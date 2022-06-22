Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC7F554119
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345286AbiFVEBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiFVEBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:01:13 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527612F031;
        Tue, 21 Jun 2022 21:01:09 -0700 (PDT)
X-QQ-mid: bizesmtp65t1655870373tceldupx
Received: from ubuntu.localdomain ( [106.117.99.132])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 11:59:28 +0800 (CST)
X-QQ-SSF: 01000000000000B0B000000A0000000
X-QQ-FEAT: ACkb0FcbxRnYk73geYpLkbkj9vr6F9nivVRrtN6oXB7SIWL2x8lhOjZy1Prol
        0+Rfghy0oToGgu3XLckfcn1opdu2DHWCo6D13JUgoFaIYVtDqPI1xsHRLHYnDwNTmJedES0
        3PnxwtrD5PPsAii9NjvmaL1udANFGrJXXryJzGHRjL7of2TogmR1v/d/kB8I9adWUFeL3DV
        QgWb8IBi1/r5otL4URPdjzi+o8C4FqJfWe9L82CW5MGw74AQ1W95O3qTILTMYdcT3VnWjqK
        jqIEJs8piwwTxf0CxPki/cfPoTZHO+qzFofCn3sJJrcF0ILjCFpjblGWHPTUP0vxoKDZkeL
        WWEYnktW0WhE+uVuCviAz/9FIEQmOuALfPsuvSY
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, ardeleanalex@gmail.com, andy.shevchenko@gmail.com,
        antoniu.miclaus@analog.com, u.kleine-koenig@pengutronix.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH v2] iio: magnetometer: hmc5843: Remove duplicate 'the'
Date:   Wed, 22 Jun 2022 11:59:25 +0800
Message-Id: <20220622035925.5008-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an obvious typing error, found by spellcheck(1).

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

