Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C8C49DB3E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbiA0HNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:13:01 -0500
Received: from smtpbg701.qq.com ([203.205.195.86]:44982 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237127AbiA0HNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:13:00 -0500
X-QQ-mid: bizesmtp37t1643267572tjg1zcey
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 27 Jan 2022 15:12:41 +0800 (CST)
X-QQ-SSF: 0140000000000090E000B00A0000000
X-QQ-FEAT: JWRRigPlP3C2ST/VISuYxlpF+8MYFF6xQgFjVx5xL6ysOicrVfE4j/Mykv4bw
        eMPUQ14VMRRTqTiYBuu4yLyawDhm5PMBmWELTsdVhz36s4RfcUBshcVWnU8X+ZJ4uEk5nDr
        Z61h9ujLRT1Twa34a5XabVQ2QdcFv1NAJ8cY8euDpICwNxWEsvrslOXV4gqHZAC5dweZZqq
        eP4233FhCsVQoAuGChRYCsgIVffHA+OK8DiMSKun5hE0W/9inKwY7KWTq9Usu0KoONb9rcU
        6TX9ooMkkzoCeOuKAfCWt0V5aHfBtExXXmzG16AwSS1yTZWYvInFLO6/S4osWGU+4HJdy5o
        Wb4e9H9lGnmNLZ2RKTIIt43N8hMItkD8tNjh+fm
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     tangmeng <tangmeng@uniontech.com>
Subject: [PATCH] drm/amd/amdgpu: fix spelling mistake "disbale" -> "disable"
Date:   Thu, 27 Jan 2022 15:12:39 +0800
Message-Id: <20220127071239.30487-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake. Fix it.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index aef9d059ae52..a642c04cf17d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -544,7 +544,7 @@ static int xgpu_vi_mailbox_rcv_irq(struct amdgpu_device *adev,
 {
 	int r;
 
-	/* trigger gpu-reset by hypervisor only if TDR disbaled */
+	/* trigger gpu-reset by hypervisor only if TDR disabled */
 	if (!amdgpu_gpu_recovery) {
 		/* see what event we get */
 		r = xgpu_vi_mailbox_rcv_msg(adev, IDH_FLR_NOTIFICATION);
-- 
2.20.1



