Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E05F4F1EE9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380572AbiDDWMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386832AbiDDVjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:39:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E264F9CF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1hcHq3+jtoL5KI3F2TXnvjIRLzfezUI/ZzvP2fdXzK8=; b=eOATVfRMpJ/59wHBVZdU1fcZGi
        bu9a2mhF+aplohuk+fjg4G27QNxVjFJ4KiPunSIa8K9qqxtySfOIxoLX8iWyqbVbQztoqxca8VfrH
        ZikJBe50X02hySLGJG27bymW34LnGZWUSPjlRMAhq8G7oPhq5s5lGX2oui1ZGfKSky1Fn+zCnR8zj
        oJBjm6lCRbPI6j72s/nbf+Kc4NObJefjyV/wPa0M0Q2cbNIiATKh7wlUpeTEA7aWAGzsNrzjmkYnN
        VnADdg0lBY6B/FDR8Fs0eviZL/hibJkM3JuIJXceRym7zGwscM4hNThWa5tBg7/Ngp2TJrMynFQD7
        oYnAO3Xw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbUHZ-00GSRY-Ai; Mon, 04 Apr 2022 21:30:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Nayan Deshmukh <nayan26deshmukh@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jiawei Gu <Jiawei.Gu@amd.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/scheduler: quieten kernel-doc warnings
Date:   Mon,  4 Apr 2022 14:30:40 -0700
Message-Id: <20220404213040.12912-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings in gpu_scheduler.h and sched_main.c.

Quashes these warnings:

include/drm/gpu_scheduler.h:332: warning: missing initial short description on line:
 * struct drm_sched_backend_ops
include/drm/gpu_scheduler.h:412: warning: missing initial short description on line:
 * struct drm_gpu_scheduler
include/drm/gpu_scheduler.h:461: warning: Function parameter or member 'dev' not described in 'drm_gpu_scheduler'

drivers/gpu/drm/scheduler/sched_main.c:201: warning: missing initial short description on line:
 * drm_sched_dependency_optimized
drivers/gpu/drm/scheduler/sched_main.c:995: warning: Function parameter or member 'dev' not described in 'drm_sched_init'

Fixes: 2d33948e4e00 ("drm/scheduler: add documentation")
Fixes: 8ab62eda177b ("drm/sched: Add device pointer to drm_gpu_scheduler")
Fixes: 542cff7893a3 ("drm/sched: Avoid lockdep spalt on killing a processes")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Nayan Deshmukh <nayan26deshmukh@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Jiawei Gu <Jiawei.Gu@amd.com>
Cc: dri-devel@lists.freedesktop.org
Acked-by: Christian König <christian.koenig@amd.com>
---
Feel free to make changes or suggest changes...

v2: drop @work description (already done by Andrey)

 drivers/gpu/drm/scheduler/sched_main.c |    3 ++-
 include/drm/gpu_scheduler.h            |    9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

--- linux-next-20220404.orig/drivers/gpu/drm/scheduler/sched_main.c
+++ linux-next-20220404/drivers/gpu/drm/scheduler/sched_main.c
@@ -198,7 +198,7 @@ static void drm_sched_job_done_cb(struct
 }
 
 /**
- * drm_sched_dependency_optimized
+ * drm_sched_dependency_optimized - test if the dependency can be optimized
  *
  * @fence: the dependency fence
  * @entity: the entity which depends on the above fence
@@ -984,6 +984,7 @@ static int drm_sched_main(void *param)
  *		used
  * @score: optional score atomic shared with other schedulers
  * @name: name used for debugging
+ * @dev: target &struct device
  *
  * Return 0 on success, otherwise error code.
  */
--- linux-next-20220404.orig/include/drm/gpu_scheduler.h
+++ linux-next-20220404/include/drm/gpu_scheduler.h
@@ -328,10 +328,10 @@ enum drm_gpu_sched_stat {
 };
 
 /**
- * struct drm_sched_backend_ops
+ * struct drm_sched_backend_ops - Define the backend operations
+ *	called by the scheduler
  *
- * Define the backend operations called by the scheduler,
- * these functions should be implemented in driver side.
+ * These functions should be implemented in the driver side.
  */
 struct drm_sched_backend_ops {
 	/**
@@ -408,7 +408,7 @@ struct drm_sched_backend_ops {
 };
 
 /**
- * struct drm_gpu_scheduler
+ * struct drm_gpu_scheduler - scheduler instance-specific data
  *
  * @ops: backend operations provided by the driver.
  * @hw_submission_limit: the max size of the hardware queue.
@@ -434,6 +434,7 @@ struct drm_sched_backend_ops {
  * @_score: score used when the driver doesn't provide one
  * @ready: marks if the underlying HW is ready to work
  * @free_guilty: A hit to time out handler to free the guilty job.
+ * @dev: system &struct device
  *
  * One scheduler is implemented for each hardware ring.
  */
