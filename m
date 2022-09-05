Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45945ACD2F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiIEH5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbiIEH5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:57:22 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BB3025C44
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PthuW
        4+2T/916gJ0mcWz5BIVJ432LvylOCFS/+qPKNg=; b=bmYeIG18Mz1MxsUfvGV5m
        3y5R8/IKJqPkpoLTuNVO7++3sj6sJXPWjmF4xm51lZQYEbyDzCM3TldFIcKvDG/8
        UKruVWb8VFyoNYSeN4WjXwmJU8z/tdG1vjce0VnP1HUDDy5bC3Eixk89ArNyfBWA
        +8BRDfnwOMwJP0kGtf0txI=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp10 (Coremail) with SMTP id DsCowACXQKmrqxVjsjDjGA--.54890S4;
        Mon, 05 Sep 2022 15:56:45 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     Felix.Kuehling@amd.com, lexander.deucher@amd.com,
        hristian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] drm/amdgpu: cleanup coding style in amdgpu_amdkfd.c
Date:   Mon,  5 Sep 2022 15:56:24 +0800
Message-Id: <20220905075624.22979-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowACXQKmrqxVjsjDjGA--.54890S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4UCr48uw4xJw4UXF45trb_yoWfuFc_CF
        W5XF4xury3AFnFvr1ayrW3Zry0yFZ8Zrn5Jr1rtFZaq34Du3yUA3srXrnrXF15Gr1xuF9r
        uw409F45A3ZxCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt2Nt7UUUUU==
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbCoBVzF1zmWEfaqAAAsG
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

Fix everything checkpatch.pl complained about in amdgpu_amdkfd.c

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 091415a4abf0..4f5bd96000ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2014 Advanced Micro Devices, Inc.
  *
@@ -130,6 +131,7 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
 						  kfd.reset_work);
 
 	struct amdgpu_reset_context reset_context;
+
 	memset(&reset_context, 0, sizeof(reset_context));
 
 	reset_context.method = AMD_RESET_METHOD_NONE;

base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
-- 
2.34.1

