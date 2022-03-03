Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508EA4CBF18
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiCCNpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiCCNpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:45:31 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD0E18A7A0;
        Thu,  3 Mar 2022 05:44:46 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id i6-20020a4ac506000000b0031c5ac6c078so5789568ooq.6;
        Thu, 03 Mar 2022 05:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=MWU8DyAQWfBCp/kx00pg2Nk6vyP9a87Eky1nXis5bgw=;
        b=Cy902N/pLaZHuBcUg/NvduVCdw5pQ8cayt86Cnnf2zAM67tiRpt6nUmCIx01tULE7A
         BK2InSYlv+z38pwG1eImHY+Cdv+oKOK2cqvSN+1HuPe3ncV7KNC5XN2fsxO7DLbY171k
         TfkfQb9JCChTfc2iFMDtVhRO0iOEQV3pGBy9u1hPz3WsB6qnNrdcCDajXWsSOMukGAP5
         y/SZiehec7LBeEbEsOGaOewIUKxc+WgO0sBMgu0oMqepDA/QhLmv+P88r23y4I1r0dwe
         pXacdJvvvSQTIZ3nUa6wYlDKfqMTXmLT1M+6v0vQbrrwzlBXHh3WuTcJfopMGI0+fP/z
         USYg==
X-Gm-Message-State: AOAM531rlYTvEhKO566ZIEkg5xXIIpcBBX40jK3XWK62Dzv65BWBxOex
        1/GMp4MSiJGFj7DpEP7sYA==
X-Google-Smtp-Source: ABdhPJxEjj3zkKGLS+DBVQDv69xIDBRF37rnjyhkcK3WRGVogrbTz8vxAjXBhVtoY28jPMDvlnXutw==
X-Received: by 2002:a05:6870:b62a:b0:d9:a98b:7a24 with SMTP id cm42-20020a056870b62a00b000d9a98b7a24mr3983372oab.160.1646315085557;
        Thu, 03 Mar 2022 05:44:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a69-20020a4a4c48000000b0031bec1608fbsm940634oob.17.2022.03.03.05.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 05:44:44 -0800 (PST)
Received: (nullmailer pid 1495436 invoked by uid 1000);
        Thu, 03 Mar 2022 13:44:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        john@metanate.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220302211113.4003816-18-clabbe@baylibre.com>
References: <20220302211113.4003816-1-clabbe@baylibre.com> <20220302211113.4003816-18-clabbe@baylibre.com>
Subject: Re: [PATCH v2 17/18] dt-bindings: crypto: convert rockchip-crypto to yaml
Date:   Thu, 03 Mar 2022 07:44:38 -0600
Message-Id: <1646315078.991896.1495435.nullmailer@robh.at.kernel.org>
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

On Wed, 02 Mar 2022 21:11:12 +0000, Corentin Labbe wrote:
> convert rockchip-crypto to yaml
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../crypto/rockchip,rk3288-crypto.yaml        | 64 +++++++++++++++++++
>  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
>  2 files changed, 64 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1600075


cypto-controller@ff8a0000: clock-names: ['aclk', 'hclk', 'sclk', 'apb_pclk'] is too long
	arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml
	arch/arm/boot/dts/rk3288-evb-rk808.dt.yaml
	arch/arm/boot/dts/rk3288-firefly-beta.dt.yaml
	arch/arm/boot/dts/rk3288-firefly.dt.yaml
	arch/arm/boot/dts/rk3288-firefly-reload.dt.yaml
	arch/arm/boot/dts/rk3288-miqi.dt.yaml
	arch/arm/boot/dts/rk3288-phycore-rdk.dt.yaml
	arch/arm/boot/dts/rk3288-popmetal.dt.yaml
	arch/arm/boot/dts/rk3288-r89.dt.yaml
	arch/arm/boot/dts/rk3288-rock2-square.dt.yaml
	arch/arm/boot/dts/rk3288-rock-pi-n8.dt.yaml
	arch/arm/boot/dts/rk3288-tinker.dt.yaml
	arch/arm/boot/dts/rk3288-tinker-s.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-brain.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-fievel.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-jaq.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-jerry.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-mickey.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-mighty.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-minnie.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-pinky.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-speedy.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-tiger.dt.yaml
	arch/arm/boot/dts/rk3288-vyasa.dt.yaml

cypto-controller@ff8a0000: clocks: [[7, 199], [7, 461], [7, 125], [7, 193]] is too long
	arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml
	arch/arm/boot/dts/rk3288-evb-rk808.dt.yaml
	arch/arm/boot/dts/rk3288-firefly-beta.dt.yaml
	arch/arm/boot/dts/rk3288-firefly.dt.yaml
	arch/arm/boot/dts/rk3288-firefly-reload.dt.yaml
	arch/arm/boot/dts/rk3288-miqi.dt.yaml
	arch/arm/boot/dts/rk3288-phycore-rdk.dt.yaml
	arch/arm/boot/dts/rk3288-popmetal.dt.yaml
	arch/arm/boot/dts/rk3288-r89.dt.yaml
	arch/arm/boot/dts/rk3288-rock2-square.dt.yaml
	arch/arm/boot/dts/rk3288-rock-pi-n8.dt.yaml
	arch/arm/boot/dts/rk3288-tinker.dt.yaml
	arch/arm/boot/dts/rk3288-tinker-s.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-brain.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-fievel.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-jaq.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-jerry.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-mickey.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-mighty.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-minnie.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-pinky.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-speedy.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-tiger.dt.yaml
	arch/arm/boot/dts/rk3288-vyasa.dt.yaml

