Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C909853AC11
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356392AbiFARhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352260AbiFARhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:37:03 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F01379398;
        Wed,  1 Jun 2022 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654105021; x=1685641021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=obRWwBxWo5wxourlKoQ+72J1NaWg/JXxo6pkl6dj4kI=;
  b=MOx8f2WOSgtigH9pnOj1Q7m6MQogIAKGb0vD+fcGNL17fdcmp4L5r9bf
   vTXtlo1dcuMASEAzxZzqRSygSPhEO+K2fj5nLDcIm6p5H86JIfQWbV56q
   UITnufkvUZdODPbHLk5nUOaqGqCKKao+8Wy7QoW7P5MSXZhqTB71ah+FE
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Jun 2022 10:37:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 10:37:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 10:36:59 -0700
Received: from [10.216.18.22] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 1 Jun 2022
 10:36:53 -0700
Message-ID: <5d3797bd-915f-2746-b593-1b8a3f792c5d@quicinc.com>
Date:   Wed, 1 Jun 2022 23:06:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Anderson <dianders@chromium.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        <linux-phy@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        <quic_ppratap@quicinc.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_vpulyala@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
References: <1654066564-20518-1-git-send-email-quic_kriskura@quicinc.com>
 <1654066564-20518-2-git-send-email-quic_kriskura@quicinc.com>
 <1654086533.981346.3753217.nullmailer@robh.at.kernel.org>
 <20220601173326.GA3993065-robh@kernel.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20220601173326.GA3993065-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob !


On 6/1/2022 11:03 PM, Rob Herring wrote:
> On Wed, Jun 01, 2022 at 07:28:53AM -0500, Rob Herring wrote:
>> On Wed, 01 Jun 2022 12:26:02 +0530, Krishna Kurapati wrote:
>>> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>>
>>> Add device tree bindings for SNPS phy tuning parameters.
>>>
>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>   .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 96 ++++++++++++++++++++++
>>>   1 file changed, 96 insertions(+)
>>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-rise-fall-time-bp: 'oneOf' conditional failed, one must be fixed:
>> 	'type' is a required property
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-rise-fall-time-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'enum' is a required property
>> 		'const' is a required property
>> 		hint: A vendor string property with exact values has an implicit type
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-rise-fall-time-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'$ref' is a required property
>> 		'allOf' is a required property
>> 		hint: A vendor property needs a $ref to types.yaml
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
>> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,ls-fs-output-impedance-bp: 'oneOf' conditional failed, one must be fixed:
>> 	'type' is a required property
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,ls-fs-output-impedance-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'enum' is a required property
>> 		'const' is a required property
>> 		hint: A vendor string property with exact values has an implicit type
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,ls-fs-output-impedance-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'$ref' is a required property
>> 		'allOf' is a required property
>> 		hint: A vendor property needs a $ref to types.yaml
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
>> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
>> 	'type' is a required property
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'enum' is a required property
>> 		'const' is a required property
>> 		hint: A vendor string property with exact values has an implicit type
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'$ref' is a required property
>> 		'allOf' is a required property
>> 		hint: A vendor property needs a $ref to types.yaml
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
>> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,squelch-detector-bp: 'oneOf' conditional failed, one must be fixed:
>> 	'type' is a required property
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,squelch-detector-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'enum' is a required property
>> 		'const' is a required property
>> 		hint: A vendor string property with exact values has an implicit type
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,squelch-detector-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'$ref' is a required property
>> 		'allOf' is a required property
>> 		hint: A vendor property needs a $ref to types.yaml
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
>> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-disconnect-bp: 'oneOf' conditional failed, one must be fixed:
>> 	'type' is a required property
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-disconnect-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'enum' is a required property
>> 		'const' is a required property
>> 		hint: A vendor string property with exact values has an implicit type
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-disconnect-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'$ref' is a required property
>> 		'allOf' is a required property
>> 		hint: A vendor property needs a $ref to types.yaml
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
>> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
>> 	'type' is a required property
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'enum' is a required property
>> 		'const' is a required property
>> 		hint: A vendor string property with exact values has an implicit type
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'$ref' is a required property
>> 		'allOf' is a required property
>> 		hint: A vendor property needs a $ref to types.yaml
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
>> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-duration-bp: 'oneOf' conditional failed, one must be fixed:
>> 	'type' is a required property
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
>> 		hint: A vendor boolean property can use "type: boolean"
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-duration-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'enum' is a required property
>> 		'const' is a required property
>> 		hint: A vendor string property with exact values has an implicit type
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-duration-bp: 'oneOf' conditional failed, one must be fixed:
>> 		'$ref' is a required property
>> 		'allOf' is a required property
>> 		hint: A vendor property needs a $ref to types.yaml
>> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
>> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: ignoring, error in schema: properties: qcom,hs-rise-fall-time-bp
>> Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.example.dtb:0:0: /example-0/phy@88e2000: failed to match any schema with compatible: ['qcom,sm8150-usb-hs-phy']
> Ignore these. A tool issue which is now fixed.
>
> Rob
