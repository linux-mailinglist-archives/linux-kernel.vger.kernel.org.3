Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C775707AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiGKPvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiGKPut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:50:49 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD80A73931
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:50:39 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id trqd2700h4C55Sk01rqd4C; Mon, 11 Jul 2022 17:50:38 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgD-0036wy-D6; Mon, 11 Jul 2022 17:50:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgC-006shH-SJ; Mon, 11 Jul 2022 17:50:36 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 02/10] video: fbdev: atari: Remove bogus FB_VMODE_YWRAP flags
Date:   Mon, 11 Jul 2022 17:50:26 +0200
Message-Id: <0373f203dc541e17e4e52981c9416b46b4df0c95.1657554353.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657554353.git.geert@linux-m68k.org>
References: <cover.1657554353.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vertical wrap is not supported (fb_fix_screeninfo.ywrapstep = 0), hence
there is no point in setting the FB_VMODE_YWRAP flag in video modes.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/atafb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index c0683d2a4efaf1e8..172ef547ff6f4883 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -467,27 +467,27 @@ static struct fb_videomode atafb_modedb[] __initdata = {
 	{
 		/* 320x200, 15 kHz, 60 Hz (ST low) */
 		"st-low", 60, 320, 200, 32000, 32, 16, 31, 14, 96, 4,
-		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+		0, FB_VMODE_NONINTERLACED
 	}, {
 		/* 640x200, 15 kHz, 60 Hz (ST medium) */
 		"st-mid", 60, 640, 200, 32000, 32, 16, 31, 14, 96, 4,
-		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+		0, FB_VMODE_NONINTERLACED
 	}, {
 		/* 640x400, 30.25 kHz, 63.5 Hz (ST high) */
 		"st-high", 63, 640, 400, 32000, 128, 0, 40, 14, 128, 4,
-		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+		0, FB_VMODE_NONINTERLACED
 	}, {
 		/* 320x480, 15 kHz, 60 Hz (TT low) */
 		"tt-low", 60, 320, 480, 31041, 120, 100, 8, 16, 140, 30,
-		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+		0, FB_VMODE_NONINTERLACED
 	}, {
 		/* 640x480, 29 kHz, 57 Hz (TT medium) */
 		"tt-mid", 60, 640, 480, 31041, 120, 100, 8, 16, 140, 30,
-		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+		0, FB_VMODE_NONINTERLACED
 	}, {
 		/* 1280x960, 72 kHz, 72 Hz (TT high) */
 		"tt-high", 57, 1280, 960, 7760, 260, 60, 36, 4, 192, 4,
-		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+		0, FB_VMODE_NONINTERLACED
 	},
 
 	/*
@@ -497,11 +497,11 @@ static struct fb_videomode atafb_modedb[] __initdata = {
 	{
 		/* 640x480, 31 kHz, 60 Hz (VGA) */
 		"vga", 63.5, 640, 480, 32000, 18, 42, 31, 11, 96, 3,
-		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+		0, FB_VMODE_NONINTERLACED
 	}, {
 		/* 640x400, 31 kHz, 70 Hz (VGA) */
 		"vga70", 70, 640, 400, 32000, 18, 42, 31, 11, 96, 3,
-		FB_SYNC_VERT_HIGH_ACT | FB_SYNC_COMP_HIGH_ACT, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+		FB_SYNC_VERT_HIGH_ACT | FB_SYNC_COMP_HIGH_ACT, FB_VMODE_NONINTERLACED
 	},
 
 	/*
@@ -511,7 +511,7 @@ static struct fb_videomode atafb_modedb[] __initdata = {
 	{
 		/* 896x608, 31 kHz, 60 Hz (Falcon High) */
 		"falh", 60, 896, 608, 32000, 18, 42, 31, 1, 96,3,
-		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+		0, FB_VMODE_NONINTERLACED
 	},
 };
 
-- 
2.25.1

