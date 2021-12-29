Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC206481718
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 22:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhL2Vgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 16:36:31 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:36087 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhL2Vga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 16:36:30 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id DE8ED2000A;
        Wed, 29 Dec 2021 21:36:27 +0000 (UTC)
Date:   Wed, 29 Dec 2021 22:36:27 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: fsl: scu: Add i.MX8QM rtc binding
Message-ID: <YczU26vFxiO0wWKa@piout.net>
References: <1640088948-3690-1-git-send-email-abel.vesa@nxp.com>
 <1640088948-3690-2-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640088948-3690-2-git-send-email-abel.vesa@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2021 14:15:46+0200, Abel Vesa wrote:
> Add i.MX8QM rtc compatible to the SCU bindings documentation.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index f1470d562156..4633be2182dd 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -134,7 +134,9 @@ RTC bindings based on SCU Message Protocol
>  ------------------------------------------------------------
>  
>  Required properties:
> -- compatible: should be "fsl,imx8qxp-sc-rtc";
> +- compatible:		Should be one of:
> +			"fsl,imx8qm-sc-rtc",
> +			"fsl,imx8qxp-sc-rtc".

Are the imx8qm and imx8qxp SCU actually different? I would hope you
won't had a third messaging protocol for the RTC...


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
