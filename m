Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108B546A67D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348774AbhLFUF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245711AbhLFUF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:05:57 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2A4C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 12:02:28 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id k37so28152116lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 12:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MV8pLjJcbpCes0pPCBGkkCU9j3+hlAKLtwDB7sdc260=;
        b=sCGw2x5S42H1flR6yrgcbJpyVrLbZUlciC9ASPGwv3wYl3856XM/1BT/dlnIOOipX0
         /Wk9opckSY26KJkY9ZtMGmJr8inxYkxXVBzcsiqKcjXyX4lhaWz4QnbEEUu1pka4vIwy
         pcjb5bITAc3PFc8s0rtAG7kIaLA0rY3drMijWI8B62v3+7KeR9uX4ExME7ytmC9M0aYG
         dj59o5pKJfO8MMfd20UY11q5+nuc1zRTTHv9YecvUKWvrnz9elLYcrHKhqWTgsaNG1u6
         rrFWo51ilAqPhd8qX/BDvckrV4CzujP0/WMk8S2XukyU0KqDLMv7YoauNnc4oI3By9AB
         rnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MV8pLjJcbpCes0pPCBGkkCU9j3+hlAKLtwDB7sdc260=;
        b=sWNrARRTqXEx+N1VV1JFD/CH/qhfzVyJilN0CnMS7DgyTRP4nsfh8mu1bm0LuGUpOC
         WaTjt8G1NNBt7PfPB1BSeIzm912bivJbfL79EuQwYpUplnJKQV9lAB+lH/PTHAThQC+4
         Ah+826RQQiwPZ89vbAuvrii6ElAdA0WiH20vq4uKKPQgKmPSMIGsNWDQijeoE5dbaLhI
         sYCl8HJmAomYycj+s1ANKJp0YjUKLhUZAmrtwN4qzO7+GJymKCrJAYaQn3BR3U3Rm+O5
         SZeBW7kAHLU0zMBzi3xXq/qs9RIODPlAS6fEaIOCiH+mhejmDAfEIJDM+Hbcu2JJKvDn
         h2+w==
X-Gm-Message-State: AOAM531FJLTxKuQkn6D9HU5RtB+Fd2XStHLDg3xbhbSDpIyDj7KD5Ztk
        LyE8OSQfjXrZnm9NHtZZ/ZdyrCJqzBSGhXut7qZwGw==
X-Google-Smtp-Source: ABdhPJxJDec6abMrza4P+4CkbJYlI0Co3O5gNnso2xGk+rWgq2NQ2ix/cTg0La8jfc1KUCsLK5zNdfA/opdTXeGwa/w=
X-Received: by 2002:ac2:4d19:: with SMTP id r25mr35689585lfi.82.1638820945720;
 Mon, 06 Dec 2021 12:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20211206140313.5653-1-ojeda@kernel.org> <20211206140313.5653-12-ojeda@kernel.org>
 <Ya4mAqoOa8zIeZGZ@kroah.com> <CANiq72kCmLgrv++mFygR6dt0xOhfv04o9j6jYLQ1N+zLNvqohQ@mail.gmail.com>
 <Ya40Bcv+eFkqc9jv@kroah.com> <CAKwvOdkLF_DPP1FF60720q3zxZG2qaSNTthxJPxLb4Bj=AFE=Q@mail.gmail.com>
 <Ya5qrjabKMM6sPr+@casper.infradead.org>
In-Reply-To: <Ya5qrjabKMM6sPr+@casper.infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Dec 2021 12:02:14 -0800
Message-ID: <CAKwvOdnSSkRO0n8-Bz_ACcqsoctyv4MkALG1n75p4rQoNfrMuQ@mail.gmail.com>
Subject: Re: [PATCH 11/19] vsprintf: add new `%pA` format specifier
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 11:55 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Dec 06, 2021 at 11:52:09AM -0800, Nick Desaulniers wrote:
> > On Mon, Dec 6, 2021 at 8:14 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Dec 06, 2021 at 04:56:32PM +0100, Miguel Ojeda wrote:
> > > > On Mon, Dec 6, 2021 at 4:46 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > That should be in a .h file somewhere.  Remember, don't put #ifdef in .c
> > > > > files please.
> >
> > Why not put #ifdef in .c files?
> >
> > > > Will do, thanks for reviewing!
> > > >
> > > > > Same here, this should not be needed if you put it in a .h file
> > > > > correctly.
> >
> > I guess IS_ENABLED could be used in the .c code, but I don't see how
> > they could move the dispatch to rust_fmt_argument to a header without
> > moving the definition of pointer() to a header, which they probably
> > _cant_ do because it's noinline_for_stack.
>
> In the header file, you put:
>
> #ifdef CONFIG_FOO
> int foo(void);
> #else
> static inline int foo(void) { }
> #endif
>
> and then in your .c file, you call foo() unconditionally, and everything
> works beautifully.
>

Ah, that is nice, thanks!

-- 
Thanks,
~Nick Desaulniers
