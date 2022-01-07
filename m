Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F6B487211
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346135AbiAGFPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiAGFPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:15:11 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B500C061212
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 21:15:11 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id l10-20020a4a840a000000b002dc09752694so1223215oog.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 21:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lXYTMqTPQj6nVYc2LjkC+PRXcEeKHgZlGRbidIcOIo=;
        b=L3zHbWNYc53NMKrX6Sl1d3PRn29b66vuiNXviFr8GA4a+SYGpiSAyvS18jms6d8qVB
         fKs3D+Nbr+M6SNOoFZDyMEvRSdPvzFrzzEGDWpLMQWGidJTOSq1Iqpx53jH1xd4YXitS
         SSGZeD8LGKgJig/FEGdCluCKQl2Oe2NwjhtHQpWiii5utKHQBmtfn6tScZX6Kakzb2TF
         EP0qNy52kdQQDeE0/CzqJ36Xhn6zZGmaoniKY5iaEE+FoazTqn1MIU0UX+METLAKof5P
         IzzC0+07tN5TPfH60atp5u5kgV5lP7qVsaQzSBeSiN0T3CFVtqm2p2FVW9BXdVs6KNB/
         cx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lXYTMqTPQj6nVYc2LjkC+PRXcEeKHgZlGRbidIcOIo=;
        b=nnQPna7gJl5nsXWNMaxkxf4qtBHuSu79o+Nzfox8EVOzUp9UiVmUF+jcJCYkgJZbYw
         fn1UqcymIt7FXoeiO1PPNWHFpcaW2J/M+CZf+6Z12d3AFzBe4SYh88vaiwE+i5Ab2UWO
         P7jHgNriiheSjUb/+25mQzGQp/yrMOL3vEPkQpRxK1kE0AdHZix/KSgJMnQOlmc5y+pE
         LIxukrFMZS1zwzNjDwP8veKvkkXxrz2ptSrp5+cSj29nsLEErk/DpBwCoDoLl2Otme7C
         j3h/3nkfQIz3r1HmJDFw/Mmq1XcuvHFL+iRIXz1jr8xRy9mDLc+JEP1RcV1t+MhHhbRn
         Tkmw==
X-Gm-Message-State: AOAM532xF6dumXgfC4X8nrSMWZNlIG3BTM8xp0BzUOGbPH4O91rOg+jy
        HSzZLvK26Sc2HGnSqCzHPtPuvyUZkzLSpnfq9sYpwQ==
X-Google-Smtp-Source: ABdhPJwJ2NaeNTYz8jr/Bz1rJEZfuZ5XHAT20ivQM2kiMSToIXtUl8uQhMexLkbtkzTkHr/nOhstN/RfFJf7Y6M22uk=
X-Received: by 2002:a4a:5403:: with SMTP id t3mr3926068ooa.72.1641532510072;
 Thu, 06 Jan 2022 21:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20211229215330.4134835-1-yaelt@google.com> <CAFA6WYPuPHgcnzt6j+Q-EA2Dos6vBDukrjpheo5srLVXFrifEg@mail.gmail.com>
 <5a38824152eeee0fc9ba0a4fd2308bb6e0970059.camel@linux.ibm.com>
 <CAFA6WYOJt3=YMTt_QQSq6Z-MK42hwWspgSpasw2fuPtVFcP3uA@mail.gmail.com> <CAKoutNvW1c7MkTaFwyrD7MjUVXvTtcBOGFULMittJ5vzjMN0mg@mail.gmail.com>
In-Reply-To: <CAKoutNvW1c7MkTaFwyrD7MjUVXvTtcBOGFULMittJ5vzjMN0mg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 7 Jan 2022 10:44:57 +0530
Message-ID: <CAFA6WYPQRagZF8-grn_LC8_SAaxBzh=cSgHhFAQQOYK+L2KuBQ@mail.gmail.com>
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
To:     Yael Tiomkin <yaelt@google.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, Jarkko Sakkinen <jarkko@kernel.org>,
        corbet@lwn.net, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yael,

On Thu, 6 Jan 2022 at 01:48, Yael Tiomkin <yaelt@google.com> wrote:
>
> Hi Sumit,
>
> On Mon, Jan 3, 2022 at 1:51 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Mimi,
> >
> > Apologies for the delayed reply as I was on leave for a long new year weekend.
> >
> > On Thu, 30 Dec 2021 at 18:59, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Thu, 2021-12-30 at 15:37 +0530, Sumit Garg wrote:
> > > > + Jan, Ahmad
> > > >
> > > > On Thu, 30 Dec 2021 at 03:24, Yael Tiomkin <yaelt@google.com> wrote:
> > > > >
> > > > > The encrypted.c class supports instantiation of encrypted keys with
> > > > > either an already-encrypted key material, or by generating new key
> > > > > material based on random numbers. This patch defines a new datablob
> > > > > format: [<format>] <master-key name> <decrypted data length>
> > > > > <decrypted data> that allows to instantiate encrypted keys using
> > > > > user-provided decrypted data, and therefore allows to perform key
> > > > > encryption from userspace. The decrypted key material will be
> > > > > inaccessible from userspace.
> > > >
> > > > This type of user-space key import feature has already been discussed
> > > > at large in the context of trusted keys here [1]. So what makes it
> > > > special in case of encrypted keys such that it isn't a "UNSAFE_IMPORT"
> > > > or "DEBUGGING_IMPORT" or "DEVELOPMENT_IMPORT", ...?
> > > >
> > > > [1] https://lore.kernel.org/linux-integrity/74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de/
> > > >
> > > > -Sumit
> > > >
> > > > >
> > > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > Signed-off-by: Yael Tiomkin <yaelt@google.com>
> > >
> > > There is a difference between trusted and encrypted keys.
> >
> > Yeah I understand the implementation differences.
> >
> > >  So in
> > > addition to pointing to the rather long discussion thread, please
> > > summarize the conclusion and, assuming you agree, include why in once
> > > case it was acceptable and in the other it wasn't to provide userspace
> > > key data.
> >
> > My major concern with importing user-space key data in *plain* format
> > is that if import is *not* done in a safe (manufacturing or
> > production) environment then the plain key data is susceptible to
> > user-space compromises when the device is in the field.
>
> I agree this can happen. Key distribution in any scenario needs to be
> secure and this could also potentially be an issue if the key is first
> encrypted and then imported.

Currently its not the case with encrypted keys. These are random keys
generated within the kernel and encrypted with master key within the
kernel and then exposed to user-space as encrypted blob only.

> We can make sure the documentation
> highlights the safety requirement.
>

IMO, you should enable this feature as a compile time option. The help
text for that config option should highlight the use-case along with a
safety warning.

-Sumit

> >
> > And it sounds like we are diverting from basic definition [1] of encrypted keys:
> >
> > "Trusted and Encrypted Keys are two new key types added to the
> > existing kernel key ring service. Both of these new types are variable
> > length symmetric keys, and in both cases all keys are created in the
> > kernel, and **user space sees, stores, and loads** only encrypted
> > blobs."
> >
> > Also, as Jarrko mentioned earlier the use-case is still not clear to
> > me as well. Isn't user logon keys an alternative option for
> > non-readable user-space keys?
>
> The goal in this change is to allow key encryption from userspace,
> using user-provided decrypted data. This cannot be achieved in logon
> keys, which as you mentioned, are simply non-readable user type keys.
>
>
> >
> > [1] https://www.kernel.org/doc/html/v4.13/security/keys/trusted-encrypted.html
> >
> > -Sumit
> >
> > >
> > > thanks,
> > >
> > > Mimi
> > >
>
> Yael
