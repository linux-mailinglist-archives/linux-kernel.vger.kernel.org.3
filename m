Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5F4BAE12
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiBRAKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:10:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiBRAKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:10:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E323058E5E;
        Thu, 17 Feb 2022 16:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645142979;
        bh=tNeDGkoj81qJYq6F6QZlW2TcqYZQQfmV+dfePkZYrvM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XLV2uwyrzUrRZ3Z6gQzB20SJTO/0niQQgRZ+ahoMgqPWutjDy9iP7OfLVY248MCxX
         BWrTOoIW6J2y9/y6Yrp1s8JnkTG57N80En3TtOZcPE7eiNRCwAHHz69Dg9muBDcXYA
         HcB1ovBmpxaDUPcMulT3qColDUoFZ4sNmj/NT9Zo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Udt-1nNLop3eAb-006ysA; Fri, 18
 Feb 2022 01:09:38 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-actions@lists.infradead.org
Subject: [PATCH v4 5/5] clk: actions: Make sentinel elements more obvious
Date:   Fri, 18 Feb 2022 01:09:21 +0100
Message-Id: <20220218000922.134857-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218000922.134857-1-j.neuschaefer@gmx.net>
References: <20220218000922.134857-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xeYTRFzkMWjyKO4xWaLwWNdriIvxSCWqqm9Mm+ASH2buzvuNhzy
 sQO5Nqu7uL2ETPwGrDeXJnKMA+7efsfy5zYPf7OEbktICkN/jB6aiADa6ipbdgRnwZZJ+pO
 bHTbX59OtKK+HzF3poiEiSpmuxXFM37o3ywTKE7afId6RbTOfIn9L7HTmObw5TUWm4WTSVG
 PJiZKe+YvdYAZPI++s74g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1V/lEO0B3yk=:IeclwrkKx6F6P5dakmqrWY
 C7ICSbtbsLFCjm4Ao/pUmDvTyzG4GOdWTSyXTth5n7VKaLxnsbEIlLsqm9vzg4SDg7SK1WmzF
 x8uC0hMNB4pkHUOWT06UJ4zldKWc6Yqi5dOtykxZJfw8IX8TfLYU1gAQAmwt8aL/DvLoA6EZ/
 PoGV8zjfALMMiRNnR3PYAXBNKGaV9Y6RnqxUIx2D5TvUJmEAT4dMrYwwJcCQ9plJ5vntxnUYe
 34fCN771fb+axI6t0A+aWmIpbGhHBE6aUCAmPsSkqbgJooVwIy6hdRDd1jXzgK9jiszh3vk9t
 dQDm0Uo6o+oRpBKfTHF7xK8C5BIDHke7wYO+8okItLARkiSbFZ5IcUE7L3EczxVpWpsVEudSV
 mw66+ocG0cO08rFfOCGsMbC06F3WntypjpIaBDq7JnWWUeRu0XuhDEB8mx/hmlTd1wgZmhMoC
 c2v3Qip3mK7uc6rs9Duglsj6YvLPw9jskPwRbQRLOK89RP+QsyKvFoxo5W99OKzcfsd1eTYZz
 SpqtEi/c+gqUK2VPxzz1Ynwc7H67oo3ELfWMiyb5Cp38+ErQVTypISBtOhcFCvtCFY+sM4F5c
 yKXm4IfxTqg5Do28LGSp9gOjEr11x8MmZuQnWfrw5q3EhP4u15gSYocL83rpyuqnZBMwRFSSK
 3eyMHuQm6osafFsseMUV3y8nJxDY46k8CwoyDePfJjkLFTWFdSS+Yy9cbZ4x7cKZ+epcMbkKa
 wsA6zH4H+xljJ4bNH88fmaDmFaU9S8VUMdg4UfZVnXVC2EDNwP4D0uh1B0L8LoBbNcJDi7p5h
 ROsGBxuVVNO/jwTjCfBjdDObR8vEgs/FL3t5r1ABwvYLav/06G96VU4he66clSj/lpcS1eOo3
 GpW/hifVfwhLyHMPz+HdIcPepiAuvgP3EsfKOZxa5kw+A/FE+sRN+2YsZeD7dj8xRhDRNFTSj
 a8zJfPj/xw/lXFSRF9oGk612NiFawysuvNyCVGGRwUIhL2wYYNC50fZconNsZIYd7oGRkuEpr
 IEtVxdqOpnLV+3yl1neS1e1VVp8qEa92vMm1pymme12R7XJdrYTLsZeKNE0V2qyiMeNg6MM9Y
 bPU900fDi4TrsU=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sentinel elements of various tables in drivers/clk/actions can be a
bit hard to recognize. Make them easier to see by changing the style
from { 0, 0 } to { /* sentinel */ }.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v4:
- New patch
=2D--
 drivers/clk/actions/owl-s500.c | 16 ++++++++--------
 drivers/clk/actions/owl-s700.c | 18 ++++++++++--------
 drivers/clk/actions/owl-s900.c | 26 +++++++++++++-------------
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500=
.c
index 57d06e183dff4..c69a7e2f06457 100644
=2D-- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -95,7 +95,7 @@

 static const struct clk_pll_table clk_audio_pll_table[] =3D {
 	{ 0, 45158400 }, { 1, 49152000 },
-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 /* pll clocks */
@@ -138,46 +138,46 @@ static struct clk_factor_table sd_factor_table[] =3D=
 {
 	{ 272, 1, 17 * 128 }, { 273, 1, 18 * 128 }, { 274, 1, 19 * 128 }, { 275,=
 1, 20 * 128 },
 	{ 276, 1, 21 * 128 }, { 277, 1, 22 * 128 }, { 278, 1, 23 * 128 }, { 279,=
 1, 24 * 128 },
 	{ 280, 1, 25 * 128 },
-	{ 0, 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_factor_table de_factor_table[] =3D {
 	{ 0, 1, 1 }, { 1, 2, 3 }, { 2, 1, 2 }, { 3, 2, 5 },
 	{ 4, 1, 3 }, { 5, 1, 4 }, { 6, 1, 6 }, { 7, 1, 8 },
 	{ 8, 1, 12 },
-	{ 0, 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_factor_table hde_factor_table[] =3D {
 	{ 0, 1, 1 }, { 1, 2, 3 }, { 2, 1, 2 }, { 3, 2, 5 },
 	{ 4, 1, 3 }, { 5, 1, 4 }, { 6, 1, 6 }, { 7, 1, 8 },
-	{ 0, 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_div_table rmii_ref_div_table[] =3D {
 	{ 0, 4 }, { 1, 10 },
-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_div_table std12rate_div_table[] =3D {
 	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
 	{ 4, 5 }, { 5, 6 }, { 6, 7 }, { 7, 8 },
 	{ 8, 9 }, { 9, 10 }, { 10, 11 }, { 11, 12 },
-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_div_table i2s_div_table[] =3D {
 	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
 	{ 4, 6 }, { 5, 8 }, { 6, 12 }, { 7, 16 },
 	{ 8, 24 },
-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_div_table nand_div_table[] =3D {
 	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 6 },
 	{ 4, 8 }, { 5, 10 }, { 6, 12 }, { 7, 14 },
 	{ 8, 16 }, { 9, 18 }, { 10, 20 }, { 11, 22 },
-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 /* mux clock */
diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700=
.c
index 6ea7da1d6d755..3e48105602aa0 100644
=2D-- a/drivers/clk/actions/owl-s700.c
+++ b/drivers/clk/actions/owl-s700.c
@@ -73,7 +73,7 @@

 static struct clk_pll_table clk_audio_pll_table[] =3D {
 	{0, 45158400}, {1, 49152000},
-	{0, 0},
+	{ /* sentinel */ }
 };

 static struct clk_pll_table clk_cvbs_pll_table[] =3D {
@@ -82,7 +82,8 @@ static struct clk_pll_table clk_cvbs_pll_table[] =3D {
 	{33, 35 * 12000000}, {34, 36 * 12000000}, {35, 37 * 12000000},
 	{36, 38 * 12000000}, {37, 39 * 12000000}, {38, 40 * 12000000},
 	{39, 41 * 12000000}, {40, 42 * 12000000}, {41, 43 * 12000000},
-	{42, 44 * 12000000}, {43, 45 * 12000000}, {0, 0},
+	{42, 44 * 12000000}, {43, 45 * 12000000},
+	{ /* sentinel */ }
 };

 /* pll clocks */
@@ -137,7 +138,7 @@ static struct clk_factor_table sd_factor_table[] =3D {
 	{276, 1, 21 * 128}, {277, 1, 22 * 128}, {278, 1, 23 * 128}, {279, 1, 24 =
* 128},
 	{280, 1, 25 * 128}, {281, 1, 26 * 128},

-	{0, 0},
+	{ /* sentinel */ }
 };

 static struct clk_factor_table lcd_factor_table[] =3D {
@@ -150,19 +151,19 @@ static struct clk_factor_table lcd_factor_table[] =
=3D {
 	{256, 1, 1 * 7}, {257, 1, 2 * 7}, {258, 1, 3 * 7}, {259, 1, 4 * 7},
 	{260, 1, 5 * 7}, {261, 1, 6 * 7}, {262, 1, 7 * 7}, {263, 1, 8 * 7},
 	{264, 1, 9 * 7}, {265, 1, 10 * 7}, {266, 1, 11 * 7}, {267, 1, 12 * 7},
-	{0, 0},
+	{ /* sentinel */ }
 };

 static struct clk_div_table hdmia_div_table[] =3D {
 	{0, 1},   {1, 2},   {2, 3},   {3, 4},
 	{4, 6},   {5, 8},   {6, 12},  {7, 16},
 	{8, 24},
-	{0, 0},
+	{ /* sentinel */ }
 };

 static struct clk_div_table rmii_div_table[] =3D {
 	{0, 4},   {1, 10},
-	{0, 0}
+	{ /* sentinel */ }
 };

 /* divider clocks */
@@ -179,13 +180,14 @@ static OWL_DIVIDER(clk_rmii_ref, "rmii_ref", "ethern=
et_pll", CMU_ETHERNETPLL, 2,
 static struct clk_factor_table de_factor_table[] =3D {
 	{0, 1, 1}, {1, 2, 3}, {2, 1, 2}, {3, 2, 5},
 	{4, 1, 3}, {5, 1, 4}, {6, 1, 6}, {7, 1, 8},
-	{8, 1, 12}, {0, 0, 0},
+	{8, 1, 12},
+	{ /* sentinel */ }
 };

 static struct clk_factor_table hde_factor_table[] =3D {
 	{0, 1, 1}, {1, 2, 3}, {2, 1, 2}, {3, 2, 5},
 	{4, 1, 3}, {5, 1, 4}, {6, 1, 6}, {7, 1, 8},
-	{0, 0, 0},
+	{ /* sentinel */ }
 };

 /* gate clocks */
diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s900=
.c
index 5144ada2c7e1a..7dc6e07fb60ea 100644
=2D-- a/drivers/clk/actions/owl-s900.c
+++ b/drivers/clk/actions/owl-s900.c
@@ -73,12 +73,12 @@

 static struct clk_pll_table clk_audio_pll_table[] =3D {
 	{ 0, 45158400 }, { 1, 49152000 },
-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_pll_table clk_edp_pll_table[] =3D {
 	{ 0, 810000000 }, { 1, 135000000 }, { 2, 270000000 },
-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 /* pll clocks */
@@ -120,41 +120,41 @@ static struct clk_div_table nand_div_table[] =3D {
 	{ 4, 8 }, { 5, 10 }, { 6, 12 }, { 7, 14 },
 	{ 8, 16 }, { 9, 18 }, { 10, 20 }, { 11, 22 },
 	{ 12, 24 }, { 13, 26 }, { 14, 28 }, { 15, 30 },
-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_div_table apb_div_table[] =3D {
 	{ 1, 2 }, { 2, 3 }, { 3, 4 },
-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_div_table eth_mac_div_table[] =3D {
 	{ 0, 2 }, { 1, 4 },
-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_div_table rmii_ref_div_table[] =3D {
 	{ 0, 4 },	  { 1, 10 },
-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_div_table usb3_mac_div_table[] =3D {
 	{ 1, 2 }, { 2, 3 }, { 3, 4 },
-	{ 0, 0 }
+	{ /* sentinel */ }
 };

 static struct clk_div_table i2s_div_table[] =3D {
 	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
 	{ 4, 6 }, { 5, 8 }, { 6, 12 }, { 7, 16 },
 	{ 8, 24 },
-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_div_table hdmia_div_table[] =3D {
 	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
 	{ 4, 6 }, { 5, 8 }, { 6, 12 }, { 7, 16 },
 	{ 8, 24 },
-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 /* divider clocks */
@@ -185,24 +185,24 @@ static struct clk_factor_table sd_factor_table[] =3D=
 {
 	{ 280, 1, 25 * 128 }, { 281, 1, 26 * 128 }, { 282, 1, 27 * 128 }, { 283,=
 1, 28 * 128 },
 	{ 284, 1, 29 * 128 }, { 285, 1, 30 * 128 }, { 286, 1, 31 * 128 }, { 287,=
 1, 32 * 128 },

-	{ 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_factor_table dmm_factor_table[] =3D {
 	{ 0, 1, 1 }, { 1, 2, 3 }, { 2, 1, 2 }, { 3, 1, 3 },
 	{ 4, 1, 4 },
-	{ 0, 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_factor_table noc_factor_table[] =3D {
 	{ 0, 1, 1 },   { 1, 2, 3 }, { 2, 1, 2 }, { 3, 1, 3 }, { 4, 1, 4 },
-	{ 0, 0, 0 },
+	{ /* sentinel */ }
 };

 static struct clk_factor_table bisp_factor_table[] =3D {
 	{ 0, 1, 1 }, { 1, 2, 3 }, { 2, 1, 2 }, { 3, 2, 5 },
 	{ 4, 1, 3 }, { 5, 1, 4 }, { 6, 1, 6 }, { 7, 1, 8 },
-	{ 0, 0, 0 },
+	{ /* sentinel */ }
 };

 /* factor clocks */
=2D-
2.34.1

