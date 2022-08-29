Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5047E5A46AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiH2KAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiH2KAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:00:46 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B781E0C5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:00:44 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id DN0h2800E4C55Sk01N0iWy; Mon, 29 Aug 2022 12:00:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oSbZR-0036s9-I1; Mon, 29 Aug 2022 12:00:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oSbZQ-000IaT-VG; Mon, 29 Aug 2022 12:00:40 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v6.0-rc2
Date:   Mon, 29 Aug 2022 12:00:39 +0200
Message-Id: <1fbe623e5d69bdce0352445c06e1b2c9fb8d123e.1661767119.git.geert@linux-m68k.org>
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

  - Drop CONFIG_NF_CONNTRACK_PROCFS=n (no longer auto-enabled since
    commit aa5762c34213aba7 ("netfilter: conntrack: NF_CONNTRACK_PROCFS
    should no longer default to y").

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be combined with "m68k: defconfig: Update defconfigs for v6.0-rc1".
---
 arch/m68k/configs/amiga_defconfig    | 1 -
 arch/m68k/configs/apollo_defconfig   | 1 -
 arch/m68k/configs/atari_defconfig    | 1 -
 arch/m68k/configs/bvme6000_defconfig | 1 -
 arch/m68k/configs/hp300_defconfig    | 1 -
 arch/m68k/configs/mac_defconfig      | 1 -
 arch/m68k/configs/multi_defconfig    | 1 -
 arch/m68k/configs/mvme147_defconfig  | 1 -
 arch/m68k/configs/mvme16x_defconfig  | 1 -
 arch/m68k/configs/q40_defconfig      | 1 -
 arch/m68k/configs/sun3_defconfig     | 1 -
 arch/m68k/configs/sun3x_defconfig    | 1 -
 12 files changed, 12 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 1e545592ece66309..e2038d9499e479cd 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -84,7 +84,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CONNTRACK_PROCFS is not set
 # CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 8b3c02455f13e1c3..ddd201259e43a95a 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -80,7 +80,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CONNTRACK_PROCFS is not set
 # CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 217e286c2a760607..66a5dbd8bd428a33 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -87,7 +87,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CONNTRACK_PROCFS is not set
 # CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 083cbb179e708e1b..68957c6bcff1a1be 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -77,7 +77,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CONNTRACK_PROCFS is not set
 # CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 291e250d843deefe..825c6a02fa9d102f 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -79,7 +79,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CONNTRACK_PROCFS is not set
 # CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 815ff8d9a65e4240..17f64c562bf119e8 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -78,7 +78,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CONNTRACK_PROCFS is not set
 # CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 5c84db94f9e11153..f5f4c572b6949698 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -98,7 +98,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CONNTRACK_PROCFS is not set
 # CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 0a2df9102b8e8404..b4a0bbef7e39b490 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -76,7 +76,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CONNTRACK_PROCFS is not set
 # CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 951d37effb0cedff..c6a6d59267934021 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -77,7 +77,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CONNTRACK_PROCFS is not set
 # CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 258001e059baac3a..49c9c89f0caf76ee 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -78,7 +78,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CONNTRACK_PROCFS is not set
 # CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index eea582f0e4dc57f1..9b44eeb9c07f7aa9 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -74,7 +74,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CONNTRACK_PROCFS is not set
 # CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index d2c857cf74b8c99f..d2ffb0a65b44ac47 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -74,7 +74,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CONNTRACK_PROCFS is not set
 # CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
-- 
2.25.1

