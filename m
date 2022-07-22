Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143B157DF36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiGVKCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiGVKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:02:22 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF77654642;
        Fri, 22 Jul 2022 03:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=v+9Gc
        lBRPLM9l1etqc5cavPYU+C0Wa8ZsFEC7RfS8js=; b=KBUX3ldk804NsyvRKTKOV
        l/0IS32cLurIIHr4P0l8qHLmMlwR+EYDJV/M4aKZEpIwy+FOFcMFGmcxouYLXSv9
        rtUJsl49f3lDBX6O8QHv5I4z5pTsphVoBhWHk2gkiMf4dGUqEeYJyfjgKwFCJAHP
        ZTlbGEd5j9o6aZd8fCys80=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp2 (Coremail) with SMTP id GtxpCgAXmPKnddpigztoQg--.22497S2;
        Fri, 22 Jul 2022 18:02:17 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     code@tyhicks.com
Cc:     linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] ecryptfs: keystore: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:02:12 +0800
Message-Id: <20220722100212.79490-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgAXmPKnddpigztoQg--.22497S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyfZw48Kw4kGryUArWxXrb_yoWfWFb_Ga
        y0qFWkt3s8KryFq3s5t3yrXr1S93y8tF4YgF43GrZFga45WrsF9Fn7Arnavr13uw43tws0
        9rs8Jryqv3ZIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt7KxJUUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAwZGZGB0LoTj4QAAsb
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
 fs/ecryptfs/keystore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 3fe41964c0d8..2452d6fd7062 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -878,7 +878,7 @@ struct ecryptfs_parse_tag_70_packet_silly_stack {
  * @filename: This function kmalloc's the memory for the filename
  * @filename_size: This function sets this to the amount of memory
  *                 kmalloc'd for the filename
- * @packet_size: This function sets this to the the number of octets
+ * @packet_size: This function sets this to the number of octets
  *               in the packet parsed
  * @mount_crypt_stat: The mount-wide cryptographic context
  * @data: The memory location containing the start of the tag 70
-- 
2.25.1

