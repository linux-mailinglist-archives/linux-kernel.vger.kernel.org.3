Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73EA5A3887
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiH0Pxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 11:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiH0Pxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 11:53:30 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA5C30F58;
        Sat, 27 Aug 2022 08:53:28 -0700 (PDT)
X-QQ-mid: bizesmtp73t1661615593tev1dwfc
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 27 Aug 2022 23:53:07 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: HHPuPN/BfjWVIbtH5sgpHE5/n72T7kqKGrJrNjJt9MwoxM2DRYa4NFX0P8+cN
        M5cVFIo5xn/KWB5fd7w+HsksrUS8mSwpYEYjqBLFadO+Xg+EK9TyAiyOfXJS6E9imRmtUhy
        kMxlpPwxWQ7YELF1D90UZLl01jgp5CMujGvsU3YU/ViGCz1/QiKZcjpsl2eKapWrzDTrX+V
        /xb4jVkFVLjD+2D9WelF4aK61nGFITz0eLnvozTnsaD7ywvrb7FdQx38W/1kjT5ryh9+58X
        qvHA+bNuHMjWsyA0GKP8Kk8f1AQQOQcjRuGLQlFUUnt/qGg8POjz530CCzup/A2l975msOL
        +QKK5Rwg3csFH4TYRtS8h/wcbXfnT9OmYc0nmXqXMgE9tlExc4SDVwGQkDugw==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     hauke@hauke-m.de, zajec5@gmail.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] MIPS: BCM77xx: Fix comments typo
Date:   Sat, 27 Aug 2022 11:53:06 -0400
Message-Id: <20220827155306.11757-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the unneeded word "that" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 arch/mips/bcm47xx/prom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 0a63721d0fbf..bcb9c90ea041 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -69,7 +69,7 @@ static __init void prom_init_mem(void)
 	 * call them at the beginning of the boot.
 	 *
 	 * BCM47XX uses 128MB for addressing the ram, if the system contains
-	 * less that that amount of ram it remaps the ram more often into the
+	 * less that amount of ram it remaps the ram more often into the
 	 * available space.
 	 */
 
-- 
2.35.1

