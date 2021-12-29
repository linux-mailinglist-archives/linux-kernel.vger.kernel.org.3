Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE2481639
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhL2TSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhL2TSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:18:51 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58487C061574;
        Wed, 29 Dec 2021 11:18:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k18so9489765wrg.11;
        Wed, 29 Dec 2021 11:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=L5NLQD0x2q9pNvl7pWa1l5kU/PhkAbfmQ6zLA61SgcE=;
        b=TGBAy6Vxhkp/k9hrXUbwdM6MEYMLPNhHz7BIlnBr1DafXAvxlfIN+A/Gtp4XspGMm2
         TOvigkr9UBJrFGQ2W7GWOyLK7MA2QuU1ku6eEoOApGXvJfldW2JoN/E1Mkpak/ULAPFf
         6xgPD+mN6xSWMdVz3Vxg/LhLpzgcKUNoANsDzc+KaqqY90sHxXFZt9wLALXnfcKcht+H
         4knGZvRt7flrnU2Uv4VjvCWF7xHj+bbXas7Ad3HEhXr/tQBy2K7VRd5xwsjlOMJ+APfH
         Jbsr8ztYN0sOATt1GwmUZRTZvouhUiwRM7V1JD4GLIo87B7mQgHe/BqWGBcouZYhHd6C
         JzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L5NLQD0x2q9pNvl7pWa1l5kU/PhkAbfmQ6zLA61SgcE=;
        b=yR2Or6OQHkoaETah0rZrZTwEI5U6rthrR0vIQ/BblE9WeMO4WVrcuIhGsUNgncBpoF
         ObKjiXeSG6Qv4r0nyL1c1K9ynh7g3QokLIOs726ZX1rlT8UXPoSivw1T31QbrpPNNmOJ
         fHGFqXRRQKxePfDyyUYUDRYJ6GfNtn5ft+23JPEM4zCqnWkSpsKsWTMgDy+R621b1FuJ
         TIUSNvKKNyf1TR0znzqU5BSe1JHxu6ScBXW4+TdqNnFgacuYazD5uTn+Q+3yJJfJjjtK
         /pMZMjuUzd2UFro5x3P+YbRqyYxHeYH/B96kffTs69T0wdpULr7D3ddbCv1V4sfZu5yr
         QNhw==
X-Gm-Message-State: AOAM532+jeHBUUviOVbb+KN/5OgZ68/V8+0fgFcDkk0kjBoqjMn8RXP2
        80G8yRkxAkm953BxL36ig1Y=
X-Google-Smtp-Source: ABdhPJyJ9UBQefJ6fLsRdjgd69qjWLBA9ZP5MMkNVO6jNJdk5Pz0SlOWrhrobRPJSKOVkVpJL4MjgA==
X-Received: by 2002:adf:f741:: with SMTP id z1mr22229447wrp.54.1640805529911;
        Wed, 29 Dec 2021 11:18:49 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2626:5600:5f5:a4cc:1dcf:a62])
        by smtp.gmail.com with ESMTPSA id y11sm25523441wry.70.2021.12.29.11.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 11:18:49 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Tomas Cech <sleep_walker@suse.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RFC PATCH] MAINTAINERS: mark ARM/PALM TREO SUPPORT orphan
Date:   Wed, 29 Dec 2021 20:18:28 +0100
Message-Id: <20211229191828.21317-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The email address sleep_walker@suse.com and the url http://hackndev.com/,
provided in the ARM/PALM TREO SUPPORT section, are not reachable anymore.

Make this machine support orphan, and give somebody the chance to step up.
Move the maintainer into CREDITS to keep the attribution to his work.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
If anyone knows if Tomas Cech is still around, please respond.

 CREDITS     | 4 ++++
 MAINTAINERS | 4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index b97256d5bc24..e870e61aec38 100644
--- a/CREDITS
+++ b/CREDITS
@@ -627,6 +627,10 @@ S: 48287 Sawleaf
 S: Fremont, California 94539
 S: USA
 
+N: Tomas Cech
+E: sleep_walker@suse.com
+D: arm/palm treo support
+
 N: Florent Chabaud
 E: florent.chabaud@polytechnique.org
 D: software suspend
diff --git a/MAINTAINERS b/MAINTAINERS
index c87a3f5e302a..fca8c0a9bd25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2402,10 +2402,8 @@ F:	drivers/power/reset/oxnas-restart.c
 N:	oxnas
 
 ARM/PALM TREO SUPPORT
-M:	Tomas Cech <sleep_walker@suse.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-W:	http://hackndev.com
+S:	Orphan
 F:	arch/arm/mach-pxa/palmtreo.*
 
 ARM/PALMTX,PALMT5,PALMLD,PALMTE2,PALMTC SUPPORT
-- 
2.17.1

