Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68334576E4C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiGPNs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiGPNs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:48:57 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E14C647F;
        Sat, 16 Jul 2022 06:48:48 -0700 (PDT)
X-QQ-mid: bizesmtp86t1657979316t0ylgr3j
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:48:32 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: LE7C6P2vL8SuiLogd5OpmOeFmcl/9mnozec7oeQe4uhbtya/GN/WhZMLMWhkY
        8ETKVKJTsGGsQOqxTZFIYoM6qMcNqImkZw/SHjXpp0hsFQ357JR5gi+qHcE0lnHyVnDY90F
        c2dx+MqwA1n8KdbIw/4kqCqnbiAaqRW5xU+CW4PMRlEzZBs4/oYtyd9znJjNcUSJ9pC3vqT
        0qD1NExRBCjtr2+EfwOSsZJk9tOHmnb9I23QNvhfgxqCPU8McDB+LTFnhxFFk17UsdllZiO
        IdCCwoug5kSoQH+KssHoUW14GmNy7KOigEO3/uf6zZ4m1/yWBfQjAVXSr6L8+VZNpcAjQ4X
        x0Sguz8WUpz4e7L3UaGFkj67ZvDxCCiK0Zco9O8HILzZ7ZHdjCqssFDBHsCCw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/serial: fix repeated words in comments
Date:   Sat, 16 Jul 2022 21:48:26 +0800
Message-Id: <20220716134826.48413-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/serial/cypress_m8.c | 2 +-
 drivers/usb/serial/mos7720.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 6924fa95f6bd..da8913683104 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -256,7 +256,7 @@ static int analyze_baud_rate(struct usb_serial_port *port, speed_t new_rate)
 		/*
 		 * Mike Isely <isely@pobox.com> 2-Feb-2008: The
 		 * Cypress app note that describes this mechanism
-		 * states the the low-speed part can't handle more
+		 * states the low-speed part can't handle more
 		 * than 800 bytes/sec, in which case 4800 baud is the
 		 * safest speed for a part like that.
 		 */
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 1e12b5f30dcc..23ccbba716c7 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -826,7 +826,7 @@ static int mos77xx_calc_num_ports(struct usb_serial *serial,
 		/*
 		 * The 7715 uses the first bulk in/out endpoint pair for the
 		 * parallel port, and the second for the serial port. We swap
-		 * the endpoint descriptors here so that the the first and
+		 * the endpoint descriptors here so that the first and
 		 * only registered port structure uses the serial-port
 		 * endpoints.
 		 */
-- 
2.36.1

