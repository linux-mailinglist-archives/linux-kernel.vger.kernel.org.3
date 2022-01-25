Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0F049ADDE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449462AbiAYIR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448621AbiAYIPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:15:23 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD2DC0A6ECD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 22:46:32 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v186so58832593ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 22:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s9eUukAZSoXLwfwoNX3OA+1nnkr3K0zvB1fY8vDJD/s=;
        b=hhcPlTxEhl1jkQVwAiq8iZtSSvjbikyRy/5M5ftUybRFLKNr+wkd638MtTiXC78Nj5
         X4bEJ3F1Nqrz6Aulgth/9t9VN34smaPhUp1SpNyDs8ddwYo+E/pYy7wfdnTJvLVR7T0Z
         RfJrS5FEssK5CRVJvrx09lyZbv1nbPNQbxCWsqNL0pf9chJLUiv72M46ArHL1+OWqNMs
         CXDTJr9YcnDpdn+U2ZU80r98Mxj8H7rrYGpNT1GdoAKxfPk8Vmk0DfVGsxVb9nlGkKvE
         xVEN49T9h8LEGRFik1QqnKvPg5RKmGyM7DPAfs4l4G/gGYFQebXrK+IdOm+Uc8tsXRBR
         jpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s9eUukAZSoXLwfwoNX3OA+1nnkr3K0zvB1fY8vDJD/s=;
        b=pD9IZdI5oAfpZg9s0B1AXdFgsygHGTSGcZ+plqQDDlZbuR0iCnhybfEvezzBLhJ/JY
         5gCN8UMx7wS8zBHXvrWjv7U8Xbi+VCD063bLB8ImVpm462mEHEqIyGb5fkJHo5K7Y9n7
         sewubne/E9QxLfu5i2EgKLx6UafcCmqcvYzgbDOnclekj6Vlt+g176QXnLQLPmaTgUM9
         ho0QPWwGJ/stLG0TCsTgbZXihEXL3jLq74+Fmy8RJiGuDXrWOR4X2ycvnmWixpF+r4k3
         fqt+5HSzh43+Cnkj+vOkouXRTHpWk18sxBrR/rUNmH8Eewuo2c0CPGGENvCW6Dv+0qbq
         ndpA==
X-Gm-Message-State: AOAM53140fHB6wdbgrhCWgqf8WbvjVeWNDYJMRllbvNipt6TjMz1gxj3
        SZ6Up5HnS5nb7BWbs9xJq4EqoKxeebJuhTjaTMjg3w==
X-Google-Smtp-Source: ABdhPJw2CF2jZmEZwNN6xF7zrJVv6SzcNU/D8oujCUYOSKItda8dOoLF90Mga93UTxPElvHu8X1PlYLBG4YB9RVqFuM=
X-Received: by 2002:a81:130a:0:b0:2ca:287c:6d64 with SMTP id
 00721157ae682-2ca2c52ec13mr4426817b3.521.1643093191437; Mon, 24 Jan 2022
 22:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20220124184100.867127425@linuxfoundation.org> <374e9357-35eb-3555-3fe5-7b72c3a77a39@linaro.org>
 <ef6a4bcf-832b-3a5d-9643-827239293772@linaro.org>
In-Reply-To: <ef6a4bcf-832b-3a5d-9643-827239293772@linaro.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Jan 2022 12:16:20 +0530
Message-ID: <CA+G9fYtTU_7DVaxwbLWnKBfqwbW51ebEoP=+vah7f6cWYSrKkQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/846] 5.15.17-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, stable@vger.kernel.org,
        Russell King <russell.king@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 at 09:09, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wro=
te:
>
> Hello!
>
> On 1/24/22 16:50, Daniel D=C3=ADaz wrote:
> > Hello!
> >
> > On 1/24/22 12:31, Greg Kroah-Hartman wrote:
> >> This is the start of the stable review cycle for the 5.15.17 release.
> >> There are 846 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, pleas=
e
> >> let me know.
> >>
> >> Responses should be made by Wed, 26 Jan 2022 18:39:11 +0000.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5=
.15.17-rc1.gz
> >> or in the git tree and branch at:
> >>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git linux-5.15.y
> >> and the diffstat can be found below.
> >>
> >> thanks,
> >>
> >> greg k-h
> >

Regressions detected on arm, arm64, i386, x86 on 5.15 and 5.10

> >
> > This is one from arm64:
> >    /builds/linux/arch/arm64/mm/extable.c: In function 'fixup_exception'=
:
> >    /builds/linux/arch/arm64/mm/extable.c:17:13: error: implicit declara=
tion of function 'in_bpf_jit' [-Werror=3Dimplicit-function-declaration]
> >       17 |         if (in_bpf_jit(regs))
> >          |             ^~~~~~~~~~
> >    cc1: some warnings being treated as errors
> >    make[3]: *** [/builds/linux/scripts/Makefile.build:277: arch/arm64/m=
m/extable.o] Error 1
>
> Bisection here pointed to "arm64/bpf: Remove 128MB limit for BPF JIT prog=
rams". Reverting made the build succeed.

arm64/bpf: Remove 128MB limit for BPF JIT programs
commit b89ddf4cca43f1269093942cf5c4e457fd45c335 upstream.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

> Greetings!
>
> Daniel D=C3=ADaz
> daniel.diaz@linaro.org
>
