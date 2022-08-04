Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1E589B57
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbiHDMBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiHDMBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:01:05 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A454F648;
        Thu,  4 Aug 2022 05:01:03 -0700 (PDT)
X-QQ-mid: bizesmtp64t1659614458tv7kl1j1
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 20:00:57 +0800 (CST)
X-QQ-SSF: 01000000008000F0U000B00A0000020
X-QQ-FEAT: 7YFKcddXaghnL1R2jIO6ZTnUxZn4tmOaUDRjmUsIKeZOlW4+2fQct1jLYN9S4
        nofSP0yL45FiNtY3U7oUgUKtlLWeFvsUhT1/c12W2+Yb0JyAIabPeXc8upeP5ebmBUn+PWA
        YUIbOLA3qfpSy1ALt6fmZxQiy6G5Nra78jEQHk7Hq+WFqchm4xQ9aUXqmpSsw9rQSSJY8An
        ihmuA4Cgi6U5K/hdO8LY58E/tMQBMcE5AlmeJieXRsEvJZHUbdThRO4p2s5fs/krXD922bt
        fc7V8PUfRmR3XeasFviQZ3USJyADI9FZMOot9eoXnj0a7CadyMiCaqQQQoO2jgr/+pfLaUs
        iIlJA6O5jyUYlyjUyw3S1aX1BN9WeDs4DWNW7FW8wdIWoWbEMSHhGv+LlUcIUlxCgOCarQp
        kaQSaZ20xjI=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     awalls@md.metrocast.net, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: pci/ivtv: Fix comment typo
Date:   Thu,  4 Aug 2022 20:00:55 +0800
Message-Id: <20220804120055.55273-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/pci/ivtv/ivtv-yuv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ivtv/ivtv-yuv.c b/drivers/media/pci/ivtv/ivtv-yuv.c
index e79e8a5a744a..4ba10c34a16a 100644
--- a/drivers/media/pci/ivtv/ivtv-yuv.c
+++ b/drivers/media/pci/ivtv/ivtv-yuv.c
@@ -538,7 +538,7 @@ static void ivtv_yuv_handle_vertical(struct ivtv *itv, struct yuv_frame_info *f)
 	reg_2964 = (reg_2964 << 16) + reg_2964 + (reg_2964 * 46 / 94);
 
 	/* Okay, we've wasted time working out the correct value,
-	   but if we use it, it fouls the the window alignment.
+	   but if we use it, it fouls the window alignment.
 	   Fudge it to what we want... */
 	reg_2964 = 0x00010001 + ((reg_2964 & 0x0000FFFF) - (reg_2964 >> 16));
 	reg_2968 = 0x00010001 + ((reg_2968 & 0x0000FFFF) - (reg_2968 >> 16));
-- 
2.35.1

