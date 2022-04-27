Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DA3511AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbiD0OyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbiD0Oxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:53:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365DF4093A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:50:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y3so3867958ejo.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TopemPKnePhFBvdQyVlRU2YsgkU6mC/ZFyaLpAEWb+8=;
        b=l1S8Szb6YcnjZdnVaz8zzSfr+dPrbZYHvwGnZbhtsZEwiNom8Ypifffv3sNqsjqKRg
         h0ddvg9NIF707QQrfjXr0lPbL+Rw+kElQKXli8kFttoj4zIcDlYZS2RxqHaT+xqmYyOu
         ujpXiXJ+fQ9oe4lLFNbP42Z1h9ZadEeN0kQhNwibhY3cQnurVmDXsFxL7S7TylQ69+nb
         OyDnahkiwXZZrNWSB3r06C6YfMHE4pSWE7nqRbQ32NTLj+VENsQ+SCCLoQCf5tm0G1hF
         VSvIlX64IZa6ajuuWOU93ZE2NQZ/fYitiEg9AKO10SkCWInJjTesRmgbeCLelOD6/S+y
         Erwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TopemPKnePhFBvdQyVlRU2YsgkU6mC/ZFyaLpAEWb+8=;
        b=KfEXTi3SsyzuisZH53t0d7bLVeah7KqHymUBXjzGBFisSw0U1olXX3qRNXgTRpkZYa
         RYK0HjPilX5yQcV/snAYmg+uF95dyUeZdzLVaZAJ7Fw1Kb7C1AmbcQ59oRX5RRyYBU/6
         7YElu8IPd5IC/x9a7SoPi5BYqSqhSTmcovhp8OSkQEjYgjlScAFDvq6EE2uWooXsWSoi
         xti8paah0PbFbLNbR/eb6PbAO/Q9VCsC5w8515db1oTczKE6bcK6wr1cUtaVBrYXCqlV
         Y0IK/f10WFEY2YIgz2nHmLOQuHVHvN6NbNfdC3haAgIhtClgQsg9NxhLcdJrE+Bin9ba
         lvJg==
X-Gm-Message-State: AOAM530G5sgBa/bIzWYxdshzYde+d/ORrORP6wazeUrKtgIPXhxs/YLJ
        iJ6nJd6abk5Zcd8d6uxnUHNn/NJcyzmeBlB9NSA=
X-Google-Smtp-Source: ABdhPJze0rrE09zpTtnC3kY/fQaGWUjOnEIxVfQjERch64qFczOtwWFYXf/NmUkjW0AubSZi4EJKq9liLxcZi/rCYqU=
X-Received: by 2002:a17:907:6d22:b0:6f3:a9e5:d074 with SMTP id
 sa34-20020a1709076d2200b006f3a9e5d074mr9978050ejc.639.1651071035761; Wed, 27
 Apr 2022 07:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204241643030.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHp75VdHnvv6FH1BKcs8WgGF3nJpj77TsrmsQGBSpsAQU_S-bw@mail.gmail.com>
 <alpine.LRH.2.02.2204260759540.2737@file01.intranet.prod.int.rdu2.redhat.com>
 <YmfxaB1j65p8dOyj@smile.fi.intel.com> <alpine.LRH.2.02.2204261128220.5129@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHp75Vc8kb+dpT_i93No+0_==tLuYKxu9t1Nnv1KRomRc+Ke1w@mail.gmail.com> <alpine.LRH.2.02.2204271000020.1114@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204271000020.1114@file01.intranet.prod.int.rdu2.redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Apr 2022 16:49:59 +0200
Message-ID: <CAHp75Vf=sEeoHwzb2RdVFsmZ_mWAyg2zdMKgtW9RQFM_bTMHPw@mail.gmail.com>
Subject: Re: [PATCH v2] hex2bin: fix access beyond string end
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Snitzer <msnitzer@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 4:10 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> On Wed, 27 Apr 2022, Andy Shevchenko wrote:
> > On Tue, Apr 26, 2022 at 5:29 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > > On Tue, 26 Apr 2022, Andy Shevchenko wrote:
> > > > On Tue, Apr 26, 2022 at 08:07:44AM -0400, Mikulas Patocka wrote:
> > > > > On Tue, 26 Apr 2022, Andy Shevchenko wrote:
> > > > > > On Sun, Apr 24, 2022 at 10:48 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > ...
> >
> > > > Still shadows error codes.
> > > >
> > > > > +                   return -EINVAL;
> > > >
> > > > >                     return -EINVAL;
> > >
> > > What do you mean? What's wrong with "return -EINVAL"?
> >
> > The actual error code is returned by hex_to_bin(). What is the point
> > of shadowing it with the explicit value?
>
> hex_to_bin returns -1 on error, hex2bin returns -EINVAL on error.
>
> This is inconsistent and it may be fixed (after verifying all the
> hex_to_bin callers - a quick grep over the source shows that there is "if
> ((k = hex_to_bin(in_str[j--])) != -1)").
>
> But for the purpose of fixing this bug, we should preserve the behavior
> and return -1 and -EINVAL just like it was before.

This is clear now to me. So, by improving a commit message you may
make it clear to everybody who reads your change.

With the updated commit message,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
