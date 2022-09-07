Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096585B02DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiIGL1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIGL12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:27:28 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A8DB2CD8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:27:27 -0700 (PDT)
X-QQ-mid: bizesmtp70t1662550025tjf5rbk4
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Sep 2022 19:27:03 +0800 (CST)
X-QQ-SSF: 01000000002000D0F000B00A0000000
X-QQ-FEAT: tyV+f0f3wWeQiR6EYZ3U6gcbzZzTNIw1jhLYW1neIWk2Dze/dTI9mm0Js0y0w
        40J2DsHskt8+GcB+WaxWWkWGpbGut8Zdjo7kRU7KpqeiWBOJTsTjOP0048iTBrcqWwjRh6Y
        5GEqgiBPNCiR9R/5DMlndFyTfiPfuccw0o/wtB3nSHiMswA9xqwpAkLCiRR2K73frFU4YBM
        o/XJKQe9lAU0u8kBhbBgZ9/UpxNIiPJGcD8EVRXB0NDEp5Pw2jlHkFn/2qMTCXYNRzg4K99
        6+X1HQ4odbZ3XWMb+eytYqV62VLuv8OAppF5eODOk2hkkA2Ocd7sP6P1K8mAk9kWx1LaLeb
        5NgbLIg15oEiE5ArTtgfbFjyJ71mwT+Jo+gnuZs8XMV32j+7OzuGw8/h03E9g==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch, isabbasso@riseup.net
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/amdgpu: fix repeated words in comments
Date:   Wed,  7 Sep 2022 19:26:57 +0800
Message-Id: <20220907112657.25150-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'we'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 02cb3a12dd76..6d6cc4637d41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -694,7 +694,7 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
  * @allocated: allocated a new handle?
  *
  * Validates the handle and return the found session index or -EINVAL
- * we we don't have another free session index.
+ * we don't have another free session index.
  */
 static int amdgpu_vce_validate_handle(struct amdgpu_cs_parser *p,
 				      uint32_t handle, uint32_t *allocated)
-- 
2.36.1

