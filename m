Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51BC567D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiGFE6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGFE6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:58:34 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 059391571D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 21:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HkwIy
        c9p7ULhqlETt5oNPcBKwEPx0xfgOW9txY0JjbE=; b=jjUGPU2ocezyxvss5D704
        F8J0R51wUnbBS5qHEcnQkZu/RhK2jCO+PILLOt80hpSZ5f6t+arWrnu3kBT5iQCP
        WSXm2KZ7ym8bsgHbddJmY0Z5G7BNY6510EotMhLFt6MPa3tt4UgpuxWmfRXMGJi4
        1TPBzM7WK0rzmB7if69HbY=
Received: from bf-rmsz-11.ccdomain.com (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowACHraswFsViC24FLw--.4616S2;
        Wed, 06 Jul 2022 12:57:21 +0800 (CST)
From:   Zhongjun Tan <hbut_tan@163.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, chandan.vurdigerenataraj@amd.com,
        aurabindo.pillai@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Zhongjun Tan <tanzhongjun@coolpad.com>
Subject: [PATCH] drm/amdgpu/display: Remove duplicated argument to ||
Date:   Wed,  6 Jul 2022 12:57:12 +0800
Message-Id: <20220706045712.19930-1-hbut_tan@163.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowACHraswFsViC24FLw--.4616S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4kJrWDuFyxZFykJryUGFg_yoWDAFb_KF
        10vr9aq3WfZ3WqqrWxZr4ruw1Fqa15GFs7Jry2g34Iyw17Wr4jgF93GrnaqF1jyFs7AFZI
        y3WvkF1kXa97GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnqjg3UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: xkex3sxwdqqiywtou0bp/1tbiSBE2xl+Fe1c9EwAAsx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhongjun Tan <tanzhongjun@coolpad.com>

Remove duplicated argument to ||

Signed-off-by: Zhongjun Tan <tanzhongjun@coolpad.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 07f3a85f8edf..5a701d9df0f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -275,7 +275,7 @@ void dml32_CalculateBytePerPixelAndBlockSizes(
 		*BytePerPixelDETC = 0;
 		*BytePerPixelY = 4;
 		*BytePerPixelC = 0;
-	} else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16) {
+	} else if (SourcePixelFormat == dm_444_16) {
 		*BytePerPixelDETY = 2;
 		*BytePerPixelDETC = 0;
 		*BytePerPixelY = 2;
-- 
2.29.0

