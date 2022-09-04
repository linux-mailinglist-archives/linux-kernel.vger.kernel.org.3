Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE635AC660
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 22:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiIDUjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 16:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiIDUjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 16:39:14 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 500DA275C1
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 13:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hHJgr
        5wYhr6xRNrFQsZXLLIPlZg5J3cO6F0appWlrC4=; b=ll+PFt5LdejQ4kR3xS8fW
        wJ76cRSpjKKDgjKvcoBsPzngE1qO0VwjYecubwQGgGqXIrSgFbbX9MM1pmQUKnbP
        p1W6NYAAHlsjECEcP6QNC9FVgvNQ+0nD/vZx/MPBzTdDNjDcQanUm4gFrzjCK7+M
        Xa/tIW4ityfbn3RDjFYCrQ=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp12 (Coremail) with SMTP id EMCowAA37pK9DBVjKCHDJg--.22806S4;
        Mon, 05 Sep 2022 04:38:49 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] drm/print: cleanup coding style in drm_print.h
Date:   Mon,  5 Sep 2022 04:38:18 +0800
Message-Id: <20220904203818.16775-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAA37pK9DBVjKCHDJg--.22806S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw18GFy5Cr47Zry3uryDKFg_yoW8Ar48p3
        ZxJFyktr4qyr43Ww1qyF42yr1fX3yIgF1xXFZ7Kw1rAF1jva4v9wsYyryjkw1rWryxKF13
        JF9FyFyUuF9xArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEVyxJUUUUU=
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbBaRpyF1Xly05dGgAAsk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix everything checkpatch.pl complained about in drm_print.h

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 include/drm/drm_print.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 22fabdeed297..4332fbeb76a8 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright (C) 2016 Red Hat
  *
@@ -103,7 +104,7 @@ __printf(2, 0)
  * @va: the va_list
  */
 static inline void
-drm_vprintf(struct drm_printer *p, const char *fmt, va_list *va)
+drm_vprintf(struct drm_printer *p, const char *fmt, va_list * va)
 {
 	struct va_format vaf = { .fmt = fmt, .va = va };
 
@@ -426,16 +427,16 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 
 
 #define drm_info(drm, fmt, ...)					\
-	__drm_printk((drm), info,, fmt, ##__VA_ARGS__)
+	__drm_printk((drm), info, fmt, ##__VA_ARGS__)
 
 #define drm_notice(drm, fmt, ...)				\
-	__drm_printk((drm), notice,, fmt, ##__VA_ARGS__)
+	__drm_printk((drm), notice, fmt, ##__VA_ARGS__)
 
 #define drm_warn(drm, fmt, ...)					\
-	__drm_printk((drm), warn,, fmt, ##__VA_ARGS__)
+	__drm_printk((drm), warn, fmt, ##__VA_ARGS__)
 
 #define drm_err(drm, fmt, ...)					\
-	__drm_printk((drm), err,, "*ERROR* " fmt, ##__VA_ARGS__)
+	__drm_printk((drm), err, "*ERROR* " fmt, ##__VA_ARGS__)
 
 
 #define drm_info_once(drm, fmt, ...)				\

base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
prerequisite-patch-id: f039528bc88876d6e0f64e843da089e85f6d3f58
prerequisite-patch-id: c14ed2e970be2c3f8ba746634e8161b94c148e88
-- 
2.34.1

