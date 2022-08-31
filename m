Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080F35A7DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiHaMs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiHaMsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:48:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8178B8E0DD;
        Wed, 31 Aug 2022 05:48:16 -0700 (PDT)
X-QQ-mid: bizesmtp84t1661950092t663xyr6
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 20:48:10 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: +Fw3Sd5mYDUBonsU31Sdex/qB1ji1iZUiZ+0V7V0HuZwG97jbOZdDsfI0hC9N
        7usso13k6JqYMFnD5gSNVZMNKtCqLSxUIS1ysQCkxGtmL0ko9mO9Io1xEova5etIXoIT6c+
        vRhT5OtQ+rgn558DPVQHg7YROPERnnGjxkEK0y0RbL1D/fowLieytm44Yp9ycYtQNuQIBrw
        f/dfxCOhJ4+PCRL072PWd4pCsTtCaFTLjIJo1xfRzP9IigBXoH/ZPL0Jq/ufPWMzJmcVy/D
        aWZW7E7mHeZgn6OywZQndndWXnLqkeHsPSq+hA3jjEZxsa5sJXNT4MhO6ZcC7OXQZng/iv9
        l81qCCdc844XICdcbhZnsqTrNuvxUddMKmTRgD7yzpqudZtzh1gYTPmnL+IQiTfN8lBh/HS
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] mips: fix repeated words in comments
Date:   Wed, 31 Aug 2022 20:48:04 +0800
Message-Id: <20220831124804.11092-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'as'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/mips/cavium-octeon/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index cbd83205518d..57b32418b29d 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -532,7 +532,7 @@ void octeon_user_io_init(void)
 	/* Get the current settings for CP0_CVMMEMCTL_REG */
 	cvmmemctl.u64 = read_c0_cvmmemctl();
 	/* R/W If set, marked write-buffer entries time out the same
-	 * as as other entries; if clear, marked write-buffer entries
+	 * as other entries; if clear, marked write-buffer entries
 	 * use the maximum timeout. */
 	cvmmemctl.s.dismarkwblongto = 1;
 	/* R/W If set, a merged store does not clear the write-buffer
-- 
2.36.1

