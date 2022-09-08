Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E870D5B1D69
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiIHMmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiIHMlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:41:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A67B4425
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:41:36 -0700 (PDT)
X-QQ-mid: bizesmtp76t1662640886tyx8gc2h
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:41:24 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: fs34Pe/+C2R6x+YrnEANM1wHRE+loiFRNiN8+WfRdXQ13eACKf+RQTz+8oF1P
        ZuXoBR9tWArDfjhqLlUBUEYBPd4sWIeWEXyB2+FWDIXB2OszexxXs5kLO81rFsILrMD3WLU
        O+rBTaJ+90IhSN6e/rxqUDMbJNZPeg3Nh35IEk8J8mbpYQE7iIX8BJVrYNhDUsr/dQa2ewk
        2ZkTOGVyhnI6I/+SMD4lC1r3ULg6855tDiXDOPwYQVt379wFLXtO+Q4SKeopoKmHYE9jy6w
        HSi6nNUXcCAka2snYdCP39PGJHlS2sQoXtRzHNki5+2jwFLCtw9wzwXOGgZIUDV5/3aG5wu
        dmqVSl9uzg8x6KTkwGoea6qqIvDfgBlhi0sdeSSuin41vlAa7CMme+iklxljA==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] dc/dce: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:41:17 +0800
Message-Id: <20220908124117.21402-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index bdb6bac8dd97..c94a966c6612 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -300,7 +300,7 @@ static void set_high_bit_rate_capable(
 	AZ_REG_WRITE(AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_HBR, value);
 }
 
-/* set video latency in in ms/2+1 */
+/* set video latency in ms/2+1 */
 static void set_video_latency(
 	struct audio *audio,
 	int latency_in_ms)
-- 
2.36.1

