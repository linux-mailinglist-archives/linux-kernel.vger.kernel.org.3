Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4104E7DAB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiCYToc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiCYTnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:43:19 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408143E983D;
        Fri, 25 Mar 2022 12:17:03 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-dacc470e03so9036016fac.5;
        Fri, 25 Mar 2022 12:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=TD21QR0lMMXUO0nMDIjOEtGgypHb96HYAdoM26wDIGs=;
        b=Kawmhyol/R7LaoFp/f4ylvTPV4fSXjgAM8+vi/6h2/Qe9TTxRs7JIskH2WahJPQOBB
         SJThg9Iz8uSpArJ1cIR+wOSvDuhiGXWSOXh4VsEIdnDklfDPxz4fFz6uvACXpofPcIeH
         NmvI3xYkBo6u6rGmSWlpJ5GVIL6HMLCOpbdenOXDNiGjazFG9Zf4eHfwtTjMmzHuGAKu
         F4/Srdj6JWVSO0lrzWcimlS3UQcX5z3D8O+ZxIi/APyHh7JaKBKW9K2cj9E3a/uV7osc
         k1mfTFNy5MKgxM7uuWjqCc3MHrllFgXPih4pYow8yZJDC40DsHJ0hqYGyQOY+1u8pysQ
         adgA==
X-Gm-Message-State: AOAM5338MAkNLlTofiN94UdNWJkwFssMxCYishZfQOYNf828+2lmkeHc
        qiAi/JAzxPGWxZ0VSxvV0Dtl9AM84Q==
X-Google-Smtp-Source: ABdhPJxRhOXEGGu66qd3lltmMOUhaUE/Q4GESm8rEHbUQJkl8rylAaxB9T48w92FhlgVax8cPtc3MA==
X-Received: by 2002:a54:480b:0:b0:2ef:8e00:155b with SMTP id j11-20020a54480b000000b002ef8e00155bmr7912769oij.164.1648233804356;
        Fri, 25 Mar 2022 11:43:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k4-20020a9d4b84000000b005b2310ebdffsm3052644otf.54.2022.03.25.11.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:43:23 -0700 (PDT)
Received: (nullmailer pid 210218 invoked by uid 1000);
        Fri, 25 Mar 2022 18:43:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, jitao.shi@mediatek.com, mripard@kernel.org,
        matthias.bgg@gmail.com, kishon@ti.com,
        linux-phy@lists.infradead.org, airlied@linux.ie,
        markyacoub@google.com, chunfeng.yun@mediatek.com,
        robh+dt@kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>,
        dri-devel@lists.freedesktop.org, ck.hu@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        tzimmermann@suse.de, p.zabel@pengutronix.de,
        maarten.lankhorst@linux.intel.com, daniel@ffwll.ch
In-Reply-To: <20220325171511.23493-3-granquet@baylibre.com>
References: <20220325171511.23493-1-granquet@baylibre.com> <20220325171511.23493-3-granquet@baylibre.com>
Subject: Re: [PATCH 02/22] dt-bindings: mediatek,dp: Add Display Port binding
Date:   Fri, 25 Mar 2022 13:43:22 -0500
Message-Id: <1648233802.138910.210217.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2022 18:14:51 +0100, Guillaume Ranquet wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This controller is present on several mediatek hardware. Currently
> mt8195 and mt8395 have this controller without a functional difference,
> so only one compatible field is added.
> 
> The controller can have two forms, as a normal display port and as an
> embedded display port.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/mediatek/mediatek,dp.yaml         | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dts:24:18: fatal error: dt-bindings/power/mt8195-power.h: No such file or directory
   24 |         #include <dt-bindings/power/mt8195-power.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1609494

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

