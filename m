Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9425509498
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 03:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383608AbiDUBTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 21:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiDUBTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 21:19:05 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9481113D4F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:16:17 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id n11so2693333qvl.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F77C2q47pYS+RE/OwYeFXyxS3AjhQn7/SR6GHq78D9o=;
        b=gRwMUG+QIEI2kyRZlqfd4xYQieTFYWtCclx9IVQil7D/l/KhfqL9eHTcDQZrW85RRZ
         NCOS/gGcvu7QSxwl7bXTd/fMNv/SJ6YSZZHc4vNpFMyZ4lCbneeTQ4EOCXVUANLWiVTG
         ChFnwtlCYvS0zP6wd1SHhvBGPJ06Uc8pkDDZNAQ6TMubSEtJnZcoFO0+XkWmJh15tqau
         26iUTw3y+zlXyvVuZ3EMyomS4rDSfkh7ZsD+BDhf1lroX2MYNcVInXnmf26Qn8AiYtn7
         Dh95FMyps+w05SIvJp1Mxx5/9IQOm85L+lw6L1L5JwINhviclttqhCYxbYMMRDbUvgiZ
         /zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F77C2q47pYS+RE/OwYeFXyxS3AjhQn7/SR6GHq78D9o=;
        b=jwqy2FmOjiTvDSTH9qb7gZ8eNFkQ+cbdN26F+6+KKZxVuSyWAUcfXBFNNYXqugrUyK
         aLSSvPm3JB+gRWF389H/R7yZCg0KkcDhSPOVyFflC7gWR60NvfhEimJxBNDnM7BRk0nW
         SGL46usg8+vyfFn8JBaSu+uz+saC1Adp0RvOl96eU5z3kDVdw5sIcre177Blm09efplV
         0/CG3ZKUzhEdZjKiYvp6P8GKYPhCWyuyXYEXlmUgJwgz8UsEPTd/FYjQeUFN0gtZe5zO
         NaQDhHDLGpFi+6gb75hhrqB/2nFDYTCj9/6No0+DqOCQ1jFxDu64tONzFPAHJJbAPpjn
         ehNA==
X-Gm-Message-State: AOAM532t2Z7WpxM17v83egG43NsYkUTjivwZ1BYI+jKGXjnhDs4pZS10
        /FjA7RrWKAWHxXBIlt/Qjyvyb/B3lUw=
X-Google-Smtp-Source: ABdhPJyWFnCPc/QcD8yZDwf04BFpBVFoEELlmPqp8FSOw6wNgqpdGMgMv9RczvWhkI6FT4lzgZduxg==
X-Received: by 2002:ad4:5bef:0:b0:446:7727:efac with SMTP id k15-20020ad45bef000000b004467727efacmr7778139qvc.44.1650503776396;
        Wed, 20 Apr 2022 18:16:16 -0700 (PDT)
Received: from sophie ([45.134.140.168])
        by smtp.gmail.com with ESMTPSA id s195-20020a37a9cc000000b0069ca29ab6f4sm2403427qke.26.2022.04.20.18.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:16:15 -0700 (PDT)
Date:   Wed, 20 Apr 2022 20:16:14 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: compare strcmp result to zero
Message-ID: <20220421011614.GA5118@sophie>
References: <20220416102434.97567-1-remckee0@gmail.com>
 <20220420094220.GD2951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420094220.GD2951@kadam>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Wed, Apr 20, 2022 at 12:42:20PM +0300, Dan Carpenter wrote:
> On Sat, Apr 16, 2022 at 05:24:34AM -0500, Rebecca Mckeever wrote:
> > Add " == 0" to the condition in both else if branches to address a
> > possible bug. strcmp returns 0 when its arguments are equal, which
> > evaluates to false, often leading to errors when used in if statements.
> > 
> > Currently, the statement in the first else if branch does not execute
> > when its arguments are equal, but it does execute when crypt->ops->name
> > equals any string other than "WEP" or "TKIP".
> > 
> > Similarly, the second else if branch does not execute when its arguments
> > are equal, and it only executes when crypt->ops->name equals "TKIP".
> > The else branch never executes.
> > 
> > It is unlikely that this is working as intended.
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> 
> Looks good.  How did you find this bug?

I noticed it when I was trying to understand the surrounding code when
preparing another patch.

> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> > There is a similiar issue in
> > drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > but I'm not sure if it's incorrect. The strcmp on line 2847 isn't
> > negated, but the ones on lines 2851, 2853, and 2855 are.
> > 
> > 2845         /* IPW HW cannot build TKIP MIC, host decryption still needed. */
> > 2846         if (!(ieee->host_encrypt || ieee->host_decrypt) &&
> > 2847             strcmp(param->u.crypt.alg, "TKIP"))
> > 2848                 goto skip_host_crypt;
> 
> You're right, but also I suspect this whole if statement is wrong.
> 
> The if statement is only triggered if both ->host_encrypt and
> ->host_decrypt are disabled.  (Too many negatives).  I think both are
> set in alloc_ieee80211() and rtl8192_init_priv_variable() so both are
> always true and the if statement is dead code.
> 
> How does the code match with the comment?
> 
> Fixing this probably requires testing.  Maybe we could add this to the
> TODO list or maybe add a comment?

There isn't currently a TODO file for this driver. Adding a TODO file
would probably be more effective than a comment?

> 
> regards,
> dan carpenter
> 
> Ps:  When you have a !(foo || bar) then it's often more readable to
> write it as !foo && !bar, but in this case it doesn't really answer any
> of the core questions so don't bother.
 
Yeah, I think you're right, !foo && !bar makes more sense to me.

Thanks,
Rebecca
