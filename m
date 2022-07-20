Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475F557B155
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiGTHEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGTHES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:04:18 -0400
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4655289D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:04:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VJvh.sX_1658300649;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VJvh.sX_1658300649)
          by smtp.aliyun-inc.com;
          Wed, 20 Jul 2022 15:04:10 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     arnd@arndb.de
Cc:     baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: update Baolin Wang's email
Date:   Wed, 20 Jul 2022 15:03:58 +0800
Message-Id: <1658300638-109504-1-git-send-email-baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently switched to my Alibaba email address. So add aliases for my
previous email addresses.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Hi Arnd, could you help to take this patch of updating my email address
into your ARM SoC tree? Thanks.
---
 .mailmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index 4f5850d..58fedc7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -60,6 +60,10 @@ Arnd Bergmann <arnd@arndb.de>
 Atish Patra <atishp@atishpatra.org> <atish.patra@wdc.com>
 Axel Dyks <xl@xlsigned.net>
 Axel Lin <axel.lin@gmail.com>
+Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang@linaro.org>
+Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang@spreadtrum.com>
+Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang@unisoc.com>
+Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang7@gmail.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@sandisk.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@wdc.com>
 Ben Gardner <bgardner@wabtec.com>
-- 
1.8.3.1

