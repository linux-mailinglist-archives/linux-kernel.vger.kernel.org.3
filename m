Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7013B56C395
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbiGHVcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240483AbiGHVcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:32:08 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BAEA0266;
        Fri,  8 Jul 2022 14:32:08 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id h16so5603208ila.2;
        Fri, 08 Jul 2022 14:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2c8hNn/HcSsNuhk2VZkSz28XgxLYEcL3R/BmDHkTe1Y=;
        b=NJ5MpovZ0YAnHZEbkxcI73+hIPzRTbPnlDSz7Iyvc4XWI2lVURuwoBR84ItHNaYN43
         ME15zYAt+Kx8bWQFd1ooaVyp6XLVKd7cPVAVmXb0j8z3phY8AMcYJyLqnPobXIophfTC
         lqwqTfKpLu3NLF7T6Q9eaogO0jQjhEtGSbJPN9362JfBM0ILiVTRCx9fbaWxs+k2dRMs
         pSaFgkl8Ldq5Rn/WHMkJsi/4lJlYwrbeoIY0L1mZndrScK1uEOx1mKjbyJLZk4WtBwnW
         c3XBllnA4MbDv31U9kclGf9EVCV/yhggF20zb3Bdq16FUMx0OkSr8Yy6JM2IfxUHGEwu
         bVCQ==
X-Gm-Message-State: AJIora8PxFmLLjNPkshyFF2crCVis2TrC3DyO0x+3PsW3kWNN2G5Vi2z
        IqBapw1pU/48I5el9VnXZw==
X-Google-Smtp-Source: AGRyM1vPbXrieqMHwm2ebeU3CsWBQ7/Skb1GSUm9tzvGAV+/lPgBdXG9me75jXQNeSTpNLyUbB8o8Q==
X-Received: by 2002:a92:6c05:0:b0:2da:b9e8:24df with SMTP id h5-20020a926c05000000b002dab9e824dfmr3316030ilc.99.1657315927467;
        Fri, 08 Jul 2022 14:32:07 -0700 (PDT)
Received: from robh.at.kernel.org ([98.38.210.73])
        by smtp.gmail.com with ESMTPSA id a17-20020a027a11000000b0033f2f249a69sm1086501jac.129.2022.07.08.14.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:32:07 -0700 (PDT)
Received: (nullmailer pid 1508206 invoked by uid 1000);
        Fri, 08 Jul 2022 21:32:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        vigneshr@ti.com, davem@davemloft.net, robh+dt@kernel.org,
        herbert@gondor.apana.org.au, j-keerthy@ti.com
In-Reply-To: <20220707110756.16169-1-j-choudhary@ti.com>
References: <20220707110756.16169-1-j-choudhary@ti.com>
Subject: Re: [PATCH] dt-bindings: crypto: ti,sa2ul: drop dma-coherent property
Date:   Fri, 08 Jul 2022 15:32:02 -0600
Message-Id: <1657315922.470955.1508205.nullmailer@robh.at.kernel.org>
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

On Thu, 07 Jul 2022 16:37:56 +0530, Jayesh Choudhary wrote:
> crypto driver itself is not dma-coherent. It is the dmaengine
> that moves data and the buffers are to be mapped to the
> dmaengine provider. So this property should be dropped.
> 
> Fixes: 2ce9a7299bf6 ('dt-bindings: crypto: Add TI SA2UL crypto accelerator documentation')
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  .../devicetree/bindings/crypto/ti,sa2ul.yaml        | 13 -------------
>  1 file changed, 13 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


crypto@4e00000: 'dma-coherent' does not match any of the regexes: '^rng@[a-f0-9]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dtb
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dtb
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dtb
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dtb
	arch/arm64/boot/dts/ti/k3-am654-base-board.dtb
	arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb
	arch/arm64/boot/dts/ti/k3-j721e-sk.dtb

