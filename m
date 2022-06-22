Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B348B5541B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356863AbiFVEZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356703AbiFVEY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:24:57 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF66435251;
        Tue, 21 Jun 2022 21:24:51 -0700 (PDT)
X-QQ-mid: bizesmtp81t1655871876tb10uhgc
Received: from ubuntu.localdomain ( [106.117.99.132])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 12:24:30 +0800 (CST)
X-QQ-SSF: 01000000000000B0B000000A0000000
X-QQ-FEAT: Mzskoac49OgAryltguf54BTqSvvea65kdojPEmwPiHx13EQ6QHezdUnLrya+a
        Ht5Hwr3feZ86ln16Bs05g0oKEO561Lv4rBECIQPUoQXm1McfrH+dVe5m9u8GcZKs7V1BXmN
        hAWHy7FXzvhNZybYkzeHJfsTdiG7mkwk1zGJIlVqJie9uFCENrfS+SNcth7ngKV/KTOk8xA
        aHAIVmxf20AAsPjY11USCNd85oGASkG6sUuOGgJ94HyL5zUFHu+68tmTQ3lxPYbWulZrQ+Y
        PnhjDco88yFGGPpW1uDF8yYvXcsAqzDMBdkhBTIFcdzs2G9niXZTo//7cM55IJQ9xEcXtAY
        llEDHw92kNsYonzRFY=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     artur.paszkiewicz@intel.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: isci: Remove duplicate 'the'
Date:   Wed, 22 Jun 2022 12:24:28 +0800
Message-Id: <20220622042428.11033-1-jiangjian@cdjrlc.com>
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

Fix an obvious typing error, found by spellcheck(1).

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
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

