Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8324A5846C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiG1UGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1UG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:06:28 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4725D7538D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:06:28 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4Lv1r33mm9z9s1T;
        Thu, 28 Jul 2022 20:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659038787; bh=qMkVhpHfimqGZ1UHe8cnMLY3YgQI8b39H7ayhDfdi6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjxI3gik4u0EyftYF37MDXA2IlhpWeTCfn9LKSIq4qtJXUVUdBY2Mfoki7d6Nlsx9
         qw4G8GIIqMWpOQHTJX5YCE7sgItB/Jk4o/Ii1RF2YsB4a0uUe5PZGVBXAjPkPepUKG
         e0/RklUyyBcKTyS0Njh1b6GVCW1aZiI9wLFewjJM=
X-Riseup-User-ID: 951C84FCE757D20387021224588B25A3FBE76A1B970D0C2DC7BD085DD24D9ED8
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Lv1qy64Mzz5vTb;
        Thu, 28 Jul 2022 20:06:22 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        mwen@igalia.com, andrealmeid@riseup.net,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH 16/16] drm/amd/display: Remove never used VBA variables
Date:   Thu, 28 Jul 2022 17:06:16 -0300
Message-Id: <20220728200616.514993-1-mairacanal@riseup.net>
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

The variables OutputBPP, VTotal_Min,
TotalBandwidthConsumedGBytePerSecond, BandwidthSupport,
dummy_integer_array, dummysinglestring,
SurfaceRequiredDISPCLKWithoutODMCombine, SurfaceRequiredDISPCLK,
MinVoltageLevel, and MaxVoltageLevel are never used. So, remove the
variables entries from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 5eaedc3bf2c8..839f8fde4b47 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -527,7 +527,6 @@ struct vba_vars_st {
 	unsigned int MinCompressedBufferSizeInKByte;
 	unsigned int NumberOfActiveSurfaces;
 	bool ViewportStationary[DC__NUM_DPP__MAX];
-	double       OutputBPP[DC__NUM_DPP__MAX];
 	unsigned int GPUVMMinPageSizeKBytes[DC__NUM_DPP__MAX];
 	bool SynchronizeTimingsFinal;
 	bool SynchronizeDRRDisplaysForUCLKPStateChangeFinal;
@@ -557,7 +556,6 @@ struct vba_vars_st {
 	unsigned int HTotal[DC__NUM_DPP__MAX];
 	unsigned int VTotal[DC__NUM_DPP__MAX];
 	unsigned int VTotal_Max[DC__NUM_DPP__MAX];
-	unsigned int VTotal_Min[DC__NUM_DPP__MAX];
 	int DPPPerPlane[DC__NUM_DPP__MAX];
 	double PixelClock[DC__NUM_DPP__MAX];
 	double PixelClockBackEnd[DC__NUM_DPP__MAX];
@@ -690,12 +688,10 @@ struct vba_vars_st {
 	/*outputs*/
 	bool ScaleRatioAndTapsSupport;
 	bool SourceFormatPixelAndScanSupport;
-	double TotalBandwidthConsumedGBytePerSecond;
 	bool DCCEnabledInAnyPlane;
 	bool WritebackLatencySupport;
 	bool WritebackModeSupport;
 	bool Writeback10bpc420Supported;
-	bool BandwidthSupport[DC__VOLTAGE_STATES];
 	unsigned int TotalNumberOfActiveWriteback;
 	double CriticalPoint;
 	double ReturnBWToDCNPerState;
@@ -955,9 +951,7 @@ struct vba_vars_st {
 	unsigned int        dummyinteger9;
 	unsigned int        dummyinteger10;
 	unsigned int        dummyinteger11;
-	unsigned int        dummy_integer_array[8][DC__NUM_DPP__MAX];
 
-	bool           dummysinglestring;
 	bool           SingleDPPViewportSizeSupportPerPlane[DC__NUM_DPP__MAX];
 	double         PlaneRequiredDISPCLKWithODMCombine2To1;
 	double         PlaneRequiredDISPCLKWithODMCombine4To1;
@@ -1248,11 +1242,7 @@ struct vba_vars_st {
 	unsigned int NotEnoughUrgentLatencyHidingA[DC__VOLTAGE_STATES][2];
 	double ReadBandwidthSurfaceLuma[DC__NUM_DPP__MAX];
 	double ReadBandwidthSurfaceChroma[DC__NUM_DPP__MAX];
-	double SurfaceRequiredDISPCLKWithoutODMCombine;
-	double SurfaceRequiredDISPCLK;
 	double MinActiveFCLKChangeLatencySupported;
-	int MinVoltageLevel;
-	int MaxVoltageLevel;
 	unsigned int TotalNumberOfSingleDPPSurfaces[DC__VOLTAGE_STATES][2];
 	unsigned int CompressedBufferSizeInkByteAllStates[DC__VOLTAGE_STATES][2];
 	unsigned int DETBufferSizeInKByteAllStates[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
-- 
2.37.1

