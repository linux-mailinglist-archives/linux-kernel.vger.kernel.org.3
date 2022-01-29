Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB894A2AD1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 02:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351942AbiA2BET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 20:04:19 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:57664 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231846AbiA2BES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 20:04:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V34fUPz_1643418255;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V34fUPz_1643418255)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 29 Jan 2022 09:04:15 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, Xinhui.Pan@amd.com, christian.koenig@amd.com,
        alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
        sunpeng.li@amd.com, harry.wentland@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: clean up some inconsistent indenting
Date:   Sat, 29 Jan 2022 09:04:13 +0800
Message-Id: <20220129010413.97801-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:
drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:2246
dp_perform_8b_10b_link_training() warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index daaec3164875..34ffcd5bb1d7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2243,11 +2243,11 @@ static enum link_training_result dp_perform_8b_10b_link_training(
 
 	if (status == LINK_TRAINING_SUCCESS) {
 		status = perform_clock_recovery_sequence(link, link_res, lt_settings, DPRX);
-	if (status == LINK_TRAINING_SUCCESS) {
-		status = perform_channel_equalization_sequence(link,
-					link_res,
-					lt_settings,
-					DPRX);
+		if (status == LINK_TRAINING_SUCCESS) {
+			status = perform_channel_equalization_sequence(link,
+								       link_res,
+								       lt_settings,
+								       DPRX);
 		}
 	}
 
-- 
2.20.1.7.g153144c

