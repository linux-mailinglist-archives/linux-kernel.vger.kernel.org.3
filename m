Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED24555207
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377129AbiFVRMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376705AbiFVRMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:12:00 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0338521AA;
        Wed, 22 Jun 2022 10:11:54 -0700 (PDT)
X-QQ-mid: bizesmtp77t1655917905tzg9x260
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 01:11:39 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: GF9U4x7uyA+sbgXxCB/IJoh76s4ARvWP+rfSzaz/GyEgG8x/0WyO+9mzOR9hq
        B5Vex1e+Wfx8aB4xqPJG3ZWlGghRgArKwdLqiYHqDYubotU6mC1tqIrvpjHjvYIl3Wxau8U
        0UWNvWmucdA7LWrLOIa+JhJsR/e9A0gfZaxZpHoHhYI8k8wY/9vItWRJ4yzm7h0qI2brRqV
        HEkJemGXOoEKDnGYIVqb+IwHuw3K/nx+1LbFVAZ6pbQR9qdUoKdiFzBICIZmcuyA775oHtw
        TcusrsyBIGwiRnNvba1xOTtGgnbn7hOaWEqdL+GCpR1Hf1rFsH042wP72d2yYbgkQ9MG5e2
        SANkV5gEPlZSJJWIYs=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     hverkuil@xs4all.nl, jiangjian@cdjrlc.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: gspca: drop unexpected word 'is' in the comments
Date:   Thu, 23 Jun 2022 01:11:37 +0800
Message-Id: <20220622171137.4863-1-jiangjian@cdjrlc.com>
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

there is an unexpected word 'is' in the comments that need to be dropped

file - drivers/media/usb/gspca/spca501.c
line - 491

* This is is for the 3com HomeConnect Lite which is spca501a based.

changed to:

* This is for the 3com HomeConnect Lite which is spca501a based.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/media/usb/gspca/spca501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/gspca/spca501.c b/drivers/media/usb/gspca/spca501.c
index ecc97f807cfa..f7c75d7535c4 100644
--- a/drivers/media/usb/gspca/spca501.c
+++ b/drivers/media/usb/gspca/spca501.c
@@ -488,7 +488,7 @@ static const __u16 spca501_init_data[][3] = {
 
 /* Data for video camera init before capture.
  * Capture and decoding by Colin Peart.
- * This is is for the 3com HomeConnect Lite which is spca501a based.
+ * This is for the 3com HomeConnect Lite which is spca501a based.
  */
 static const __u16 spca501_3com_open_data[][3] = {
 	/* bmRequest,value,index */
-- 
2.17.1

