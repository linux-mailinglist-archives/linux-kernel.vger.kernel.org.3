Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5925657D066
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiGUP4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGUP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:56:00 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04183AE42
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:55:53 -0700 (PDT)
X-QQ-mid: bizesmtp68t1658418939tni39y8y
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2022 23:55:21 +0800 (CST)
X-QQ-SSF: 01000000002000409000B00A0000000
X-QQ-FEAT: bhet8yMU7vn5WdIbn+X4cwVFm4ZE5gYnlE5WclUheQpQIDmCR7sr8HZ92xmLa
        YQpKQwuR1xb60fTBSgGlPhLcsOaT09JDi42x+wDJwZbpyYHkWUBp7daxk+NmJJWrfVs2x/3
        oq78PdcA2A8CUanpytwrzeAuA5IUjnc53CP+84foaSDF2FBxGneUH6xuKyWDW9YTkdQbMp2
        rEWmHn39Ua8Bfsr/Lp7k3kl0Mj8zRt66nAgl5fEfqYBotIkPnTKRsQzB32yunZkK2AStgiD
        /MN7S+RH6Z3k9ZuH9vdPfMeGZQIEcq0OoHvRU73ElwSOtvtKi2yd8SfaQf/BlMB4VlGaQMG
        Eu+Le5gFGO4pwAK2YQIn225E4VAm1Kgp+WDGEFT+Vu/z7wfcRB4Aj9C9EyjYLJ/SLYuxAim
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] ALSA: asihpi: Fix typo in comments
Date:   Thu, 21 Jul 2022 11:55:17 -0400
Message-Id: <20220721155517.2438-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "in" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 sound/pci/asihpi/hpi6205.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index 3d6914c64c4a..27e11b5f70b9 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -445,7 +445,7 @@ void HPI_6205(struct hpi_message *phm, struct hpi_response *phr)
 /* SUBSYSTEM */
 
 /** Create an adapter object and initialise it based on resource information
- * passed in in the message
+ * passed in the message
  * *** NOTE - you cannot use this function AND the FindAdapters function at the
  * same time, the application must use only one of them to get the adapters ***
  */
-- 
2.35.1

