Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82784E8316
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 18:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiCZRta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 13:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiCZRt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 13:49:29 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Mar 2022 10:47:51 PDT
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4296C36B56;
        Sat, 26 Mar 2022 10:47:51 -0700 (PDT)
Received: from localhost (h252.183.30.69.ip.windstream.net [69.30.183.252])
        by vultr.guest (OpenSMTPD) with ESMTPSA id 915f4e9a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 26 Mar 2022 17:21:10 +0000 (UTC)
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Subject: [PATCH] crypto: aes_generic: fixed styling warnings
Date:   Sat, 26 Mar 2022 12:20:51 -0500
Message-Id: <20220326172051.14722-1-thepaulodoom@thepaulodoom.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all styling warnings from the checkpatch.pl script.

Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
---
 crypto/aes_generic.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/crypto/aes_generic.c b/crypto/aes_generic.c
index 27ab27931..322e345ac 100644
--- a/crypto/aes_generic.c
+++ b/crypto/aes_generic.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Cryptographic API.
  *
@@ -56,7 +57,7 @@
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
-static inline u8 byte(const u32 x, const unsigned n)
+static inline u8 byte(const u32 x, const unsigned int n)
 {
 	return x >> (n << 3);
 }
@@ -325,6 +326,7 @@ __visible const u32 crypto_ft_tab[4][256] ____cacheline_aligned = {
 		0x7bcbb0b0, 0xa8fc5454, 0x6dd6bbbb, 0x2c3a1616,
 	}
 };
+EXPORT_SYMBOL_GPL(crypto_ft_tab);
 
 static const u32 crypto_fl_tab[4][256] ____cacheline_aligned = {
 	{
@@ -853,6 +855,7 @@ __visible const u32 crypto_it_tab[4][256] ____cacheline_aligned = {
 		0x7b6184cb, 0xd570b632, 0x48745c6c, 0xd04257b8,
 	}
 };
+EXPORT_SYMBOL_GPL(crypto_it_tab);
 
 static const u32 crypto_il_tab[4][256] ____cacheline_aligned = {
 	{
@@ -1118,8 +1121,6 @@ static const u32 crypto_il_tab[4][256] ____cacheline_aligned = {
 	}
 };
 
-EXPORT_SYMBOL_GPL(crypto_ft_tab);
-EXPORT_SYMBOL_GPL(crypto_it_tab);
 
 /**
  * crypto_aes_set_key - Set the AES key.
@@ -1144,34 +1145,34 @@ EXPORT_SYMBOL_GPL(crypto_aes_set_key);
 
 /* encrypt a block of text */
 
-#define f_rn(bo, bi, n, k)	do {				\
+#define f_rn(bo, bi, n, k)	while (0) {				\
 	bo[n] = crypto_ft_tab[0][byte(bi[n], 0)] ^			\
 		crypto_ft_tab[1][byte(bi[(n + 1) & 3], 1)] ^		\
 		crypto_ft_tab[2][byte(bi[(n + 2) & 3], 2)] ^		\
 		crypto_ft_tab[3][byte(bi[(n + 3) & 3], 3)] ^ *(k + n);	\
-} while (0)
+}
 
-#define f_nround(bo, bi, k)	do {\
+#define f_nround(bo, bi, k)	while (0) {\
 	f_rn(bo, bi, 0, k);	\
 	f_rn(bo, bi, 1, k);	\
 	f_rn(bo, bi, 2, k);	\
 	f_rn(bo, bi, 3, k);	\
 	k += 4;			\
-} while (0)
+}
 
-#define f_rl(bo, bi, n, k)	do {				\
+#define f_rl(bo, bi, n, k)	while (0) {				\
 	bo[n] = crypto_fl_tab[0][byte(bi[n], 0)] ^			\
 		crypto_fl_tab[1][byte(bi[(n + 1) & 3], 1)] ^		\
 		crypto_fl_tab[2][byte(bi[(n + 2) & 3], 2)] ^		\
 		crypto_fl_tab[3][byte(bi[(n + 3) & 3], 3)] ^ *(k + n);	\
-} while (0)
+}
 
-#define f_lround(bo, bi, k)	do {\
+#define f_lround(bo, bi, k)	while (0) {\
 	f_rl(bo, bi, 0, k);	\
 	f_rl(bo, bi, 1, k);	\
 	f_rl(bo, bi, 2, k);	\
 	f_rl(bo, bi, 3, k);	\
-} while (0)
+}
 
 static void crypto_aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
@@ -1214,12 +1215,12 @@ static void crypto_aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 
 /* decrypt a block of text */
 
-#define i_rn(bo, bi, n, k)	do {				\
+#define i_rn(bo, bi, n, k)	while (0) {				\
 	bo[n] = crypto_it_tab[0][byte(bi[n], 0)] ^			\
 		crypto_it_tab[1][byte(bi[(n + 3) & 3], 1)] ^		\
 		crypto_it_tab[2][byte(bi[(n + 2) & 3], 2)] ^		\
 		crypto_it_tab[3][byte(bi[(n + 1) & 3], 3)] ^ *(k + n);	\
-} while (0)
+}
 
 #define i_nround(bo, bi, k)	do {\
 	i_rn(bo, bi, 0, k);	\
@@ -1229,19 +1230,19 @@ static void crypto_aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 	k += 4;			\
 } while (0)
 
-#define i_rl(bo, bi, n, k)	do {			\
+#define i_rl(bo, bi, n, k)	while (0) {			\
 	bo[n] = crypto_il_tab[0][byte(bi[n], 0)] ^		\
 	crypto_il_tab[1][byte(bi[(n + 3) & 3], 1)] ^		\
 	crypto_il_tab[2][byte(bi[(n + 2) & 3], 2)] ^		\
 	crypto_il_tab[3][byte(bi[(n + 1) & 3], 3)] ^ *(k + n);	\
-} while (0)
+}
 
-#define i_lround(bo, bi, k)	do {\
+#define i_lround(bo, bi, k)	while (0) {\
 	i_rl(bo, bi, 0, k);	\
 	i_rl(bo, bi, 1, k);	\
 	i_rl(bo, bi, 2, k);	\
 	i_rl(bo, bi, 3, k);	\
-} while (0)
+}
 
 static void crypto_aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
-- 
2.35.1

