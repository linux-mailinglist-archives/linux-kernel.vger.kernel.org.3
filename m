Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7358153ABFA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356337AbiFARdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346250AbiFARda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:33:30 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF86E8C3;
        Wed,  1 Jun 2022 10:33:29 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-e93bbb54f9so3586216fac.12;
        Wed, 01 Jun 2022 10:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g/q8Ry/wqbpa2LSJpp84P/0VUqJYk079x4LedOp/0TI=;
        b=Jjquta200CuvHIf3tnkZiTvzXzCxbujkUBZkDTmwQ7VD2v1mUjV/iKvJWOxWZ7jeyz
         H1/z/lwZU3UvQ+jODcDkRieaBXnzBHQyPvr+rkpthDnjkTbBcCzfz4HSsQ4SIEGX1JLk
         LwFQBL4cfnt2+M4yg2g6g8Cc4X6rNtCMY9RfCoKk8ab3UAwOAo/6jFv4L3w/h2NGmUBo
         fO3vzcaOWGAODs9mO68nMSt4K2PjFZIlzhG30jvU5WNZ0B0cSH6dGjTm1FRlHdTrwMII
         mUMcbZQzapVCbBwu1F+oGIteA3ey00CL2BW85EWDOiN8o44W/Pu8bxWgS1ifbbSCYjJ7
         FtYQ==
X-Gm-Message-State: AOAM532eSDRjnEvodOCKj7MW78Cl6IL0xRgeJpUkoIZtmlKZqK7fakvH
        Vhlk8W0Oc7o/jyGHFJGQCw==
X-Google-Smtp-Source: ABdhPJwQGOeZSoePmPAvSCimyS6zpImcovhOJ8TREaIjdgLPMYAczQBo/kuJDVlj92kGnCRTZ2SFTQ==
X-Received: by 2002:a05:6870:631a:b0:ed:7825:e9ff with SMTP id s26-20020a056870631a00b000ed7825e9ffmr17010403oao.54.1654104808291;
        Wed, 01 Jun 2022 10:33:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e21-20020a4ab995000000b0035f6cf71391sm1122267oop.43.2022.06.01.10.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 10:33:27 -0700 (PDT)
Received: (nullmailer pid 71870 invoked by uid 1000);
        Wed, 01 Jun 2022 17:33:26 -0000
Date:   Wed, 1 Jun 2022 12:33:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-phy@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        quic_ppratap@quicinc.com, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_vpulyala@quicinc.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Message-ID: <20220601173326.GA3993065-robh@kernel.org>
References: <1654066564-20518-1-git-send-email-quic_kriskura@quicinc.com>
 <1654066564-20518-2-git-send-email-quic_kriskura@quicinc.com>
 <1654086533.981346.3753217.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654086533.981346.3753217.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 07:28:53AM -0500, Rob Herring wrote:
> On Wed, 01 Jun 2022 12:26:02 +0530, Krishna Kurapati wrote:
> > From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > 
> > Add device tree bindings for SNPS phy tuning parameters.
> > 
> > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 96 ++++++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-rise-fall-time-bp: 'oneOf' conditional failed, one must be fixed:
> 	'type' is a required property
> 		hint: A vendor boolean property can use "type: boolean"
> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
> 		hint: A vendor boolean property can use "type: boolean"
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-rise-fall-time-bp: 'oneOf' conditional failed, one must be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 		hint: A vendor string property with exact values has an implicit type
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-rise-fall-time-bp: 'oneOf' conditional failed, one must be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 		hint: A vendor property needs a $ref to types.yaml
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,ls-fs-output-impedance-bp: 'oneOf' conditional failed, one must be fixed:
> 	'type' is a required property
> 		hint: A vendor boolean property can use "type: boolean"
> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
> 		hint: A vendor boolean property can use "type: boolean"
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,ls-fs-output-impedance-bp: 'oneOf' conditional failed, one must be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 		hint: A vendor string property with exact values has an implicit type
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,ls-fs-output-impedance-bp: 'oneOf' conditional failed, one must be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 		hint: A vendor property needs a $ref to types.yaml
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
> 	'type' is a required property
> 		hint: A vendor boolean property can use "type: boolean"
> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
> 		hint: A vendor boolean property can use "type: boolean"
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 		hint: A vendor string property with exact values has an implicit type
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 		hint: A vendor property needs a $ref to types.yaml
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,squelch-detector-bp: 'oneOf' conditional failed, one must be fixed:
> 	'type' is a required property
> 		hint: A vendor boolean property can use "type: boolean"
> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
> 		hint: A vendor boolean property can use "type: boolean"
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,squelch-detector-bp: 'oneOf' conditional failed, one must be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 		hint: A vendor string property with exact values has an implicit type
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,squelch-detector-bp: 'oneOf' conditional failed, one must be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 		hint: A vendor property needs a $ref to types.yaml
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-disconnect-bp: 'oneOf' conditional failed, one must be fixed:
> 	'type' is a required property
> 		hint: A vendor boolean property can use "type: boolean"
> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
> 		hint: A vendor boolean property can use "type: boolean"
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-disconnect-bp: 'oneOf' conditional failed, one must be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 		hint: A vendor string property with exact values has an implicit type
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-disconnect-bp: 'oneOf' conditional failed, one must be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 		hint: A vendor property needs a $ref to types.yaml
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
> 	'type' is a required property
> 		hint: A vendor boolean property can use "type: boolean"
> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
> 		hint: A vendor boolean property can use "type: boolean"
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 		hint: A vendor string property with exact values has an implicit type
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,hs-amplitude-bp: 'oneOf' conditional failed, one must be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 		hint: A vendor property needs a $ref to types.yaml
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-duration-bp: 'oneOf' conditional failed, one must be fixed:
> 	'type' is a required property
> 		hint: A vendor boolean property can use "type: boolean"
> 	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
> 		hint: A vendor boolean property can use "type: boolean"
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-duration-bp: 'oneOf' conditional failed, one must be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 		hint: A vendor string property with exact values has an implicit type
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: properties:qcom,pre-emphasis-duration-bp: 'oneOf' conditional failed, one must be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 		hint: A vendor property needs a $ref to types.yaml
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: ignoring, error in schema: properties: qcom,hs-rise-fall-time-bp
> Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.example.dtb:0:0: /example-0/phy@88e2000: failed to match any schema with compatible: ['qcom,sm8150-usb-hs-phy']

Ignore these. A tool issue which is now fixed.

Rob
