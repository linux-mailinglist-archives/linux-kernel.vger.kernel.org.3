Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642E14BA642
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbiBQQkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:40:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiBQQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:40:21 -0500
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2122B31A2;
        Thu, 17 Feb 2022 08:40:06 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id f13so2670281ilq.5;
        Thu, 17 Feb 2022 08:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=42YgXKsYX5OZqyMF3kRdlVgh0yrlkJ5vHS9c6U9AXD8=;
        b=uvSwjivzanb29+kwl7fByzsu2bthAzwtX9G0+k6erRNYnedtGile3qSm4dcBaVk02t
         h3DOJRelgu5E93hFd/lcPQPHXvT9Li/y0R15YTOhuOuUEDXDgsvGVnIIhWp8TDxH/wSJ
         y86DWQqZ4WzcnBONBx2y76mUjC/htlIWbhjM6G3LrVNzssS8eKwJyF23xClrXtngNDQM
         SJ0FMnqgb0Rzz3WbuvsoObx+POXSxCpsgqVVcK8QUaepzjyvqxpbVxzIyKsxsNt1KAfj
         irAEzUFHyogxTfHIEexHj3GMp9kD8UL27TlNceY7emP/mOcMIHUhzFoHSqmciC+HHpuL
         cwOw==
X-Gm-Message-State: AOAM532zubg56qQ4v7tw41pHrexG10glqJ1hRksJ5YCctclcPP7HOrDo
        1RvhSOtOUVw9Oygla+V14w==
X-Google-Smtp-Source: ABdhPJzblA3h4h2T4K+K98Bdy6EvTCXy87z0Zrx38haaMlOdtIg1+JWX6SDxGNwnl4O1+t+hZSC20A==
X-Received: by 2002:a05:6e02:2168:b0:2c1:a436:d18c with SMTP id s8-20020a056e02216800b002c1a436d18cmr499762ilv.49.1645116005928;
        Thu, 17 Feb 2022 08:40:05 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a19sm2309825iot.35.2022.02.17.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:40:05 -0800 (PST)
Received: (nullmailer pid 3365323 invoked by uid 1000);
        Thu, 17 Feb 2022 16:39:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>, Li Yi <liyi@loongson.cn>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        Zack Rusin <zackr@vmware.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Ilia Mirkin <imirkin@alum.mit.edu>
In-Reply-To: <20220216181712.1493400-3-15330273260@189.cn>
References: <20220216181712.1493400-1-15330273260@189.cn> <20220216181712.1493400-3-15330273260@189.cn>
Subject: Re: [PATCH v8 2/3] MIPS: Loongson64: dts: update the display controller device node
Date:   Thu, 17 Feb 2022 10:39:55 -0600
Message-Id: <1645115995.354636.3365322.nullmailer@robh.at.kernel.org>
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

On Thu, 17 Feb 2022 02:17:11 +0800, Sui Jingfeng wrote:
> From: suijingfeng <suijingfeng@loongson.cn>
> 
> The display controller is a pci device, its PCI vendor id is 0x0014
> its PCI device id is 0x7a06.
> 
> 1) In order to let the lsdc kms driver to know which chip the DC is
>    contained in, we add different compatible for different chip.
> 
> 2) Add display controller device node for ls2k1000 SoC
> 
> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
> ---
>  .../loongson/loongson,display-controller.yaml | 114 ++++++++++++++++++
>  .../display/loongson/loongson-drm.txt         |  16 +++
>  .../boot/dts/loongson/loongson64-2k1000.dtsi  |   8 ++
>  arch/mips/boot/dts/loongson/ls7a-pch.dtsi     |   7 +-
>  4 files changed, 140 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson-drm.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/display/loongson/loongson,display-controller.yaml#
Error: Documentation/devicetree/bindings/display/loongson/loongson,display-controller.example.dts:22.30-31 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/display/loongson/loongson,display-controller.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1593886

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

