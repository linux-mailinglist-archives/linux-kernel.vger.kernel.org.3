Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9A46F698
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhLIWTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhLIWTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:19:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B257AC0617A1;
        Thu,  9 Dec 2021 14:15:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4B33BCE2905;
        Thu,  9 Dec 2021 22:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2038EC341CC;
        Thu,  9 Dec 2021 22:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639088122;
        bh=8+5iejOgt4a0kV0Vay3REpdXFmJ05lGq8mKVYoJ5mOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qsuO8wX3P6ivizjIYASOLUKS7Pg2Q6WQTRv02j7MCcj+oQL8LdxYQz4A19xAenjHS
         j8WSCYO2ndqayDdLKDFM6iPKbi/oJc0mT9phzQ8Ljv3iW/3cGfZ3fvY/gcIMZWzy1W
         WGphXEutdaonqh1OWSuMW5gA3dWMPuraMq/S3IGXVv8uzTZwoXtlOQxULtrZjoPiTh
         OPyDqzS6lRqud/UbrisuHI39P8AidKN0NGVvpvqAwpKp7BVK3jRraRX7kjSOhE9+BK
         dxb5O3kz7GLTbsHPtpaGrOW+0pupd+bg/PJHSGvuo+I+egi95zx4DDxpc90vgv82JC
         TXfZjvs62NxJg==
Received: by mail-ed1-f42.google.com with SMTP id r11so23701872edd.9;
        Thu, 09 Dec 2021 14:15:22 -0800 (PST)
X-Gm-Message-State: AOAM533J3kS5jzK7BL0Gsqt9xNTcaybuSL9YJPy7R659tw5g6t76M1eH
        blGgO7nJexOjACPFy5E+qIc9OMdRrDumXvZRMA==
X-Google-Smtp-Source: ABdhPJyWGE4yophjLw+aj1ZHBnOdC34qdnBApVThTxytcLV4NKNORgY2HorbJ+2FVd+KDAYIp8Z7QHfm5oklNSpg1mo=
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr32502014edx.306.1639088120352;
 Thu, 09 Dec 2021 14:15:20 -0800 (PST)
MIME-Version: 1.0
References: <20211112062604.3485365-1-peng.fan@oss.nxp.com> <20211112062604.3485365-4-peng.fan@oss.nxp.com>
In-Reply-To: <20211112062604.3485365-4-peng.fan@oss.nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 9 Dec 2021 16:15:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLD6=a==nx=aXjqRwQ3xTamrPVk8LwmqygC_q0UCrL9iw@mail.gmail.com>
Message-ID: <CAL_JsqLD6=a==nx=aXjqRwQ3xTamrPVk8LwmqygC_q0UCrL9iw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: imx8qxp: add cache info
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 12:27 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX8QXP A35 Cluster has 32KB Icache, 32KB Dcache and 512KB L2 Cache
>  - Icache is 2-way set associative
>  - Dcache is 4-way set associative
>  - L2cache is 8-way set associative
>  - Line size are 64bytes
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 617618edf77e..dbec7c106e0b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -58,6 +58,12 @@ A35_0: cpu@0 {
>                         compatible = "arm,cortex-a35";
>                         reg = <0x0 0x0>;
>                         enable-method = "psci";
> +                       i-cache-size = <0x8000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <256>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;

Why do you need all this for the L1? Isn't it discoverable with cache
ID registers?

Rob
