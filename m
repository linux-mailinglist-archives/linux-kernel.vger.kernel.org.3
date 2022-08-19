Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A72599607
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345710AbiHSHWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHSHWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:22:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1217AE3991
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:22:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h24so4157658wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=5qRMB2kj3nIXd/wcM+TBcXz5RoNmnxqlHzw23QGYjAA=;
        b=P93IJ0qGt+QzTqb0yNiIcTjzt4B/HrOLoFDVpSGq6obb9NZl2zWSIFCy9I7ugKCuYi
         4hrQ8LknSxt6nY7t/cmGd0EQgwCUNfEhzSDjmuf+tf04IiwxOVmrnXD2EJ/qBDMe3PTp
         2uSdF4EWl+Js+ZLze2x/enT8M9ECqKQqGot98wYfwXw2Pyt7mb3t9DOg2hPj88iVZC4g
         NhERNeYHmU3Rw4dHOkXmOgJoJk3f/SSyYROtlRfJvARBc8QsJj3+8oDPX2jkQJcHYvDQ
         ru44L1JdW97cdauI69DWSJEt4Oh+aLP3SJB0/swNl8YmduLJaDsujZQND6yYsjODBnbE
         COjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5qRMB2kj3nIXd/wcM+TBcXz5RoNmnxqlHzw23QGYjAA=;
        b=mT+i9xJlPNpptKW4Z3AY6Ai9iB8qKNJ+sl3DpVnJva6UJBIlVXKBGociVigrIYMvt4
         8t982jEy6vK6aCsIVZzL1k+Y7h4plCBXKyoX/dWLO2P9O+p5+ITmzB34GWFbKMA1xkAN
         TeXlmbKKM7K1zTC86kEQNcTmwlOUvWXYVCY91lQjAMRAGj2hcsT7aGjEngGbh5UQFRpj
         wFszdxOhEqajt5X6/yd7mx1S41FQngRaaugeFL1oEmmQ1+ZSdNqo6QwJ0QbQi5XKXpxs
         /khWTY2nTnlZxnf7Ty3RqWmr8dFKCdVdWoaXjCeb2tUTRR8e3jb8EoEKfI1dF5buUw5L
         OlEA==
X-Gm-Message-State: ACgBeo2t6lOeHXG9Rhj1o4b0cU2rvwbekrfdAflAl3CnKiMNARtc1oLS
        ThEulO4OVTLoY6Aq3eW1ZwD99w==
X-Google-Smtp-Source: AA6agR5Gyn9rSNq8Jpb7hMwbXBXRZDO6OOGxQ2M0IkfQHOo5WJHKGWVm2OywK1udf8VkSSheBL82cA==
X-Received: by 2002:a05:6000:1d2:b0:225:2ce7:2559 with SMTP id t18-20020a05600001d200b002252ce72559mr3449872wrx.157.1660893754598;
        Fri, 19 Aug 2022 00:22:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e24e:29a0:a8c1:942b])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d4647000000b002237fd66585sm3129305wrs.92.2022.08.19.00.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 00:22:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Arnd Bergmann <arnd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] MAINTAINERS: make me the maintainer of DaVinci platforms
Date:   Fri, 19 Aug 2022 09:22:32 +0200
Message-Id: <20220819072232.8105-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sekhar is stepping down from supporting DaVinci. As it's quite low-volume,
I will keep maintaining it.

Acked-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 MAINTAINERS | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..748a98de5f33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20288,11 +20288,10 @@ F:	drivers/clk/ti/
 F:	include/linux/clk/ti.h
 
 TI DAVINCI MACHINE SUPPORT
-M:	Sekhar Nori <nsekhar@ti.com>
-R:	Bartosz Golaszewski <brgl@bgdev.pl>
+M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
 F:	Documentation/devicetree/bindings/i2c/i2c-davinci.txt
 F:	arch/arm/boot/dts/da850*
 F:	arch/arm/mach-davinci/
-- 
2.34.1

