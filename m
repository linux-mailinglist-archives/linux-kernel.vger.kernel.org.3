Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E3358FF31
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiHKPVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiHKPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:20:58 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A23DBCC;
        Thu, 11 Aug 2022 08:20:56 -0700 (PDT)
X-QQ-mid: bizesmtp91t1660231252tpxlpmh5
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 23:20:47 +0800 (CST)
X-QQ-SSF: 0100000000200060B000B00A0000000
X-QQ-FEAT: 7Lv6dviieSTkIkfiWi6vr7/WReokV0mJGkaNMIfEWGttLpnU4KeFOwsZs+1CJ
        XJkfYeC60QjNVkFUI2camKyCeBmFwTy6gP/b5BCQQu848a6r38v3GKluemLxM9vlPjAWaSB
        5cmnbNbm9Jt53f2L8NamPESpCia896WMG3jrBQF/8MHkn4BtevWqMEnurOz/PBgcwjx0iy9
        iXjWpaZDZ9cmitG0YtWQwzYqLYskmlqBsJ81IMI2rBm+q2m6mDQ1wejXVr/B2KfBvteMB8l
        QQxpzeJ4WY5OfkrFIWmtvKrEewGZ+jQEN2IIGeffZiO0AUZunsXm17NYd/F3nxr4EWN6bEz
        KLKOhjtGkViWRAn7UAr5Q6xadBi/s2S6ETUCBdwVqChCRVl7p4qBPXCSZpHCcbUICopR71F
        12DEGgJhHAs=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     zajec5@gmail.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] bcma: Fix typo in comments
Date:   Thu, 11 Aug 2022 11:20:43 -0400
Message-Id: <20220811152043.11446-1-dengshaomin@cdjrlc.com>
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

Remove the repeated word "registers" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/bcma/driver_mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
index 12aca34e8db0..4f01e6b17bb9 100644
--- a/drivers/bcma/driver_mips.c
+++ b/drivers/bcma/driver_mips.c
@@ -30,7 +30,7 @@ enum bcma_boot_dev {
 	BCMA_BOOT_DEV_NAND,
 };
 
-/* The 47162a0 hangs when reading MIPS DMP registers registers */
+/* The 47162a0 hangs when reading MIPS DMP registers */
 static inline bool bcma_core_mips_bcm47162a0_quirk(struct bcma_device *dev)
 {
 	return dev->bus->chipinfo.id == BCMA_CHIP_ID_BCM47162 &&
-- 
2.35.1

