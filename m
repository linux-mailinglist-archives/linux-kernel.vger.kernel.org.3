Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988B0487521
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346635AbiAGJ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:58:06 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:6647 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346610AbiAGJ6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:58:04 -0500
X-UUID: b4422ce86f974f36a6a8bb0102ab501a-20220107
X-CPASD-INFO: 4652e3ea3efa4753b3b4e4a09666967f@fYZvUpJlk5Ffhaitg3qAbYJkkmSVYIF
        _e3BWZmdmY4aVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3g3hvUpVhlQ==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: 4652e3ea3efa4753b3b4e4a09666967f
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:181.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:98.0,IP:-2.0,MAL:0.0,ATTNUM:0.
        0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFO
        B:0.0,SPC:0.0,SIG:-5,AUF:13,DUF:29771,ACD:157,DCD:259,SL:0,AG:0,CFC:0.239,CFS
        R:0.16,UAT:0,RAF:0,VERSION:2.3.4
X-CPASD-ID: b4422ce86f974f36a6a8bb0102ab501a-20220107
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1, 1
X-UUID: b4422ce86f974f36a6a8bb0102ab501a-20220107
X-User: lizhenneng@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <lizhenneng@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 611986031; Fri, 07 Jan 2022 18:11:05 +0800
From:   Zhenneng Li <lizhenneng@kylinos.cn>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zhenneng Li <lizhenneng@kylinos.cn>
Subject: [PATCH 2/2] drm/amdgpu: enable dcn support on arm64
Date:   Fri,  7 Jan 2022 17:57:32 +0800
Message-Id: <20220107095732.982194-3-lizhenneng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107095732.982194-1-lizhenneng@kylinos.cn>
References: <20220107095732.982194-1-lizhenneng@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
---
 drivers/gpu/drm/amd/display/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 127667e549c1..1c6c4cb1fd0a 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -6,7 +6,7 @@ config DRM_AMD_DC
 	bool "AMD DC - Enable new display engine"
 	default y
 	select SND_HDA_COMPONENT if SND_HDA_CORE
-	select DRM_AMD_DC_DCN if (X86 || PPC64) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
+	select DRM_AMD_DC_DCN if (X86 || PPC64 || (ARM64 && KERNEL_MODE_NEON)) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
 	help
 	  Choose this option if you want to use the new display engine
 	  support for AMDGPU. This adds required support for Vega and
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
