Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F4E53DAE3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 10:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349800AbiFEIpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 04:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiFEIpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 04:45:16 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D952188;
        Sun,  5 Jun 2022 01:45:11 -0700 (PDT)
X-QQ-mid: bizesmtp74t1654418637tb7nap4v
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 05 Jun 2022 16:43:43 +0800 (CST)
X-QQ-SSF: 01000000002000C0G000B00A0000000
X-QQ-FEAT: 3uawQE1sH+3FUqPkLPowtOQBuTZOvH5lvJD0mEeglnetACa1xLaHyTppTRY5+
        7YyGFrySZNzQuDxCb1jwDaHHkNUT4cQY/mgTiKXMGrJxeCAOLSghvEbAu0j+kH1SDnjUytv
        x/16oLI+0WISLmgZLybfrTo5rBK3PXKG9UMA5QKfhv/mo7gnsS2p897lDmLwF3qsRljEhOO
        /7vTSXHbKn8JFo5QATHH2rQ1W/agpeUZAATu4UIpcKR1OwMmaNy0xKmsBBMidbxWA+2Y7Ht
        PZ7zay6RK9OIjjh1uXBw0BaOp/W4hoMDHpb6NNqJtt2bq71u/PekI1CoXaAxBTOONw91+7r
        92ReYfRI7LpCaZBQsQ=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, lains@riseup.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] HID: logitech-hidpp: Fix syntax errors in comments
Date:   Sun,  5 Jun 2022 16:43:43 +0800
Message-Id: <20220605084343.10514-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 81de88ab2ecc..68f9e9d207f4 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1694,7 +1694,7 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 			val->strval = hidpp->hid_dev->uniq;
 			break;
 		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-			/* hardware reports voltage in in mV. sysfs expects uV */
+			/* hardware reports voltage in mV. sysfs expects uV */
 			val->intval = hidpp->battery.voltage * 1000;
 			break;
 		case POWER_SUPPLY_PROP_CHARGE_TYPE:
-- 
2.36.1

