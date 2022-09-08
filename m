Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABF55B1CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiIHMZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiIHMYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:24:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189132F3BC;
        Thu,  8 Sep 2022 05:24:39 -0700 (PDT)
X-QQ-mid: bizesmtp91t1662639866twn5qpkl
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:24:24 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: D6RqbDSxuq4EWm4mj5Jkr816U6oKErZvKJVT9g0PL9ZWubgTTrxBT3LbAyMmH
        vynW1jFrMl8b8c/DR1z7uLgLtqssN+oJxi0ReeIL9+CIb/caGIvaGN3xCtb3iK8qzywac4E
        IR2ymYZXfjSbC6kfcTx+CDZf7z92KYfnpqf0kceq0eAoFaxgEvHvbszZC1ebaGjmGdQgho5
        xd5bX+rcc0RD3Su2TPukh46CLi0KwKF51cOiOUdLZiys/ES7f0eL0hdcW4ZSCVQRHg4wplD
        SGk+cg46eLnpMic/kULVwIyQpESsyahHXC2ar/yS4c1OOtMdUq6ysz2yMdHaNwLmNnWQkP2
        m7v+/Qn6gkfiWtjB+WlNaM808DIVK8KPWkQ8KEK1ngIJ7u1d8/R7vzrA5X//w==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     oliver@neukum.org, aliakc@web.de, lenehan@twibble.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     dc395x@twibble.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/scsi: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:24:18 +0800
Message-Id: <20220908122418.11728-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/scsi/dc395x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 670a836a6ba1..aea82007dd61 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -4226,7 +4226,7 @@ static void adapter_init_params(struct AdapterCtlBlk *acb)
  * values that we have already stored in the adapter instance. There's
  * some mention that a lot of these are deprecated, so we won't use
  * them (we'll use the ones in the adapter instance) but we'll fill
- * them in in case something else needs them.
+ * them in case something else needs them.
  *
  * The eeprom structure, irq and io ports in the adapter need to have
  * been set before calling this function.
-- 
2.36.1

