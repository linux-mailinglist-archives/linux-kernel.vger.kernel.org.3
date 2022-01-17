Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D297490C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbiAQQXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:23:04 -0500
Received: from mout.gmx.net ([212.227.17.21]:49275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237650AbiAQQXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642436574;
        bh=C/nNo/U1fHwsB5wUuT5IdsLvdaDiPnpuFRsb17zmLaY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BiA1MA4wynF+O+Vxx2Jdd5bajZOBcVShHWfh2xu+a2jBsKEy58fbFRlFLJ6hdutU5
         ZmkKBaDx8s/Pqq6RljVqD99XqXm/fWKJxPAA9cW2Ft+fBoJF4RE1brZOsI4zPJS29K
         MSkrZZdMH3UP7pCwIxiZiioDOi4e8Mv5UJwJgs6A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.167.237]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1mMSIC10K6-00x1kY; Mon, 17
 Jan 2022 17:22:54 +0100
Message-ID: <e19563aa-21a3-e13c-4143-847bd77a38c7@gmx.de>
Date:   Mon, 17 Jan 2022 17:21:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <YeG8ydoJNWWkGrTb@ls3530>
 <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de>
 <CAKMK7uHVHn9apB6YYbLSwu+adEB2Fqp4FM0z582zf4F-v3_GnQ@mail.gmail.com>
 <cf21018b-f231-7538-169e-2ad450643cbf@gmx.de>
 <97d49bca-f5f7-dba4-b62d-b6fcdd4276ac@suse.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <97d49bca-f5f7-dba4-b62d-b6fcdd4276ac@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/5TP4ksWG3pJ2c8vr5NltA1nVOpxlu0XprZKELpqA0IF76MmDq9
 cMNzSSwkf2zb3y1tjx6mIIpJ5VFxbLYDgQ1sj8wMsnwWy0HfkR5GElwZzBReIZcFPybuQpk
 Xr4WSHwtVFRjxQ9/g1oBKH8hsUqjaPDa6mJbGKwY6+JhCWGI+BonlHSuVKuQgTWm+e36ZuG
 eD4VYA8rmHx2ZVkjWpV+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cjpfNiUJtH0=:HdpF7/JuxlGGkFZaIer7yR
 DBUufryX0oB7eN8IdA5AVHbnWozyAUyuTbr/2HwgNELbH7icR3iKkxuUgmoXGe60/H9T/em41
 JZs1jcnT3Nk9GHnbDt7bzi5m6zedFUUogw+6+QHQka86ksse+o7uAbbhnQ+j750Z+0tBDOLWP
 RXh/QYNKwfA35i1Sa2kA5qAVGXtcbRhlem23tuuvSRrz0XeArsdkqheuSG5/KelGW8JxRnGyv
 eq1RQu62NtCbUAtLFKt6D1cslGptxs+d4ORwtGQyre0Bv7JRAJoStn/vxZNS3K7Ms5mPXwZLJ
 oHU02cYFCwUpPWx4KZ2qUxmJz3yoo/CLGBZjhkTwG0GjjH4mJeIDY6YRxnE8MAC8vYVng/DqT
 SKzfq7f0mazENoX/QOumTetynExnuYBKC+DdXVbgbFdzLgrSW/8NEhCejYjbvl0/U7Cbxr0WS
 odceWhNx3veLolUxWlE8XlfeavSAqMeKuCz1zffmCd8/8Iczo9UBMz3+49zoZIqKJZ4xTM7Qx
 0SEi2Hki3dKFh9oWTm5FYKSXjH4zRIi6B0p1WZFNiSNLQ2pwE5a4eDJpseMy7hRY5pv6eAlmc
 WLvoubEWoqDo/qoMZZe+H/As3tbps7w4sJ+DxucnYksTn9Z3zIL6/rmCmj6EMsCZZM7egUEaK
 b5ZcFtW4JhBoShFQdgIhBc0YeUgDyGO9j72xUfjbe2VM/7KCiYwb0/PUIn0AJPUCdCSayNPWg
 /Mg1ZbAwXqGZTiH/Pk9uHys5ZffovwRFX55fCaHKW7VrR8tejYp4GoT5kKOWMMyUYtruejLlj
 qiygTJkFlaGm+fbMm0qnbUk7MGnCy+KPRAKnghWZzdZoW6/Dwdoh3pxe2z1ZqMW262rnFNU1N
 hnI/0EjM/7dGK6iG2k6+ppDKyzWUsJuN3gZTVioiMV8tJRqKhfyP54Bh9v00KvWpC4277+g9H
 V9FruUmJRKDOtDwCmCyBhNXEYxDB2gtFFbuZc2OQXt1AGxsPFFaPdb6QlpcKQE1l6Qi1EwSSI
 Xy24vOHDZgu96aSbtH42LFn0UsSYMGI52cVNPQavVjFc4PraZt6xIItsvUlUZxttOlSmjnx32
 NSABtmS0/DS6hY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 16:58, Thomas Zimmermann wrote:
> Hi
>
> Am 17.01.22 um 16:42 schrieb Helge Deller:
>> [...]
>>>> c) reintroduce the state where fbcon is fast on fbdev. This is import=
ant for non-DRM machines,
>>>> =C2=A0=C2=A0=C2=A0 either when run on native hardware or in an emulat=
or.
>>>> d) not break DRM development
>>>>
>>>> Especially regarding c) I complained in [1] and got no feedback. I re=
ally would like to
>>>> understand where the actual problems were and what's necessary to fix=
 them.
>>>>
>>>> Helge
>>>>
>>>> [1] https://lore.kernel.org/r/feea8303-2b83-fc36-972c-4fc8ad723bde@gm=
x.de
>
> Seems like few people read linux-fbdev these days.
> I suggest to partly revert the patch to the point were performance
> gets better again.
Yes, *please*!
That would solve my biggest concern.

As far as I can see that's only 2 commits to be reverted:
b3ec8cdf457e - "fbdev: Garbage collect fbdev scrolling acceleration, part =
1 (from TODO list)"
39aead8373b3 - "fbcon: Disable accelerated scrolling"for-next-next

I think both were not related to any 0-day bug reports (but again, I might=
 be wrong).

Helge
