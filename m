Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBC057DFF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiGVK2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiGVK1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:27:43 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61A88B5CA0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qQC00
        J2ytoScwDJfnGwwHCkrH+Wnn2YE/s/umhYNq4E=; b=UrnpfZOarczYTFjmVNrd+
        wxnXMc/h0ck23rFDbbyujEOUHUaTegaHDk7wNMPDu1gUedSXAf2gelLPIxzs6E9/
        dEiT4KpTYvvO6qH0eA1zV3TTwgqZabFrbMipONIyGOtRo0Nw7554+Z8iJAZC4Sm3
        52LZGZHMVOq2tU0t8WFcjE=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp5 (Coremail) with SMTP id HdxpCgCXx0tde9pi2W27Pg--.21652S2;
        Fri, 22 Jul 2022 18:26:39 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     Julia.Lawall@inria.fr, nicolas.palix@imag.fr
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] scripts: coccinelle: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:26:35 +0800
Message-Id: <20220722102635.81678-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgCXx0tde9pi2W27Pg--.21652S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyktr18ArWkCF1UKF1xKrg_yoWfKFgE93
        yxKry8CrW3Wan8KF48Jr4SqF4Ikw4xGr4IgwnxKF43Z34DurWY93W7JFy3Xw47Gw1DZFyf
        ur90va4ayw17KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtxRh3UUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAwZGZGB0LoUtEQAAsk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 scripts/coccinelle/misc/badty.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/badty.cocci b/scripts/coccinelle/misc/badty.cocci
index ed3e0b8f3b1a..e3530cade156 100644
--- a/scripts/coccinelle/misc/badty.cocci
+++ b/scripts/coccinelle/misc/badty.cocci
@@ -4,7 +4,7 @@
 //# This makes an effort to find cases where the argument to sizeof is wrong
 //# in memory allocation functions by checking the type of the allocated memory
 //# when it is a double pointer and ensuring the sizeof argument takes a pointer
-//# to the the memory being allocated. There are false positives in cases the
+//# to the memory being allocated. There are false positives in cases the
 //# sizeof argument is not used in constructing the return value. The result
 //# may need some reformatting.
 //
-- 
2.25.1

