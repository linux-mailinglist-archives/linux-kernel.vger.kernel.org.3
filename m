Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39EF492BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346782AbiARQxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346658AbiARQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:53:40 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11D7C06161C;
        Tue, 18 Jan 2022 08:53:39 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c2so23544756wml.1;
        Tue, 18 Jan 2022 08:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRAWtfjjgO5udN5+BKSAfe9dAH85zJZw/J7zjuoQ9nM=;
        b=Dqb8O6GEYwt8HCmaHuN1I+GcjxznFBzwxuZuQSEgO3bTJaokbixGAe8kgncdkE/VNz
         bryh8WKSu10Jtncf2jG+g3DTXhINZ0XjLePrs70VSDJ86Nbo/OxIjWo6bnDqSow/fwxY
         Hmu9bk5Cl8No5EvWiWvenUCcadbzXsGvzdUsWmO5Bh/juNwxmjVPTgB42Rf4uGysVR/+
         jiYxH79KncyeO7ewBOtdgkgTYGjW9M0uWNMyQSaolx3YpxzCvLw6xoqSqLw0ffhvPSan
         oGxwmiHDbhrJZUSn5b0dtXBwZj8xxJHbDJICT8v7DHbz17FqQVk3PAGsxQE/JyzfW2cu
         RXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRAWtfjjgO5udN5+BKSAfe9dAH85zJZw/J7zjuoQ9nM=;
        b=A7F0fHRlCcosnuLSBU2VsEtjRssrvZ2ZdCxcKEi24etD3iCPWT6pP3u2jfJafVcMn0
         M+bjolBq8yZmYU2WRGtzpHHtLBURjVjIzvu5WnZY0C8INTrpj5GRXSWHm5osy2IQxTXB
         0gG+rP0iPGan4/kw/D51I9S7Dc+tgVyibVoXAXMBAPPXXzHkOtNanELLX35r2Wz0AA47
         r3TebEORpbW7mpx/zzpLT1so3Y6Vre0AakItBDkrD1fzo9Jm8iZy0++xcM4HPgWiTrfv
         NR1ei0Vpe3V70nxvPHOyWkBahLejILVM16VO3dn9mXZAKOTikDr4gzTOH6PuNWJ+HKrA
         YiNQ==
X-Gm-Message-State: AOAM530HOUk8R0PHUEDdZ4RSSx8y3JZPxr3zKA8rrTRw3ahPeq1CnGEY
        LB+B7ry4soRULQL3F5nSB50=
X-Google-Smtp-Source: ABdhPJwjm8rQCg0TKQgSjD4CWMm1aJAlhnlKVN716sTW6eCvfVZJFwlYsQUwAPUrNNgYjymzLCCbjA==
X-Received: by 2002:a5d:59ac:: with SMTP id p12mr13734859wrr.9.1642524818602;
        Tue, 18 Jan 2022 08:53:38 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id o12sm10634141wrc.51.2022.01.18.08.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 08:53:38 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [ASUS EC Sensors v7 3/3] hwmon: deprecate asis_wmi_ec_sensors driver
Date:   Tue, 18 Jan 2022 17:53:09 +0100
Message-Id: <20220118165316.412735-4-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118165316.412735-1-eugene.shalygin@gmail.com>
References: <20220118165316.412735-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate the asus_wmi_ec_sensors driver in favor of the asus_ec_sensors

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2c16b19d2c03..38094c702e4d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2243,13 +2243,16 @@ config SENSORS_ASUS_WMI
 
 config SENSORS_ASUS_WMI_EC
 	tristate "ASUS WMI B550/X570"
-	depends on ACPI_WMI
+	depends on ACPI_WMI && SENSORS_ASUS_EC=n
 	help
 	  If you say yes here you get support for the ACPI embedded controller
 	  hardware monitoring interface found in B550/X570 ASUS motherboards.
 	  This driver will provide readings of fans, voltages and temperatures
 	  through the system firmware.
 
+	  This driver is deprecated in favor of the ASUS EC Sensors driver
+	  which provides fully compatible output.
+
 	  This driver can also be built as a module. If so, the module
 	  will be called asus_wmi_sensors_ec.
 
-- 
2.34.1

