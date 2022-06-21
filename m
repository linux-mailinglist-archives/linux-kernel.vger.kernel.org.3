Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3885E55381D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351517AbiFUQmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiFUQmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:42:49 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC26520199;
        Tue, 21 Jun 2022 09:42:43 -0700 (PDT)
X-QQ-mid: bizesmtp69t1655829664tbhg73p6
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 00:40:59 +0800 (CST)
X-QQ-SSF: 0100000000700090B000B00A0000000
X-QQ-FEAT: cS/tZYixAvZiukInQCdTcdOOhi5eOQ/aoboSNmq+SIDSsYqGkjEJKp0m3BM1w
        xYgsGzfYuLyV02bshFMRr069godo/YqkFgPbCrRLz3hx/OnyBK73ecDmN0Ad+QLFn9af1SW
        kwGfGdsWlO4eH92GEuvSqJYUQE8DBwpCrnXjZmvf2CyoYWNiaS7Z5izJ8np/0KgPl/SYNzE
        ENHzZxrfVzZJFhfBK4+R1EGcsKEi1RXFiYNBM7Eg//SpMInCSDqqNdxjunx8TUGQS1F6Gs2
        VzEG4fxdZCFfAYiSv+rL/0Ct0tOQiVImYN3feHt3Xj+V78Cu3dfQQZz5NNAoIfN805QnPIt
        NKhPQrK95PPz5jauMM=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, ardeleanalex@gmail.com,
        u.kleine-koenig@pengutronix.de, jiangjian@cdjrlc.com,
        antoniu.miclaus@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio:magnetometer:hmc5843: Remove duplicate 'the' in two places.
Date:   Wed, 22 Jun 2022 00:40:56 +0800
Message-Id: <20220621164056.30622-1-jiangjian@cdjrlc.com>
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

file: drivers/iio/magnetometer/hmc5843_core.c
line: 3
  * Device driver for the the HMC5843 multi-chip module designed
changed to
  * Device driver for the HMC5843 multi-chip module designed

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/iio/magnetometer/hmc5843_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index 92eb2d156ddb..4a63b2da9df0 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Device driver for the the HMC5843 multi-chip module designed
+ * Device driver for the HMC5843 multi-chip module designed
  * for low field magnetic sensing.
  *
  * Copyright (C) 2010 Texas Instruments
-- 
2.17.1

