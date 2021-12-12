Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEE0471CB6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhLLThP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:37:15 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:34407 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhLLThO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:37:14 -0500
Received: by mail-ed1-f54.google.com with SMTP id x15so46581334edv.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUmORROTpVY9Hp7avDp6sVJ49Hh7LYXhiArgTChl2mU=;
        b=Vx+cEJpxZQQbYXnWtDzHq3itL/czDeMyIS669+jL4YAzydTndfFtwOlQiUzlfLZSj4
         6EvVcbemN69+VjK03DjDXppxwMaDL11jzmOL3BeNu9LUDrEj5a8oy49clfjJdlgJeDwc
         g1CbhGln/Q8cP8jKbC6QjnhxTLMWRRfby4q2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUmORROTpVY9Hp7avDp6sVJ49Hh7LYXhiArgTChl2mU=;
        b=NGoEjMSQEKSiJ6fcXLSVJl4/KyosEKUdnwnd3oI8H3a3kYpu7URbb/meUWE8t1t0cp
         f4qhlfLu2W5qC+qYmHFyVNQdL0lYWp0lXPMtfMrXkhbWZnTc7p+bsF/axVxR+KG1cT+R
         A5upKN8ZsUMVnppDz8kO7iRVuCfQbJM2I6o4s2p/qDukIBV3r7hdZMRm/5Zg8VSctyJa
         ShwgmlBGd/phy//TXHC6uMYocYf4/QwAPLSDN6gM5Q+LVeY/nKgDsRMWoK4g4Rv1fKtU
         qZlOCjXGGFiI7WAB5CgR9pFSWdaT02FEFdf3qpgNMH7Y/WACIrAWgYaRgZKl3A48c8Ee
         oNBQ==
X-Gm-Message-State: AOAM532EwWsB3fAdL7sv5ckzBkgzQviqnfTZFt1RtiQkib1GBh3KQQqy
        yq/0BqZJvPcMKmz6brrYL0ceYYplqfXyQkRM
X-Google-Smtp-Source: ABdhPJz7xSYD/S0amPhVR7JuoXN32ihMLPv6Q9W2mLpiZ+FCG+whG8gTxyq7VcEBfWYrtV3db6mzmg==
X-Received: by 2002:a17:907:6e8e:: with SMTP id sh14mr38248711ejc.536.1639337773506;
        Sun, 12 Dec 2021 11:36:13 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id hg19sm4721189ejc.1.2021.12.12.11.36.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 11:36:12 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id t9so23759352wrx.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:36:12 -0800 (PST)
X-Received: by 2002:a5d:4575:: with SMTP id a21mr28207048wrc.193.1639337772599;
 Sun, 12 Dec 2021 11:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20211211173447.4155374-1-hjl.tools@gmail.com> <CACVxJT-k664=aYp4VkG1LH3PsGHEf50PqP5EA+JWiFVb_JVs2Q@mail.gmail.com>
 <CAMe9rOqM+S_uBO-t5jJ1TLVD0R-LOJEiR6htb+k05c+ak7gF-g@mail.gmail.com>
 <CAHk-=wiEgwj3DGZai2GF9+z-FCSS455kGZ9z2g1qtdPLPWpvxQ@mail.gmail.com>
 <CAMe9rOqYxiMabie_2LN2mTTP7QPa0_mfKwDY10OSzKFj5GYT7A@mail.gmail.com>
 <CAHk-=whPK-aB34T1YS4CVK0G1m6QU7FZg28+oEeVaGy-b4hZGA@mail.gmail.com> <CAMe9rOoqkH=FL3s331YKeyz_Qjf7pR9M_Cf117XHErrTU-2iRA@mail.gmail.com>
In-Reply-To: <CAMe9rOoqkH=FL3s331YKeyz_Qjf7pR9M_Cf117XHErrTU-2iRA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Dec 2021 11:35:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKzE-+X7uZHELP-udnULXf75jog=UfO7GQ_gPXycELjw@mail.gmail.com>
Message-ID: <CAHk-=wiKzE-+X7uZHELP-udnULXf75jog=UfO7GQ_gPXycELjw@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: disallow zero entry point address
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Crossed emails ]

On Sun, Dec 12, 2021 at 11:30 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Linux, the start of the first PT_LOAD segment is the ELF
> header and the address 0 points to the ELF magic bytes which
> isn't a valid code sequence.

Yeah, then I think a much more valid argument (and patch) is _that_ argument.

So that kind of explanation, along with a patch more along the line of that

        if (elf_ex->e_entry < header_sizes)
                goto out;

I suggested, and not talking about paper standards that may or may not
be relevant.

That would be much more palatable to me - it's a _technical_ argument,
not a "some paper standard that we clearly have never followed"
argument.

                Linus
