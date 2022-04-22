Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF3F50C1B8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiDVV5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiDVV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:56:34 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03FE401D14;
        Fri, 22 Apr 2022 13:39:03 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e5c42b6e31so9790164fac.12;
        Fri, 22 Apr 2022 13:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wPXMqD3X8aZc1gXMrMxqebs6D6zYaQ0urWjSJ8Up88c=;
        b=qYi2dglOI9JU6DKtqKwm8rnW/RPJU58JUdlbXsUG2eFmK05OdVLtXpwia9p1UqOruP
         GBcRVh7s/5yxYWvJAWTnA2/PP/Xcrj7Wmied6U9xtVDV/eCB14HrISEW+0+PHbuEfaPb
         vHcM/U8nEag6MxT8dU0U/JFNLJ8ElSF9m6OQk+O1rwrBXzqCmh7wmNKGRNJ8Nr5prZlK
         QX6N1sv1ySn3TOU/KmKx4M48yZIU5pcncAVz21c3+k9NaD/j9Uak1OvTqmqceSaedH71
         OfQryHzogpMyhXHayX90IXr6bDVJ0jk3sGm1b3S/52btXXuFaq+HQis8u8wgXUdAukxP
         kqQw==
X-Gm-Message-State: AOAM5334Q4kgmeUzKnEGNuQ/n03Fxd7IMWqhXwPgRZNszm/40tAHZWie
        Fx1qpwhC8EWkKEsGw1qnHhzSaujn7Q==
X-Google-Smtp-Source: ABdhPJyNlHUyl9wvKM6UUmFm66SCvceXo/fIVBC+AhuhJuRSCFLQ8tRNV5S1nH0SHinOhCxabmzQ/g==
X-Received: by 2002:a05:6870:4149:b0:e6:8519:94f5 with SMTP id r9-20020a056870414900b000e6851994f5mr2684281oad.48.1650655235173;
        Fri, 22 Apr 2022 12:20:35 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id h21-20020a056808015500b00323c43663e2sm1047276oie.32.2022.04.22.12.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:20:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: [PATCH] dt-bindings: Drop empty and unreferenced binding .txt files
Date:   Fri, 22 Apr 2022 14:19:57 -0500
Message-Id: <20220422191958.2589318-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop a couple of old, empty .txt binding files which are no longer
referenced.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 1 -
 Documentation/devicetree/bindings/mtd/common.txt  | 1 -
 Documentation/devicetree/bindings/rtc/rtc.txt     | 1 -
 3 files changed, 3 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/eeprom/at24.txt
 delete mode 100644 Documentation/devicetree/bindings/mtd/common.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc.txt

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
deleted file mode 100644
index c94acbb8cb0c..000000000000
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has been moved to at24.yaml.
diff --git a/Documentation/devicetree/bindings/mtd/common.txt b/Documentation/devicetree/bindings/mtd/common.txt
deleted file mode 100644
index ae16f9ea8606..000000000000
--- a/Documentation/devicetree/bindings/mtd/common.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has been moved to mtd.yaml.
diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
deleted file mode 100644
index b8d36fce5e2d..000000000000
--- a/Documentation/devicetree/bindings/rtc/rtc.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has been moved to rtc.yaml.
-- 
2.32.0

