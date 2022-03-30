Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664294EC5FC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346430AbiC3Nxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346524AbiC3Nwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:52:49 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023041480EE;
        Wed, 30 Mar 2022 06:51:02 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id o20-20020a9d7194000000b005cb20cf4f1bso14932231otj.7;
        Wed, 30 Mar 2022 06:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=yHeRiX2bMIx0KbaFEt4HL/mkVxSbe1mp5NhZsTk9FpE=;
        b=Q3FXTEzQyPmhEjt51ScacM0FKbrL4G6wU2jaHCxMEZe9YK5h75AJTYyFWjQ6LUClQP
         rUmZFpda415/YHC1kRzbO0TIE09FXTWIYtQY72nvCzxtG4tE2lhwlV1YPU6oh7sNCIgG
         ZKfFShxJgbWVKMwLPP288DoEX5hNX7ZwQ7yhkdFngKQdzq41aRhcpz2EK5LmdwVl/v76
         UayWFeFtm7nm/mXPkYm+p1MNwGevbrH0HFYh2pGBXRmG9ceJmpT1NUca19JI8EDcXXK4
         gDeV7zcqEgUYxG1EMSNbkpuh37OnypfGt6Jk/pDgEe/kE+q/2H+6c/TTyzF8Ekez0d3m
         bBCQ==
X-Gm-Message-State: AOAM531dvqybcrePm8E7RlOA6pAYq3BomI45TstNwTARviCHk7XUV/QR
        BGx6ZvuMiuDWu0KJAwR5Fk72pcyF5g==
X-Google-Smtp-Source: ABdhPJwJb0gAhNOGxyZyBT1Dysx5h/4ZV6i7rhvJehmKsif+DWOSg8rCnMl2C12b8kUdLQ2IDJ+PZg==
X-Received: by 2002:a05:6830:812:b0:5af:6b1b:537f with SMTP id r18-20020a056830081200b005af6b1b537fmr3187780ots.194.1648648261611;
        Wed, 30 Mar 2022 06:51:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870e50300b000d9be6436f1sm9562024oag.29.2022.03.30.06.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:51:00 -0700 (PDT)
Received: (nullmailer pid 2932724 invoked by uid 1000);
        Wed, 30 Mar 2022 13:50:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     devicetree@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Robin van der Gracht <robin@protonic.nl>
In-Reply-To: <20220330073440.3986724-3-david@protonic.nl>
References: <20220330073440.3986724-1-david@protonic.nl> <20220330073440.3986724-3-david@protonic.nl>
Subject: Re: [PATCH 2/2] dt-bindings: auxdisplay: holtek,ht16k33.yaml: Add holtek,refuse-primary-fb
Date:   Wed, 30 Mar 2022 08:50:59 -0500
Message-Id: <1648648259.965681.2932723.nullmailer@robh.at.kernel.org>
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

On Wed, 30 Mar 2022 09:34:40 +0200, David Jander wrote:
> Document the DT property that will cause the holtek auxdisplay driver to
> back off if it detects that it is the first driver to probe a framebuffer
> device.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  .../devicetree/bindings/auxdisplay/holtek,ht16k33.yaml         | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml: properties:holtek,refuse-primary-fb: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml: properties:holtek,refuse-primary-fb: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml: properties:holtek,refuse-primary-fb: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml: ignoring, error in schema: properties: holtek,refuse-primary-fb
Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.example.dt.yaml:0:0: /example-0/i2c1/ht16k33@70: failed to match any schema with compatible: ['holtek,ht16k33']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1610969

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

