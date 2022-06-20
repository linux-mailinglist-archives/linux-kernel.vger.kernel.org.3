Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D30551622
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbiFTKoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiFTKoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:44:11 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4E213E28;
        Mon, 20 Jun 2022 03:44:06 -0700 (PDT)
X-QQ-mid: bizesmtp85t1655721776tjwauf34
Received: from localhost.localdomain ( [106.117.82.33])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 20 Jun 2022 18:42:46 +0800 (CST)
X-QQ-SSF: 01000000004000D0I000B00A0000000
X-QQ-FEAT: g1CXZ3gRPwz5VYsOrM7BP1wViAZWaqQ1Hg1S7R7wt+hdUXBZqVoZ2uMBp7GaL
        tbLjZ7Jw71bqlqXZqnvmzkZoLkC+ixa0mblREvfm3dHuFgQ1TVomk8wa/DZjeBC274F2j0b
        J4fC4tqtzQNuOhUff+Gnqs6zbSZuTUmvHYWj4jW/N/6n6GcxfFOKguFXyPIhDsfhcqN7DKt
        CGRgc+lWlAWR8g8XtEq+QVr3x6HsZv0xHum+EzMEsAKC+lYqOJAtzwbiX3pFz/nlwQ2JBZ6
        Sc+Guq9jfQn2qOM+D4Lt8uZhdAMqbcNzdry0iV9kk0OKGMnXEwqPmr5KlFAw2pNOnq9rXi8
        ICL3FfricJP+AsOdZ5OtuF3IIlpGw==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] USB: storage: Fix typo in comment
Date:   Mon, 20 Jun 2022 18:42:43 +0800
Message-Id: <20220620104243.4979-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Delete the redundant word 'the'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/usb/storage/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 64d96d210e02..7449e379077a 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -1178,7 +1178,7 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
 		/*
 		 * If the device tried to send back more data than the
 		 * amount requested, the spec requires us to transfer
-		 * the CSW anyway.  Since there's no point retrying the
+		 * the CSW anyway.  Since there's no point retrying
 		 * the command, we'll return fake sense data indicating
 		 * Illegal Request, Invalid Field in CDB.
 		 */
-- 
2.36.1

