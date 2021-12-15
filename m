Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8894764DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhLOVtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:49:42 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:57705 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhLOVtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:49:41 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MdeKd-1mOpV42v2n-00ZhgC; Wed, 15 Dec 2021 22:49:39 +0100
Received: by mail-wr1-f51.google.com with SMTP id t9so40561711wrx.7;
        Wed, 15 Dec 2021 13:49:39 -0800 (PST)
X-Gm-Message-State: AOAM5303tLyEPqp+DZ1578ZBUv0l3AaCo/05okCaN1m84A3lHkG1tIqw
        gK/D+e5EuNSxXoCwBGrO8BAOqfdEiWyFcr8Yzm4=
X-Google-Smtp-Source: ABdhPJyI4sFfqi3WV9r3gOmk1U//npIrS4nf8wBAkc7GviXMWmaD3dsHGyhZUXFZ+uysDsSwkLsuIqVlj3CoEC95hIQ=
X-Received: by 2002:a5d:530e:: with SMTP id e14mr6188596wrv.12.1639604979240;
 Wed, 15 Dec 2021 13:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
 <CAK8P3a2AnLJgGNBFvjUQqXd-Az9vjgE7yJQXGDwCav5E0btSsg@mail.gmail.com> <CA+zEjCtajRJhs8zSdR_oFBOO3P5FWWZJ3L6N-GK+JnUjdymTiA@mail.gmail.com>
In-Reply-To: <CA+zEjCtajRJhs8zSdR_oFBOO3P5FWWZJ3L6N-GK+JnUjdymTiA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Dec 2021 22:49:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3aJJYcONV9JMcn47=mW4P4kvYFdwnTdyZfRqeo+eGndQ@mail.gmail.com>
Message-ID: <CAK8P3a3aJJYcONV9JMcn47=mW4P4kvYFdwnTdyZfRqeo+eGndQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Cleanup after removal of configs
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Steve French <sfrench@samba.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cachefs@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-power@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Io+rAnOukRGsESnCj52tUXFsPjVCtRLppZBZmKntlAeVeXpSrHi
 qcxK9k04dshwgrWQYiw878XedRH47AsrLy4n/gdfxwlX7u2EYvjqUjIKEXIjY0tuCEb4D4b
 LwE4dKpbjXgggXVUh7oHMARa5sG2Nx8fzgjtBBQhJLpcxn/XzSdD2djB3j6dwZlyKw7hv1G
 drYUyPNFv42Qoql8UBrlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c07D+hGrL+w=:9x8C/icw8ntMTFqTZrSJrn
 6fyDDf4A/Q11iHr55nqwsGbPmkNrTebx43qkhrG1kKn+QweoG2MdgmEAMiSPsM0a18L18+Aur
 rWclUKaX1DLwnkMvBTMNEBclBZYir8NYTvXSxZkzrJqynEv8CDsIwVEO73ysx3dkU79TaUJqq
 ZGIEJjiEnuGE16rReyAdFECgxf6LmiGPDDLM/iBKdx9uO4BQGoXW18Cr/4+W/93SFzg8KuPCl
 4cO5C618BYZCT/TM34l2u/+7s0zYwWnnG5DneRm5zATDIaOpzQmASCntR1+q10bQ5shpFWfQ9
 349jAEyhYcUS51FiqkwWtW9U8nugU7PtrsLIOoJvF9O6RLHenDq4UhSZ+4wLl69agk/IGFwdY
 e1pmV61H6prVazhtH0IJav8Tq+SlZA9eEL9ciwmNKDoqBq2UMGDU6NsiVlBC5IBfmFFwwW6vp
 KnJgdSRkvw5StV8PRak8JngW4z38sMAssrPaLhMZnB58ohEI8vyai/WrofA3ZMAhqSXdUVHVW
 MA94AVgnaRrqkS4aBiCwQXpehyyIGYzmaYvHQ5t5Rmcze8cs9pcwXtBm5NMjHJ7zQZh/sjcvD
 3VDHt9JKKeJ+17u9vpzBc/CqU/JYO47NgWL88LV8n1MafnwPo9YqI9ttnCx66ln9cZui2m3f0
 bGWS9lZmArQRHp8q2TygJ//o8TTWVCEP5dbnuH3rBp3ln7RSib74/2lkOGLR1fuMQcLY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 9:38 PM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> On Fri, Nov 5, 2021 at 4:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, Nov 5, 2021 at 4:43 PM Alexandre Ghiti
> > <alexandre.ghiti@canonical.com> wrote:
> > >
> > > While bumping from 5.13 to 5.15, I found that a few deleted configs had
> > > left some pieces here and there: this patchset cleans that.
> > >
> > > Alexandre Ghiti (7):
> > >   Documentation, arch: Remove leftovers from fscache/cachefiles
> > >     histograms
> > >   Documentation, arch: Remove leftovers from raw device
> > >   Documentation, arch: Remove leftovers from CIFS_WEAK_PW_HASH
> > >   arch: Remove leftovers from mandatory file locking
> > >   Documentation, arch, fs: Remove leftovers from fscache object list
> > >   include: mfd: Remove leftovers from bd70528 watchdog
> > >   arch: Remove leftovers from prism54 wireless driver
> >
> > Looks all good to me, thanks a lot for the cleanup!
> >
> > For arch/arm/configs:
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > assuming this goes through someone else's tree. Let me know if you need me
> > to pick up the patches in the asm-generic tree for cross-architecture work.
>
> Arnd, do you mind taking the whole series except patch 6 ("include:
> mfd: Remove leftovers from bd70528 watchdog") as this will be handled
> separately. I can ask Jonathan for the doc patches if needed.

I tried to apply them, but only three of the patches applied cleanly. Can you
resend them based on v5.16-rc1?

        Arnd
