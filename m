Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A015533B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbiFUNfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351955AbiFUNdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:33:13 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EE72936F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:31:30 -0700 (PDT)
X-QQ-mid: bizesmtp79t1655818272t2kqiz35
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 21:31:09 +0800 (CST)
X-QQ-SSF: 0100000000700050B000D00A0000000
X-QQ-FEAT: hOPADF7UwX6UhkRp296GqMQ5mOWCHugCJHmaYevsI0MlO0eU+rKDA7c6457hY
        9I2erBsA16xegyGcn6PVyHxiQZorUFP1wl6X9AxcJ9ukwsqpDlk6dPes9zoNZffDspquUDG
        oHfkA2vNSBVmGa/AKibWMUT7DCFr4foPJ2OHZiK92CzwCXdc5rdeNNPsBlpALD39PbWUtaX
        oEwWM3NaGMTUUBRWrrQGjmVnAcX1+2dTzZfsUVVZEO3PCOdekoBufY2ksffLukQrMm2BiUc
        BalZEmO1GKhx/DS/bcjuGuLPmDn5uybYs1Gu2dkS3L27EpFevRjfmawZpOMAO+r0yyyahJs
        j/AxtBaTKUm7TOMFu+/BIABUrnYTFWxiqciKXfs
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     emma@anholt.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] drm/pl111: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 21:31:07 +0800
Message-Id: <20220621133107.3752-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/gpu/drm/pl111/pl111_display.c
line: 251
* Note that the the ARM hardware's format reader takes 'r' from
changed to
* Note that the the ARM hardware's format reader takes 'r' from

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/pl111/pl111_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 443e3b932322..2fdd3b968e87 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -248,7 +248,7 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		cntl |= CNTL_ST_CDWID_24;
 
 	/*
-	 * Note that the the ARM hardware's format reader takes 'r' from
+	 * Note that the ARM hardware's format reader takes 'r' from
 	 * the low bit, while DRM formats list channels from high bit
 	 * to low bit as you read left to right. The ST Micro version of
 	 * the PL110 (LCDC) however uses the standard DRM format.
-- 
2.17.1

