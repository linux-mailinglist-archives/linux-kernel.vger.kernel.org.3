Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C7956979F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiGGBiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiGGBiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:38:20 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101E32ED6D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 18:38:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VIadX3N_1657157894;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VIadX3N_1657157894)
          by smtp.aliyun-inc.com;
          Thu, 07 Jul 2022 09:38:14 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
        sunpeng.li@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: clean up some inconsistent indenting
Date:   Thu,  7 Jul 2022 09:38:12 +0800
Message-Id: <20220707013812.64057-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:405 get_bios_object_from_path_v3() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:611 bios_parser_get_hpd_info() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:818 bios_parser_get_device_tag() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1599 bios_parser_is_device_id_supported() warn: inconsistent indenting

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser2.c   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index c332650b7048..6f514d92b401 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -402,7 +402,7 @@ static struct atom_display_object_path_v3 *get_bios_object_from_path_v3(
 		return NULL;
 	}
 
-    return NULL;
+	return NULL;
 }
 
 static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
@@ -605,8 +605,8 @@ static enum bp_result bios_parser_get_hpd_info(
 	    default:
 	        object = get_bios_object(bp, id);
 
-			if (!object)
-				return BP_RESULT_BADINPUT;
+		if (!object)
+			return BP_RESULT_BADINPUT;
 
 	        record = get_hpd_record(bp, object);
 
@@ -810,10 +810,10 @@ static enum bp_result bios_parser_get_device_tag(
 	        /* getBiosObject will return MXM object */
 	        object = get_bios_object(bp, connector_object_id);
 
-			if (!object) {
-				BREAK_TO_DEBUGGER(); /* Invalid object id */
-				return BP_RESULT_BADINPUT;
-			}
+		if (!object) {
+			BREAK_TO_DEBUGGER(); /* Invalid object id */
+			return BP_RESULT_BADINPUT;
+		}
 
 	        info->acpi_device = 0; /* BIOS no longer provides this */
 	        info->dev_id = device_type_from_device_id(object->device_tag);
@@ -1596,7 +1596,7 @@ static bool bios_parser_is_device_id_supported(
 			break;
 	}
 
-    return false;
+	return false;
 }
 
 static uint32_t bios_parser_get_ss_entry_number(
-- 
2.20.1.7.g153144c

