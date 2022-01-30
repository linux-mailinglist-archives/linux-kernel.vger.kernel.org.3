Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E704A371B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355361AbiA3O7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355335AbiA3O7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:59:07 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EC9C061714;
        Sun, 30 Jan 2022 06:59:07 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h25so8385438qtm.1;
        Sun, 30 Jan 2022 06:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f+X5yk2roOzmJwzypwQmhOu/mrO4cbF9p7VZTWulkAE=;
        b=hZn6WRv/zhcXNyjrVUeS9BrgiFa0HgEmEqOPc+zdMag+uwiwEspKvAyWYGgdmCwm7Q
         YcEtHdH0z0co22/8b/5aWo1NB36LXNTkPlsgUEqMIu6iKmDTUnUZXEzpamnVkR200w+o
         Gr4VZZJoSr2A9X0i27MLz3kOh/wzYWqc6Jr3031OzAVEU1zlyoi4V5DyBE5/MF0umGpe
         ELIgVNC4YEiZT19GgDXozTQvgxVjiansUUkFtz8CyUqClyM0mLlUmI5xxLvZzb4j8ARo
         1Yx8Mc9VRMc3h4MhqEKijxlU2iTfLbxwK2ZIFYz/72gVFREGTqCSpvwT1gvkTxqF8rhI
         19Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f+X5yk2roOzmJwzypwQmhOu/mrO4cbF9p7VZTWulkAE=;
        b=Be8s0TJ8b+FTAgotiqWZQ1RXkfYeFE1Nng9Ty//7N8kRGak0s64j5iYB3WttWhnlVU
         rziEC2109lel5cd3fMAr0Tr96xcpE3MKckEkT4e7OJl9K+yzxtiTwVDcWaTuMBiH858u
         gkoDix3T2/W7BNfl44UFm64YL6nszbyglB8Uyb8BN45zg0lLUjTKLHJJDCqgnTZ3MSH5
         BHg9YklK+zGYMGbFs5dtOY4XlcFFIE0dX0Y31Nxt/06I7dT9Z9NG/IfGxvD0hS3S3Ovd
         vK/r48rUI3e12z6UfkKWFuGJ/ImHJP/4mtn3Eadl1Fdodt7W3LCB7prp9M83BUUmhPbf
         Yq6A==
X-Gm-Message-State: AOAM531eGEqMHTUVNzzjiPZg9PMyfS42+yre+8j4oECd91Tol3GWlfEy
        G4bFG80TKu/jbkWFwUXeyktq0j+wSYI=
X-Google-Smtp-Source: ABdhPJysO5uJaDMgv+i05X60uWQx4c7I2DJErsRJZonIgGdivOF7DOzdYrpDgddVrms4fR9tronRlQ==
X-Received: by 2002:a05:622a:447:: with SMTP id o7mr1446288qtx.537.1643554746267;
        Sun, 30 Jan 2022 06:59:06 -0800 (PST)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id az38sm3436312qkb.124.2022.01.30.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 06:59:05 -0800 (PST)
Date:   Sun, 30 Jan 2022 09:59:03 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v12 00/16] iio: afe: add temperature rescaling support
Message-ID: <Yfant1/USRnKsCaJ@shaak>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
 <CAHp75VdyujSuTCr_+oFP9t=tardioG69k7uNkBSRAmPvqiyT7w@mail.gmail.com>
 <20220130143933.7711025a@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130143933.7711025a@jic23-huawei>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sun, Jan 30, 2022 at 02:39:33PM +0000, Jonathan Cameron wrote:
> On Sun, 9 Jan 2022 15:10:36 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Sat, Jan 8, 2022 at 10:53 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > >
> > > Jonathan, Peter, Andy,
> > >
> > > I left out IIO_VAL_INT overflows for now, so that I can focus on getting
> > > the rest of these changes pulled in, but I don't mind adding a patch for
> > > that later on.
> > >
> > > This series focuses on adding temperature rescaling support to the IIO
> > > Analog Front End (AFE) driver.
> > >
> > > The first few patches address minor bugs in IIO inkernel functions, and
> > > prepare the AFE driver for the additional features.
> > >
> > > The main changes to the AFE driver include an initial Kunit test suite,
> > > support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
> > > and temperature transducer sensors.
> > >
> > > My apologies Andy for misunderstanding your left-shift comments, I don't
> > > know where my head was at... Thanks for your patience!  
> > 
> > For the patches 1-5
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > 
> > Jonathan, perhaps you may apply them, so Liam will have less burden in
> > the near future.
> > 
> done, Patches 1-5 applied to the togreg branch of iio.git and pushed out
> as testing for 0-day to see if it can find anything we missed.
> 
> I've marked the fixes for stable, but am taking these the slow way
> (via next merge window) so as to keep things simple for applying the
> rest of the series later this cycle.

Thanks for taking these in.

> I got a bit lost in the discussion but seems there are some minor
> requests for changes so I guess I'll see a v13 of patches 6-12.

I'm rebasing what's left on top of your to-greg branch, and will send
out v13 today.

Cheers,
Liam

> Thanks,
> 
> Jonathan
> 
> 
