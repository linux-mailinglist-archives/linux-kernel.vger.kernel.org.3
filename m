Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C544ABF81
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448807AbiBGNNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448451AbiBGNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:11:36 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF506C0401CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:11:26 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8923:c5e0:fe66:f22f])
        by albert.telenet-ops.be with bizsmtp
        id sDBQ2600e2zxJMx06DBQgw; Mon, 07 Feb 2022 14:11:25 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nH3ng-0004SN-Ge; Mon, 07 Feb 2022 14:11:24 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nH3ng-009F9I-1I; Mon, 07 Feb 2022 14:11:24 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Sam Creasey <sammy@sammy.net>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Disable fbdev on Sun3/3x
Date:   Mon,  7 Feb 2022 14:11:23 +0100
Message-Id: <20220207131123.2203141-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
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

Commit e019630e78e3482c ("[PATCH] remove broken video drivers") in
v2.6.21 removed Sun3 framebuffer support, hence there are no more frame
buffer device drivers available on the Sun3 and Sun3x platforms.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/configs/sun3_defconfig  | 3 ---
 arch/m68k/configs/sun3x_defconfig | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index f214f277c55a18a1..db6769790bdb600c 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -385,9 +385,6 @@ CONFIG_NTP_PPS=y
 CONFIG_PPS_CLIENT_LDISC=m
 CONFIG_PTP_1588_CLOCK=m
 # CONFIG_HWMON is not set
-CONFIG_FB=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_LOGO=y
 CONFIG_HID=m
 CONFIG_HIDRAW=y
 CONFIG_UHID=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 73b4c61394a2a306..e9c362683666ab48 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -384,9 +384,6 @@ CONFIG_NTP_PPS=y
 CONFIG_PPS_CLIENT_LDISC=m
 CONFIG_PTP_1588_CLOCK=m
 # CONFIG_HWMON is not set
-CONFIG_FB=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_LOGO=y
 CONFIG_HID=m
 CONFIG_HIDRAW=y
 CONFIG_UHID=m
-- 
2.25.1

