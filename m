Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67D9466F17
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 02:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376928AbhLCBaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 20:30:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42882 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356794AbhLCBaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:30:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B5D3628A9;
        Fri,  3 Dec 2021 01:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EA9C00446;
        Fri,  3 Dec 2021 01:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638494806;
        bh=X+YiYktzByoUj3nOnnjfIh2j31/JPhOGcu8FfoM3lmQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MD7Ffr986h5shGcce0hE2Tk/QubgbjLBz6j6nVEzhYHHNSMm0aEizP/g4Utb97NcV
         cle8Od1DMYCXNJksHUs6kROLan3+OnxDS0o9oRBnvV4q1cFlgofp8cOFtl97gAMoAv
         tVipMmDNqw1ravWInO2k6LRGBYEJY2nC3WMtoZr993wKhna5jxrvwpLOD0xmSNnpNG
         Ez5TnTdpX/F4qXZecFobbxr7fDZQNMT/5vwAB+EnXiTFnpat4j7F12LajRo0MzRmAz
         Sr1p7SXKI5aRmdlEAVsKuEJmlxiUgkdAtJptYNTMzhcaC2gyIDVVvOPqrO6Tf2h8bw
         2P4Cz0iki700Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211115032607.28970-1-rdunlap@infradead.org>
References: <20211115032607.28970-1-rdunlap@infradead.org>
Subject: Re: [PATCH] clk: imx: pllv1: fix kernel-doc notation for struct clk_pllv1
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Abel Vesa <abel.vesa@nxp.com>, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, Alexander Shiyan <shc_work@mail.ru>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Date:   Thu, 02 Dec 2021 17:26:44 -0800
User-Agent: alot/0.9.1
Message-Id: <20211203012645.F2EA9C00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap (2021-11-14 19:26:07)
> Convert struct clk_pllv1 comments to kernel-doc notation and move them
> below the MFN_* macros.
>=20
> Fixes this kernel-doc warning:
>=20
> drivers/clk/imx/clk-pllv1.c:12: warning: This comment starts with '/**', =
but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * pll v1
>=20
> Fixes: 2af9e6db14db ("ARM i.MX: Add common clock support for pllv1")
> Fixes: a594790368a8 ("ARM: imx: pllv1: Fix PLL calculation for i.MX27")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Abel Vesa <abel.vesa@nxp.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-imx@nxp.com
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Applied to clk-next
