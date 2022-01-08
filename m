Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36C0488083
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 02:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiAHB1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 20:27:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54124 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiAHB1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 20:27:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C555CB827BF;
        Sat,  8 Jan 2022 01:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8091EC36AEB;
        Sat,  8 Jan 2022 01:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641605259;
        bh=KeI8RnfgfEQEdVg9X/nT0Z288YrE9gljUBDI7bfI//I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KkwDtrORgFmcvs8c7t5b+VeDnBQ9pEOkRPNZX2m8y4ecqscEqpnCLSodtgA7OkbTA
         G7ZAT7JgXhXQ2unjQYCmZHPHcBNnBXIbB6/CFwATC4hHPprA8nm5Tfh+1fJUk5ML4l
         SJbXvdx3Z0yWQP8PbYeGJCQhD+GgATdLJgn2ZS0SDZ0SPpTvZx8W2KS5Wd4/ZfT2XN
         9XAKYgo32PQ8ulklxHZOIsz8ftlIXyPWXDr/AypaqZdukYjFy3DgY2Opem9azCnjhK
         a93qi5JIyqUVHmDvekRu4HQh89jfW20Qxv86LrWY5/mvugkUOZ60I22xgLFcohkAkS
         yYBpCEI9/8cWw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1639747533-9778-1-git-send-email-abel.vesa@nxp.com>
References: <1639747533-9778-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH v2] clk: imx: Add imx8dxl clk driver
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
Date:   Fri, 07 Jan 2022 17:27:38 -0800
User-Agent: alot/0.9.1
Message-Id: <20220108012739.8091EC36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-12-17 05:25:33)
> From: Jacky Bai <ping.bai@nxp.com>
>=20
> Add files for imx8dxl clk driver which is based on imx8qxp clock driver.
>=20
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
