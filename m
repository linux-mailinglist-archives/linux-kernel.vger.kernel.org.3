Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB44C6D60
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiB1NEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbiB1NEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:04:02 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1467E42486;
        Mon, 28 Feb 2022 05:03:22 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id j9so5102956vkj.1;
        Mon, 28 Feb 2022 05:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BTl/pAfD1lZ0h4IgEDgvVGkksy8JHT3RGVdO1p5rBwQ=;
        b=Ldlxx9hDrW/D5mRexfK07vpqUm5TKE1VpzQKjQkvjhcAorAkHxxa7tI7JSaN+VYHl2
         6a6uEMH9oYAUOYiRQ5xkzVa8jS9+O0DhVRfm5d/jiLroorICFA2Ff/w5AtFCtdwI6pdN
         /A0fGyTwiWs7/iQuqK/tlooufyT6Txb+CXQOc7ej4befc/04Zg6+v3U0XIwiHc99+XBj
         2A2ajw15zY6/xRky38XIiREnuty1P6+Yq29yomZsZakkcytIVfer+PMhYP/sP4wy6hC5
         y71faSoQcslmZRT8Tg3qJel1E4QqIoFAzu6ke6t2rsRKwHaTvYwzmQ/7bLtPDKQj8ij3
         tqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BTl/pAfD1lZ0h4IgEDgvVGkksy8JHT3RGVdO1p5rBwQ=;
        b=TTQ60V367HaUxt/xZ/eJXU0Evy5CgBXBy/0nzXJvrMyEk8Srwp9uZ4R8jjxXi6UW/1
         yYZQIUkhMqDo7KL17hw9YA0/qXDWitw8Z7xyctFHSjfrikDJ+NrFG9qtVbbg9VDVh6/R
         8kFSUy/wpfFXnTofv8ZdCVmfH0GjEy6wXAwA9cbKm33izvYPls4uJAVlMnWPYX5I/n5a
         k1GVuuR6Fze343WS0QWzlhqTeqGGnRZJmFm+134HI0TwfegRgC1gkg5t3IoH/0m70FT+
         SC+05o/VssXVQOfMqo3m2uebsDTO/6MjpL3fdsERD5w4Sbt6jNFu8XV5/45WKkU951Hm
         aBIA==
X-Gm-Message-State: AOAM5304obN5rJ9/EmE56IMVVitjJ+Ulw4zERD9otnyyaA7zeU72xpJO
        zZhT352UMKpM7TupTBIk0y6/W8UBUFPfKFvIXpo=
X-Google-Smtp-Source: ABdhPJyHAUb/sh2pkS8vXWVikPEH8kElNCDS41yRTb+JNO4AIHzANImpaNBvQfUKfI2f/vXi912Qqw==
X-Received: by 2002:a1f:ac04:0:b0:32d:710:5930 with SMTP id v4-20020a1fac04000000b0032d07105930mr7901130vke.6.1646053401150;
        Mon, 28 Feb 2022 05:03:21 -0800 (PST)
Received: from ishi (072-189-064-222.res.spectrum.com. [72.189.64.222])
        by smtp.gmail.com with ESMTPSA id e20-20020ab02b14000000b00345f0381ddcsm1886237uar.0.2022.02.28.05.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:03:20 -0800 (PST)
Date:   Mon, 28 Feb 2022 08:03:18 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>, trix@redhat.com
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] counter: add defaults to switch-statements
Message-ID: <YhzIFofXbnbFe9N6@ishi>
References: <20220227161746.82776-1-trix@redhat.com>
 <20220227174610.0e0e73e4@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227174610.0e0e73e4@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 05:46:10PM +0000, Jonathan Cameron wrote:
> On Sun, 27 Feb 2022 08:17:46 -0800
> trix@redhat.com wrote:
> 
> > From: Tom Rix <trix@redhat.com>
> > 
> > Clang static analysis reports this representative problem
> > counter-chrdev.c:482:3: warning: Undefined or garbage value
> >   returned to caller
> >   return ret;
> >   ^~~~~~~~~~
> > 
> > counter_get_data() has a multilevel switches, some without
> > defaults, so ret is sometimes not set.
> > Add returning -EINVAL similar to other defaults.
> > 
> > Fixes: b6c50affda59 ("counter: Add character device interface")
> > Signed-off-by: Tom Rix <trix@redhat.com>
> I'm fairly sure this one is warning supression rather than a fix as
> that type u8 being used in the switch is storing an enum which is
> set only by kernel code and all values of the enum are covered.
> 
> However, that's not locally visible so to me the addition looks good, I'd
> just be tempted to drop the fixes tag as backporting this looks like noise
> to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Yes, this isn't really a bug because the only values available are those
from the enum, but I see how this is not immediately obvious at first.
If Tom has no objections, I'll pick this up and drop the fixes tag so
that we have it along with the other counter changes for the 5.18 merge.

Thanks,

William Breathitt Gray

> > ---
> >  drivers/counter/counter-chrdev.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
> > index b7c62f957a6a8..69d340be9c93f 100644
> > --- a/drivers/counter/counter-chrdev.c
> > +++ b/drivers/counter/counter-chrdev.c
> > @@ -477,6 +477,8 @@ static int counter_get_data(struct counter_device *const counter,
> >  		case COUNTER_SCOPE_COUNT:
> >  			ret = comp->count_u8_read(counter, parent, &value_u8);
> >  			break;
> > +		default:
> > +			return -EINVAL;
> >  		}
> >  		*value = value_u8;
> >  		return ret;
> > @@ -496,6 +498,8 @@ static int counter_get_data(struct counter_device *const counter,
> >  		case COUNTER_SCOPE_COUNT:
> >  			ret = comp->count_u32_read(counter, parent, &value_u32);
> >  			break;
> > +		default:
> > +			return -EINVAL;
> >  		}
> >  		*value = value_u32;
> >  		return ret;
> 
