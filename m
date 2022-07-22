Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0680357E18F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbiGVMoO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Jul 2022 08:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiGVMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:44:11 -0400
X-Greylist: delayed 373 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Jul 2022 05:44:09 PDT
Received: from lynxeye.de (ns.lynxeye.de [87.118.118.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0A8F796BF;
        Fri, 22 Jul 2022 05:44:09 -0700 (PDT)
Received: by lynxeye.de (Postfix, from userid 501)
        id D554DE74011; Fri, 22 Jul 2022 14:37:24 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from [192.168.178.22] (a89-183-85-87.net-htp.de [89.183.85.87])
        by lynxeye.de (Postfix) with ESMTPSA id B3989E74004;
        Fri, 22 Jul 2022 14:37:23 +0200 (CEST)
Message-ID: <9b0fad63e5610533da3d3423fd5f7c8719a86d73.camel@lynxeye.de>
Subject: Re: [PATCH v1 11/12] arm64: dts: mnt-reform2: don't use multiple
 blank lines
From:   Lucas Stach <dev@lynxeye.de>
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Jul 2022 14:37:23 +0200
In-Reply-To: <20220721195936.1082422-12-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com>
         <20220721195936.1082422-12-marcel@ziswiler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 21.07.2022 um 21:59 +0200 schrieb Marcel Ziswiler:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Avoid the following checkpatch warning:
> 
> arch/arm/boot/dts/imx8mq-mnt-reform2.dts:213: check: Please don't use
>  multiple blank lines
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Acked-by: Lucas Stach <dev@lynxeye.de>

> ---
> 
>  arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts b/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
> index 8956a46788fa..055031bba8c4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
> @@ -210,7 +210,6 @@ &pwm2 {
>  	status = "okay";
>  };
>  
> -
>  &reg_1p8v {
>  	vin-supply = <&reg_main_5v>;
>  };

