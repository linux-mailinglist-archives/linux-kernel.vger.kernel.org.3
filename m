Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316E1497718
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiAXB5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiAXB5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:57:15 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11096C06173B;
        Sun, 23 Jan 2022 17:57:15 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso26545209wms.4;
        Sun, 23 Jan 2022 17:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxNPKXNgPBpizAlXXQnSjyS2LmsF/9xUr6n65dLB5Ic=;
        b=bD0WuQ3ojZaRMUxrDGOLXn8780jcQnl0TK2IrY9JvMipTL/mPQuso2uB5NDSP3bfVW
         QZXvELsvCY3T+9pTVaGxqryzWcQHulZrxUcbwfIrzlG/rXJ7mtI4OVVyBissx5dpF2S6
         1fcVbBtVQUgPoBbXmve1bkkfmvI02Bg1IHZF5Un8H4Q3yucew6+ZF7ui5SF/kmRVDJED
         Plc1/nmKThgNR1NJO3Qrm8qGeXD1rr3wrp8h/X5+aa4HOu0QdPC91+EKos4xoEUHt3oK
         eCxKVwny0A2eDDKNSAWEYsB4sV+D01shtyOHyluzRLW/+MKFCtOZ2Mg1389oCB6Wc8mo
         gpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxNPKXNgPBpizAlXXQnSjyS2LmsF/9xUr6n65dLB5Ic=;
        b=ySr++3gA5uQx986Y0xLSaDdV8Q1aj5tIqcLgyS5sVz7o3oYE3LB/V9l3EXKue/cyET
         mEpotprGxtPmeBX8AlokOkNl3EBS3Ee0Vzt8mBfbf1Gg3/ivaluhlchXBw72Vc+yPNJ+
         cxNqxUeljvkfmN12acmUbZWlBtyvGEs8xtPPuIhL02k4SQakKSm9Sbl8w3H7mERNgfJ6
         fkB8R8GbcS8oFRL9EoDLJd8NjCpA0rXyv65C0rMY0wkIHvXSKAxApjzK89aat/9o9h8x
         sRWt7R/XNuAw1ITGbO3iy3Y+snLs2VDhwDvh9Nydw6aU8O+YIMxbPeKThzeCbbjHd6vJ
         zfJg==
X-Gm-Message-State: AOAM530zcmx6XyiGnJlx8SomCp2FPeZR9p9tjlum7rnxuKCeNh/PyHkX
        nL9vk+1Q1dqbr9vc+Q6WpDVLydhBCO0=
X-Google-Smtp-Source: ABdhPJy3bLpRQcykC0+CIIf0RKlN+uyOjf8HS/VU2CUzHt8BefV1q5IozRb70fp7OwPvH53ex0aSYA==
X-Received: by 2002:a05:600c:3caa:: with SMTP id bg42mr7849733wmb.193.1642989433584;
        Sun, 23 Jan 2022 17:57:13 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id i2sm3224968wmq.23.2022.01.23.17.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 17:57:13 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        oleksandr@natalenko.name, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [ASUS EC Sensors v8 0/3]
Date:   Mon, 24 Jan 2022 02:56:42 +0100
Message-Id: <20220124015658.687309-1-eugene.shalygin@gmail.com>
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

Changes in v8:
 - Fixed formatting (removed doc comments, removed redundant new line).
 - Changed hwmon device name (asus_ec_sensors -> asusec) removing
	 unnecessary "sensors" word.

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

