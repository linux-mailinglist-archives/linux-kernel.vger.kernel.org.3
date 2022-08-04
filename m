Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9464E589B2D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239214AbiHDLqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHDLqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:46:33 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D42F1FCF9
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:46:31 -0700 (PDT)
X-QQ-mid: bizesmtp74t1659613563terev2cc
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 19:46:01 +0800 (CST)
X-QQ-SSF: 01000000008000F0U000B00A0000020
X-QQ-FEAT: ao4JQgu0M390dh+71ddRRaTCN8uGOsNtawusObnIeQCE1w8TRXhmU8lp1Be4l
        GAwB/xWbHL7Y0KHsjwsgUf/DsykXWZBQxQes3FkY7/BGwTfJDoje2ds6o1hAI22loqgreQo
        vxCxPv4tyS3mFZ1YLfxJ/ROosL5mZsK6a7PYk5GyXw445gUc5Imup4h8fhwDWxTNIVuLsF0
        C5WqoQnJBzx/lu/yCjPsie/SG0w8ugb1K46Jxgj9fDnptZDAzVzZq3qFzWQ3HDjl00tPf0S
        baCkRNjSbwbGqWQPmSL4SiDIOZHVESR9cTo0fDl2KlQc8VJ5yrKFcKg0Mb63mH5PmcGCmee
        EustQVJQ6KVaaEOfLaGSm/cdI/3w4LzfP/L2/vSc+OXkV7c9vGnkzcv9uGEZrCS/BIOGX6D
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel@ffwll.ch
Cc:     airlied@linux.ie, jani.nikula@intel.com, lyude@redhat.com,
        ville.syrjala@linux.intel.com, tzimmermann@suse.de,
        imre.deak@intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] drm/display: Fix comment typo
Date:   Thu,  4 Aug 2022 19:45:57 +0800
Message-Id: <20220804114557.44714-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e5bab236b3ae..32b295003f49 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1597,7 +1597,7 @@ static int drm_dp_aux_reply_duration(const struct drm_dp_aux_msg *msg)
 
 /*
  * Calculate the length of the i2c transfer in usec, assuming
- * the i2c bus speed is as specified. Gives the the "worst"
+ * the i2c bus speed is as specified. Gives the "worst"
  * case estimate, ie. successful while as long as possible.
  * Doesn't account the "MOT" bit, and instead assumes each
  * message includes a START, ADDRESS and STOP. Neither does it
-- 
2.35.1

