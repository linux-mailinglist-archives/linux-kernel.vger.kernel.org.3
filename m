Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDA95542E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiFVGRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiFVGRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:17:15 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130F5140DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:17:07 -0700 (PDT)
X-QQ-mid: bizesmtp71t1655878489t5m2g26e
Received: from ubuntu.localdomain ( [106.117.99.132])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 14:14:43 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000C00A0000000
X-QQ-FEAT: JuPszP98+7oSFkGdit87xSSuthfvabXG8jBovL2UEHgso+gkyvguvO+O5DK5j
        A8Z4q55VdYjOlcPp+YOB5japIP9f07MK9eMmOondf3jq/q/t7MCWLu6wesJBncrH6WUGnqd
        5RcjTRlwqQSfJj1TDTyeTSVEPOINf0tFdCOzyyuPJwCqzKYPV7Lw6qp+AKIo50gqbmisNIb
        wHP4ywNsEi0+xgzUNrmvpvA2Jkd5RAF2dyJzUm7Bkt/7x3CzOM7SdlzCn/XtTr2LeUcj0ra
        HoJwOutPmQC015/fxPQ8EJjcEVjTLdHsGgtxO5h+7o/B/NEd+14CGVA7hqgayayXk5P4FDq
        DothxHCZC47r7D5Mm0=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     bleung@chromium.org
Cc:     jiangjian@cdjrlc.com, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: wilco_ec: event: Fix typo in comment
Date:   Wed, 22 Jun 2022 14:14:42 +0800
Message-Id: <20220622061442.18242-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the redundant word 'the'.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/platform/chrome/wilco_ec/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index 814518509739..32e400590be5 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -343,7 +343,7 @@ static __poll_t event_poll(struct file *filp, poll_table *wait)
  *
  * Removes the first event from the queue, places it in the passed buffer.
  *
- * If there are no events in the the queue, then one of two things happens,
+ * If there are no events in the queue, then one of two things happens,
  * depending on if the file was opened in nonblocking mode: If in nonblocking
  * mode, then return -EAGAIN to say there's no data. If in blocking mode, then
  * block until an event is available.
-- 
2.17.1


