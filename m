Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86550503735
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 16:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiDPO5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 10:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiDPO46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 10:56:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7CF65D7;
        Sat, 16 Apr 2022 07:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0C0B60F54;
        Sat, 16 Apr 2022 14:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A79C385A3;
        Sat, 16 Apr 2022 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650120865;
        bh=Kfk0kOIGY6+UE7statVAbsazZExO99gSHyvkgaaYaE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C6FM+SFLqI1f6phrqG6fizT9LvlYzD9RpX8fODD7AIlcNSnJsP2RelBM3kT40NvXk
         MZDBZOTU6Hq3pHsHMeRwLY6MMbcj9FQH1bg9k48fXvI3W5eFwMBWjcUCZf5WdrR3P1
         EZhrNG97K8LWBJuVdFggSmiyURbYp6UqeXsUmTLbp4GaFUzgt5A8wi+qPTMVQ8E26f
         qJTMC5LjYLGhjORKttDkJd6X/qk6QeUXrIbB6LZklE/CqX+3kXuH88WFbEwnR4FKbP
         zF8AyvIF6ws2R2Pd8rwKLh39e6HkcSk2MyLCQR0grY5R4FCrrglMDAIDI+WqsWYgQ4
         JwfVzXviH62OQ==
Date:   Sat, 16 Apr 2022 16:02:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v1 2/3] iio: ABI: adc: ad4130: document
 filter_mode{,_available}
Message-ID: <20220416160222.23e1a6db@jic23-huawei>
In-Reply-To: <20220413094011.185269-2-cosmin.tanislav@analog.com>
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
        <20220413094011.185269-2-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 12:40:10 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> AD4130-8 is an ultra-low power, high precision,
> measurement solution for low bandwidth battery
> operated applications.
> 
> The fully integrated AFE (Analog Front-End)
> includes a multiplexer for up to 16 single-ended
> or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip
> reference and oscillator, selectable filter
> options, smart sequencer, sensor biasing and
> excitation options, diagnostics, and a FIFO
> buffer.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> new file mode 100644
> index 000000000000..942150991e75
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> @@ -0,0 +1,36 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
> +KernelVersion:

Make a guess at the kernel version (hopefully this cycle!)
We never remember to fill these in later so better to have it slightly wrong
than not present at all.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a list with the possible filter modes.
> +		"sinc4"       - Sinc 4. Excellent noise performance. Long 1st
> +				conversion time. No natural 50/60Hz rejection.
> +		"sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion time.
> +		"sinc3"	      - Sinc3. Moderate 1st conversion time. Good noise
> +				performance.
> +		"sinc3+rej60" - Sinc3 + 60Hz rejection. At a sampling frequency
> +				of 50Hz, achieves simultaneous 50Hz and 60Hz
> +				rejection.
> +		"sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion time.
> +				Best used with a sampling frequency of at least
> +				216.19Hz.
> +		"sinc3+pf1"   - Sinc3 + Post Filter 1.
> +				53dB rejection @ 50Hz, 58dB rejection @ 60Hz.
> +		"sinc3+pf2"   - Sinc3 + Post Filter 2.
> +				70dB rejection @ 50Hz, 70dB rejection @ 60Hz.
> +		"sinc3+pf3"   - Sinc3 + Post Filter 3.
> +				99dB rejection @ 50Hz, 103dB rejection @ 60Hz.
> +		"sinc3+pf4"   - Sinc3 + Post Filter 4.
> +				103dB rejection @ 50Hz, 109dB rejection @ 60Hz.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Set the filter mode of the differential channel. When the filter
> +		mode changes, the in_voltageY-voltageZ_sampling_frequency and
> +		in_voltageY-voltageZ_sampling_frequency_available attributes
> +		might also change to accomodate the new filter mode.
> +		If the current sampling frequency is out of range for the new
> +		filter mode, the sampling frequency will be changed to the
> +		closest valid one.

