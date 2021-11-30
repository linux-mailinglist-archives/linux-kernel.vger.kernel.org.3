Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4194A463D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245196AbhK3SB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbhK3SB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:01:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2003C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:58:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e131-20020a25d389000000b005fb5e6eb757so30572056ybf.22
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DuQLXDY/WsavsK3Y3Vk6NGzTVs4MQ3ZvOESfMJoDcDo=;
        b=ALbQWEeAPh8ZvYWV7e5NyymlXgZOHWgLWSAYU7dqP9Kas54PvzFNrzB7L0YE2UFdRM
         pm2hOCI5Nm9tsiGXFk2H9CrbQjeXMFJZIGNrj33WDf0+H6MT3cVRwSCFj0NF8RGLgdX1
         2uXmrXqheQn2Ol7zvoIJMx3cMuIH9/qWK3C5FzVRPjsOzAx+5NFVL9PqBYLE2EbHNGdB
         Xq+w03q+xNlMRy7vbdRgh8US3MkxUGo+6ueNTB1IfulsrNX4qShHqQ45J3mjPzMPG8u3
         PkTZmWUHd/8a36JkJnJimCUQ6udGAnH+8MvYXUbWwFWGj0nfkrPbrRZvr5W+7EYLr5YG
         Y6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DuQLXDY/WsavsK3Y3Vk6NGzTVs4MQ3ZvOESfMJoDcDo=;
        b=SXcU15QE/S5/Jn4+9fYhLgDOltnfgK47thuTF13H5CVJi49AD/oVTrjIImWcVFPvKW
         k+ZWJhuZwPcKQUWpDxxN60x/i52XBH7xxQ3lnOMCkjKRI8SLMv0LWlnGx0MOg1+1BHiZ
         9duEefW7nPl14J5vhjicve5iFiA4zvR6WKwdv7hhVeRFnQp2xReVPMwyr9yOc79Ua5zV
         jwSp/zMrKOsyiWgAiUhM6uOCxXW7fxBkvsv7BYG4HorJPvhyghmghz/IpYg8uevrC0ve
         Sn2FXKHjq11vpicT8Swx/R7BP/K7UhY4CXAGltnD326eAt6XZJGIFYBnFGnoqs8JW7D9
         vf7A==
X-Gm-Message-State: AOAM533J5TkPGcr4AiK4JGuycx9+uxBLlTl5kQBvnSF47yaM3PRXlK+e
        sb+qW4DxOQT/rwzMQ8/74Bp1m1somax6
X-Google-Smtp-Source: ABdhPJx4WFQ9Q9DkSrRwDd/b6SaLVPLQbm3hQm7EhVuYXDW46/X/aUARgYlI2cOMfpcXgmA/GX1g2nw4rFrf
X-Received: from aaelhaj02.cam.corp.google.com ([2620:15c:93:a:1db9:9f82:594c:720f])
 (user=aaelhaj job=sendgmr) by 2002:a05:6902:70d:: with SMTP id
 k13mr734013ybt.14.1638295086967; Tue, 30 Nov 2021 09:58:06 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:57:40 -0500
Message-Id: <20211130175740.2216591-1-aaelhaj@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] S8036 DTS changes:
From:   Ali El-Haj-Mahmoud <aaelhaj@google.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Oskar Sneft <osk@google.com>,
        Ali El-Haj-Mahmoud <aaelhaj@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Allow VUART and SuperIO to coexist.
- Minor formatting.
---
 .../linux-aspeed/aspeed-bmc-tyan-s8036.dts    | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/meta-tyan/meta-s8036/recipes-kernel/linux/linux-aspeed/aspeed-bmc-tyan-s8036.dts b/meta-tyan/meta-s8036/recipes-kernel/linux/linux-aspeed/aspeed-bmc-tyan-s8036.dts
index 30b68ce89..7f650f6c8 100644
--- a/meta-tyan/meta-s8036/recipes-kernel/linux/linux-aspeed/aspeed-bmc-tyan-s8036.dts
+++ b/meta-tyan/meta-s8036/recipes-kernel/linux/linux-aspeed/aspeed-bmc-tyan-s8036.dts
@@ -127,10 +127,23 @@
 	status = "okay";
 };
 
+&uart_routing {
+	status = "okay";
+};
+
 &vuart {
 	status = "okay";
-	aspeed,lpc-io-reg = <0x3f8>;
-	aspeed,lpc-interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+
+	/* We enable the VUART here, but leave it in a state that does
+	 * not interfere with the SuperIO. The goal is to have both the
+	 * VUART and the SuperIO available and decide at runtime whether
+	 * the VUART should actually be used. For that reason, configure
+	 * an "invalid" IO address and an IRQ that is not used by the
+	 * BMC.
+	 */
+
+	aspeed,lpc-io-reg = <0xffff>;
+	aspeed,lpc-interrupts = <15 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpc_ctrl {
@@ -340,7 +353,7 @@
 
 &kcs1 {
 	status = "okay";
-   aspeed,lpc-io-reg = <0xca8>;
+	aspeed,lpc-io-reg = <0xca8>;
 };
 
 &kcs3 {
@@ -385,7 +398,7 @@
 	/*A6*/		"",
 	/*A7*/		"",
 	/*B0-B7*/	"","","","","","","","",
-   /*C0-C7*/  	"","","","","","","","",
+	/*C0-C7*/  	"","","","","","","","",
 	/*D0*/		"",
 	/*D1*/		"",
 	/*D2*/		"power-chassis-good", /* in: PWR_GOOD_LED -- Check if this is Z3?*/
@@ -447,6 +460,6 @@
 	/*AA5*/		"",
 	/*AA6*/		"",
 	/*AA7*/		"BMC_ASSERT_BMC_READY",
-   /*AB0*/     "BMC_SPD_SEL", 
+	/*AB0*/     "BMC_SPD_SEL", 
 	/*AB1-AB7*/	"","","","","","","";
 };
-- 
2.34.0.rc2.393.gf8c9666880-goog

