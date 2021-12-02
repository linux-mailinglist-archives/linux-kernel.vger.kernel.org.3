Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F640466A51
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376864AbhLBTU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376361AbhLBTUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:20:01 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F117EC061757;
        Thu,  2 Dec 2021 11:16:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b11so392584pld.12;
        Thu, 02 Dec 2021 11:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvLTgGZG4bYn9DGJF1rWTWzAv7yNl0un9HiwPetaqA0=;
        b=B/JGkrFUJMSUx1kx85cCmBmGLIsRg96OK3u1/HQ3dxsaJHAauqjSWNOXI8XifhxH4Q
         FXF4zXv2fGNFisz5MdTgVeInPg8DWz2FGDZBmGjnF57EPtHXeVCVv/IOV2Q+dTH+cwaj
         J/0ZXty/WZLaO5NA6lxHAElfQPlvXZ7hqV/L1OuxALYNYj08uiehB9wovwNEQstm5kFL
         zYZV1ysmbk4LxwzV+CgJRREdnQC9zTQMuPDVPS32+ONBEUwJXHDtzZc4wB5C9xuUrnOz
         7eQTaQBKZt2dN5P+hrv2ZLg0VKpH9bSbqKcsPCQzx8oo0qo42a0ShJE0JqarvZOChjb8
         tghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvLTgGZG4bYn9DGJF1rWTWzAv7yNl0un9HiwPetaqA0=;
        b=j41WiLOHftsHYYfpCX2oT7e2ur7ZuNxn0I9LoiLA2tdRwGjg6/dQAcNlDg+C2pgaDC
         ILMNh/4KU9uN4iYCd6l2YZcDk88q4tDPsfBWhSNa7/1XU5fa79L0LBf2zrxS2asJoT/5
         bSzTU83xO5/E6n8dP7vN3F8c5suLvTpwEdDcUQrIBADftUNPZyE5L8xA59ZRd2zCnjTM
         OyuiY8QxCWw6eyopItZYcTSfio2DXbUj5Rs1EIWiWWLV/zn9kErF2IpVDjfMpy4itFRz
         aRGJlAfTfG0dfnm0fqqqCRiJkQxXwajM9TlTbiT91md7anOtM9KIN2Gd+fjt1E1tzM8E
         4hdg==
X-Gm-Message-State: AOAM531vL1j4nD/6lDUE+k5XrB5RfvjOP2J+njsdx4Enjh0HgtC/HiqR
        jz3fMfjpqF/cNBph1Q0KINU=
X-Google-Smtp-Source: ABdhPJzpg/GFbT+i6QUzSUt93XI3COPH+h0B9GZHT3Kalaag/a4UNffRexF3QXgfCTDVXy3aN0iYvA==
X-Received: by 2002:a17:90b:1bd1:: with SMTP id oa17mr8097403pjb.246.1638472597529;
        Thu, 02 Dec 2021 11:16:37 -0800 (PST)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:37:517f:74c7:9fe9:b5e8])
        by smtp.gmail.com with ESMTPSA id x14sm289897pjl.27.2021.12.02.11.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:16:36 -0800 (PST)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultz@microsoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH 2/5] platform: surface: Propagate ACPI Dependency
Date:   Thu,  2 Dec 2021 11:16:27 -0800
Message-Id: <20211202191630.12450-3-jaschultz@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202191630.12450-1-jaschultz@microsoft.com>
References: <20211202191630.12450-1-jaschultz@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Surface XBL Driver does not depend on ACPI, the
platform/surface directory as a whole no longer depends on ACPI. With
respect to this, the ACPI dependency is moved into each config that depends
on ACPI individually.

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>

---

Changes in v3:
 - Further propagated ACPI dependecy to SURFACE_AGGREGATOR

---

Changes in v2:
 - Created to propagate ACPI dependency
---
 drivers/platform/surface/Kconfig            | 7 ++++++-
 drivers/platform/surface/aggregator/Kconfig | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 3105f651614f..5f0578e25f71 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -5,7 +5,6 @@
 
 menuconfig SURFACE_PLATFORMS
 	bool "Microsoft Surface Platform-Specific Device Drivers"
-	depends on ACPI
 	default y
 	help
 	  Say Y here to get to see options for platform-specific device drivers
@@ -30,12 +29,14 @@ config SURFACE3_WMI
 
 config SURFACE_3_BUTTON
 	tristate "Power/home/volume buttons driver for Microsoft Surface 3 tablet"
+	depends on ACPI
 	depends on KEYBOARD_GPIO && I2C
 	help
 	  This driver handles the power/home/volume buttons on the Microsoft Surface 3 tablet.
 
 config SURFACE_3_POWER_OPREGION
 	tristate "Surface 3 battery platform operation region support"
+	depends on ACPI
 	depends on I2C
 	help
 	  This driver provides support for ACPI operation
@@ -126,6 +127,7 @@ config SURFACE_DTX
 
 config SURFACE_GPE
 	tristate "Surface GPE/Lid Support Driver"
+	depends on ACPI
 	depends on DMI
 	help
 	  This driver marks the GPEs related to the ACPI lid device found on
@@ -135,6 +137,7 @@ config SURFACE_GPE
 
 config SURFACE_HOTPLUG
 	tristate "Surface Hot-Plug Driver"
+	depends on ACPI
 	depends on GPIOLIB
 	help
 	  Driver for out-of-band hot-plug event signaling on Microsoft Surface
@@ -154,6 +157,7 @@ config SURFACE_HOTPLUG
 
 config SURFACE_PLATFORM_PROFILE
 	tristate "Surface Platform Profile Driver"
+	depends on ACPI
 	depends on SURFACE_AGGREGATOR_REGISTRY
 	select ACPI_PLATFORM_PROFILE
 	help
@@ -176,6 +180,7 @@ config SURFACE_PLATFORM_PROFILE
 
 config SURFACE_PRO3_BUTTON
 	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
+	depends on ACPI
 	depends on INPUT
 	help
 	  This driver handles the power/home/volume buttons on the Microsoft Surface Pro 3/4 tablet.
diff --git a/drivers/platform/surface/aggregator/Kconfig b/drivers/platform/surface/aggregator/Kconfig
index fd6dc452f3e8..cab020324256 100644
--- a/drivers/platform/surface/aggregator/Kconfig
+++ b/drivers/platform/surface/aggregator/Kconfig
@@ -4,6 +4,7 @@
 menuconfig SURFACE_AGGREGATOR
 	tristate "Microsoft Surface System Aggregator Module Subsystem and Drivers"
 	depends on SERIAL_DEV_BUS
+	depends on ACPI
 	select CRC_CCITT
 	help
 	  The Surface System Aggregator Module (Surface SAM or SSAM) is an
-- 
2.25.1

