Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7533A4A8DC8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354810AbiBCUdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354479AbiBCUbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:31:42 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A070DC061759;
        Thu,  3 Feb 2022 12:31:11 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ee12so7718849edb.8;
        Thu, 03 Feb 2022 12:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x9kRaOBtaHkhPekFjPvc1KlEAjAvRZ6bAcdpwAt4N2E=;
        b=dLg1Cx/6SVsAqaFNvUz6VEy5UXo8GPtQKVYiFMmPZVTEtZoJJUKML81Y0qmwo6nzH1
         /a8cdHZrsKXKgwKy3ED4CGw3ZANA2nkkKE7co6fJFrk6bb2cLBdE3I8t6hh2B2a4/n0m
         cq//aX/hSDtquNG17KjzN4U8dP/B675TMT2X+OrvCtmyTrjJtffRd7nLHT2sU1axjCty
         X1L50FkY8n1dBU1tl8i90/skMISorhHJT++kvCQrgx3ZYJQ8JGOLFikwfieLZXsXpurq
         6aJsi1MbdfSqrwH0ftQddjH+WFo/M2vL6KL4X1BEi0lgTaGQT+aE1mAGii2DE9qxiIp8
         olJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9kRaOBtaHkhPekFjPvc1KlEAjAvRZ6bAcdpwAt4N2E=;
        b=5hXSYCkCsHiRAVcP3I/vR5pT/O1TuElahqdeSfRQQpNRQ6njnvwf3L7ta+fdfQULqD
         F76JDm2OYdgR62LWIyHunvn4UWSNEZBEoGDny0g64fgB2SIALo6+TVkdsREoCrAtl9Py
         pIOaBS3VXDPO2uiQ+PAQimB+DrHze85Rtm9EyzC+Zx/rJcm32wnXYNj9W3v7OJh0NV2N
         V1SAFgHrikk3OCPAKS8Vl4B5wdAev132WDHNRACqoxC5ng9/lr1WKZDq9gsFGfRLk10n
         DE+gbsjSyedmxeOWEW27BD0LAx40MX0HeVffkdfUymIhm/17fGSQKGjJ1NfaYosgW2/i
         CccA==
X-Gm-Message-State: AOAM531IMnTTXNlqJjPSqAFb+2CPFjvyGeiZFqNp8ifuifCutfasmQ7M
        JZ1Ur19xTvZ0N1bptH+coIk=
X-Google-Smtp-Source: ABdhPJyIpwS5FkWLDCaYhhE2Um6Y5E2Bl+Q1S01iKeEgMWY2iFpTpHVKSGlntNR1X/fLDOpRDU9SxA==
X-Received: by 2002:aa7:de91:: with SMTP id j17mr37735684edv.396.1643920270055;
        Thu, 03 Feb 2022 12:31:10 -0800 (PST)
Received: from adroid (027-177-184-091.ip-addr.vsenet.de. [91.184.177.27])
        by smtp.gmail.com with ESMTPSA id c25sm4634498edu.103.2022.02.03.12.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:31:09 -0800 (PST)
From:   =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
Subject: [PATCH v2 2/2] ARM: defconfig: add SMB347 charger driver for p4note
Date:   Thu,  3 Feb 2022 21:29:48 +0100
Message-Id: <4f1f6a4f8200855d07f3faed80ec5cc320e40941.1643919230.git.martin.juecker@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d7f7b0f87a18b5cc44ba97390461c15469439829.1643919230.git.martin.juecker@gmail.com>
References: <d7f7b0f87a18b5cc44ba97390461c15469439829.1643919230.git.martin.juecker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Summit SMB347 charger is part of the p4note family of devices,
enable the driver in exynos and multi_v7 defconfigs.

Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
---
Changes in v2:
  - adjusted wording to decouple the patch from the dt changes
---
 arch/arm/configs/exynos_defconfig   | 1 +
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index c58877cfdc9d..9d3191de96b6 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -159,6 +159,7 @@ CONFIG_CHARGER_MAX14577=y
 CONFIG_CHARGER_MAX77693=y
 CONFIG_CHARGER_MAX8997=y
 CONFIG_CHARGER_MAX8998=y
+CONFIG_CHARGER_SMB347=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_NTC_THERMISTOR=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1c2c3e9f0e05..bfbcb57e2083 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -510,6 +510,7 @@ CONFIG_CHARGER_MAX14577=m
 CONFIG_CHARGER_MAX77693=m
 CONFIG_CHARGER_MAX8997=m
 CONFIG_CHARGER_MAX8998=m
+CONFIG_CHARGER_SMB347=m
 CONFIG_CHARGER_TPS65090=y
 CONFIG_SENSORS_ARM_SCMI=y
 CONFIG_SENSORS_ASPEED=m
-- 
2.25.1

