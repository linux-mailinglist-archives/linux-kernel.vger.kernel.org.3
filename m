Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580CE466F69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 02:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhLCCAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLCCAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:00:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1963C06174A;
        Thu,  2 Dec 2021 17:57:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A562CB8259D;
        Fri,  3 Dec 2021 01:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCBCC00446;
        Fri,  3 Dec 2021 01:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638496634;
        bh=/UDPkKhe1xuwTbm+tg8qCshVaTn9o077A90hWi1CX6Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=P22bOfSNPryoQdsSZD7kk6eRN7s+Om6vT2CrvzGA+WfQqsOfcQWB28+L3q4+DEVdg
         RaEnE/+bS+Xa+JMb5+pnHft6xafn/ejRiKDa0WjnCi0lPjxlbn3MUtOhXAhMVbIPib
         AVPGDMb85P3nJzplra/0mv6p6X7QkdB7dXOemB6QWNPx2K9Zpo9HOcRU1vDZsqrSu5
         tOscy+82u0EROxyAmpcuYvHIoIuHxzebeqig5l/zRoOe0d4ZosVQ5sSce3PJZHGEMg
         VERM8XGJcQF5Kv/6vDJt0fOyx25PEaweT+OYxDdLnveZRLlY5ZydyC9FqcwaDLAEQC
         GAlTDVckYpiMQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YZlchKnEqWN8nKQk@ryzen>
References: <163087455086.405991.14496690646389782129@swboyd.mtv.corp.google.com> <20211105055932.3432-1-miles.chen@mediatek.com> <YZlchKnEqWN8nKQk@ryzen>
Subject: Re: [PATCH v3] clk: imx: use module_platform_driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        wsd_upstream@mediatek.com
To:     Abel Vesa <abel.vesa@nxp.com>, miles.chen@mediatek.com
Date:   Thu, 02 Dec 2021 17:57:13 -0800
User-Agent: alot/0.9.1
Message-Id: <20211203015714.4BCBCC00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-11-20 12:37:24)
> On 21-11-05 13:59:32, miles.chen@mediatek.com wrote:
> > From: Miles Chen <miles.chen@mediatek.com>
> >=20
> > Hi Stephen,
> >=20
> > >> Fixes: e0d0d4d86c766 ("clk: imx8qxp: Support building i.MX8QXP clock=
 driver as module")
> > >> Cc: Fabio Estevam <festevam@gmail.com>
> > >> Cc: Stephen Boyd <sboyd@kernel.org>
> > >> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> >=20
> > > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> >=20
> > Thanks for doing the review, I cannot find this patch in clk-imx tree,
> > Would you pick this patch, please?
>=20
> Sorry for the delay.=20
>=20
> Fixes are usually picked up directly by Stephen,=20
> therefore they're not going through clk-imx tree.
>=20
> Stephen, can you pick this one up please?
>=20

It doesn't look like a very critical fix but ok. I suppose someone could
try to use =3Dm for these files?
