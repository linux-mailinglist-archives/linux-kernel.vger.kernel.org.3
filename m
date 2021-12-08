Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D4646DEDC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 00:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhLHXLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 18:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLHXLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 18:11:07 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7CEC061746;
        Wed,  8 Dec 2021 15:07:35 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id m9so4715230iop.0;
        Wed, 08 Dec 2021 15:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GvxS1qroTD61QT/EFi3iPjXiqfPMtu/AfLzP0j5oWl8=;
        b=A716lHua5S8Q0I6LxK8EbL72dqrwmaFOaGZWKh8i2V6ZCefvzwrlTpqmZbofBkji3o
         eTcY11faHhDvzaWnlyJPjD7MAItParYA6jFITwEW1GmuBNmQpivoeP+lvJXzQFzoRt4o
         KrRJYahvYIy5j7BOUkX/gYL9MMLme5cBDW81kzuBpbmOLzqNYjLQEj7lfLjINBTl62tu
         6LKR4U7ia3Uft+usQCy2zYjuO84q0t57aRNsJGok6UcRGOFTAq8e022/6KwyGFU2QJ0w
         XRDya9VZc8Wt9YttyS8IJyQLAL9LeHUiAnj73F7pRVE9OPVsxiUNFKczmtlJ85+QhuBd
         +20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GvxS1qroTD61QT/EFi3iPjXiqfPMtu/AfLzP0j5oWl8=;
        b=0r/oyFZmwd46PgC/k+pk3QFzxDVuUmqv6gfWtQc4FbQ/LrCEKSpgHOIG7bPo21LoEI
         Z+WybU/tv6ZCw9A8SgHf5IeXvjVITAFV1iyoZYltsCE4pwNHWjxF6VqKfyPizQQK7LzR
         syeiSCGijbFObQSght9SFNX3CAvUPR38vChkaTzNAmflEfL+77eJXQpoBvF8yxqfKJlF
         LzPmLVJtH750Dm9DiUcQFtnBVO59YlV2BqRV/MO+fIA9AJjBMU1ugIDqY6JzCYEiuhmn
         lxMEEXMGbxWeGvD1BGGMIgOe8zie/5uVU0bhVoHbfNLx4KiEcQ6TXu4kwmOhEMw/vVDE
         8Flw==
X-Gm-Message-State: AOAM530W2QdisLTdEge3nn2PAYxMyJCT9/sblgcX6TIJBnXEgB+I7VWC
        97dRcgLGiKRw1DmMNE6IFwzfYz1Tf2x+UOr2VD4=
X-Google-Smtp-Source: ABdhPJy5PjPkLmDXdBa8v9cvnb0J8BYP4vtPofj3T3hO/HPtklP9pPvbbe0+0XmfCKfw0H5ANish9+gJVfHa7ILR6mI=
X-Received: by 2002:a02:c78e:: with SMTP id n14mr3798423jao.40.1639004854486;
 Wed, 08 Dec 2021 15:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20211206140313.5653-1-ojeda@kernel.org> <20211206140313.5653-15-ojeda@kernel.org>
 <CAKwvOdnA+XU9u+dJ6NfmVFDTxdkCH4v04nMVaieuzauWZtBUpw@mail.gmail.com>
In-Reply-To: <CAKwvOdnA+XU9u+dJ6NfmVFDTxdkCH4v04nMVaieuzauWZtBUpw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 9 Dec 2021 00:07:24 +0100
Message-ID: <CANiq72n1DehytS+n2_RbJf0uAROTD2c48voDWVGEWPaPr_V4qQ@mail.gmail.com>
Subject: Re: [PATCH 14/19] docs: add Rust documentation
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wu XiangCheng <bobwxc@email.cn>, Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Yuki Okushi <jtitor@2k36.org>, Wei Liu <wei.liu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 2:30 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> I'm sure Documentation/rust/ will grow over time; there's certainly
> more that can be added and core kernel devs will have more questions

Indeed -- the comment is only trying to emphasize (or explain) that
this might be a difference with respect to C, i.e. that we should try
to put as much of the documentation as possible closer to the code,
rather than create "far" files in `Documentation/rust`. I will try to
clarify the comment.

> But I read through all that was added here and didn't find anything
> problematic IMO.  I didn't verify the png's are actually the logo...

Thanks for reading through all of it!

> I don't think `make htmldocs` produced any new warnings, though it's
> not exactly warning free at the moment (pre-existing before this
> series).

Yeah, I also run `make htmldocs` before submitting the patch series
rounds. And indeed, there are quite a few warnings (20+?), but none
coming from `Documentation/rust` that I could see.

> How is rust-logo.png being included in the docs? Is there something
> with RST that isn't grep'able for rust-logo.png?

At the moment, the assets are simply copied to the output folder, in
the `rust/Makefile`. (I should provide an SVG too or remove the
reference to it, by the way).

Cheers,
Miguel
