Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03AB50E9AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245046AbiDYTrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245038AbiDYTrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:47:09 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FB62A71A;
        Mon, 25 Apr 2022 12:44:04 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id g30-20020a4a251e000000b0033a39d8340aso2983475ooa.5;
        Mon, 25 Apr 2022 12:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3MgO8upGLQIT7MA1c1wZtenkS69Cr8OOjspSzkPpmss=;
        b=VdK/ikbGzF8vyJbzdErm17h3UVQcKhQ4ouDT0f/q4y73e1YKtOE4LoE0LTsM3N5BuK
         0tRsUDymTkqEdFAJWAEPtgxgPwXbhoCaVJSTLQFSVCQ5Cv+U0tFaCg08zHYu8Hwi25Xh
         xXq8WLRl+Xb7MMB3L8OJmCdM9X0mDIj6dO/JrQT0wEvU7N9xH69EcnyFb0xZ4kO8rkYQ
         +AVPP20N4h831POP1s+hPFDZ4MT22B0ofLuqVF33TKkC3D6syPen+vfDxpPxPJ1tEb16
         JuR+oMd/u+R8LCdv8J/0+pwhX9OHoOfVBPJIr+UhWntZddkm4E5qhpaMOTQBVYJrjT47
         ELtQ==
X-Gm-Message-State: AOAM531K/0LdO5/HmQ/4M/bRWx7oFg4ZmBYfCtn55LIvCA1JYt+B19B2
        1WshILB86MNfNhdrJGWceQ==
X-Google-Smtp-Source: ABdhPJwf4Xyx+/VQ5kGcMOPdAcQfh7fvYOnVekrEwwDVyJaLDX2aks6e0Ho5r/lUEmXwJDUSbQPsMg==
X-Received: by 2002:a4a:dfd7:0:b0:35e:499c:7bb5 with SMTP id p23-20020a4adfd7000000b0035e499c7bb5mr4695942ood.36.1650915843421;
        Mon, 25 Apr 2022 12:44:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f63-20020a9d2c45000000b005e973e22081sm4115852otb.37.2022.04.25.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 12:44:02 -0700 (PDT)
Received: (nullmailer pid 141172 invoked by uid 1000);
        Mon, 25 Apr 2022 19:44:01 -0000
Date:   Mon, 25 Apr 2022 14:44:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
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
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com
Subject: Re: [PATCHv1 19/19] arm64: dts: rockchip: Add rk3588-evb1 board
Message-ID: <Ymb6AWcLkUnqsslp@robh.at.kernel.org>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-20-sebastian.reichel@collabora.com>
 <46e72600-b96a-03a9-134d-28a0cb4bc078@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46e72600-b96a-03a9-134d-28a0cb4bc078@linaro.org>
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

On Sat, Apr 23, 2022 at 12:09:21PM +0200, Krzysztof Kozlowski wrote:
> On 22/04/2022 19:09, Sebastian Reichel wrote:
> > From: Kever Yang <kever.yang@rock-chips.com>
> > 
> > Add board file for the RK3588 evaluation board. While the hardware
> > offers plenty of peripherals and connectivity this basic implementation
> > just handles things required to successfully boot Linux from eMMC
> > and connect via UART.
> > 
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > [rebase, update commit message, use EVB1 for SoC bringup]
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../devicetree/bindings/arm/rockchip.yaml     |  5 +++
> >  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
> >  .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 34 +++++++++++++++++++
> >  3 files changed, 40 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > index eece92f83a2d..b14d0c84c69b 100644
> > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > @@ -664,6 +664,11 @@ properties:
> >            - const: rockchip,rk3568-bpi-r2pro
> >            - const: rockchip,rk3568
> >  
> > +      - description: Rockchip RK3588 Evaluation board
> > +        items:
> > +          - const: rockchip,rk3588-evb1-v10
> > +          - const: rockchip,rk3588
> > +
> >  additionalProperties: true
> >  
> >  ...
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index 4ae9f35434b8..8a53ab6d37a1 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -61,3 +61,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> > new file mode 100644
> > index 000000000000..68b19acb1550
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "rk3588.dtsi"
> > +
> > +/ {
> > +	model = "Rockchip RK3588 EVB1 V10 Board";
> > +	compatible = "rockchip,rk3588-evb1-v10", "rockchip,rk3588";
> > +
> > +	chosen {
> > +		stdout-path = "serial2:1500000n8";
> > +	};
> > +};
> > +
> > +&sdhci {
> > +	bus-width = <8>;
> > +	no-sdio;
> > +	no-sd;
> > +	non-removable;
> > +	max-frequency = <200000000>;
> > +	mmc-hs400-1_8v;
> > +	mmc-hs400-enhanced-strobe;
> > +	status = "ok";
> > +};
> > +
> > +&uart2 {
> > +	status = "ok";
> 
> Usually status goes at the end of properties and rockchip sources use
> "okay" instead of "ok".

"okay" is what's documented in the spec and in the schemas, so please 
fix. 

No need for reviewers to tell you this though, please run 'make 
dtbs_checks' on the dts file and don't add new warnings.

Rob
