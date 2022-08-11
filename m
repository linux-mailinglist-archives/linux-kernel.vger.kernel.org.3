Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0290B58FF13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiHKPRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiHKPQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:16:59 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F0661D6B;
        Thu, 11 Aug 2022 08:16:57 -0700 (PDT)
X-QQ-mid: bizesmtp90t1660231001t0xm8mw2
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 23:16:34 +0800 (CST)
X-QQ-SSF: 0100000000200080H000B00A0000020
X-QQ-FEAT: eSZ1CZgv+JCwTB9Wg85cnslhA6pu5r4Mf+y8fjYXssxcQYaEHki9jZ0JHkRrd
        6ARfL5d/bYQIH1phNBc6ideDH85m++WkR9GDf6+VB9q9+ioHR/OjL5D/lNXdv+dNQkEdjm/
        BmibYsW7Eb+JsnSy/pgvPK3ii0oIDV+mjcnRfUCSbCJfVH6LCYtfKyIwzxCvynjY2G/dfNj
        M4eMmdn54zPBgQK7Kz+ipkVS8AMbAIFVY8MXJR+9ciUywxj1JVdK4AEHAsodkK3nBwqp4sf
        ZSFrUWJd2Rdz7LVcxRx+CzIDGclMCnuExGUujuNlASJBwgHRHClWkryvw9KtQIkxdIJ/dsc
        N4+FekpKK9+zxwKfI2S5FT6qEp3LDD1gKntgbU8jETOW6mGOlrCSU0tShgbeOePO7GVm3Dd
        PYbaU3ltohI=
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     artur.paszkiewicz@intel.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, min tang <tangmin@cdjrlc.com>
Subject: [PATCH] isci: Fix comment typo
Date:   Thu, 11 Aug 2022 23:16:22 +0800
Message-Id: <20220811151622.12825-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
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

The double `the' is duplicated in line 157, remove one.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 drivers/scsi/isci/remote_node_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/remote_node_context.h b/drivers/scsi/isci/remote_node_context.h
index c7ee81d01125..f22950b12b8b 100644
--- a/drivers/scsi/isci/remote_node_context.h
+++ b/drivers/scsi/isci/remote_node_context.h
@@ -154,7 +154,7 @@ enum sci_remote_node_context_destination_state {
 /**
  * struct sci_remote_node_context - This structure contains the data
  *    associated with the remote node context object.  The remote node context
- *    (RNC) object models the the remote device information necessary to manage
+ *    (RNC) object models the remote device information necessary to manage
  *    the silicon RNC.
  */
 struct sci_remote_node_context {
-- 
2.17.1

