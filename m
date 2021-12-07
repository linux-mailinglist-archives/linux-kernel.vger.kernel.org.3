Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AAA46BCDF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbhLGNtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhLGNtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:49:10 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E9C061574;
        Tue,  7 Dec 2021 05:45:39 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so2288514wmc.2;
        Tue, 07 Dec 2021 05:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hborBrthxNbQAZArCMA4MiIrNEcRIe9EcwmyeOHHUJ0=;
        b=KwioKg8aKiIAwqcRrerQOBq+2pCJ2noJDzLdEYT0nGbN8xeTiR1kypzDh3rAusGg1/
         BbjhbpflDqERDU8n9tuDi2g9G1oGy2XUXHjJz05N+wkm9I0i/EqdIcxhPJTA//NyZGES
         mky5qUXIyPMwph4iVFdoU4OJRqKVSXIqaJ27NkfQCQrq2oifGW31lQfZp0v9bAgZSyoB
         jkvrEE+xq1H1Kx1W2Oq6I+lVXw2INETyIMAEzLQjuiJU0+QNfrGMNpp0Q4fYXgsSQE8p
         FLt14202lMw46oGpzbZp3WV9W3vKo4fEppM3FcewYDvfrlrLWUYKPYkDO+BtqD3AZ9kX
         Tadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hborBrthxNbQAZArCMA4MiIrNEcRIe9EcwmyeOHHUJ0=;
        b=bfXT1Qa+e7/OJmIgVqpWvw0/I4yX/O12TP7z4d96dJLuGKsIa5WK0iJpX7yiWQJ43a
         9PD/25hdjzOBBa7xtmDOIIuGk5wfjno1gHHpm1eMeAckzxowZ5JekiFfbtfGGE09+dQN
         //iRC6DNAA6JOjxyR5/BY4A53DRK09ShOVppi6vf1qHUkeSW3sh13N29I8M86WHCy0DK
         oma1uLyU+XyHHBGC/EsKU033pv6pUt8KLy42s3bSuCi3ij13JP0fGpAQSYpIPZNu0LbW
         boIIgmWOR8aL0NPMwaR3qbLLEOYSJ+QTnJTGbG2M4Ocv4sir2s8UbXY6PDuDDTIUYd6r
         rPHA==
X-Gm-Message-State: AOAM532ZJFWWZ2hw3P08y1g+b0s4M/EWUp8//53GPIhS4D18io+3NW8z
        HzaLxdMCKVSmH4Q+iGFm5Z0=
X-Google-Smtp-Source: ABdhPJzt9o/ocPKsbNmeRRBU4lwVWkUk/+vqjSHNtgFCZ8vx5g2UUbxi4CHe1kWcOXN5YOzW/PppBQ==
X-Received: by 2002:a1c:a592:: with SMTP id o140mr7041688wme.10.1638884738146;
        Tue, 07 Dec 2021 05:45:38 -0800 (PST)
Received: from localhost.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id x1sm14504594wru.40.2021.12.07.05.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:45:37 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
Date:   Tue,  7 Dec 2021 14:45:31 +0100
Message-Id: <20211207134531.19560-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 983b62975e90 ("dt-bindings: mfd: bd9571mwv: Convert to json-schema")
converts bd9571mwv.txt to rohm,bd9571mwv.yaml, but missed to adjust its
reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
a broken reference. Repair this file reference in ROHM MULTIFUNCTION
BD9571MWV-M PMIC DEVICE DRIVERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Lee, please pick this minor clean-up patch into your -next tree on top
of the commit mentioned above.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 79ef55bf2ca7..842be45b37ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16560,7 +16560,7 @@ M:	Marek Vasut <marek.vasut+renesas@gmail.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/mfd/bd9571mwv.txt
+F:	Documentation/devicetree/bindings/mfd/rohm,bd9571mwv.yaml
 F:	drivers/gpio/gpio-bd9571mwv.c
 F:	drivers/mfd/bd9571mwv.c
 F:	drivers/regulator/bd9571mwv-regulator.c
-- 
2.26.2

