Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908F54FB14D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 03:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbiDKBTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 21:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239133AbiDKBTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 21:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA18218C;
        Sun, 10 Apr 2022 18:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A507160FC3;
        Mon, 11 Apr 2022 01:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2633AC385AB;
        Mon, 11 Apr 2022 01:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649639846;
        bh=Wmd3tpnOCMz+F8jQzU/+hDuRAAQJvtvRLj04PWXXuuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeOMDzgRziTkixAeun05EC1EQvc+TSxuBJYPMGxlrZbP3sO094oW2DA0aAwEt+8ox
         PPXXwJq6qq5YymxCEEsqq/tMrZdvJbQk+uuUMA7fDhWjaiiRNwpNkoY1Q4ktYbjyeW
         SZZQ5uK59gFaG1qdnUXH44xEkSDLDgvDat1TigOmZwUoyZJDjf5ksTIyOs/2mavwqn
         ZQyUN1IC37LxEDlzV1d6LjE3hX45l6QbY45ZqOu5AfkxpzyyDd5R9nBr7Jci69QY73
         DfolTnQN+9TTEBMfJr09jhWv0DD4CB2TUJ/gHZXusOFtTubbXQ87WSz8zz9Q1TACuS
         pBJLyRSn0BmKw==
Date:   Mon, 11 Apr 2022 09:17:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] imx8m{m,n}-venice-*: add missing uart-has-rtscts
 property to UARTs
Message-ID: <20220411011719.GB129381@dragon>
References: <20220405200223.18384-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405200223.18384-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:02:23PM -0700, Tim Harvey wrote:
> Add the missing 'uart-has-rtscts' property to UART's that have hardware
> flow control capability.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

'arm64: dts: ...' subject prefix please.

And it doesn't apply to imx/dt64 branch.

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts  | 3 +++
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts  | 3 +++
>  arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts  | 1 +
>  4 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
> index 426483ec1f88..7a5d45e80982 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
> @@ -221,6 +221,7 @@
>  	pinctrl-0 = <&pinctrl_uart3>, <&pinctrl_bten>;
>  	cts-gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
>  	rts-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +	uart-has-rtscts;
>  	status = "okay";
>  
>  	bluetooth {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> index ee78c189c556..a23801deb4cd 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> @@ -716,6 +716,7 @@
>  	dtr-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
>  	dsr-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
>  	dcd-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
> +	uart-has-rtscts;
>  	status = "okay";
>  };
>  
> @@ -731,6 +732,7 @@
>  	pinctrl-0 = <&pinctrl_uart3>;
>  	cts-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
>  	rts-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
> +	uart-has-rtscts;
>  	status = "okay";
>  };
>  
> @@ -739,6 +741,7 @@
>  	pinctrl-0 = <&pinctrl_uart4>;
>  	cts-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
>  	rts-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
> +	uart-has-rtscts;
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> index 49e15a671b67..6aa0eb463647 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> @@ -644,6 +644,7 @@
>  	pinctrl-0 = <&pinctrl_uart1>;
>  	rts-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
>  	cts-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
> +	uart-has-rtscts;
>  	status = "okay";
>  };
>  
> @@ -660,6 +661,7 @@
>  	pinctrl-0 = <&pinctrl_uart3>, <&pinctrl_uart3_gpio>;
>  	rts-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
>  	cts-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
> +	uart-has-rtscts;
>  	status = "okay";
>  
>  	bluetooth {
> @@ -677,6 +679,7 @@
>  	dtr-gpios = <&gpio4 3 GPIO_ACTIVE_LOW>;
>  	dsr-gpios = <&gpio4 4 GPIO_ACTIVE_LOW>;
>  	dcd-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>;
> +	uart-has-rtscts;
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> index 3c0e63d2e82d..2c1f591335ad 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> @@ -625,6 +625,7 @@
>  	pinctrl-0 = <&pinctrl_uart3>, <&pinctrl_uart3_gpio>;
>  	rts-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
>  	cts-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
> +	uart-has-rtscts;
>  	status = "okay";
>  
>  	bluetooth {
> -- 
> 2.17.1
> 
