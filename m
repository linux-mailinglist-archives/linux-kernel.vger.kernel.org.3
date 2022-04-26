Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F167750FE94
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350795AbiDZNPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350742AbiDZNOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:14:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A3960AB4;
        Tue, 26 Apr 2022 06:11:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso1460282wme.5;
        Tue, 26 Apr 2022 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VbIqYrl/j/4f2JpJRwKTfog5CMhMNsgfur6sJmAAYyM=;
        b=hXqzTTps2HVRXHQSYmBwN2XN1rYAupQNRApRyMp0zDmiOZ1aSMIAart17L/C3E5oUb
         2cqHPJ65BoShl2+SSbrHxQTpiVHUFQVzc0G9WgtTgh6TR+8lrewvVjsOYXffalfAh1Lo
         AhKGn/So5VWuhfINEeZlYKEZoYJ9R8k+1xxRfPjEKnylgVGNkOgwIrY1bpfu0aCreWYG
         jXkW4Lq5VKZMsgThNJNyy6tLN+l+7PqVscCKFwWi+duJGWHH8ZBqMRvBsSG/fWkESXUg
         5Bh68MZuWKh7nKJNXDILYPDfR7DTbYS5jfy6sbuTuExQ75Oo0EfqqYkd49X9Px5kfJ8f
         ny3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VbIqYrl/j/4f2JpJRwKTfog5CMhMNsgfur6sJmAAYyM=;
        b=EyaQfLvim7GzkbXC4ry/d97Homs6CqkxfI2uZstGTObm36oka1eKwaF5cpDMP89V+M
         wICpqfHXGoysRhehlBRF2qk0IADOagS9X/OaLggHp5Ha0o9G5pdzfk76+jqs0i3wbxs5
         4iqsZOYuvS/JI9I1WvJxY5QwqiaspP2okB6xVU0aG/Qe2VQfqn81gy2cdMQBTwYTTKgd
         sq+NxGPZfI1rvjdnrHWGjcF6Pu7nhuzRaXmLDVDndGqQxcMtE0ItngEyJbKT+DdWFHt0
         LXmPXdJSYDLfJBPfmOW4AvLqNRYdbVo7uAiSHtIAn9+RZr4lnH5g8BReoPBlVXVh8hll
         UhQA==
X-Gm-Message-State: AOAM5334OqqjHXOiA6rj27zMzxnV8+pfxPFQxT50JQu7ZcsaVABKw/es
        ZhkyR4YtZ5pvlsbdh301IrA=
X-Google-Smtp-Source: ABdhPJyJx3p6eMl28pdya7q+rrOr3vzQaeqoVn0kIgN543h8VeoLjAyDSIjI3OLtkLU797eb8wrEHA==
X-Received: by 2002:a05:600c:3b02:b0:393:e7d4:b660 with SMTP id m2-20020a05600c3b0200b00393e7d4b660mr12637839wms.183.1650978682527;
        Tue, 26 Apr 2022 06:11:22 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm3262910wmq.47.2022.04.26.06.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:11:22 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v5 14/14] docs: iio: add documentation for BNO055 driver
Date:   Tue, 26 Apr 2022 15:11:02 +0200
Message-Id: <20220426131102.23966-15-andrea.merello@gmail.com>
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

The bno055 driver is rather complex and have some oddities and not-obvious
things that worth to document (e.g. calibration files).

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 Documentation/iio/bno055.rst | 50 ++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/iio/bno055.rst

diff --git a/Documentation/iio/bno055.rst b/Documentation/iio/bno055.rst
new file mode 100644
index 000000000000..af21376d7a25
--- /dev/null
+++ b/Documentation/iio/bno055.rst
@@ -0,0 +1,50 @@
+.. SPDX-License-Identifier: GPL-2.0
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

