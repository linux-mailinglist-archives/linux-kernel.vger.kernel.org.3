Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA157C6C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiGUIpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiGUIp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:45:27 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D402F66AFE;
        Thu, 21 Jul 2022 01:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VF1d/
        zy/I1K/UAjSmUA6VGtL7nm0QEknMtj94x7d39U=; b=ob5Oo8pyt8IyFdXiDTR9x
        zUUThDcevPZ7InEPAuPrIuTP0iJhZyXOkIqFIQ63z41hyUiNw2rDmxmcUJvP2kXO
        mgIrOX8z3u05LNZs1FzgbhIL0RYkceRuMJWZJkEbbmYaqFNK+FxwuMPS5AEcOHUi
        zvQkK1805Xi4MA1WW3SszE=
Received: from localhost.localdomain (unknown [223.104.68.234])
        by smtp10 (Coremail) with SMTP id DsCowABnN7D7EdliKy7aOQ--.124S2;
        Thu, 21 Jul 2022 16:44:47 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] iio: magn: hmc5843: Fix typo 'the the' in comment
Date:   Thu, 21 Jul 2022 16:44:41 +0800
Message-Id: <20220721084441.50065-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABnN7D7EdliKy7aOQ--.124S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1fur47tr1xJrWxCrg_yoW3GrgEqr
        4rXrs3X3WSyw1UAw42q3Z0vF92ya4DZFs3Ar4ayry3Wr9ruw4DZr18tws8Aw15Zr4UCa9r
        XrZ0yw1xAw1kWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiy89DUUUUU==
X-Originating-IP: [223.104.68.234]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivx9FZFWB0i9O3AAAs6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
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
2.25.1

