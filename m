Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571324F5D8D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiDFMAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiDFL6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:58:46 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF53E4A7D16
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:30:41 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:54472.1734920290
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 6C6EB1002AB;
        Wed,  6 Apr 2022 15:30:37 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-vjdjk with ESMTP id b3fc00b12b0444a3b3ce6c4630009db5 for maarten.lankhorst@linux.intel.com;
        Wed, 06 Apr 2022 15:30:40 CST
X-Transaction-ID: b3fc00b12b0444a3b3ce6c4630009db5
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/drm_modeset_helper_vtables.h: fix a typo
Date:   Wed,  6 Apr 2022 15:30:36 +0800
Message-Id: <20220406073036.276288-1-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 change upate to update

Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 include/drm/drm_modeset_helper_vtables.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index fdfa9f37ce05..fafa70ac1337 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1384,7 +1384,7 @@ struct drm_mode_config_helper_funcs {
 	 * starting to commit the update to the hardware.
 	 *
 	 * After the atomic update is committed to the hardware this hook needs
-	 * to call drm_atomic_helper_commit_hw_done(). Then wait for the upate
+	 * to call drm_atomic_helper_commit_hw_done(). Then wait for the update
 	 * to be executed by the hardware, for example using
 	 * drm_atomic_helper_wait_for_vblanks() or
 	 * drm_atomic_helper_wait_for_flip_done(), and then clean up the old
-- 
2.25.1

