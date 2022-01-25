Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E721149BE5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiAYWTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:19:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60938 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiAYWTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:19:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E0B26181B;
        Tue, 25 Jan 2022 22:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDFEC340E0;
        Tue, 25 Jan 2022 22:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643149173;
        bh=VlXNEuKVTo6EC09CQRzHMCigmbmkNcEacUmaxeI8KrM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AUTOgcSRZJIBOoE8MAmpZ+SbKBaNdEqmBzjDOxxzuSWmiHS3dUitE65K8kSEet1On
         i4gV+mrWeEu+MFKPDZjcfrP1xRJ02CAjmGVm6r5HgWWXxszxrKKMM3hhmZohsKX2x+
         x4itDGpanqTFnvhj+B7o839ura1NuSWgWXOtwmlAPqCgU4/f9Bt2kADaMwnrUbT9ek
         G7EWWGIdQZt1Oa1WXPGImD7fIlkWUT2gTxnEf2Q6K5gvmkLJPXSCCU/8Xo6hfUSpyi
         rWKnQxjQ5y5B4Cb4mO9wc8ghdnR/KiB3g2sHP3DI461C2zNtBJqLAMkyf3436e93Uu
         pcuxkCTBLJBJw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220125144441.17750-1-ceggers@arri.de>
References: <20220125144441.17750-1-ceggers@arri.de>
Subject: Re: [PATCH RESEND 0/6] clk: imx6*: avoid GPMI clock glitches on reparenting/divider change
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>, ceggers@arri.de
To:     Abel Vesa <abel.vesa@nxp.com>, Christian Eggers <ceggers@arri.de>
Date:   Tue, 25 Jan 2022 14:19:31 -0800
User-Agent: alot/0.10
Message-Id: <20220125221933.8DDFEC340E0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christian Eggers (2022-01-25 06:44:35)
> RESEND because the series got corrupted on first tranmission

Still looks corrupted :(
