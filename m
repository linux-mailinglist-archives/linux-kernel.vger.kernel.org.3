Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CFC5A671A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiH3PQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiH3PQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:16:39 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7C6EF9FD;
        Tue, 30 Aug 2022 08:16:36 -0700 (PDT)
X-QQ-mid: bizesmtp88t1661872564t27khvye
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 Aug 2022 23:15:58 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: +oIWmpEafD/Bpx4MTlGOKDu0lfe5GgDUAfsbEqkDTL3d5YH3Z8lHoGNNL9STg
        8C61d+HfEQyN8lsC6jg1Lz7t8RhYRydXJxyKvwypS1EzoQ2uLpQ4sc4lZolQdtN+g+OMOQM
        l6VEQTSAN0lTcbl3PkSjtry4Nx0y2vrBsUqZm2fjRyi+duXnDoXx9YBYoCfNHn4QwnAzHPN
        SxnsKeGsp97iovep7SazkMWaglfwXWX/+HaTMwwIsyB1wA9z8cA17JDu2NFEc2cPxWEJ5zG
        5diNsFgz1yJGAzcuRrA2ZiI2n7B2zQEiTt5Sox6RcUqRLbzJlYxBF55tjXrJo80pkHvJSpV
        +RcuYHBHM3xnJKN94bhRKTC2+VZt5o/J1PznK1TdB3O0nX8Tcl1g/oFEXtQ7r7jCNyJe2tK
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com, DDRokosov@sberdevices.ru,
        yangyingliang@huawei.com, u.kleine-koenig@pengutronix.de,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] iio:accel:kxcjk-1013: Fix comments typo
Date:   Tue, 30 Aug 2022 11:15:55 -0400
Message-Id: <20220830151555.27140-1-dengshaomin@cdjrlc.com>
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

Fix double word in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/iio/accel/kxcjk-1013.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 94f7b6ac5c87..adc66b3615c0 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1064,7 +1064,7 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 
 	/*
 	 * We will expect the enable and disable to do operation in
-	 * in reverse order. This will happen here anyway as our
+	 * reverse order. This will happen here anyway as our
 	 * resume operation uses sync mode runtime pm calls, the
 	 * suspend operation will be delayed by autosuspend delay
 	 * So the disable operation will still happen in reverse of
-- 
2.35.1

