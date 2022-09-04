Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4935AC39B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 11:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiIDJ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 05:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIDJ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 05:27:02 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D317474EE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=e072z
        4VQxm65ywSD356w2FUZqlt2NwgtGY3qZldyc5k=; b=Qo5fxiQweQpZlZDTpNWjZ
        jn48cwb8HCghjgqFKdXkrdPu+LIBgBcLr/KIiVaTUZN43Yk7nvvdhSSM7h6vsgVq
        YfZStYEQKM7r4N1FvV1GKYQ1tMRogvD5ks+7aWHMlm1/D6yh1l2jXzaSDJZymYru
        lVYKDkhLpyY8yBiXnYtt0Y=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp12 (Coremail) with SMTP id EMCowABnt49DbxRjQYBnJg--.28508S4;
        Sun, 04 Sep 2022 17:26:42 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Felix.Kuehling@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] amd: amdgpu: fix coding style issue
Date:   Sun,  4 Sep 2022 17:26:25 +0800
Message-Id: <20220904092625.1007393-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowABnt49DbxRjQYBnJg--.28508S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jw1kJryDJF1xXF1UZF4fKrg_yoW8JF18pr
        1fGr15Kr45ZFWSk39rZ3WkuFyft3WxXFy8KrW7Zw4Y9ws8XF98Jry5tr4jvF9rWrsxCF47
        tryqqay5uFnFvr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE6RRZUUUUU=
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/1tbishJyF1UMWQCYBwAAsa
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch to the amdgpu_sync.c file that fixes some warnings found by the checkpatch.pl tool

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 504af1b93bfa..dfc787b749b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -1,5 +1,6 @@
-/*
- * Copyright 2014 Advanced Micro Devices, Inc.
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright 2014 Advanced Micro Devices, Inc.
  * All Rights Reserved.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
@@ -315,6 +316,7 @@ struct dma_fence *amdgpu_sync_get_fence(struct amdgpu_sync *sync)
 	struct hlist_node *tmp;
 	struct dma_fence *f;
 	int i;
+
 	hash_for_each_safe(sync->fences, i, tmp, e, node) {
 
 		f = e->fence;
@@ -392,7 +394,7 @@ void amdgpu_sync_free(struct amdgpu_sync *sync)
 {
 	struct amdgpu_sync_entry *e;
 	struct hlist_node *tmp;
-	unsigned i;
+	unsigned int i;
 
 	hash_for_each_safe(sync->fences, i, tmp, e, node) {
 		hash_del(&e->node);
-- 
2.34.1

