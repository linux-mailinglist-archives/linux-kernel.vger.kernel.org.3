Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396F35548F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354164AbiFVKbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiFVKbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:31:40 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3356E39BB1;
        Wed, 22 Jun 2022 03:31:35 -0700 (PDT)
X-QQ-mid: bizesmtp73t1655893825t62hbayc
Received: from ubuntu.localdomain ( [223.104.103.173])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 18:30:06 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000D00A0000000
X-QQ-FEAT: g1CXZ3gRPwwxz7vTC89bMjrwpJ+Kws0Nuv//IChJHXCIkddCnxshejeaW/Sf7
        zXqUaB+Y0MbgHmzKn5TggDUcLRwWcjrsO8Ol1TWDPuAuFP6Zt1plmEnzbt+vqg82RMlvagq
        YW1YTNcgOjKDl/A7HaaWnk6O5E26PFLw9FJ+Dz43e2nzRpFZ2+UY9qGdSyOlzPHe1HS8E80
        5VgI5nUTx3T8fNdvRNS0SuOdtZ7icETUTCvEsOWR54d0yrDYsOIgMYYFE0rSts6FHijb18S
        1gyUGquLqxKcBLdGEOlJcm9/VCVw7ZwWxYY/Uy3ZXMZIKCb+rXIuql4aA5PGjg89LklCvR5
        yZQiB2pcF/bFsz0kgoG4UZ8htP9TnypWDqs57gQ
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     gregkh@linuxfoundation.org, u.kleine-koenig@pengutronix.de
Cc:     l.stelmach@samsung.com, stefan@datenfreihafen.org,
        mkl@pengutronix.de, mark.tomlinson@alliedtelesis.co.nz,
        mailhol.vincent@wanadoo.fr, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] usb: max-3421: drop unexpected word "the" in the comments
Date:   Wed, 22 Jun 2022 18:30:03 +0800
Message-Id: <20220622103003.5420-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped
file: ./drivers/usb/host/max3421-hcd.c
line: 315

  * reasonable overview of how control transfers use the the IN/OUT

changed to:

  * reasonable overview of how control transfers use the IN/OUT

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/usb/host/max3421-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 502a3ac5e35b..352e3ac2b377 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -312,7 +312,7 @@ static const int hrsl_to_error[] = {
 
 /*
  * See https://www.beyondlogic.org/usbnutshell/usb4.shtml#Control for a
- * reasonable overview of how control transfers use the the IN/OUT
+ * reasonable overview of how control transfers use the IN/OUT
  * tokens.
  */
 #define MAX3421_HXFR_BULK_IN(ep)	(0x00 | (ep))	/* bulk or interrupt */
-- 
2.17.1

