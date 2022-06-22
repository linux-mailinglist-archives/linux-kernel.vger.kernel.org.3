Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BC655485B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354898AbiFVKgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354925AbiFVKge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:36:34 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE2C3B57F;
        Wed, 22 Jun 2022 03:36:28 -0700 (PDT)
X-QQ-mid: bizesmtp85t1655894169tb1eaix1
Received: from ubuntu.localdomain ( [223.104.103.173])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 18:36:00 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000D00A0000000
X-QQ-FEAT: qpGeUh0uYB/+woD7CHQyPyus3Pdy3PGCWbuF6JTaBFoifIBXGJ/V4AWJ+XUmC
        9keCpXfeaeYq67T6MonpGVIYBLZ4dHcDZZAYKAvXUHecJ0gcNMYVsxLojC0+BWIHrhXHhQF
        enOYh/Va8Hy3/xo2CTX8kur+d1u2h3oqcnruRHOzHps2L1J7tlid0yLmjQImX2HcxYghsHM
        F1GX18RenL3MYKq3FcwbJvz2m7YtgWcBb/yYxNdeIZuP6mEKECe9y13FVy7vYqj+LSWgG6W
        uadqHq/k3qEYQ87dBG6Bb9j/UXZFmvH4ytYNBfpB18dJn23WEPc8eyBZrj0tuoYAqM5+0yz
        bxSq7id9leV4YUIBMadg4yAm3Q5W0Fhzh2bP2ge
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     hminas@synopsys.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] usb: dwc2: drop unexpected word "the" in the comments
Date:   Wed, 22 Jun 2022 18:35:58 +0800
Message-Id: <20220622103558.6647-1-jiangjian@cdjrlc.com>
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

there is an unexpected word "the" in the comments that need to be dropped

file: ./drivers/usb/dwc2/hcd.c
line: 1002

          * even and the current frame number is even the the transfer
changed to:
          * even and the current frame number is even the transfer

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/usb/dwc2/hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 3f107a06817d..d8d20aa638c9 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -999,7 +999,7 @@ static void dwc2_hc_set_even_odd_frame(struct dwc2_hsotg *hsotg,
 
 		/*
 		 * Try to figure out if we're an even or odd frame. If we set
-		 * even and the current frame number is even the the transfer
+		 * even and the current frame number is even the transfer
 		 * will happen immediately.  Similar if both are odd. If one is
 		 * even and the other is odd then the transfer will happen when
 		 * the frame number ticks.
-- 
2.17.1

