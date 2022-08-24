Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111CB59FAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbiHXNMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiHXNMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:12:13 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176B420F43;
        Wed, 24 Aug 2022 06:12:05 -0700 (PDT)
X-QQ-mid: bizesmtp82t1661346722te70zksx
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:12:00 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: znfcQSa1hKY+Y42639KpZS/OxSsqc3p/4S+8kJXDXQM9J/XhUzApL2ICXgAtj
        aUzBRnvORqgpxHMrFwGGoOJVO1/5OQoW2hbmqrDoMzZRdS0JZiguycsawak3ZVs1gc1SJ3/
        UOKGcn2g1k5DcrWd802cpYhe2lJWygWpdzHd/M2lgiOJLZ+Bs8wifbEIOnAKHH49fc1GS79
        j+Kpj79MK88ECnixBd9dP3uMx6hvp9Li9VHLgxHrvoCTvj7lx4Q/eXSABREL3VegxPGs0P6
        lK69dM6IEsJs3Is/BCIHGEMsVCFQ35SVY7S2D3eWf0hetZuUwTSMPXoObqYJjgiRNZpVnBM
        aDhRVeaKXdWXkldV9T65UesbHnpv7UBtTtquP+cjWDPNnoCa2xJsiKyq25CQg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/dvb-usb: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:11:53 +0800
Message-Id: <20220824131153.48756-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'is'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/usb/dvb-usb/technisat-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb/technisat-usb2.c b/drivers/media/usb/dvb-usb/technisat-usb2.c
index 9c77911fcad4..df90c6c5f3b9 100644
--- a/drivers/media/usb/dvb-usb/technisat-usb2.c
+++ b/drivers/media/usb/dvb-usb/technisat-usb2.c
@@ -786,7 +786,7 @@ static void technisat_usb2_disconnect(struct usb_interface *intf)
 {
 	struct dvb_usb_device *dev = usb_get_intfdata(intf);
 
-	/* work and stuff was only created when the device is is hot-state */
+	/* work and stuff was only created when the device is hot-state */
 	if (dev != NULL) {
 		struct technisat_usb2_state *state = dev->priv;
 		if (state != NULL)
-- 
2.36.1

