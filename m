Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6487F58B6B1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiHFQIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHFQIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:08:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87B8B859;
        Sat,  6 Aug 2022 09:08:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D5A0B80025;
        Sat,  6 Aug 2022 16:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DC0C433C1;
        Sat,  6 Aug 2022 16:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659802099;
        bh=KaJNt0cSkuFB1ok87jDtHilImyzswYx2bxlCgHo8OH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DRY3+KPC2nfOyD/L7FJeV/UyzlkwTjQbSOZsPNe0kn8ZSmwKXphJTRY7JKLrQ7uUU
         EDJ0iYxIVFj6LDaj0m4FAcsDz/8PZ2Sm6vkwus6L6/A3geggsWd/Xc/BAzSsIvxTJV
         5ojxOlSBae2SYp2Rbr355DIUUJYf/HlCH7FlJapHt+xp3CuQ1Sfjmmon2ASSKZpK47
         7TmBrNvfvDx/Mr2fSOBQglBJwlkKw24Ugb0QOIK9p0ApKiT05KBeXs3pqH4/NdC/VK
         4aAY4xCYLVFxFXq3SxUkknx34NhwPQ9YRP9AsPJzbWxQZ6FAqnjlRGSPZNiVGmSWX5
         93b5EA5Ugywaw==
Date:   Sat, 6 Aug 2022 17:18:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Simmons-Talbott <joetalbott@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Add names for function definition arguments.
Message-ID: <20220806171839.30883878@jic23-huawei>
In-Reply-To: <20220731160120.4831-1-joetalbott@gmail.com>
References: <20220731160120.4831-1-joetalbott@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022 12:01:20 -0400
Joe Simmons-Talbott <joetalbott@gmail.com> wrote:

> As reported by checkpatch.pl add missing names for function definition
> arguments.
> 
> Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
Hi Joe,

I took this last week. Not sure why email didn't hit the list.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-event.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index b5e059e15b0a..0e2056894965 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -354,9 +354,10 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
>  	enum iio_shared_by shared_by, const unsigned long *mask)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -	ssize_t (*show)(struct device *, struct device_attribute *, char *);
> -	ssize_t (*store)(struct device *, struct device_attribute *,
> -		const char *, size_t);
> +	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
> +		char *buf);
> +	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t len);
>  	unsigned int attrcount = 0;
>  	unsigned int i;
>  	char *postfix;

