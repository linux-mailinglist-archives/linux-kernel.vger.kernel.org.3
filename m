Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA3450FE96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350779AbiDZNO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350721AbiDZNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:14:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF2E60A86;
        Tue, 26 Apr 2022 06:11:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e2so19133059wrh.7;
        Tue, 26 Apr 2022 06:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idMpnOwwQxknrLO1JzQQ/GiHZ1ucfvlCNdrCkbdfxuE=;
        b=FWupyOrCF08QhEmgz36sz4qRHXL2jW1myoO+7awOm6kv7X0kknLxO9KKBUKeN61i7c
         o4NCh9wiFAhZ6iUdgc6Zk7++kc7F6D0H3+2Qhws3YrNvpaxBSiQBthEtH5IfXjuGlNYr
         peYjjHJ+UNY8oXduzdXozdbTW1qP7CjOe2m6E4u/jdl9h0r4c6OK5XI78+n7QTTkZt0W
         MPZrK6lBOTT1mA794rlDDOzL0RoIwoD03mDhLG084Q5SydYR55W9pWIigNZenvENiz+t
         ypFEJo3ANnnftAEMnWa/beESBaWWainZxYEWIxYS//zhn5GLB2Izg0vtnUVA0RWjfd0R
         uUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idMpnOwwQxknrLO1JzQQ/GiHZ1ucfvlCNdrCkbdfxuE=;
        b=wkmjkub03ZRUkgjVvcVi7t3xJzVX+RRv2tO1A+sLsqPDiSrbYqwUhLeABK8AEV3PBR
         jpLj/gutaKdNuzr8jUL0rCv/9+nEkYTB/JqnMcRV4tLriKeVi4JFFzVkQBMTttQ48ksO
         xTeNHmPpEMQEp9TOXtS/aYr62W+TEZgnqyOPInpVYRn0zxqALed1w5QotJg4RrRHEDYk
         8HPSAP16oaG5bHdMe68Rg+QMkc7brKTuhE6mbIqmqynWxQo4v5syJVhEfJAN82Hd/F4i
         mm/FM/16wd2yvrOHAAy20Kpie23x5KeUxZBk1wMTqcatduK4GGvfs0o0t43hR3i+PTYH
         2gRw==
X-Gm-Message-State: AOAM533LFl/bizF0ImOC23kqTcnsT3rxBvcJrSfKHdkf4PDMis2477uj
        TKFMhQidDVsnNgo1K90GXsk=
X-Google-Smtp-Source: ABdhPJzhgujtOVdiLeXqN2oVPT6T8NSjK3k7smFkJZUd3NKRdzfXv0rRY4tLvx6o/O+RdWGks2HaWA==
X-Received: by 2002:a5d:6211:0:b0:1ef:85dd:c96b with SMTP id y17-20020a5d6211000000b001ef85ddc96bmr17822128wru.456.1650978676915;
        Tue, 26 Apr 2022 06:11:16 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm3262910wmq.47.2022.04.26.06.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:11:16 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v5 09/14] iio: document bno055 private sysfs attributes
Date:   Tue, 26 Apr 2022 15:10:57 +0200
Message-Id: <20220426131102.23966-10-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426131102.23966-1-andrea.merello@gmail.com>
References: <20220426131102.23966-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Add ABI documentation for bno055 driver private sysfs attributes.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 .../ABI/testing/sysfs-bus-iio-bno055          | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-bno055 b/Documentation/ABI/testing/sysfs-bus-iio-bno055
new file mode 100644
index 000000000000..22a5c6dc90dc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-bno055
@@ -0,0 +1,81 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_raw_range
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) range for acceleration readings. Unit after
+		application of scale is m/s^2. Note that this doesn't affects
+		the scale (which should be used when changing the maximum and
+		minimum readable value affects also the reading scaling factor).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_raw_range
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Range for angular velocity readings in radians per second. Note
+		that this does not affects the scale (which should be used when
+		changing the maximum and minimum readable value affects also the
+		reading scaling factor).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_raw_range_available
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of allowed values for in_accel_raw_range attribute
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_raw_range_available
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of allowed values for in_anglvel_raw_range attribute
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_calibration_fast_enable
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be 1 or 0. Enables/disables the "Fast Magnetometer
+		Calibration" HW function.
+
+What:		/sys/bus/iio/devices/iio:deviceX/fusion_enable
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be 1 or 0. Enables/disables the "sensor fusion" (a.k.a.
+		NDOF) HW function.
+
+What:		/sys/bus/iio/devices/iio:deviceX/calibration_data
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the binary calibration data blob for the IMU sensors.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibration_auto_status
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the accelerometer sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_calibration_auto_status
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the gyroscope sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_calibration_auto_status
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the magnetometer sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/sys_calibration_auto_status
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the status for the IMU overall autocalibration.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
-- 
2.17.1

