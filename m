Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826CD57911B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 05:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiGSDE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 23:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiGSDEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 23:04:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787183AB34;
        Mon, 18 Jul 2022 20:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08E01B8186C;
        Tue, 19 Jul 2022 03:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8937EC341C0;
        Tue, 19 Jul 2022 03:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658199888;
        bh=EMcEye5HY7kEpDggDR5ZLX2uR9NgtH945FPI9JMyOHw=;
        h=From:To:Cc:Subject:Date:From;
        b=eec7IRTjZwOGISMW8RhNu0tZKtNXJTl8dit29OBV0oNZoUuAvIi40jLHP4jb9tQjn
         CjZFLRUa/yJBtzYnmPIE7lf3FMFYye7XmeDpcVHfWgMR+gXdgHrLYb5raG1Oa2mYDk
         qm8EU1+AyiD/Pnd5kyuACZ/vE9NHNUfN/yWnMYsFmQGsBf1SMuAhB69VfFuBcwi4Yt
         81ZE14ZrApPzXn9csKVOkpQBD6vhyOabT1V6lrcS1VgKV9LCC1fmOfqP40cHjSeIpg
         2g5xxyQACUzRFF7Swz+XM/2eCV0aFKVbWhkImmJbnURGpEYW2PkOTDMteKdQEwA2fS
         6sB+3vzF4n2Rw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] crypto: lib - add module license to libsha1
Date:   Mon, 18 Jul 2022 20:04:15 -0700
Message-Id: <20220719030415.32113-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

libsha1 can be a module, so it needs a MODULE_LICENSE.

Fixes: ec8f7f4821d5 ("crypto: lib - make the sha1 library optional")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/crypto/sha1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
index 0494766fc574ec..1aebe7be9401bd 100644
--- a/lib/crypto/sha1.c
+++ b/lib/crypto/sha1.c
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/module.h>
 #include <linux/bitops.h>
 #include <linux/string.h>
 #include <crypto/sha1.h>
@@ -135,3 +136,5 @@ void sha1_init(__u32 *buf)
 	buf[4] = 0xc3d2e1f0;
 }
 EXPORT_SYMBOL(sha1_init);
+
+MODULE_LICENSE("GPL");

base-commit: ec8f7f4821d5e70d71601519bc2325b311324a96
-- 
2.37.0

