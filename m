Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAAD48A40D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345762AbiAJX6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:58:16 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42634 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242630AbiAJX6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:58:15 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DB204894;
        Tue, 11 Jan 2022 00:58:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641859094;
        bh=qnKz7LM757k8HkgtPk71VoFWL2HhNiN+9+eX50x2hTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wVO2SgGGIJjmaPAwKWPwGSomwcK9MlluE9oYupkK/k0zRN1k45nuRzl3qfzAJ6Qlm
         lIozl+IdGJ4Ffpkqgucl2bFBjGSILloO3lTtkMp7kEn8tOXNPVC7+h15qHY4M+aZRy
         JUcTR7DorZ4FDV/cvXc0wiiIMznTZQny4ooWJO3M=
Date:   Tue, 11 Jan 2022 01:58:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oliver =?utf-8?Q?St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/14] arm64: dts: imx8mm: fix strange hex notation
Message-ID: <YdzIDNa0gHqbLChi@pendragon.ideasonboard.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
 <20220107180314.1816515-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220107180314.1816515-2-marcel@ziswiler.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Thank you for the patch.

On Fri, Jan 07, 2022 at 07:03:01PM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Fix strange hex notation with mixed lower-case and upper-case letters.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
> index a003e6af3353..c68a5e456025 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
> @@ -279,7 +279,7 @@
>  #define MX8MM_IOMUXC_SAI5_RXD2_SAI1_TX_DATA4                                0x150 0x3B8 0x000 0x1 0x0
>  #define MX8MM_IOMUXC_SAI5_RXD2_SAI1_TX_SYNC                                 0x150 0x3B8 0x4CC 0x2 0x1
>  #define MX8MM_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK                                 0x150 0x3B8 0x4E8 0x3 0x0
> -#define MX8MM_IOMUXC_SAI5_RXD2_PDM_DATA2                                    0x150 0x3B8 0x53c 0x4 0x0
> +#define MX8MM_IOMUXC_SAI5_RXD2_PDM_DATA2                                    0x150 0x3B8 0x53C 0x4 0x0
>  #define MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23                                   0x150 0x3B8 0x000 0x5 0x0
>  #define MX8MM_IOMUXC_SAI5_RXD3_SAI5_RX_DATA3                                0x154 0x3BC 0x4E0 0x0 0x0
>  #define MX8MM_IOMUXC_SAI5_RXD3_SAI1_TX_DATA5                                0x154 0x3BC 0x000 0x1 0x0
> @@ -486,7 +486,7 @@
>  #define MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC                                 0x1D8 0x440 0x000 0x0 0x0
>  #define MX8MM_IOMUXC_SAI3_TXFS_GPT1_CAPTURE2                                0x1D8 0x440 0x000 0x1 0x0
>  #define MX8MM_IOMUXC_SAI3_TXFS_SAI5_RX_DATA1                                0x1D8 0x440 0x4D8 0x2 0x2
> -#define MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX                                 0x1D8 0x440 0x4Fc 0x4 0x2
> +#define MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX                                 0x1D8 0x440 0x4FC 0x4 0x2
>  #define MX8MM_IOMUXC_SAI3_TXFS_UART2_DTE_TX                                 0x1D8 0x440 0x000 0x4 0x0
>  #define MX8MM_IOMUXC_SAI3_TXFS_GPIO4_IO31                                   0x1D8 0x440 0x000 0x5 0x0
>  #define MX8MM_IOMUXC_SAI3_TXFS_TPSMP_HDATA1                                 0x1D8 0x440 0x000 0x7 0x0
> @@ -494,7 +494,7 @@
>  #define MX8MM_IOMUXC_SAI3_TXC_GPT1_COMPARE2                                 0x1DC 0x444 0x000 0x1 0x0
>  #define MX8MM_IOMUXC_SAI3_TXC_SAI5_RX_DATA2                                 0x1DC 0x444 0x4DC 0x2 0x2
>  #define MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX                                  0x1DC 0x444 0x000 0x4 0x0
> -#define MX8MM_IOMUXC_SAI3_TXC_UART2_DTE_RX                                  0x1DC 0x444 0x4Fc 0x4 0x3
> +#define MX8MM_IOMUXC_SAI3_TXC_UART2_DTE_RX                                  0x1DC 0x444 0x4FC 0x4 0x3
>  #define MX8MM_IOMUXC_SAI3_TXC_GPIO5_IO0                                     0x1DC 0x444 0x000 0x5 0x0
>  #define MX8MM_IOMUXC_SAI3_TXC_TPSMP_HDATA2                                  0x1DC 0x444 0x000 0x7 0x0
>  #define MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0                                 0x1E0 0x448 0x000 0x0 0x0

-- 
Regards,

Laurent Pinchart
