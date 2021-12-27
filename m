Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37DB47F9C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 03:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbhL0C3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 21:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhL0C3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 21:29:05 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990C1C061401
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 18:29:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t18so29667477wrg.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 18:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bOhEvVozhHM6YldXriruHfBFw2hklkJ8aXUAF0+xVPg=;
        b=XoIoCzWCYSPvm4fY4M3T73vMITkswDgMyGplM+rbY6W6VkBBfPVdETLchyI2PCRrF0
         xbvSb/rgdUlEDXwDPcHcrOJ5Ob49nn81tZ/qnfjjH3tf0btwcV4Z3wIsyvqNiyAG6syh
         6OwGpi28YXtGyrkvuxqHEs5NFuM1nYrlAqhALE8XU24+1NqeT2WgiioMcASaTvF3k/EF
         9pHla7ja7tr0wIPCKUDiU9ICMOuLGzA0Em7b0B/0FoTGbdkPSGCPnHKiCCNRoY2eNqJ9
         Rp4wFGjLj7Up5L0Oo1ioaay6r6u1/K+k+WEYVSdR3svV8nKekHAazev9o/04eXai88lk
         6swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bOhEvVozhHM6YldXriruHfBFw2hklkJ8aXUAF0+xVPg=;
        b=V7EMXMSGOVvo/Bq2Z0CNK+GeHoDqmh0mPgFKIU49j5rO2nckJ1PmLL7jCiZVwIMfij
         R9j1En2pG05wNueEqFvTAhcgfKbhaB9tOD0Sou66CLiWYSmSLTUFBpVLyVFomtg+TwxK
         CPmDTEoG8KUFqGtBEo3YaOIHn42ES+ZVWDXtgWF34nUS11wOLeTZId/KxPwfmDFlgv8f
         e4Qd8229sT5mkLrZpwvQRx13AxqkyewqHS7DKoGnMDoL4YZH8eViwgviSIQt4Y3cM5wV
         1fgB3GcDgwBqhS5YyYfr6zTO14CMmjlfw51O5bneT+Iv6LypPpVgIl8Fa8Nj7VgyBhfU
         4Vgg==
X-Gm-Message-State: AOAM530FUcoGrrC/V7yWa68k3DUPSQg/s3xekom6T5ntcCJaYjgNRzf/
        iKHZzAcVB7B32zRjisUKU1RTdg==
X-Google-Smtp-Source: ABdhPJwqzX+wn7fueplWnROokfjMQchC3UHOG/zKLlnPZj61VkZ2EQle1lIluZZcEB73WdGst5H9xg==
X-Received: by 2002:a05:6000:15c4:: with SMTP id y4mr11112209wry.166.1640572143101;
        Sun, 26 Dec 2021 18:29:03 -0800 (PST)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id g5sm14158063wru.48.2021.12.26.18.29.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Dec 2021 18:29:02 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 00/13] riscv: compat: Add COMPAT mode support for rv64
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAJF2gTQ04utyOc9=q9Tu92togGuyygKgq3tWwfPBCuyTfLh2SQ@mail.gmail.com>
Date:   Mon, 27 Dec 2021 02:29:02 +0000
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?utf-8?B?IldlaSBXdSAo5ZC05LyfKSI=?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA7091EA-C3AF-47CE-B0C5-E2ECE4133D09@jrtc27.com>
References: <20211221163532.2636028-1-guoren@kernel.org>
 <CAK8P3a37+0=CCE7283VQ4QZ1tZqcU+A2POUGXtvdM46ZMHx-gw@mail.gmail.com>
 <CAJF2gTRAxX0qEcNmw+5N=3jZcJw9YF75oRjT7Y5FUMUkHoSz4Q@mail.gmail.com>
 <20211226162223.795f9417@xhacker>
 <CAJF2gTRHND1F_-5+Euzy-UdRRdg2oAXDY4dt8_5p9JxsHDSe6Q@mail.gmail.com>
 <CAK8P3a08kawHpz6RsLZsvNNn0_WKaFWRU-7M4fJ3e7i7J+GQcA@mail.gmail.com>
 <CAJF2gTQ04utyOc9=q9Tu92togGuyygKgq3tWwfPBCuyTfLh2SQ@mail.gmail.com>
To:     Guo Ren <guoren@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Dec 2021, at 01:16, Guo Ren <guoren@kernel.org> wrote:
>=20
> On Mon, Dec 27, 2021 at 4:31 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>=20
>> On Sun, Dec 26, 2021 at 7:38 AM Guo Ren <guoren@kernel.org> wrote:
>>> On Sun, Dec 26, 2021 at 4:36 PM Jisheng Zhang =
<jszhang3@mail.ustc.edu.cn> wrote:
>>>> On Wed, 22 Dec 2021 20:59:30 +0800 Guo Ren <guoren@kernel.org> =
wrote:
>>>>> On Wed, Dec 22, 2021 at 2:10 AM Arnd Bergmann <arnd@arndb.de> =
wrote:
>>>>=20
>>>> What about adding RV64 ILP32 support instead? This don't need HW =
side
>>>> modifications so can benefit all RV64.
>>>=20
>>> ILP32 is another topic in C Language Data Type Models and it =
couldn't
>>> replace the standard rv32 ecosystem.
>>> COMPAT is a common framework in Linux (7 arches have been =
supported),
>>> so let rv64 support COMPAT mode is considerable.
>>>=20
>>> Customers would choose ILP32 / RV32-compat by themself and that
>>> depends on which one has a better ecosystem.
>>=20
>> =46rom a kernel perspective, supporting both is not much more work =
than
>> supporting either of them. We had the same debate for Arm64, and =
ended
>> up never merging the ILP32 patches despite them being well written
>> and maintainable, to limit the number of supported user space ABIs
>> as well as the possible attack vectors when there is an exploitable
>> bug that is specific to an ABI.
>>=20
>> arm64 does support big-endian mode, which is a similar niche, but it
>> can't easily be removed after it's already supported. Supporting =
normal
>> compat mode is the easiest here because it doesn't add another user
>> space ABI, but I'd strongly recommend not to add any other ones.
>=20
> @Palmer Dabbelt How do you think about supporting ILP32 & COMPAT both
> in rv64? And let users vote by foot which is better.

As psABI TG co-chair I really do not want an ILP32 RV64 to exist if it
can at all be avoided. Every single attempt at an ILP32 ABI for a
64-bit architecture has failed to take off in the past, so I struggle
to see why RV64 will be any different. So, in my opinion, there is a
relatively high barrier to entry for it to be an official frozen ABI,
and without it being that I doubt upstreams will want to go near it, be
it Linux, GCC, binutils or GCC, but they can speak for themselves if
they feel otherwise.

Also, with every year that goes by, ILP32 becomes more and more limited
in what you can use it for, due to increased memory footprints...

Jess

