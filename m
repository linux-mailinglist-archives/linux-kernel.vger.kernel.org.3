Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919BE53907B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbiEaMRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiEaMRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:17:06 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1091572D
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653999417;
        bh=A6zomDaMBgPhaGtT/FtuJTC9T1qzsoqX4CIG6Xm+HO0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Xc0fAPHFeZBkTpEqTBVGygJX4GuscjeERotPJ+BqL/56aTTPnY5R8PeGGikN3awxi
         0cOkt6JDo+UWCpZaWttrCtNKnzJ3Kx7xNLubv7+eQy2o75goAUWyCOCnJgdp06Ur0/
         FJdxrWmcTF5PF9eMvF1qsWT+AFUIxCdBmA7qK50s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [100.120.147.234] ([84.17.52.175]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRTRH-1o8T0u05sj-00NO9R; Tue, 31
 May 2022 14:16:57 +0200
Message-ID: <cbde441f-b172-2a01-606d-0f97681a59fb@gmx.fr>
Date:   Tue, 31 May 2022 14:16:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: PROBLEM: with daemon.c after y2038 on 32-bits Kernel
Content-Language: en-US
To:     Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     y2038@lists.linaro.org, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
References: <CAK8P3a0bmE03wJ_iELrAMyFvamwd_r5aLsFBH=6=5YaueO=-kg@mail.gmail.com>
 <CAK8P3a3m5E2-w4sewEnb4WK68T1wduChR6eSUzsaWPicYhKPHQ@mail.gmail.com>
 <4b83ea18-e106-e7ec-d1d9-daa74aeaf990@linaro.org>
From:   =?UTF-8?Q?Arnaud_Pana=c3=afotis?= <arnaud.panaiotis@gmx.fr>
In-Reply-To: <4b83ea18-e106-e7ec-d1d9-daa74aeaf990@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Antivirus: Avast (VPS 220531-2, 31/5/2022), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:X+WtXu9AeUhO3aQKCkObXmLknRAO5bq2KVXF4ajKfsS6doEOfbF
 +DZMR8tUB4mjdJMotgrfyrl5/IFOd9KZ1m4acDGJmJlovhpTV58EnscdId5Fqyl6ck0tVoN
 +AQ/Z0DIjrI1TkKxpReVejQcaO6wHWEX2MIw5s6ym5TwqAuLC+7Sj0pJkeWAqU0WrCmV2cE
 /n/Rywdon4yl0i/g2H5Og==
X-UI-Out-Filterresults: junk:10;V03:K0:Xq/nOuFRXew=:f2fK9u2CIkMp1G+PWEUq87VI
 N3sbQoK85SgEd+6asLoAlLJCT6jJF7Hr/eaJ9MHmbuTOOMrQBpjf0RNVdRJiYrNxjyeWocZaE
 iX+4oX2wDSLG4IClAfybfOdoqOYae9V7H68SckM7WDm0xkFB7aUB3yCXj5f/3X7I6wglL0MfR
 GOuHIzCZUGUmp6/E4rWGMz11I7K8twgv5ZiQe7w22RZBja21aRtNTAgoYUKJwSkM9F51eYqOo
 LMLftAJebsfUdi/U6tbAT61tXBf6PMfQ6XjMQNyLUXeHPymMU01xHx61SCOacGYXKnlwYw8NJ
 kyXE2xRm3Lsd8HEEGzT+TVu4X0DFlY2Hejll6LdroCIXIJ72d7KmJda5VE6c6nzb5QKEox5Yh
 +IISrh6k7gtToWCYOeAwg+d/dFsQayXAVXJHKxdmOp+ZSYZL4PKHrX7bCv3BYFcgFAcxeqNZ8
 jcMDMN8sdlHdM6MQjOyh06mCf8ltlqffB0RBQdgDqtHIgtyl36b8zMjCfmtxo0Zkv0xLZMTLt
 Js/Hm+MjYGVdjzRsaA/1FSlcEbDjx0T3j2Vx4oMxuIc1JjgsTBN/SZDKzF7OZogY/12QfyjqT
 obzvb8gLCasjBXFNV+r4gvpvg6zmpBC+n+KqDEajhv+wKMoGkhqzgVNaVC1Hk0HDjuHifNB8E
 O+dEbw3tDEOHTaBxb9ZIdPgzkpJfQAPor+7yf7ZM0fcRiOn8x0BQiJXF6qDQjhGr6nhN/3EDx
 xcryvRvQbMl/ojcNoqRaXb8bWIrCRsJZhcj4TIc3twxkLWY+XVsvQ3/3UkHZ2MngReztTWsf4
 F9vIXHbYUfqjzIzB5z5fBp9W8XBpHJP7h92OdF6enh6q5COnIvPppm2Pzex1dZnH9m+vCbZ6F
 +3cwtYrbIxiYo+YiZ5eTm51Vhe5IVUFYQ8R1Iu1U6F9vjs9jK7DA0L1+F8Ity7Ugb9/5SAuTI
 y73fEOflLMSzxC3smByCRmMd4ZHvV83lNoCFHMgkMldgCOrtdbDpeSfArSMhzY+n+uFAuFeI8
 Eom5lnMIVfKyakKKT4EkFwcj8y8MHLViAV/5V1jl/mtgIcxmLdTJ0BorcN8VZbp7YQjnbk5Ie
 P/RNDpImvVuTNRGV0RpMxNfauKl9BAa+GRihkh8oxMU3z58UKufYuUgKz5ZPbett+X+mjpFUc
 KPq97HvDrD+v4AOnjVZASTyh
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 31/05/2022 12:54, Adhemerval Zanella wrote:
>
> On 31/05/2022 05:33, Arnd Bergmann via Libc-alpha wrote:
>> (cc correct libc-alpha list, sorry for the typo)
>>
>> On Tue, May 31, 2022 at 10:24 AM Arnd Bergmann <arnd@kernel.org> wrote:
>>> On 17/05/2022 09:51, Arnaud Pana=C3=AFotis wrote:
>>>> I'm working for a client to generate embedded 32-bits Linux Kernel wo=
rking after y2038 issue.
>>>>
>>>> I generated a 5.15 Kernel thought Buildroot with Coreutils 9.0, GCC 1=
1.2.0, Binutils 2.37, Glibc 2.34-9 and CFLAGS  -D_LARGEFILE_SOURCE -D_FILE=
_OFFSET_BITS=3D64  -D_TIME_BITS=3D64.
>>>>
>>>> I encounter an issue while working with OpenSSH (I initially contacte=
d them before).
>>> To clarify: did you build just openssh with  -D_TIME_BITS=3D64, or did
>>> you build the entire user space this way?

I made a patch for the whole Builroot, this way all packages are built
with it (unless it is filter-out, I had to make few patches).

Option is present in build log for daemon.c and sshd.c

>>>
>>>> After 2038, /usr/sbin/sshd does not create an error but it child does=
 generate this one:
>>>> daemon() failed: Value too large for defined data type
>>>>
>>>> This happend here in sshd.c:
>>>>
>>>> 2019         /*
>>>> 2020          * If not in debugging mode, not started from inetd and =
not already
>>>> 2021          * daemonized (eg re-exec via SIGHUP), disconnect from t=
he controlling
>>>> 2022          * terminal, and fork.  The original process exits.
>>>> 2023          */
>>>> 2024         already_daemon =3D daemonized();
>>>> 2025         if (!(debug_flag || inetd_flag || no_daemon_flag || alre=
ady_daemon)) {
>>>> 2026
>>>> 2027                 if (daemon(0, 0) =3D=3D -1)
>>>> 2028                         fatal("daemon() failed: %.200s", strerro=
r(errno));
>>> My guess is that there are parts of glibc that are not fully
>>> y2038-safe at the moment, but
>>> merely provide the interfaces for time64 applications.
>>>
>>>
>>> In the glibc code, I see
>>>
>>> int
>>> daemon (int nochdir, int noclose)
>>> {
>>> ...
>>>                  if ((fd =3D __open_nocancel(_PATH_DEVNULL, O_RDWR, 0)=
) !=3D -1
>>>                      && (__builtin_expect (__fstat64 (fd, &st), 0)
>>>                          =3D=3D 0)) {
>>> ...
>>>                               } else {
>>>                          __close_nocancel_nostatus (fd);
>>>                          return -1;
>>>                  }
>>>       return (0);
>>> }
> Thanks for catching it, I have opened a bug report for it [1] and I will=
 fix
> and backport to 2.34 and 2.35.
>
> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=3D29203
Thanks, I'll watch this.
>
>>> __fstatat64 (int fd, const char *file, struct stat64 *buf, int flags)
>>> {
>>>    struct __stat64_t64 st_t64;
>>>    return __fstatat64_time64 (fd, file, &st_t64, flags)
>>>           ?: __cp_stat64_t64_stat64 (&st_t64, buf);
>>> }
>>>
>>> If I'm reading this correctly, daemon() internally uses the time32
>>> version of 'stat', which fails for files with out-of-range timestamps.
>>> Are you able to rebuild the ssh binary (or your entire distro, if that=
's
>>> easier) against musl-1.2.x instead of glibc to see if the same thing
>>> happens there?

Musl did not worked previously for me, not sure for openssh only within
Buildroot.

I'll test the patch from ticket 29203, probably the easiest solution for m=
e.

>>>
>>>         Arnd
>>>
>>>> To reproduce:
>>>>
>>>> # date -s "2040-05-12"
>>>> # hwclock --systohc
>>>> # reboot
>>>> # /usr/sbin/sshd
>>>>
>>>> Note this error occurs only after the reboot, and setting a date befo=
re 2038 also require a reboot to remove the error.
>>>>
>>>> strace and gdb trace linked.
>>>>
>>>> Let me know if you need additional information.
=2D-

*Arnaud PANA=C3=8FOTIS* | Lead Developer Freelance
+33 6 34 82 12 62 | arnaud.panaiotis@gmx.fr <mailto:Arnaud Pana=C3=AFotis
<arnaud.panaiotis@gmx.fr>>

18 place Jean Moulin - 38000 Grenoble
APsudo - www.panaiotis.fr <https://www.panaiotis.fr>

=2D-
L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=C3=
=A9rifi=C3=A9e par le logiciel antivirus Avast.
https://www.avast.com/antivirus

