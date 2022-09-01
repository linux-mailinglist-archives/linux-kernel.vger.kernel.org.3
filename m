Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32995A8A6D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiIABPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiIABPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:15:43 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7487E31D;
        Wed, 31 Aug 2022 18:15:38 -0700 (PDT)
X-QQ-mid: bizesmtp69t1661994934tx9ikm69
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 01 Sep 2022 09:15:33 +0800 (CST)
X-QQ-SSF: 01000000000000D0F000000A0000000
X-QQ-FEAT: 1wca0hqBk6dTXiaDyqK0laN1XnNv0ApWFsPTZWz2mG501M14BcdtzBn5sVQwT
        ykmPinSvBFAorVbIIIE/kvO3/6WnCtdZskcbTTHzQ+x0tcVAL79n8CtNcEkiZjf77eomFGM
        fhynqQ/ZCjCuqj1+UspBb9LndHYZux9ei4Ypf0RXl2/8arnczZiPGoaojZ76w6np4rTAIoe
        2Qt/C8tilF2eJWag95FklOCXOFTD/KXbR5Tisua5j5cUwY3DYPLb4gDvImWx+0t85t42kaa
        8R+COtfJJUvxP7N869adX9LKxgGyZYKnW2olv8U2CX62Lz46xVq0UL31ejeQFwlp1Z6s1R1
        1B/rfvVITPfCm7CjVpZWgv6ZKDyJa0HKnl+Z0URixPPXlbKf/I=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] [media] siano: Use 'unsigned int' instead of just 'unsigned'.
Date:   Thu,  1 Sep 2022 09:15:26 +0800
Message-Id: <20220901011526.23839-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' should be clearer than 'unsigned'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/common/siano/sms-cards.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/siano/sms-cards.h b/drivers/media/common/siano/sms-cards.h
index 028c5cb435bc..7f2a551bd1a6 100644
--- a/drivers/media/common/siano/sms-cards.h
+++ b/drivers/media/common/siano/sms-cards.h
@@ -85,7 +85,7 @@ struct sms_board {
 	struct sms_antenna_config_ST *antenna_config;
 };
 
-struct sms_board *sms_get_board(unsigned id);
+struct sms_board *sms_get_board(unsigned int id);
 
 extern struct smscore_device_t *coredev;
 
-- 
2.36.1

