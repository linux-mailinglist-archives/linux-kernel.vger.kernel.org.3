Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2C946C789
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbhLGWia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:38:30 -0500
Received: from mail.hugovil.com ([162.243.120.170]:45222 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhLGWi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:38:29 -0500
X-Greylist: delayed 2299 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2021 17:38:29 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=CeuVHtUFLn7b/ZEZ5WxCFr9pXaQsL+cPjhzzHc54meA=; b=Y
        K3tSriQjws91OY5omJQiWgwpgGTitqhSCfk0X4g3hFs6/lvBDlgG6MBq+bRn/JRLG86KSpeZHMOv/
        ODzDnQBuzlo4b6hx7SQ6sQvc/61pqOOqsmwrZ7e5ZsuW//cnO+34Wn6obV0nEKPZW9o3zBNr6wdi4
        bMmQE2CNNu94kqmI=;
Received: from ipagstaticip-ad9375f2-382c-b511-8ac1-9541f69fe50f.sdsl.bell.ca ([142.116.33.166]:13104 helo=pettiford.dimonoffinc.intra)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1muiRu-0000k3-Ii; Tue, 07 Dec 2021 16:56:35 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue,  7 Dec 2021 16:56:25 -0500
Message-Id: <20211207215626.2619819-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 142.116.33.166
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.hugovil.com
X-Spam-Level: 
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: dimonoff.com]
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH] rtc: pcf2127: Fix typo in comment
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Replace TFS2 with TSF2.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index f0a6861ff3ae..d01671676a00 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -650,7 +650,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 
 	/*
 	 * Enable timestamp function and store timestamp of first trigger
-	 * event until TSF1 and TFS2 interrupt flags are cleared.
+	 * event until TSF1 and TSF2 interrupt flags are cleared.
 	 */
 	ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_TS_CTRL,
 				 PCF2127_BIT_TS_CTRL_TSOFF |
-- 
2.30.2

