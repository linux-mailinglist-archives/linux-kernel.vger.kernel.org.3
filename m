Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE32D4BC972
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 18:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242580AbiBSRAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 12:00:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbiBSRAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 12:00:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE2E66634;
        Sat, 19 Feb 2022 08:59:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F9E060B89;
        Sat, 19 Feb 2022 16:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279F8C004E1;
        Sat, 19 Feb 2022 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645289997;
        bh=34JCMX2vd9mdkBrisLNaRHxb0jWBq7aU4Xf9pF6nGWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HyiMhNHwoj5fwEutPf0JbsfqmfAAPZv9S8x95toNVz/34taVbEAXA3PehywARUD5V
         b5DNTblk4yqMXrdoM2Gtw1gc9Qz0EVHIp/FEAe08d51MP5phPqRQvkqw10sC+ETB8m
         IBikkxMRPw4dhLdxSP0ose/vYLr5rLjZs5xGgsag/4ex5bsK03woG1KbeWPwLixHSC
         hagNwuZ+rNzq9+ZeJZ8ZdfvHOXcEf2mefmyFcqRCpxJbo7pxJKQO+ZD80dRlWeBjZs
         kgtIkoiqpNoiLlUZjPfVBUJsgly326Ry7VfipQwJ3HiS7LHyzWN9wonBDfR0MGMk/d
         thcclbC8uDHiQ==
Date:   Sat, 19 Feb 2022 17:06:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v3 13/13] docs: iio: add documentation for BNO055 driver
Message-ID: <20220219170645.565afed8@jic23-huawei>
In-Reply-To: <20220217162710.33615-14-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
        <20220217162710.33615-14-andrea.merello@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 17:27:10 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

Perhaps a comment on why it's worth having documentation for this device
when we rarely bother?  (complex device etc...)

> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>  Documentation/iio/bno055.rst | 53 ++++++++++++++++++++++++++++++++++++

Please add it to an appropriate index such as Docuemntation/iio/index.rst
so that it actually gets linked to in the documentation built.

One comment inline.

>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/iio/bno055.rst
> 
> diff --git a/Documentation/iio/bno055.rst b/Documentation/iio/bno055.rst
> new file mode 100644
> index 000000000000..4bb185075325
> --- /dev/null
> +++ b/Documentation/iio/bno055.rst
> @@ -0,0 +1,53 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +==============================
> +BNO055 driver
> +==============================
> +
> +1. Overview
> +===========
> +
> +This driver supports Bosch BNO055 IMUs (on both serial and I2C busses).
> +
> +Accelerometer, magnetometer and gyroscope measures are always provided.
> +When "fusion_enable" sysfs attribute is set to 1, orientation (both Euler
> +angles and quaternion), linear velocity and gravity vector are also
> +provided, but some sensor settings (e.g. low pass filtering and range)
> +became locked (the IMU firmware controls them).
> +
> +IIO attributes for unavailable measurements (e.g. Euler angles when fusion
> +mode is disabled) just read zero.

Hmm. Should probably return -EBUSY as 0 could be a valid value.

> +
> +This driver supports also IIO buffers.
> +
> +2. Calibration
> +==============
> +
> +The IMU continuously performs an autocalibration procedure if (and only if)
> +operating in fusion mode. The magnetometer autocalibration can however be
> +disabled writing 0 in the sysfs in_magn_calibration_fast_enable attribute.
> +
> +The driver provides access to autocalibration flags (i.e. you can known if
> +the IMU has successfully autocalibrated) and to the calibration data blob.
> +
> +The user can save this blob in a firmware file (i.e. in /lib/firmware) that
> +the driver looks for at probe time. If found, then the IMU is initialized
> +with this calibration data. This saves the user from performing the
> +calibration procedure every time (which consist of moving the IMU in
> +various way).
> +
> +The driver looks for calibration data file using two different names: first
> +a file whose name is suffixed with the IMU unique ID (exposed in sysfs as
> +serial_number) is searched for; this is useful when there is more than one
> +IMU instance. If this file is not found, then a "generic" calibration file
> +is searched for (which can be used when only one IMU is present, without
> +struggling with fancy names, that change on each device).
> +
> +Valid calibration file names would be e.g.
> + bno055-caldata-0e7c26a33541515120204a35342b04ff.dat
> + bno055-caldata.dat
> +
> +In non-fusion mode the IIO 'offset' attributes provide access to the
> +offsets from calibration data (if any), so that the user can apply them to
> +the accel, angvel and magn IIO attributes. In fusion mode they are not
> +needed (the IMU firmware internally applies those corrections) and they
> +read as zero.

