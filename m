Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EA059E69F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244079AbiHWQJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbiHWQIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:08:37 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FC83058C8;
        Tue, 23 Aug 2022 05:22:02 -0700 (PDT)
X-QQ-mid: bizesmtp82t1661257285tvampdxi
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 20:21:24 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: DQ0OCu3gog0eXFOOnpCwfQFj8W5pO1yvcYnu2yB4JEjFW0CpTRtb4p4mtINdw
        eRzERUAFTv7UB3UEcfhSh8ivr++4kI62EdT5P/cX8N4V/JkcroxZ1CsX7Pnkn6Ccg37ptx8
        Hy4aPKYuzmsHKM8g8tgGXvIriP3C1G8k3Idny93DtEOEG+ILZyHtmEBONjr4RnQIU8pyP1N
        Ab7bAvQXWhDt1Hly1zA0rOnDL6eSSDGCSI/13naVFjDdk6cWUJIz74T8v50J1JInJAd4u3h
        llYvT/ALwXZNDazh6y4I2cPFe7vVlY0yQrF/lGcDEawn4QJ0gshvjhO2xxHBeIpO98uqqAC
        bHsZlAAdE44FZ4NvSZpvdWx1VNSDucE8YOkZlCv6MYp+YpGr1DkQilj4TAmMTU/MWnyrcbT
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch, krzysztof.kozlowski@linaro.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/exynos: fix repeated words in comments
Date:   Tue, 23 Aug 2022 20:21:17 +0800
Message-Id: <20220823122117.15757-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'next'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 471fd6c8135f..4f9edca66632 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1195,7 +1195,7 @@ int exynos_g2d_set_cmdlist_ioctl(struct drm_device *drm_dev, void *data,
 	 * If don't clear SFR registers, the cmdlist is affected by register
 	 * values of previous cmdlist. G2D hw executes SFR clear command and
 	 * a next command at the same time then the next command is ignored and
-	 * is executed rightly from next next command, so needs a dummy command
+	 * is executed rightly from next command, so needs a dummy command
 	 * to next command of SFR clear command.
 	 */
 	cmdlist->data[cmdlist->last++] = G2D_SOFT_RESET;
-- 
2.36.1

