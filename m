Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D92591B6F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbiHMPe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiHMPe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:34:57 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9151EC4F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 08:34:55 -0700 (PDT)
X-QQ-mid: bizesmtp83t1660404880tmhkwk9h
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 13 Aug 2022 23:34:33 +0800 (CST)
X-QQ-SSF: 0100000000200080H000B00A0000020
X-QQ-FEAT: ao4JQgu0M39k2YuXdaMww2Xpj7yFVsZdElscKH/kG6xdjcbJlkdsynj1frJMm
        DPgyYwtCVUbGGdblLd18IjZ5nE9SSMpygzZvukm4g5S95VkUa5IOBLfg8dKwSEWTp2BA0kJ
        xmkf9ycHpSbClO0QyF1uA9yl+t9TK0uRHiQZYmTf6Y5jEJKr+QeercZwhuwSLJJT+QJvYTp
        2cZkT9t2VXDamXUhxyFKBwmJySyUVU9dxpMY89n5C2Orz0GbeMgXchdSx28lkHAQteC9qoq
        9UZvkyDC8TBJkS/SGO9cJFXew96ewfYENKukPjZxR6o/wmbFE7R6kpcGXVXkTALayYDTNpF
        cUulzg801p9zHnLA1BCLkZ99HWt7otEe9GOUxHMHMw4UQsVMeclidz0ZnShkg==
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, Charlene.Liu@amd.com,
        qingqing.zhuo@amd.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, min tang <tangmin@cdjrlc.com>
Subject: [PATCH] drm/amd/display: Unneeded semicolon
Date:   Sat, 13 Aug 2022 23:34:21 +0800
Message-Id: <20220813153421.4754-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no semicolon after '}' in line 510.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 27501b735a9c..c87cf8771c6d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -505,7 +505,7 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 		bw_params->clk_table.entries[i].dispclk_mhz = clock_table->DispClocks[i];
 		bw_params->clk_table.entries[i].dppclk_mhz = clock_table->DppClocks[i];
 		bw_params->clk_table.entries[i].wck_ratio = 1;
-	};
+	}
 
 	/* Make sure to include at least one entry and highest pstate */
 	if (max_pstate != min_pstate || i == 0) {
-- 
2.17.1

