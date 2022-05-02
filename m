Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C39B5179E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiEBWZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiEBWXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:23:54 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF10A1BE;
        Mon,  2 May 2022 15:20:24 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id y63so16590242oia.7;
        Mon, 02 May 2022 15:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VR6aQATCwdPyj2a2nSMH6aYl4mUSCVGJN91iqP+EUDc=;
        b=XSU42yiZiJu/CzAJFTD/5J2C91N0mAM3f+J74g/XKVxqL9TrSrrJvP40rPzEE7Z7LA
         ZwxJvJ4wwfh8vNeYFMH+o9O+mKcQgz6JsynGhoh3tNLCwdHqFWOch6EBkGJD++GJg37x
         /w6YIolQwahv3Mm3qTxHSowh+GYwTTh3lSY2csYZvJvSgCwYO2GG+HmfWHhUHVswVDvI
         WxCwO873xS7FacqlW8tM3uWe8eJ54G5f9wWE2i1HT9qLeNcgRxEoQNMcjsFJmHbKoSl+
         J7YAW0C0eZrWn1q7KgjKyUYMo2ZWpVAQHSnkBUiwx2B2PkGHzQrZvDrN1Z+dGtlkClub
         pNoA==
X-Gm-Message-State: AOAM531dtkYJ/dm6dsVlG0033Otu6GOSzUYHNIQ8XiMgxixAtyIPnrqe
        XpjtMtEGyeynjku6Fa04Gw==
X-Google-Smtp-Source: ABdhPJx8V52EJ5MZQdiCVJ7+iHueY+QIxBxyN68rDX9lMZGqh4wHsvqRFvMWHd4cNinWBJjPJ6PZNg==
X-Received: by 2002:a54:4e92:0:b0:325:224c:8ff7 with SMTP id c18-20020a544e92000000b00325224c8ff7mr586298oiy.154.1651530023456;
        Mon, 02 May 2022 15:20:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dw40-20020a056870772800b000e686d1387csm6287149oab.22.2022.05.02.15.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 15:20:23 -0700 (PDT)
Received: (nullmailer pid 1896541 invoked by uid 1000);
        Mon, 02 May 2022 22:20:21 -0000
Date:   Mon, 2 May 2022 17:20:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCHv1 18/19] arm64: dts: rockchip: Add base DT for rk3588 SoC
Message-ID: <YnBZJa/dCKnGRF3n@robh.at.kernel.org>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-19-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422170920.401914-19-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 07:09:19PM +0200, Sebastian Reichel wrote:
> From: Kever Yang <kever.yang@rock-chips.com>
> 
> This initial version supports (single core) CPU, dma, interrupts, timers,
> UART and SDHCI. In short - everything necessary to boot Linux on this
> system on chip.
> 
> The DT is split into rk3588 and rk3588s, which is a reduced version
> (i.e. with less peripherals) of the former.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> [rebase, squash and reword commit message]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

[...]

> diff --git a/include/dt-bindings/clock/rk3588-cru.h b/include/dt-bindings/clock/rk3588-cru.h
> index d51e6ed939b3..2f046f048a83 100644
> --- a/include/dt-bindings/clock/rk3588-cru.h
> +++ b/include/dt-bindings/clock/rk3588-cru.h
> @@ -1451,6 +1451,7 @@
>  #define SCMI_CRYPTO_CORE		20
>  #define SCMI_CRYPTO_PKA			21
>  #define SCMI_SPLL			22
> +#define SCMI_HCLK_SD			23

Belongs in the header patch?

>  
>  /********Name=SECURE_SOFTRST_CON00,Offset=0xA00********/
>  #define SRST_A_SECURE_NS_BIU		10
> -- 
> 2.35.1
> 
> 
