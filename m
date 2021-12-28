Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA5480C57
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbhL1SGn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhL1SGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:06:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3011EC061574;
        Tue, 28 Dec 2021 10:06:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A63C0612FA;
        Tue, 28 Dec 2021 18:06:41 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 89844C36AE9;
        Tue, 28 Dec 2021 18:06:37 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:12:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 14/23] counter: Update documentation for new counter
 registration functions
Message-ID: <20211228181222.72ab998c@jic23-huawei>
In-Reply-To: <20211227094526.698714-15-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-15-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:17 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> In order to replace the counter registration API also update the
> documentation to the new way.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Fine either way, but a suggestion below.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/driver-api/generic-counter.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
> index 1b487a331467..991b180c7b47 100644
> --- a/Documentation/driver-api/generic-counter.rst
> +++ b/Documentation/driver-api/generic-counter.rst
> @@ -262,11 +262,11 @@ order to communicate with the device: to read and write various Signals
>  and Counts, and to set and get the "action mode" and "function mode" for
>  various Synapses and Counts respectively.
>  
> -A defined counter_device structure may be registered to the system by
> -passing it to the counter_register function, and unregistered by passing
> -it to the counter_unregister function. Similarly, the
> -devm_counter_register function may be used if device memory-managed
> -registration is desired.
> +A counter_device structure is supposed to be allocated using counter_alloc()
> +and may be registered to the system by passing it to the counter_add()
> +function, and unregistered by passing it to the counter_unregister function.

I'd avoid the supposed to and the odd vague use of structure in the origin
text and just go with

A struct counter_device is allocated using counter_alloc()...


> +There are device managed variants of these functions: devm_counter_alloc() and
> +devm_counter_add().
>  
>  The struct counter_comp structure is used to define counter extensions
>  for Signals, Synapses, and Counts.

