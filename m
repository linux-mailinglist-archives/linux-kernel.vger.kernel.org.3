Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26525532F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350821AbiFUNGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350066AbiFUNGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:06:43 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDEB2612D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:06:35 -0700 (PDT)
X-QQ-mid: bizesmtp82t1655816536tegru2l3
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 21:02:12 +0800 (CST)
X-QQ-SSF: 0100000000700050B000B00A0000000
X-QQ-FEAT: xoS364mEyr2lrJLrObarZ620j5HzhnGsAxRGEt30W2QTeCOW0f4X+LfQXscqK
        f+JJxJBcSHehUERB7aUQzczaJeG7LmUbUFgTpMcKsMVMrCxL5IhHfe6ZPBqsE6XX8hVdcHV
        FnfkxIFR4nADKqxvescYikqkjJr6ebnWk6+DIdvBvwkkqWfBHh3qD+fTVPpdTVLsf8in2nW
        plK8W1V85hYCxJVz82AsbN6FPd4gtDuLrcN7SjwBPIhBJY4CfsWczOBSUxxaiqXe/gwtQjr
        VSVmAB6Ryd+50MmnCLH+Ncpu1C8eYRMQdQ3aoxcQJ+DNfKO2R9gCCQV2Wi/uOg3y/K2BWc1
        9+g/dhGfs2e63I6GxDz3aq1Y0eg3A==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] drm/prime: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 21:02:10 +0800
Message-Id: <20220621130210.125461-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/gpu/drm/drm_prime.c
line: 842
* of the the buffer described by the provided sg_table.
changed to
* of the buffer described by the provided sg_table.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/drm_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index e3f09f18110c..a3f180653b8b 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -839,7 +839,7 @@ EXPORT_SYMBOL(drm_prime_pages_to_sg);
  * @sgt: sg_table describing the buffer to check
  *
  * This helper calculates the contiguous size in the DMA address space
- * of the the buffer described by the provided sg_table.
+ * of the buffer described by the provided sg_table.
  *
  * This is useful for implementing
  * &drm_gem_object_funcs.gem_prime_import_sg_table.
-- 
2.17.1

