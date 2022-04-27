Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31CC511B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiD0OVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiD0OVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:21:41 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194C76A002;
        Wed, 27 Apr 2022 07:18:30 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-e5e433d66dso2073800fac.5;
        Wed, 27 Apr 2022 07:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=PhXcDgK09TfJ0k4/TcfwOYlktcKSTjsxAO+dgwid8sU=;
        b=2xOQh1XR7ym3OsES4idwVUbm/DSVPrsxVdgT0UpOOAb1dEfdsZZU2d3l3yTqksSKPy
         Y4pESMLMBKnrNC/GGg7inPIsbtNdfr6E1LvMlF2g1J21IZdSIP4pavCyYwEyXMVCfvv2
         ez+n4FXX1bKijJ9Q4nunRP3EcTTuHpYV8A5R/WrAp9D+vFuHk+ufsciWeg1Rz7Wuir6Q
         zoFjbhF5rSTaXfgyO+38mLa8ww4KpHDDolMmvmJ/YAYXMxRpTIpX5agxrVdAWxYWzbB8
         4Z/6ottxix+1Z/XryFLYy9z/SU6JY1V0b7xEQm6AkOImg9aZvchM6R49UIpfPVcByOAC
         SLEg==
X-Gm-Message-State: AOAM531lx7ZVuA/YFWgzxEHS/PhBhKB6W33hzGKD0bsXvaFJguF12p7F
        SaEfjNcJaeiUhIeRjsXtO87Rk0Im8w==
X-Google-Smtp-Source: ABdhPJzEazdYi+wBumpNxD6+bRTRjB1cnfTbRe3mJ/iYA6rFI8tXYvlUpz6mMwksoa3oLiTqbPubyQ==
X-Received: by 2002:a05:6870:ea8d:b0:e6:135c:1a2e with SMTP id s13-20020a056870ea8d00b000e6135c1a2emr15718470oap.9.1651069109351;
        Wed, 27 Apr 2022 07:18:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b14-20020a056870160e00b000e915a9121csm672499oae.52.2022.04.27.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:18:28 -0700 (PDT)
Received: (nullmailer pid 4142584 invoked by uid 1000);
        Wed, 27 Apr 2022 14:18:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220427010154.29749-2-zev@bewilderbeest.net>
References: <20220427010154.29749-1-zev@bewilderbeest.net> <20220427010154.29749-2-zev@bewilderbeest.net>
Subject: Re: [PATCH v4 1/7] dt-bindings: hwmon: Add nuvoton,nct6775
Date:   Wed, 27 Apr 2022 09:18:28 -0500
Message-Id: <1651069108.145838.4142583.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 18:01:48 -0700, Zev Weiss wrote:
> These Super I/O chips have an i2c interface that some systems expose
> to a BMC; the BMC's device tree can now describe that via this
> binding.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../bindings/hwmon/nuvoton,nct6775.yaml       | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml: properties:nuvoton,tsi-channel-mask: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'maximum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml: properties:nuvoton,tsi-channel-mask: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml: properties:nuvoton,tsi-channel-mask: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml: ignoring, error in schema: properties: nuvoton,tsi-channel-mask
Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.example.dtb:0:0: /example-0/i2c/superio@4d: failed to match any schema with compatible: ['nuvoton,nct6779']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

