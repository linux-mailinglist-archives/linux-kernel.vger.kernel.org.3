Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7517659E778
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244932AbiHWQhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbiHWQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:36:47 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B526B9C51B;
        Tue, 23 Aug 2022 07:46:34 -0700 (PDT)
X-QQ-mid: bizesmtp79t1661265990twxfk9ef
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:46:29 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: znfcQSa1hKZhyJBQOdcyLOVLZXnBiwv5xjD25h3dvn7PDcLPNGx7ckGYofWqZ
        2NafTPQ2nFwNAneoso14gpF4XbSHr/isTDouLgg4gCkq+TLHvoFbv5IG/8MkLbqshGb/zOR
        cR0JIShLL9M3nj9EJwhpXSZeNao0Ji4wfCCd/uX8HL8cPrF7NxF0P11SlQQ1aWUsOJ9El7O
        YwkoBfuaxHPjXUo1MaU5057chMJrlSeH/z3avPOvv/YdXHO0eFWmGLeM1RQuqofgpfXReVV
        JcUHw34QmS5cU/K8fxSoIqcNrKIx+BdT2HY3MxwFIINIWvXmpRu8cww4+SJqsI+dAoa3W/C
        E7NEHdSa1A9blYuGdGhq1cC7Sac4RiDKHSTeNth9W8TRXm5CGE7fboXR+aexg==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] usb/tm6000: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:46:22 +0800
Message-Id: <20220823144622.34949-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/media/usb/tm6000/tm6000-cards.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/tm6000/tm6000-cards.c b/drivers/media/usb/tm6000/tm6000-cards.c
index 98f4a63adc2a..b7842cd6f9af 100644
--- a/drivers/media/usb/tm6000/tm6000-cards.c
+++ b/drivers/media/usb/tm6000/tm6000-cards.c
@@ -1297,7 +1297,7 @@ static int tm6000_usb_probe(struct usb_interface *interface,
 		le16_to_cpu(dev->udev->descriptor.idProduct),
 		interface->altsetting->desc.bInterfaceNumber);
 
-/* check if the the device has the iso in endpoint at the correct place */
+/* check if the device has the iso in endpoint at the correct place */
 	if (!dev->isoc_in.endp) {
 		printk(KERN_ERR "tm6000: probing error: no IN ISOC endpoint!\n");
 		rc = -ENODEV;
-- 
2.36.1

