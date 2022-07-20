Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2601957BE60
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiGTTYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiGTTYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:24:24 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBE37436C;
        Wed, 20 Jul 2022 12:24:10 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h16so2933737ilc.10;
        Wed, 20 Jul 2022 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hl75daCj6bmszj8wMSbUPV0LQRu+ve1ILCk7lybXe/E=;
        b=SKm8TkhEPfi/RU5XpslPHkzPuUiswStDsB7SXaiVQCWY1zP5vmMPME52ydkD5hlia3
         eX6hARWc0vTSROK/HdfzIvDQKRifaLajTYBlr1UmriVcqRMeBdzxSMi+ZWRvf144fbV4
         PDBSyfFNZI38+eEmL8pN91YVG7PJBUHC+ZfeUUC11CBX6H6/bvrsZyP8d6mdlfFuK8u7
         zifY6TUZ2a4gNnCOkEf0TC/BunAzdvwVElmHiPU9JhLNBux7HD5j0NrYpzTczto28QPj
         IyJqO1qU2MQdbKsRI8Gqx04zg9apjs9LM0zw/nR4a7WgkhMmRL7+E8Kv/oMZ5vG0Cp47
         JH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hl75daCj6bmszj8wMSbUPV0LQRu+ve1ILCk7lybXe/E=;
        b=6M8yNEIdNKmO233IJivRn2IrJhN/2uvoz5wnDRSFM05riOrbkh1WW8qvZ1BxX+24bY
         4WB4t0qJqRINip8rMFFd+MYPjlIr1UITyjPmmjCwpAe4OBmBcWeLGuZKbKUtmTB8mW5m
         xOS1PSR7Ib8FWjKrMzMSiFZ4mGjYLfIMnLFWhnIwVS4bpYW0iSZt861TXqtb444KRYio
         Wnu9YEp2GbNQBoIcucE7jO90IGLXYWRLbODCb3VhuCsUbYrSLswU/37kEfa+AzKi1ofJ
         rsE+korkjxH6MQYJIhlQt8gK/iet6ZQzm+nxMjTKDkxs7G0R2+GuREqPnD6WBV6Zk02U
         Y/dQ==
X-Gm-Message-State: AJIora/wd9gpSRfZtTpoP6R5Aze8ynmXeT0f9RTx9FcwdcMDDpeZk/pH
        XPT4+xA5HKKnlVErh3t8sO4qpTCPeFs2abIMJ7XUO/gWRBrMZg==
X-Google-Smtp-Source: AGRyM1tSMHamXHQVemmB9sJC5cgve9nid3rtOujbVF4Y7tju5ujgFrF/r9OGE56jB/kiVcwZQz+REsBLTVgblsM2JDw=
X-Received: by 2002:a05:6e02:1c23:b0:2dc:e497:8b12 with SMTP id
 m3-20020a056e021c2300b002dce4978b12mr9260657ilh.151.1658345049872; Wed, 20
 Jul 2022 12:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org> <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
 <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com> <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
In-Reply-To: <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 20 Jul 2022 21:23:55 +0200
Message-ID: <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
Subject: Re: [PATCH 00/13] [RFC] Rust support
To:     Olliver Schinagl <oliver+list@schinagl.nl>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Jul 18, 2022 at 8:56 AM Olliver Schinagl
<oliver+list@schinagl.nl> wrote:
>
> Absolutly, but with the many luitenants, many tree's, and not a single
> CI source, this would still be tricky in the end; but certainly possible.

A bot in -next (possibly an existing one) is a single thing to care
about and the amount of maintainers/trees doesn't have an effect on
it, thus I don't think it would be tricky.

> I think this is a pretty poor argument for following Rust's opinionated
> view of the world. E.g. it's generally bad to copy/paste code to begin
> with. How many 'bugs' that we know of are copy/paste bugs?

We will have to disagree. Consistency and simplicity are fine
arguments in my book, not "pretty poor" ones.

I don't see the relevance of the copy/paste code discussion here. But
assuming the analogy makes sense, I don't agree that reusing code is
"generally bad" either.

Anyway, given you mention "bugs", I think you are implying that the
defaults are somehow "incorrect" (not accessible?). In that case, to
improve things for all Rust developers out there, I would suggest
opening an issue in https://github.com/rust-dev-tools/fmt-rfcs.

> Secondly, and more importantly so; you argue 'who cares about people
> with disablements, atleast its equally hard to read everywhere' which is
> a very poor argument :p

No, and I want to be __very__ clear about this: at no point I have
argued "who cares about people with disabilities" or anything like it.
It is insulting that you even suggest it.

Likewise, you are the one claiming it is "hard to read", not me.

And then after constructing those straw men, you call them "a very
poor argument"...

> Finally, it must of course be mentioned, that rust is really trying to
> do an XKCD here, https://xkcd.com/927/ though I'm sure we'll get it
> right this time around ;)

How does that even apply here? There is no "standard" for formatting
across languages, if that is what you are saying.

Actually, what is happening here is that there is an "official" tool,
called rustfmt, that most Rust code out there uses.

By not using it, it is you the one that may be creating a XKCD
situation, if anything.

And to be clear, we don't necessarily follow "Rust's biased view". For
instance, there is also an "official" build tool, called Cargo, that
most Rust code out there uses; yet we are not using it for the kernel.

We are actually doing things how we think are best for the kernel. Not
because "Rust" (whatever or whoever that is) is "trying to do an
XKCD". Not because we are "following Rust's opinionated view of the
world" or "Rust's biased view".

> But you are not, only those that follow rust's biased view. Everybody
> else that has a different opinion (like die-hard C programmers) that
> care enough (I'm sure there's plenty) would setup their rustfmt config
> file to resemble their C code; and thus the entire premisis is broken.
> Though; yes, in a perfect world it could have worked like this, but xkcd
> again :)

No. I said we are being consistent with the majority of the Rust code
out there, not with "everybody".

If, instead, we try to be consistent with the kernel C style, then you
are likely not being consistent with the majority of the Rust code out
there. And you would have to decide exactly how to map the C style to
Rust constructs and which particular kernel style.

Again: I personally don't mind what the particular style is. As a
project, what we value the most is having a single style across it and
not having to think about formatting. Nevertheless, I think there is
also value in being consistent with the majority of the Rust code out
there.

> This though is a fair argument I understand, it would be weird in having
> 2 styles in user-space and kernel-space code; though I see this
> happening today as well; where developers follow kernel style for kernel
> code (obviously) but use their preferred 2 or 3 space style on their
> userland code. Trying to 'force' this, usually however never gets the
> intended result ...

If we follow the usual Rust style in the kernel, I would say it is
more likely that both styles match.

Cheers,
Miguel
