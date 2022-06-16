Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A65054E328
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377605AbiFPOQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiFPOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:16:20 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF0924BF2;
        Thu, 16 Jun 2022 07:16:09 -0700 (PDT)
X-QQ-mid: bizesmtp73t1655388936te84ol4k
Received: from localhost.localdomain ( [153.0.97.30])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 16 Jun 2022 22:15:30 +0800 (CST)
X-QQ-SSF: 01000000003000D0I000B00A0000000
X-QQ-FEAT: rDVzBkvD//YLDwnPANlvrHAlKPDEbPwgQ2HSKDcek4Llnwe5aVQKtmWVbq2qr
        u80NhtcuRwxAuSsC0lvRI43BtAKe0tVS5DU3YHjokYpFYw+kBRGrkfLRttT9zO1pAyM5hWx
        gLkkCTee6jy+lp4hv7GA8t2l7zrqZk7m1BGYqO57B3HNJm2A6jTa1uNSXL6flmNtMk/BPtr
        0ghpYmixSjWIvmXK//RyAfJxYUEKzJ+dxDbEFUwo5GjnlXhrm4nl33xQvrSoxv502N9v965
        PbWYevjr2La5fyF7GIipgHCy+mChpYRDGxOACy+bMpLkzijzbcsLk3rU8=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] iio: Fix typo in comment
Date:   Thu, 16 Jun 2022 22:15:22 +0800
Message-Id: <20220616141522.2238-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/iio/gyro/bmg160_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 81a6d09788bd..cedd9f02ea21 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -766,7 +766,7 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
 		return 0;
 	}
 	/*
-	 * We will expect the enable and disable to do operation in
+	 * We will expect the enable and disable to do operation
 	 * in reverse order. This will happen here anyway as our
 	 * resume operation uses sync mode runtime pm calls, the
 	 * suspend operation will be delayed by autosuspend delay
-- 
2.36.1

