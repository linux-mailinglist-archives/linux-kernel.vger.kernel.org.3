Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D4456B0F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 05:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbiGHDLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 23:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiGHDLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 23:11:23 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BD3373594
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 20:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=r2cOE
        uXAAAXANaMg92EJ+3l5uhuP8HS5zodz6szymtE=; b=i+kRGJxaXdIw8n7aqMDzz
        q9fxpRfqZIYhU2xDope3LqxrkoA28HKBkTH3yxfAa5ZyIiJ5BE0r5i+QsqsQaZ3b
        V0rhHi4/gakJsjpCyu5NNCgyvGdk0jw30unpsOpclpYhuabA5NxdmSmixEovfPUK
        ghEnHdh8DSNPXrC8dgRpU8=
Received: from bf-rmsz-11.ccdomain.com (unknown [218.17.89.92])
        by smtp13 (Coremail) with SMTP id EcCowACHj2E_oMdi_5ZWMQ--.36352S2;
        Fri, 08 Jul 2022 11:10:57 +0800 (CST)
From:   Zhongjun Tan <hbut_tan@163.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, chandan.vurdigerenataraj@amd.com,
        tanzhongjun@coolpad.com, aurabindo.pillai@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Remove condition with no effect
Date:   Fri,  8 Jul 2022 11:10:48 +0800
Message-Id: <20220708031048.43472-1-hbut_tan@163.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowACHj2E_oMdi_5ZWMQ--.36352S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1DAF45trWUArWUXr4xZwb_yoWkWFbEgF
        4vqFn5Kr15Ar4qgr47Zr1F9ryvvan8KF4DXrWIq3s0ywnIga47GFZ7GwnrWr1jvFsrXFZI
        ya10kF48Can7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnDKsUUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: xkex3sxwdqqiywtou0bp/1tbiSAE4xl+Fe25bJwAAsE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhongjun Tan <tanzhongjun@coolpad.com>

Remove condition with no effect

Signed-off-by: Zhongjun Tan <tanzhongjun@coolpad.com>
---
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 07f3a85f8edf..ec3ea94d3802 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -4670,10 +4670,6 @@ void dml32_CalculateMinAndMaxPrefetchMode(
 	} else if (AllowForPStateChangeOrStutterInVBlankFinal == dm_prefetch_support_uclk_fclk_and_stutter) {
 		*MinPrefetchMode = 0;
 		*MaxPrefetchMode = 0;
-	} else if (AllowForPStateChangeOrStutterInVBlankFinal ==
-			dm_prefetch_support_uclk_fclk_and_stutter_if_possible) {
-		*MinPrefetchMode = 0;
-		*MaxPrefetchMode = 3;
 	} else {
 		*MinPrefetchMode = 0;
 		*MaxPrefetchMode = 3;
-- 
2.29.0

