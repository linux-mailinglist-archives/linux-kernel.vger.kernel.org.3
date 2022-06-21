Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49D7552E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348125AbiFUJYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347543AbiFUJYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:24:09 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B640237E4;
        Tue, 21 Jun 2022 02:24:04 -0700 (PDT)
X-QQ-mid: bizesmtp83t1655803408t46n8ffl
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 17:23:21 +0800 (CST)
X-QQ-SSF: 0100000000700030B000D00A0000000
X-QQ-FEAT: im3L/SzDuHYGcURFVRUx4/0cBDy8sD85syTxTRFAP/ZlUJvc5zPV9r7qa2WOo
        aB4gonDUFHXANd88qOUQF/fX/+4QPdeZbxUUvpLQtV4MpnVem2l/IaaNX7C9k2V16r0k1yx
        JM9DF+q+Y8AhI26/OFA9+D1LedM/YpfQndkyenzAQ3QnNYNosC86xLgetEWVqJkRkwv08oQ
        ywWGfWuPDMuT2viduW6uGJnAM4zlZ+x9OL19RqCgNI/dCNReJIjpVtHC+jNOer6HLYr+ANB
        TROxYl9Msh4YuepERHtTPvQzmUEjIEhhQdbPOFT0x7RhuCj2b3nyUsd23anyQldtPES6Bqw
        bEY0n2QBnc4ahPmS8r0qWdADZ04JQ==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] iio: dac: ad5380: aligned '*' each line and drop unneeded blank line
Date:   Tue, 21 Jun 2022 17:23:19 +0800
Message-Id: <20220621092319.69598-1-jiangjian@cdjrlc.com>
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

Consider '*' alignment in the comments of struct ad5380_chip_info declaration.

...
>   * @channel_template:  channel specification template
>   * @num_channels:      number of channels
>   * @int_vref:          internal vref in uV
> -*/
> + */
>
While at it, drop the unneeded blank line here.
>  struct ad5380_chip_info {
...
}

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/iio/dac/ad5380.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index a44c83242fb1..81775152aac6 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -36,8 +36,7 @@
  * @channel_template:	channel specification template
  * @num_channels:	number of channels
  * @int_vref:		internal vref in uV
-*/
-
+ */
 struct ad5380_chip_info {
 	struct iio_chan_spec	channel_template;
 	unsigned int		num_channels;
@@ -53,7 +52,6 @@ struct ad5380_chip_info {
  * @pwr_down:		whether the chip is currently in power down mode
  * @lock:		lock to protect the data buffer during regmap ops
  */
-
 struct ad5380_state {
 	struct regmap			*regmap;
 	const struct ad5380_chip_info	*chip_info;
-- 
2.17.1

