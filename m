Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A2B464DD2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349205AbhLAM23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:28:29 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:41595 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbhLAM2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:28:20 -0500
Received: by mail-ua1-f42.google.com with SMTP id p37so48484771uae.8;
        Wed, 01 Dec 2021 04:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wM6sLeqqHQEJqcA32n7DT7OQw6XkxxoEaHR8PwS804=;
        b=2+/Lxkk0Mkb35oOv588S1PgVukf1ht3CrNv8OnFxnz6RdAipH87HvXJslPI+fAotoW
         My1u6PeMR5gOtLTwrvstDP9J5jca9ECaCMb0dDD0+yQcn7iytMLQmadU7qBP9UOzswCl
         UmnvSYofWewe3G4EvpRtbD0YJe5+QFCVfKBaWtTL0oNTdLZ9pDIRza8m9Zn+4cFH8TLJ
         oRmYSHV3T0qda3vwJBWKa0Xkft5sVOgPWFL4aaPrNJRsgJ5phmEoH+VKclZbAX91+65V
         SUvDnqlp+sOE9M6ql1CVrYakZdt2l+38JWNUgIa9BcINl+1myQYCb+YXKGs6WECkurJk
         arLQ==
X-Gm-Message-State: AOAM531zQHolgYPdF3KCJ00c5560rmV5zXfOmXoQn6HhqG7S/mkVEHW0
        voMOvoYehR9PeJ0T1zxEQRmg5syLlQSTjw==
X-Google-Smtp-Source: ABdhPJyuckWgJnc0GTwVVO6MiXuhjv1Ukeeyf8gU3ddLycHypvlDAF1ez3v6dOII0xaH65sMDvfpXA==
X-Received: by 2002:a9f:3649:: with SMTP id s9mr6526028uad.123.1638361498705;
        Wed, 01 Dec 2021 04:24:58 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id r2sm11877843vsk.28.2021.12.01.04.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 04:24:58 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id y5so48491274ual.7;
        Wed, 01 Dec 2021 04:24:58 -0800 (PST)
X-Received: by 2002:a05:6102:c89:: with SMTP id f9mr6786745vst.68.1638361498069;
 Wed, 01 Dec 2021 04:24:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637566224.git.linux@leemhuis.info> <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <8735nesj3r.fsf@meer.lwn.net> <72e4756f-c410-6c78-696f-b5e4bfebc135@leemhuis.info>
In-Reply-To: <72e4756f-c410-6c78-696f-b5e4bfebc135@leemhuis.info>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Dec 2021 13:24:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUZ3cyJLr90J5+BpBeq5hEibKy4=8Ly9YbmW8FMA1S=rQ@mail.gmail.com>
Message-ID: <CAMuHMdUZ3cyJLr90J5+BpBeq5hEibKy4=8Ly9YbmW8FMA1S=rQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags 'Reported:'
 and 'Reviewed:'
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

On Wed, Dec 1, 2021 at 7:32 AM Thorsten Leemhuis <linux@leemhuis.info> wrote:
> On 29.11.21 23:16, Jonathan Corbet wrote:
> > Thorsten Leemhuis <linux@leemhuis.info> writes:
> >> Introduce the tags 'Reported:' and 'Reviewed:' in addition to 'Link:',
> >> as the latter is overloaded and hence doesn't indicate what the provided
> >> URL is about. Documenting these also provides clarity, as a few
> >> developers have used 'References:' to point to problem reports;
> >> nevertheless 'Reported:' was chosen for this purpose, as it perfectly
> >> matches up with the 'Reported-by:' tag commonly used already and needed
> >> in this situation already.
> >>
> >> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>

> > [...]
> >> +The tags in common use are:
> >> +
> >> + - ``Reported:`` points to a report of a problem fixed by this patch. The
> >> +   provided URL thus might point to a entry in a bug tracker or a mail in a
> >> +   mailing list archive. Typically this tag is followed by a "Reported-by:"
> >> +   tag (see below).
> >> +
> >> + - ``Link:`` points to websites providing additional backgrounds or details,
> >> +   for example a document with a specification implemented by the patch.
> >
> > So this is a serious change from how Link: is used now, and runs counter
> > to the scripts used by a lot of maintainers.  I suspect that this thread
> > is only as short as it is because a lot of people haven't seen this yet;
> > it could be a hard change to sell.

I saw it, but decided to wait a bit for other input...

> Yeah, I'm aware of that. And to be honest: I don't have a strong
> interest in this, just think it might be the right thing to do. And I
> just got the impression that regzbot's dependence on the Link: tag for
> linking to regression reports is making the ambiguity of the tag worse.
> That lead to the thought: well, simply bring it up now and see what
> people think; if they don't like it, I can tell myself "well, I tried to
> improve it, but it was not welcomed" and sleep well at night. At least
> as long as my cat allows me to. :-)
>
> > Also, I think that documents like specs should be called out separately
> > in the changelog, with text saying what they actually are.
>
> I wonder a little if that is worth the trouble, but hey, why not, fine
> with me.
>
> >> + - ``Reviewed:`` ignore this, as maintainers add it when applying a patch, to
> >> +   make the commit point to the latest public review of the patch.
> >
> > Another question would be: what's the interplay between the (quite
> > similar) "Reviewed" and "Reviewed-by" tags (and the same for the report
> > tags).
>
> Hmmm, I liked the interplay for Reported/Reported-by, but yeah, for
> Reviewed/Reviewed-by I see the problem now.
>
> >  If there's a "Reviewed" do we still need "Reviewed-by"?  That
> > should be spelled out, whichever way is wanted.
>
> I didn't want to undermine or obsolete "Reviewed-by" at all. I sometimes
> wonder if this and "Tested-by" should be stored somewhere else (in "git
> notes" or something), so they can be extended after a change got
> committed -- but that's a whole different topic and something I'm even
> less interested in driving forward. :-D
>
> Maybe "Reviewed" was simply the wrong term. Maybe "Review:", "Posted:",
> or "MergeRequest:" would be better in general and avoid this problem.
>
> > I do worry that the similarity is going to lead to a certain amount of
> > confusion and use of the wrong tag.  People have a hard time getting all
> > the tags we have now right; adding more that look almost like the
> > existing ones seems like a recipe for trouble.
> >
> > For these reasons, I would be more inclined toward Konstantin's
> > suggestion of adding notes to the existing Link: tags.

Exactly. The power of the "Link" tag is that it can refer to a
variety of related content. I.e. the meaning is derived from the
link target, which can be an email discussion, a bug report, a bug
tracker page, ...

A proliferation of tags complicates life for patch authors and commit
analyzers. IMHO adding tags should only be done as a last resort, as
it doesn't come without a cost.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
