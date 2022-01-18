Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B43492B99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346512AbiARQxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiARQxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:53:32 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A8C061574;
        Tue, 18 Jan 2022 08:53:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id w26so29096440wmi.0;
        Tue, 18 Jan 2022 08:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fD75JvyIsiVpBEx5QtG5GC9Un7z17Fl7pTIMPWRtl8I=;
        b=maWYMrui4TgwRqDdWVibXHB5T1WIxc2iuT4yxI71rVkDkyQCUMn78HZ5u5c9lBSump
         0p5sZJo6P5zFrWZMkO+GgU5Mni1gwAoLBbejaEAq0n4lAqpMHUBL6dm+hm88GFfPAW/9
         11MbesyOM/eBMsi2euH+wY5nCPnxsjFQnv/fF7Ts/Rdo+o9K4XZYLSJ7Qi062+hJaJu6
         QD41eEI3wS1SqEXTdRh38uE+2k7z3xTL8/6CZO9tEIyFvUAIEt+tcb9yU7werzSOgp+J
         rERw2TsoDVP45ZcnznL3rd/zMVD7Gr+ZJjUxgAuxG98Wt6a41kxD+g/JA92BzfGiaWeh
         +MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fD75JvyIsiVpBEx5QtG5GC9Un7z17Fl7pTIMPWRtl8I=;
        b=B29lcc3WwO89OHx7Dx1+TWcUByuZregk/5UDOAcVGxnv9+C8+EGdJMfKZdLgHCFuZp
         X04DVJCpWS46XuJKelhvoJxXe912u4/tVCJ1jf9zLH/2WuAcFkEAJwYaLV6CPUYKueb9
         A00l1OQg4FxeqQfiGfabRr0mIGaPf0rlgcFPZXw0CIMCrtRguYSwDsBWg3qO6h3o8zJB
         kuCoNW1UwxSAOozQ7DCVpuzOHP5s2vGPze+tt0KQIyAbuMn0giJAu3Jcez1/scUudhl9
         kW5kt6w+uKJYFvOzPSBNCd0Gm05rVQ/mINroASzCy+CvFXAOHQlxqvtIrVmWeEH6IFl+
         57/g==
X-Gm-Message-State: AOAM531sQ4Nlh6VLYzR97UETuFG/OYPV5AzS1Qr+IjZWjFd0mm3iF8Kt
        scivhr19BuK33ouqKfB00pw5jcGgfCvt9A==
X-Google-Smtp-Source: ABdhPJz6ngw+lrAu63PBTllko9nB58N2mt4o+jQmmv5wJrRe7ZIn9cVcNBWeMk6qbSX6KBNSvMOd8w==
X-Received: by 2002:a5d:6da1:: with SMTP id u1mr18367215wrs.592.1642524810267;
        Tue, 18 Jan 2022 08:53:30 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id o12sm10634141wrc.51.2022.01.18.08.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 08:53:29 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [ASUS EC Sensors v7 0/3]
Date:   Tue, 18 Jan 2022 17:53:06 +0100
Message-Id: <20220118165316.412735-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces the HWMON asus_wmi_ec_sensors driver with
an implementation that does not use WMI but queries the embedded
controller directly.

That provides two enhancements: sensor reading became quicker (on some
systems or kernel configuration it took almost a full second to read
all the sensors, that transfers less than 15 bytes of data), the driver
became more fexible. The driver now relies on ACPI mutex to lock access
to the EC, in the same way as the WMI DSDT code does.

Changes in v7:
 - Add suport for the ROG STRIX X570-F GAMING board.
 - Add the __init attribute to two more functions.

Changes in v6:
 - Fixed hwmon device name replacing dashes with underscores.
 - Removed module verion.
 - Fixed condition for asus_wmi_ec_Sensors in KBuild.

Changes in v5:
 - Place the sensors bitset directly into the driver_data field of the
   dmi_system_id struct.
 - Replace doc comments with regular ones.

Changes in v4:
 - Deprecate the wmi driver rather than removing it.

Changes in v3:
 - Remove BIOS version checks and BIOS version dependent mutex path.

Changes in v2:
 - Replace sensor flags enum with bitset
 - Replace module init/probe functions with module_platform_driver_probe
   and ask the platform drivers framework to load the driver when ACPI
   EC is found (ACPI ID "PNP0C09").
 - Extend board data with BIOS version attribute for the mutex path to be
   BIOS version dependent.
 - Add module parameter to override the mutex path.

Eugene Shalygin (3):
  hwmon: (asus-ec-sensors) add driver for ASUS EC
  hwmon: (asus-ec-sensors) update documentation
  hwmon: deprecate asis_wmi_ec_sensors driver

 Documentation/hwmon/asus_ec_sensors.rst     |  52 ++
 Documentation/hwmon/asus_wmi_ec_sensors.rst |  38 --
 MAINTAINERS                                 |   6 +
 drivers/hwmon/Kconfig                       |  16 +-
 drivers/hwmon/Makefile                      |   1 +
 drivers/hwmon/asus-ec-sensors.c             | 694 ++++++++++++++++++++
 6 files changed, 768 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/hwmon/asus_ec_sensors.rst
 delete mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 drivers/hwmon/asus-ec-sensors.c

-- 
2.34.1

