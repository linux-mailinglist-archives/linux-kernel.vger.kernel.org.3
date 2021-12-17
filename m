Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCCE4785E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhLQIFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:05:53 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:39047 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhLQIFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:05:53 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MWAaw-1n0sK51xAg-00XeeE; Fri, 17 Dec 2021 09:05:51 +0100
Received: by mail-wm1-f46.google.com with SMTP id z4-20020a1c7e04000000b0032fb900951eso3445568wmc.4;
        Fri, 17 Dec 2021 00:05:51 -0800 (PST)
X-Gm-Message-State: AOAM530UVPFTHLswgmMlvfOQdY3XtPQR7F+LlL/WvkZAGqwMu7efbnzw
        tcNlVOeg2iuCti4BmlPGBtBWWTtVfnNHpmBnmfY=
X-Google-Smtp-Source: ABdhPJy65SCV/45HP97WdNkIb8aOc/tC51kdFuMAYYfjjY+omPz7xCE5EUN4u430rKPc1GQNd/dsFVZ1zf74TMYWY0g=
X-Received: by 2002:a7b:c007:: with SMTP id c7mr8595362wmb.82.1639728351135;
 Fri, 17 Dec 2021 00:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20211217110720.21e8020b@canb.auug.org.au>
In-Reply-To: <20211217110720.21e8020b@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Dec 2021 09:05:35 +0100
X-Gmail-Original-Message-ID: <CAK8P3a09aESjUa6Fj9O+EvAfXKqoKwtUePf+Ujun0fLiDxUyxQ@mail.gmail.com>
Message-ID: <CAK8P3a09aESjUa6Fj9O+EvAfXKqoKwtUePf+Ujun0fLiDxUyxQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the fscache tree with the asm-generic tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:v9Pxe2VTMcCYRKYBvrgssU9eg8gqM2M7dyWpIekzxcE5amqgD03
 HGZn7dQ7o7wjqNlDTBjtM5XELt9vXSonxNQT+Pa3IkFjViwg3RA2OYTOnN8R2ZbPOfQTaOb
 KBlwlWAhTfV7X7aX6ItPE8aqAkniPmoD7UG9H8CqA9si2vFb8U/N1Oh3BpjdVb74MvuASQu
 z21hy8Zf/ovc/KH1mKbWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zQrd28kpvc4=:YCRUT/ROEQLcbC836Kqj4Y
 fr5qaDSv+C/rfrwx8+zI+klkF+8MGqnnOsHAiE4Tle+gwLhL+cgQGeys+pS+fuDQmCtEsBBKT
 3a8QqEFIOMtOoz6rlS0tv/ZLJxal2dr2CSOpvTUzeCrdMaXC6rkx1vFX20aKjVYrHNkN6dEy1
 CE4IUwGfiCCZLC0Wkz2NG89n0SNZqinjX7WVTwlmuCJGVcm79sui0UUfcSd5zEZuI51KFaole
 Z46pHORysE2xEVXilCLk27QFe4pZgn2Wn60UY6KQbmCSvOKV+0vFevju6Jq7RoYf7aRRtgnxt
 78XIaWSLW8vdqjSfYmZZWzLCAGWOPxf3t7hMNGcKQWn7ZKNYXC2w4NgHK/sBiBX4ty3lLOGJo
 Y6mr6Ry6osaTrGkkgoiE7J5NxUid8cfOOH5B6zAxTVxCqbuZwW6BcOxsQF58YOyL3o9WMbqp+
 PeABUDUylSBd1STTh0n+oIja+ZIL9My6LR0eK8cruij2VoMkcfyv/723hlfaxs30rOHdJ802e
 k+emdxc+zQVwjsbIexLVex8nhgh05ZCik39PwfqkmgQJ6gDk3rOr0qpIDKhD66WxYJNX7tD1g
 GzQNSRcUdb3HcSR3ok+MqTAQmsBdr91suNUJ9qbwxF77osGU7CkpcvAtAD8WU5N+5z3MeqAqV
 Ko9D1YTBC4uD7qOJywTgn9501wC+A8l6AFTxCIaQT0zS50PV7Woh71vIfP6rPKiCFXCCjUsfo
 KvVw+u2HZ8jqrY/9ngQ0c46NCrzamQDHNo/VqbX+N2IbWVDM+E+Arpcscvbw0S1Wj5ZlvQklM
 6EEpJ8Eubz8VmgVUe3q8w03dMcqS5ySNJIPAPvHo7CSUHcpS9g=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 1:07 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the fscache tree got a conflict in:
>
>   Documentation/filesystems/caching/fscache.rst
>
> between commits:
>
>   d881c06e0890 ("Documentation, arch: Remove leftovers from fscache/cachefiles histograms")
>   5c61c384095a ("Documentation, arch, fs: Remove leftovers from fscache object list")
>
> from the asm-generic tree and commit:
>
>   ac1c0f96f4c0 ("fscache: Rewrite documentation")
>
> from the fscache tree.
>
> I fixed it up (I just used the latter version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Hi Alexandre,

There are three conflicts between these two patches and the fscache tree,
which apparently has some of the same changes, plus more.

I would suggest I drop both of the above from the asm-generic tree, and
you rebase them on top of the latest fscache tree so David can pick up
whatever is left from your changes.

       Arnd
