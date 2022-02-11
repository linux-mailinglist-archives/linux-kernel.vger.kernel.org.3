Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C274B2DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbiBKTji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:39:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbiBKTjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:39:36 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83244CFD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:39:34 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so12880747pjl.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1PfxLBu5RTg6+W/ZdiydbjFdhG3Vz/jZwXQgz4MJUVk=;
        b=gTTQq1Lpjo4qFq2wmfuP+1ay9ScwIR14QX5SufQFA2pmQmCYOR2ta+n1yZCA/k1eGd
         jBWDOFfrcauj6jNvgk11++n3b9gGaYbKGOJPPAQLK/Wn9H7uuDULc1jLED5/W1oYiPwU
         VIv9Gp85XFQloIzZHpPptfV+uYh/3ufNJMFOiK5NmA9NHari4jIL6YZFwlVsIy9u7bM5
         IZb9a7HqGtginSss40ljGAJQgZxzZ74S0AajBqR/Lo7wZ+e77K4LCLGBdwaKKxX6yxBx
         uWxUpPL8V+v5Wm7bt5mdRzmLcjzEgFAu8FGt1ednky/2Z2Rko99gk2GTTh+2MTH77Jud
         uTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1PfxLBu5RTg6+W/ZdiydbjFdhG3Vz/jZwXQgz4MJUVk=;
        b=CS8vqaAkUxGIPRsbggUtYiuX+7JA5KqCcBsCsa54EGf1TO5yWslAQXXni6q4PoKWrx
         HPkd8VfFr6KzTvIzns8XvzUKe/gbjVN/hKPm5mk8959zz1dafcnMazL5t26BVgWWijnF
         PcVXW26BHWkTYPZJ9FcSxabihUCT/EyiPQxgub1G+kXv+N+5pguQG6tFyVEKt1F0O2lK
         sh6ycI5CCZnl2AgCTARLKSv6Jg+faFc8xypuPxsHKCHQPH496bEWxqELXwSNBKMeUot5
         vnm68xOI2FxsnykmXCJUPh6uLHcwv+h2uZxb953jrn4277jSI4k1dbtxZo1awGEup82u
         WraA==
X-Gm-Message-State: AOAM530AIyueW5Iaxwwt3TC0514WicdP8eIhc6nSjCdFQ7bOLsm+5l9c
        DvBRqmpfUJBR25hHILqu1jw=
X-Google-Smtp-Source: ABdhPJxvf10EAyJIO+qJIcDhcmGkyzxt4c/n32xl61eB7mzX4PIryCYdnd+wz16O98ulEsl/9SIdiQ==
X-Received: by 2002:a17:902:ed82:: with SMTP id e2mr2960091plj.55.1644608373945;
        Fri, 11 Feb 2022 11:39:33 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id h25sm25748175pfn.208.2022.02.11.11.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 11:39:33 -0800 (PST)
Date:   Sat, 12 Feb 2022 08:39:28 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     realwakka@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: add rf69_dbg_hex function
Message-ID: <Yga7cDO00Hmk9+BL@mail.google.com>
References: <YgYZRArwwF7Z1B4f@mail.google.com>
 <YgYa8Pt77v6AAyjb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgYa8Pt77v6AAyjb@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 09:14:40AM +0100, Greg KH wrote:
> 
> This is a lot of additional complexity for almost no real benefit.
> 

you're right. I will no longer pursue this approach. 

> > -	/* print content read from fifo for debugging purposes */
> > -	for (i = 0; i < size; i++)
> > -		dev_dbg(&spi->dev, "%d - 0x%x\n", i, local_buffer[i + 1]);
> 
> What is wrong with this simple line?
> 

to be honest, I think that 1 register per line isn't the easiest way to
read them. Given that print_hex_dump_debug existed and had this
horizontal-style priting format, I thought that it would be a better
way of visualizing the fifo data.

the only problems with print_hex_dump_debug was the absense of device
name and string format... so I saw a couple of drivers implementing
alternative hex_dump-like functions and thought that pi433 would benefit
from similar approach.

> > -	/* print content written from fifo for debugging purposes */
> > -	for (i = 0; i < size; i++)
> > -		dev_dbg(&spi->dev, "0x%x\n", buffer[i]);

if we are keeping this format, I may need to add the register idx to
dev_dbg: 
		dev_dbg(&spi->dev, "%d - 0x%x\n", i, buffer[i]);

> Again, the original is fine here, why make this so complex?

[thinking out loud/brainstorm]

I do agree that, for just a single driver, having a method like that
seemed unnecessary but do you think it would be a good idea having
something like dev_dbg_hex_dump or similar?

print_hex_dump_debug has the following limitation: 

1) lacks string format
2) doesn't honor dynamic debug flags (other then 'p')
3) doesn't print device driver name and device name

> > +	rf69_dbg_hex(spi, local_buffer + 1, size, "%s - ", __func__);
>
> Also, you are using local_buffer here, not buffer, why?
> 

That was a mistake, good catch.

> I think the original is just fine, no need to polish something as tiny
> as a hex dump for debugging only.
> 
> thanks,
> 
> greg k-h

thanks for taking the time to review the patch, I won't pursue this
approach anymore.

thanks,

Paulo Almeida
