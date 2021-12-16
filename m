Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DE24771C9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbhLPM0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbhLPM03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:26:29 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99214C06173E;
        Thu, 16 Dec 2021 04:26:29 -0800 (PST)
Received: from [81.101.6.87] (port=48024 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxpq1-0008SQ-E3; Thu, 16 Dec 2021 12:26:25 +0000
Date:   Thu, 16 Dec 2021 12:31:36 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     cgel.zte@gmail.com
Cc:     lars@metafoo.de, chi.minghao@zte.com.cn, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH iio-next] drivers/iio: remove redundant ret variable
Message-ID: <20211216123128.54c51264@jic23-huawei>
In-Reply-To: <20211215060710.442163-1-chi.minghao@zte.com.cn>
References: <20211215060710.442163-1-chi.minghao@zte.com.cn>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 06:07:10 +0000
cgel.zte@gmail.com wrote:

> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from ads8688_prog_write() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

applied,

Thanks,

> ---
>  drivers/iio/adc/ti-ads8688.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
> index 79c803537dc4..2e24717d7f55 100644
> --- a/drivers/iio/adc/ti-ads8688.c
> +++ b/drivers/iio/adc/ti-ads8688.c
> @@ -281,12 +281,10 @@ static int ads8688_write_reg_range(struct iio_dev *indio_dev,
>  				   enum ads8688_range range)
>  {
>  	unsigned int tmp;
> -	int ret;
>  
>  	tmp = ADS8688_PROG_REG_RANGE_CH(chan->channel);
> -	ret = ads8688_prog_write(indio_dev, tmp, range);
>  
> -	return ret;
> +	return ads8688_prog_write(indio_dev, tmp, range);
>  }
>  
>  static int ads8688_write_raw(struct iio_dev *indio_dev,

