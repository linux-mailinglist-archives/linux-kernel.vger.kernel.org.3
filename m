Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98181580DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiGZHdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbiGZHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:32:03 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520332A421
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:28:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VKUN9FD_1658820463;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VKUN9FD_1658820463)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 15:27:45 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 20/20] drm/amd/display: Clean up some inconsistent indenting
Date:   Tue, 26 Jul 2022 15:25:55 +0800
Message-Id: <20220726072555.91323-20-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
References: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

smatch warnings:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1372 dp_dsc_clock_en_read() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1478 dp_dsc_clock_en_write() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1563 dp_dsc_slice_width_read() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1667 dp_dsc_slice_width_write() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1752 dp_dsc_slice_height_read() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1856 dp_dsc_slice_height_write() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1937 dp_dsc_bits_per_pixel_read() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2038 dp_dsc_bits_per_pixel_write() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2117 dp_dsc_pic_width_read() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2178 dp_dsc_pic_height_read() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2254 dp_dsc_chunk_size_read() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2330 dp_dsc_slice_bpg_offset_read() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 72 +++++++++----------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index aa4edf182095..0e48824f55e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1369,9 +1369,9 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx) {
@@ -1475,9 +1475,9 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx || !pipe_ctx->stream)
@@ -1560,9 +1560,9 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx) {
@@ -1664,9 +1664,9 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx || !pipe_ctx->stream)
@@ -1749,9 +1749,9 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx) {
@@ -1853,9 +1853,9 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx || !pipe_ctx->stream)
@@ -1934,9 +1934,9 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx) {
@@ -2035,9 +2035,9 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx || !pipe_ctx->stream)
@@ -2114,9 +2114,9 @@ static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx) {
@@ -2175,9 +2175,9 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx) {
@@ -2251,9 +2251,9 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx) {
@@ -2327,9 +2327,9 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx) {
-- 
2.20.1.7.g153144c

