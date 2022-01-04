Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD348450C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiADPpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiADPoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:44:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC482C061761;
        Tue,  4 Jan 2022 07:44:54 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g7-20020a7bc4c7000000b00345c4bb365aso20241703wmk.4;
        Tue, 04 Jan 2022 07:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=UZgyb2U19162yeBshMqDAobgM1UM6Ei3ph+HYHeKHG4=;
        b=gczLsTMf/bfhbL55yEQ2UXzidnYPxLEss/ifBRaLBSfMS8TtvZvE0YKhPLrMrz8bBz
         qOJPIMBIjxSA71g2Rt0Qj5i1pA0nSVwnPeAsZG5qt+FGPa51P3RPlvfJI91QB/p4Wj0e
         NHy4jb26IlHUrKRXl1Rqre2hq2Z6wLEnPEpF17G5Gdc4gQD1yowsKegiQg22WblXps5s
         NmjrVG7yHdSVLtT6gdDnWYPyJI3QJsB4NdxQrmUr2GiZtDaCzVKUPfOF6g6e6pgZy6qs
         8rRu4kDEM3pr7PSV6HYIfq+72ehbQQcX0bUpMqVZPmACmAimKU8kHeDN8S0+JtzDJI1d
         hUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UZgyb2U19162yeBshMqDAobgM1UM6Ei3ph+HYHeKHG4=;
        b=yDoI6tYIUGu1dO2tXWj1RbbBI1HWpOavjD1Pxiaco0DUEROd31Gj7V20HUsDUHnrqW
         9UvJVtDyjXJpVY/YZMCTMYQFLOwYGupVmMhg1vnVyqGe4ymtRnMmf2KIhxb8of0uqVGf
         57Kfih2TXImct9YMFWIinnJNNWUF0j0iSRrBHsYBRwfiA6vZ4olYSQMib3AcHiqi0HJz
         IwE4q8hDCBwPmbYQjweJ6lXzIxflxCCxtNZ6Zq1wGh4+E3QX+tQ249M6SoSjLbVRuK9I
         hLVWG6ZZmc1ZFY1cp50OldYsbpqvVgN8ekrMRLxVKyr1gb4NIXTdMgMOzVdLvGb/9Dqc
         cYxQ==
X-Gm-Message-State: AOAM531HHDBjGwtphRKU5Ru6cSp1ZO1qEf58zxsgsJU3nHjhGmd3+MDZ
        cAQdoV6iq3zbXQ9qoA2o++flvHLWx08=
X-Google-Smtp-Source: ABdhPJzFtuM8tF9y9xxXooJDmNfSa7ycURqI6U7nxCrqAsDKa5tne1Rgpp3vjcUWzq0OlmsH8JOoZQ==
X-Received: by 2002:a1c:ed01:: with SMTP id l1mr21616630wmh.185.1641311093440;
        Tue, 04 Jan 2022 07:44:53 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2647:5a00:918:9389:3260:d714])
        by smtp.gmail.com with ESMTPSA id m21sm36542318wrb.2.2022.01.04.07.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 07:44:53 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove typo from REALTEK OTTO WATCHDOG section
Date:   Tue,  4 Jan 2022 16:44:14 +0100
Message-Id: <20220104154414.21496-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 489119bf75e6 ("watchdog: Add Realtek Otto watchdog timer") adds the
REALTEK OTTO WATCHDOG section in MAINTAINERS and one file entry refers to
driver/watchdog/realtek_otto_wdt.c. The actual top-level directory name is
drivers, not driver, though.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

    warning: no file matches	F:	driver/watchdog/realtek_otto_wdt.c

Remove this obvious typo in the file entry.

Fixes: 489119bf75e6 ("watchdog: Add Realtek Otto watchdog timer")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f7bf491409cf..b4fcc2bb7c54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16307,7 +16307,7 @@ M:	Sander Vanheule <sander@svanheule.net>
 L:	linux-watchdog@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
-F:	driver/watchdog/realtek_otto_wdt.c
+F:	drivers/watchdog/realtek_otto_wdt.c
 
 REALTEK RTL83xx SMI DSA ROUTER CHIPS
 M:	Linus Walleij <linus.walleij@linaro.org>
-- 
2.17.1

