Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC47511B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbiD0Nqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbiD0Nqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:46:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C7C3B395E;
        Wed, 27 Apr 2022 06:43:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bv19so3491576ejb.6;
        Wed, 27 Apr 2022 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hmu0bkgn//dXI/P5wHwHmQRu1pJCrmiNt9JAutGmxpM=;
        b=jaZ8FHjruwTTLoIosbuLJKfJomhSpbPNpreE+dXl1UOQHyXVu+7mCgEc5MFDmKrAsV
         aCZUK3EAfvK+FS36H58W99pBZA99fX2bvpApqdvcrTVLaMW50P3HIXsfVLTvbF0pwBxW
         TQeM0uOY0E7hZr2sP7ysGv3AfmWiEo0rnJEfZSkIHaf3RBJh3LdU7TV1wytt1R9Tyu0K
         Iq3PCn4phFMuAiHnwK/tFDZhgXpCeatq0UzaQxcV9if7j7OVsnQYMwKQXz+9GaoMhK+d
         ytwRTw20lV8bD3uCFvWsN6BSYFakYmi34nHWavXsxFIPsoaEIBSykhu7WthFHSxtfTAO
         iOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hmu0bkgn//dXI/P5wHwHmQRu1pJCrmiNt9JAutGmxpM=;
        b=C1sGly9QwVxbBvhoVcfTZAIyq4wXiAKtiXKD3uphyieZOsKNb2zHNX1Myp04kNFiOz
         0FRr7qQU302Yfgup28s1Sk3ppiNblgrU542kiekw8D3gdlYVTbBaoKPajVp57VsfsykU
         mT9EcD7xKZLuUXpSxreU8VjTHZnh+NhRY8IMyD2bajqvQp0iphjc2ant/29Kt8gO+ylG
         /Y4HOGv2QxKwMNBMBAdnGZechXo8nbJXO+tW6g3IwA+uT0/yILeUpHlSYmCAnCwNZzyN
         7AjZ1aGQ+dFiQ6teuWfgnMJ/dfpOpDkQZepz/eHeBXggOrBXizZ9DnHK/8nm9YIdU/La
         MgaA==
X-Gm-Message-State: AOAM530hb8qjt6dIQ8PuwUgYc2x1cPxQbH+yaVlR6qWKNfNN9bfiP9lx
        65rV3CqqQLVjhxzmjLGkrJTWmboPwxz+KtWBYzw=
X-Google-Smtp-Source: ABdhPJzDbMVPJu0/8838MVBM+T1tFfZLPRx/fVoCq7YI3A22WU9Fmtl0KNXUMj6nqgxm0Ta1pcJyehX2can+m4DTBAA=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr26134448ejc.132.1651067005094; Wed, 27
 Apr 2022 06:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220426131102.23966-1-andrea.merello@gmail.com>
In-Reply-To: <20220426131102.23966-1-andrea.merello@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Apr 2022 15:42:49 +0200
Message-ID: <CAHp75VcoXu=0yvxmTwGAzexV_MgACXg-Cufkigt_kCEvbnwq_Q@mail.gmail.com>
Subject: Re: [v5 00/14] Add support for Bosch BNO055 IMU
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 3:11 PM Andrea Merello <andrea.merello@gmail.com> wrote:
>
> From: Andrea Merello <andrea.merello@iit.it>
>
> This series (tries to) add support for Bosch BNO055 IMU to Linux IIO
> subsystem. It is made up several patches:
>
>   1/14 to 6/14: add some IIO modifiers, and their documentation, to the IIO
>                 core layer, in order to being able to expose the linear
>                 acceleration and Euler angles among standard attributes.
>                 Also update the IIO event monitor tool
>
>   7/14: fix binary attributes didn't work with IIO
>
>   8/14 to 11/14: add the core IIO BNO055 driver and documentation for sysfs
>                  attributes and DT bindings
>
>   12/14: adds serdev BNO055 driver to actually use the IMU via serial line
>
>   13/14: adds I2C BNO055 driver to actually use the IMU via I2C wiring
>
>   14/14: add a documentation file that describe the bno055 driver and
>          specifically the calibration

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for non-commented patches (12 out of 14 AFAICS).

> Differences wrt v4:
> - be more tolerant wrt unrecognized chip IDs
> - rename 'serial_number' attribute in 'serialnumber'
> - fix missing NULL variable initialization
> - use sign_extend32() instead of s16 casting where appropriate
> - fix quaternion unit
> - minor stuff (e.g. comments..)
> - reduce (slightly) locking in serdev driver
> - rework tracepoint support (e.g. remove dedicated config option)
>
> Differences wrt other BNO055 drivers:
>
>   Previously at least another driver for the very same chip has been posted
>   to the Linux ML [0], but it has been never merged, and it seems no one
>   cared of it since quite a long time.
>
>   This driver differs from the above driver on the following aspects:
>
>   - This driver supports also serial access (to be reliable, reset pin is
>     required to be wired)
>
>   - The above driver tried to support all IMU HW modes by allowing to
>     choose one in the DT, and adapting IIO attributes accordingly. This
>     driver does not rely on DT for this, instead settings are done via
>     sysfs attributes.  All IIO attributes are always exposed; more on this
>     later on. This driver however supports only a subset of the
>     HW-supported modes.
>
>   - This driver has some support for managing the IMU calibration
>
> Supported operation modes:
>
>   - AMG (accelerometer, magnetometer and gyroscope) mode, which provides
>     raw (uncalibrated) measurements from the said sensors, and allows for
>     setting some parameters about them (e.g. filter cut-off frequency, max
>     sensor ranges, etc).
>
>   - Fusion mode, which still provides AMG measures, while it also provides
>     other data calculated by the IMU (e.g. rotation angles, linear
>     acceleration, etc). In this mode user has no freedom to set any sensor
>     parameter, since the HW locks them. Autocalibration and correction is
>     performed by the IMU.
>
>   IIO attributes exposing sensors parameters are always present, but in
>   fusion modes the available values are constrained to just the one used by
>   the HW. This is reflected in the '*_available' IIO attributes.
>
>   Trying to set a not-supported value always falls back to the closest
>   supported one, which in this case is just the one in use by the HW.
>
>   IIO attributes for unavailable measurements (e.g. Euler angles in AMG
>   mode) can't be read (return -EBUSY, or refuse to enable buffer).
>
> IMU calibration:
>
>   The IMU supports for two sets of calibration parameters:
>
>   - SIC matrix. user-provided; this driver doesn't currently support it
>
>   - Offset and radius parameters. The IMU automatically finds out them when
>     it is running in fusion mode; supported by this driver.
>
>   The driver provides access to autocalibration flags (i.e. you can known
>   if the IMU has successfully autocalibrated) and to calibration data blob.
>   The user can save this blob in a "firmware" file (i.e. in /lib/firmware)
>   that the driver looks for at probe time. If found, then the IMU is
>   initialized with this calibration data. This saves the user from
>   performing the calibration procedure every time (which consist of moving
>   the IMU in various way).
>
>   The driver looks for calibration data file using two different names:
>   first a file whose name is suffixed with the IMU unique ID is searched
>   for; this is useful when there is more than one IMU instance. If this
>   file is not found, then a "generic" calibration file is searched for
>   (which can be used when only one IMU is present, without struggling with
>   fancy names, that changes on each device).
>
>   In AMG mode the IIO 'offset' attributes provide access to the offsets
>   from calibration data (if any), so that the user can apply them to the
>   accel, angvel and magn IIO attributes. In fusion mode they are not needed
>   and read as zero.
>
>
> Access protocols and serdev module:
>
>   The serial protocol is quite simple, but there are tricks to make it
>   really works. Those tricks and workarounds are documented in the driver
>   source file.
>
>   The core BNO055 driver tries to group readings in burst when appropriate,
>   in order to optimize triggered buffer operation. The threshold for
>   splitting a burst (i.e. max number of unused bytes in the middle of a
>   burst that will be throw away) is provided to the core driver by the
>   lowlevel access driver (either serdev or I2C) at probe time.
>
> [0] https://www.spinics.net/lists/linux-iio/msg25508.html
>
> Andrea Merello (14):
>   iio: add modifiers for linear acceleration
>   iio: document linear acceleration modifiers
>   iio: event_monitor: add linear acceleration modifiers
>   iio: add modifers for pitch, yaw, roll
>   iio: document pitch, yaw, roll modifiers
>   iio: event_monitor: add pitch, yaw and roll modifiers
>   iio: add support for binary attributes
>   iio: imu: add Bosch Sensortec BNO055 core driver
>   iio: document bno055 private sysfs attributes
>   iio: document "serialnumber" sysfs attribute
>   dt-bindings: iio/imu: Add Bosch BNO055
>   iio: imu: add BNO055 serdev driver
>   iio: imu: add BNO055 I2C driver
>   docs: iio: add documentation for BNO055 driver
>
>  Documentation/ABI/testing/sysfs-bus-iio       |   25 +
>  .../ABI/testing/sysfs-bus-iio-bno055          |   81 +
>  .../bindings/iio/imu/bosch,bno055.yaml        |   59 +
>  Documentation/iio/bno055.rst                  |   50 +
>  Documentation/iio/index.rst                   |    2 +
>  drivers/iio/imu/Kconfig                       |    1 +
>  drivers/iio/imu/Makefile                      |    1 +
>  drivers/iio/imu/bno055/Kconfig                |   25 +
>  drivers/iio/imu/bno055/Makefile               |   10 +
>  drivers/iio/imu/bno055/bno055.c               | 1710 +++++++++++++++++
>  drivers/iio/imu/bno055/bno055.h               |   12 +
>  drivers/iio/imu/bno055/bno055_i2c.c           |   57 +
>  drivers/iio/imu/bno055/bno055_ser_core.c      |  560 ++++++
>  drivers/iio/imu/bno055/bno055_ser_trace.h     |  104 +
>  drivers/iio/industrialio-core.c               |   10 +-
>  include/uapi/linux/iio/types.h                |    7 +-
>  tools/iio/iio_event_monitor.c                 |    6 +
>  17 files changed, 2718 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
>  create mode 100644 Documentation/iio/bno055.rst
>  create mode 100644 drivers/iio/imu/bno055/Kconfig
>  create mode 100644 drivers/iio/imu/bno055/Makefile
>  create mode 100644 drivers/iio/imu/bno055/bno055.c
>  create mode 100644 drivers/iio/imu/bno055/bno055.h
>  create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
>  create mode 100644 drivers/iio/imu/bno055/bno055_ser_core.c
>  create mode 100644 drivers/iio/imu/bno055/bno055_ser_trace.h
>
> --
> 2.17.1



-- 
With Best Regards,
Andy Shevchenko
