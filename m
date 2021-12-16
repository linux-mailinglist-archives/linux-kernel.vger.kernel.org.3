Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105F7477187
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhLPMT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhLPMT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:19:26 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7F9C061574;
        Thu, 16 Dec 2021 04:19:25 -0800 (PST)
Received: from [81.101.6.87] (port=48022 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxpj6-0007Lc-O0; Thu, 16 Dec 2021 12:19:17 +0000
Date:   Thu, 16 Dec 2021 12:24:28 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606: Fix syntax errors in comments
Message-ID: <20211216122416.5547c401@jic23-huawei>
In-Reply-To: <20211212144118.16904-1-wangxiang@cdjrlc.com>
References: <20211212144118.16904-1-wangxiang@cdjrlc.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021 22:41:18 +0800
Xiang wangx <wangxiang@cdjrlc.com> wrote:

> Delete the redundant word 'the'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7606.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 9350ef1f63b5..4f82d7c9acfd 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -62,7 +62,7 @@ struct ad7606_chip_info {
>   * struct ad7606_state - driver instance specific data
>   * @dev		pointer to kernel device
>   * @chip_info		entry in the table of chips that describes this device
> - * @reg		regulator info for the the power supply of the device
> + * @reg		regulator info for the power supply of the device
>   * @bops		bus operations (SPI or parallel)
>   * @range		voltage range selection, selects which scale to apply
>   * @oversampling	oversampling selection

