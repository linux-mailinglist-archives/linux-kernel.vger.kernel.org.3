Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A555045A2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 00:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiDPWUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 18:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiDPWUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 18:20:16 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AAFE6D;
        Sat, 16 Apr 2022 15:17:42 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id e189so11468098oia.8;
        Sat, 16 Apr 2022 15:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2JYEwuCKMkvFE9bkQV/NNaX/hW3Szh4RVLF5Mm1ed8o=;
        b=JMx9HJ8PlHQPOhEcS9PA8v0NvunUlW5ULvN661rOCk9hozxIKIRuSH7T8sVgip5WiE
         dZF9BXrQD5+YhMdITMQEnmEMjnJhtSotKBknR6a9UgLSdSJcJbF93uyhBMvknqjoHKyL
         GL8kz12fgNcHgb5c0oLZ7/MpqStytcgc+VipHgjiXGxYbObKL/83o9U1XRhuPVc/kYcJ
         yu54AGu6p4yFXVTGbjnqlAC8gK63yWELf06vbWkraqbLt+Fnsh/h6+TyWSs1H5nSSZVD
         VKtkjMLYs7qiz8YOsNy6+w3NfWVNaFQjt2GmC3Uo5NZb11oocYt6v5SfzBrWbPMsWWUn
         S4Uw==
X-Gm-Message-State: AOAM530LcCXxXY0mHSOIEh+vKuT+TSQJjJgCP9UuoaGtlDUhuXkwAOXa
        SdevIK7CndqVMiLO7zgyVg==
X-Google-Smtp-Source: ABdhPJz4+/8mYxiNK3mwYOHKuPzb6694BbLOqA73ZnWVlKMwCgLmz169CflDFMxVO4+zStw4dfiEKw==
X-Received: by 2002:a05:6808:13d0:b0:2fa:72dc:6159 with SMTP id d16-20020a05680813d000b002fa72dc6159mr2248703oiw.224.1650147461895;
        Sat, 16 Apr 2022 15:17:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o7-20020a056871078700b000e29ff467dcsm2875635oap.50.2022.04.16.15.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 15:17:41 -0700 (PDT)
Received: (nullmailer pid 3544949 invoked by uid 1000);
        Sat, 16 Apr 2022 22:17:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ryan Lee <ryan.lee.analog@gmail.com>
Cc:     krzk+dt@kernel.org, pbrobinson@gmail.com,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        lukas.bulwahn@gmail.com, devicetree@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com,
        srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org,
        tanureal@opensource.cirrus.com, broonie@kernel.org, tiwai@suse.com,
        cy_huang@richtek.com, stephan@gerhold.net, arnd@arndb.de,
        robh+dt@kernel.org, hdegoede@redhat.com, perex@perex.cz,
        drhodes@opensource.cirrus.com, ryans.lee@analog.com,
        lgirdwood@gmail.com
In-Reply-To: <20220416004024.210418-1-ryan.lee.analog@gmail.com>
References: <20220416004024.210418-1-ryan.lee.analog@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: max98396: add amplifier driver
Date:   Sat, 16 Apr 2022 17:17:39 -0500
Message-Id: <1650147459.157752.3544948.nullmailer@robh.at.kernel.org>
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

On Fri, 15 Apr 2022 17:40:23 -0700, Ryan Lee wrote:
> From: Ryan Lee <ryans.lee@analog.com>
> 
> This patch adds dt-bindings information for Analog Devices MAX98396
> and MAX98397 Smart Amplifier.
> 
> Signed-off-by: Ryan Lee <ryans.lee@analog.com>
> ---
>  .../bindings/sound/adi,max98396.yaml          | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,max98396.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/adi,max98396.yaml:49:111: [warning] line too long (121 > 110 characters) (line-length)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,max98396.yaml: properties:adi,spkfb-slot-no: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maximum', 'default', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,max98396.yaml: properties:adi,spkfb-slot-no: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,max98396.yaml: properties:adi,spkfb-slot-no: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,max98396.yaml: properties:adi,interleave-mode: 'oneOf' conditional failed, one must be fixed:
	Additional properties are not allowed ('default' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,max98396.yaml: properties:adi,interleave-mode: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	Additional properties are not allowed ('type', 'default' were unexpected)
		hint: A vendor string property with exact values has an implicit type
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,max98396.yaml: properties:adi,interleave-mode: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,max98396.yaml: properties:adi,vmon-slot-no: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maximum', 'default', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,max98396.yaml: properties:adi,vmon-slot-no: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,max98396.yaml: properties:adi,vmon-slot-no: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,max98396.yaml: properties:adi,imon-slot-no: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maximum', 'default', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,max98396.yaml: properties:adi,imon-slot-no: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,max98396.yaml: properties:adi,imon-slot-no: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,max98396.yaml: ignoring, error in schema: properties: adi,spkfb-slot-no
Documentation/devicetree/bindings/sound/adi,max98396.example.dtb:0:0: /example-0/i2c/amplifier@39: failed to match any schema with compatible: ['adi,max98396']
Documentation/devicetree/bindings/sound/adi,max98396.example.dtb:0:0: /example-0/i2c/amplifier@3c: failed to match any schema with compatible: ['adi,max98397']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

