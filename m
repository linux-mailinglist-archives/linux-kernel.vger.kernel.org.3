Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C67D576E2C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiGPN0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGPN0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:26:09 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2322D6351;
        Sat, 16 Jul 2022 06:26:03 -0700 (PDT)
X-QQ-mid: bizesmtp70t1657977954tdqkh9if
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:25:48 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: 7jw2iSiCazo6mfR54gyfAPPcUCmAkvQgnJgY3OkKQ5sjVXFzBzlwqTdzYL1Ej
        zz+MXo+ddPtXjlfvTfPfad4GSnCKssME/zNAAicf9PF726qktrCpdABBRjIbRfZ15eOrswV
        GjsU7qwsS98Mpk/Y8UpyleIXmiJthdYCXSz9gW66JydRfb8NHS3wQVH56e43Nhy8hZxoe4M
        2xIThDvzMXn2lWypQGYW10qIQxylpMhX3FF114t/7NYGRyoBh0YoknRAdSNZ8/P5ULU+zZm
        HKmpPVGd9cl8rdt5wPHIc30CvNUXVMoap4N/u6cl37RrS4n90ecQdRs0a6d4iacIVpvWxzT
        fGsrE35gSkZQE8/oMb/qUMOcwt/ZNhZZjgkJLRCNG4Hf0gesqjEkdaTnpKLVl7NbA4p2l9t
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/dwc2: fix repeated words in comments
Date:   Sat, 16 Jul 2022 21:25:40 +0800
Message-Id: <20220716132540.36840-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/dwc2/hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index f63a27d11fac..a9731169d378 100644
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
2.36.1

