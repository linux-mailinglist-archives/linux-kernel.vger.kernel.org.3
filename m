Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1234CB35C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiCCAD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiCCADW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:03:22 -0500
X-Greylist: delayed 5810 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 16:02:37 PST
Received: from smtprelay07.ispgateway.de (smtprelay07.ispgateway.de [134.119.228.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF3B193F5;
        Wed,  2 Mar 2022 16:02:36 -0800 (PST)
Received: from [92.206.166.137] (helo=note-book.lan)
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1nPWIw-0003tE-09; Wed, 02 Mar 2022 22:14:38 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
To:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH] ath6kl: add device ID for WLU5150-D81
Date:   Wed,  2 Mar 2022 22:14:36 +0100
Message-Id: <20220302211436.8746-1-git@apitzsch.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device with a male Mini-B USB connector is part of Panasonic TVs.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/net/wireless/ath/ath6kl/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index aba70f35e574..65e683effdcb 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -1217,6 +1217,7 @@ static int ath6kl_usb_pm_resume(struct usb_interface *interface)
 static const struct usb_device_id ath6kl_usb_ids[] = {
 	{USB_DEVICE(0x0cf3, 0x9375)},
 	{USB_DEVICE(0x0cf3, 0x9374)},
+	{USB_DEVICE(0x04da, 0x390d)},
 	{ /* Terminating entry */ },
 };
 
-- 
2.35.1

