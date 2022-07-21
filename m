Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F25957C2C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiGUDeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiGUDeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:34:14 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B3FE7822A;
        Wed, 20 Jul 2022 20:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yd7Wq
        f0OitoLLGDKE7spYAiUYX053HXKfg4Ni/Q/LSM=; b=d3AY91bAo29mAkdZN5zyM
        dG5eXwbgZXjPIMZo14C/7fakx4UKs1lUseWevCus7OoK5UTCq9KiwSGWPSTM12n8
        /afNR53wrP9Zkk8hvmLajexsubBC5QdNwGRPBcFqpaw/iMzgZ8Kh0cAKpFw2vm0+
        BIDvUNztL+YNnv9W+IbmCg=
Received: from localhost.localdomain (unknown [112.97.57.47])
        by smtp3 (Coremail) with SMTP id G9xpCgCXNY8nydhiloKYQQ--.385S2;
        Thu, 21 Jul 2022 11:34:02 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] s390: Fix typo 'the the' in comment
Date:   Thu, 21 Jul 2022 11:33:58 +0800
Message-Id: <20220721033358.44838-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgCXNY8nydhiloKYQQ--.385S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF4Dtw18JFW7KF47Kr1rJFb_yoW8WFyUpr
        1UCF1DK3ykKF1DCa45Gr48WFW8Zan7Ww4ag3Wvk3yrAFy5ZwsYvFyvq3WxJrWjgryku3W0
        qF1j9r4qg3ZFyaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_F4RxUUUUU=
X-Originating-IP: [112.97.57.47]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJQtFZGAJpJa9YQAAsI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 arch/s390/kernel/perf_cpum_sf.c | 2 +-
 arch/s390/kernel/sthyi.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 4d141e2c132e..dfc350fab384 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -250,7 +250,7 @@ static void fill_diag_mac(struct sthyi_sctns *sctns,
 	sctns->mac.infmval1 |= MAC_CNT_VLD;
 }
 
-/* Returns a pointer to the the next partition block. */
+/* Returns a pointer to the next partition block. */
 static struct diag204_x_part_block *lpar_cpu_inf(struct lpar_cpu_inf *part_inf,
 						 bool this_lpar,
 						 void *diag224_buf,
-- 
2.25.1

