Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416D14A2D85
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 10:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352477AbiA2Jwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 04:52:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:53347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237502AbiA2JwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 04:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643449935;
        bh=gRoLgReVt9sFMKKgTgP9bxEx0JJNCyYEO1Me2LoeXqw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=C7xHbw6ntN6xluwDa+g4kH8xrQQZpYeq6yLleXEIo9Q9jvAIFx5bCFY5C60avI2Dt
         cEYZfbzzrPT2XArpBXs4gb7X3S2O6ep8egRmbnuSxPLVeE7vBbt0pBRIB8azvqqsME
         y5PxRDCVRJGchMlZp5f3/GJP6lAjYHH7mbdcFj9Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1nF6mG2kIB-0048sg; Sat, 29
 Jan 2022 10:52:15 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5/5] clk: pistachio: Declare mux table as const u32[]
Date:   Sat, 29 Jan 2022 10:51:58 +0100
Message-Id: <20220129095159.2202366-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129095159.2202366-1-j.neuschaefer@gmx.net>
References: <20220129095159.2202366-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KE34mcs5juQ711y5ONeWmE3pM2pJTHQcjAqXXEo6hqDu3hKtRb8
 oWLGrhaqghRtr1ay00lRaJZcxlQXQSChmKqjGBMYweOXYz0FoyaCcjGux6qoOrI8VEQItWY
 ZsdC122xXAPDo8tVEAU38QSlZ2v8/gCcfphFtFrJH4DMywKO2IzNO6XtpPFEHQhFYpXWgEt
 G3P6rzIOoqOV29jrlZsFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cXKG2Akly48=:QciOPHrQgYxI/ETkmFgGn9
 sus+9uF/epI5kONu7NoLtMOZOmpX7zFs+gMTa2tXO8k3LIIun3TJAjyRqh+d7PTduaRmhP3Vo
 s5uv1pgkqGN9qFHECnrJXcuI2CbqtMUp0C6I+jklZ+jhoPY2gfFEwtucpRttDhDwfNojUhPx1
 /UYTddRqdLujmObhwHGgJNBrtC4IAEvwY7ZDmT/YeKj5T8pQ5G7LxCInmY2PMG7SjIooH5Hyc
 xlaWs/DX3IxnTbk/ScyMcEPv/YMSByceloQzzLoyOyk41+6YwiY9rx2+hn3Z7vwje2OT8as/H
 glnGxY7pxxuyi3QhljcKAeG4438rnij2CwpDM8p7HIYOTPOjgGLfB8A8NTqPQ2vPkhT9bkeoc
 Taa+EyP9QdSRE/bRrzW05RhI/sFhnHbbxV4vJYZc4sIJWsYidBptmxKwPo40PYAuPcqTZH3AP
 PJWyPXOutWkgMx+pOsXNrjUqHG+Tfrp910XOd2vzKEqB3nHX6Xma1h+A3TRMlkokuv9ymG2Dt
 T9L8OFbE4CrHExEGkBxe7NyZpoOLUbDpHAV6IS+IpOj7OMIYPwAXmLK8I+97B+U2n7Bdhk9PH
 Tbck6jojmVUmeW0Qhq671uvef/czzS4qEGhjg8HsvGrEx+V+p9ujLQk664fUIJ2VtBDNDeuo/
 F6UPbaISC+FlxHVe5m4YSd2SYI5UuP5kjiOEQkFKCV27GWxgvl2yn/UomRxvFkV+N9NOmeqNU
 hLKNgS9dqCOe1aPRd5PTEXwLivSFoG2g/SeVnaHQZQD+4ObhxfnRy8vobAGeLaMDsdL9aeZza
 rQ1KTnwj5+FyCoGNJvWrbMruDn99PnCDTs+5LZ/pF7reiQG9pYQTspfccsG1WX1243ANHsbXE
 6esTqn944NXWWeK0HVMrFmb9PD94MV6t4/gOxEfkmvVkgcmmIhust1AniR0FND+z0cxj409Vo
 V6cRK8QtJmALWkYgKkngv5druxSlAEIa7caS9zjKYhDekiFwd+b7vJOOJwfz06wkN1Djcz8gB
 oJNHjkWU/8CjiNi9AfaBvVn7mnLgiKvkSk3Rf68pAisK39vuA4xLBLshbQalw2IFm3OviD5sE
 4x08IuhviEb4Sw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clk_register_mux_table takes a const u32 *, we can declare the
mux table as const u32[].

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/clk/pistachio/clk-pistachio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/pistachio/clk-pistachio.c b/drivers/clk/pistachio=
/clk-pistachio.c
index 76f492c7e917e..2a6d583237dc7 100644
=2D-- a/drivers/clk/pistachio/clk-pistachio.c
+++ b/drivers/clk/pistachio/clk-pistachio.c
@@ -154,7 +154,7 @@ static struct pistachio_pll pistachio_plls[] __initdat=
a =3D {
 PNAME(mux_debug) =3D { "mips_pll_mux", "rpu_v_pll_mux",
 		     "rpu_l_pll_mux", "sys_pll_mux",
 		     "wifi_pll_mux", "bt_pll_mux" };
-static u32 mux_debug_idx[] =3D { 0x0, 0x1, 0x2, 0x4, 0x8, 0x10 };
+static const u32 mux_debug_idx[] =3D { 0x0, 0x1, 0x2, 0x4, 0x8, 0x10 };

 static unsigned int pistachio_critical_clks_core[] __initdata =3D {
 	CLK_MIPS
=2D-
2.34.1

