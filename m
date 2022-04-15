Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD17502AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354042AbiDONEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353935AbiDONDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:03:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA29366AD;
        Fri, 15 Apr 2022 06:00:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b15so9851701edn.4;
        Fri, 15 Apr 2022 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1uuQGvfh8vFWU1llTooYRNPk+PjiEO3+SafqMRB+yTM=;
        b=MmV3Nlngf1Oa8Eqp2bgiBSkaDi4MmYrtIQ7m6mkS7q+rvOtnL6mw0Ed2GcZDynGLng
         80khJtznKxUY0/ag2Hn7PnyIofTF0wtDNMzUcVkLuDhs8Ff24ZufppNfbzqMFeMXH2h6
         7r+AFUpkur87hKgGrsDlpnFwkbrh6T5x3CbYxxc8RTCiH3yYjPTghw9aOXjhTa1JCm6x
         7zBNUFubyB/Rqva4UjoUnQGvCk/oZaP1R8Cr4BoW1Zjn9T7vW/twEcqx/5uXzVNkofru
         NOgeWNYfXe80bVuBV8PGRC/9+p1ujqCx+YTy79S/HX3Kug1BTcAVuOjRN4KogXXnk6/s
         eOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1uuQGvfh8vFWU1llTooYRNPk+PjiEO3+SafqMRB+yTM=;
        b=vNuj4T08Y0PeLdw0w5OCy7YExX6lIJyF76VM6ue/zmKt1sFc/ccNWENwNTdRThKVTK
         z/xaAUUeHRvNuSamPBM1ohRWWoboI+d76GNQjSjnq/fSCCvKgErkWBHqRx3CzCvWOSQ4
         WSkA+juQmTC27CBGJAY0V7fw59+wtKUEPFmQypDE1+Qjo1Y9xBNdAMzWOG2OchDCNUCN
         s6ZyESnujznHbmZKuEqbpPhI7VEZBUHOIcCBmdZ6UOxfMA1n+fdiFgitqRzAc7fjk8rb
         peDfw1n25QlqGc/ysbzlqNwMwyQNlJQ4Gs8+4YN3UJyBvRyB5/MwXj3TQMw+5zWn8cSX
         ZtQA==
X-Gm-Message-State: AOAM531VuRPAfkksav9ryQ/YYOpm0U545vy+gSTTZgutCxHbB8WoRwVX
        mLPKUyRTeNZTzpRjjUuuPbM=
X-Google-Smtp-Source: ABdhPJyeAttSECor5jE+sp05qKsQlQKvNgaay0NnVVoJUNP2Qsnt3bPdTnOv5ZMJB9IMW8NqCkvOuA==
X-Received: by 2002:a05:6402:238d:b0:41d:7630:2300 with SMTP id j13-20020a056402238d00b0041d76302300mr8172120eda.363.1650027638294;
        Fri, 15 Apr 2022 06:00:38 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2704715edj.0.2022.04.15.06.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:00:37 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v4 14/14] docs: iio: add documentation for BNO055 driver
Date:   Fri, 15 Apr 2022 15:00:05 +0200
Message-Id: <20220415130005.85879-15-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415130005.85879-1-andrea.merello@gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

The bno055 driver is rather complex and have some oddities and not-obvious
things that worth to document (e.g. calibration files)

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

