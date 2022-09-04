Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806795AC52E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiIDQAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIDQAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:00:15 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B232018380
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 09:00:10 -0700 (PDT)
X-QQ-mid: bizesmtp71t1662307204tg1p7zau
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Sep 2022 00:00:00 +0800 (CST)
X-QQ-SSF: 01000000000000C0C000000A0000000
X-QQ-FEAT: dQMYTUiNPs4GZP4ff+PF3OOEvcCvjgfBk/Uvdu9ipU79IPygTUuzAWeUtVp+U
        ACfyyMWt76A0gXK0oRd1a+88lXNUhYe6auW/APNz0OdsAhdaePoRK3aOvfglmHu64e1+KMQ
        cYg1VClZWCDB6H4O9qHbLFpvyTs+gbZFJTYdFaG8V8y7p0+25VU9Hel+YcxMhMD814NX+WJ
        7olXfGKcwYvtpZ25UW9ZmZIT3cuEKOtXbaHeDwNeWoaLVdpWGdvbuZaGRX+jp7KGkiR2NnJ
        HU/8kxhs5DEp0+MaPz+gaWuGq0LnPraMyjOb0ZhtVLmSxWSb2iejT6o4bTNlLLkqgL4MUfd
        RNOjRAwprxYnLIBMa4=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     airlied@linux.ie, linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] agp/intel: Fix double word in comments
Date:   Sun,  4 Sep 2022 12:00:00 -0400
Message-Id: <20220904160000.29746-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "require" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/char/agp/intel-gtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index bf6716ff863b..89bd810c3a39 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -568,7 +568,7 @@ static void intel_gtt_cleanup(void)
 	intel_gtt_teardown_scratch_page();
 }
 
-/* Certain Gen5 chipsets require require idling the GPU before
+/* Certain Gen5 chipsets require idling the GPU before
  * unmapping anything from the GTT when VT-d is enabled.
  */
 static inline int needs_ilk_vtd_wa(void)
-- 
2.35.1

