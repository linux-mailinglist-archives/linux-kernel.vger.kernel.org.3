Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9E159FB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiHXNZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbiHXNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:25:20 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173D92BB15;
        Wed, 24 Aug 2022 06:25:04 -0700 (PDT)
X-QQ-mid: bizesmtp77t1661347445tpn8s4ih
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:24:03 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: zT6n3Y95oi1cHKh5VwldZDTLfOuqJIzINCBZQdtjoFL81UdXcZiAbA5o9Cx/1
        MSsJQB2soJlyIz9JowZanvnu7U40qyTDrAd0IPKpCi4BgEF3yE14HGvkGvJ+EaGHhl3qTyx
        4GPZppHPMJ3U/Wl9LUSfzsP/pCke6uwy18gx85bjhrOtAflcKxOwpDTAd3II9puT328NOdP
        UFNjnuEDHkB8pw43pCf58ps2sDjC2yPjHZk45zDR8E6pBJTB7fcmTbWj0rg41gbPzBBVFFR
        pd6cYuBz0+HdHaAqCD7Djnn48VxXy4RVQ+eSlj+xO9q+1K6W9wssY5jwjr5Mtj+N0FbOZCC
        r7WuHLe9jfj5SO8f+gJkDkPr2Z6FQS0z7q4HplkAzfkpvQXWi/HzeLFP5jGRDa+OQ1yv7IU
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     awalls@md.metrocast.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] pci/ivtv: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:23:47 +0800
Message-Id: <20220824132347.58865-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
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

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
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
2.36.1

