Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9C5A76BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiHaGhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiHaGhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:37:51 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9A4A5C78;
        Tue, 30 Aug 2022 23:37:49 -0700 (PDT)
X-QQ-mid: bizesmtp81t1661927864trwquawg
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 14:37:43 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: hoArX50alxGwaBU1YZbUJfnLJShSYQ7GMsq5aaskZBklXsram6OentME+5JkB
        6oDxFDxiBZqR8vv1iX1WQyR/JYjYLh6ugCrh9Ec+qUjuTxXUidyx7vpfvinByxKux3SIGsg
        k8YuSEgWHX3QsC48bUceuFEPmV6+0Q4n1JCBPnTDlYHjZ22xuyR4r3svbekqNH1EUHYZGtP
        yQ13IdWSJAuN6a02U4OnmlSiFStk1Y26PS5nSD92oT1zev7Ngl+TzbFgPTrVXcGEmWbfsH0
        UDWSob7+O7WDVMxWp0hh+9/vC/c5VVzNkWn/+4U0jOzMPLHLyFBJtoYFJI1sZZpFruk8kNC
        OAY6dJsbQWYDT8/TDqFGhawvl+zCOyDQPEYC9htcgk1dJHcDkC9lXLCAkVhpw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] s390/delay: fix repeated words in comments
Date:   Wed, 31 Aug 2022 14:37:37 +0800
Message-Id: <20220831063737.18460-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'that'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/s390/lib/delay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index f7f5adea8940..c32bc8f7c1fd 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -16,7 +16,7 @@ void __delay(unsigned long loops)
         /*
          * To end the bloody studid and useless discussion about the
          * BogoMips number I took the liberty to define the __delay
-         * function in a way that that resulting BogoMips number will
+         * function in a way that resulting BogoMips number will
          * yield the megahertz number of the cpu. The important function
          * is udelay and that is done using the tod clock. -- martin.
          */
-- 
2.36.1

