Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88E4583F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbiG1MlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbiG1MlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:41:00 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973E0DE86;
        Thu, 28 Jul 2022 05:40:55 -0700 (PDT)
X-QQ-mid: bizesmtp72t1659012049t0a45982
Received: from localhost.localdomain ( [171.223.98.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 28 Jul 2022 20:40:47 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: 5x8Sgf4S6/huEDPjJNG3z1GKiV/wywwfCUT30L7c7L1oKWJNL1PAO/kx9au7p
        hn2juDzOXwqu9UPxt7g7zLhOHvprV/S6o4qnw3AB9KXO7WduySkvnG6BmpWGVxGm12D7Ihd
        t5sz2xe83ZGG1XoLcxJ3bSogMPPhd99smnp9/EbMugMtqJOcKIvlilAM1/RRecWONVIytgQ
        wZ5bliDImX2ZbtbEkbJASNIeycZeIFUCmoQZ76MvOQi+8L26Ymltuu3NloG4WG08i1ljs2F
        KILR4FaultrGeyeV4LM1Y18XP7CZ1YldMg9S6tH78WSWcmj37La3fUEQK0OE1U1WxLMzuec
        USJpCIzpVQ/OvAZ76Xd8JH0VrkEoab91MXnZ4j2hKyPjb4yc2VUsAjNVQcUKvfsty3jHQOn
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     wangborong@cdjrlc.com
Cc:     code@tyhicks.com, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ecryptfs: Fix comment typo
Date:   Mon, 25 Jul 2022 12:38:53 +0800
Message-Id: <20220725043853.7441-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
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
2.35.1

