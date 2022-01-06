Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE62C486B86
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244078AbiAFVBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244010AbiAFVBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:01:40 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D30C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:01:40 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id i30so3680618pgl.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ft4KTDnmfGNxrsGxX/0Cc8w5WOpSQF6ljEU4UL8RaD8=;
        b=oQv+P66yLtYEjzRdtw6E+azvb1+cssHtxap+eylA/E6oDuldn/j9leLANeLuYuXGu+
         196ocDCi50FISgMjWsuWaMgbWeJ9p2GINm85nplZL1qYWzUawKSrIhB9lybagNk4HTC/
         pJJqrBWGcpOlGa7ieS+EawyTLVVXFx/x0017f1S7LiquuXr7fJJW22Qzm6La7qWcyj0l
         3XCNP7DEQ24c7MBLo/yMFqYzFL/9GGsCXAIbXUv5OxHvVM6nmF5pp9hoDI2HUrj/G9ZH
         vFJH6UODT8yMbQb5OLhVh6KCP4t9YiGgusl+iCFeIFb6eekicCxm9it/iKOuL08QVT+i
         ZlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ft4KTDnmfGNxrsGxX/0Cc8w5WOpSQF6ljEU4UL8RaD8=;
        b=Bx4uAXllCNiV0g3iFY2N4KRuPgfn3RHTkdp1mZmnKMwmUWqXDjaYl2YIdw9MyFoYxy
         CGbS9XBu1namjU/FS/hcI13mEScVO8huIEed1yP+xvmkpuqZhkSRhoa+u5VN5l69fJ4J
         QogxeUeJ9wpeXU36OmKLy5WrHuIgG0ndP9PEBA2ZZCMn62tflwEAIZEMFV9+vHn+b9E6
         OQiWwp0GxQrZQTy7U5NIPy9WAiITwKCu3deSd5LVI/+NccHMeeNfA+SrYd9gLf4CwWMF
         WwTeBBlSWJBqwfwte0tOFKeUaGUaF60MoeWN4uMjjxvB52WIy8U4ZcqtMuAWflHGgK63
         y9aQ==
X-Gm-Message-State: AOAM5300KI290GCdFcJsQPvvg33pwmsly7m3nBpReXoJKNmr5KWzab6q
        RgTwfKSW89cqftQ0jQJayvg=
X-Google-Smtp-Source: ABdhPJyUAM2wF97lFOwI55hw8C21xSxvLscFnuutC/Yawdg8EhM6MeUMQobVIDOJ/tdMtHo/FghKXw==
X-Received: by 2002:a63:b20d:: with SMTP id x13mr8730426pge.310.1641502900186;
        Thu, 06 Jan 2022 13:01:40 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id t126sm2739702pgc.61.2022.01.06.13.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:01:39 -0800 (PST)
Date:   Fri, 7 Jan 2022 10:01:34 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     realwakka@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: move get version func to where all other
 functions are
Message-ID: <20220106210134.GB3416@mail.google.com>
References: <20220106093110.GA20011@mail.google.com>
 <Ydb22Tuvm0MwfpOK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydb22Tuvm0MwfpOK@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 03:04:09PM +0100, Greg KH wrote:
> > --- a/drivers/staging/pi433/pi433_if.c
> > +++ b/drivers/staging/pi433/pi433_if.c
> > @@ -1116,9 +1116,7 @@ static int pi433_probe(struct spi_device *spi)
> >  		spi->mode, spi->bits_per_word, spi->max_speed_hz);
> >  
> >  	/* Ping the chip by reading the version register */
> > -	retval = spi_w8r8(spi, 0x10);
> > -	if (retval < 0)
> > -		return retval;
> > +	retval = rf69_get_chip_version(spi);
> 
> This can not fail anymore, like it used to be able to.  So I think you
> just broke the functionality for why this call was being made in the
> first place (i.e. ping the chip to see if it was alive, and fail if it
> is not.)
>

I thought that this if statement was somewhat redudant because right
after obtaining the chip version, there is a switch statement that
checks if the value is what we expect or return an error otherwise.

Unfortunately, in the patch file generated the whole switch statement 
isn't visible so I admit that it looks funny at first. I will paste the
routine here:

/* Ping the chip by reading the version register */
retval = rf69_get_chip_version(spi);

switch (retval) {
case 0x24:
	dev_dbg(&spi->dev, "found pi433 (ver. 0x%x)", retval);
	break;
default:
	dev_dbg(&spi->dev, "unknown chip version: 0x%x", retval);
	return -ENODEV;
}

Let me know if you agree with the approach I've taken, otherwise I am
more than happy to add the original if statement if you think I'm
missing any edge case here.

Once again, thanks for taking the time to review my patch :)

thanks,

Paulo A.

