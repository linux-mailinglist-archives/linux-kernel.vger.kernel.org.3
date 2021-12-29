Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F4B480E87
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 02:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbhL2B02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 20:26:28 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:39004
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232128AbhL2B00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 20:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640741186; bh=35UsicSX1KDX6T7mUqmcQ6lP8TA2dw5f1LDNVxMtiAs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=AH89lcWi5sHk1DrAkdkAdJ7Meq4lMZ2Y5zoB5W/CCtB4Ygo4+TLdE35t9Up5T7fxZUSWmSkdHTKPH0kVbeJMkOjb/3UxgOfE0h4KCZJWv+awZX0+zALYMvsZznU53YGxui6kHf4Nm2ymbgM84Oz8SyuubhFkdeGo4jgTqcYVq/31yS+8n3Y7DZr4AHCjOIovnrtig1zoabITBbIANJYPmnNPz7vWQ2hO6c8bxd01bBNu6ohd+mdrNcAl7nQErxs4pPN0BUYplaWBtsBy8b3+mPPWoN2hy8JCMfN+kbciKH/39CurPHf9MxkcVlU7txBO0daGRI/IgAxhahzJzW9Cbg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640741186; bh=loPGJkZ8YKUoQuk7z2y6hdwl6SvGkmUY+2kd2cbsviX=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=iDQDOHThXcdnKGRp/27LUmMaSg3kieTjhYPjIn4WejK01E+BGNCgvW4q67aVQ+SMa9RlH+r94GObGNdPcbLKZBZpgyGBjgTMR2eP4wA+KyyCXg/s1heltMtuGXIseU9/B+iIGsuk63RPu6evMyj28ghUo9prXuOCml3p0H3zZbFwqRrrIPFvkDZcGbb7cQOFr2IcU7hGBWgLZ3P79QCbxSugenkugpRrk0SMek4i6VH9kdbbIFRjTNnEQ+VpS9emewWdU4iRWscaqnzzJfCYgHmQgkjAs0NoEH3q8q6ZHIncW5igcpR3pWxQly1ubZstFqefOguYh5D2kGRdLKODXQ==
X-YMail-OSG: vd2.ZT0VM1n33tt5wGadSSiJjdlITnXNHTN8jIhrP.FEro.YKR.MZKWNAUVpX_7
 ur8_aHZHe_IbR46N8hUoK57ttQw4rEsIruu0k2zvKq4TT98Khb2mUyPLjpVVR6GYYXgxVrk8Bdcj
 RUegMq1oZJIg4OfOR3FUxvvLo2LkMTlS43KLL4U2fhlqdf905szk6YXK_gwuYIWG8L_0cnImAA6s
 E.SxOyNKE2GKk2Pb1TQftfOWtqGTdxr0qA0jFGECcCLllxhKuKydrCQ.E1h8i_bpVBbR1PUHv2J_
 f6cTZ9qJqBd225vw349Xuu9eN3ROs4TCmBf9XkPb5vaibyZNQR6ElHVc7xO5AytB57WK4muC9xy.
 OYAVTHpl6WZNU2tql0LKtXkQZGdrCsFpTuzPFLuNMbmYfvgP6XN.3n.qkk2mUvT0jmgIRtISdhnL
 fMSmmK1ka0n3kQwr0TYN4_oEdh.s0eUzd88F87V7JvOekBs6HU7uCB75M3WV3dN90yuFOpUR0wJM
 VOVu6I4XNjhiVL2wwSJIf5TIgpGC7qA4dSmIHz1J6CxeZJafro.UaAL1xaxkeDAbyDZDZd9iv_g4
 Z7YbcjYNCWNAGUr_icZ378epgyihS2HQSfbmRQnKtCkVXg2vh3M4XdM5txYkNMrC0c.lGgz_qCgE
 Gsn74jH5py3KH81Nb7CxLu7MYArAWc4IrGeMrnHLvdsCJRTLek71MYVvrJGQ_zJwckOb75UeelEL
 _BRWdZ454LILFG3HejhfoPUvJ_4Cj3d1yX8RyWTnfuTv1dkNCC1AW_NEdKCRdtVYDGImE0QBIUHg
 gu27RSWnROFYEOsOyKvCzuq33.uAyaFNxnMTnndL5_LYow9VbpHK672Cc8Kmfy_6CgY3gJv5ZcVp
 OgoZE75qp8xtJPcclWWS1wm1SdskgQFxmg5x6OR8PlSjoDdxngqR7cI_cO9HzHQPOcGwVO7AEnP1
 qKDSIYRhrV5N553OeccCjkZ2NuXuxD3FCevczHA8mVvnHaEs67uDU1c3U_mPcdlMmPbFON8rUowf
 DtHtD.zKV1FLL.Q2GaP8GS4RaRKiWEli0nrAe1IEzzYkZFbBWz4cTWkAZMBmCLJgv3lmOW7Y4eg1
 yZZkWSznIwKlLDCyHUp_Go7__BIrzpJb0aaZPqVu92cg3RheSAJRT1wAjLZHGqQiQAOiAGitSm8h
 finrRBpoxGH4D6lBIgaXJUcFh6Si5Iq.NJjEGUK_mHahDNoGyY225Soy3hPe5JmMEXC9yzGFuZ7Z
 7hyBhXaxysFNB9N3PkKubR5PbEraVag6ZQBqDZzPhxZMTxTs9VtJHaFpdRYVQWhiccP76EZAucjF
 NVgK1hz4zRGMH8qspJamyJ2nR1con56bPnfRDWM3Jj6g16Bx35ItJ1PFzGJ477_ivE3mYoB4nczs
 78xwhkX9NMW93Yu.mselY3pzlcAMOBfnikhJeWgjaOVnKwzMFD3i_C8Uim.KABbf04wJv6YecOBO
 RcGLauyTCTQgT.S3eeavM4KbA2TnGYSwNyit3Ow.zF_7F2WoEhOXcF3D_KfhfGZAO3uDqQ2v6StS
 eJK5EG2kHcae_fF2ulZ6c4HVh7VE0t4Q53nPSagbQ_VmsPO0fzcKZ8oYuLUIl4RxLVVybhxK_BzK
 7J1aczU61i3.3YHKb0er2QGFDEQSKphYRs108OAdYMXwLi0J.4Hor0VCmBd3vLT2MJVrtAtRO.MG
 WlALIU9bpf4exCC7oQznVEwRzKUfQdpDu0ROatreKz_Ja_GL.q5gMvUIL0J3UlEmcWvWU5YOwr4W
 uI21znghk_C2szarUALPsxlXqCWI3Ry8ndvOdnu25qYHEVdhowxgx6qMfKbcUoENBSbBGPZTzk8t
 b4veQGYLKZLVGssQ5uNKshNcfq7WlLCvP9NvY1h7YgfwTcVruG3L8Bt6I_u.lwYyFKCEpHQ6PDng
 TyaFLmvhXIwzrkGoqAiVwKq4CBml5CPSdDLtVxIMi6LUx3wGEdkD5cj1NApGjKg9wKGrblYQYz.Q
 XexTqWKxthg2gPR2LWDF32wK8RxyDSGXvW2dudGM_NsO4Ve.Jk2ogA6r0PYJ.ig8qiwl19yqbnHR
 CVO2eaffkZ4u0wCsC9kBl2fsjjb_riwmksre1zfPpGdzq366bdKklWIH9sAjJMssUA4yHiG.vvZY
 Izl3MnqO_UvvRddoP44evW1CCzrRjen6gVOOfvMIaXQXXRbOpZN7K_kN0GgoG4KScapBL1G0VNNc
 xhr9tuEeRR0kh3QEJ2dum5duWdYaeUCrs0_TE78b.JRiqpJYbmTiL.R2fsL4suwQxU4ieLGKZ
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 29 Dec 2021 01:26:26 +0000
Received: by kubenode513.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1b86c1bb2cdfb517010be5c30d079470;
          Wed, 29 Dec 2021 01:26:21 +0000 (UTC)
Message-ID: <48103715-6e22-10ab-6b4f-06946e00a28e@schaufler-ca.com>
Date:   Tue, 28 Dec 2021 17:26:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH v1 0/2] Add capabilities file to sysfs
Content-Language: en-US
To:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211227205500.214777-1-flaniel@linux.microsoft.com>
 <7d1d7682-dd19-1b8a-ee5a-50fe6479589b@schaufler-ca.com>
 <2639798.l7ez0hRiAL@machine>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <2639798.l7ez0hRiAL@machine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.19498 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/2021 5:34 AM, Francis Laniel wrote:
> Hi.
>
> Le lundi 27 décembre 2021, 23:22:41 CET Casey Schaufler a écrit :
>> On 12/27/2021 12:54 PM, Francis Laniel wrote:
>>> Hi.
>>>
>>>
>>> First, I hope you are fine and the same for your relatives.
>>>
>>> Capabilities are used to check if a thread has the right to perform a
>>> given
>>> action [1].
>>> For example, a thread with CAP_BPF set can use the bpf() syscall.
>>>
>>> Capabilities are used in the container world.
>>> In terms of code, several projects related to container maintain code
>>> where the capabilities are written alike include/uapi/linux/capability.h
>>> [2][3][4][5]. For these projects, their codebase should be updated when a
>>> new capability is added to the kernel.
>>> Some other projects rely on <sys/capability.h> [6].
>>> In this case, this header file should reflect the capabilities offered by
>>> the kernel.
>>>
>>> So, in this series, I added a new file to sysfs: /sys/kernel/capabilities.
>> This should be /sys/kernel/security/capabilities.
> I began to write code to move this under /sys/kernel/security/capabilities but
> I realized this directory is linked to CONFIG_SECURITYFS.
> This option is not required to be able to run container [1].

You're going to need to handle the case where the file is missing
regardless. It is hard to design a kernel feature based on what a
container expects when there are so many definitions of a container.

> Also, kernel/capability.c is always compiled, so I think it is better if this
> file (i.e. the one which prints capabilities to user) does not depend on any
> CONFIG_.

CONFIG_MULTUSER is going to be an issue if you really care.

> What do you think of it? Does this sound acceptable for you?

Meh. I'm not going to get worked up over it, but your rationale
is a little weak.

>
>>> The goal of this file is to be used by "container world" software to know
>>> kernel capabilities at run time instead of compile time.
>>>
>>> The underlying kernel attribute is read-only and its content is the
>>> capability number associated with the capability name:
>>> root@vm-amd64:~# cat /sys/kernel/capabilities
>>> 0       CAP_CHOWN
>>> 1       CAP_DAC_OVERRIDE
>>> ...
>>> 39      CAP_BPF
>>>
>>> The kernel already exposes the last capability number under:
>>> /proc/sys/kernel/cap_last_cap
>>> So, I think there should not be any issue exposing all the capabilities it
>>> offers.
>>> If there is any, please share it as I do not want to introduce issue with
>>> this series.
>>>
>>> Also, if you see any way to improve this series please share it as it
>>> would
>>> increase this contribution quality.
>>>
>>> Francis Laniel (2):
>>>     capability: Add cap_strings.
>>>     kernel/ksysfs.c: Add capabilities attribute.
>>>    
>>>    include/uapi/linux/capability.h |  1 +
>>>    kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
>>>    kernel/ksysfs.c                 | 18 +++++++++++++
>>>    3 files changed, 64 insertions(+)
>>>
>>> Best regards and thank you in advance for your reviews.
>>> ---
>>> [1] man capabilities
>>> [2]
>>> https://github.com/containerd/containerd/blob/1a078e6893d07fec10a4940a566
>>> 4fab21d6f7d1e/pkg/cap/cap_linux.go#L135 [3]
>>> https://github.com/moby/moby/commit/485cf38d48e7111b3d1f584d5e9eab46a902a
>>> abc#diff-2e04625b209932e74c617de96682ed72fbd1bb0d0cb9fb7c709cf47a86b6f9c1
>>> moby relies on containerd code.
>>> [4]
>>> https://github.com/syndtr/gocapability/blob/42c35b4376354fd554efc7ad35e0b
>>> 7f94e3a0ffb/capability/enum.go#L47 [5]
>>> https://github.com/opencontainers/runc/blob/00f56786bb220b55b41748231880b
>>> a0e6380519a/libcontainer/capabilities/capabilities.go#L12 runc relies on
>>> syndtr package.
>>> [6]
>>> https://github.com/containers/crun/blob/fafb556f09e6ffd4690c452ff51856b88
>>> 0c089f1/src/libcrun/linux.c#L35
>
> Best regards.
> ---
> [1] https://github.com/moby/moby/blob/
> 10aecb0e652d346130a37e5b4383eca28f594c21/contrib/check-config.sh
>
>
