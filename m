Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B23D57781F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 22:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiGQUId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 16:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGQUIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 16:08:31 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EE3B80;
        Sun, 17 Jul 2022 13:08:30 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g1so6701346qki.7;
        Sun, 17 Jul 2022 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RVbKruXrudOejdVpt6BRSlOurBARv5UgOInWZVYbs+M=;
        b=Feo/WyzmswpQ6NicQibu7mzR1pIk2iO52Q0OtTlN/e2t2DPJaiQ97wBBqbyVZui+fK
         vat0qDJkzeNJ7ptOoIzWR8SNk0/ORsETnCA1NJQiJ21HUq3o45sazeC4g/VxC79PTvK6
         h/lIjmS4ewlbAONVn6hVRd7cTRUMQd71X+yg9b1TBsYGxO8jxB5ZuzMnEkfbLkDgT+zL
         gHkVe+ZMiXvvMK/DHWtx0qJAJsbifIBb2TA3O6FXQxy2FsvpWdvbwQrLqFc4+Bw8LZF5
         JXPrnEYhViiCMhRj0gmuk3mDDwLBpz/i/n/cIEXoxpnzu0K12AbRvxh4rYE0+nRjB8TU
         TwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RVbKruXrudOejdVpt6BRSlOurBARv5UgOInWZVYbs+M=;
        b=oODmKJ+57WClnbsQKfm9JqVwN5yi1o4aA1ZAD+9nyd/z3Qz0LWElOpPJJOB1SSVyrj
         bJ+Gw3BotJ2PwjUIz1F/FBPAjK4PiMvAas4/fUJSpsrPhiiEeSNytvgacUzaSj/uYJTW
         WPMP/4gPH/xlDPPRK1+kci41MlO6Nbd9ZlCfe8tqm4WRBCl7QmW+n90yPKaJvWZZHRRu
         XsLNIHqxTbcVcic6hkBEDr/S0axlP5BXx+fUxzteuBYh0/1yB/8nfPKuXMPNABM/mfdc
         YmJqB8Hlsp2IRrhQHNS2vMxUj756m4zCmuVZwelm+wyeQkjpDADu7HMad9k5sQabMVzS
         4EFw==
X-Gm-Message-State: AJIora+eAWwWXq2w9e0qLyhTX6f1lMbiukp3VCqh82yWhFnbqsoKTDfk
        BbER2I70+Ynkbg+H5f8PBx0=
X-Google-Smtp-Source: AGRyM1u5HaRYUNSIdZ+VQ5cVrKgqByYPdxZQPsJ8u+nGtkiomGD+kBmPGxnwvSZR18sKhemEkOYgSA==
X-Received: by 2002:a37:d281:0:b0:6af:24c7:a981 with SMTP id f123-20020a37d281000000b006af24c7a981mr15889271qkj.736.1658088509176;
        Sun, 17 Jul 2022 13:08:29 -0700 (PDT)
Received: from spruce (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id g18-20020ac87752000000b0031ee01443b4sm4606923qtu.74.2022.07.17.13.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 13:08:28 -0700 (PDT)
Date:   Sun, 17 Jul 2022 16:08:27 -0400
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Use parens with sizeof
Message-ID: <YtRsO7cLyDIH47od@spruce>
References: <20220717153438.10800-1-joetalbott@gmail.com>
 <59c0003bfc5b429a8e39151da942fcaf707109a0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59c0003bfc5b429a8e39151da942fcaf707109a0.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 10:08:37AM -0700, Joe Perches wrote:
> On Sun, 2022-07-17 at 11:34 -0400, Joe Simmons-Talbott wrote:
> > Prefer 'sizeof(var)' over 'sizeof var' as reported by checkpatch.pl.
> 
> unrelated trivia:
> 
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> []
> > @@ -368,7 +368,7 @@ struct iio_poll_func
> >  	va_list vargs;
> >  	struct iio_poll_func *pf;
> >  
> > -	pf = kmalloc(sizeof *pf, GFP_KERNEL);
> > +	pf = kmalloc(sizeof(*pf), GFP_KERNEL);
> >  	if (pf == NULL)
> >  		return NULL;
> >  	va_start(vargs, fmt);
> > @@ -560,7 +560,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
> >  	struct iio_trigger *trig;
> >  	int i;
> >  
> > -	trig = kzalloc(sizeof *trig, GFP_KERNEL);
> > +	trig = kzalloc(sizeof(*trig), GFP_KERNEL);
> >  	if (!trig)
> >  		return NULL;
> 
> It'd be nice to be consistent with the allocation return test.
> 
> Please pick one of:
> 
> 	if (ptr == NULL)
> or
> 	if (!ptr)		// my preference
> 

I'm happy to submit a patch for that.  Do you want me to include a
Suggested-by: tag?

Thanks,
Joe
