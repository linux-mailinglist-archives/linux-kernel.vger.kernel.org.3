Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5159F4BC968
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 17:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbiBSQpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 11:45:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242704AbiBSQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 11:45:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052F55F4EE;
        Sat, 19 Feb 2022 08:45:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 973FA60BA8;
        Sat, 19 Feb 2022 16:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D972EC004E1;
        Sat, 19 Feb 2022 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645289127;
        bh=+17mVetXReBFkiqb808QaM5pwG49fehWe7y9EWaB+Po=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AH1RWJpdbFv8x08o6D0JJ98Hovj0oWTLt2Cd+PsFG+Vv3xjgNDtKIHjBD2sXiN2cY
         YLLpSkqAxWjyazESWDeR13BPRRFX5pU/c7sWG+ayqBCA65P2mgZujo/Gaf0Ese0/aZ
         FLPpy9YhKtwl9z/HkNF+cvPwji6iBjkcXyswdAjQpsTei7gPziG9M9Wng9DzoLmqNT
         ts9jc6GXyAMDqHdXd36KePicbao2WEkKZPa1D1q9yl/7aXnYOmiciwNmutQnza3FOC
         /Posj0hi8AQFex2IeKTtTveyK25eYGy5RKAlLW0t15W2lVvDZTysCFELE8Ybz2jyTL
         ejuCcoHM4qtcw==
Date:   Sat, 19 Feb 2022 16:52:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v3 09/13] iio: document "serial_number" sysfs attribute
Message-ID: <20220219165214.25804a3f@jic23-huawei>
In-Reply-To: <20220217162710.33615-10-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
        <20220217162710.33615-10-andrea.merello@gmail.com>
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

On Thu, 17 Feb 2022 17:27:06 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> This patch adds ABI documentation for the new "serial_number" sysfs
> attribute. The first user is the bno055 IIO driver.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 1b8d77577608..224585f00147 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2017,3 +2017,10 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw (unscaled) euler angles readings. Units after
>  		application of scale are deg.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/serial_number
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		16-bytes, 2-digits-per-byte, HEX-string representing the sensor
> +		unique ID number.
This might prove too restrictive for other devices but I guess we can update
the help text when they come along.  Maybe relax this to

An example format is 16-bytes, 2-digits-per-byte ....

then we avoid having to update it later when a different format comes along.
