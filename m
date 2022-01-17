Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D62F4904EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiAQJaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:30:09 -0500
Received: from mout.gmx.net ([212.227.17.22]:55019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235754AbiAQJaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642411797;
        bh=GDRi6PlDojShJJ7+VpCOWmzUNyc4yYA4SNWwW6pbR9M=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RXKsvyIi9CIUQoyPCxWawUG4AWz93YxykTxZhyxFs31hShCQKwtKWmnfSYkfYyHyn
         s/xd1T78M4dpt5dUWOjAbC/VIzYRlL0Xmzi+T2OX9NbyTFBFIFEeGCovjjPMb+nuRo
         mkKp0610AwyWfkyXU+yen92m2K+SXovvpr0lCWv4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.167.237]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6R1-1mabTy1yVP-00aA0v; Mon, 17
 Jan 2022 10:29:57 +0100
Message-ID: <07123931-39d8-42b9-6d2f-b9fde89675bf@gmx.de>
Date:   Mon, 17 Jan 2022 10:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [GIT PULL] fbdev updates for v5.17-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <YeRyfaesC2kxkgZC@ls3530>
 <CAHk-=whE5gmEKLt+rtEn2MV=BN8p+QTU56VaPdSD_kmxkx7smQ@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAHk-=whE5gmEKLt+rtEn2MV=BN8p+QTU56VaPdSD_kmxkx7smQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iDjATMD3E2Ic3kJmHBjTt6VE54vxdd/QNdoIVuvd0BKRTIFZJRv
 tyb9QwhtQsEFB8C/jtigqGz3jk6j/AQOwGGDqGIwnHjthaO9NGbZWdgnTwwSS4WN3+vgemi
 h5iXQXVN25X0HDf+Pi/nLnRhBZS5Gp+ZJSUETz1uaQlaam7aFAE80lhGl5f+AAVdumWpDmI
 3YczbMIr/djPnPx+SGxFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u2jqbMnErjg=:Hx8AIAecmEsMcircfABNz5
 NVWekfhgewEJiVahygG0ywsPCtOZCpz5zNlYvpMDeCDVbXkSWzL2jkOh91L4Eyix2PKjLjGic
 mH0UJ9tg8INdkf5CRpqx6Nsajsd5wwcbiVoc29N32pFUSSoBFu97N4omsBVBiAdPF6Z9GaA5i
 CA+el4w0l4IQfkbNHhSwH1T8r287tNZFfvyeKPHGFKA8KDuT4oIiNShINrtYf37XjDINa0J9c
 XXFSBXaF9PDus0YwcvUBRxZVf7WGkN0HK2feNGKlYwOZk430YZ7e5irBBWt+ZCY/ao8wwcJkv
 /mC+7fVw69xHt0ZU54GP7Jxi1jpul0F5OMGxjN5iKebOcdEy50ccw9gqXvEG4+aY0qScKUsVf
 ZiPY7qlchj8IEWkFqXWsSBuECJmIVHfxzwHOXwbM03VpZ18ASWsfsoCmbFD2Pzn4qwBi+1Bld
 4jSxoDgp4eelS5mp6XbIxkWXZHdGkTPUvEaU4yl5LjyaBvDzF73YKjA/d1fVUNOatwz3a9UMg
 8m3tKXIPDLc98F2MAyvnTyyrUurd8+Asy0Q4i3bPq+1dTVByq3q743aRhBL0wGh5hWpda/hov
 bNCU2h4nlNVrpSCYx7xiX7IpOoldAsgQdzUEAZ3e/iN5AokVfXHp/wsIPQrwkS1+vSUmHtkE8
 eGY3DD8rS/sVixiZKFz/BRiljRzPtPNl4CKOYsp4tUSdk/jioG5kJnZ0bGPkx2ybp/Ovl9a7n
 XbyMYhHtYywSM3kESk4rRDwFaeVDdYpqJ/JHmv9I123QSfKLbCHnZBopN318aRkwVLdJkUWV3
 2fcTXvDElZxWCwyEZcDLQqHNsEBsIoIb72ZDI/nbXb0/EPrN3wcnahlQ2KGCKMYPtCWaFfCm9
 DuPnDfDuuYntlCcOFcLnJ/W4jcuFEwS/ROJVwhOnQ4f+Q7ACGc4+sxPyfTWm7ky+fZGdSmg+N
 Pw3pNUdxfsVPnAHERpmaYuQxL/MCSXFDlsGbBlmMIQ6rbqdJSS4DocGtUst8KxDWtGsleVTY+
 NwFDGpdEDuz/U2qLptVVuRzL95y7Z3KH/0SwsGHhY9iugsjRjz1yUPSe/kKh6cyy3tijsFl/d
 YY4+IEM+E7dx2w=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 05:33, Linus Torvalds wrote:
> On Sun, Jan 16, 2022 at 9:32 PM Helge Deller <deller@gmx.de> wrote:
>>
>> This pull request contains only one single initial patch which adds
>> myself to the MAINTAINERS file for the FRAMBUFFER LAYER.
>
> I'll pull this

Thanks!

> (as my test builds for other things complete), but this
> is just a note to say that this pull request email was marked as spam
> for me, with gmail saying something along the lines of "lots of emails
> from gmx.de have been marked as spam"

GMX is the biggest (free-) email provider in Germany. I'm sure their
mailboxes get heavily attacked by spammers, and others may try to use them
for spamming.

> I see nothing odd in the email itself, and it has proper SPF and DKIM,
> but it's possible that you end up sharing a subnet (or an ISP) with
> spammers...

No, I'm on a dial-up DSL line and send/get my mails via smtp/imap over the=
 official
GMX mail servers. So, it's strange that gmail suddenly thinks it's spam.

> Or maybe it was a random one-off. We'll see. I check spam filters
> enough that I _usually_ tend to catch these things.

Great.
If it happens again I can switch to my kernel.org account instead...

Helge
