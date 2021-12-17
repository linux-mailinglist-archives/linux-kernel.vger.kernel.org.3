Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD3A478BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbhLQNJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:09:51 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:37793 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbhLQNJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:09:49 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MKt3r-1nCq863kJJ-00LH3c; Fri, 17 Dec 2021 14:09:47 +0100
Received: by mail-wm1-f51.google.com with SMTP id p18so1549578wmq.5;
        Fri, 17 Dec 2021 05:09:47 -0800 (PST)
X-Gm-Message-State: AOAM532Q3TgVP8Hm9bfs7rnlBao8UUC8lgXgmRMhg68dB30Ki/qLf9Mx
        Dgc7Z8pvhsD4uGq1A9LByYyxf4hAdEi+f0mqlso=
X-Google-Smtp-Source: ABdhPJz7G1Jphi5B+WPZUUBROjJfTQT5bMgaRQTtBbW6svcijGRnk/NTqL4833WgkZbH4dijpWWNsIR992CZFrm3sB8=
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr2709166wmn.98.1639746587350;
 Fri, 17 Dec 2021 05:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20211216094426.2083802-1-alexandre.ghiti@canonical.com>
 <20211216094426.2083802-6-alexandre.ghiti@canonical.com> <1956456.1639746081@warthog.procyon.org.uk>
In-Reply-To: <1956456.1639746081@warthog.procyon.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Dec 2021 14:09:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1M-kDqe0uwzyfUiErOavoEi3bVpy4m4BPbBXQr6JrHdw@mail.gmail.com>
Message-ID: <CAK8P3a1M-kDqe0uwzyfUiErOavoEi3bVpy4m4BPbBXQr6JrHdw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] Documentation, arch, fs: Remove leftovers from
 fscache object list
To:     David Howells <dhowells@redhat.com>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Steve French <sfrench@samba.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeff Layton <jlayton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hLxcLGJobju1Hy8o/4lalmO21mxrA/gxXSLx1+T+8tRx09fRKR2
 kZSLHoQ7vwqmWXkWZUtGybzIbvtXcwWRK7RfmkdE7bS3c0OTJh+iJUF7P05+9KfxMasilqv
 BCTj0ePnXc4M/3VDcHI3ZwM5ccl7OgKjUkULNuC0g5dkDmTOX0+ZgBT/CKj8oUgBBaJj2e4
 1g9zSlYYH7DpvM2iXdpsQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2PZaWxpMsa4=:A3gCyZo3oFOL7En6B4sCju
 jyk7WAOL88OO5k13jwzXV+bAh1Oya0qRARReutgSW/6dWu/3lKqc/pwYIUBuAgPqErM0GAfMO
 z/FG0fiqLUe+3hTm2Fi5d1HXkByYl866t0ByFKB2EdxhWj+CAyqgw8U+OBMv0TaKt5QhMSThX
 OObETgmklFI+6AZgio+onY2v7SmJhbR7h56RfT49Ne5QT8po75XQ80U3JEWZk/p7ihs/t7nvz
 CtvvEvXRHq6ttwG+Hb2lmdy2i0ur7idobdid+Vk9gBIjHoajw+t4BC5UnZFOQ69WfXx18dJcg
 J2/shj55SgNMz5yWlcGC2MFw8PawgXuB4QWJSH4DEI5TJvgs8Hlrx9HvYbVFE4v9ifiNE7Ta+
 aI/pLqyocw2vn5XP1ieLZnHFBwzjsyGvmYAQ/Yc2mzF7mLxGEjFuOT6IG+qYLSAioPZblqeNc
 qlMypxs+6tUJH2u+8WzlnnkcavtKeNfJ456Kyla0swuAeb9hfBPXa3q++9ambCLIX0NwoTLw4
 5tBREScyY2C97z2LJx1DKQ9mbCkBXVyKOZocdnHtRlhDK3ah6l5DLiFRUJeY5JYOFrI+BLogP
 BdnWPLk3OFI08oVsmH1MdJPOetN1DOCEnFxUkiGyoaaHN4swQktM0hZWuSpdvxjK2V8PL/+/T
 HJOqxGP+DWNEjL4Mh/E/n+p2YE3pSBbyaIRLmlnecrTKH9J5fYrby2kNHQA5izEKB6Xo23poD
 41DN2pzbQ4Pk1fL/O13wCxKgTDALpl6Nv0yc5TwQCuJQbalgyEtmoWVHzmA12p2j3AchHjGRE
 Fn+nHLnTEgjor+3Txt8DMZlXUJtk3lgRvXIETt6JuBKjlzF+kg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 2:01 PM David Howells <dhowells@redhat.com> wrote:
>
> Hi Alexandre,
>
> >  Documentation/filesystems/caching/fscache.rst | 89 -------------------
> > ...
> >  fs/fscache/object.c                           |  3 -
> >  fs/fscache/proc.c                             | 12 ---
>
> Can you please drop all of the fscache bits?  They're dealt with by my
> fscache-rewrite patchset that I'm proposing for the next merge window[1].

I've dropped them both from the asm-generic tree.

       Arnd
