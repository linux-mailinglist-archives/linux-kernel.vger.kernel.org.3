Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83815845C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiG1SX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiG1SW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:22:56 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7402D71BC4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:22:55 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LtzXZ5v6fz9spX;
        Thu, 28 Jul 2022 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659032574; bh=zYsJAgnz9NxzI78mWEyNp5Rfrplr2HMd8zTd+2H3qzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqjanDXJZLjlDpmvBBX3SyLO7UsB4YrhGNK/CR66sVttAal1ngnK2toLfaWxziomK
         kJjmnEln7DIXPd4MBBk7dt7iJ1Y4htGBlcqhfgXKnaaLnpQjg6dPjX7GVJ9LBtK2ab
         qRiQY9T8DOP2Zd+h4QtFNyYBEFRpdkBkA/t2uaMM=
X-Riseup-User-ID: 029433EB08767EF91F38D039897485939EFC26DE185FAD55DEA8F2F0E96F7E76
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzXT3cgPz5vMX;
        Thu, 28 Jul 2022 18:22:49 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mwen@igalia.com, andrealmeid@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH 11/16] drm/amd/display: Remove MPCCombineEnable VBA variable
Date:   Thu, 28 Jul 2022 15:20:43 -0300
Message-Id: <20220728182047.264825-12-mairacanal@riseup.net>
In-Reply-To: <20220728182047.264825-1-mairacanal@riseup.net>
References: <20220728182047.264825-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MPCCombineEnable variable from the struct vba_vars_st is only
used on assignments, so its value is not used on code. So, remove
the MPCCombineEnable entry from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 1 -
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c  | 1 -
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 1 -
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c  | 2 --
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h           | 1 -
 5 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index b776a7940fac..7dd51fe88d4f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -5259,7 +5259,6 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 		v->ImmediateFlipSupport = v->ImmediateFlipSupportedForState[v->VoltageLevel][MaximumMPCCombine];
 		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
-			v->MPCCombineEnable[k] = v->MPCCombine[v->VoltageLevel][MaximumMPCCombine][k];
 			v->DPPPerPlane[k] = v->NoOfDPP[v->VoltageLevel][MaximumMPCCombine][k];
 		}
 		v->DCFCLK = v->DCFCLKState[v->VoltageLevel][MaximumMPCCombine];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index b338e72d96d8..2e906f01950b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -5530,7 +5530,6 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 		v->ImmediateFlipSupport = v->ImmediateFlipSupportedForState[v->VoltageLevel][MaximumMPCCombine];
 		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
-			v->MPCCombineEnable[k] = v->MPCCombine[v->VoltageLevel][MaximumMPCCombine][k];
 			v->DPPPerPlane[k] = v->NoOfDPP[v->VoltageLevel][MaximumMPCCombine][k];
 		}
 		v->DCFCLK = v->DCFCLKState[v->VoltageLevel][MaximumMPCCombine];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 6c60731687bf..6a5b3c39ec60 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -5645,7 +5645,6 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 		}
 		v->ImmediateFlipSupport = v->ImmediateFlipSupportedForState[v->VoltageLevel][MaximumMPCCombine];
 		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
-			v->MPCCombineEnable[k] = v->MPCCombine[v->VoltageLevel][MaximumMPCCombine][k];
 			v->DPPPerPlane[k] = v->NoOfDPP[v->VoltageLevel][MaximumMPCCombine][k];
 		}
 		v->DCFCLK = v->DCFCLKState[v->VoltageLevel][MaximumMPCCombine];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 5fce4bbb4e85..6d4907656f9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3685,8 +3685,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.CompressedBufferSizeInkByteAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine]; // Not used, informational
 
 	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
-		mode_lib->vba.MPCCombineEnable[k] =
-				mode_lib->vba.MPCCombine[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
 		mode_lib->vba.DPPPerPlane[k] = mode_lib->vba.NoOfDPP[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
 		mode_lib->vba.SwathHeightY[k] =
 				mode_lib->vba.SwathHeightYAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index f4d4bf7b6111..31cf144860b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -1147,7 +1147,6 @@ struct vba_vars_st {
 	double GPUVMMinPageSize;
 	double HostVMMinPageSize;
 
-	bool   MPCCombineEnable[DC__NUM_DPP__MAX];
 	unsigned int HostVMMaxNonCachedPageTableLevels;
 	bool   DynamicMetadataVMEnabled;
 	double       WritebackInterfaceBufferSize;
-- 
2.37.1

