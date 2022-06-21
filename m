Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB822553139
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349874AbiFULmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349833AbiFULmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:42:38 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B22A957;
        Tue, 21 Jun 2022 04:42:31 -0700 (PDT)
X-QQ-mid: bizesmtp72t1655811736t7wkv7nq
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 19:42:09 +0800 (CST)
X-QQ-SSF: 0100000000700040B000B00A0000000
X-QQ-FEAT: DHpJGCbtM4lICSNFBNVdjybKrnpM588n5nlL6Rb4WccsMqZ/UPLBb1S4Jhs4f
        /JeFQNDSrB0a/cLH66lcu6kOlIyqLGm1S7MD4AREgyXqpnx+hx16q881NCm4oO5M5aHR+7x
        dhxI6Ds6xhXV2fHfBTnwzGMUB5T0j+YrycQg5+VOWIBBv8nI5TJ2nw2QdkLYAWSNLeISVCw
        UFHH78RV+uSBC2jot60nEwQOTGn3RlXoyAyaBlLxDSk+7BxiCDZsXCytCaMJ9CixgJ1VQc+
        4E6QMfpc1lt5eG0STFY4Zc1yWZpZvwTBPB16otzKM/sps1L5+22m8dWHnAHGsPsz8ckp0M/
        1T6z9Bz+tf0mAbdpC+fGrgRq7+BEQ==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     maier@linux.ibm.com, bblock@linux.ibm.com
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: zfcp: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 19:42:07 +0800
Message-Id: <20220621114207.106405-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: ./drivers/s390/scsi/zfcp_diag.h
line: 5
* Definitions for handling diagnostics in the the zfcp device driver.
changed to
* Definitions for handling diagnostics in the zfcp device driver.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/s390/scsi/zfcp_diag.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_diag.h b/drivers/s390/scsi/zfcp_diag.h
index da55133da8fe..15c25fefe91a 100644
--- a/drivers/s390/scsi/zfcp_diag.h
+++ b/drivers/s390/scsi/zfcp_diag.h
@@ -2,7 +2,7 @@
 /*
  * zfcp device driver
  *
- * Definitions for handling diagnostics in the the zfcp device driver.
+ * Definitions for handling diagnostics in the zfcp device driver.
  *
  * Copyright IBM Corp. 2018, 2020
  */
-- 
2.17.1

