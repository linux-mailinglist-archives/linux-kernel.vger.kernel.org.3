Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC8525C56
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377783AbiEMHUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356223AbiEMHT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:19:57 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12902AACC1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:19:55 -0700 (PDT)
X-UUID: 43d5697e530f41e095fe965a3f140368-20220513
X-Spam-Fingerprint: 0
X-GW-Reason: 11101
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HMTDkurrpnIDopoHlrqHmoLg=
X-Content-Feature: ica/max.line-size 116
        audit/email.address 1
        meta/cnt.alert 1
X-UUID: 43d5697e530f41e095fe965a3f140368-20220513
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <pengfuyuan@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 482741696; Fri, 13 May 2022 14:24:51 +0800
X-ns-mid: postfix-627DF8EE-8540214981
Received: from localhost.localdomain (unknown [172.20.4.120])
        by cs2c.com.cn (NSMail) with ESMTPA id 87CC6383C640;
        Fri, 13 May 2022 06:21:34 +0000 (UTC)
From:   pengfuyuan <pengfuyuan@kylinos.cn>
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        pengfuyuan <pengfuyuan@kylinos.cn>
Subject: [PATCH] drm/amd/display: Remove macro DC_DEFAULT_LOG_MASK
Date:   Fri, 13 May 2022 14:20:45 +0800
Message-Id: <20220513062045.840780-1-pengfuyuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UNPARSEABLE_RELAY,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Why]
The DC_DEFAULT_LOG_MASK macro has not been used for a long time, so remove it.

Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
---
 .../drm/amd/display/include/logger_types.h    | 33 -------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index f093b49c5e6e..1b38cfc41718 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -131,37 +131,4 @@ enum dc_log_type {
 #define DC_MIN_LOG_MASK ((1 << LOG_ERROR) | \
 		(1 << LOG_DETECTION_EDID_PARSER))
 
-#define DC_DEFAULT_LOG_MASK ((1ULL << LOG_ERROR) | \
-		(1ULL << LOG_WARNING) | \
-		(1ULL << LOG_EVENT_MODE_SET) | \
-		(1ULL << LOG_EVENT_DETECTION) | \
-		(1ULL << LOG_EVENT_LINK_TRAINING) | \
-		(1ULL << LOG_EVENT_LINK_LOSS) | \
-		(1ULL << LOG_EVENT_UNDERFLOW) | \
-		(1ULL << LOG_RESOURCE) | \
-		(1ULL << LOG_FEATURE_OVERRIDE) | \
-		(1ULL << LOG_DETECTION_EDID_PARSER) | \
-		(1ULL << LOG_DC) | \
-		(1ULL << LOG_HW_HOTPLUG) | \
-		(1ULL << LOG_HW_SET_MODE) | \
-		(1ULL << LOG_HW_RESUME_S3) | \
-		(1ULL << LOG_HW_HPD_IRQ) | \
-		(1ULL << LOG_SYNC) | \
-		(1ULL << LOG_BANDWIDTH_VALIDATION) | \
-		(1ULL << LOG_MST) | \
-		(1ULL << LOG_DETECTION_DP_CAPS) | \
-		(1ULL << LOG_BACKLIGHT)) | \
-		(1ULL << LOG_I2C_AUX) | \
-		(1ULL << LOG_IF_TRACE) | \
-		(1ULL << LOG_HDMI_FRL) | \
-		(1ULL << LOG_SCALER) | \
-		(1ULL << LOG_DTN) /* | \
-		(1ULL << LOG_DEBUG) | \
-		(1ULL << LOG_BIOS) | \
-		(1ULL << LOG_SURFACE) | \
-		(1ULL << LOG_DML) | \
-		(1ULL << LOG_HW_LINK_TRAINING) | \
-		(1ULL << LOG_HW_AUDIO)| \
-		(1ULL << LOG_BANDWIDTH_CALCS)*/
-
 #endif /* __DAL_LOGGER_TYPES_H__ */
-- 
2.25.1

