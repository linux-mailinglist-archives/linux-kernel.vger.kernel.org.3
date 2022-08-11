Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B40590119
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbiHKPsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbiHKPqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:46:32 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A499569F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:41:15 -0700 (PDT)
X-QQ-mid: bizesmtp84t1660232445tagimrxj
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 23:40:38 +0800 (CST)
X-QQ-SSF: 0100000000200080H000B00A0000000
X-QQ-FEAT: CR3LFp2JE4k+qoMOMkngQMFfaswYNNllHQQVEKKmAclLFKgIFdLtvLu3tIlt1
        swnJmVUFjT65gS14WkrxESJiYdzgD0WBRbkbZIw6fD3fMgFoPIeRY9kY9VQGULZ49sVcLKn
        H4dCXS8CVx/djqhj08RJDrZ3nCRPWkKidfKce7P0IvzBfCbeaMTPhLxq9h1oWZxCHlAWBVe
        Y3aJ4OiNN8od0hgN17aby6xXDTdJDgK1gsBhLYPypfjn74p3iSEC37Uvv6dLMxKFwxm6G8/
        w8X/ejb/u/wpnq+8C1qeYiCI9BkXdv6fSpcmQcwuDga02/mXdM4wfZDZwq/hlnOW/pt6O/2
        X/XBaEdM7cKPIo8L+LUY3ZS0gsxwFp4NeDDE5rm0XO6hGEa0jtlK6X81ilo2ln421RVnk5x
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, min tang <tangmin@cdjrlc.com>
Subject: [PATCH] drm/i915: Fix comment typo
Date:   Thu, 11 Aug 2022 23:40:27 +0800
Message-Id: <20220811154027.13255-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `for' is duplicated in line 2537, remove one.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 drivers/gpu/drm/i915/i915_reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 9ccb67eec1bd..617a33e4bbb6 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -2534,7 +2534,7 @@
  * HDMI/DP bits are g4x+
  *
  * WARNING: Bspec for hpd status bits on gen4 seems to be completely confused.
- * Please check the detailed lore in the commit message for for experimental
+ * Please check the detailed lore in the commit message for experimental
  * evidence.
  */
 /* Bspec says GM45 should match G4X/VLV/CHV, but reality disagrees */
-- 
2.17.1

