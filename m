Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD724BD41C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 04:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbiBUDMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:12:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbiBUDMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:12:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C46737ABA;
        Sun, 20 Feb 2022 19:12:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE7916112B;
        Mon, 21 Feb 2022 03:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A73EC340E8;
        Mon, 21 Feb 2022 03:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645413149;
        bh=GwQ/eb0J77Gu9/XtUJwksNIUhBuLr3quq8TQ/P+b5SQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3wagCvR7cVpWvxIgHYDKECcCMfdXmJoU/SBKhiGMJBsN/DJv7s7z7pPauvvZMcW9
         +ne6nZ9P95DhMCQsHSWOjHpJ5dpKGtLhn8D6vDttymumcxG72qsp76xsu2qnrCmj8j
         kIOV8ahIyOyJiAMSKEkUA0kk3/nt73E4W/Me+pBrBtWBySMnPg8SFUTYzyFpSObUyu
         I29V9uG4f0Wn7V6nobheCV2wz05GvfcpXYLDy++2bw3OQRlfkIBe6gMrKJ0un9OZ6b
         TIIsXWkwolQhic7bSC8aCYqqbf6QJtNjWrlR/4Um4TUwBSSDBacGs2+wOr2Ko6UzoK
         cQazf7AV+9dcg==
Date:   Mon, 21 Feb 2022 11:12:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oliver Graute <oliver.graute@kococonnector.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: imx8qm: Add watchdog node
Message-ID: <20220221031223.GD2249@dragon>
References: <20220209154713.17850-1-oliver.graute@kococonnector.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209154713.17850-1-oliver.graute@kococonnector.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 04:47:13PM +0100, Oliver Graute wrote:
> Enable the watchdog on imx8qm
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>

It doesn't apply for me.

Shawn

> ---
> need to enable CONFIG_IMX_SC_WDT
> 
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> index 87a4c3ec8861..b822f95f9baf 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> @@ -169,6 +169,11 @@
>  
>  	};
>  
> +	watchdog {
> +		compatible = "fsl,imx8qm-sc-wdt", "fsl,imx-sc-wdt";
> +		timeout-sec = <60>;
> +	};
> +
>  	/* sorted in register address */
>  	#include "imx8-ss-img.dtsi"
>  	#include "imx8-ss-dma.dtsi"
> -- 
> 2.17.1
> 
