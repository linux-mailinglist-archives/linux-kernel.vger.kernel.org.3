Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2748FEC7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 21:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiAPUTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 15:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbiAPUTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 15:19:01 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF2CC061574;
        Sun, 16 Jan 2022 12:19:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w16so56901446edc.11;
        Sun, 16 Jan 2022 12:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cM72o/X0eOXb/IxXhR6Z9AIge0rlk96uvYViLKdmv3w=;
        b=kaD6yHxoCnovIcInLTTIIjb7IVKfbZA4bmuOTpmOa64FdqYRM4z1fFBi/114dpHevE
         +CVzWxEantiMBAdsJ0FCd/7LlhbmYQU+mAeDJ1B++mJrNBEDIqICKbrqdZJMYh/FY2ph
         SVKbkUSyy80GHjaqpqwvycoUWTHv3/fOWjHYB3AYhjRG/dH7yshBfn0Dgd80JKBf0N5f
         iDDWe254b2XhIYMrEf35VFrD5IViTnPy47gm1T+y3lNY3oSiWrkbbxNuh1zq/BanzILF
         4YqluShJZtKE9njYZIzgd44hYqy28FZQ6CLtFC/5oQRble8qnqV26nRYDsrRm5qWScek
         Asfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cM72o/X0eOXb/IxXhR6Z9AIge0rlk96uvYViLKdmv3w=;
        b=ftcQBFMPvnXD4rxONrdgANZEeP4I0Gh8lfLy75acEjQuPQ3XL9vVZOyspLMl6ISXLS
         TFuYOmnrynIZ5YaIm+W66ovS8gGp5U83k2RNo6A802jkcS/nDyZbMcwQ4MP5KkDYsNzi
         b2/kGlhcx0doE1tIgDyedvcNcb1enM1E9EDPvdVNjontQwYyS37qoQAkNsbj9n1xTa75
         tdMrVSHlDXzvWZo3Ecqf+mUKTvPKmvLqQG+YfCYyExqOMYE9RsvzaTPPZK/X3M95w7tB
         6hxtr8jEKjsuXKVWLzqPQHJ63tVm1a0M16yemBB1b3WJxY32A8MT/FxnkZANsgMXWqtn
         Depw==
X-Gm-Message-State: AOAM530LzvXf53LIb1fMLuDIJ6qWEJaAjH+2AOeP1ngDsSJzP1xLui4c
        6YjMEs3EJCE1G71YtZU2Of9Y8MvagC6ppQ==
X-Google-Smtp-Source: ABdhPJxv6fFW0gjWeOD+i2J/SaZlwkRqxNlDPv1zQkqstMuYLa3TYCocMjp9x8Es+XCq+DNb/+urhg==
X-Received: by 2002:a05:6402:27d1:: with SMTP id c17mr17593585ede.128.1642364337634;
        Sun, 16 Jan 2022 12:18:57 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f4053004b601b67b388bdb4.dip0.t-ipconnect.de. [2003:cf:9f40:5300:4b60:1b67:b388:bdb4])
        by smtp.googlemail.com with ESMTPSA id eg30sm2529452edb.85.2022.01.16.12.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 12:18:57 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [ASUS EC Sensors V6 v6 0/3]
Date:   Sun, 16 Jan 2022 21:18:38 +0100
Message-Id: <20220116201843.2301438-1-eugene.shalygin@gmail.com>
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

 Documentation/hwmon/asus_ec_sensors.rst     |  51 ++
 Documentation/hwmon/asus_wmi_ec_sensors.rst |  38 --
 MAINTAINERS                                 |   6 +
 drivers/hwmon/Kconfig                       |  16 +-
 drivers/hwmon/Makefile                      |   1 +
 drivers/hwmon/asus-ec-sensors.c             | 690 ++++++++++++++++++++
 6 files changed, 763 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/hwmon/asus_ec_sensors.rst
 delete mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 drivers/hwmon/asus-ec-sensors.c

-- 
2.34.1

