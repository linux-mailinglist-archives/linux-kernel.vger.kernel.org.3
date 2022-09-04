Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE0D5AC5E9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 20:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiIDSdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIDSdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 14:33:42 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2A5930548
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0Cixm
        +IIyxb326ssYKv/Au9Yv7Sc+F7nhziOB8Ue01o=; b=opPn+ZhzMSd99l1shlpjA
        xKjFwDqQuroq9cM9LAUu4Si5L6Jo3oc7IkFafdc6j/lP0VoDgBeIuFzFZ+bn3iHB
        eSRbVuZy1upto6hd0uD+Cag31oS8+0xI/Dee/hyFrBQVbtuw/nURcaliZ7RB//CN
        BRFEO8R5tAJ2Zk6//qmjRA=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp9 (Coremail) with SMTP id DcCowADXz7Vm7xRjeH6ieQ--.9485S4;
        Mon, 05 Sep 2022 02:33:23 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Felix.Kuehling@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] drm/amdgpu: cleanup coding style in amdgpu_sync.c file
Date:   Mon,  5 Sep 2022 02:33:07 +0800
Message-Id: <20220904183307.14550-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowADXz7Vm7xRjeH6ieQ--.9485S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jw1kJryDJFyrAFyrCr43GFg_yoW8JF1UpF
        1fJr4jgr45ZFWa93srAF1kZF93t3W7XFyxKr17Zw4Fqws8ZF15JF1FyrW0vFyDWrs8CF42
        yrWqqayrZFnIvF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEsXonUUUUU=
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbCoA5yF1zmWD1eTwABsE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch to the amdgpu_sync.c file that fixes some warnings found by the checkpatch.pl tool

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 504af1b93bfa..090e66a1b284 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2014 Advanced Micro Devices, Inc.
  * All Rights Reserved.
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

base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
prerequisite-patch-id: fefd0009b468430bb223fc92e4abe9710518b1ea
-- 
2.34.1

