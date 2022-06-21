Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9615537D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiFUQaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiFUQaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:30:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADEA1E3E8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:30:01 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1o3glH-0007xn-5n; Tue, 21 Jun 2022 18:29:55 +0200
Message-ID: <1bb9aeaf-dc05-3fa4-2b6f-bafbcbec325a@pengutronix.de>
Date:   Tue, 21 Jun 2022 18:29:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ARM: dts: imx6qdl-prti6q.dtsi: Add applicable properties
 to usdhc3
Content-Language: en-US
To:     Robin van der Gracht <robin@protonic.nl>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220621140334.568446-1-robin@protonic.nl>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220621140334.568446-1-robin@protonic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.22 16:03, Robin van der Gracht wrote:
> The usdhc3 interface is connected to a soldered eMMC chip on all boards
> that import this dtsi. Adding these properties speeds up the device probe
> during boot.
> 
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx6qdl-prti6q.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-prti6q.dtsi b/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
> index 19578f660b09..f0db0d4471f4 100644
> --- a/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
> @@ -94,6 +94,9 @@ &usdhc3 {
>  	pinctrl-0 = <&pinctrl_usdhc3>;
>  	bus-width = <8>;
>  	non-removable;
> +	no-1-8-v;
> +	no-sd;
> +	no-sdio;
>  	status = "okay";
>  };
>  


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
