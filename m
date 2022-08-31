Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EF35A76CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiHaGjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiHaGj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:39:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56832BE4F8;
        Tue, 30 Aug 2022 23:39:25 -0700 (PDT)
X-QQ-mid: bizesmtp70t1661927959t2spadwu
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 14:39:18 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: r/cTxDoDoiGYHY4msGThDPsUXtghOn+zjRYbUJrgOJwjlIpQi7JcA2FmNnlD1
        sYmBu9fH2LVxxT4IeCLCRPmKInYl5kLN2N2pJSnUTbjI/NQjKtWgMo2P/hJ3Clp4dunxSeM
        KXYJOaLITUENHBWnP2TgqM7d9Xzq9VFSe262BgIrNHcC6wlr6v3T5qIBsTqUtKNdZ8akUdH
        BMhy8URWNrIjZhiYWqLkfkippA2d4FEG/Eaxv+i+7GgquMloyA2+LebPiMu9z+8I/R4ATxa
        nzUVnvVZbAhzFWv6IHrX9ug792D3gixZtIK2PcAdgUsKwGQNnjotE+jRh+Fl++iD00W5kIL
        vuIO3pXHOOx/4aBWJraZpau9lG/VA35oAwJ1+5JAnskcgJUxeW+ekKAESTHDQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] s390/cpumf: fix repeated words in comments
Date:   Wed, 31 Aug 2022 14:39:12 +0800
Message-Id: <20220831063912.19738-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/s390/kernel/perf_cpum_sf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 332a49965130..0fda19b1e21d 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1160,7 +1160,7 @@ static void perf_event_count_update(struct perf_event *event, u64 count)
  * combined-sampling data entry consists of a basic- and a diagnostic-sampling
  * data entry.	The sampling function is determined by the flags in the perf
  * event hardware structure.  The function always works with a combined-sampling
- * data entry but ignores the the diagnostic portion if it is not available.
+ * data entry but ignores the diagnostic portion if it is not available.
  *
  * Note that the implementation focuses on basic-sampling data entries and, if
  * such an entry is not valid, the entire combined-sampling data entry is
-- 
2.36.1

