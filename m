Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FCB4BC964
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 17:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbiBSQni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 11:43:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242543AbiBSQnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 11:43:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F2C5F4DD;
        Sat, 19 Feb 2022 08:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5861EB80BED;
        Sat, 19 Feb 2022 16:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C263AC004E1;
        Sat, 19 Feb 2022 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645288994;
        bh=x1ObFa22r+G7aTZvTwhEyDEIDeww+LwIpzPKuw1LyPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uqfIRnpWWRakLe2XH/OLhBdoLGh7/lGf/0sotfyZJDWQMEuzQZ+j6X5YQ3v6Kvvg8
         KWPm5751JGvewv8FqS32hbXhytPm8rxzjywEpXIEBJIBBpo3L/56sTI+WTqGeUIVin
         hYODzIu5uWBCWXqY9qALUo64DYQYMai4GX0zfThymKHXnEEbnddQ1dyqaV6P1utlE/
         7TNOgM0di8y6IE04fMo8KywjYlEY02pk52CS4edz0KOznY7aE6s1hM8HrwenDvgIDi
         j2nRi/+XqSXupHSNIA6Hh5qMnjc1Mg5pvWgFEu1Nt4Zx46O0/Lzhj88+2ra1W7c7oM
         GUxtLicA3Eq5g==
Date:   Sat, 19 Feb 2022 16:50:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v3 08/13] iio: document bno055 private sysfs attributes
Message-ID: <20220219165000.56877005@jic23-huawei>
In-Reply-To: <20220217162710.33615-9-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
        <20220217162710.33615-9-andrea.merello@gmail.com>
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

On Thu, 17 Feb 2022 17:27:05 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> This patch adds ABI documentation for bno055 driver private sysfs
> attributes.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>  .../ABI/testing/sysfs-bus-iio-bno055          | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-bno055 b/Documentation/ABI/testing/sysfs-bus-iio-bno055
> new file mode 100644
> index 000000000000..c239276f2b0f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-bno055
> @@ -0,0 +1,81 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_raw_range
> +KernelVersion:	5.17

Update this to 5.18 as hopefully we'll resolve remaining questions in
time to make the merge window.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Range for acceleration readings in m/s^2. 

If it is in m/s^2 then we need to not call it _raw_ as that implies application
of offset and scale.  I didn't think this through in earlier discussion...

If it's in m/s^2 then in_accel_input_range would be appropriate.
Same for the other similar cases that follow.

> Note that this does
> +		not affects the scale (which should be used when changing the
> +		maximum and minimum readable value affects also the reading
> +		scaling factor).
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_raw_range
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Range for angular velocity readings in radians per second. Note
> +		that this does not affects the scale (which should be used when
> +		changing the maximum and minimum readable value affects also the
> +		reading scaling factor).
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_raw_range_available
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of allowed values for in_accel_raw_range attribute
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_raw_range_available
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of allowed values for in_anglvel_raw_range attribute
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_magn_calibration_fast_enable
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Can be 1 or 0. Enables/disables the "Fast Magnetometer
> +		Calibration" HW function.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/fusion_enable
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Can be 1 or 0. Enables/disables the "sensor fusion" (a.k.a.
> +		NDOF) HW function.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/calibration_data
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reports the binary calibration data blob for the IMU sensors.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibration_auto_status
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reports the autocalibration status for the accelerometer sensor.
> +		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
> +		the number, the better the calibration status.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_calibration_auto_status
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reports the autocalibration status for the gyroscope sensor.
> +		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
> +		the number, the better the calibration status.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_magn_calibration_auto_status
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reports the autocalibration status for the magnetometer sensor.
> +		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
> +		the number, the better the calibration status.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/sys_calibration_auto_status
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reports the status for the IMU overall autocalibration.
> +		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
> +		the number, the better the calibration status.

