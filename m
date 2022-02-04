Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0754A9C39
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359832AbiBDPte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBDPta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:49:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D34C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:49:29 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nG0pu-0003Cd-6d; Fri, 04 Feb 2022 16:49:22 +0100
Message-ID: <6439e94e-ad3b-1e4d-e724-235121f40bc6@pengutronix.de>
Date:   Fri, 4 Feb 2022 16:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 10/16] ARM: dts: stm32: keep uart4 behavior on
 stm32mp157c-lxa-mc1
Content-Language: en-US
To:     Erwan Le Ray <erwan.leray@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220203171114.10888-1-erwan.leray@foss.st.com>
 <20220203171114.10888-11-erwan.leray@foss.st.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220203171114.10888-11-erwan.leray@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.22 18:11, Erwan Le Ray wrote:
> DMA configuration is added to uart nodes in stm32mp15x device tree.
> Delete uart4 DMA property in stm32mp157c-lxa-mc1 board device tree to
> keep console in irq mode, as DMA support for console has been removed
> from the driver by commit e359b4411c28 ("serial: stm32: fix threaded
> interrupt handling").
> 
> Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
> index 1e9bf7eea0f1..e8d2ec41d537 100644
> --- a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
> @@ -248,5 +248,7 @@
>  &uart4 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart4_pins_a>;
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
>  	status = "okay";
>  };


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
