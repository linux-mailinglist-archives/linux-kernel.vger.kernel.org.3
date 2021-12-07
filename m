Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D3846B484
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhLGHxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhLGHxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:53:47 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05719C061746;
        Mon,  6 Dec 2021 23:50:16 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bi37so31588607lfb.5;
        Mon, 06 Dec 2021 23:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L0Bou1mfaXx2WGsiNNdaHUGQpeB7Iv95i6yCuq9Y0vw=;
        b=HSXGrPV9/CIOy+RWksj5XEXXeHpTleMSLsEBLfZw1tenfuuYmw9eZ0TnwZqOhEnJ8g
         Z69zyGsDdV+dGoRJU3vMz5aaYdSXWHCLBYgFh4j7ksqILK2kIhSUDLqknYd6ghqjJrN6
         5kD9B4UanAbrR3EvM1wDB/fhKNbywNZgXFS6WlmsgRLf8jlJ8IjVm+Eo5Wew8tsjrAW+
         7kZ81WRU/Pfa8Pq9W4EI6gTDKUH+wsabYAbNc0lVfR472Iyxcv7iwX+xtF0A4e4jf0eH
         2Ss/xOTwllQwnMnnoYsHEjSldq+th46Ztdq7T3Yirjd6rMI3Eel4rFu4q2RVkNTHFbwN
         +/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L0Bou1mfaXx2WGsiNNdaHUGQpeB7Iv95i6yCuq9Y0vw=;
        b=P+QjMuH6XIqoU0IDeBJzUV5qczZ0pdsh023R/ZpHdmOw/NmtAJqvqOdkEFRV52cYqX
         3P50uIyKn0b8Mjf3FPGSawJQtXMCRmojvElolCtimMZ+7NyP44RQ5Hcg7EuNP2lPj1wt
         T+02N1BH6maJqzqORfx0gyngV2zxJdD9Cov/+5IBbpYt4pfGcjTjwKv0tKDkxEtX9Y7I
         SJ4jzD5lm2LRwSf2veYFMjOnDiU35ouLLxFj6y2h+N4WDyPYBHtSg8mtaS5WtJXeHV30
         7+KoruwiDR8mhVddyOfGlXSxOCbX7B1haWR5wlP+lihX0vJ3J6RJzjWLBpj21QBGDEBC
         i8yw==
X-Gm-Message-State: AOAM533UWPip3YztN06dF6Z7wYSbO2GisacIgE1QM2E60gntJcc3s0eM
        iPEIUdF36gsRAfl5ZMIYRHQ=
X-Google-Smtp-Source: ABdhPJzAMNECXUa1KxJfJKi0e817+S3oAiDw69meDpREoC6gtNTPQQ1Opy3WTB9LxxTvC7PtRUVYAg==
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr40544130lfq.183.1638863415282;
        Mon, 06 Dec 2021 23:50:15 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id s19sm1679371lji.81.2021.12.06.23.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 23:50:15 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: mfd: brcm,cru: fix pin controller nodename
Date:   Tue,  7 Dec 2021 08:50:10 +0100
Message-Id: <20211207075010.9310-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Replace "pin-controller@" with "pinctrl@" to match new pinctrl binding
requirement. This will fix:
Documentation/devicetree/bindings/mfd/brcm,cru.example.dt.yaml: cru-bus@1800c100: 'pinctrl@1c0' does not match any of the regexes: '^clock-controller@[a-f0-9]+$', '^phy@[a-f0-9]+$', '^pin-controller@[a-f0-9]+$', '^syscon@[a-f0-9]+$', '^thermal@[a-f0-9]+$', 'pinctrl-[0-9]+'
        From schema: Documentation/devicetree/bindings/mfd/brcm,cru.yaml

Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/mfd/brcm,cru.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,cru.yaml b/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
index be4a2df71c25..b85819fbb07c 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
@@ -39,7 +39,7 @@ patternProperties:
   '^phy@[a-f0-9]+$':
     $ref: ../phy/bcm-ns-usb2-phy.yaml
 
-  '^pin-controller@[a-f0-9]+$':
+  '^pinctrl@[a-f0-9]+$':
     $ref: ../pinctrl/brcm,ns-pinmux.yaml
 
   '^syscon@[a-f0-9]+$':
@@ -94,7 +94,7 @@ examples:
             reg = <0x180 0x4>;
         };
 
-        pin-controller@1c0 {
+        pinctrl@1c0 {
             compatible = "brcm,bcm4708-pinmux";
             reg = <0x1c0 0x24>;
             reg-names = "cru_gpio_control";
-- 
2.31.1

