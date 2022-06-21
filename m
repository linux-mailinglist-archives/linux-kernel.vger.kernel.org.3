Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906E85539F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352604AbiFUTBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiFUTBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:01:31 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135142A972
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:01:26 -0700 (PDT)
X-QQ-mid: bizesmtp66t1655838063t28cg980
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 03:00:56 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000C00A0000000
X-QQ-FEAT: fcnEXZ5FDbA9IfQiCumHta+FxrRtAgbjRWF7PNKU8+4xahNTDtdShJDxpXn+h
        kz7LFi0XtaHqHw83RutJRjaOcZWsJoRUdaWctV5adW/Kjb/waDmxc21r95zII7QTyBOBjhh
        CeeUvfjSGJQaALLbXM9ko0Rgb2KnJJG2cNQOXB/JliFZO+WcngzXt5eQumIcO3DyrKDfU/U
        mq/0+Tjx+RFRV2iMAzCJ6v6lhO5xlpvBkaEON4P7eJDbPm45SwV7tIPD34FUxejTvZ+XkHE
        HmPMUEfnhqyGZRUvpCBbEw0ovMGbntKHcwLPbx5oeZ3cewNoxjkWF39ztMPwGVBMXSd+szi
        ftPB9WdFX/kGjGgueM=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     jani.nikula@intel.com, lyude@redhat.com, tzimmermann@suse.de,
        dianders@chromium.org, ville.syrjala@linux.intel.com,
        imre.deak@intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] drm/display: Remove duplicate 'the' in two places.
Date:   Wed, 22 Jun 2022 03:00:55 +0800
Message-Id: <20220621190055.8323-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped
file: drivers/gpu/drm/display/drm_dp_helper.c
line: 1600
  * Doesn't account the the "MOT" bit, and instead assumes each
changed to
  * Doesn't account the "MOT" bit, and instead assumes eac

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e7c22c2ca90c..499f75768523 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1597,7 +1597,7 @@ static int drm_dp_aux_reply_duration(const struct drm_dp_aux_msg *msg)
  * Calculate the length of the i2c transfer in usec, assuming
  * the i2c bus speed is as specified. Gives the the "worst"
  * case estimate, ie. successful while as long as possible.
- * Doesn't account the the "MOT" bit, and instead assumes each
+ * Doesn't account the "MOT" bit, and instead assumes each
  * message includes a START, ADDRESS and STOP. Neither does it
  * account for additional random variables such as clock stretching.
  */
-- 
2.17.1

