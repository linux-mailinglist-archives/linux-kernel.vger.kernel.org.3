Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC81D4ACB00
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbiBGVMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbiBGVMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:12:33 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3365EC06173B;
        Mon,  7 Feb 2022 13:12:32 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id t17so12971512qto.1;
        Mon, 07 Feb 2022 13:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=sOVELqX66vp9yeaVOedDsfncNbabj9VWLRnh6rkHdYw=;
        b=QEEgIJGv4dLCj5LXnsE1cuIi8MwDDDvg/2DXrDuT49fKoPrw6Hop/mp8xF00TGGA2F
         gN31/f3RYuiWEQ+G8CTgBAecKmkCGDUyTX4EH0kINuvKr4tA8nj2ccB0IRghbgUxAWaV
         vqQJBTtgqxVeHRXXHXRc+lmLUTCR+xQp6S7Yl3UcbGHb5+PfutvtCvYlrLpnfWCCKDql
         UT3+t6XO0VUrCmrY2jdOQkbtaE6VifSpPRCe2XaMN26hBRs+EMwDIfbFn9kvdCkTjrr+
         qtfDzDqWqqPKYUHNgbom3K1eeH41UMwOaR9qiQ5DpG5FbCEvoa6t2yXalOe66mBGAzPU
         eOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=sOVELqX66vp9yeaVOedDsfncNbabj9VWLRnh6rkHdYw=;
        b=opVcafRs/h3pOCfS4PLTAFl19GngOmfVlvL4auSpj8uXnqAaqJnSttqabFU0XtAJ5e
         MvlEVQQ9HhoBfUyXF81YI3MELh/OYPVRtqOd6wSRj8/90Xu0TTaNpAVdTEGN3rRF6LUN
         BSJ49TqPEOLT8MIxHCacwsfoHC+NLcrBvPpRHkenZkGFFAKp/XvfKo3tAbzUBvARJUoN
         BUNu16PrHL75FK9oU74x2Kp0dpJJd1weysoAHHruER5kO+3bTZUxNk7IvC3FQ8eDOsmZ
         Fprk/v0CSX572dV2lVuyLq6xoIBM2gmgmuLpyiJePn6vOqYcKqlOsHfegf+DH1HFx3kq
         HfzQ==
X-Gm-Message-State: AOAM532tLPe1W2NHhlpKcbsV9kY1blfEpEM6sUWpGg253gH/ABU6BobA
        K7z32rc8kbbLz9YVD4LmdSY=
X-Google-Smtp-Source: ABdhPJxvffQiNUn28iredPCdbHe5Ug3EFnF3L1c5UZnq+RGTSxKIIjpeLlYHoXwMyCDQirv/uNmiUg==
X-Received: by 2002:a05:622a:152:: with SMTP id v18mr1036108qtw.159.1644268351239;
        Mon, 07 Feb 2022 13:12:31 -0800 (PST)
Received: from [10.139.255.254] ([89.187.171.240])
        by smtp.gmail.com with ESMTPSA id l11sm6099487qkp.86.2022.02.07.13.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 13:12:30 -0800 (PST)
Message-ID: <99d51c4f-d067-2687-e7ae-d42a6d1326b2@gmail.com>
Date:   Mon, 7 Feb 2022 16:12:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
Content-Language: en-US
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
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
 <7798e61c-eb22-7b19-0849-35e5bfccad8b@gmail.com>
 <CAFftDdpXm3VubMW_d51uEM+F_6eSGZerJbVQ=c8w7B-L1zT+3Q@mail.gmail.com>
From:   Demi Marie Obenour <demiobenour@gmail.com>
In-Reply-To: <CAFftDdpXm3VubMW_d51uEM+F_6eSGZerJbVQ=c8w7B-L1zT+3Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CjwF5jXBddTZaH1eTPFOXgYa"
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
--------------CjwF5jXBddTZaH1eTPFOXgYa
Content-Type: multipart/mixed; boundary="------------pEJRldvzRcV0ynFur2WEx514";
 protected-headers="v1"
From: Demi Marie Obenour <demiobenour@gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, SElinux list <selinux@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 selinux-refpolicy@vger.kernel.org
Message-ID: <99d51c4f-d067-2687-e7ae-d42a6d1326b2@gmail.com>
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
 <7798e61c-eb22-7b19-0849-35e5bfccad8b@gmail.com>
 <CAFftDdpXm3VubMW_d51uEM+F_6eSGZerJbVQ=c8w7B-L1zT+3Q@mail.gmail.com>
In-Reply-To: <CAFftDdpXm3VubMW_d51uEM+F_6eSGZerJbVQ=c8w7B-L1zT+3Q@mail.gmail.com>

--------------pEJRldvzRcV0ynFur2WEx514
Content-Type: multipart/mixed; boundary="------------SEcVIkVqyg7NN9y9IQKVDoco"

--------------SEcVIkVqyg7NN9y9IQKVDoco
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/7/22 13:35, William Roberts wrote:
> On Mon, Feb 7, 2022 at 11:09 AM Demi Marie Obenour
> <demiobenour@gmail.com> wrote:
>>
>> On 2/7/22 12:00, William Roberts wrote:
>>> On Mon, Feb 7, 2022 at 9:08 AM Paul Moore <paul@paul-moore.com> wrote=
:
>>>>
>>>> On Wed, Feb 2, 2022 at 5:13 AM Demi Marie Obenour <demiobenour@gmail=
=2Ecom> wrote:
>>>>> On 2/1/22 12:26, Paul Moore wrote:
>>>>>> On Sat, Jan 29, 2022 at 10:40 PM Demi Marie Obenour
>>>>>> <demiobenour@gmail.com> wrote:
>>>>>>> On 1/26/22 17:41, Paul Moore wrote:
>>>>>>>> On Tue, Jan 25, 2022 at 5:50 PM Demi Marie Obenour
>>>>>>>> <demiobenour@gmail.com> wrote:
>>>>>>>>> On 1/25/22 17:27, Paul Moore wrote:
>>>>>>>>>> On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
>>>>>>>>>> <demiobenour@gmail.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), whi=
ch SELinux
>>>>>>>>>>> always allows too.  Furthermore, a failed FIOCLEX could resul=
t in a file
>>>>>>>>>>> descriptor being leaked to a process that should not have acc=
ess to it.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
>>>>>>>>>>> ---
>>>>>>>>>>>  security/selinux/hooks.c | 5 +++++
>>>>>>>>>>>  1 file changed, 5 insertions(+)
>>>>>>>>>>
>>>>>>>>>> I'm not convinced that these two ioctls should be exempt from =
SELinux
>>>>>>>>>> policy control, can you explain why allowing these ioctls with=
 the
>>>>>>>>>> file:ioctl permission is not sufficient for your use case?  Is=
 it a
>>>>>>>>>> matter of granularity?
>>>>>>>>>
>>>>>>>>> FIOCLEX and FIONCLEX are applicable to *all* file descriptors, =
not just
>>>>>>>>> files.  If I want to allow them with SELinux policy, I have to =
grant
>>>>>>>>> *:ioctl to all processes and use xperm rules to determine what =
ioctls
>>>>>>>>> are actually allowed.  That is incompatible with existing polic=
ies and
>>>>>>>>> needs frequent maintenance when new ioctls are added.
>>>>>>>>>
>>>>>>>>> Furthermore, these ioctls do not allow one to do anything that =
cannot
>>>>>>>>> already be done by fcntl(F_SETFD), and (unless I have missed so=
mething)
>>>>>>>>> SELinux unconditionally allows that.  Therefore, blocking these=
 ioctls
>>>>>>>>> does not improve security, but does risk breaking userspace pro=
grams.
>>>>>>>>> The risk is especially great because in the absence of SELinux,=
 I
>>>>>>>>> believe FIOCLEX and FIONCLEX *will* always succeed, and userspa=
ce
>>>>>>>>> programs may rely on this.  Worse, if a failure of FIOCLEX is i=
gnored,
>>>>>>>>> a file descriptor can be leaked to a child process that should =
not have
>>>>>>>>> access to it, but which SELinux allows access to.  Userspace
>>>>>>>>> SELinux-naive sandboxes are one way this could happen.  Therefo=
re,
>>>>>>>>> blocking FIOCLEX may *create* a security issue, and it cannot s=
olve one.
>>>>>>>>
>>>>>>>> I can see you are frustrated with my initial take on this, but p=
lease
>>>>>>>> understand that excluding an operation from the security policy =
is not
>>>>>>>> something to take lightly and needs discussion.  I've added the
>>>>>>>> SELinux refpolicy list to this thread as I believe their input w=
ould
>>>>>>>> be helpful here.
>>>>>>>
>>>>>>> Absolutely it is not something that should be taken lightly, thou=
gh I
>>>>>>> strongly believe it is correct in this case.  Is one of my assump=
tions
>>>>>>> mistaken?
>>>>>>
>>>>>> My concern is that there is a distro/admin somewhere which is rely=
ing
>>>>>> on their SELinux policy enforcing access controls on these ioctls =
and
>>>>>> removing these controls would cause them a regression.
>>>>>
>>>>> I obviously do not have visibility into all systems, but I suspect =
that
>>>>> nobody is actually relying on this.  Setting and clearing CLOEXEC v=
ia
>>>>> fcntl is not subject to SELinux restrictions, so blocking FIOCLEX
>>>>> and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD) is
>>>>> blocked by seccomp or another LSM.  Clearing close-on-exec can also=
 be
>>>>> implemented with dup2(), and setting it can be implemented with dup=
3()
>>>>> and F_DUPFD_CLOEXEC (which SELinux also allows).  In short, I belie=
ve
>>>>> that unconditionally allowing FIOCLEX and FIONCLEX may fix real-wor=
ld
>>>>> problems, and that it is highly unlikely that anyone is relying on =
the
>>>>> current behavior.
>>>>
>>>> I understand your point, but I remain concerned about making a kerne=
l
>>>> change for something that can be addressed via policy.  I'm also
>>>> concerned that in the nine days this thread has been on both the mai=
l
>>>> SELinux developers and refpolicy lists no one other than you and I
>>>> have commented on this patch.  In order to consider this patch
>>>> further, I'm going to need to see comments from others, preferably
>>>> those with a background in supporting SELinux policy.
>>>>
>>>
>>> AFAIK/AFAICT Android makes no reference to F_SETFD, and tracing the c=
ode
>>> does seem to be ignored, and the code for FIOCLEX FIONCLEX calls into=

>>> the same kernel routine set_close_on_exec().
>>> Considering that Android's bionic contains support for "e" flag to
>>> fopen, and it's
>>> used in a lot of places, makes me more sure the check is skipped for =
F_SETFD
>>>
>>> However, Android does make reference to FIOCLEX FIONCLEX and every
>>> domain has it enabled:
>>> domain.te:allowxperm domain { file_type fs_type domain dev_type }:{
>>> dir notdevfile_class_set blk_file } ioctl { FIOCLEX FIONCLEX };
>>> domain.te:allowxperm domain tun_device:chr_file ioctl { FIOCLEX FIONC=
LEX };
>>>
>>> Refpolicy doesn't use xperm AFAICT.
>>>
>>> I stayed quiet, I wouldn't ack on this myself, but the premise seems
>>> correct and we
>>> can safely drop this. Note that I didn't review the code. But we need=

>>> to ensure we handle
>>> policy correctly and not break anything. I'm not sure what the
>>> compilers are doing
>>> for validation of policy macro values, but we would probably want to
>>> mark it deprecated,
>>> but still allow loading of old compiled policies.
>>
>> Loading of policies is not impacted.  My patch simply skips the
>> checks for FIOCLEX and FIONCLEX, instead unconditionally allowing the
>> operation.  This is actually *more* selective than anything that can
>> be done via policy, as my patch checks the entire ioctl number whereas=

>> policy can only check the low 16 bits.  As such, it is safer than usin=
g
>> policy to allow FIOCLEX and FIONCLEX system-wide: if my patch causes a=
n
>> ioctl to be allowed, it is guaranteed that that ioctl will change the
>> close-on-exec flag and have no other effect.
>>
>=20
> What I meant by my comment is that patching the kernel is only 1/2 the
> problem. We
> still need to coordinate with existing policies to deprecate that out,
> but since it's just
> Android (AFIAK), that's pretty simple to do. I just want to make sure
> we don't leave
> confusing cruft floating around. I looked more at how they do xperms
> in Android, and it's just
> an m4 macro to a number. So we would want to coordinate a patch into th=
e kernel
> with a patch that drops that from Android policy.

The kernel patch needs to come first, but there is no urgency at all
for the Android policy patch.  The existing Android policy will work
fine with a patched kernel.  Removing the allowxperms for FIOCLEX and
FIONCLEX will require ensuring that doing so does not make some domains
not subject to xperm rules, and therefore allow ioctls that would
previously have been forbidden.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------SEcVIkVqyg7NN9y9IQKVDoco
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=3Dx+Ro
-----END PGP PUBLIC KEY BLOCK-----

--------------SEcVIkVqyg7NN9y9IQKVDoco--

--------------pEJRldvzRcV0ynFur2WEx514--

--------------CjwF5jXBddTZaH1eTPFOXgYa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmIBizoACgkQsoi1X/+c
IsFEtRAArNWR8OQW9u/HGycxHpD8uXoJKT1x/4f8A5bp/Z+n7p8udUnbVISZ7Mbr
fD+Rqm60MwFBLVd6g08GmTSm+FPO9rfN9J8M4X2TCxjEVBpwKordXMKCET9K3mA+
dEdD37H3BzoxejKkMERSzVVKSAdKCSHq2f9gqYEOqHcz7ZgDXJQNNlhX3w33bnNd
DcW07nBOeRBIDtKo5qVL7G+aTPmlLD0de0b51No+mFzNQG/IbRuPQLON27BzONOk
aAJKS7faDUcxRSMyrqQ3AZ31FEz+PvtLypg8ncqqjJx6mpCbXm+fWjTJ71K1RXGn
8ouK8ejGoK48ySyYJkQ25uZNTCYolr/WD7Wd3pUIun+yn05vWf0IJ+jag3y8YNyw
2+j7SwtBCQGXVc2nzo99tSbuHNzkPMzsWHLU9fwIQk1+usJnA/sxlztjMr0RmxyV
eYWPvmE6Npogf5XoTYVAOuQTtECnsFQX1cTK8Ke1bJQpPnJvtcr6au1Me/2kjfnX
p5Sr+tpI7ZE82retr69AvJhx061O7ZifuqtAYd1RLmD7DM1qKs+4Rn3iZEO/mu8n
DH6hjLgjWahFGROBFaFkNUhJ5qWQxG6IoF3S47BSlPMXzgCEQGEaxYhtJ5drn2h0
uOY0M0R3JBe/Z3QRWdpZEVGvWmahnwmCqdFqvkNdffPWhHex5LA=
=L36B
-----END PGP SIGNATURE-----

--------------CjwF5jXBddTZaH1eTPFOXgYa--
