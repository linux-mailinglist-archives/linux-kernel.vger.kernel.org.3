Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF80449031F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbiAQHra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237671AbiAQHr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:47:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09EBC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:47:27 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b13so62059114edn.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KxaKd126ds9B/hqHoJr3I0DdwvzQ+yakIqTbnoGSuO8=;
        b=RGXdV4HyYc3xaX2rdnh+hAKPvPMFKV81qHTYLnM9kE6m4ww5iFzzJhvkM+GlTCXgm4
         ZokwaT+e53zJt/1DXVTyJxkad79H3Eh05BUmTyYG8YMTO182roVXLBbdNIAzvTxe8TWX
         8mdvIHdvuFPgQbda+EO/U/kRqlj5jS7Vae7u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KxaKd126ds9B/hqHoJr3I0DdwvzQ+yakIqTbnoGSuO8=;
        b=hv+olE2cplLOFFqbGGPBsLDwYkLpqX7wcXJV8Xa30h+zv6Ln4DPJcfNgqTJryic37V
         6GaxM8nj8V4TPW5yoNiKZNzLrxWDQ4xPrJgVIvt64Y6y5BQg/QSfrCvyS1SegYKEw8wo
         3Ts5n9gr7LfmEjRfpCkRQ71zfcaEICNHvjsbs42CXkpjGam9U85lkpljP7Rk2PUCuW+o
         ciSwnXkuku4T58JuoqAGSLl6un8GCrgsZYUce6eWggdBn1aJdeN3KLDlshlQGLYzFjqd
         uHiAuwEhrQrG0Tue/MrUpIxHEvqoSYcGZD/4q965tj4YFCWO80qu+BpK+wB6fK1d7BH/
         OqUQ==
X-Gm-Message-State: AOAM530racyFEbngVn8MbfzSko5Nt2/ixS6Ug+LuzJOI0MiUkbhmyJV6
        xvpm8qEnTY8zrp7j4rLLDWnXzmYikGhKQ/5X
X-Google-Smtp-Source: ABdhPJwJLorDGX9xj2Xrs3KdXXbvJeElDWHM4dJ7iXMN7BRMFZChEKLyH1AoujGAIaGXZvuNWvK56w==
X-Received: by 2002:a50:da48:: with SMTP id a8mr19115089edk.146.1642405646296;
        Sun, 16 Jan 2022 23:47:26 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id j5sm4164432ejo.177.2022.01.16.23.47.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 23:47:24 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso20593678wmd.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:47:24 -0800 (PST)
X-Received: by 2002:a05:6000:1787:: with SMTP id e7mr4294373wrg.281.1642405644098;
 Sun, 16 Jan 2022 23:47:24 -0800 (PST)
MIME-Version: 1.0
References: <163935794678.22433.16837658353666486857@noble.neil.brown.name>
 <20211213125906.ngqbjsywxwibvcuq@wittgenstein> <YbexPXpuI8RdOb8q@technoir>
 <20211214101207.6yyp7x7hj2nmrmvi@wittgenstein> <Ybik5dWF2w06JQM6@technoir>
 <20211214141824.fvmtwvp57pqg7ost@wittgenstein> <164237084692.24166.3761469608708322913@noble.neil.brown.name>
In-Reply-To: <164237084692.24166.3761469608708322913@noble.neil.brown.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jan 2022 09:47:08 +0200
X-Gmail-Original-Message-ID: <CAHk-=wiLi2_JJ1+VnhZ3aWr_cag7rVxbhpf6zKVrOuRHMsfQ4Q@mail.gmail.com>
Message-ID: <CAHk-=wiLi2_JJ1+VnhZ3aWr_cag7rVxbhpf6zKVrOuRHMsfQ4Q@mail.gmail.com>
Subject: Re: [PATCH - resend] devtmpfs regression fix: reconfigure on each mount
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anthony Iliopoulos <ailiop@suse.com>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 12:07 AM NeilBrown <neilb@suse.de> wrote:
>
> Since that was changed, the mount options used for devtmpfs are ignored.
> This is a regression which affect systemd - which mounts devtmpfs
> with "-o mode=755,size=4m,nr_inodes=1m".

Hmm, I've applied this, but I'd have loved to see what the actual
symptoms of the problem were. Particularly since it's apparently been
broken for 18 months with this being the first I hear of it.

Yes, yes, I could (and did) search for this on the mailing lists, and
found the discussion and more information, but I think that info
should have been in the commit message rather than me having to go
look for it just to see the clarifications..

                Linus
