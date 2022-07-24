Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972C357F377
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 08:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiGXGgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 02:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGXGgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 02:36:53 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657D112AF8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 23:36:48 -0700 (PDT)
X-QQ-mid: bizesmtp67t1658644601tkl5cgze
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 14:36:39 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: pMuUV8CkajyAwxb04UR3teIl64cORv4dI27JtmKUzGBNHrZxAwSQdtHocO9Rz
        g7ICb4BEKkgo0J9uxL0Qbi1rImRGnmz0t7S0VlDrg7g5JGYnmLqGulkr5OW0LEau2wDBjfY
        Bz4Ji+Onp0E+lUDCXdNsSfKiPFLlRA+0MJLEDi4oyRb7WsJLGdKjRPKpP1/qJz9DI/pRdB2
        J/X52hzmykvV/g8UYMQsi2RSAk448IGQztjeJnOB4mw7ilN96BROndtbBWLEJoFfJYz8nCy
        cQEtpu6DZcvsARV1IHmvfc5F+epzBmyVOIMvrI9hA0evitptnGpCj1Yyo0Y01OZ9U0rFk84
        4K7ViZ2ZsvI8YDyedYioN9pVk0qZPdAJ1r+NMaH
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] powerpc/mm: fix repeated words in comments
Date:   Sun, 24 Jul 2022 14:36:22 +0800
Message-Id: <20220724063622.3205-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'so'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 arch/powerpc/mm/init-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 119ef491f797..acf5d7ba79d1 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -130,7 +130,7 @@ void pgtable_cache_add(unsigned int shift)
 
 	/* It would be nice if this was a BUILD_BUG_ON(), but at the
 	 * moment, gcc doesn't seem to recognize is_power_of_2 as a
-	 * constant expression, so so much for that. */
+	 * constant expression, so much for that. */
 	BUG_ON(!is_power_of_2(minalign));
 	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
 
-- 
2.36.1

