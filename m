Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA094A2D84
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 10:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbiA2JwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 04:52:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:53685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238371AbiA2JwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 04:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643449933;
        bh=S5j5/Sm6YkgWOSf2/+deeTb0J23eJMklqMU3VA6xYVw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hSlc/48VBEWGDyIpnGFrnqZxPOaobgdlDWfQknh2E0q4MIdrJQsyt3BEwNwAvw4m1
         NPtOpqReRDNyWuk1fEfc/uQ/7N+haKBXLDDHPtiEznEM0eGr8xA44UNMdrZD5sYdyN
         PXnvckzmbvfVQrwFBQs2yt9/dEj03/uDKA/EMucc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDNl-1mStwB3eHP-00qg4x; Sat, 29
 Jan 2022 10:52:12 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 3/5] clk: mmp: Declare mux tables as const u32[]
Date:   Sat, 29 Jan 2022 10:51:56 +0100
Message-Id: <20220129095159.2202366-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129095159.2202366-1-j.neuschaefer@gmx.net>
References: <20220129095159.2202366-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wugnxLreJ8HvuFe6a1KD2/l1RN1QGM7Z/RamLTVSxNzpNpXRmPI
 xrGnCqK1d+ASM5GpR6rjpAE6Kc7ULUFrJEcvtMfzxurYpHOVnofR4Ve/rl2g3miYKnUkxYv
 M9Uiok1CkFo21rlKOTzNvA4VwSwGk3kQQkYOMHg/SmqFg3ohaJogoa10xyfxBv5YkBuoqJM
 y31bh3El4Xhd19tri3hmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BpDlFZvPK4g=:m+hRt0372SHm4gfbBxRaJL
 Km0pNjENZ/v0UN0OVhkJhEr288RZR6WRcHZ6f89ypO1VoAlLnHBbdM1SWX21bQ+U08DzrzlmF
 VhrbchQM1QedrSzdl47ehtomISB/6zloCo3BQGRNePc6oy8VT6W2OqeGFV3oTpaC8sTcI0mrc
 1TL5H1eWpCnPgJLAixUDdFUUA4inf/spPHy+N8aCV/0vXPeYRYyKj/vMrTBRS1aKPw91Si3LT
 y5hSW0jGUMSMfkzqHUGd5RnxqYUgzlbNxVjYDluFwjpJhPSUfQ6U7A2Dpr8DI8ucdMCh8TFBs
 HvQzuwHJ3cljcgNyQN5EtOrbkENamrImXU7IhG8k/dtOQvbEdWS4xrBq2OsJM0Y4/tH8JcqO1
 kVEQ4LBpjK2vu2ROheDLzT4UR5PuqdRP01KwbSm/bJueaxirjUToFhhwxzc+DzyDF5F2e8Lyg
 oUMhna9EC1FIw4ZOh5Mesoy6LIAG5h0g3CbP8CQUbnXSdW/SHkt4tAqHTUnT5NLn3j/bq53bw
 G8iey6LYFKcTmcuanqbqAooKE1LluHdZKGIAi03m7KZcrw+8CUy3rSWS3nVE0QF3sIO05LBDv
 Dfbz48GJq9g+eBMfkFTKy1+vzssLb6B1K0dFVXGCD3M2LYEDx9W5e0lrM69nQSBr07VWase26
 5frlOYjNMp12YdWFAvEkGK06fuBywCzEfwtho7XO7qZvDeto7ph9JraGtxEV5BBVYLKPxQMvr
 MqwpDpoZlnAgeNXtJ9F2s33jE2GPKG67ohel9AFSG8k6EM5sVDmA3cAHrfoaGS1i4rVfFNP+y
 sL7rHMf6Nq9dzaQJXyAIOMwP8ihoERc5xTnB0IwmIuyNUSUnPrm43QkyYyrS+jbKKd8Rz63U5
 1isdddEtEPKKHbGz4PgugD+Rr2j2r5TMM/fd2DHT3QuYElZvZ+w2Bfi4CQhdjtChq0nfDQ3pt
 U+PRcPIzymWGYlHOHCYsHQWg7UARwAnkdQuJ8nxHVW8MBGy08o+eAga1YbW7CP9rWBXwlw2oj
 2nGgyY+5IeALdL28GQ/gahop7plgm2Ths1NpVZzYyEqhNReJP2rHYTjeuJ6ognpmEzWZ6nCFq
 Bpumsh5A8lAb0o=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clk_register_mux_table takes a const u32 *, we can declare the
mux tables as const u32[].

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/clk/mmp/clk-of-mmp2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index 0839fb2049e94..50a780274ba0c 100644
=2D-- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -317,9 +317,9 @@ static const char * const ccic_parent_names[] =3D {"pl=
l1_2", "pll1_16", "vctcxo"};

 static DEFINE_SPINLOCK(gpu_lock);
 static const char * const mmp2_gpu_gc_parent_names[] =3D  {"pll1_2", "pll=
1_3", "pll2_2", "pll2_3", "pll2", "usb_pll"};
-static u32 mmp2_gpu_gc_parent_table[] =3D          { 0x0000,   0x0040,   =
0x0080,   0x00c0,   0x1000, 0x1040   };
+static const u32 mmp2_gpu_gc_parent_table[] =3D { 0x0000,   0x0040,   0x0=
080,   0x00c0,   0x1000, 0x1040   };
 static const char * const mmp2_gpu_bus_parent_names[] =3D {"pll1_4", "pll=
2",   "pll2_2", "usb_pll"};
-static u32 mmp2_gpu_bus_parent_table[] =3D         { 0x0000,   0x0020,   =
0x0030,   0x4020   };
+static const u32 mmp2_gpu_bus_parent_table[] =3D { 0x0000,   0x0020,   0x=
0030,   0x4020   };
 static const char * const mmp3_gpu_bus_parent_names[] =3D {"pll1_4", "pll=
1_6", "pll1_2", "pll2_2"};
 static const char * const mmp3_gpu_gc_parent_names[] =3D  {"pll1",   "pll=
2",   "pll1_p", "pll2_p"};

=2D-
2.34.1

