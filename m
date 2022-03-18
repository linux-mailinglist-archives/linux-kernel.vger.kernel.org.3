Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842CD4DD3B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiCRDtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiCRDs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:48:59 -0400
X-Greylist: delayed 911 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 20:47:41 PDT
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E3019751E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1647574332; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=elggAf41HvUrWWN3scF9gUzAIWcf9dFqq8c+zWxcBCogwFV/Cf8H2I4NmSEeUUgPem6CCqs9yS/3IW83xL+T8qDLBZMbSY1d5F1SVme6n5hkhr/yy7HnE8bMiOVEiXp7H8WUiaOZGlgI9tvLCK38BfGRSo0SZC8bx7QSJuV6t6Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1647574332; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0eZ+4T6crTbJHWrS/WB+dfvsVCgffBHeCpqttMifoTA=; 
        b=UtrXSyZh99gxgNHK2gghEWI+u1GcEWtiTvv14xHpaCo6zj1Al5qHB80Myg5iIiTetE43mRm5MFqzmL7QM4uNFzhLPDBinrjBqbWQWT7cJ+6ju2roShqiJtk99jORnpgTAd/KwFMCneJX44VpjzdiGfLAyLkig/nGYRyuIflIEkA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1647574332;
        s=zoho; d=dlrobertson.com; i=dan@dlrobertson.com;
        h=Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=0eZ+4T6crTbJHWrS/WB+dfvsVCgffBHeCpqttMifoTA=;
        b=Z6G5KjZY9nSVkyqm+9jjFHk09VxeVqU0/jM2bfTF1xNSFd86QgaZfgC51L59B+yn
        m4lql1Sjy23nV/7OhanbYS6oMNvX8ZQJptMjnEY9KyZvdETwJP8H5Br+N2TccUWx4+J
        cZbtcQ6hbMEnhBm/zg6DdaTJycHGNdPiAvZJF1CQ=
Received: from dlrobertson.com (pool-108-28-30-11.washdc.fios.verizon.net [108.28.30.11]) by mx.zohomail.com
        with SMTPS id 1647574328046413.1315427305391; Thu, 17 Mar 2022 20:32:08 -0700 (PDT)
Date:   Thu, 17 Mar 2022 23:32:06 -0400
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] iio: accel: bma400: patches for todos
Message-ID: <YjP9NttLHJpXdrZ1@dlrobertson.com>
References: <20220317215227.GB1934@jagath-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317215227.GB1934@jagath-PC>
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 03:22:27AM +0530, Jagath Jog J wrote:
> Hello,
>
> To continue the contribution I chose the bma400 accelerometer device driver,
> there are multiple todos, so thought of adding support for the same.
> Currently, I am able to get the trigger buffer with data ready interrupt,
> step counter and event for step change with bma400 accelero breakout board.

This is awesome! Thanks so much for checking out the driver. I enjoyed
writing it. It seems like quite a capable device with lots of features I've
yet to implement, and I had far less time free for development on the device
than I had hoped. Any help would be _greatly_ appreciated.

> Below are the changes I have implemented for the bma400 driver in separate
> patches
>
> 1. Conversion to device-managed function and remove the bma400_remove()
> function.
> 2. Added trigger buffer support with data ready interrupt.
> 3. Added a separate channel for the step counter.
> 4. Added event support for step change.
> Can I send the above patches for review?

I used the driver for this device as a way to learn, so I by no means claim to
be an expert, but I'll do my best to review and test patches sent. At a bare
minimum I can be a shoulder to cry on and fellow to commiserate with :-)

> Sorry for all the mistakes that I have made in the previous ds1803 patch
> series and I will make sure to avoid all those mistakes.
>
> In the bma400 driver, I am stuck on one point and your advice will be very
> helpful.
>
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio
> From IIO documentation for accelerometer device the calculation for
> final value from the sysfs attributes of the accelerometer device for
> the Z-axis will be
> (in_accel_z_raw + in_accel_z_offset) * in_accel_scale = 9.8 m/s2 approximately.
>
> In the mainline kernel bma400 device driver, there are multiple-scale
> values for different acceleration ranges +-2g, +-4g, etc.
>
> root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
> cat in_accel_scale_available
> 0.038357 0.076714 0.153428 0.306856
>
> With +-4g range
> root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
> cat in_accel_scale
> 0.076714
> root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
> cat in_accel_z_raw
> 519
> root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
> echo "0.076714 * 506" | bc
> 39.277568
>
> With +- 2g range
> root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
> echo 0.038357 > in_accel_scale
> root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
> cat in_accel_scale
> 0.038357
> root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
> cat in_accel_z_raw
> 1012
> root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
> echo "0.038357 * 1012" | bc
> 38.817284
>
> The _raw value from the sensor is as per the datasheet but the final value for the
> Z axis after applying scale for all ranges is around 38.8 which is not expected.
> I tried by placing the sensor in a different position where the X-axis value should
> be approximately 9.8 m/s2 but In this case also the value is around 38.8 m/s2
>
> Is the above method to calculate the acceleration in the Z-axis correct or
> am I missing something?

Based on your tests, a review of the code, and a re-read of the datasheet, I
definitely calculated the BMA400_SCALE_MIN and BMA400_SCALE_MAX incorrectly.

> For confirmation I also tested the mpu6050 IMU.
>
> root@raspberrypi:/sys/bus/iio/devices/iio:device1# cat in_accel_scale_available
> 0.000598 0.001196 0.002392 0.004785
> root@raspberrypi:/sys/bus/iio/devices/iio:device1# cat in_accel_scale
> 0.000598
> root@raspberrypi:/sys/bus/iio/devices/iio:device1# cat in_accel_z_raw
> 16706
> root@raspberrypi:/sys/bus/iio/devices/iio:device1# echo "0.000598 * 16706" | bc
> 9.9801
> With MPU6050 I am getting 9.9801 m/s2 which is near to earth's acceleration due
> to gravity 9.8 m/s2
>
> For BMA400 I recalculated the scale values from sensitivity for different
> acceleration ranges
> https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bma400-ds000.pdf
>
> For +-2g - 1 LSB = 0.0095768 m/s2
> For +-4g - 1 LSB = 0.0191536 m/s2
> For +-4g - 1 LSB = 0.0383072 m/s2

Assuming you mean 8g for the last one here.

> Is the above method to calculate the scale values correct or am I missing
> something?

Yeah, the scale is definitely off currently.

I think we need to change the following, if I'm reading the datasheet correctly.

 - BMA400_SCALE_MIN to 9582
 - BMA400_SCALE_MAX to 76659

Great catch and thanks for working on the device!

> Thank you
> Jagath

Cheers,

 - Dan
