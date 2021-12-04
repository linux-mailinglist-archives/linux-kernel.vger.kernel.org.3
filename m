Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C010468418
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384595AbhLDKez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344486AbhLDKey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:34:54 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4001FC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:31:29 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id t5so21822931edd.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3uS29sk8arDOYaFNgLSLpZuH9ffdqV+pSvuIUovPK4=;
        b=YhhQj9HCudkWRmnADXEgimSoMFYflHNMbKWLIpnxXt/cOosIWp50u8k/tsNa2N61Th
         sczVRRGRB8DyjTCj9Gh1GF3iXERAA7QekNlB9oahVr1a6PmDzofk5Hd7+PcNjobDvMqL
         G0dUFGZ4wIZoVUdAVKiBrjvyrkqa58ttP7X4HywxF8SLZj6Vq2sRUhNK9V7FrKoxO/VG
         IWVPjdfLAMLits9qP0J7NEZDp6oCaMd2z8pbMQjZFgZsyeiXhlOMWjB24jszIOMRmYeR
         IE7c8AuBZUYrW7CItlQzUezv6SQDe2cC3VwomQEEvdRl4Q+5Pux8ebq15Z6OoLHx8OfN
         Am1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3uS29sk8arDOYaFNgLSLpZuH9ffdqV+pSvuIUovPK4=;
        b=O4TNHaf4JBefz1gC2DHiJfB+GVaMETEf02cs2LGaDPw5RRA+vw2F84etp8nDvWY6UY
         OFo+hcRvBS0jicfqyhlV4hmAYM7oPTzZ/O3/tuEhOZLM+wHOwd9cR3QJ/cgsD/b7ehR7
         ojL5/FO9d/4PxRQ74+/C6fqkCSsRXovEaGts4T9BK2f0S2A5msDtmVUxYlPiCzROSWE6
         8YPbOkC6/EzrpGDpmYjRP2mZoPKDZZ59ZFO8f74GEQY2bHsZLrMlTzl0Eznc3gdCjGd6
         9DOisLusfb0r0a9dGIcgUuTdht0No5z3rgLPWCd8voYkfvuCD39TbiFgt8HMPYDFRFIK
         lHWw==
X-Gm-Message-State: AOAM531guENTJcisFlmHfdXDZB49BWX0czr893UP0XCYwDJ8PDvHkOLj
        XBAsH6cJxJC4LT8mCranCvM=
X-Google-Smtp-Source: ABdhPJz7rJ9I38MlIcRMZJyEReJY0j+1NmLLm+8pFNACCpSnaMORuCo37VnckADa1fJc8+GKULTl9Q==
X-Received: by 2002:a17:907:a40b:: with SMTP id sg11mr30013595ejc.534.1638613887907;
        Sat, 04 Dec 2021 02:31:27 -0800 (PST)
Received: from bulldog.fritz.box (host-79-17-112-183.retail.telecomitalia.it. [79.17.112.183])
        by smtp.gmail.com with ESMTPSA id bd12sm3499839edb.11.2021.12.04.02.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:31:27 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: remove unused variable byMinChannel
Date:   Sat,  4 Dec 2021 11:30:51 +0100
Message-Id: <20211204103053.3934783-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but not used variable byMinChannel.

---
 drivers/staging/vt6655/device.h      | 1 -
 drivers/staging/vt6655/device_main.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 9e5f060f3784..b2aee3b8bc8d 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -200,7 +200,6 @@ struct vnt_private {
 	unsigned char byTopOFDMBasicRate;
 	unsigned char byTopCCKBasicRate;
 
-	unsigned char byMinChannel;
 	unsigned char byMaxChannel;
 
 	unsigned char preamble_type;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 6c5140e29f6b..d008b22cb98a 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -227,8 +227,6 @@ static void device_init_registers(struct vnt_private *priv)
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	/* Get Channel range */
-	priv->byMinChannel = 1;
 	priv->byMaxChannel = CB_MAX_CHANNEL;
 
 	/* Get Antena */
-- 
2.25.1

