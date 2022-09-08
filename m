Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449F55B1E58
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiIHNPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiIHNPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:15:11 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896683CBD8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:15:05 -0700 (PDT)
X-QQ-mid: bizesmtp65t1662642865tdvhoh5r
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 21:14:24 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: V1jmEc92UabV16orn0KMa9TOp2pFaqc0uXI1iUUeNUmq4NhAzq9NWMVtOpdOB
        WPaOebP6QN0kS/BfqvC2K9I6vwP6bd6nPbCia6n4YXFxtzQx3hM767kUHZD0ElYcYKRvrNP
        ULrQQEyzV9gpkjXmiOYIwozSJJThZ/s40wwQJwcmVXdWso4zC3RoIkhx4pueQ+MmWD9d3U+
        WeLhsnhGNbPmTGWWO4OvtkDw2lClM/ZIVe5bOZulHyWp3hvz9lk/f5IWDE+8bmrp6SetrYM
        P63h3isqucPTJm92+5MNqYf+FHcCLYtsY81AfDxw5uvtUNzFFgJqckOl/VorkHSvwCiV18A
        cXF7oqt0VZxdxgLMEgdKDjXh6j5w+YwS5W0EoBegmZT4of7uyGL52nu3qK7Qg==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drm/i915: fix repeated words in comments
Date:   Thu,  8 Sep 2022 21:14:17 +0800
Message-Id: <20220908131417.38720-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/i915/i915_memcpy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_memcpy.h b/drivers/gpu/drm/i915/i915_memcpy.h
index 3df063a3293b..126dfb4352f0 100644
--- a/drivers/gpu/drm/i915/i915_memcpy.h
+++ b/drivers/gpu/drm/i915/i915_memcpy.h
@@ -18,7 +18,7 @@ void i915_unaligned_memcpy_from_wc(void *dst, const void *src, unsigned long len
 /* The movntdqa instructions used for memcpy-from-wc require 16-byte alignment,
  * as well as SSE4.1 support. i915_memcpy_from_wc() will report if it cannot
  * perform the operation. To check beforehand, pass in the parameters to
- * to i915_can_memcpy_from_wc() - since we only care about the low 4 bits,
+ * i915_can_memcpy_from_wc() - since we only care about the low 4 bits,
  * you only need to pass in the minor offsets, page-aligned pointers are
  * always valid.
  *
-- 
2.36.1

