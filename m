Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF11575288
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbiGNQOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiGNQOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:14:11 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8B511C3E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:14:10 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o21so1542775qkm.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFSTD6wveJdVFdIc7MwStIh/vF25P1SbCtUGXzm3kOk=;
        b=eovREipWybbyqgn//4S89yttA+tchfUg0XDFBTsby/VK7kOIUtOUBc36fOSPTR4jUz
         L8wMuiyfYa5iBvtJawkZicZQV0Pii7EocQqQ1VVChxJDO3rGF2QgL+75BDs+T1dLS9BS
         TghO9YngU50ccyw4XxKaCrMr03ec5Mhm4kjHu3X4LhJu7iQKgGnHOfu0dtyDyTkvMZAP
         Kc8ex4aIbW3Ncnwt2dKFBMhxBshGDWb9cKtfm975qSGLtl689kAEl1gFa+pfpj2Yaqk9
         u9Xuc/c1SlrFIIWfNO/qSwLEtOTanSQfGS2n3PkAxvtRcUwdwSPs5L3E5deDvzq30dNC
         4mOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFSTD6wveJdVFdIc7MwStIh/vF25P1SbCtUGXzm3kOk=;
        b=vXCyLpRyIKL2WBjJS9oFCwvKF0TKciYw7nXYXn0ee903OjlGovjDWzlJk5BoVWLYmn
         2DGKlGCbQw661xTgqSj9cPYRbKL3Pz9bsGxLqDzQj+Rbv3mBJ8Okl8D0bHWO8cQynG7H
         pxj116OwS0cgLxGkXRAxkbpzOyJeQmxWHEZB7iWTMg7Fvg26QR2edcYa/Gi4RE8Gv2AR
         Ts/ZufO8u1qfGS6upvbbMKOetNcVqYFCvEwLnTdjYKgVfaIJ+B4DN3hisBSJifhNC7Vb
         5i1MqQ2URPE1olncnAhpODmfFWUnjzOzq8XG0Zt8eitPgQbyM/XW/k6e4dKr3FgE/CiN
         xzBA==
X-Gm-Message-State: AJIora9DdrXQiTrzMnYqd+nf9sRQ1GuAGshQTsi88zgVhJ+gx2kksxwh
        kLn8+8Q2ff2MK1du4g6ImoT3otRJsMKLdQ==
X-Google-Smtp-Source: AGRyM1uFYl2o/SW9M8GpKV+ZlQ9Z9hNenvYJM6g2a536RAB6kYThWfXtyl/0/GSTM2yijLoQ2LI05A==
X-Received: by 2002:a05:620a:b4b:b0:6b5:cc47:a85e with SMTP id x11-20020a05620a0b4b00b006b5cc47a85emr133409qkg.204.1657815249240;
        Thu, 14 Jul 2022 09:14:09 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cp4-20020a05622a420400b0031eb393aa45sm1690067qtb.40.2022.07.14.09.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:14:08 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 1/4] MAINTAINERS: Update info for William Breathitt Gray
Date:   Thu, 14 Jul 2022 12:07:12 -0400
Message-Id: <694c2da1a01d1a3065239bf2c060018cb3308c34.1657813472.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657813472.git.william.gray@linaro.org>
References: <cover.1657813472.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new job position bestowed a new email address and Counter subsystem
git tree for me.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 MAINTAINERS | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..bb95b27f418d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -280,38 +280,38 @@ S:	Maintained
 F:	drivers/hwmon/abituguru3.c
 
 ACCES 104-DIO-48E GPIO DRIVER
-M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-104-dio-48e.c
 
 ACCES 104-IDI-48 GPIO DRIVER
-M:	"William Breathitt Gray" <vilhelm.gray@gmail.com>
+M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-104-idi-48.c
 
 ACCES 104-IDIO-16 GPIO DRIVER
-M:	"William Breathitt Gray" <vilhelm.gray@gmail.com>
+M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-104-idio-16.c
 
 ACCES 104-QUAD-8 DRIVER
-M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+M:	William Breathitt Gray <william.gray@linaro.org>
 M:	Syed Nayyar Waris <syednwaris@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/counter/104-quad-8.c
 
 ACCES PCI-IDIO-16 GPIO DRIVER
-M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-pci-idio-16.c
 
 ACCES PCIe-IDIO-24 GPIO DRIVER
-M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-pcie-idio-24.c
@@ -1354,7 +1354,7 @@ S:	Maintained
 F:	sound/aoa/
 
 APEX EMBEDDED SYSTEMS STX104 IIO DRIVER
-M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/adc/stx104.c
@@ -5107,10 +5107,10 @@ F:	Documentation/hwmon/corsair-psu.rst
 F:	drivers/hwmon/corsair-psu.c
 
 COUNTER SUBSYSTEM
-M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-T:	git git@gitlab.com:vilhelmgray/counter.git
+T:	git https://git.linaro.org/people/william.gray/counter.git
 F:	Documentation/ABI/testing/sysfs-bus-counter
 F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
@@ -5869,7 +5869,7 @@ F:	include/sound/da[79]*.h
 F:	sound/soc/codecs/da[79]*.[ch]
 
 DIAMOND SYSTEMS GPIO-MM GPIO DRIVER
-M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-gpio-mm.c
@@ -10441,7 +10441,7 @@ F:	Documentation/devicetree/bindings/interrupt-controller/
 F:	drivers/irqchip/
 
 ISA
-M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+M:	William Breathitt Gray <william.gray@linaro.org>
 S:	Maintained
 F:	Documentation/driver-api/isa.rst
 F:	drivers/base/isa.c
@@ -12194,7 +12194,7 @@ F:	drivers/net/ieee802154/mcr20a.c
 F:	drivers/net/ieee802154/mcr20a.h
 
 MEASUREMENT COMPUTING CIO-DAC IIO DRIVER
-M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/dac/cio-dac.c
@@ -21460,13 +21460,13 @@ S:	Maintained
 F:	drivers/media/rc/winbond-cir.c
 
 WINSYSTEMS EBC-C384 WATCHDOG DRIVER
-M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-watchdog@vger.kernel.org
 S:	Maintained
 F:	drivers/watchdog/ebc-c384_wdt.c
 
 WINSYSTEMS WS16C48 GPIO DRIVER
-M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-ws16c48.c
-- 
2.36.1

