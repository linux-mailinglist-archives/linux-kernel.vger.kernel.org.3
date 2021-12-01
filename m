Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C14465849
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 22:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344086AbhLAVXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344010AbhLAVXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:23:09 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD32C061574;
        Wed,  1 Dec 2021 13:19:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id z7so31964028lfi.11;
        Wed, 01 Dec 2021 13:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VqCD5X4z3E22KUCM7brtm+WLf2cLZsABPfgU1nbqQJg=;
        b=KsH1TFr8dZTTKCqVTATfd3Js5wW27OGo7XYxghwnkcOty1s6RtZWFJDUAbIAlji2p6
         ovw5RTDgW/JbejsqHOMCWj/BtRs8hkjxm7HIQlXcdXT1AH7m9B9r0IY8jLx41AWEUOR9
         TEW2G7fZzVqamry/5cAxMbeQ73HIvjarnekhgaxwIjSpFqJq9jwdpqF6XLzn34BSEJ+e
         tEzJLB4L0/yaq8KzMQA6+J/wOV2p5egwBfnjabV7xUUpPTbkETk4UU0CKT4uu/SIk5MS
         tt8EGSCFBgNYu9rrOM/msKzR+jDsORRzZU5ZPNSBbmrQ0rB8IXclPl1hQSyxgldwwjzg
         4+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VqCD5X4z3E22KUCM7brtm+WLf2cLZsABPfgU1nbqQJg=;
        b=hYXdfiBd3p8g0JXGlvnDzqj78LtZgW/+ZoKr1wnvm7NPdjwwjpTJQhwH7WEBgmioZp
         es8GtLDqldE54C/809DkqWWf2277sIN9eOAm5SGiuK2sfYO4Ee2xm2ygvWXaeYaOXFYn
         q0458ujx+73IKeou3I9artAs3P37VSYPPEV0vOV3hv/QrY22gx7jyTH1VWN6ESXGCkYV
         rrryccZW/7RdUjEdLvNJ4xB3Dp2VgEiOz/4F4ALIVvBSY0iTfMq9Ij9ff4fxRbt3GJnO
         slcNg3+xz+CFiBEtLK62s/YKOZZ6+uibpk9K7HX7WCR3W0/YJZmaFG6VE0BIoya6VPOS
         hoBg==
X-Gm-Message-State: AOAM532PHwJRQDQJFpsjnk6nEHzBkriTLrWhrfRWHP3pMr2ji5bDrd8W
        zYFyELzriKWizbNBBNNpEJDVL2jRLoc=
X-Google-Smtp-Source: ABdhPJxJxGPIHET353HJdTwalA7snVPtLPN9+bzzmDfTbkAApY8KnLkPmUVSh1GGetO0oMpitP9MNA==
X-Received: by 2002:ac2:51b0:: with SMTP id f16mr8228337lfk.20.1638393586169;
        Wed, 01 Dec 2021 13:19:46 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id o8sm104919lfk.2.2021.12.01.13.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 13:19:45 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] MAINTAINERS: Add Florian as BCM5301X and BCM53573 maintainer
Date:   Wed,  1 Dec 2021 22:19:39 +0100
Message-Id: <20211201211939.13087-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM5301X and BCM53573 commits go through Florian's stblinux.git so add
him as maintainer to make sure people e-mail him when sending patches.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b53fc85c5238..d60e3d7670eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3626,6 +3626,7 @@ F:	drivers/net/ethernet/broadcom/bcm4908_enet.*
 F:	drivers/net/ethernet/broadcom/unimac.h
 
 BROADCOM BCM5301X ARM ARCHITECTURE
+M:	Florian Fainelli <f.fainelli@gmail.com>
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 M:	Rafał Miłecki <zajec5@gmail.com>
 M:	bcm-kernel-feedback-list@broadcom.com
@@ -3637,6 +3638,7 @@ F:	arch/arm/boot/dts/bcm953012*
 F:	arch/arm/mach-bcm/bcm_5301x.c
 
 BROADCOM BCM53573 ARM ARCHITECTURE
+M:	Florian Fainelli <f.fainelli@gmail.com>
 M:	Rafał Miłecki <rafal@milecki.pl>
 L:	bcm-kernel-feedback-list@broadcom.com
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.31.1

