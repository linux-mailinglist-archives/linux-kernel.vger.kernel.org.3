Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68304BC93E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 17:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242597AbiBSQBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 11:01:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242586AbiBSQBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 11:01:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CFD127D40;
        Sat, 19 Feb 2022 08:01:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51EBAB80B38;
        Sat, 19 Feb 2022 16:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B982C004E1;
        Sat, 19 Feb 2022 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645286478;
        bh=J0jsLfquOY4toaMPw5pNObo276r9OnBrFL7uKrC7EvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W7xRNR0qCcWVtY8IFX5h7mrVqaG6Cht3DnizKeR8u1UAsnxT4UUDgcr1OUDlSz4kU
         1IAdIMpNhFkSHBe+RtCOTbBVYqVgJSlR2FD948DlM/F2RZJfB0uI08Su0WggLF2Vbo
         QkfcMcgLY2VLqXTq3IpZGye80EKR35XGUq5f0/lrGK5TESxGA/F7pLHdpyBIpN63KB
         AQVS5WTrlb0z5VJszE6jJC/4iDVVpY8PGtV/Pq1sXzvcuYZ/6ftH83V9tAr5+b7Hz5
         W4PDShXF4CEwvUA31P17j6egFjwfTaTizSUrpn5SrFGNFOOj8upi+SM6jQ0LDQZyNE
         p6DlMWrPJ8pRQ==
Date:   Sat, 19 Feb 2022 16:08:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v3 02/13] iio: document linear acceleration modifiers
Message-ID: <20220219160805.59fa8176@jic23-huawei>
In-Reply-To: <20220217162710.33615-3-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
        <20220217162710.33615-3-andrea.merello@gmail.com>
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

On Thu, 17 Feb 2022 17:26:59 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> This patch introduces ABI documentation for new iio modifiers used for
> reporting "linear acceleration" measures.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index c551301b33f1..b2fb4d9abcd1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -233,6 +233,15 @@ Description:
>  		Has all of the equivalent parameters as per voltageY. Units
>  		after application of scale and offset are m/s^2.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_x_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_y_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_z_raw
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		As per in_accel_X_raw attributes, but minus the gravity
> +		acceleration.

As it looks like you are going to be doing a v4 given the stuff 0-day found
I'd prefer this as "minus the acceleration due to gravity" which from what
I recall tends to be what it is called in physics text books etc.

> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_x_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_y_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_z_raw

