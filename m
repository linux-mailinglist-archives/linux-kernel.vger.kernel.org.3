Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6F3542C44
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiFHJ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbiFHJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:58:25 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2806B630D;
        Wed,  8 Jun 2022 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654680670; x=1686216670;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=AnYHjZy/FvZbWBNBcv5n8j2WBcm4XS/zrNABP+VAJ/g=;
  b=SkGWWL7QMPyuh5g+MJ4GbT9fX/ZV2Ejdg7BCBSB+KfT3uZvuzWpw0mIb
   IsugoRqoSmaWfHOpjZUGrzg+hQ7MQLDqgyr0y0g/3q8fNxL9zo+6jknqE
   FIhVcxYFMWqDKPgGquPa8NBhMi0Fhb7JJ8bnLACaPNc9HcZQ8UuLDcb3o
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Jun 2022 02:31:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:31:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 8 Jun 2022 02:31:07 -0700
Received: from [10.216.33.38] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 8 Jun 2022
 02:31:00 -0700
Message-ID: <8eeae82b-1021-97e3-64c5-e2bdbdfb1f8a@quicinc.com>
Date:   Wed, 8 Jun 2022 15:00:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay Abraham" <kishon@ti.com>
CC:     Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Anderson <dianders@chromium.org>,
        "Stephen Boyd" <swboyd@chromium.org>,
        <linux-phy@lists.infradead.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        <quic_ppratap@quicinc.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_vpulyala@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
References: <1654066564-20518-1-git-send-email-quic_kriskura@quicinc.com>
 <1654066564-20518-2-git-send-email-quic_kriskura@quicinc.com>
 <1654086533.981346.3753217.nullmailer@robh.at.kernel.org>
 <20220601173326.GA3993065-robh@kernel.org>
 <5d3797bd-915f-2746-b593-1b8a3f792c5d@quicinc.com>
In-Reply-To: <5d3797bd-915f-2746-b593-1b8a3f792c5d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn, Krzysztof, Vinod, Kishon,


   Can you please help provide your inputs/review on this patch series.


Regards,

Krishna,


On 6/1/2022 11:06 PM, Krishna Kurapati PSSNV wrote:
> Thanks Rob !
>
>
> On 6/1/2022 11:03 PM, Rob Herring wrote:
>> On Wed, Jun 01, 2022 at 07:28:53AM -0500, Rob Herring wrote:
>>> On Wed, 01 Jun 2022 12:26:02 +0530, Krishna Kurapati wrote:
>>>> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>>>
>>>> Add device tree bindings for SNPS phy tuning parameters.
>>>>
>>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>   .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 96 
>>>> ++++++++++++++++++++++
>>>>   1 file changed, 96 insertions(+)
>>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,hs-rise-fall-time-bp: 'oneOf' conditional failed, 
>>> one must be fixed:
>>>     'type' is a required property
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     Additional properties are not allowed ('maximum', 'minimum' were 
>>> unexpected)
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,hs-rise-fall-time-bp: 'oneOf' conditional failed, 
>>> one must be fixed:
>>>         'enum' is a required property
>>>         'const' is a required property
>>>         hint: A vendor string property with exact values has an 
>>> implicit type
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,hs-rise-fall-time-bp: 'oneOf' conditional failed, 
>>> one must be fixed:
>>>         '$ref' is a required property
>>>         'allOf' is a required property
>>>         hint: A vendor property needs a $ref to types.yaml
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     hint: Vendor specific properties must have a type and 
>>> description unless they have a defined, common suffix.
>>>     from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,ls-fs-output-impedance-bp: 'oneOf' conditional 
>>> failed, one must be fixed:
>>>     'type' is a required property
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     Additional properties are not allowed ('maximum', 'minimum' were 
>>> unexpected)
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,ls-fs-output-impedance-bp: 'oneOf' conditional 
>>> failed, one must be fixed:
>>>         'enum' is a required property
>>>         'const' is a required property
>>>         hint: A vendor string property with exact values has an 
>>> implicit type
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,ls-fs-output-impedance-bp: 'oneOf' conditional 
>>> failed, one must be fixed:
>>>         '$ref' is a required property
>>>         'allOf' is a required property
>>>         hint: A vendor property needs a $ref to types.yaml
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     hint: Vendor specific properties must have a type and 
>>> description unless they have a defined, common suffix.
>>>     from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,pre-emphasis-amplitude-bp: 'oneOf' conditional 
>>> failed, one must be fixed:
>>>     'type' is a required property
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     Additional properties are not allowed ('maximum', 'minimum' were 
>>> unexpected)
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,pre-emphasis-amplitude-bp: 'oneOf' conditional 
>>> failed, one must be fixed:
>>>         'enum' is a required property
>>>         'const' is a required property
>>>         hint: A vendor string property with exact values has an 
>>> implicit type
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,pre-emphasis-amplitude-bp: 'oneOf' conditional 
>>> failed, one must be fixed:
>>>         '$ref' is a required property
>>>         'allOf' is a required property
>>>         hint: A vendor property needs a $ref to types.yaml
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     hint: Vendor specific properties must have a type and 
>>> description unless they have a defined, common suffix.
>>>     from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,squelch-detector-bp: 'oneOf' conditional failed, one 
>>> must be fixed:
>>>     'type' is a required property
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     Additional properties are not allowed ('maximum', 'minimum' were 
>>> unexpected)
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,squelch-detector-bp: 'oneOf' conditional failed, one 
>>> must be fixed:
>>>         'enum' is a required property
>>>         'const' is a required property
>>>         hint: A vendor string property with exact values has an 
>>> implicit type
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,squelch-detector-bp: 'oneOf' conditional failed, one 
>>> must be fixed:
>>>         '$ref' is a required property
>>>         'allOf' is a required property
>>>         hint: A vendor property needs a $ref to types.yaml
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     hint: Vendor specific properties must have a type and 
>>> description unless they have a defined, common suffix.
>>>     from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,hs-disconnect-bp: 'oneOf' conditional failed, one 
>>> must be fixed:
>>>     'type' is a required property
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     Additional properties are not allowed ('maximum', 'minimum' were 
>>> unexpected)
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,hs-disconnect-bp: 'oneOf' conditional failed, one 
>>> must be fixed:
>>>         'enum' is a required property
>>>         'const' is a required property
>>>         hint: A vendor string property with exact values has an 
>>> implicit type
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,hs-disconnect-bp: 'oneOf' conditional failed, one 
>>> must be fixed:
>>>         '$ref' is a required property
>>>         'allOf' is a required property
>>>         hint: A vendor property needs a $ref to types.yaml
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     hint: Vendor specific properties must have a type and 
>>> description unless they have a defined, common suffix.
>>>     from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,hs-amplitude-bp: 'oneOf' conditional failed, one 
>>> must be fixed:
>>>     'type' is a required property
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     Additional properties are not allowed ('maximum', 'minimum' were 
>>> unexpected)
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,hs-amplitude-bp: 'oneOf' conditional failed, one 
>>> must be fixed:
>>>         'enum' is a required property
>>>         'const' is a required property
>>>         hint: A vendor string property with exact values has an 
>>> implicit type
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,hs-amplitude-bp: 'oneOf' conditional failed, one 
>>> must be fixed:
>>>         '$ref' is a required property
>>>         'allOf' is a required property
>>>         hint: A vendor property needs a $ref to types.yaml
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     hint: Vendor specific properties must have a type and 
>>> description unless they have a defined, common suffix.
>>>     from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,pre-emphasis-duration-bp: 'oneOf' conditional 
>>> failed, one must be fixed:
>>>     'type' is a required property
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     Additional properties are not allowed ('maximum', 'minimum' were 
>>> unexpected)
>>>         hint: A vendor boolean property can use "type: boolean"
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,pre-emphasis-duration-bp: 'oneOf' conditional 
>>> failed, one must be fixed:
>>>         'enum' is a required property
>>>         'const' is a required property
>>>         hint: A vendor string property with exact values has an 
>>> implicit type
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> properties:qcom,pre-emphasis-duration-bp: 'oneOf' conditional 
>>> failed, one must be fixed:
>>>         '$ref' is a required property
>>>         'allOf' is a required property
>>>         hint: A vendor property needs a $ref to types.yaml
>>>         from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>     hint: Vendor specific properties must have a type and 
>>> description unless they have a defined, common suffix.
>>>     from schema $id: 
>>> http://devicetree.org/meta-schemas/vendor-props.yaml#
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: 
>>> ignoring, error in schema: properties: qcom,hs-rise-fall-time-bp
>>> Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.example.dtb:0:0: 
>>> /example-0/phy@88e2000: failed to match any schema with compatible: 
>>> ['qcom,sm8150-usb-hs-phy']
>> Ignore these. A tool issue which is now fixed.
>>
>> Rob
