Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85D04DBA3D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349452AbiCPVjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356305AbiCPVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:39:37 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD5436E26;
        Wed, 16 Mar 2022 14:38:21 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id q6so2502765ilv.6;
        Wed, 16 Mar 2022 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5j/Sq8viQeL/hoyzW74KMLICeOJJ3w8lbHfpe3/YTVU=;
        b=DXYv2/wtt7waxuVknPG+8pyznDUfuCkxuI2Lex+axB/Zy85oY4E/fnFE0mA97FmQOi
         /tD3CPYnHde2MjrrfhGwuoC5N0G31hdTcV/G2/DdOgiXIpvsScpx4FYENxTSu7h5KnjU
         yl4EbrcDeBisoXk/U/1+Rfwm1qDfMKgs85FhvVJYtcQM6MUvnIbd9Pz2FDY+HuTobiGl
         P1AHw2J9ycFDjwN3c601lKwxw6IYpSGz9+8xw0anZjFNuEUEzq4sKJf9Bh5LoQLpzfOW
         hRGzG2q5XoYx+6cytlYs0+1zOd0fItjUylW/KJmqGBj8KwIJMXihXIoH4J1slKqK8Kmy
         VxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5j/Sq8viQeL/hoyzW74KMLICeOJJ3w8lbHfpe3/YTVU=;
        b=YPt0VrrPX6GBSUTT/JGfaLHI9lMhmj8NT66MC6UHzsax1EOt3kyTrtqt73/jg3qOhF
         m7KhjDIzSRA9cUW0EsunmyVu/UORlOTZHZdyu3rncAc2DgB+O92HNeQ+DONxiLZ8/YY9
         xBz0PLoZhFQ/8/+hIUE9eCgEyuTJIm0z1i80YYDTn5lwQm1aT6Mw8TEZRzwsDUyM7ja2
         QHgUAR7EMlckb6YpLcIdsoWOy9hMQLBRVLR3Y3i4INfNo1uBvotnO5Dp5MJUDpghwsHF
         GSgIW6iNpPK66f+YbGFI8iMs+DmLl9NXEeLV2zbgOnSxfX8H7o7m+07xrG1FUDkX1jBx
         A7oQ==
X-Gm-Message-State: AOAM530DkYj5GyfMxn1F6m82AY4hl3CIGBQq5Yzjeo9hjH4hEhWIGuKW
        ycCvUm6VgX639z67JOAxsVdLl5frvPoUfKJwwNM=
X-Google-Smtp-Source: ABdhPJzyY7nVOwSZFU6XgRHIUFHXdyAf8u1zf1zxe/TFlHeKO0VEOG5DoWkiwO5oi6A6Zcq1sk6IKlUs0qteIMjGX5k=
X-Received: by 2002:a92:c5aa:0:b0:2c5:f753:9069 with SMTP id
 r10-20020a92c5aa000000b002c5f7539069mr608362ilt.71.1647466700640; Wed, 16 Mar
 2022 14:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <Yh9G7FyCLtsm2mFA@kroah.com> <Yh9ZvLHuztwQCu0d@silpixa00400314>
 <Yh+FpKuoyj3G16lK@kroah.com> <Yh/vY4t3xnuoCW3Q@gondor.apana.org.au>
 <Yh/yr6oB5yeOUErL@silpixa00400314> <Yh/znCnZzWaL49+o@gondor.apana.org.au>
 <YiDHT31ujlGdQEe/@silpixa00400314> <YiEVPc2cd38AnLZB@gmail.com>
 <YiEyGoHacN80FcOL@silpixa00400314> <YiE21aPGG5DHwJvb@gmail.com> <YiJRQQmSxA/fbm6P@silpixa00400314>
In-Reply-To: <YiJRQQmSxA/fbm6P@silpixa00400314>
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Wed, 16 Mar 2022 14:38:10 -0700
Message-ID: <CACsaVZJ2JH1M9-fB9uO=XKDuO74ZPKBHX81TQ4+bBvr_iSNiWQ@mail.gmail.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Makes sense. I'm going to send it upstream and Cc stable as documented
> in https://www.kernel.org/doc/html/v4.10/process/stable-kernel-rules.html#option-1
> I will then revert this change in the set that fixes the problem.

Did this go anywhere? I'm still not seeing it in any of the stable trees.

Kyle.

On Fri, Mar 4, 2022 at 9:50 AM Giovanni Cabiddu
<giovanni.cabiddu@intel.com> wrote:
>
> On Thu, Mar 03, 2022 at 09:44:53PM +0000, Eric Biggers wrote:
> > On Thu, Mar 03, 2022 at 09:24:42PM +0000, Giovanni Cabiddu wrote:
> > > On Thu, Mar 03, 2022 at 07:21:33PM +0000, Eric Biggers wrote:
> > > > If these algorithms have critical bugs, which it appears they do, then IMO it
> > > > would be better to disable them (either stop registering them, or disable the
> > > > whole driver) than to leave them available with low cra_priority.  Low
> > > > cra_priority doesn't guarantee that they aren't used.
> > > Thanks for your feedback Eric.
> > >
> > > Here is a patch that disables the registration of the algorithms in the
> > > QAT driver by setting, a config time, the number of HW queues (aka
> > > instances) to zero.
> > >
> > > ---8<---
> > > From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > > Subject: [PATCH] crypto: qat - disable registration of algorithms
> > > Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
> > >
> > > The implementations of aead and skcipher in the QAT driver do not
> > > support properly requests with the CRYPTO_TFM_REQ_MAY_BACKLOG flag set.
> > > If the HW queue is full, the driver returns -EBUSY but does not enqueue
> > > the request.
> > > This can result in applications like dm-crypt waiting indefinitely for a
> > > completion of a request that was never submitted to the hardware.
> > >
> > > To avoid this problem, disable the registration of all skcipher and aead
> > > implementations in the QAT driver by setting the number of crypto
> > > instances to 0 at configuration time.
> > >
> > > This patch deviates from the original upstream solution, that prevents
> > > dm-crypt to use drivers registered with the flag
> > > CRYPTO_ALG_ALLOCATES_MEMORY, since a backport of that set to stable
> > > kernels may have a too wide effect.
> > >
> > > commit 7bcb2c99f8ed032cfb3f5596b4dccac6b1f501df upstream
> > > commit 2eb27c11937ee9984c04b75d213a737291c5f58c upstream
> > > commit fbb6cda44190d72aa5199d728797aabc6d2ed816 upstream
> > > commit b8aa7dc5c7535f9abfca4bceb0ade9ee10cf5f54 upstream
> > > commit cd74693870fb748d812867ba49af733d689a3604 upstream
> > >
> > > Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > > ---
> > >  drivers/crypto/qat/qat_common/qat_crypto.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > Sounds good; is there any reason not to apply this upstream too, though?
> > You could revert it later as part of the patch series that fixes the driver.
> Makes sense. I'm going to send it upstream and Cc stable as documented
> in https://www.kernel.org/doc/html/v4.10/process/stable-kernel-rules.html#option-1
> I will then revert this change in the set that fixes the problem.
>
> Thanks,
>
> --
> Giovanni
