Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4071511ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiD0OVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbiD0OVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:21:43 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594966A01C;
        Wed, 27 Apr 2022 07:18:31 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e922e68b0fso2094529fac.1;
        Wed, 27 Apr 2022 07:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=PMYFToIIw9gCyKckeLz6QNSj28pYwPtqHEMymIKkXRA=;
        b=oT7wLDmeGNjUm9hVucJWKuIN53Af8Rj7+Gl67IkO8oyR9y15Dpsv98niuvtzA+nFeu
         Ip3d3QJYcYsEA0nL1NKv/vmv+xHpgsZhI+c0S6vXIJkvK/8pFVNJX2TMjc1j/nOhAlXr
         k7BhG29R/ahv8R/qwR3OYbUR8aES5A5QitGa4uCRDXPL5UizxZo64cHhth7pqyItfFnN
         s9KGwznKIF41y/waT3XsOf0khF8oL9/TkFDtz2AK2rKrKhayo5uB7tmgeIR2/0/KQtN9
         G/at2kstoJ+ZtXbwZS/g2A1ZHmWQHiXilxQxbGk1TAxfcZS2Ofo0FMeIPALObgsizy+Q
         DSKg==
X-Gm-Message-State: AOAM533ejB1M6N4kuxEj9EaU4q7JCv+sGa/jtC4ux3UzAn0wYDS1Y5JK
        SNx//BAgXohunCIQ+TCgRSRP1+uJug==
X-Google-Smtp-Source: ABdhPJyS08rrT9jgCgkOe3uGHzv/NwWEfTH0q/IX+PLWPJjo6NzGWHPEYfF02mq/cITg/8Jmteod+w==
X-Received: by 2002:a05:6870:6307:b0:e9:6ed6:cb2f with SMTP id s7-20020a056870630700b000e96ed6cb2fmr2954367oao.26.1651069110640;
        Wed, 27 Apr 2022 07:18:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h21-20020a9d6015000000b006025edf7cafsm6020169otj.22.2022.04.27.07.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:18:30 -0700 (PDT)
Received: (nullmailer pid 4142587 invoked by uid 1000);
        Wed, 27 Apr 2022 14:18:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427075338.1156449-5-michael@walle.cc>
References: <20220427075338.1156449-1-michael@walle.cc> <20220427075338.1156449-5-michael@walle.cc>
Subject: Re: [PATCH v3 4/4] dt-bindings: fsl: convert fsl,layerscape-scfg to YAML
Date:   Wed, 27 Apr 2022 09:18:28 -0500
Message-Id: <1651069108.159837.4142586.nullmailer@robh.at.kernel.org>
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

On Wed, 27 Apr 2022 09:53:38 +0200, Michael Walle wrote:
> Convert the fsl,layerscape-scfg binding to the new YAML format.
> 
> In the device trees, the device node always have a "syscon"
> compatible, which wasn't mentioned in the previous binding.
> 
> Also added, compared to the original binding, is the
> interrupt-controller subnode as used in arch/arm/boot/dts/ls1021a.dtsi
> as well as the litte-endian and big-endian properties.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> changes since v2:
>  - none
> 
> changes since v1:
>  - moved to soc/fsl/fsl,layerscape-scfg.yaml
>  - generic name for node in example
>  - mention added "syscon" compatible in commit message
>  - reference specific interrupt controller
> 
>  .../arm/freescale/fsl,layerscape-scfg.txt     | 19 ------
>  .../bindings/soc/fsl/fsl,layerscape-scfg.yaml | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


scfg@1570000: interrupt-controller@1ac:interrupt-map-mask:0:0: 15 was expected
	arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb

scfg@1570000: interrupt-controller@1ac:interrupt-map-mask:0:0: 7 was expected
	arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dtb
	arch/arm/boot/dts/ls1021a-qds.dtb
	arch/arm/boot/dts/ls1021a-tsn.dtb
	arch/arm/boot/dts/ls1021a-twr.dtb

