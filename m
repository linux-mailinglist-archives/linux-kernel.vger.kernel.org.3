Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67664911E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243666AbiAQWpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:45:50 -0500
Received: from mail.hugovil.com ([162.243.120.170]:47608 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiAQWpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=RC0/zUbWCKe8a/wmytMs3vCIcJwk05PG0KKtR709Iw0=; b=B
        A+hCXjIuVQ/T/42fe+XdjuKhBho5MmrL8QUJE20bACZnbTzfrhpMb2OmaUfb667WjQ1ecQ77kPFp+
        ed8DdivIA+lKiIrhXUz413BS4zcpXXldcTcgllzUWZYQo0TJG6PiwG3UIa3BfcKY3TZOLGX8fBSk0
        s8aycitkbe8ylNo8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54810 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1n9akz-0005jL-Ig; Mon, 17 Jan 2022 17:45:46 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Jan 2022 17:45:03 -0500
Message-Id: <20220117224503.1250525-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.hugovil.com
X-Spam-Level: 
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: dimonoff.com]
        * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 1/3] rtc: lp8788: Fix typo in comment
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add missing "if".

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-lp8788.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-lp8788.c b/drivers/rtc/rtc-lp8788.c
index c0b8fbce1082..3aa5d980e596 100644
--- a/drivers/rtc/rtc-lp8788.c
+++ b/drivers/rtc/rtc-lp8788.c
@@ -262,7 +262,7 @@ static int lp8788_alarm_irq_register(struct platform_device *pdev,
 
 	rtc->irq = 0;
 
-	/* even the alarm IRQ number is not specified, rtc time should work */
+	/* even if the alarm IRQ number is not specified, rtc time should work */
 	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, LP8788_ALM_IRQ);
 	if (!r)
 		return 0;
-- 
2.30.2

