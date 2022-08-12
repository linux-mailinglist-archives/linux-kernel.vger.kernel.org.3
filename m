Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D9A5909F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 03:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiHLBja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbiHLBjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:39:24 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A832698CA8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:39:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VM.Wval_1660268357;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VM.Wval_1660268357)
          by smtp.aliyun-inc.com;
          Fri, 12 Aug 2022 09:39:18 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     daniel@ffwll.ch
Cc:     airlied@linux.ie, Xinhui.Pan@amd.com, christian.koenig@amd.com,
        alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
        sunpeng.li@amd.com, harry.wentland@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 3/4] drm/amd/display: clean up one inconsistent indenting
Date:   Fri, 12 Aug 2022 09:39:11 +0800
Message-Id: <20220812013912.70000-3-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220812013912.70000-1-yang.lee@linux.alibaba.com>
References: <20220812013912.70000-1-yang.lee@linux.alibaba.com>
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

The indentation of statements in the same curly bracket should be
consistent.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1890
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1891
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 5b5d952b2b8c..4ac8e4fcba77 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2151,8 +2151,8 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
 				dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
 					dc->res_pool->dp_clock_source,
 					grouped_pipes[i]->stream_res.tg->inst, &pclk);
-					grouped_pipes[i]->stream->timing.pix_clk_100hz =
-						pclk*get_clock_divider(grouped_pipes[i], false);
+				grouped_pipes[i]->stream->timing.pix_clk_100hz =
+					pclk*get_clock_divider(grouped_pipes[i], false);
 				if (master == -1)
 					master = i;
 			}
@@ -2206,7 +2206,7 @@ void dcn10_enable_vblanks_synchronization(
 				grouped_pipes[i]->stream->timing.pix_clk_100hz,
 				get_clock_divider(grouped_pipes[master], false),
 				get_clock_divider(grouped_pipes[i], false));
-				grouped_pipes[i]->stream->vblank_synchronized = true;
+			grouped_pipes[i]->stream->vblank_synchronized = true;
 		}
 		grouped_pipes[master]->stream->vblank_synchronized = true;
 		DC_SYNC_INFO("Sync complete\n");
-- 
2.20.1.7.g153144c

