Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA044A2D87
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 10:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352607AbiA2Jwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 04:52:44 -0500
Received: from mout.gmx.net ([212.227.17.20]:35113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238478AbiA2JwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 04:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643449931;
        bh=Swrg5/t4GYSpqbq0c9I5YxcNVTHXi9plZl3rISnQv50=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UIjyCHGkNRX3WwjfEAQ/5XJ8qVCG14YR70LL8DI5sIdX4jHK5BalcQg5z6TM3Spcm
         2BNPIAB8cK1OtLdysT4LJxdgws8UmsSBecXAsANehf0VeWVO7sG4JkU+1XC9rk6qg/
         Jvxs7e/ePC1paWiYkyzRptG7Wfjvxb592pIOKJfc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1mEOOB0CFE-00zr8v; Sat, 29
 Jan 2022 10:52:11 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH 2/5] clk: hisilicon: Remove unnecessary cast of mux table to u32 *
Date:   Sat, 29 Jan 2022 10:51:55 +0100
Message-Id: <20220129095159.2202366-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129095159.2202366-1-j.neuschaefer@gmx.net>
References: <20220129095159.2202366-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3QbcZ+fgvrQPBHAbbzAUIOnXldDccNhVwsbOTvbP2MM9djnv+Mo
 G15QKIq8BSqhf43TP+d1ezfc+UO715Lt4c0uBsNWkvKTnLkfwI3o3zNo33cPwJyhSiGASy3
 sOs35pUHVhr4AMN+VYlwidC8UjyYl2WTLxu7XU7VHjtq1XJ0am6oHLozVDgZvkYRcecSLHt
 +ieRVN08o+4b0xDB/5SzQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z3d1pBjeim0=:qWrUNI0oQu0tGTYMPpRmv4
 ayoKLaEsI+HItiYQvv9A8eX0TpJTsC6CFWaKSPu/pWhcxvR1/AeDTyZhYxuPRkkkqlwm1USwC
 cMawdS8oNIcY6B3LNw6EQYzmnfJRTZjyFJQ+Zz1mCTIw6+iBgCdbPtHRLQc7GUJSj3HxDNuAs
 CZbSVkEBCs+RPCUWAVVmYePIk03N396GksgzX1ywwyT9EF7z2BVThzgB2jo435DaYqyAcSBXL
 032eWcyN9UU2xWz9v166KVq3/Agt2oa3PaxAvd9YbGcqEauhKj+kEUKYbU5SYI67WBsnWc3DV
 Egm9s+yR8UjCIAM7iU5Og9sjZPj/QzGaeXXfGkRcW+Cf7HuZsKY3X7QdUZdn9tK07rBuG8Z/I
 FXrd/az9o+c8zTKUj2epU+X9uS+st+CjQUVPD+7v1zLGvnCN+gYSt6oNKg38pJNRfehONl23J
 Ba8mRksxJfSTuUIW2Z1m8iGhusk9lb5brWlPVAEdOY/UIGDh8Ini/gHWHy5jNKWFZT1NX86hO
 QKAe52eELpdm7INqqZtlzoyrO1vMHGL0zimJ9RWYTGEwSEBis770dkLCx5RLIVLnu/peh56kI
 gQMa4LCtamFu9p+nFBOb1XZHm083PbO3l78q6bzVVGnu2On+fgyDPp/+tETK0dOf5ZfeTUT+4
 5x1RMvZoofujpTwGPGyy07mBUkDH7duRCdMeizN9ufiCdxIUNx1p6e1qRBMoYR0R3BSEs60U0
 9E7hO/GbxPQ4Ca7g9kCcKPuYDyiZ3w7rp2+KkR6GI2kPfJjc0toJPEmWz5e/BMAGEDZMAGaDf
 B7pakIF3ey/iA99fsLvS8/6+oi7R+9an1E20NKuJdGVki7bySDBc/D5t34z4/Ijc6x8DLFooI
 IBW5yOFM0+Q9NXsnRUOGjRtgaI0CPGZeIO+9YejvSfDPbXvGMzy3cYazMsXuHePdv/zUHuvWd
 OYB18TDa+Joo34V7e/KDYxiYqyVD07OGLcD1J+sE6VAv54bQXcRoPGFNLU0GguEdwHjsH9xRc
 /sNeGajYbnmo12fIP+PzmDlJReut0oAOUTRDaXloVLPIA+OIYkh2jJQyG+ecZqE6ALOr3/1sc
 ePT5lD4KQsPB5I=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clk_register_mux_table takes a const u32 *, we don't need the
cast anymore.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/clk/hisilicon/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 9361fba7cd4cf..54d9fdc935990 100644
=2D-- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -162,7 +162,7 @@ int hisi_clk_register_mux(const struct hisi_mux_clock =
*clks,
 					clks[i].num_parents, clks[i].flags,
 					base + clks[i].offset, clks[i].shift,
 					mask, clks[i].mux_flags,
-					(u32 *)clks[i].table, &hisi_clk_lock);
+					clks[i].table, &hisi_clk_lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
=2D-
2.34.1

