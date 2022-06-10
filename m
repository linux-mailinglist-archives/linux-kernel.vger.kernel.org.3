Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188F85460F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348408AbiFJJFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348329AbiFJJE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:04:58 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E8E25F91D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:04:50 -0700 (PDT)
X-QQ-mid: bizesmtp74t1654851760tuxb3c51
Received: from localhost.localdomain ( [182.148.15.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 10 Jun 2022 17:02:37 +0800 (CST)
X-QQ-SSF: 01000000002000C0H000B00A0000000
X-QQ-FEAT: HoyAXBWgsknBzJifp2+Njyqq0cP9V10DvphHsceYwQvb/w1hNrXRGwUgwtxzj
        al7E4L1pQMvGlRAk449pLVajp2fBLDCCtPOcXrRoQ9xfpyC2me0tM/6wMHi74U6Lj/7ZFdm
        RYFmKEBFpm0H60hskt9Q/pYAfwMUaUfLFKqedoON2q0fpRnwN7eB+Jp7B2EFhpWeSECOJdk
        BjwsLEuuOdRZsXviQm+TCpHmqqSiDqcgvqacalQpeHOgZNCx+coymEC3kj+dDimvTQ1OUQg
        uZStgqSu2oUkM+qNGwt2GVyDL0r1d5a/BPQiPe52ue/gKvvxDl/jJi1u3mAyp95hDsRi0Si
        O1NkTaQKtELsE0s36A+K7NJf7T4q8Cu+E0QBYzx
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     suzuki.poulose@arm.com
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] coresight: etm4x: Fix typo in comment
Date:   Fri, 10 Jun 2022 17:02:30 +0800
Message-Id: <20220610090230.62126-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 86a313857b58..36a670b7d195 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1496,7 +1496,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 
 			/*
 			 * If filters::ssstatus == 1, trace acquisition was
-			 * started but the process was yanked away before the
+			 * started but the process was yanked away before
 			 * the stop address was hit.  As such the start/stop
 			 * logic needs to be re-started so that tracing can
 			 * resume where it left.
-- 
2.36.1


