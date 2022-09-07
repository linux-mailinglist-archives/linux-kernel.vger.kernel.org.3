Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327A45AFAA5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiIGDaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIGDaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:30:04 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 378473F310
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 20:30:00 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id B553F1E80D59;
        Wed,  7 Sep 2022 11:28:48 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ngmRjKLa8Til; Wed,  7 Sep 2022 11:28:46 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id EA2EB1E80D57;
        Wed,  7 Sep 2022 11:28:45 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     christian.koenig@amd.com, ray.huang@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] drm/ttm: Remove unnecessary '0' values from ret
Date:   Wed,  7 Sep 2022 11:29:34 +0800
Message-Id: <20220907032934.4490-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable ret is assigned in the judgment branch statement, he does
not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 include/drm/ttm/ttm_bo_driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index 897b88f0bd59..1afa891f488a 100644
--- a/include/drm/ttm/ttm_bo_driver.h
+++ b/include/drm/ttm/ttm_bo_driver.h
@@ -106,7 +106,7 @@ static inline int ttm_bo_reserve(struct ttm_buffer_object *bo,
 				 bool interruptible, bool no_wait,
 				 struct ww_acquire_ctx *ticket)
 {
-	int ret = 0;
+	int ret;
 
 	if (no_wait) {
 		bool success;
-- 
2.18.2

