Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C30589B33
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbiHDLto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbiHDLtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:49:41 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710CE57267
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:49:40 -0700 (PDT)
X-QQ-mid: bizesmtp74t1659613769t2zljze1
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 19:49:28 +0800 (CST)
X-QQ-SSF: 01000000008000F0U000B00A0000020
X-QQ-FEAT: DWSCcwW/aQZVWJjuyFZXThKOr/fN0z1ZLf3gMeSgEi3IPGYuYRWUTBNjaY7RQ
        MPuwtUXre6YkOreEnxkijQMFfpXjASipe7EbPpuv/h1NAg/Vhd3K1oQIHA/LbrOaDQ1QO6W
        O4vg8QXwqNXQx9b5GxaePui95wEuwW2uJNtSN4mkuorjv0ufNq9CrnjcBbZ9Vyn5N76wtyx
        dGaR9dWvjNJE5HyhkpbMkf1ydnYl9lbbfpkphFt7KDZixCF+uSTdAEhsGUZTawo8bVAuzL7
        vHK3fJ+p9EKr/v1YurSEvgW9QTKHi/ouIBbO3cyWW5+xPaMnryEiZ8N/FNJwNtjy/LrukPP
        QHE0QMpxpwTPc3KpMKYGFAneIvmKrtgMu34I3pnzHGgFdN3Ize6e4BmnZEGMghe5ImTLjqd
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mripard@kernel.org
Cc:     maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] drm/mipi-dsi: Fix comment typo
Date:   Thu,  4 Aug 2022 19:49:04 +0800
Message-Id: <20220804114905.47845-1-wangborong@cdjrlc.com>
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
 drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index c40bde96cfdf..fd2790a5664d 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -606,7 +606,7 @@ EXPORT_SYMBOL(mipi_dsi_turn_on_peripheral);
 
 /*
  * mipi_dsi_set_maximum_return_packet_size() - specify the maximum size of the
- *    the payload in a long packet transmitted from the peripheral back to the
+ *    payload in a long packet transmitted from the peripheral back to the
  *    host processor
  * @dsi: DSI peripheral device
  * @value: the maximum size of the payload
-- 
2.35.1

