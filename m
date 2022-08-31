Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589655A72F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiHaAuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiHaAtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:49:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ACED5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:49:44 -0700 (PDT)
X-QQ-mid: bizesmtp69t1661906962thnq9p1l
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 08:49:21 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: E5VoqBf3byi/RxEYnkB0AwLa8zBDUlpRF2tTlzL8C1vwovpwf/jD96EJ9dEsN
        rAUsAmOkgimCuWj+/CRH8A8bVUW58V3xWFCYyJtC/rwUlodaeg/suIDT97A9SL/710f5br5
        sI8Nu38ci3nfLX2BIuJC44/1+c4X3f6JGHhjq+YocWXC6KQlmWEno03Wh0KWPiur/kKB+of
        InBmTCZTKjsIm0awul/2CcgfnAZDvgdshtGvVVTw25UV27MyQ7UGFZMPFJ7urBV8bkge2uI
        SA5qJO1qfpeA6tZZ2p1OyJ62VGsGhB6oPzSMOA28fVQur5AllFTPW4YhOBeRzGD54+yqbW2
        Pt44f3mey/Zj2jE/kxG2d0i0IAX8PDBRTYd4dW9QMs2J6mJW5A=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        gustavoars@kernel.org, Julia.Lawall@inria.fr
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] powerpc/vas: fix repeated words in comments
Date:   Wed, 31 Aug 2022 08:49:14 +0800
Message-Id: <20220831004914.37055-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/powerpc/platforms/book3s/vas-api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
index c0799fb26b6d..40f5ae5e1238 100644
--- a/arch/powerpc/platforms/book3s/vas-api.c
+++ b/arch/powerpc/platforms/book3s/vas-api.c
@@ -431,7 +431,7 @@ static vm_fault_t vas_mmap_fault(struct vm_fault *vmf)
 	 * The window may be inactive due to lost credit (Ex: core
 	 * removal with DLPAR). If the window is active again when
 	 * the credit is available, map the new paste address at the
-	 * the window virtual address.
+	 * window virtual address.
 	 */
 	if (txwin->status == VAS_WIN_ACTIVE) {
 		paste_addr = cp_inst->coproc->vops->paste_addr(txwin);
-- 
2.36.1

