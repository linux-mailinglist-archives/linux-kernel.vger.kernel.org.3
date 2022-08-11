Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D4858FE04
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiHKOFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbiHKOEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:04:34 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BC58981D;
        Thu, 11 Aug 2022 07:04:11 -0700 (PDT)
X-QQ-mid: bizesmtp84t1660226625tduidwys
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 22:03:44 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: 3qOr2y8T3jHiaJBKAvQ+jpJemwwPKU50gJHjzJdX164Fbz24WSo/Wg4smglYD
        OKfNISHknX2RIm80byjxtfGRb72Hgu+WlqMXUewRuXVFQO7D8eCWM2HKaFIwnQo8q5jOpgo
        CcaIIQLnSDHnPGrLJkypkhe/a7T4Ul/wxpeQZUYHr0Yx8UoINRDt6nhy0i9Y7uLyBhoSH7X
        hH+5brQ9k9VCSIJTFoInHjF9exQa74xW2pQMW9oTOzf4jGhIrqVMxnSXWX1gZjU387eCpGI
        SOQLFHQgMikreFBvTsKJq0EdKc0qyv8v5htAk94ixfjWdz262SGCFXX9y6faJ2LT0eKjPxJ
        tpe56vX3R8+W83cChJU0HEqSzkWSD4Ka6hqmHtf7mjDspawacI5wtBhRn/d1tHH9JYU3qUR
        wLFJzTGuyN8=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     wangborong@cdjrlc.com
Cc:     code@tyhicks.com, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ecryptfs: keystore: Fix comment typo
Date:   Thu, 11 Aug 2022 22:03:35 +0800
Message-Id: <20220811140335.32067-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
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

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.36.1

