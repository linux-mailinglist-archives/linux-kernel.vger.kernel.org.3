Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AFB59FAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiHXNOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiHXNOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:14:12 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AB626AE6;
        Wed, 24 Aug 2022 06:14:09 -0700 (PDT)
X-QQ-mid: bizesmtp62t1661346837tzdevp6l
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:13:56 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: XlKBH1Cks66hVGf5IHF0wX9e+JV7B9E8UsslHLvaTzKLmLVIupy7tsCnA9+hK
        OEe1S7qT/e/5VdIPXOOg3NMCfi2vsGw7G6x9FaY9n2vsrwQ5VdtZR3zxrZLf5zUqVEJULJM
        jGGtW7sE0YHrJ5dlbqbwtf4/2SypSsYyl1cRjDQ4k5atiitWMTBxlM+D6oqWFpq+2aSA4eF
        p0hU+zj67i1BFY2qoA2wuHMioqwbICLuZw1nu6RCykCe84TpPR/e/Dl1GIwcYla7kME1luF
        wNosf8WJ/Uvquv+o1hf5RottkrZhxjjRYPzW5TlOIbnfwVKkUpOd+iSu+Za3bOPmuj3lCQf
        A1Crx5tFevDmsqc05kRD3RvO2y2+AKunop2NYNkzgcvAs0e2ptCRSuLAc3haQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     crope@iki.fi, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/dvb-usb-v2: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:13:50 +0800
Message-Id: <20220824131350.50984-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'my'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/usb/dvb-usb-v2/af9035.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 5eef37b00a52..1e9c8d01523b 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -1497,7 +1497,7 @@ static int af9035_tuner_attach(struct dvb_usb_adapter *adap)
 		/*
 		 * AF9035 gpiot2 = FC0012 enable
 		 * XXX: there seems to be something on gpioh8 too, but on my
-		 * my test I didn't find any difference.
+		 * test I didn't find any difference.
 		 */
 
 		if (adap->id == 0) {
-- 
2.36.1

