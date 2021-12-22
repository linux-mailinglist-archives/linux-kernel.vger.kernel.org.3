Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8987747D783
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbhLVTNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhLVTNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:13:39 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DD0C061574;
        Wed, 22 Dec 2021 11:13:39 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id q14so2831334qtx.10;
        Wed, 22 Dec 2021 11:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wqw4Csw6qZshE12s1pYlPJOaQv5WDALPakxDCEsMC0E=;
        b=iWSZ9MZRac4lr9Bc8dNkgqGJSwe4YRtLf4xm6ZGxlzisWWu+INYtwBVh8eleUyD5bQ
         NpZlzrZ/RgG69av+Ak6mlzN2A1UKKAeeIGabGN+T9VGbbxv0yft1AvttkNZUIL7p+80W
         hfKFRzy9F4+CHbFF4Gzdrx8Vj1oyGwOs3oyxL6SUs71HDZ8H3SxNtnyPJufqXdaDr5gu
         ATbIjL6j5aQ8ed7bBc8QZO43OB5vHh8LQhZaImP9e5MRjElmPg9BQedjzxRjRka2L+FP
         TJweNJru/JkZCoHYQs0Crz5+BU3wlwrdYx5/43WtbONviEs8LIpc0RdoyHWsOgr+6BnE
         FkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wqw4Csw6qZshE12s1pYlPJOaQv5WDALPakxDCEsMC0E=;
        b=jAeVo0jPIxWKhPDVkt+oZRDN9/+mJFx3rMwe1XMsl9BkBqzBg4IJpAYJdCUDm9P05J
         x7phle1Y62Ux1uSWJ/UovCFD7YtCJqBm0jG/xsT5cbtRweqJ7fcts+gMSbW+bs4S4qAv
         CsVDMI/x5Gxka7bTedDW7D7Z54XSp1uJxEZdEcIWKcRkz8Qed59fhxdK+kfPUI5v3Xpw
         ny2RzTSkbKvHQhSGY73R9bn6v1yx5XCWTog6C8dZBOyfyg+AD3IUCIpD1li9nKRynHII
         HlCWNqWUrqy59RWscbQUMWb+0SAaYU3h6eG4eO6EWHPdDHE67geZS8c7m9zjGyupnfgq
         PyNg==
X-Gm-Message-State: AOAM533+9D46+QTXdbwZRhi6u2v2wFMqzZs4oaPLev7aHiYx3HJDLxz2
        XR69kpc8FD3IkWCCuyFVpbQ=
X-Google-Smtp-Source: ABdhPJzMAZN9PefC3l8mbgN/lL2Fr9Hu2xQIr8mr1qd9Xv/9JrRw5X9U0G8nSTMMdKEtTW3+eu5NVg==
X-Received: by 2002:a05:622a:134f:: with SMTP id w15mr3282155qtk.561.1640200418501;
        Wed, 22 Dec 2021 11:13:38 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id bs16sm2687874qkb.45.2021.12.22.11.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:13:37 -0800 (PST)
Date:   Wed, 22 Dec 2021 14:13:35 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v11 11/15] iio: test: add basic tests for the iio-rescale
 driver
Message-ID: <YcN43+L77t/EoKKf@shaak>
References: <20211222034646.222189-1-liambeguin@gmail.com>
 <20211222034646.222189-12-liambeguin@gmail.com>
 <CAHp75Ve4RuJLMdpdKe14nobuZHRNKA7tWt4yE82+noF5p+xxpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve4RuJLMdpdKe14nobuZHRNKA7tWt4yE82+noF5p+xxpw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 02:38:13PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:
> >
> > From: Liam Beguin <lvb@xiphos.com>
> >
> > The iio-rescale driver supports various combinations of scale types and
> > offsets. These can often result in large integer multiplications. Make
> > sure these calculations are done right by adding a set of kunit test
> > cases that build on top of iio-test-format.
> 
> ...
> 
> > +       int fract_mult = 100000000LL;
> 
> Perhaps also change to use the prefix?

Argh.. I missed this file. Sorry, will update.

> ...
> 
> > +       *nano = (s64)tmp * 10 * fract_mult + tmp2;
> 
> I'm also puzzled what the meaning of the 10 is here?

That comes from iio_str_to_fixpoint().
I sould've added a comment to make it more explicit as details escape me
right now...  Will fix.

> ...
> 
> > +       err = 1000000 * abs(exp - real);
> 
> Prefix?

Ok

> ...
> 
> > +       err = div64_u64(err, abs(exp));
> > +       return (int)err;
> 
> return div64_u64();

will do.

Cheers,
Liam

> -- 
> With Best Regards,
> Andy Shevchenko
