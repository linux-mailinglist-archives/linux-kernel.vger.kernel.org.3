Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCC848D0B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 04:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiAMDQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 22:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiAMDQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:16:41 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1E4C06173F;
        Wed, 12 Jan 2022 19:16:40 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id g21so5390267qtk.4;
        Wed, 12 Jan 2022 19:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/gINneDYHArTmYDuiZroEiN0ihwxBALKaNwAenOfdY=;
        b=UQF/0vh5YPu246CIaKrZq34eNz6twmswUX900v6ezJ3ZkA0EvZMJFkdOdMbmrWOSPF
         sRH9L/o642dayg4As32yFaNLh/rANq3I8gi9nI51O2JLNCaBxHJIp9QwI7mW1JpO8cE4
         DWBPbv9TqflPKoTkBsY7ymSqB3bzoBWMheUK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/gINneDYHArTmYDuiZroEiN0ihwxBALKaNwAenOfdY=;
        b=3RvkmC1xzeVJkds8VZsfoAnmewLv/Gb0lOAMv4gtpxzYsqp6yEVNcmZSUbvGp50YC5
         /TceCwaD/i7fV12hRj3+Cz/5Z4j+PJfcfOqV7uycd0FRJuibfjnOXfK3Rho7DWLeB+D+
         xnnr7lTOpSU05LtgbD0HZ42th8va4q/sG8FQuTzqfA8cwtQfGRfiv4lIlgKCcRifkqI+
         fozQiNbE5dJWqGWnrRuwS8PfHTKNwTvr4aH1c5hcCbb1IlwPLgL+8PTsqp5uKJ4WebgS
         FMxs/KHFHIPeUtSIpJ15cpznplpraemWClF59zmCQ+7B44by8mBP7wWnTze3bL8ozRwa
         4uaw==
X-Gm-Message-State: AOAM532egMyEIS4dJgkbv+McX25iPURWCNhLo1yebx5YiLohO/bYrJT7
        zZrISTRHP1CFakRuFblO7TjCZSYiCY1W6CqX4VFSDQa8
X-Google-Smtp-Source: ABdhPJwjC8vJ9oEqVShEVmfTLImiXZ9NACvdnYSMgbS//mqpu0MoR8m4WgqPkDXWDI1ELo+mE0NL/IvUF8RDNd8G80k=
X-Received: by 2002:ac8:5a0b:: with SMTP id n11mr2134767qta.625.1642043799724;
 Wed, 12 Jan 2022 19:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20220112230247.982212-1-iwona.winiarska@intel.com> <20220112230247.982212-4-iwona.winiarska@intel.com>
In-Reply-To: <20220112230247.982212-4-iwona.winiarska@intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 13 Jan 2022 03:16:25 +0000
Message-ID: <CACPK8XfL8-TovFWBxXo7ryijPXeS+sFwejxz-fKNNwxgD1N+oA@mail.gmail.com>
Subject: Re: [PATCH v5 03/13] ARM: dts: aspeed: Add PECI controller nodes
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 at 23:04, Iwona Winiarska <iwona.winiarska@intel.com> wrote:
>
> Add PECI controller nodes with all required information.
>
> Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 11 +++++++++++
>  arch/arm/boot/dts/aspeed-g5.dtsi | 11 +++++++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi | 11 +++++++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index b313a1cf5f73..3c2961da6272 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -391,6 +391,17 @@ uart_routing: uart-routing@9c {
>                                 };
>                         };
>
> +                       peci0: peci-controller@1e78b000 {
> +                               compatible = "aspeed,ast2400-peci";
> +                               reg = <0x1e78b000 0x60>;
> +                               interrupts = <15>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
> +                               resets = <&syscon ASPEED_RESET_PECI>;
> +                               cmd-timeout-ms = <1000>;
> +                               clock-frequency = <1000000>;
> +                               status = "disabled";
> +                       };
> +
>                         uart2: serial@1e78d000 {
>                                 compatible = "ns16550a";
>                                 reg = <0x1e78d000 0x20>;
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index c7049454c7cb..aab1c3ecb4dc 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -511,6 +511,17 @@ ibt: ibt@140 {
>                                 };
>                         };
>
> +                       peci0: peci-controller@1e78b000 {
> +                               compatible = "aspeed,ast2500-peci";
> +                               reg = <0x1e78b000 0x60>;
> +                               interrupts = <15>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
> +                               resets = <&syscon ASPEED_RESET_PECI>;
> +                               cmd-timeout-ms = <1000>;
> +                               clock-frequency = <1000000>;
> +                               status = "disabled";
> +                       };
> +
>                         uart2: serial@1e78d000 {
>                                 compatible = "ns16550a";
>                                 reg = <0x1e78d000 0x20>;
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 5106a424f1ce..564f1292993f 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -507,6 +507,17 @@ wdt4: watchdog@1e7850c0 {
>                                 status = "disabled";
>                         };
>
> +                       peci0: peci-controller@1e78b000 {
> +                               compatible = "aspeed,ast2600-peci";
> +                               reg = <0x1e78b000 0x100>;
> +                               interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_REF0CLK>;
> +                               resets = <&syscon ASPEED_RESET_PECI>;
> +                               cmd-timeout-ms = <1000>;
> +                               clock-frequency = <1000000>;
> +                               status = "disabled";
> +                       };
> +
>                         lpc: lpc@1e789000 {
>                                 compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
>                                 reg = <0x1e789000 0x1000>;
> --
> 2.31.1
>
