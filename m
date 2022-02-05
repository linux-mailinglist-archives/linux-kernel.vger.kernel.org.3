Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504944AA82A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379777AbiBEKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:37:01 -0500
Received: from mout.gmx.net ([212.227.15.18]:55851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379713AbiBEKgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644057406;
        bh=FAvlJM+jb1m0qmORnVnFCRA+QzbVGz9kzNSNgqbFCdc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FZTWUrXvqrVrB+2nJ+vL91lXSe7krZ6jQXuR+ME6KzNTUuwMdydT/p4zg+CNtGhgp
         eZaDOlam2Cw3P+L1psXLqXu2rgesn9t04YVHwbBX05fX/cm4GGLqePd4yIgJkw0rl8
         yH2QFpqQMq/3R3zytPaKYF0Z6bRcO4e6S0kgg3cc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9kM-1mzpLe2ATU-00GX0X; Sat, 05
 Feb 2022 11:36:46 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 7/7] clk: pistachio: Declare mux table as const u32[]
Date:   Sat,  5 Feb 2022 11:36:13 +0100
Message-Id: <20220205103613.1216218-8-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DGR/LqufAv9n4PU7HJES8KlhrBCuH394ssecNb0vWGACLGmH7/H
 H+iSub3IEzG88RoH4WFGE1/uWXP4waYAg4xFXgfFnXMldprxMRsZwdnnB+r7diNJfTbWQ2s
 t+9xLxjmrctTZgDgUi5bC4sswDyQir65RTfKwDRfJPZ1rMS0K88UtYiDqg+hNpUZcLP0cKr
 gDuOobl1j16PwvU+xaNOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X6UKte1m/ZM=:Y65sZrSWGZmV3Qa1u4IVqT
 Jt4F9IEMcE936u4XAAzLpmkPnUjQCGD0WdgyJPud40yLCzfYWa9v1oJ8IOB1X5zIU3SiRbc8P
 KTN+GiPp741pigkbDNDM6YebDkBZ2Tyk74+yPvYzvK0Jpl3X1KMMvzOhfIVA5diN9VOSTWEnN
 hfZuyKGmtVqQ/NROUPR1lzaGYkcNu/qBwnVRiHgcRz04v/G/mKO3SPXyFXDTFOUTsArI8zDAU
 tGaVdPGZnkRlPvCmWw8NoIS41bp3zkMscz0NoGh1FgWCcX92BGVoVgjN3q3ArpetnCtZ3hYdC
 iXuwG40l8at/AySYpfAlkmoXemLwP6dONeyHbGgg3tuXAyAJce/mZlI92A4GR1v/DOTG48akf
 rKE/5/asAJRV6d0WrXRJvmvbFH/auqtUeEsC6Oh5258aRhsxtcybEjs4ImhfHAL3RK7Nj5bfP
 nq0bEBBMHwqnezWw+Rnj5pxd9saSW/zqzOEdY+dsG3mpu+jfATnskdsKQRq0ZbgD7KGHQNKbW
 5FeNbxo/0x96f2JFr6ujGPK4YKj/+MInl690z7OJa7tva6J4YboBDZOM3V2YYYYzg5bh5vl7/
 vsllmVLQ5TToUWyhu/9oagjBPYpPFK0cMtpxjIt5fo+ZvEkAl4qgMHmKYnUu3u3dm6dGI3MiH
 Dtk4bMQPxZisuNJoPqfMN9zIDVVvrM3NqFuG2eqTSrSI+OJkes0G7u+p+JP9KMS7j0flKh+sM
 OU6iZdGfjwcxghzhQ+RYmbFzv3UoLyuoPpHo16cESaoea+E7jpq+QPWOpW18/HO/xF2ypaOuO
 k2wmoZWNoi7DnDIssLKWAs/hsRanU+uh1W73PbP3/Yn6QWW3JkkhwwYLyFVVElacXnuHL/iew
 J9bKsf44Zdi/A85t4QGHfp9t0MXP/WCqt1Zhf6nzvEVlIBWIuhJ1w+/GYWfiGXqEzib+SRc4T
 BdEpmLNgZc0/jFFfpztAq87w0u1R1ZFJyNnyV81Xl4joRi0lxsKQKEHOwCwb8A58SnMmMTzNq
 Bf9zXdy2R1TTR+hQfeC/Uo2zCeUy9YqsgIQvnkb6IBBgBRoboV7RacJh07skOJ0fCO06kZTj1
 zq6CGefHXa08r0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clk_register_mux_table takes a const u32 *, we can declare the
mux table as const u32[].

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- no changes
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

