Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9944DBCE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349296AbiCQCOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiCQCOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:14:10 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB68A188;
        Wed, 16 Mar 2022 19:12:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V7OwIyg_1647483171;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7OwIyg_1647483171)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 10:12:52 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     dhowells@redhat.com
Cc:     dwmw2@infradead.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] certs: Fix some kernel-doc comments
Date:   Thu, 17 Mar 2022 10:12:49 +0800
Message-Id: <20220317021249.31655-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

certs/system_keyring.c:46: warning: expecting prototype for
restrict_link_to_builtin_trusted(). Prototype was for
restrict_link_by_builtin_trusted() instead
certs/system_keyring.c:80: warning: This comment starts with '/**', but
isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 certs/system_keyring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 05b66ce9d1c9..f0eb8c680cac 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -34,7 +34,7 @@ extern __initconst const unsigned long system_certificate_list_size;
 extern __initconst const unsigned long module_cert_size;
 
 /**
- * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
+ * restrict_link_by_builtin_trusted - Restrict keyring addition by built in CA
  *
  * Restrict the addition of keys into a keyring based on the key-to-be-added
  * being vouched for by a key in the built in system keyring.
@@ -77,8 +77,9 @@ int restrict_link_by_builtin_and_secondary_trusted(
 }
 
 /**
- * Allocate a struct key_restriction for the "builtin and secondary trust"
- * keyring. Only for use in system_trusted_keyring_init().
+ * get_builtin_and_secondary_restriction - Allocate a struct key_restriction
+ * for the "builtin and secondary trust" keyring. Only for use in
+ * system_trusted_keyring_init().
  */
 static __init struct key_restriction *get_builtin_and_secondary_restriction(void)
 {
-- 
2.20.1.7.g153144c

