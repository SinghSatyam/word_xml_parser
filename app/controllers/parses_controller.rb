class ParsesController < ApplicationController

  def parse
    doc = get_parsed_document_using_nokogiri("2.xml")
    wordDocument = doc.xpath("//w:wordDocument",'w'=>'http://schemas.microsoft.com/office/word/2003/wordml')
    body = wordDocument.xpath("//w:body",'w'=>'http://schemas.microsoft.com/office/word/2003/wordml')

    styles = {}
    body.xpath('//w:p//w:pPr//w:pStyle','w'=>'http://schemas.microsoft.com/office/word/2003/wordml').each do |obj,index|
      style = obj.attributes['val'].value
      styles[style] = [] unless styles[style].present?
      grandparent(obj).children.each do |child|
        child.children.each do |chichi|
          styles[style].push(chichi.text) if chichi.name=="t"
        end
      end
    end
    render :xml => styles.to_xml(skip_types: true,root: 'Document')
  end



  #def create
  #  @parse = Parse.new(parse_params)
  #
  #  respond_to do |format|
  #    if @parse.save
  #      format.html { redirect_to @parse, notice: 'Parse was successfully created.' }
  #      format.json { render :show, status: :created, location: @parse }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @parse.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parse
      @parse = Parse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parse_params
      params[:parse]
    end

  def grandparent(obj)
    obj.parent.parent
  end

  def get_value_from_styles_hash(complete_styles_hash,style_name)
    complete_styles_hash[style_name]
  end

  def get_parsed_document_using_nokogiri(file)
    Nokogiri::XML::Document.parse(File.open(file))
  end
end
