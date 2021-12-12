Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8CA471A39
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 13:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhLLMzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 07:55:03 -0500
Received: from smtp-34-i2.italiaonline.it ([213.209.12.34]:42941 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230467AbhLLMzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 07:55:02 -0500
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([82.50.51.121])
        by smtp-34.iol.local with ESMTPA
        id wOMammqwPUpmcwOMcmGyK7; Sun, 12 Dec 2021 13:54:02 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639313642; bh=XB3UsxbeGSGlitHS0T7zXuAeheulVRHT3ylsFJWY7RA=;
        h=From;
        b=ZwtshlG9C0YZNYSxyOlodJ7wBNMvdpVxpX0Q/X6wq6QhBQZKXOcHUHLiq1RoVa7Of
         7gNXIu80nhElOTMM3p62BbFTgNkS1EVYh9o5366SbyFsiq2LbQiGLXcGoGZsBhZ6yR
         k5Po007Lmep19FDkT3ORMHxFxDkFGSoVLD0pbgd56R25QePqJKv2K5pTGXGLdqCU+U
         AqQF8yjLoc7slsrPNSHqj0EwnHyHVo8Ik6TV346lNFbVYfhlWxV6b7zxTE6T19Fpn4
         jNC52XpxuX/WuhoFCKUnpfyCu20FVcsiduJa8aBJxMfm+ghJk2J3HGIhrwUD4uW032
         p7KQKDcsP3G9Q==
X-CNFS-Analysis: v=2.4 cv=VsDmv86n c=1 sm=1 tr=0 ts=61b5f0ea cx=a_exe
 a=xtCFBUu/Ze6RtP+zVSd77w==:117 a=xtCFBUu/Ze6RtP+zVSd77w==:17
 a=VZkyjkMPts0tdjHXfkQA:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     "Andrew F . Davis" <afd@ti.com>, Felipe Balbi <balbi@ti.com>,
        Rachna Patil <rachna@ti.com>, Wolfram Sang <wsa@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jeff Lance <j-lance1@ti.com>,
        Zubair Lutfullah <zubair.lutfullah@gmail.com>,
        Vignesh R <vigneshr@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Brad Griffis <bgriffis@ti.com>,
        Dario Binacchi <dariobin@libero.it>
Subject: [RESEND PATCH 3/3] input: ti_am335x_tsc: lower the X and Y sampling time
Date:   Sun, 12 Dec 2021 13:53:58 +0100
Message-Id: <20211212125358.14416-4-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211212125358.14416-1-dariobin@libero.it>
References: <20211212125358.14416-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfCr2tNHPJS5M42ZQsU6d1R66UV4G0n0glQqdeKDjfAiyeLTueeEPu2fSFu5P77D/aBTX8p44qql16w5nDlGsxoeoG5IUD4BWbixP9BIYI6DywAO78p4m
 9RifdIxgOv44xlkDzDu7JKcfVb7jU6d0TEDqGAGyVZr8z4YmGH9hZGCQrYNEwUA0txz76AEg19uczYTu9II3AZiNiYuMqlfRDszrHVC1sSDdVj7jqOZJqNxj
 J+6uVhJdEBiX0m26d+No8aHmOcbleXa1jW9q+GabG2FA2N+iIth3SeXGkN6H9jtps6lGIwZusGm5sogwGev9RcuRTB/4TLVsGe0c2Vjc3n5HzlurANqtzWmp
 5yg5WLI2/NLpth7wrPwAPM7o6076wRRD0VjVJSOagAlNNfz9wUl1TlniEiQ1GQ8zXNDfaVSjDwlZS3XG6sNH3yWObfedJ0APPYdS75WJ6ZlaslFV972rN+BR
 CiFyAgaWFZJkjNZa9O5KcAyc3FzI3iU4QeG0qT6bM0A/Bp7GtYrobs+cM6HIlGsfYqv3KBMzX7EBERMuP44hJPtORl4liJtVo7TvJJ5uS5PABFB1WCCF8VMO
 JI7AJ5ufkoXW2fRX/tXElkhQMgtXC97qSS50lj7VvPmKAy4meUC+E11Bs9w9LrRNzvs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The open delay time has to be applied only on the first sample of the
X/Y coordinates because on the following samples the ADC channel is not
changed. Removing this time from the samples after the first one,
"ti,coordinate-readouts" greater than 1, decreases the total acquisition
time, allowing to increase the number of acquired coordinates in the time
unit.

Signed-off-by: Dario Binacchi <dariobin@libero.it>

---

 drivers/input/touchscreen/ti_am335x_tsc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index cfc943423241..f4ef218bc1b8 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -126,7 +126,7 @@ static int titsc_config_wires(struct titsc *ts_dev)
 static void titsc_step_config(struct titsc *ts_dev)
 {
 	unsigned int	config;
-	int i;
+	int i, n;
 	int end_step, first_step, tsc_steps;
 	u32 stepenable;
 
@@ -151,9 +151,11 @@ static void titsc_step_config(struct titsc *ts_dev)
 	first_step = TOTAL_STEPS - tsc_steps;
 	/* Steps 16 to 16-coordinate_readouts is for X */
 	end_step = first_step + tsc_steps;
+	n = 0;
 	for (i = end_step - ts_dev->coordinate_readouts; i < end_step; i++) {
 		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
-		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
+		titsc_writel(ts_dev, REG_STEPDELAY(i),
+			     n++ == 0 ? STEPCONFIG_OPENDLY : 0);
 	}
 
 	config = 0;
@@ -175,9 +177,11 @@ static void titsc_step_config(struct titsc *ts_dev)
 
 	/* 1 ... coordinate_readouts is for Y */
 	end_step = first_step + ts_dev->coordinate_readouts;
+	n = 0;
 	for (i = first_step; i < end_step; i++) {
 		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
-		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
+		titsc_writel(ts_dev, REG_STEPDELAY(i),
+			     n++ == 0 ? STEPCONFIG_OPENDLY : 0);
 	}
 
 	/* Make CHARGECONFIG same as IDLECONFIG */
-- 
2.17.1

