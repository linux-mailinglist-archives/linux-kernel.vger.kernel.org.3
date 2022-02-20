Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A9D4BCB77
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 02:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiBTBQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 20:16:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiBTBQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 20:16:46 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E1D3A185;
        Sat, 19 Feb 2022 17:16:25 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id bm39so1062380qkb.0;
        Sat, 19 Feb 2022 17:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to;
        bh=yUkj/0c3+DOigbjVwCFAWhudBAmfqcn1fc1rklII8aw=;
        b=IXvh2G1fGqfvnriSR3uuPpsvt4A9BYknbSgMklfJuLYAk0dcxCyrPX05mDnUFpzdOz
         o58E9Z6Rfa/oVsv2xbvht7HLXOsc5/yk8Lkr2eTSYkz6SEW1Bt+bTE8NladTDrO5E2of
         lclj61r4Th41G2wxPuLWkOmcguinAVtzvI9Rx6txnU7j/51Z3tspG/HkiOkxhAE80vpM
         Rnw7DD0cCC9LEt4oG7fZ/0AKfvjGLBkxaNjBY7ci5PJ7X2DorfzB1hgQXF2Z+XMM6j6N
         02vlQ7+z+DVrXL4Cr+B/kn/pn9QPdq++wTn+tPLOgK3HF4ZVJB62cF2mK97gjel+8E35
         Zbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to;
        bh=yUkj/0c3+DOigbjVwCFAWhudBAmfqcn1fc1rklII8aw=;
        b=lx9I9nvcPe8B/HiwqDRJxvxMrmov49p7+vz+EknQV67jH5Eu8vPUJG36FFnodFP9Ui
         hozK2Oc5M58ynQWEpVKBAvANRxzOFQkvHFnmv7+E7Bn1qPaAIs6v8n+a7YMd7c5hTHXV
         f+RU6wZMg/UnQO/2vCGAxneJdkLlNjhfd9x+88/iXsAH8TdKvoTi96ZH/h3biKOQFtqW
         jWzUYpnB/aA9i7M73Rn/vcY5C/ZE9WJuNFWx1MMmYhNnZ1/PKkX4ToCGmUKaxT3/HROW
         veycEM4epcr3knFqpbCqRqmUHkJHaIucLl+yHn7vxBV2gPTWTNkRswxKKwevxclHiPi4
         DDlw==
X-Gm-Message-State: AOAM530ROP30durP8i3l6y5NcGrJ5141aBCTda7ZJxoCfJKwescyR9+y
        UzlvVTHQMWghywdhPn7jrBc=
X-Google-Smtp-Source: ABdhPJzBfzPFKYu3LH0i5dWNrrlG8w53hvjL5scKkMUejCjL3e3bqZ8fdFOIe4NpG7p5ILaFYOjPMQ==
X-Received: by 2002:a37:c06:0:b0:49b:7a31:cd54 with SMTP id 6-20020a370c06000000b0049b7a31cd54mr8563066qkm.358.1645319784027;
        Sat, 19 Feb 2022 17:16:24 -0800 (PST)
Received: from [10.139.255.254] ([89.187.171.240])
        by smtp.gmail.com with ESMTPSA id w10sm29013355qtj.73.2022.02.19.17.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 17:16:23 -0800 (PST)
Message-ID: <6d6378bf-7ac7-108c-a896-14c81832c364@gmail.com>
Date:   Sat, 19 Feb 2022 20:15:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
To:     Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Dominick Grift <dominick.grift@defensec.nl>,
        Chris PeBenito <chpebeni@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeffrey Vander Stoep <jeffv@google.com>
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
 <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
 <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
 <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
 <478e1651-a383-05ff-d011-6dda771b8ce8@linux.microsoft.com>
 <875ypt5zmz.fsf@defensec.nl>
 <CAFftDdo9JmbyPzPWRjOYgZBOS9b5d+OGKKf8egS8_ysbbWW87Q@mail.gmail.com>
 <CABXk95Az0V0qWyB0Cp9D+MaCKNBfcdk4=bvXRdm5EXzHdjXJJg@mail.gmail.com>
 <CAHC9VhQKuQuR1pJfa0h2Y5dCjmrpiYaGpymwxxE1sa6jR3h-bA@mail.gmail.com>
 <aca4f2d6-5e1a-8c20-bfde-17e436b7e9d8@gmail.com>
 <141da74b176cd3bae74a8a81226c661c032631dc.camel@btinternet.com>
From:   Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
In-Reply-To: <141da74b176cd3bae74a8a81226c661c032631dc.camel@btinternet.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------SoV7eweFMBgTyiNBGWn7dsOM"
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
--------------SoV7eweFMBgTyiNBGWn7dsOM
Content-Type: multipart/mixed; boundary="------------dDIc5L2XZnhT9RbhsZXbCNJ0";
 protected-headers="v1"
From: Demi Marie Obenour <demiobenour@gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>,
 Paul Moore <paul@paul-moore.com>
Cc: William Roberts <bill.c.roberts@gmail.com>,
 Dominick Grift <dominick.grift@defensec.nl>,
 Chris PeBenito <chpebeni@linux.microsoft.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, SElinux list <selinux@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 selinux-refpolicy@vger.kernel.org, Jeffrey Vander Stoep <jeffv@google.com>
Message-ID: <6d6378bf-7ac7-108c-a896-14c81832c364@gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
 <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
 <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
 <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
 <478e1651-a383-05ff-d011-6dda771b8ce8@linux.microsoft.com>
 <875ypt5zmz.fsf@defensec.nl>
 <CAFftDdo9JmbyPzPWRjOYgZBOS9b5d+OGKKf8egS8_ysbbWW87Q@mail.gmail.com>
 <CABXk95Az0V0qWyB0Cp9D+MaCKNBfcdk4=bvXRdm5EXzHdjXJJg@mail.gmail.com>
 <CAHC9VhQKuQuR1pJfa0h2Y5dCjmrpiYaGpymwxxE1sa6jR3h-bA@mail.gmail.com>
 <aca4f2d6-5e1a-8c20-bfde-17e436b7e9d8@gmail.com>
 <141da74b176cd3bae74a8a81226c661c032631dc.camel@btinternet.com>
In-Reply-To: <141da74b176cd3bae74a8a81226c661c032631dc.camel@btinternet.com>

--------------dDIc5L2XZnhT9RbhsZXbCNJ0
Content-Type: multipart/mixed; boundary="------------dKg03NCLZLG0t0B9zhGDv2Lo"

--------------dKg03NCLZLG0t0B9zhGDv2Lo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/18/22 10:39, Richard Haines wrote:
> On Thu, 2022-02-17 at 18:55 -0500, Demi Marie Obenour wrote:
>> On 2/15/22 15:34, Paul Moore wrote:
>>> On Mon, Feb 14, 2022 at 2:11 AM Jeffrey Vander Stoep
>>> <jeffv@google.com> wrote:
>>>> On Tue, Feb 8, 2022 at 3:18 PM William Roberts
>>>> <bill.c.roberts@gmail.com> wrote:
>>>>>
>>>>> <snip>
>>>>>
>>>>> This is getting too long for me.
>>>>>
>>>>>>>
>>>>>>> I don't have a strong opinion either way.=C2=A0 If one were to
>>>>>>> allow this
>>>>>>> using a policy rule, it would result in a major policy
>>>>>>> breakage.=C2=A0 The
>>>>>>> rule would turn on extended perm checks across the entire
>>>>>>> system,
>>>>>>> which the SELinux Reference Policy isn't written for.=C2=A0 I
>>>>>>> can't speak
>>>>>>> to the Android policy, but I would imagine it would be the
>>>>>>> similar
>>>>>>> problem there too.
>>>>>>
>>>>>> Excuse me if I am wrong but AFAIK adding a xperm rule does
>>>>>> not turn on
>>>>>> xperm checks across the entire system.
>>>>>
>>>>> It doesn't as you state below its target + class.
>>>>>
>>>>>>
>>>>>> If i am not mistaken it will turn on xperm checks only for
>>>>>> the
>>>>>> operations that have the same source and target/target class.
>>>>>
>>>>> That's correct.
>>>>>
>>>>>>
>>>>>> This is also why i don't (with the exception TIOSCTI for
>>>>>> termdev
>>>>>> chr_file) use xperms by default.
>>>>>>
>>>>>> 1. it is really easy to selectively filter ioctls by adding
>>>>>> xperm rules
>>>>>> for end users (and since ioctls are often device/driver
>>>>>> specific they
>>>>>> know best what is needed and what not)
>>>>>
>>>>>>>>> and FIONCLEX can be trivially bypassed unless
>>>>>>>>> fcntl(F_SETFD)
>>>>>>
>>>>>> 2. if you filter ioctls in upstream policy for example like i
>>>>>> do with
>>>>>> TIOSCTI using for example (allowx foo bar (ioctl chr_file
>>>>>> (not
>>>>>> (0xXXXX)))) then you cannot easily exclude additional ioctls
>>>>>> later where source is
>>>>>> foo and target/tclass is bar/chr_file because there is
>>>>>> already a rule in
>>>>>> place allowing the ioctl (and you cannot add rules)
>>>>>
>>>>> Currently, fcntl flag F_SETFD is never checked, it's silently
>>>>> allowed, but
>>>>> the equivalent FIONCLEX and FIOCLEX are checked. So if you
>>>>> wrote policy
>>>>> to block the FIO*CLEX flags, it would be bypassable through
>>>>> F_SETFD and
>>>>> FD_CLOEXEC. So the patch proposed makes the FIO flags behave
>>>>> like
>>>>> F_SETFD. Which means upstream policy users could drop this
>>>>> allow, which
>>>>> could then remove the target/class rule and allow all icotls.
>>>>> Which is easy
>>>>> to prevent and fix you could be a rule in to allowx 0 as
>>>>> documented in the
>>>>> wiki: https://selinuxproject.org/page/XpermRules
>>>>>
>>>>> The questions I think we have here are:
>>>>> 1. Do we agree that the behavior between SETFD and the FIO
>>>>> flags are equivalent?
>>>>> =C2=A0 I think they are.
>>>>> 2. Do we want the interfaces to behave the same?
>>>>> =C2=A0 I think they should.
>>>>> 3. Do upstream users of the policy construct care?
>>>>> =C2=A0 The patch is backwards compat, but I don't want their to be
>>>>> cruft
>>>>> floating around with extra allowxperm rules.
>>>>
>>>> I think this proposed change is fine from Android's perspective.
>>>> It
>>>> implements in the kernel what we've already already put in place
>>>> in
>>>> our policy - that all domains are allowed to use these IOCLTs.
>>>> https://cs.android.com/android/platform/superproject/+/master:system=
/sepolicy/public/domain.te;l=3D312
>>>>
>>>> It'll be a few years before we can clean up our policy since we
>>>> need
>>>> to support older kernels, but that's fine.
>>>
>>> Thanks for the discussion everyone, it sounds like everybody is
>>> okay
>>> with the change - that's good.=C2=A0 However, as I said earlier in th=
is
>>> thread I think we need to put this behind a policy capability, how
>>> does POLICYDB_CAPABILITY_IOCTL_CLOEXEC/"ioctl_skip_cloexec" sound
>>> to
>>> everyone?
>>>
>>> Demi, are you able to respin this patch with policy capability
>>> changes?
>>
>> I can try, but this is something I am doing in my spare time and I
>> have no idea what adding a policy capability would involve.=C2=A0 Whil=
e I
>> have written several policies myself, I believe this is the first
>> time
>> I have dealt with policy capabilities outside of kernel log output.
>> So it will be a while before I can make a patch.=C2=A0 You would proba=
bly
>> be
>> able to write a patch far more quickly and easily.
>=20
> RESEND: Forgot to add the updates for libsepol (I think it's complete
> now)
>=20
>=20
> # Adding A New Policy Capability
>=20
> - [Kernel Updates](#kernel-updates)
> - [*libsepol* Library Updates](#libsepol-library-updates)
> - [Reference Policy Updates](#reference-policy-updates)
>=20
> ## Kernel Updates
>=20
> In kernel source update the following three files with the new
> capability:
>=20
> ***security/selinux/include/policycap_names.h***
>=20
> Add new entry at end of this list:
>=20
> ```
> /* Policy capability names */
> const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] =3D {
> 	...
> 	"genfs_seclabel_symlinks",
> 	"new_polcap_name"
> };
> ```
>=20
> ***security/selinux/include/policycap.h***
>=20
> Add new entry at end of this list:
>=20
> ```
> /* Policy capabilities */
> enum {
> 	...
> 	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
> 	POLICYDB_CAPABILITY_NEW_POLCAP_NAME,
> 	__POLICYDB_CAPABILITY_MAX
> };
> ```
>=20
> ***security/selinux/include/security.h***
>=20
> Add a new entry that will initialise the new capability:
>=20
> ```
> static inline bool selinux_policycap_new_name(void)
> {
> 	struct selinux_state *state =3D &selinux_state;
>=20
> 	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_NEW_POLCAP_NAME]=
);
> }
> ```
>=20
> Finally in the updated code that utilises the new policy capabilty do
> something like this:
>=20
> ```
> if (selinux_policycap_new_name())
> 	do this;
> else
> 	do that;
> ```
>=20
> ## *libsepol* Library Updates
>=20
> In selinux userspace source update the following two files with the new=

> capability:
>=20
> ***selinux/libsepol/src/polcaps.c***
>=20
> Add new entry at end of this list:
>=20
> ```
> static const char * const polcap_names[] =3D {
> 	...
> 	"genfs_seclabel_symlinks",	/* POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLI=
NKS */
> 	"new_polcap_name",		/* POLICYDB_CAPABILITY_NEW_POLCAP_NAME */
> 	NULL
> };
> ```
>=20
> ***selinux/libsepol/include/sepol/policydb/polcaps.h***
>=20
> Add new entry at end of this list:
>=20
> ```
> /* Policy capabilities */
> enum {
> 	...
> 	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
> 	POLICYDB_CAPABILITY_NEW_POLCAP_NAME,
> 	__POLICYDB_CAPABILITY_MAX
> };
> ```
>=20
> ## Reference Policy Updates
>=20
> The new policy capability entry is then added to the Reference Policy
> file:
>=20
> ***policy/policy_capabilities***
>=20
> An example entry that enables the capability in policy is:
>=20
> ```
> # A description of the capability
> policycap new_polcap_name;
> ```
> To disable the capability in policy comment out the entry:
>=20
> ```
> # A description of the capability
> #policycap new_polcap_name;
> ```

This is going to be a much, MUCH larger patch, and it will be quite a
while before I have the spare time to write it.  I would be fine with
someone else writing it, though.

--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------dKg03NCLZLG0t0B9zhGDv2Lo
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=3Dx+Ro
-----END PGP PUBLIC KEY BLOCK-----

--------------dKg03NCLZLG0t0B9zhGDv2Lo--

--------------dDIc5L2XZnhT9RbhsZXbCNJ0--

--------------SoV7eweFMBgTyiNBGWn7dsOM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmIRlmYACgkQsoi1X/+c
IsF4xw//fssrR1QYSHYv0IWM6EUXSwhkkxsUlEVXK9CNMpeWfAiweu5gIvn0VA/t
PwJxBmipd9SBV2oR+0IA1QmyATre4zv2lEqy3mMViWpz8SvVmwgoNR5Z7r0WgGCG
i1V15247lpg/rleCb8Z0miInJ+VEBJq27j2J4fFl0hkCsVgNEMFwMPNl1Wb2YXrn
1NNICjTgS+nHsmq8fCea1FjcvHTZ0zWCFGVRq3HOvUCVtlZxmehnusYaj/scvBPA
hRrPLbPh139vEZUmnwaztOnmw8cbDOC1I3UZnSd/UvpZAXaKkl99sP9BZ5zMIIJP
EfOMQQxAQLQ9uxpJOIaOodC/3DCZVoajEqa+Gcw/gLef4zKGGnBCmsZJFm5ra6bO
9Cg3XU4LueWh/zDpNOYIQHCVLNwJjJh5CG+IjkPHdiXDQ+s8MnteJsu1cJ4cEQGY
mK+TCwYQBKfATvyAePn5nLyouOthCRC7qdEINt8Z26EK+tLSSLyZ1jw9auKfeXG1
1gz02O/ltm04oUdJlH2HCtbkNormbvhL/07Y+Y/3AZb0EfBxZhdJNjqCTe1E0AjX
TF5Ek6kAd9YrRFaQcun3czlpqKCtc7XFCMPIeN/TNQ9LlrYAN9sG8WOSag3lcGDz
GfyFr9iwQI3n7MsIjuQkNIMqjL2KgBQSFSrwHgjpSx2Iv8nVW24=
=YKg7
-----END PGP SIGNATURE-----

--------------SoV7eweFMBgTyiNBGWn7dsOM--
