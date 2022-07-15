Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F40578275
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiGRMir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGRMip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:38:45 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F08CA463;
        Mon, 18 Jul 2022 05:38:40 -0700 (PDT)
X-QQ-mid: bizesmtp90t1658147897tcggymxm
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:38:15 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: lp8jUtqYSiDdRSj78y6Q9aGn5VjwF/dx4jHhwpgxYRE0Sf/tq9V596ETLvsJy
        U4zpB334unK4JNHyW4wBx6YgA/TM0Dl1Gyma9jjQJDIQd+8iD6ihzpQEJrJQaCQ3RiOvk+O
        2SHV+kMJaP68oZfZUKK3aHfglcztl2aED8aDMXuQbFqxS+xjVihWZ357V3eo1Ly0iGpo3Qn
        eMuTj11tQ8wLWDSyCSAmcZdqreEEkcFpZQobMZsCapt001Bjlo94ld8t6TTHhqeTLD4LJ7e
        CVjS0jf48HgkSxK7RrFmj3Ql4F1hj3v1IkWYA2O7sHagWqs9NqSRvruGvDwNN6bv1qWgDwR
        F/ZtYb35sp/5Cnl7qV7mwCOoE9nup1M/OQ2vcC0VrpZyUpVS/mPhur31LkWdfDudsEvwHBx
        N6ly0IIiugM=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     svens@linux.ibm.com
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] s390/delay: Fix comment typo
Date:   Fri, 15 Jul 2022 12:36:10 +0800
Message-Id: <20220715043610.17229-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `that' is duplicated in line 19, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.35.1


