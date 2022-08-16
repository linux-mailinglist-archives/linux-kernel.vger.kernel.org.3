Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEE15961E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiHPSFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbiHPSFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:05:09 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3078F6F547;
        Tue, 16 Aug 2022 11:05:08 -0700 (PDT)
X-QQ-mid: bizesmtp77t1660673091torkwan0
Received: from harry-jrlc.. ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 17 Aug 2022 02:04:39 +0800 (CST)
X-QQ-SSF: 0100000000000060D000B00A0000020
X-QQ-FEAT: xqT8U4SkSpjAjVG76KbLvDD5cIIcr9xQkN252TAQvbnthflc8upl4tvZZXqNY
        o2sd2HLh3srsWNxNvuNTmQnG4Nz/+VHGMwTuUaW/5J8KkRSozrR9rIJ42sxT+gUNAJZnEOY
        KFSZLYt4xZUDSUE7CU3+BQmwhmu30zVktSKS+ag4jObH8/+Nmmm89UOOYBRhm62J6OjndTF
        4PoxZzG/Kr3s2PyOYulXSnFBveQRERz+kSk/laiFIEiioWe3J4Ie0v6/K5Pz82QCugnIjg2
        sWwRXKVFVBtjGA3iOmq4Lmw7VWcvO50Rxgdr80BTXfBJUrmVUtFf2IAfBMbJwe78d8/dNBB
        8itEJxGLmIQmFlqTxSayYo0HYGuhxwXsUPDqrmWPoMtwBGYIu69xTMTHRsDFA==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     dhowells@redhat.com, jarkko@kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] keys: Variable type completion
Date:   Wed, 17 Aug 2022 02:04:38 +0800
Message-Id: <20220816180438.8807-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' is better than 'unsigned'.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 security/keys/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index 3c90807476eb..433a96e26930 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -13,7 +13,7 @@
 /*
  * Delay between key revocation/expiry in seconds
  */
-unsigned key_gc_delay = 5 * 60;
+unsigned int key_gc_delay = 5 * 60;
 
 /*
  * Reaper for unused keys.
-- 
2.30.2

