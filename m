Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8259F516DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384384AbiEBKRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384481AbiEBKRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:17:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D1A183BE
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:13:41 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nlT3c-0005yj-Ti; Mon, 02 May 2022 12:13:32 +0200
Message-ID: <399244dcaab28cb7217bae65ee290821ad89afae.camel@pengutronix.de>
Subject: Re: [PATCH v1 3/4] soc: imx: imx8m-blk-ctrl: Add reset bits for
 mipi dsi phy
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Viraj Shah <viraj.shah@linutronix.de>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 May 2022 12:13:27 +0200
In-Reply-To: <20220502100233.6023-4-viraj.shah@linutronix.de>
References: <20220502100233.6023-1-viraj.shah@linutronix.de>
         <20220502100233.6023-4-viraj.shah@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 02.05.2022 um 12:02 +0200 schrieb Viraj Shah:
> As per reference manual page 3903, bit 16 (GPR_MIPI_S_RESETN)
> as well as 17 (GPR_MIPI_M_RESETN) are the reset masks for mipi phy reset
> mask.

Nack. The MIPI-S reset is used for the CSI receiver and is already
handled by the appropriate power domain.

Regards,
Lucas

> 
> Signed-off-by: Viraj Shah <viraj.shah@linutronix.de>
> ---
>  drivers/soc/imx/imx8m-blk-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index ca63fd30e70a..d7638b7fa99d 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -502,7 +502,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[]
>  		.gpc_name = "mipi-dsi",
>  		.rst_mask = BIT(5),
>  		.clk_mask = BIT(8) | BIT(9),
> -		.mipi_phy_rst_mask = BIT(17),
> +		.mipi_phy_rst_mask = BIT(17) | BIT(16),
>  	},
>  	[IMX8MM_DISPBLK_PD_MIPI_CSI] = {
>  		.name = "dispblk-mipi-csi",


