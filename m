Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2061B55051B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 15:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiFRN1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 09:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFRN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 09:27:21 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C09914D34;
        Sat, 18 Jun 2022 06:27:15 -0700 (PDT)
X-QQ-mid: bizesmtp82t1655558831tav3mpq4
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 18 Jun 2022 21:27:06 +0800 (CST)
X-QQ-SSF: 01000000002000D0I000B00A0000000
X-QQ-FEAT: ZHWZeLXy+8cHtKI1jYaZtodi5tfaA4MDUnvHxkg97ek1Kneskc370Gz5uZ0k6
        2iX1TKiTLCsmo/RMCMy86b5G6PgA/IrVcQocmtG8gjdnIZU/Aze8s4m+koRDHBsReN7bvgO
        htzI4HHOrk6T5nrDgHK2SF1VKQrpDpQU1p70XXMuHACKK1/D10n0kR1eT0mP2bWIHiJRXKX
        TXuZuCNMcjxE7kpMGUELiMTE/kWTFyfNWWXEdd2CDO1EtRhc111FAaNNHZwFRtr5QkKeCO0
        67/oIENAworu/Hp/Nk+XczCq3K9ybokXe6FKQY1dDpwk+K77e3uAbnb53FwOwgNx1aTh+iQ
        9sb7Ww4wteINqY+0K5bp2/EHpAXrA==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] watchdog: booke_wdt: Fix typo in comment
Date:   Sat, 18 Jun 2022 21:26:59 +0800
Message-Id: <20220618132659.17100-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'and'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/watchdog/booke_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 5e4dc1a0f2c6..af4b79ff93c3 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -73,7 +73,7 @@ static unsigned long long period_to_sec(unsigned int period)
 
 /*
  * This procedure will find the highest period which will give a timeout
- * greater than the one required. e.g. for a bus speed of 66666666 and
+ * greater than the one required. e.g. for a bus speed of 66666666
  * and a parameter of 2 secs, then this procedure will return a value of 38.
  */
 static unsigned int sec_to_period(unsigned int secs)
-- 
2.36.1

