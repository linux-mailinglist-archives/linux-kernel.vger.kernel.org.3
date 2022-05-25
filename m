Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F123A533EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiEYOU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiEYOUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:20:23 -0400
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.46.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3CF9C2CB
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:20:22 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id CB1461208E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:57:21 -0500 (CDT)
Received: from 162-215-252-169.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id trVpnBNTM0EfytrVpn581Q; Wed, 25 May 2022 08:57:21 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rCKqXle6qbQe/IsqkcPkNDc9pAVJQLLMF9gxVrNillo=; b=K9uaUQOjVJ+/emlolmG8oM4At/
        HvP6C73sk5f84+w7DPVbjB9g3W+qHKKPnYuBAoM5eCIHtugpA6S7xiWWB5BKif+34NjIcnatRGVbx
        tkGlxkm7ObCR7tuX8xsiOdplkHoN/SmYPJKdoPP6RtSHljgEI1zkTqbO+qEi/HwbJGwrI+eYh/3HX
        ZkhYWn5MBYxJZkIC9ApPOg3g3VJMDNpIMyRcGYg5PTNl96oBMtjd9ng1p4PKajjiDACg3SBJRzA4J
        Jly9EkL2EaqasAuUE9/3cvfhggxrB26U9dkTGCXTU47iAA1FlvpXEmWGaHm3hY/clJEmXFh4a8hWX
        AGsUH+Uw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:58272 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1ntrVo-000P8e-P0; Wed, 25 May 2022 13:57:20 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 04/40] hwmon: (lm90) Reorder chip enumeration to be in alphabetical order
Date:   Wed, 25 May 2022 06:56:33 -0700
Message-Id: <20220525135709.2899592-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135709.2899592-1-linux@roeck-us.net>
References: <20220525135709.2899592-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1ntrVo-000P8e-P0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:58272
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 19
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder chip enumeration in alphabetical order to make it easier to
see which chips are supported, and to clarify where to add support
new chip types. No functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index b7f5b743c9f5..6728520a21ca 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -113,8 +113,10 @@ static const unsigned short normal_i2c[] = {
 	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 	0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
-enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
-	max6646, w83l771, max6696, sa56004, g781, tmp451, tmp461, max6654 };
+enum chips { adm1032, adt7461, g781, lm86, lm90, lm99,
+	max6646, max6654, max6657, max6659, max6680, max6696,
+	sa56004, tmp451, tmp461, w83l771,
+};
 
 /*
  * The LM90 registers
-- 
2.35.1

