Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6C477DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbhLPUxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbhLPUxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:53:35 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A2C061574;
        Thu, 16 Dec 2021 12:53:34 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so71050eds.10;
        Thu, 16 Dec 2021 12:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UYWl8N2PhW5Ju/B4C9j+htNcmkHrVxhfOJ/XbLXRxaE=;
        b=KXp7KhYACJe+eJ/OZnlUBx/WVARig0YkY9XAroEdvqOUel5mbP1RLmVN+VCkWdTs1q
         YErja46p+kaTMWd9fwpBL7mpKKy1xTe7qB3RfoOEkZmHSOhQLotEUulQRHMlw1QUn577
         XMucMJ6J1cqPF/CrK9I4xRWN8pOIddxUSXNQuokdie20NxUKDBL2kMZQScpFBiBK0671
         CJSUFMim2ek1XYUxqMwtviaf3cUZ9ofD2aDfpEyeoj9omrCLPAqvkV31IhYJ8G7pk7dp
         mOcPg6OITXgR7mruQup7/+Rua7SDKUtGFb0O+KB/xwl8QOC4qGve0cEDncekJ9t+9LzH
         49rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYWl8N2PhW5Ju/B4C9j+htNcmkHrVxhfOJ/XbLXRxaE=;
        b=nzLz5mc0HoYOfAqcuKsbZPROcpXTdt3rAFXpeAtbJp8i1i3dqXnoLz9Gj+ZiVosmm4
         xE1AZUp+vk9openn7/cJsrK84431ta4BiPtTA+8DCcH2cU06oWobYkaJnAs54plX/lE0
         7ysvzbKKc/PKaCRuDDyRX172+olkbFUIFrgMqfwmOJq4GDQuxUZ6jgZRjVktaZooy4YV
         E3VkXxnhFOxFO/yYYJVmgxDU2zjEbUNG4J6H2Dkbk9NpW/ver1qlW3c46fMVD0Y9B6pB
         /FE/yOVCC8GsorSCZXWq5+XhWsCsuMPYkiH25xNyvLQnUlhOaJ6wAP/9JwJA8vaLwlQO
         W94g==
X-Gm-Message-State: AOAM530Ot08mbhQu9fAY71+Nfxm4irzPJlQeHH85IDRg3i0D03zEwmvS
        Rzei1jNKk6yWfFfitnj+kKw=
X-Google-Smtp-Source: ABdhPJyZ6/TD9GmzNNPDOlZrGh0poEb0LV5Qj47nvm7U89Gk4fLF27i81VsVlvVXgqdHenaKc6+9wA==
X-Received: by 2002:a17:907:1c17:: with SMTP id nc23mr14252126ejc.549.1639688013193;
        Thu, 16 Dec 2021 12:53:33 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f34ba00f711d38e28b691af.dip0.t-ipconnect.de. [2003:cf:9f34:ba00:f711:d38e:28b6:91af])
        by smtp.googlemail.com with ESMTPSA id h2sm2107842ejo.169.2021.12.16.12.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 12:53:32 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: update ASUS EC driver documentation
Date:   Thu, 16 Dec 2021 21:53:01 +0100
Message-Id: <20211216205303.768991-2-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216205303.768991-1-eugene.shalygin@gmail.com>
References: <20211216205303.768991-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 ...wmi_ec_sensors.rst => asus_ec_sensors.rst} | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)
 rename Documentation/hwmon/{asus_wmi_ec_sensors.rst => asus_ec_sensors.rst} (61%)

diff --git a/Documentation/hwmon/asus_wmi_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
similarity index 61%
rename from Documentation/hwmon/asus_wmi_ec_sensors.rst
rename to Documentation/hwmon/asus_ec_sensors.rst
index 1b287f229e86..8b4baf83116f 100644
--- a/Documentation/hwmon/asus_wmi_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
-Kernel driver asus_wmi_ec_sensors
+Kernel driver asus_ec_sensors
 =================================
 
 Supported boards:
@@ -9,9 +9,11 @@ Supported boards:
  * ROG CROSSHAIR VIII DARK HERO,
  * ROG CROSSHAIR VIII FORMULA,
  * ROG CROSSHAIR VIII HERO,
+ * ROG CROSSHAIR VIII IMPACT,
  * ROG STRIX B550-E GAMING,
  * ROG STRIX B550-I GAMING,
- * ROG STRIX X570-E GAMING.
+ * ROG STRIX X570-E GAMING,
+ * ROG STRIX X570-I GAMING
 
 Authors:
     - Eugene Shalygin <eugene.shalygin@gmail.com>
@@ -22,9 +24,7 @@ ASUS mainboards publish hardware monitoring information via Super I/O
 chip and the ACPI embedded controller (EC) registers. Some of the sensors
 are only available via the EC.
 
-ASUS WMI interface provides a method (BREC) to read data from EC registers,
-which is utilized by this driver to publish those sensor readings to the
-HWMON system. The driver is aware of and reads the following sensors:
+The driver is aware of and reads the following sensors:
 
 1. Chipset (PCH) temperature
 2. CPU package temperature
@@ -32,7 +32,8 @@ HWMON system. The driver is aware of and reads the following sensors:
 4. Readings from the T_Sensor header
 5. VRM temperature
 6. CPU_Opt fan RPM
-7. Chipset fan RPM
-8. Readings from the "Water flow meter" header (RPM)
-9. Readings from the "Water In" and "Water Out" temperature headers
-10. CPU current
+7. VRM heatsink fan RPM
+8. Chipset fan RPM
+9. Readings from the "Water flow meter" header (RPM)
+10. Readings from the "Water In" and "Water Out" temperature headers
+11. CPU current
-- 
2.34.1

