Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B709D54B08B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiFNM16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiFNM14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:27:56 -0400
Received: from es400ra02.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE4421266;
        Tue, 14 Jun 2022 05:27:50 -0700 (PDT)
Received: from es400ra02.iit.it (127.0.0.1) id hl1vc40171s9; Mon, 13 Jun 2022 14:05:54 +0200 (envelope-from <prvs=1163b4114e=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding:Content-Type; bh=VBTL6Apel5oB8rKCVDhtd
        2UfB/i7hDekWFdZzJO1MWU=; b=ZUhXFk/r3F7s/uTXUetAfRUbL/zENc8bgS86S
        J+5hNENkd2KpZUpKKnvoEq6ft363IKhckc4ifTKxKjMqF20CpSxzpUXTrE8Dmld9
        V6uF3RJMHB+gN1yhxs+2fW3n7nnAH+1RA3GZFtXPPRJwY3qWdFupwYM5yknkook6
        KpCuT0=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra02.iit.it ([172.31.0.242]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202206131205540231025-8; Mon, 13 Jun 2022 14:05:54 +0200
Received: from poker.lan (90.147.26.235) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.17; Mon, 13 Jun
 2022 14:05:54 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v6 09/14] iio: document bno055 private sysfs attributes
Date:   Mon, 13 Jun 2022 14:05:29 +0200
Message-ID: <20220613120534.36991-10-andrea.merello@iit.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613120534.36991-1-andrea.merello@iit.it>
References: <20220613120534.36991-1-andrea.merello@iit.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [90.147.26.235]
X-ClientProxiedBy: IITMXWGE021.iit.local (10.255.8.187) To
 iitmxwge020.iit.local (10.255.8.186)
X-Mlf-DSE-Version: 6873
X-Mlf-Rules-Version: s20220519150137; ds20200715013501;
        di20220610180234; ri20160318003319; fs20220610211824
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: Andrea.Merello@iit.it
X-Mlf-Version: 10.0.16.7295
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202206131205540231025
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
index 000000000000..8d3d0a79d7e4
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-bno055
@@ -0,0 +1,81 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_raw_range
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) range for acceleration readings. Unit after
+		application of scale is m/s^2. Note that this doesn't affects
+		the scale (which should be used when changing the maximum and
+		minimum readable value affects also the reading scaling factor).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_raw_range
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Range for angular velocity readings in radians per second. Note
+		that this does not affects the scale (which should be used when
+		changing the maximum and minimum readable value affects also the
+		reading scaling factor).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_raw_range_available
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of allowed values for in_accel_raw_range attribute
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_raw_range_available
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of allowed values for in_anglvel_raw_range attribute
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_calibration_fast_enable
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be 1 or 0. Enables/disables the "Fast Magnetometer
+		Calibration" HW function.
+
+What:		/sys/bus/iio/devices/iio:deviceX/fusion_enable
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be 1 or 0. Enables/disables the "sensor fusion" (a.k.a.
+		NDOF) HW function.
+
+What:		/sys/bus/iio/devices/iio:deviceX/calibration_data
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the binary calibration data blob for the IMU sensors.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibration_auto_status
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the accelerometer sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_calibration_auto_status
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the gyroscope sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_calibration_auto_status
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the magnetometer sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/sys_calibration_auto_status
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the status for the IMU overall autocalibration.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
-- 
2.17.1

