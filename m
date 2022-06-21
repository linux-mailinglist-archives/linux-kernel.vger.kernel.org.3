Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAEB552B41
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346194AbiFUGoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346026AbiFUGoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:44:12 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EFA1B7B1;
        Mon, 20 Jun 2022 23:44:08 -0700 (PDT)
X-QQ-mid: bizesmtp65t1655793811tlg7zu1o
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 14:43:23 +0800 (CST)
X-QQ-SSF: 01000000007000109000B00A0000000
X-QQ-FEAT: HDjpALELSmGBnafpOVGCHO6n8VKZ7Qkc5FO1v5nS31UOccX/mYQqbgg0hy3hM
        asyjlJqOwRF5+Nvvw0mjDghhpY5L1f8k/Iq7w38y5tRR0DaQrbzQyfr+5nJsjnmQmsFHppN
        7oztY6pNdOyJmKyMLbpnkzVrTHcegfAyOqPrc2qYEayr0r+bM64e9XAzVa/kicQ1FcUvV5J
        F5acnuGyqY3GN3bpVWTItXaLQjdR5BAVcnpLMxbGP/3aE4xpaFUt2KCcU0JhVf/8Jn9Z786
        qxBh+5pNJ97ass3us8lBnOOGuWuVtKlWWx3IbUPrUqqP73hx7/PUm+3Ag77i/JNh1nFwejZ
        ZmhrmJd
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiangjian@cdjrlc.com
Subject: [PATCH] iio: aligned '*' each line
Date:   Tue, 21 Jun 2022 14:43:21 +0800
Message-Id: <20220621064321.25635-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider '*' alignment in comments

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/iio/dac/ad5380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index a44c83242fb1..f8291cb013ce 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -36,7 +36,7 @@
  * @channel_template:	channel specification template
  * @num_channels:	number of channels
  * @int_vref:		internal vref in uV
-*/
+ */
 
 struct ad5380_chip_info {
 	struct iio_chan_spec	channel_template;
-- 
2.17.1

