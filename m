Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9095788B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbiGRRo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiGRRoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:44:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BF05F61;
        Mon, 18 Jul 2022 10:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90F73CE1884;
        Mon, 18 Jul 2022 17:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61065C341CB;
        Mon, 18 Jul 2022 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658166251;
        bh=bvwgPiet+KbQqeWdNCXQUOY/LnQARZbnjVN0i6WvK0U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ATDYLREGyDY1p0LExzxuUBNAtzBS2ji87F0D7Jxl/sgTxwo5gaPcqcijf8ix4XJ6n
         jt9GMNvthc64DxonGMWbpTRSKSsOO1wXL6ZxDQS0BshuXii+dBTD6rpRcanC/EBGfN
         vIeqUB+PPjTCq9TDjAx57iRzpHe916eLG2yAUqzbn6wb/VmUkcH++70/eXdDkopnvk
         UHD4LChwJ0NPy0GxNn7WjeLldjX4m76DislFHV5TG9ppdwR2U5p0wxl2GdA2vjKsWC
         Z3eDvVCwpA8N/A6IJUJezxqkC7q2/2+f/ZHoN/J2gqgD4r1OTRbSZIRUOQsskL7zIL
         U8rlmISioDJng==
Date:   Mon, 18 Jul 2022 18:54:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     lars@metafoo.de, ardeleanalex@gmail.com, andy.shevchenko@gmail.com,
        antoniu.miclaus@analog.com, u.kleine-koenig@pengutronix.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: hmc5843: Remove duplicate 'the'
Message-ID: <20220718185406.793cc3b4@jic23-huawei>
In-Reply-To: <20220622035925.5008-1-jiangjian@cdjrlc.com>
References: <20220622035925.5008-1-jiangjian@cdjrlc.com>
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

On Wed, 22 Jun 2022 11:59:25 +0800
Jiang Jian <jiangjian@cdjrlc.com> wrote:

> Fix an obvious typing error, found by spellcheck(1).
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
Applied.  Thanks
> ---
>  drivers/iio/magnetometer/hmc5843_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
> index 92eb2d156ddb..4a63b2da9df0 100644
> --- a/drivers/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/iio/magnetometer/hmc5843_core.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Device driver for the the HMC5843 multi-chip module designed
> + * Device driver for the HMC5843 multi-chip module designed
>   * for low field magnetic sensing.
>   *
>   * Copyright (C) 2010 Texas Instruments

