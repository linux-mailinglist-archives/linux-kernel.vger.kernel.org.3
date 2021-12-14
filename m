Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EDE4743F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhLNNzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:55:01 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:24027 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230038AbhLNNzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:55:01 -0500
X-QQ-mid: bizesmtp46t1639489947t4knmgn0
Received: from wangx.lan (unknown [171.221.148.2])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 14 Dec 2021 21:52:19 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: eTtJes0duVuCV5I93GIB5ZyjA1+F5l2Dnf6qN24mxYOihzHztWcvdOgxEkCCa
        xz1TlrTAmtFmvsa8csE4t08n5PSZFY5PmMgyImpBqir0QDkeLuBClrnFH0HcxFArQ/5XG1H
        QTdrX0k+6hpRSWIecxKu5GlelLBat3YCEI9fTBJCp6nI05Jx1gSAkFFP1mpZIYlvEK7l9B9
        cGQtGI2mRNodkr7MHyBDQWWNTm33hhKZygr5phkqN15CQehSMJQv6AYpIYx5siCGFTc5XSY
        bZcIFptTIGFbZiJshCv4cP3bSLhOEWjsKT9efdu8J7U3mYGzQshagYGSlhbKZY3tjo9Pl5r
        Coo7DllVHSccTqgKsWe3Z0aHtse2A==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     airlied@linux.ie
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] drm/radeon: Fix syntax errors in comments
Date:   Tue, 14 Dec 2021 21:52:17 +0800
Message-Id: <20211214135217.24444-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'we'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/gpu/drm/radeon/radeon_vce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index 511a942e851d..ca4a36464340 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -513,7 +513,7 @@ int radeon_vce_cs_reloc(struct radeon_cs_parser *p, int lo, int hi,
  * @allocated: allocated a new handle?
  *
  * Validates the handle and return the found session index or -EINVAL
- * we we don't have another free session index.
+ * we don't have another free session index.
  */
 static int radeon_vce_validate_handle(struct radeon_cs_parser *p,
 				      uint32_t handle, bool *allocated)
-- 
2.20.1

