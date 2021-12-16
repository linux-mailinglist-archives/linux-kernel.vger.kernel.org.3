Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6988477A49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbhLPRQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhLPRQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:16:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53697C061574;
        Thu, 16 Dec 2021 09:16:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43D2FB82365;
        Thu, 16 Dec 2021 17:16:07 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 0D07EC36AE0;
        Thu, 16 Dec 2021 17:16:03 +0000 (UTC)
Date:   Thu, 16 Dec 2021 17:21:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] iio:filter:admv8818: Add sysfs ABI documentation
Message-ID: <20211216172127.74371d2e@jic23-huawei>
In-Reply-To: <20211207155445.247444-4-antoniu.miclaus@analog.com>
References: <20211207155445.247444-1-antoniu.miclaus@analog.com>
        <20211207155445.247444-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 17:54:45 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add initial ABI documentation for admv8818 filter sysfs interfaces.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu

Please make sure to include change logs for all the patches - or a summary in
a cover letter is also fine.
> ---

I made an unclear comment in v2 review.
What I meant to request for the 3db_frequency was that you added a
line to the main sysfs-bus-iio documentation in the 3db_frequency block to
cover it's use with out_altvoltageX_filter_high_base_3db_frequency


>  .../ABI/testing/sysfs-bus-iio-filter-admv8818    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818 b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> new file mode 100644
> index 000000000000..f6c035752639
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> @@ -0,0 +1,16 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/filter_mode_available
> +KernelVersion:

As per other review, please fill these in.  I'll never remember to do it whilst
applying so just take a guess and update if we cross into the next cycle during review.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading this returns the valid values that can be written to the
> +		on_altvoltage0_mode attribute:
> +
> +		- auto -> Adjust bandpass filter to track changes in input clock rate.
> +		- manual -> disable/unregister the clock rate notifier / input clock tracking.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/filter_mode
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute configures the filter mode.
> +		Reading returns the actual mode.

