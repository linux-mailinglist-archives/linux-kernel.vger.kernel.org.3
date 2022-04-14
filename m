Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F196501C10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345719AbiDNTnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbiDNTnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:43:50 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AC1AC050
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:41:24 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id a5so4920957qvx.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yL9/UIL982jnwFL4yczTgqRaZlbJCY9QhpIXC00WZqw=;
        b=SQDCH2eXbnV6ThaqWQZY8N5NxsV2cc0btmkPWX9ZdhfGbQ8negud7uKiAMm6D0enDK
         GtwUxBUoFT3TkdVQmK7JDQQH7UdrBoxVwwA5CT1SdTP5Fi7xuZ2Tsb4YKQh/2UioZ89d
         a10kmA4refMtnqO9FcIb9lxA2gFAykJZqK3zqPa8eOd0vQOegR2C//dMDhhUA5y+Sz5D
         gHmV3Bp/udHH0tUXylkdfBs7dC2BrqJW4FmFSZDGYze+F//D4l/u7AsjOvk1EWD+kdkH
         Q5aAavNJj5WRZJGdZzJKPK2awBB4GPJmuvy4s561szrhomyBz01wS7V8DjR1iFgfeStc
         TRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yL9/UIL982jnwFL4yczTgqRaZlbJCY9QhpIXC00WZqw=;
        b=wfCHKjTuB9mCxEuiVLP/1NW5rlSYzOXR8rqiqf74QdHYW9itOFn9k3VU8doUY+fJpy
         yZaTtSGC3P4CwxKsGsLnJSnD+CqVTQ9ODBdBDS8JhJT6l8QGeeYYMsIAyE1eiV+2kYqG
         hsKlUxHOq9QDagSbvJv7gdPii27chaanGIq2w//QNJ0uWpFYuboHX83yTf3anF2pXN9t
         ZKY0qUp4Lib1PU8utV6IRmFzniZPs9gm4TTuvON37uB38YULL+REK/1UswqrR995Tw8J
         vMWnkDMJkj58Teyb5t3VS0gHNtuV5zSxpKtakAi/mVly34FAsczybJW5HPMYqb+4ncnU
         82MQ==
X-Gm-Message-State: AOAM533FEVwaZl84SQsUgY4K+01sfL7qNQY88aGH36RiBepsU1XNBMQ+
        +2R+A0qb0qkxfASNHK9MuhnBdcw4d+A0ZDgo
X-Google-Smtp-Source: ABdhPJzHLQhfEnhSBmgGyGjfuvAueEwWhilK6pSHxGbK1M5Rykq8UmuXwDzGl1xLwxYzk9YF2LdIig==
X-Received: by 2002:a05:6214:1194:b0:444:45d6:d79d with SMTP id t20-20020a056214119400b0044445d6d79dmr4847812qvv.36.1649965283442;
        Thu, 14 Apr 2022 12:41:23 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id e126-20020a376984000000b0069c86b28524sm577567qkc.19.2022.04.14.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:41:22 -0700 (PDT)
Date:   Thu, 14 Apr 2022 15:41:18 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH 1/6] staging: r8188eu: remove unnecessary braces in
 single statement block
Message-ID: <20220414194118.GA4144553@jaehee-ThinkPad-X1-Extreme>
References: <cover.1649880454.git.jhpark1013@gmail.com>
 <4a0f2a0f24321c5b2039f0f8e6132cec4a2ef068.1649880454.git.jhpark1013@gmail.com>
 <3f4a6c08-4434-1865-bc96-984152af5af1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4a6c08-4434-1865-bc96-984152af5af1@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 11:24:46PM +0300, Pavel Skripkin wrote:
> Hi Jaehee,
> 
> On 4/13/22 23:11, Jaehee Park wrote:
> > Remove braces for single statement block to minimize the number of
> > empty lines, without loss of readability. Issue found with checkpatch.
> > WARNING: braces {} are not necessary for single statement blocks
> > 
> > Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> > ---
> >   drivers/staging/r8188eu/core/rtw_mlme.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> > index 3e9882f89f76..d3f4d7cdfa08 100644
> > --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> > +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> > @@ -112,9 +112,8 @@ void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
> >   	rtw_free_mlme_priv_ie_data(pmlmepriv);
> > -	if (pmlmepriv) {
> > +	if (pmlmepriv)
> >   		vfree(pmlmepriv->free_bss_buf);
> > -	}
> 
> If pmlmepriv is equal to NULL we would die in rtw_free_mlme_priv_ie_data(),
> so this check is just redundant
> 

Hi Pavel, thank you for your comment! If I'm removing this if statement,
should I include vfree(pmlmepriv->free_bss_buf) in 
rtw_free_mlme_priv_ie_data?

> 
> 
> 
> With regards,
> Pavel Skripkin
