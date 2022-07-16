Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93887576E2E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiGPN15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGPN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:27:55 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E57BCB6;
        Sat, 16 Jul 2022 06:27:49 -0700 (PDT)
X-QQ-mid: bizesmtp77t1657978055t7wkwxke
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:27:33 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: wPivafIDGPO9npSG8Mrn59YKKMn6fiIxNYcpohFm/J84Nn/brHragpnaX4yp0
        TKgAf05rbtwchzQ901TZzn9kYeK6ZW0wtxXp7hipF4Yiz18Xx7w4oowNHvWJ7/OgjUGwJzT
        rYCEDhMlE3JBGdtWHoKFmHBaMX2hAU80ujhRwaFGuZZVw8Lv2ofFBMWU0VLU4AivXpYjhtN
        bJ7A84gLATIdPatBhsntYA7WdsOYHvKO0nRLbtXTVLIzjzY0ZS+6i8T0GLzFG5l4MGhzq0W
        XcaIMSHZ1yK6BQcYI0yRHgTiP4MGusVbuzIdrNF190vzuKzdW2G+w6tlDAW5iCxUzhocsdx
        YN7l4B8QJOOicdLFPi/c4rO2cUmMegJXEJucMRpV6v7y+BI5tM1/hnNpxOI1w==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/dwc3: fix repeated words in comments
Date:   Sat, 16 Jul 2022 21:27:26 +0800
Message-Id: <20220716132726.37982-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'only'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/dwc3/ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 5d642660fd15..2a510e84eef4 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -473,7 +473,7 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 	case USB_DEVICE_REMOTE_WAKEUP:
 		break;
 	/*
-	 * 9.4.1 says only only for SS, in AddressState only for
+	 * 9.4.1 says only for SS, in AddressState only for
 	 * default control pipe
 	 */
 	case USB_DEVICE_U1_ENABLE:
-- 
2.36.1

