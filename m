Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F944DD067
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiCQVxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiCQVxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:53:50 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931ACC1C9E;
        Thu, 17 Mar 2022 14:52:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so6703502pjp.3;
        Thu, 17 Mar 2022 14:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qOOf30r9/4TaeZHAf5kMJAI7mc+jJ+v3QlvH4So96Aw=;
        b=fBYmuBClLccjikMDO82WBoVKSkm1VQvoY1yFiUuaj60H2R9trDVNiJ9HxUg/LunD/3
         kibOwegSu1VRO46WulzAZl+GE1j1yGB347qUh9oh3WKAJLyH+j/RXnMntswls/etNfHt
         IH2LZpTsRwhNYnCumpCzrm88HdSdS4Q4sDdf61QCAraYhELVCnuQFXz5F1mUW4iFF5eK
         64dUSel6Y9FwPbaGvpOxuhG94Nc2e1hJ5vY1aTkcvLjKmJACpk03yb9/3UTZp1d9U8vq
         qCKIBbLZ/IzwW1Zd/GppWdcmdK/qR9gcsa3IBr6uDuvdq0JtD03M5EEkw3PNmAkj4fhT
         g5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qOOf30r9/4TaeZHAf5kMJAI7mc+jJ+v3QlvH4So96Aw=;
        b=KLg1G8590dfmBTAziRpb/RltWfiLWGbiNyLXIx/6pTwKpilzY3uaI0QCNOTp5kxof5
         AiQfgD7Y+z31j9ZH+PzBYAzmDUR7MiIL04iN2rm/n1BbTSta5bwM4XDjEx3d+p0LTW4j
         ftVuTLb4g+MQGQWN1dllzIhPhYRDIQchU/5Sb9mS9Aqd8LSzt59/Wc9QnaL9nV8FzbbJ
         EYP5naZwlOLYx4PMuXXjRyb0uXxGNJX+hWP1ISS6I+y+xUp6d5ZMxL0x0NL+l4/FBXHw
         NdNTlj4GJlskiFguFXp3Hcy3IgMLhgc0iPRXIRcr+BlNa0IgF1ok/C0m5phUsyhJI3ts
         /5NA==
X-Gm-Message-State: AOAM532kOicDLZV60nJrqJ4NRkDrBELaNs72Z27m4wItCjTwGIj+tQL1
        lOoUB2FlOJC0rErJc6BJS3sniRtxWYMK6/zJ
X-Google-Smtp-Source: ABdhPJy8CdaIVHmWs6oUGVtFWX/BNZvLwwCHydSaLh/rVDfRNjAiO/Nzndo931iE0UzeKxOgXNKi4Q==
X-Received: by 2002:a17:90a:1d05:b0:1bf:6a85:fbf5 with SMTP id c5-20020a17090a1d0500b001bf6a85fbf5mr7717552pjd.205.1647553951836;
        Thu, 17 Mar 2022 14:52:31 -0700 (PDT)
Received: from jagath-PC ([115.99.139.148])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm6691312pfv.123.2022.03.17.14.52.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Mar 2022 14:52:31 -0700 (PDT)
Date:   Fri, 18 Mar 2022 03:22:27 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        dan@dlrobertson.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] iio: accel: bma400: patches for todos
Message-ID: <20220317215227.GB1934@jagath-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

To continue the contribution I chose the bma400 accelerometer device driver,
there are multiple todos, so thought of adding support for the same.
Currently, I am able to get the trigger buffer with data ready interrupt,
step counter and event for step change with bma400 accelero breakout board.

Below are the changes I have implemented for the bma400 driver in separate
patches

1. Conversion to device-managed function and remove the bma400_remove()
function.
2. Added trigger buffer support with data ready interrupt.
3. Added a separate channel for the step counter.
4. Added event support for step change.

Can I send the above patches for review?
Sorry for all the mistakes that I have made in the previous ds1803 patch
series and I will make sure to avoid all those mistakes.

In the bma400 driver, I am stuck on one point and your advice will be very
helpful.

https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio 
From IIO documentation for accelerometer device the calculation for
final value from the sysfs attributes of the accelerometer device for
the Z-axis will be
(in_accel_z_raw + in_accel_z_offset) * in_accel_scale = 9.8 m/s2 approximately.

In the mainline kernel bma400 device driver, there are multiple-scale
values for different acceleration ranges +-2g, +-4g, etc.

root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
cat in_accel_scale_available
0.038357 0.076714 0.153428 0.306856

With +-4g range
root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
cat in_accel_scale
0.076714
root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
cat in_accel_z_raw
519
root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
echo "0.076714 * 506" | bc
39.277568

With +- 2g range
root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
echo 0.038357 > in_accel_scale
root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
cat in_accel_scale
0.038357
root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
cat in_accel_z_raw
1012
root@raspberrypi:/sys/devices/platform/soc/3f804000.i2c/i2c-1/1-0014/iio:device0#
echo "0.038357 * 1012" | bc
38.817284

The _raw value from the sensor is as per the datasheet but the final value for the
Z axis after applying scale for all ranges is around 38.8 which is not expected.
I tried by placing the sensor in a different position where the X-axis value should
be approximately 9.8 m/s2 but In this case also the value is around 38.8 m/s2

Is the above method to calculate the acceleration in the Z-axis correct or
am I missing something?

For confirmation I also tested the mpu6050 IMU.

root@raspberrypi:/sys/bus/iio/devices/iio:device1# cat in_accel_scale_available
0.000598 0.001196 0.002392 0.004785
root@raspberrypi:/sys/bus/iio/devices/iio:device1# cat in_accel_scale
0.000598
root@raspberrypi:/sys/bus/iio/devices/iio:device1# cat in_accel_z_raw
16706
root@raspberrypi:/sys/bus/iio/devices/iio:device1# echo "0.000598 * 16706" | bc
9.9801
With MPU6050 I am getting 9.9801 m/s2 which is near to earth's acceleration due
to gravity 9.8 m/s2

For BMA400 I recalculated the scale values from sensitivity for different
acceleration ranges
https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bma400-ds000.pdf

For +-2g - 1 LSB = 0.0095768 m/s2
For +-4g - 1 LSB = 0.0191536 m/s2
For +-4g - 1 LSB = 0.0383072 m/s2
Is the above method to calculate the scale values correct or am I missing
something?

Thank you
Jagath

