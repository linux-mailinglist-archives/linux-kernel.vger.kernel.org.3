Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC985B054D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiIGNhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiIGNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:37:36 -0400
X-Greylist: delayed 604 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 06:37:32 PDT
Received: from es400ra02.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76C588DDB;
        Wed,  7 Sep 2022 06:37:31 -0700 (PDT)
Received: from es400ra02.iit.it (127.0.0.1) id h32f9i0171sv; Wed, 7 Sep 2022 15:22:30 +0200 (envelope-from <prvs=1249fcc2cf=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding:Content-Type; bh=K3e63DsllIB8jiQP3oThb
        e+k0ee6w3x2H75Xq2bGxw0=; b=TaH4uy38azvp2BrA1GOyi86cr1HsWZRZE0VU4
        Ozz9nW2XeeFq63F28T4v5aU6MNW3KrhkwEihf3HtpIVaTvSRFtPSz68nxx7Gqm8u
        0Lq9GZkWYectgqeJxjrDMMqgJ7DSsyRBBN0O3xRDjSzgCTCKHPD51i/7lxZYQcm7
        f3Dk/E=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra02.iit.it ([172.31.0.242]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202209071322300212551-8; Wed, 07 Sep 2022 15:22:30 +0200
Received: from poker.iit.local (10.10.20.64) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Wed, 7 Sep
 2022 15:22:28 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        <andrea.merello@gmail.com>, <bagasdotme@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v7 09/14] iio: document bno055 private sysfs attributes
Date:   Wed, 7 Sep 2022 15:22:00 +0200
Message-ID: <20220907132205.28021-10-andrea.merello@iit.it>
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
X-Mlf-UniqueId: o202209071322300212551
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Add ABI documentation for bno055 driver private sysfs attributes.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 .../ABI/testing/sysfs-bus-iio-bno055          | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-bno055 b/Documentation/ABI/testing/sysfs-bus-iio-bno055
new file mode 100644
index 000000000000..f32b1644e986
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-bno055
@@ -0,0 +1,81 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_raw_range
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) range for acceleration readings. Unit after
+		application of scale is m/s^2. Note that this doesn't affects
+		the scale (which should be used when changing the maximum and
+		minimum readable value affects also the reading scaling factor).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_raw_range
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Range for angular velocity readings in radians per second. Note
+		that this does not affects the scale (which should be used when
+		changing the maximum and minimum readable value affects also the
+		reading scaling factor).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_raw_range_available
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of allowed values for in_accel_raw_range attribute
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_raw_range_available
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of allowed values for in_anglvel_raw_range attribute
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_calibration_fast_enable
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be 1 or 0. Enables/disables the "Fast Magnetometer
+		Calibration" HW function.
+
+What:		/sys/bus/iio/devices/iio:deviceX/fusion_enable
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be 1 or 0. Enables/disables the "sensor fusion" (a.k.a.
+		NDOF) HW function.
+
+What:		/sys/bus/iio/devices/iio:deviceX/calibration_data
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the binary calibration data blob for the IMU sensors.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibration_auto_status
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the accelerometer sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_calibration_auto_status
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the gyroscope sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_calibration_auto_status
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the magnetometer sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/sys_calibration_auto_status
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the status for the IMU overall autocalibration.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
-- 
2.17.1

