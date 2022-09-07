Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EFE5B0574
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiIGNjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiIGNib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:38:31 -0400
Received: from es400ra01.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD609E89E;
        Wed,  7 Sep 2022 06:38:13 -0700 (PDT)
Received: from es400ra01.iit.it (127.0.0.1) id h32fbk0171sr; Wed, 7 Sep 2022 15:22:36 +0200 (envelope-from <prvs=1249fcc2cf=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding:Content-Type; bh=I+LGcW2HqkjENIvmhYhT+
        mN20z8eNbCZUrR5lhbl6YY=; b=gAQ/f3TYVFclOt99IV0w/GnwRqNa14BeUGQMV
        4L+JWX137mwHC+3JdQzVg64/fVyIab2L4LtyzbDPGJuCKbh7TXdd3bmEfBaUhoMn
        LM9LT1sX6tCcaB0qZSOZPYlq8DZ6T4ZKjUeep5NILtpPUvAeG96jMIvyrHi1Czui
        o8juCs=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra01.iit.it ([172.31.0.241]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202209071322360176984-11; Wed, 07 Sep 2022 15:22:36 +0200
Received: from poker.iit.local (10.10.20.64) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Wed, 7 Sep
 2022 15:22:35 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        <andrea.merello@gmail.com>, <bagasdotme@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v7 14/14] docs: iio: add documentation for BNO055 driver
Date:   Wed, 7 Sep 2022 15:22:05 +0200
Message-ID: <20220907132205.28021-15-andrea.merello@iit.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907132205.28021-1-andrea.merello@iit.it>
References: <20220907132205.28021-1-andrea.merello@iit.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.10.20.64]
X-ClientProxiedBy: IITMXWGE021.iit.local (10.255.8.187) To
 iitmxwge020.iit.local (10.255.8.186)
X-Mlf-DSE-Version: 6948
X-Mlf-Rules-Version: s20220810181453; ds20200715013501;
        di20220831211829; ri20160318003319; fs20220901203539
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: Andrea.Merello@iit.it
X-Mlf-Version: 10.0.16.7295
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202209071322360176984
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

The bno055 driver is rather complex and have some oddities and not-obvious
things that worth to document (e.g. calibration files).

This patch also contains this [0] fix squashed in.

[0] https://lore.kernel.org/lkml/20220704034041.15448-1-bagasdotme@gmail.com/

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 Documentation/iio/bno055.rst | 51 ++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |  2 ++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/iio/bno055.rst

diff --git a/Documentation/iio/bno055.rst b/Documentation/iio/bno055.rst
new file mode 100644
index 000000000000..9a489a79d8f5
--- /dev/null
+++ b/Documentation/iio/bno055.rst
@@ -0,0 +1,51 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+BNO055 driver
+==============================
+
+1. Overview
+===========
+
+This driver supports Bosch BNO055 IMUs (on both serial and I2C busses).
+
+Accelerometer, magnetometer and gyroscope measures are always provided.
+When "fusion_enable" sysfs attribute is set to 1, orientation (both Euler
+angles and quaternion), linear velocity and gravity vector are also
+provided, but some sensor settings (e.g. low pass filtering and range)
+became locked (the IMU firmware controls them).
+
+This driver supports also IIO buffers.
+
+2. Calibration
+==============
+
+The IMU continuously performs an autocalibration procedure if (and only if)
+operating in fusion mode. The magnetometer autocalibration can however be
+disabled writing 0 in the sysfs in_magn_calibration_fast_enable attribute.
+
+The driver provides access to autocalibration flags (i.e. you can known if
+the IMU has successfully autocalibrated) and to the calibration data blob.
+
+The user can save this blob in a firmware file (i.e. in /lib/firmware) that
+the driver looks for at probe time. If found, then the IMU is initialized
+with this calibration data. This saves the user from performing the
+calibration procedure every time (which consist of moving the IMU in
+various way).
+
+The driver looks for calibration data file using two different names: first
+a file whose name is suffixed with the IMU unique ID (exposed in sysfs as
+serial_number) is searched for; this is useful when there is more than one
+IMU instance. If this file is not found, then a "generic" calibration file
+is searched for (which can be used when only one IMU is present, without
+struggling with fancy names, that change on each device).
+
+Valid calibration file names would be e.g.
+ bno055-caldata-0e7c26a33541515120204a35342b04ff.dat
+ bno055-caldata.dat
+
+In non-fusion mode the IIO 'offset' attributes provide access to the
+offsets from calibration data (if any), so that the user can apply them to
+the accel, angvel and magn IIO attributes. In fusion mode they are not
+needed (the IMU firmware internally applies those corrections) and they
+read as zero.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 58b7a4ebac51..1b7292c58cd0 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -10,3 +10,5 @@ Industrial I/O
    iio_configfs
 
    ep93xx_adc
+
+   bno055
-- 
2.17.1

