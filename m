Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3C53D51E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348356AbiFDEGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFDEGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:06:35 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F351E3FE;
        Fri,  3 Jun 2022 21:06:29 -0700 (PDT)
X-QQ-mid: bizesmtp85t1654315550t1emksxm
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Jun 2022 12:05:42 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: 8HDoZm2y6fhLMESSHnW6YoorsIxnsaK+ThMZijZ8nsOBz5fGc6Kv/OKTK5rkh
        sUJBUdRqc2Qa02URm8oeA9NlWs+sCMTUdEPAyr95dDwX6s7rSkA+v0EaaeBX6EneV63iCMN
        FVne8h7pLxjxDZr/wyF1Z9IWcP+upSirOaf5MRibBUqRDWU6GkGQBQpTVbE5HnyS5FnsuBX
        yRUxRiuExKudwm1w0rfH9UkwmzYJIABwp4tPAa2Wmyefs8NGp2DIkkis+ngOKdtLOoEbu77
        un8j9q1m1DEsATeD81Det0YVSqIYx+8AXDStEsEfZqBoASMl6WkuIHAaw=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] iio: accel: sca3000: Fix syntax errors in comments
Date:   Sat,  4 Jun 2022 12:05:41 +0800
Message-Id: <20220604040541.8470-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'via'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/iio/accel/sca3000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 29a68a7d34cd..08dedee76e46 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -424,7 +424,7 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
  * sca3000_print_rev() - sysfs interface to read the chip revision number
  * @indio_dev: Device instance specific generic IIO data.
  * Driver specific device instance data can be obtained via
- * via iio_priv(indio_dev)
+ * iio_priv(indio_dev)
  */
 static int sca3000_print_rev(struct iio_dev *indio_dev)
 {
-- 
2.36.1

