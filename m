Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5CF597BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbiHRC7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242747AbiHRC7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:59:17 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D8943E49
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:59:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VMYvMC6_1660791553;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VMYvMC6_1660791553)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 10:59:14 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: remove unneeded semicolon
Date:   Thu, 18 Aug 2022 10:59:12 +0800
Message-Id: <20220818025912.87327-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Semicolon is not required after curly braces.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1918
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index beb025cd3dc2..1995e1d708d9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -614,7 +614,7 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
 		bw_params->clk_table.entries[i].wck_ratio = convert_wck_ratio(
 			clock_table->DfPstateTable[min_pstate].WckRatio);
-	};
+	}
 
 	/* Make sure to include at least one entry at highest pstate */
 	if (max_pstate != min_pstate || i == 0) {
-- 
2.20.1.7.g153144c

