Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5CD488635
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 22:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiAHVAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 16:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiAHVAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 16:00:02 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA6AC06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 13:00:01 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so11392815pji.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 13:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p1VgySDUuTxujElNU6wOZ2jQO8XPQhp9HhAkv/iVERk=;
        b=i+iv0X0I2cA4T9uM6PPCvPfcdwpNLXJW98EYdY6uuSkmTEqg7T/Ugg+hYKEbmLN0y4
         X5fya9KPEWYzmEdr9lRqh0uz/nrUsab/2+Yk11slGxwFJDiciev2Powr9DA5odBfe+pl
         9yP0WGrp6OlC3cAdrufgK1aFijAcKkhQsKCZnrbimQG3TrBqbsit3kkzbf0ITvc2ILHz
         ld6qaxjdUqn7+flYDnfFCKKxtNU4RtXFcdLpulyAv8LO6vp8v2a9fz3x2hmdweHvmCgK
         U4uoxnnrOss2BZYU+UBxkY5dshJReiK6BM85MzX2NjQ9u4oqF/jZD6lp4tmWpX7HWdQL
         1ixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p1VgySDUuTxujElNU6wOZ2jQO8XPQhp9HhAkv/iVERk=;
        b=TYghIzwZDC57sYWBj1cp0jow/+mJi6NE7oCwK2bh6puT0EXSCIiOMIGsG5iiskdqHV
         OXvmYJ5xtcL4lA6Yj+HbmF7DcS6TXlWKVb0Q/9DTYRkzQAn77p9avNaulvkHUI5IG8HG
         P9rLwnflHT7vEnNzO6yOEEZLK/mxWQ7W8+JVsmsXiAPQDMIic6w5xzcl3q1g4O6sbtuG
         c2OIazTNE+thGcltQeqze5MS+AIVvSd7W8MNsOwb3edGx/eZ+zDW5HRkygJCS1ZB+w1+
         pyU4dexWU5Vn3xFwdA077F6xE6EYNosnPrkiPe9VXJMYK0YvLCiM+qu7wqHxqLfa+A6B
         ni9Q==
X-Gm-Message-State: AOAM531Oghp8MvpDqjidqoOjdQr8b5F+9mvrQTv8Anut0VYHIBUqv8X5
        g+X2rfaDFil7dBoq+6UjfQY=
X-Google-Smtp-Source: ABdhPJz4yClYng8Ow9atBD9PGhp/H5v2R1hwaAEq2t1TqkiHVRfhRLqSrJ8ZakRmdEApFfbAtxNmPg==
X-Received: by 2002:a17:90b:3e8e:: with SMTP id rj14mr22268418pjb.195.1641675601274;
        Sat, 08 Jan 2022 13:00:01 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id i23sm2134065pgi.92.2022.01.08.12.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 13:00:00 -0800 (PST)
Date:   Sun, 9 Jan 2022 09:59:55 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: pi433: move get version func to where all
 other functions are
Message-ID: <20220108205955.GA3660@mail.google.com>
References: <20220106201430.GA3416@mail.google.com>
 <20220106213325.GA10767@mail.google.com>
 <20220107085343.GP7674@kadam>
 <20220107192438.GB2693@mail.google.com>
 <20220108111910.GA1978@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108111910.GA1978@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 02:19:10PM +0300, Dan Carpenter wrote:
> > are you strongly set on the rf69_read_reg approach or would you
> > be open to keep the original approach? (rf69_get_version)
> 
> I think my approach is best but I don't care.

Thanks for being so flexible. I'll keep your suggestion at the back of my
head and if I come across more scenarios in which rf69_read_reg would
be the easiest way, I will gladly send a different patch to make it
reality.

> > I just want to double-check if this suggestion is taking into
> > consideration what was mentioned here:
> > https://lore.kernel.org/lkml/20220106210134.GB3416@mail.google.com/ 
> > 
> > If it is, I'm happy to add it back but I just wanted to confirm it
> > first.
> 
> Yes.  Keep the error handling.  Your way makes the code more complicated
> to read.
>

Agreed. I will add it back.

thanks,

Paulo A.
