Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450294AC6EC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343985AbiBGRLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383810AbiBGRJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:09:18 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88FCC0401D3;
        Mon,  7 Feb 2022 09:09:16 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b35so11470933qkp.6;
        Mon, 07 Feb 2022 09:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to;
        bh=kWOvFOcta6s/ThhrB+/iDoU+7ixxmXe2AY2MFwSeUSk=;
        b=kKI7nFyBYOVdMcrQ5dLgDdjv4+ov1wC1/16kw7w/2bP3pXwMyiJ24ocSZ81Sh55Ct9
         gFWNWzPKQqnrSCFXz97g41lzPmP2FT7awvXY2G7oYV8mk6GwbxkkIhDBzs90xu4AjpTg
         I/g1I6TlmV68OOL0fFQ47rLSAvXC7TrSIf2tJLU5Cf7K/iA90SxMqgPOxk/uY3O8Vh49
         aHBIR6QKBTT1Lnoz1MfN2uicAdzbgQo5jv8cbyBjNsq/BDLduVD0xJqNiiXwsWTWJ2W6
         K01lS7WX6ZQ+9wIG8SwLD77KANLjmtafCATrtsAc2B1nYkuz6GquSZCeS8exq7C662rv
         CjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to;
        bh=kWOvFOcta6s/ThhrB+/iDoU+7ixxmXe2AY2MFwSeUSk=;
        b=W5unRZe7QXC3GXsMNfwgMpDwUCICHXJnlvv8YMbfHATJ+pwtlLNqmziy4QjlGjKByb
         a06c4Ab9WJOD8ReZmIr3oimePM56d96krc6PJeXDfO2kvUKt8bOJQbK1a6IZRwasemJV
         CVSqNgLz/znmMs78/w/RpLx0c97Bsg5PmJJu5cbMpd8JYQiMpBMoXjq2L4P8vZy6dcdL
         MbsnScsqjl6EMbe+mVHT6xo/f4lt9K/UkXDl8l9EgtNkp4ZaNpBslt8unF27h644tC4a
         +oY4zHvODEDYoQZ9U+BXfIv2E+/KsE7TAWUccW+X761O9nT/TlNtQgM9HH/8WxBRO9TA
         UqJw==
X-Gm-Message-State: AOAM533L3v5Cg52f4hXCd7wsVONM8mPCaZN1hqHA8lFX/5qalNQcvGM7
        IX65X5ObHK5ior4kGGCsIEA=
X-Google-Smtp-Source: ABdhPJwvRnRK2Ck1tzTdTfyL3MeyGelPxogtMSejAFhARG06w5gQaRkEHzFBWIGoYfafIVj6sjreqw==
X-Received: by 2002:a05:620a:2910:: with SMTP id m16mr470509qkp.428.1644253755841;
        Mon, 07 Feb 2022 09:09:15 -0800 (PST)
Received: from [10.139.255.254] ([89.187.171.240])
        by smtp.gmail.com with ESMTPSA id i20sm6038089qtx.44.2022.02.07.09.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 09:09:15 -0800 (PST)
Message-ID: <7798e61c-eb22-7b19-0849-35e5bfccad8b@gmail.com>
Date:   Mon, 7 Feb 2022 12:08:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     William Roberts <bill.c.roberts@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
 <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
 <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
 <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
 <CAFftDdpxmf4R9zPVGUUCFinST_2t8iW2SAJYG4e=3JeWtDowJw@mail.gmail.com>
From:   Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
In-Reply-To: <CAFftDdpxmf4R9zPVGUUCFinST_2t8iW2SAJYG4e=3JeWtDowJw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------L0WD2LNmC0BrNzDEbY75REh0"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------L0WD2LNmC0BrNzDEbY75REh0
Content-Type: multipart/mixed; boundary="------------kc1QEfjzunVwjnPUGEpOsvrJ";
 protected-headers="v1"
From: Demi Marie Obenour <demiobenour@gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>,
 Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, SElinux list <selinux@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 selinux-refpolicy@vger.kernel.org
Message-ID: <7798e61c-eb22-7b19-0849-35e5bfccad8b@gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
 <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
 <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
 <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
 <CAFftDdpxmf4R9zPVGUUCFinST_2t8iW2SAJYG4e=3JeWtDowJw@mail.gmail.com>
In-Reply-To: <CAFftDdpxmf4R9zPVGUUCFinST_2t8iW2SAJYG4e=3JeWtDowJw@mail.gmail.com>

--------------kc1QEfjzunVwjnPUGEpOsvrJ
Content-Type: multipart/mixed; boundary="------------7X0xDt0f3IuSXhdKw7zH4Uvs"

--------------7X0xDt0f3IuSXhdKw7zH4Uvs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/7/22 12:00, William Roberts wrote:
> On Mon, Feb 7, 2022 at 9:08 AM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Wed, Feb 2, 2022 at 5:13 AM Demi Marie Obenour <demiobenour@gmail.c=
om> wrote:
>>> On 2/1/22 12:26, Paul Moore wrote:
>>>> On Sat, Jan 29, 2022 at 10:40 PM Demi Marie Obenour
>>>> <demiobenour@gmail.com> wrote:
>>>>> On 1/26/22 17:41, Paul Moore wrote:
>>>>>> On Tue, Jan 25, 2022 at 5:50 PM Demi Marie Obenour
>>>>>> <demiobenour@gmail.com> wrote:
>>>>>>> On 1/25/22 17:27, Paul Moore wrote:
>>>>>>>> On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
>>>>>>>> <demiobenour@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which=
 SELinux
>>>>>>>>> always allows too.  Furthermore, a failed FIOCLEX could result =
in a file
>>>>>>>>> descriptor being leaked to a process that should not have acces=
s to it.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
>>>>>>>>> ---
>>>>>>>>>  security/selinux/hooks.c | 5 +++++
>>>>>>>>>  1 file changed, 5 insertions(+)
>>>>>>>>
>>>>>>>> I'm not convinced that these two ioctls should be exempt from SE=
Linux
>>>>>>>> policy control, can you explain why allowing these ioctls with t=
he
>>>>>>>> file:ioctl permission is not sufficient for your use case?  Is i=
t a
>>>>>>>> matter of granularity?
>>>>>>>
>>>>>>> FIOCLEX and FIONCLEX are applicable to *all* file descriptors, no=
t just
>>>>>>> files.  If I want to allow them with SELinux policy, I have to gr=
ant
>>>>>>> *:ioctl to all processes and use xperm rules to determine what io=
ctls
>>>>>>> are actually allowed.  That is incompatible with existing policie=
s and
>>>>>>> needs frequent maintenance when new ioctls are added.
>>>>>>>
>>>>>>> Furthermore, these ioctls do not allow one to do anything that ca=
nnot
>>>>>>> already be done by fcntl(F_SETFD), and (unless I have missed some=
thing)
>>>>>>> SELinux unconditionally allows that.  Therefore, blocking these i=
octls
>>>>>>> does not improve security, but does risk breaking userspace progr=
ams.
>>>>>>> The risk is especially great because in the absence of SELinux, I=

>>>>>>> believe FIOCLEX and FIONCLEX *will* always succeed, and userspace=

>>>>>>> programs may rely on this.  Worse, if a failure of FIOCLEX is ign=
ored,
>>>>>>> a file descriptor can be leaked to a child process that should no=
t have
>>>>>>> access to it, but which SELinux allows access to.  Userspace
>>>>>>> SELinux-naive sandboxes are one way this could happen.  Therefore=
,
>>>>>>> blocking FIOCLEX may *create* a security issue, and it cannot sol=
ve one.
>>>>>>
>>>>>> I can see you are frustrated with my initial take on this, but ple=
ase
>>>>>> understand that excluding an operation from the security policy is=
 not
>>>>>> something to take lightly and needs discussion.  I've added the
>>>>>> SELinux refpolicy list to this thread as I believe their input wou=
ld
>>>>>> be helpful here.
>>>>>
>>>>> Absolutely it is not something that should be taken lightly, though=
 I
>>>>> strongly believe it is correct in this case.  Is one of my assumpti=
ons
>>>>> mistaken?
>>>>
>>>> My concern is that there is a distro/admin somewhere which is relyin=
g
>>>> on their SELinux policy enforcing access controls on these ioctls an=
d
>>>> removing these controls would cause them a regression.
>>>
>>> I obviously do not have visibility into all systems, but I suspect th=
at
>>> nobody is actually relying on this.  Setting and clearing CLOEXEC via=

>>> fcntl is not subject to SELinux restrictions, so blocking FIOCLEX
>>> and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD) is
>>> blocked by seccomp or another LSM.  Clearing close-on-exec can also b=
e
>>> implemented with dup2(), and setting it can be implemented with dup3(=
)
>>> and F_DUPFD_CLOEXEC (which SELinux also allows).  In short, I believe=

>>> that unconditionally allowing FIOCLEX and FIONCLEX may fix real-world=

>>> problems, and that it is highly unlikely that anyone is relying on th=
e
>>> current behavior.
>>
>> I understand your point, but I remain concerned about making a kernel
>> change for something that can be addressed via policy.  I'm also
>> concerned that in the nine days this thread has been on both the mail
>> SELinux developers and refpolicy lists no one other than you and I
>> have commented on this patch.  In order to consider this patch
>> further, I'm going to need to see comments from others, preferably
>> those with a background in supporting SELinux policy.
>>
>=20
> AFAIK/AFAICT Android makes no reference to F_SETFD, and tracing the cod=
e
> does seem to be ignored, and the code for FIOCLEX FIONCLEX calls into
> the same kernel routine set_close_on_exec().
> Considering that Android's bionic contains support for "e" flag to
> fopen, and it's
> used in a lot of places, makes me more sure the check is skipped for F_=
SETFD
>=20
> However, Android does make reference to FIOCLEX FIONCLEX and every
> domain has it enabled:
> domain.te:allowxperm domain { file_type fs_type domain dev_type }:{
> dir notdevfile_class_set blk_file } ioctl { FIOCLEX FIONCLEX };
> domain.te:allowxperm domain tun_device:chr_file ioctl { FIOCLEX FIONCLE=
X };
>=20
> Refpolicy doesn't use xperm AFAICT.
>=20
> I stayed quiet, I wouldn't ack on this myself, but the premise seems
> correct and we
> can safely drop this. Note that I didn't review the code. But we need
> to ensure we handle
> policy correctly and not break anything. I'm not sure what the
> compilers are doing
> for validation of policy macro values, but we would probably want to
> mark it deprecated,
> but still allow loading of old compiled policies.

Loading of policies is not impacted.  My patch simply skips the
checks for FIOCLEX and FIONCLEX, instead unconditionally allowing the
operation.  This is actually *more* selective than anything that can
be done via policy, as my patch checks the entire ioctl number whereas
policy can only check the low 16 bits.  As such, it is safer than using
policy to allow FIOCLEX and FIONCLEX system-wide: if my patch causes an
ioctl to be allowed, it is guaranteed that that ioctl will change the
close-on-exec flag and have no other effect.

--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------7X0xDt0f3IuSXhdKw7zH4Uvs
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=3Dx+Ro
-----END PGP PUBLIC KEY BLOCK-----

--------------7X0xDt0f3IuSXhdKw7zH4Uvs--

--------------kc1QEfjzunVwjnPUGEpOsvrJ--

--------------L0WD2LNmC0BrNzDEbY75REh0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmIBUjkACgkQsoi1X/+c
IsHqERAAh8c+HR1XP/R7EAWXXBLL80La8wIyOtniWCQSiWFaZWw7fUCftQDgogBc
7ALEWpx++/jSR2VsnQemXDVHuswxZ7Yjn+/z7N3fa1fUYJW5T+5rYKvXL+PKR5Us
mOdfcrtFzuzdG5Xtztlx+pf7wkapCz+1ac7dD+yx9SR66v57oPbS47FmzbdcKz94
nh62HVkHU/hxfCdEnx3/rI3/BLuML7Pf5wDKG+lejwV1IVuo2JINUVtiIvRWfp5R
OzupRWtohLVwM0b4XpzWjPuUWK2jGXs4wYYa6UKworA8bLeYcNcttlE7fjJjmBXq
fPgjEPsBzSwwOqH2fH81Nu+Q1zcz3aI+Qbs/yOzlqvckivXNPbwpeqm6ZdH/XVr5
72VjmQu7kK1DVDoKo79uw5rbvbwbgtbaXyRBReTI8Wiy7x7dJY8WMaDYiOovdL3v
UWAl+wiAXaZca7ogvFs86Ne6lWb+p60Psgkg5f7AGpWw88lEvz79cwITDgr70hPr
Cq6PLxpTzEmK5wjF5zzj56HJ5Ms6fy57bym5RsfD6cW44wDEthZQdTClHOdxWZZ1
eMzAa6ffxZ0131HdP0bUaoUNVzpBJ5cvgtS4gvT0wBrr4+yJohnZKbx486z4wfO+
G0Z1H6LjmzI9XI0DeLl5IVIEQZV5qz8uUmkeAOVY3T2ohtoYlcE=
=RfXT
-----END PGP SIGNATURE-----

--------------L0WD2LNmC0BrNzDEbY75REh0--
