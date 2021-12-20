Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B07E47B3BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbhLTTcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhLTTcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:32:02 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A27FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:32:02 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id j6so21925703edw.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MpsgppUSFoPZhIJl2SnW8my3RwTRZUO3jm3yedovwCw=;
        b=jZf7RwAhl4FsNV0mmR8HFQVjMO8+XasHmk4N1spDsroEawvLukKGM6KxVD/5giCHu7
         KxaRhqYnAxibnQqtezfdGqTQTAra1tgQIx+P38IPYJhkkwCRwHC0Av7N38A5vmNZlJtB
         hw+GoeicQTN/lfbqrBjZLI6jezyIc3XqWfcS9MXZ7Ai82cvbfxr1jCzRj+ysfYKeEQTk
         dIsWd6RBG9O5nWof8UVKydkW4GM8WmJ8vthorciwF5e63WqqDh4D3EHo2KyYlYaYVYUR
         16evFhOW8B+25pgIH4S6BM79fAmzQjVMxI3EMQfUW6Y0DEGoAEeA19Z3qQJszKUNmyEv
         u0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MpsgppUSFoPZhIJl2SnW8my3RwTRZUO3jm3yedovwCw=;
        b=5g3YN2ht42KPiBCbhiX8NgJTrdLYx8Hw55AxWhAC33FUZpWcNoXxO5g4JEio1H6MsJ
         ez32DIBkdnU5LtokJwLkNdaKNjXRmUD4BOznsRFqWWFIpeFdYXyn6DJlYGRDZVYuK09u
         RUQEc6qc30tc6XqwWYUO2QHHP17dSkVOyEyXoUuM129bXE2O9e9kCd/Nd714f5wbB7nW
         y1eFV0dDuqR3T9rnHvaYFwcGk7dJUAPTH4xJDkiJJxEqLtvToZIIE6Zc6j2eUQv3z7HW
         SpQH6uWy0yIWbjmBwC3i6ekCkA066BoMoZsUIXk3PAGoMracbU98WyBG+7WuTt7kY+zR
         zlgg==
X-Gm-Message-State: AOAM5327YLCwhRNCFyw8bi9xhmQe59YAVbqjlwyRXmH6TwofeckezQGs
        1VFzr9v9+7P+jcAVUB0z7ZI=
X-Google-Smtp-Source: ABdhPJzKvc/MSW6zd1ePYHAHL3icUqe+cW0CX27OrFKvjJ+GHGloAITAHbQAswBU4g+37Wr3qMS6oQ==
X-Received: by 2002:a17:906:a20e:: with SMTP id r14mr14164190ejy.376.1640028720615;
        Mon, 20 Dec 2021 11:32:00 -0800 (PST)
Received: from tom-desktop (net-93-151-129-173.cust.dsl.teletu.it. [93.151.129.173])
        by smtp.gmail.com with ESMTPSA id 4sm5596273ejc.160.2021.12.20.11.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 11:32:00 -0800 (PST)
Date:   Mon, 20 Dec 2021 20:31:57 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxfancy@googlegroups.com,
        Forest Bond <forest@alittletooquiet.net>,
        Alberto Merciai <alb3rt0.m3rciai@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: drop off byRxMode var in device.h
Message-ID: <20211220193157.GA4401@tom-desktop>
References: <20211219182004.25656-1-tomm.merciai@gmail.com>
 <YcCxtkNJKhFWONv7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcCxtkNJKhFWONv7@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 05:39:18PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Dec 19, 2021 at 07:20:03PM +0100, Tommaso Merciai wrote:
> > Drop off unused variable byRxMode in device.h, this fix following 
> > checkpatch.pl check:
> > 
> > CHECK: Avoid CamelCase: <byRxMode>
> > 131: FILE: drivers/staging/vt6655/device.h:131:
> > 	unsigned char byRxMode
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> >  drivers/staging/vt6655/device.h | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
> > index 4706bde1ec1d..84b1dcf80e47 100644
> > --- a/drivers/staging/vt6655/device.h
> > +++ b/drivers/staging/vt6655/device.h
> > @@ -128,8 +128,6 @@ struct vnt_private {
> >  	u32                         memaddr;
> >  	u32                         ioaddr;
> >  
> > -	unsigned char byRxMode;
> > -
> >  	spinlock_t                  lock;
> >  
> >  	volatile int                iTDUsed[TYPE_MAXTD];
> > -- 
> > 2.25.1
> > 
> > 
> 
> Did you send this twice?  What is the difference between the two
> versions?

Hi Gregh,
I send twice for error, sorry.
> 
> And you have trailing whitespace in the changelog for this message,
> please fix.
I'll fix and send v2.

> 
> thanks,
> 
> greg k-h

thanks,
tommaso

