Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82FF477BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhLPSu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:50:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54788 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhLPSu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:50:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFFA8B825EB;
        Thu, 16 Dec 2021 18:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE53C36AE2;
        Thu, 16 Dec 2021 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639680624;
        bh=DvLthKXnDT7IAYNAF29saf7ivMQLdLn1JwfYJF2wQrw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rxyOB9elBHmWCppm0rjTtnn/Qp8gUoXe8Kv9Y1m8aZIykDzVmJ+6+gfvuy6MUMOtY
         YrWh8UbdLhmBDZjka8wccKXJPmmP/CZJb37Zq4wPK0pO9dAdqAcgbC/ibqZlaDJrHC
         6HwSMnu1NFkf6Csxir7pUBtL534u2YPN5jpZX3JaBJxsBppfr34ffen3Wt6O3sqMD0
         aGeULYtNahTGz+QZwykbh361haX74wg1zyAjIeR67xTgjDMWvgNPVdYVAeyqCGbmDm
         ADwSJKy/DprYjIfrMYSwUA3KP5LSQaXKtWIIcW3IDMcSb2+sYTZSVLIgQLPNEzoLHE
         TWESY91hlr2HQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1636567000-24145-1-git-send-email-abel.vesa@nxp.com>
References: <1636567000-24145-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH] clk: imx: Add imx8dxl clk driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Fabio Estevam <festevam@gmail.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Thu, 16 Dec 2021 10:50:23 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216185024.7DE53C36AE2@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-11-10 09:56:40)
> diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
> index c53a688d8ccc..7f4893706cc2 100644
> --- a/drivers/clk/imx/clk-imx8qxp.c
> +++ b/drivers/clk/imx/clk-imx8qxp.c
> @@ -297,6 +297,7 @@ static const struct of_device_id imx8qxp_match[] =3D {
>         { .compatible =3D "fsl,scu-clk", },
>         { .compatible =3D "fsl,imx8qxp-clk", &imx_clk_scu_rsrc_imx8qxp, },
>         { .compatible =3D "fsl,imx8qm-clk", &imx_clk_scu_rsrc_imx8qm, },
> +       { .compatible =3D "fsl,imx8dxl-clk", &imx_clk_scu_rsrc_imx8dxl, },

Can you keep this sorted on compatible string? Then we don't have to
worry about conflicts as much.

>         { /* sentinel */ }
>  };
>
