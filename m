Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB705787E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiGRQy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiGRQyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:54:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69CE1056A;
        Mon, 18 Jul 2022 09:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3852ACE178E;
        Mon, 18 Jul 2022 16:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755B0C341CB;
        Mon, 18 Jul 2022 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658163286;
        bh=yBBYa1xZZmd/FW0Ok5m8qrhARtPq1Z+pUX8jaMNgznM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tVoSsV1sti1rOnXxYnTHWdjcpFuV0S6VX/0LX2zyv2vexiVBINSAbDztE/ZHUhV7a
         WXveOAFvZWGUtBCE3GuR/otLhVM3ZSMvMVIG6xUhSCwtrakpOcOZvrd6NS3wVYerNJ
         X/YaG8rkUNQPlUvzN5yu7NJhPSY7/Zm9qdzMvNN5F+9OuyUDG1S8+Ymu5nGBx/qqZB
         noz3wnLoPSJTB5lbIpUCG2mPwcEk7Q/pJ1+T2Kif5ger9Eoi+hVR5lee3JitPh4rDb
         rr6jj7LocOV5BRjOkHwYyBkrxAsiUAZ5cRQ0seJ0C/fbUzqWw9ZXq5pa4QQSKb3N0b
         iSSXPCn6z86Dg==
Date:   Mon, 18 Jul 2022 18:04:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/3] Documentation: ABI: testing: rtq6056: Update ABI
 docs
Message-ID: <20220718180441.1363d2a6@jic23-huawei>
In-Reply-To: <1658123163-10039-4-git-send-email-u0084500@gmail.com>
References: <1658123163-10039-1-git-send-email-u0084500@gmail.com>
        <1658123163-10039-4-git-send-email-u0084500@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 13:46:03 +0800
cy_huang <u0084500@gmail.com> wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add documentation for the usage of voltage channel integration time.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d4ccc68..1f7d327 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2030,3 +2030,13 @@ Description:
>  		Available range for the forced calibration value, expressed as:
>  
>  		- a range specified as "[min step max]"
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_integration_time
> +KernelVersion:	5.20
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For voltage sensing hardware, there may be different time between
> +		channel conversion and sample update. 'Integration time' is used to
> +		specify the channel internal conversion time. And sample update
> +		interval is equal to average sample count multiple integration time.
> +		Unit as microsecond.

Whilst I did suggest moving this to this file, I also suggested that it was the
wrong interface to use.  For similar cases we've used in_voltageY_sampling_frequency
in the past because this isn't really an integration time, but rather a reflection of
a bunch of other stuff that makes up the conversion time.  In IIO we chose a long
time ago to use 1/conversion_time as the exposed interface == sampling_frequency

So, unless there is a strong reason to do otherwise, drop the overall sampling_frequency
attribute and use per channel ones instead.  Then update the main documentation
to make this usecase clear. Something in the block
https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing/sysfs-bus-iio#L89
like adding the in_voltageY_sampling_frequency entry to the What: list and a
sentence at the end that says something like:

"Some devices have separate controls of sampling frequency for individual channels.
If multiple channels are enabled in a scan, then the sampling_frequency of the the
scan may be computed from the per channel sampling_frequencies."

Not something to put in the documentation, but for devices which do simultaneous sampling
it is very unlikely we'll have per channel sampling frequencies so there isn't an
ambiguity. The alternative we 'could' consider is to allow both overall sampling_frequency
and per channel in_voltageY_sampling_frequency but that is a bad idea because the
ABI (and most userspace software) assumes that more specific attributes override the
values of more generic ones (rather than them having different meanings as would be
the case here).

Jonathan
