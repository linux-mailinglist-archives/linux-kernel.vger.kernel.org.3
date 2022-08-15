Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAB8592D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiHOKci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHOKcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:32:35 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3257D2181E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:32:34 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id 7mYX2800T4C55Sk06mYXFx; Mon, 15 Aug 2022 12:32:31 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oNXOZ-0019aL-78; Mon, 15 Aug 2022 12:32:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oNXOY-00C0OL-IA; Mon, 15 Aug 2022 12:32:30 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v6.0-rc1
Date:   Mon, 15 Aug 2022 12:32:29 +0200
Message-Id: <01a6abf7bc23a478d6a6c6801c6812ae96714620.1660559393.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Enable modular build of the new HCTR2 and ARIA crypto algorithms,
  - Drop CONFIG_CRYPTO_BLAKE2S=m (removed in commit 2d16803c562ecc64
    ("crypto blake2s - remove shash module")).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k for-v6.1 branch.

 arch/m68k/configs/amiga_defconfig    | 3 ++-
 arch/m68k/configs/apollo_defconfig   | 3 ++-
 arch/m68k/configs/atari_defconfig    | 3 ++-
 arch/m68k/configs/bvme6000_defconfig | 3 ++-
 arch/m68k/configs/hp300_defconfig    | 3 ++-
 arch/m68k/configs/mac_defconfig      | 3 ++-
 arch/m68k/configs/multi_defconfig    | 3 ++-
 arch/m68k/configs/mvme147_defconfig  | 3 ++-
 arch/m68k/configs/mvme16x_defconfig  | 3 ++-
 arch/m68k/configs/q40_defconfig      | 3 ++-
 arch/m68k/configs/sun3_defconfig     | 3 ++-
 arch/m68k/configs/sun3x_defconfig    | 3 ++-
 12 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index a6a886a89be28382..1e545592ece66309 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -573,9 +573,9 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
+CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
@@ -594,6 +594,7 @@ CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
+CONFIG_CRYPTO_ARIA=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4_GENERIC=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index bffd24c2755e7117..8b3c02455f13e1c3 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -530,9 +530,9 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
+CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
@@ -551,6 +551,7 @@ CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
+CONFIG_CRYPTO_ARIA=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4_GENERIC=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 97a6df6822f0f23f..217e286c2a760607 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -561,9 +561,9 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
+CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
@@ -582,6 +582,7 @@ CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
+CONFIG_CRYPTO_ARIA=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4_GENERIC=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 42d969697f7f0352..083cbb179e708e1b 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -522,9 +522,9 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
+CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
@@ -543,6 +543,7 @@ CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
+CONFIG_CRYPTO_ARIA=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4_GENERIC=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 97d6d9acb39520ab..291e250d843deefe 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -532,9 +532,9 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
+CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
@@ -553,6 +553,7 @@ CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
+CONFIG_CRYPTO_ARIA=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4_GENERIC=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 8cbfc1c659a311b6..815ff8d9a65e4240 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -552,9 +552,9 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
+CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
@@ -573,6 +573,7 @@ CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
+CONFIG_CRYPTO_ARIA=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4_GENERIC=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 9f45fe60757fab1c..5c84db94f9e11153 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -638,9 +638,9 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
+CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
@@ -659,6 +659,7 @@ CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
+CONFIG_CRYPTO_ARIA=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4_GENERIC=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 4736cfacf6a2801c..0a2df9102b8e8404 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -521,9 +521,9 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
+CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
@@ -542,6 +542,7 @@ CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
+CONFIG_CRYPTO_ARIA=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4_GENERIC=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 638cd38aa7d27303..951d37effb0cedff 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -522,9 +522,9 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
+CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
@@ -543,6 +543,7 @@ CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
+CONFIG_CRYPTO_ARIA=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4_GENERIC=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index ec8b6bb70ebdcaf3..258001e059baac3a 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -539,9 +539,9 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
+CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
@@ -560,6 +560,7 @@ CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
+CONFIG_CRYPTO_ARIA=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4_GENERIC=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 7d8dc578d59c6ffb..eea582f0e4dc57f1 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -521,9 +521,9 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
+CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
@@ -542,6 +542,7 @@ CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
+CONFIG_CRYPTO_ARIA=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4_GENERIC=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 96290aee530211e3..d2c857cf74b8c99f 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -520,9 +520,9 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
+CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
@@ -541,6 +541,7 @@ CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
+CONFIG_CRYPTO_ARIA=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4_GENERIC=m
 CONFIG_CRYPTO_TEA=m
-- 
2.25.1

