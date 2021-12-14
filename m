Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFC7473F01
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhLNJL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhLNJL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:11:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E390FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:11:26 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mx3q9-0005pE-96; Tue, 14 Dec 2021 10:11:17 +0100
Message-ID: <52b3f8a1aab7b898529c4f530ae4dbef2f0abec8.camel@pengutronix.de>
Subject: Re: [PATCH V4 3/9] dt-bindings: power: imx8mn: add defines for DISP
 blk-ctrl domains
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, tharvey@gateworks.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Dec 2021 10:11:15 +0100
In-Reply-To: <20211128131853.15125-4-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
         <20211128131853.15125-4-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 28.11.2021 um 07:18 -0600 schrieb Adam Ford:
> This adds the defines for the power domains provided by the DISP
> blk-ctrl.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  include/dt-bindings/power/imx8mn-power.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/dt-bindings/power/imx8mn-power.h b/include/dt-bindings/power/imx8mn-power.h
> index 102ee85a9b62..eedd0e581939 100644
> --- a/include/dt-bindings/power/imx8mn-power.h
> +++ b/include/dt-bindings/power/imx8mn-power.h
> @@ -12,4 +12,9 @@
>  #define IMX8MN_POWER_DOMAIN_DISPMIX	3
>  #define IMX8MN_POWER_DOMAIN_MIPI	4
> 
> +#define IMX8MN_DISPBLK_PD_MIPI_DSI	0
> +#define IMX8MN_DISPBLK_PD_MIPI_CSI	1
> +#define IMX8MN_DISPBLK_PD_LCDIF	2
> +#define IMX8MN_DISPBLK_PD_ISI	3
> +
>  #endif
> --
> 2.32.0
> 


