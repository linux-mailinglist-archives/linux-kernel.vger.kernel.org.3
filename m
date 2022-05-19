Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9135052D38A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbiESNFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbiESNFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:05:49 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B21197;
        Thu, 19 May 2022 06:05:42 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id l16so6377222oil.6;
        Thu, 19 May 2022 06:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=tFD9Ep9d5N4cqpkHCZF36LTDzwqxsTVwinwUztF4sXc=;
        b=jM5dkw2GOIUoN8ygIDFc6wBj+Cr820/aR/is288d1bgw65sDCkPQyuIrXoWgcphTXT
         XNXweuDO8giM4FcaBHno0dG/LYNupp9+o+r3rPYf/J/Xrzgy6ZN9HBw1roMFt45B2ZXd
         OOdHC2NgYcnZoy+dTbk/EOMOynFw6RTjeSvQPjoXcH6uLMMwPmEn2UOnOMIwnyAq4Z9b
         KuDY50t9unizOt1f1V0KgHoD0S5XcHK09/3DuK3crt5l0MbAQvwZwzEnNTENc9nXrQ06
         SB3W4hxaZOaJHtVPJv04LOm8itDftn3ig3iPajvTy7vv0uxwf2VnKqGx8NRhADcFwLPg
         DsRg==
X-Gm-Message-State: AOAM531c2CsrzGgAiK4GMQJWGOGZZt7coS1iFs7njN2TxydBP3F3K6Pw
        EvcvqlW0PnyvL5rbmigFioFLgVuHUQ==
X-Google-Smtp-Source: ABdhPJwQtnG93BKLCktwo6FewQ5JfQHelZVqP6QatjA/FeeoFl5DGAAXs7FkP7P8AAiLI7CyLm1AcQ==
X-Received: by 2002:aca:bc57:0:b0:326:b2b6:2548 with SMTP id m84-20020acabc57000000b00326b2b62548mr2458741oif.226.1652965541810;
        Thu, 19 May 2022 06:05:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o204-20020aca5ad5000000b00325cda1ff93sm1831257oib.18.2022.05.19.06.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:05:41 -0700 (PDT)
Received: (nullmailer pid 1359562 invoked by uid 1000);
        Thu, 19 May 2022 13:05:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-phy@lists.infradead.org, quic_pkondeti@quicinc.com,
        devicetree@vger.kernel.org,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>, quic_ppratap@quicinc.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        quic_vpulyala@quicinc.com
In-Reply-To: <1652934489-23386-2-git-send-email-quic_kriskura@quicinc.com>
References: <1652934489-23386-1-git-send-email-quic_kriskura@quicinc.com> <1652934489-23386-2-git-send-email-quic_kriskura@quicinc.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy override params bindings
Date:   Thu, 19 May 2022 08:05:39 -0500
Message-Id: <1652965539.923055.1359561.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 09:58:07 +0530, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
> Add device tree bindings for SNPS phy tuning parameters.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-rise-fall-time-bp: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-rise-fall-time-bp: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-rise-fall-time-bp: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,ls-fs-output-impedance-bp: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,ls-fs-output-impedance-bp: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,ls-fs-output-impedance-bp: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-disconnect-bp: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-disconnect-bp: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-disconnect-bp: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,squelch-detector-bp: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,squelch-detector-bp: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,squelch-detector-bp: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-duration-bp: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-duration-bp: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-duration-bp: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: ignoring, error in schema: properties: qcom,ls-fs-output-impedance-bp
Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.example.dtb:0:0: /example-0/phy@88e2000: failed to match any schema with compatible: ['qcom,sm8150-usb-hs-phy']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

