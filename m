Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637B95B1EAC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiIHNXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiIHNXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:23:34 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4167F11367C;
        Thu,  8 Sep 2022 06:23:27 -0700 (PDT)
X-QQ-mid: bizesmtp73t1662643386twqdhbes
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 21:23:05 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: H7ipuM2k/9rDN4LU8B4FLRvLlR3aaAx/BK5mxwL7QMcJDiqldZpqY4hAHShAS
        i/tdrYTVuZOZvilWRmVkj94XisSnJ1zvTnp2W5u/Axo6/TTFyn1qjizfWJWhYltJsuZRZNp
        wF/phUh+TemmhMEgcMpVBW6STiOWXbJ+5wXBLuTHkdxI+Gzk5LNvjgM3QYNlbkuLVlwzush
        sOwLxXIHuO5Q9dIEe1Q2VaGN3QM/LQ6ztBJspnkiRrkr9WjzI3SJrWNoYdMU6BCyoe7hZsT
        PfZJsOekSxgspfXKXNgxwtJnWEdFsHviNu96AlAu4WRzsXTxhf5k1dg5nORg71ZWWBjW9Yj
        0JV2ELXW522EAIscVWJnUkQ0K2TBoMEPIdzylQXUKga2U7M+WyRkE4wxste2w==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/rtc: fix repeated words in comments
Date:   Thu,  8 Sep 2022 21:22:58 +0800
Message-Id: <20220908132258.43674-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/rtc/rtc-ds1286.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1286.c b/drivers/rtc/rtc-ds1286.c
index 7acf849d4902..858682f67848 100644
--- a/drivers/rtc/rtc-ds1286.c
+++ b/drivers/rtc/rtc-ds1286.c
@@ -157,7 +157,7 @@ static int ds1286_read_time(struct device *dev, struct rtc_time *tm)
 	/*
 	 * read RTC once any update in progress is done. The update
 	 * can take just over 2ms. We wait 10 to 20ms. There is no need to
-	 * to poll-wait (up to 1s - eeccch) for the falling edge of RTC_UIP.
+	 * poll-wait (up to 1s - eeccch) for the falling edge of RTC_UIP.
 	 * If you need to know *exactly* when a second has started, enable
 	 * periodic update complete interrupts, (via ioctl) and then
 	 * immediately read /dev/rtc which will block until you get the IRQ.
-- 
2.36.1

