Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0E7575357
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbiGNQsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240477AbiGNQsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:48:13 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9146871A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:46:08 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LkL314pCGz9sx9;
        Thu, 14 Jul 2022 16:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1657817149; bh=29itsEn44X6T95ht/l7AnGed+BsOTGeJlu/TRnLEOKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RbuOcPZkiG1dP/MOThhQt0iWOhTAImXzAbB8HtzAGCUBz4LgxD4pKTNy7r2XBxsTq
         KKKH/WHD/fTPjf7ZMisQgWY/azrz81cmkScSb9VUPQ0YfHQPa4uC5h/rGVQDoSn6WS
         Dq4pA4LlhXmfFFetlphSt6ahsKfCiL/7LayNaF9A=
X-Riseup-User-ID: BE08BA1C076CEC47AC79A97FB992D2D138AF6D992A81EFF4B8D0FEE0F747A55C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LkL2v1GDfz5vW1;
        Thu, 14 Jul 2022 16:45:42 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mwen@igalia.com, andrealmeid@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH 04/12] drm/amd/display: Remove unused dml32_CalculatedoublePipeDPPCLKAndSCLThroughput function
Date:   Thu, 14 Jul 2022 13:44:59 -0300
Message-Id: <20220714164507.561751-4-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
References: <20220714164507.561751-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dml32_CalculatedoublePipeDPPCLKAndSCLThroughput function, which is not used in
the codebase.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:393:6:
warning: no previous prototype for function
'dml32_CalculatedoublePipeDPPCLKAndSCLThroughput' [-Wmissing-prototypes]
void dml32_CalculatedoublePipeDPPCLKAndSCLThroughput(
     ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:393:1:
note: declare 'static' if the function is not intended to be used outside of
this translation unit
void dml32_CalculatedoublePipeDPPCLKAndSCLThroughput(
^
static
1 warning generated.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 54 -------------------
 1 file changed, 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 5a701d9df0f7..4d62ab0c1a78 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -390,60 +390,6 @@ void dml32_CalculateBytePerPixelAndBlockSizes(
 #endif
 } // CalculateBytePerPixelAndBlockSizes
 
-void dml32_CalculatedoublePipeDPPCLKAndSCLThroughput(
-		double HRatio,
-		double HRatioChroma,
-		double VRatio,
-		double VRatioChroma,
-		double MaxDCHUBToPSCLThroughput,
-		double MaxPSCLToLBThroughput,
-		double PixelClock,
-		enum source_format_class SourcePixelFormat,
-		unsigned int HTaps,
-		unsigned int HTapsChroma,
-		unsigned int VTaps,
-		unsigned int VTapsChroma,
-
-		/* output */
-		double *PSCL_THROUGHPUT,
-		double *PSCL_THROUGHPUT_CHROMA,
-		double *DPPCLKUsingdoubleDPP)
-{
-	double DPPCLKUsingdoubleDPPLuma;
-	double DPPCLKUsingdoubleDPPChroma;
-
-	if (HRatio > 1) {
-		*PSCL_THROUGHPUT = dml_min(MaxDCHUBToPSCLThroughput, MaxPSCLToLBThroughput * HRatio /
-				dml_ceil((double) HTaps / 6.0, 1.0));
-	} else {
-		*PSCL_THROUGHPUT = dml_min(MaxDCHUBToPSCLThroughput, MaxPSCLToLBThroughput);
-	}
-
-	DPPCLKUsingdoubleDPPLuma = PixelClock * dml_max3(VTaps / 6 * dml_min(1, HRatio), HRatio * VRatio /
-			*PSCL_THROUGHPUT, 1);
-
-	if ((HTaps > 6 || VTaps > 6) && DPPCLKUsingdoubleDPPLuma < 2 * PixelClock)
-		DPPCLKUsingdoubleDPPLuma = 2 * PixelClock;
-
-	if ((SourcePixelFormat != dm_420_8 && SourcePixelFormat != dm_420_10 && SourcePixelFormat != dm_420_12 &&
-			SourcePixelFormat != dm_rgbe_alpha)) {
-		*PSCL_THROUGHPUT_CHROMA = 0;
-		*DPPCLKUsingdoubleDPP = DPPCLKUsingdoubleDPPLuma;
-	} else {
-		if (HRatioChroma > 1) {
-			*PSCL_THROUGHPUT_CHROMA = dml_min(MaxDCHUBToPSCLThroughput, MaxPSCLToLBThroughput *
-					HRatioChroma / dml_ceil((double) HTapsChroma / 6.0, 1.0));
-		} else {
-			*PSCL_THROUGHPUT_CHROMA = dml_min(MaxDCHUBToPSCLThroughput, MaxPSCLToLBThroughput);
-		}
-		DPPCLKUsingdoubleDPPChroma = PixelClock * dml_max3(VTapsChroma / 6 * dml_min(1, HRatioChroma),
-				HRatioChroma * VRatioChroma / *PSCL_THROUGHPUT_CHROMA, 1);
-		if ((HTapsChroma > 6 || VTapsChroma > 6) && DPPCLKUsingdoubleDPPChroma < 2 * PixelClock)
-			DPPCLKUsingdoubleDPPChroma = 2 * PixelClock;
-		*DPPCLKUsingdoubleDPP = dml_max(DPPCLKUsingdoubleDPPLuma, DPPCLKUsingdoubleDPPChroma);
-	}
-}
-
 void dml32_CalculateSwathAndDETConfiguration(
 		unsigned int DETSizeOverride[],
 		enum dm_use_mall_for_pstate_change_mode UseMALLForPStateChange[],
-- 
2.36.1

