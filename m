Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4055774E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiFWJ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiFWJ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:59:56 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6D248E7F;
        Thu, 23 Jun 2022 02:59:51 -0700 (PDT)
X-QQ-mid: bizesmtp81t1655978372tuh6nrgm
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 17:59:28 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: 3uawQE1sH+2f1013LW7NDUvhD5nitFHiWU9+7JLKgy188gCFOYzyMkSUotYzW
        ehfQtAdp1GDRZmZGmXW+sJ69XFawhcFNDYvfV9eg5blW931eIdSo84lGJKct8nvLWbJlr8B
        AaAxbDeKpcwyjSDulTa8XAM305s1qYz3/6XxeAo8d/RMeeFNYMxnn8xh1RkNPyWOY3gs7gt
        GBOl7iYfqiTA5OcdCUlQpVahGwtvKgKIdz9rrVY97nH1RPVoUgDna9vouK4wUHwAhN5qigF
        5amZqs9sK99qPNIn1oRm9x+w47EJ+W5tvojSr4jmwBwVmVRlpp81h9pK5J3uYxx7bnLy75L
        l0CmpHqjiB7C3K0RKdMBRtTIpiKlg==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     artur.paszkiewicz@intel.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: isci: drop unexpected word 'for' in comments
Date:   Thu, 23 Jun 2022 17:59:26 +0800
Message-Id: <20220623095926.23910-1-jiangjian@cdjrlc.com>
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

there is an unexpected word 'for' in the comments that need to be dropped

file - drivers/scsi/isci/remote_device.h
line - 214

 * @SCI_STP_DEV_CMD: This is the command state for for the STP remote

changed to:

 * @SCI_STP_DEV_CMD: This is the command state for the STP remote

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/isci/remote_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/remote_device.h b/drivers/scsi/isci/remote_device.h
index 3ad681c4c20a..268a3c851cb0 100644
--- a/drivers/scsi/isci/remote_device.h
+++ b/drivers/scsi/isci/remote_device.h
@@ -211,7 +211,7 @@ enum sci_status sci_remote_device_reset_complete(
  * device.  When there are no active IO for the device it is is in this
  * state.
  *
- * @SCI_STP_DEV_CMD: This is the command state for for the STP remote
+ * @SCI_STP_DEV_CMD: This is the command state for the STP remote
  * device.  This state is entered when the device is processing a
  * non-NCQ command.  The device object will fail any new start IO
  * requests until this command is complete.
-- 
2.17.1

