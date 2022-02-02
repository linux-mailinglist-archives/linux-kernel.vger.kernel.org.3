Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C3C4A6E76
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbiBBKNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245748AbiBBKNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:13:46 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A34FC061714;
        Wed,  2 Feb 2022 02:13:46 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r14so16887683qtt.5;
        Wed, 02 Feb 2022 02:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to;
        bh=OUQDWdBrmRMHaCVH7gTNItrsj6Vk034ija9DtfttVqg=;
        b=MH8AQKZq9VyI2fKWLUgOOyKvrkOd0Fhox9NZ5v1AHePVgZoHuGq5g5871nn/GVX0jP
         Lgo1itGDvyf/sGklT/Kadc7/q+DrF/FzybUe19X7LlHzCH7itWOVfRBD9U+K967QNmFS
         xl6Sd9lf3m793cN8JLhgkUvchH9gSXV1bSCoDiZaUcxrbmBv0LYbWPZA1ADF14tRLt5A
         g0ERBRyi1Q9pza2rgX/LHXAAym34l9EsNjQmIDryWCDIgoJxzTwogkQvCCQarMrsOdkh
         FD/rae1D5TPqEvhX8fxaFl6aD/ZUxES0QPOmdTqM41PaavIq7FRfPiVCsiSF6ElTrlD7
         xD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to;
        bh=OUQDWdBrmRMHaCVH7gTNItrsj6Vk034ija9DtfttVqg=;
        b=sR/G/kDTmy+IELl/htR8/VEe1ghYDvUZ0hsmvSb59nULKcBhZncGZ2bYQrcaYfiuw9
         mvImCNdxBGKfqdJE5YVkKhkhRFmmOGByg/g+qcui606MpeUVsHwz45EFFqhTir2FZ7mn
         bK/21ff3jixMNqGC3S1BcdPvi7qTQvmAFJSYMKfivswJPMPLrD7uQI2y0ra+iWEhsFfH
         s1WwgrOPzDs3l866wbN8Lyadugv9QsunZkCBCg8bogB9z+EMGWAQkLb1egAaZe1jGWkX
         58wFT71rpahRIdAST9XoguEVHbM3kqksRjD/kIf3/U9LJctbmIWz9aEGzq2lvW4V8iPw
         dVww==
X-Gm-Message-State: AOAM531UxWOW2Fv23BFeUccT5BMMz/uBvT/J0dM5CEBG2XDb+KW1xS1X
        QvLL37x78kwx2XL70WwRGoI=
X-Google-Smtp-Source: ABdhPJw6LtNb4i/skvqazZkJzPqIJgjsn9jdjDhjXOJb3YOKWrXqKvo0KQZBHE1KNZQH82cDNWc2+w==
X-Received: by 2002:a05:622a:1787:: with SMTP id s7mr8360563qtk.631.1643796825296;
        Wed, 02 Feb 2022 02:13:45 -0800 (PST)
Received: from [10.139.255.254] ([89.187.171.240])
        by smtp.gmail.com with ESMTPSA id s34sm11951741qtc.88.2022.02.02.02.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 02:13:44 -0800 (PST)
Message-ID: <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
Date:   Wed, 2 Feb 2022 05:13:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
 <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
 <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
From:   Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
In-Reply-To: <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZiXzIKd0kpSRxUbdCGDmwckI"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZiXzIKd0kpSRxUbdCGDmwckI
Content-Type: multipart/mixed; boundary="------------QHQfV1BNogFv7wPSzIrlnwVd";
 protected-headers="v1"
From: Demi Marie Obenour <demiobenour@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Message-ID: <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
 <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
 <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
In-Reply-To: <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>

--------------QHQfV1BNogFv7wPSzIrlnwVd
Content-Type: multipart/mixed; boundary="------------EC02RHxivlMIOiRF0FstpkPT"

--------------EC02RHxivlMIOiRF0FstpkPT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/1/22 12:26, Paul Moore wrote:
> On Sat, Jan 29, 2022 at 10:40 PM Demi Marie Obenour
> <demiobenour@gmail.com> wrote:
>> On 1/26/22 17:41, Paul Moore wrote:
>>> On Tue, Jan 25, 2022 at 5:50 PM Demi Marie Obenour
>>> <demiobenour@gmail.com> wrote:
>>>> On 1/25/22 17:27, Paul Moore wrote:
>>>>> On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
>>>>> <demiobenour@gmail.com> wrote:
>>>>>>
>>>>>> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SE=
Linux
>>>>>> always allows too.  Furthermore, a failed FIOCLEX could result in =
a file
>>>>>> descriptor being leaked to a process that should not have access t=
o it.
>>>>>>
>>>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
>>>>>> ---
>>>>>>  security/selinux/hooks.c | 5 +++++
>>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> I'm not convinced that these two ioctls should be exempt from SELin=
ux
>>>>> policy control, can you explain why allowing these ioctls with the
>>>>> file:ioctl permission is not sufficient for your use case?  Is it a=

>>>>> matter of granularity?
>>>>
>>>> FIOCLEX and FIONCLEX are applicable to *all* file descriptors, not j=
ust
>>>> files.  If I want to allow them with SELinux policy, I have to grant=

>>>> *:ioctl to all processes and use xperm rules to determine what ioctl=
s
>>>> are actually allowed.  That is incompatible with existing policies a=
nd
>>>> needs frequent maintenance when new ioctls are added.
>>>>
>>>> Furthermore, these ioctls do not allow one to do anything that canno=
t
>>>> already be done by fcntl(F_SETFD), and (unless I have missed somethi=
ng)
>>>> SELinux unconditionally allows that.  Therefore, blocking these ioct=
ls
>>>> does not improve security, but does risk breaking userspace programs=
=2E
>>>> The risk is especially great because in the absence of SELinux, I
>>>> believe FIOCLEX and FIONCLEX *will* always succeed, and userspace
>>>> programs may rely on this.  Worse, if a failure of FIOCLEX is ignore=
d,
>>>> a file descriptor can be leaked to a child process that should not h=
ave
>>>> access to it, but which SELinux allows access to.  Userspace
>>>> SELinux-naive sandboxes are one way this could happen.  Therefore,
>>>> blocking FIOCLEX may *create* a security issue, and it cannot solve =
one.
>>>
>>> I can see you are frustrated with my initial take on this, but please=

>>> understand that excluding an operation from the security policy is no=
t
>>> something to take lightly and needs discussion.  I've added the
>>> SELinux refpolicy list to this thread as I believe their input would
>>> be helpful here.
>>
>> Absolutely it is not something that should be taken lightly, though I
>> strongly believe it is correct in this case.  Is one of my assumptions=

>> mistaken?
>=20
> My concern is that there is a distro/admin somewhere which is relying
> on their SELinux policy enforcing access controls on these ioctls and
> removing these controls would cause them a regression.

I obviously do not have visibility into all systems, but I suspect that
nobody is actually relying on this.  Setting and clearing CLOEXEC via
fcntl is not subject to SELinux restrictions, so blocking FIOCLEX
and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD) is
blocked by seccomp or another LSM.  Clearing close-on-exec can also be
implemented with dup2(), and setting it can be implemented with dup3()
and F_DUPFD_CLOEXEC (which SELinux also allows).  In short, I believe
that unconditionally allowing FIOCLEX and FIONCLEX may fix real-world
problems, and that it is highly unlikely that anyone is relying on the
current behavior.

--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------EC02RHxivlMIOiRF0FstpkPT
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=3Dx+Ro
-----END PGP PUBLIC KEY BLOCK-----

--------------EC02RHxivlMIOiRF0FstpkPT--

--------------QHQfV1BNogFv7wPSzIrlnwVd--

--------------ZiXzIKd0kpSRxUbdCGDmwckI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmH6WVYACgkQsoi1X/+c
IsGtPw//SzjyzhX07m0Qk7mNNWZbnWGn+BUXaueVeLAhcildVmG94Op2vl52M7QE
mgcMkWXuDJeTufIWiddyRW9/ArsEYZbKhaBjDbRMMOPDdeabW1tdZ3mseBNCYY5d
KmEIoPxEA0h+BFaon0Kf3oYYtfalJJ5UmXFvVy/AomkLnfOmsuSfXvwf5ONx0GFw
2V9IK7KSTKHDV9SWXmj0/MRhmr/NigDEotebxw3lhgyMzBgz5WBgwBLtY7xEZO0t
909pu7yNl39Q71DGydRbM/9bbzprPPj10N89iX16q7IFYRQLpXOLPRS36qKH1Pni
tYLb249MIIReZcBm07gpt3MGeK8UoaAJavqAYRZbGHXLEf/Q/x+inwieLcgHzke4
pPXJmv21j+jZOBGXBJ0eqAqK6Sin9m53805lR6ZX1nal2uOaC3h6h9IuYeHItAKa
oX90iBh2ctfE0jCeIoUvvXtI5UPOFdKi1uzmkhWrTh23mawf+8iDw1Rr5P0Mgjo5
Q1Y7uojx13QztYzXi5YeZudyv0Eb/V6+mS94Ul5uFRccdAYYZpPL/e/zJBjTdb2J
6EjyRhmotlEcScm+zCRQ64Szxq9yOx3D9Ocza5BESBOI8UT2YiQlqprsMdVT7Trv
wtJ5hD5NnVvNA3cxgGGn/kGTpCsuIxNeKKrNPRAo2KhchqJcrUs=
=EiGM
-----END PGP SIGNATURE-----

--------------ZiXzIKd0kpSRxUbdCGDmwckI--
