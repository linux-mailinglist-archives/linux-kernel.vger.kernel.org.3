Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EBA48D6E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiAMLrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:47:52 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:52119 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiAMLrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:47:51 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N94uf-1mEvwn1zCZ-0169nN for <linux-kernel@vger.kernel.org>; Thu, 13 Jan
 2022 12:47:50 +0100
Received: by mail-wr1-f47.google.com with SMTP id l25so9533714wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 03:47:50 -0800 (PST)
X-Gm-Message-State: AOAM5324yvPqz/VUG0ev7/i3+I1T23ESeqx/URwwBCDtEQvE/g1Vldqn
        tkVJ6e2r9dp4SKk1h95NAkQqb3l4rGeRRlgVDr4=
X-Google-Smtp-Source: ABdhPJzb++o7mEl0JUsZFNNn3m6fdbZLXZhy0y69c9tneidZNnmp+bkycxivwtp1vUiNmHvh9hJwKnjln77tPfd2M8U=
X-Received: by 2002:adf:d1c8:: with SMTP id b8mr2456597wrd.317.1642074469929;
 Thu, 13 Jan 2022 03:47:49 -0800 (PST)
MIME-Version: 1.0
References: <1641980099-20315-1-git-send-email-anshuman.khandual@arm.com>
 <1641980099-20315-2-git-send-email-anshuman.khandual@arm.com>
 <CAK8P3a1cDF=jEVGchU8LNBdjdtROmHHHpebOASreR=WOuZ4Z1A@mail.gmail.com> <00e28671-8d3a-f789-91c4-109814792a07@arm.com>
In-Reply-To: <00e28671-8d3a-f789-91c4-109814792a07@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Jan 2022 12:47:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Q+iN1O6FEdUJRt=0bQu=6fkWAD3RCECfdhu4DKHq0pg@mail.gmail.com>
Message-ID: <CAK8P3a2Q+iN1O6FEdUJRt=0bQu=6fkWAD3RCECfdhu4DKHq0pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: Add Cortex-X2 CPU part definition
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ujqCp3gAYFlmY+iftBxV0857EDjE/IPmAg4L+WG0pn8EBa5hqxO
 KZPVTRX+ehguH8rph3XBAXF0brsTdunbIYoPp1yKKV640GHFWLGvhpLnHhdc/QsssI97cb4
 zz0onhEtJZjwlg354EfbWQTuoQTn6a9qNtcfXpBm0BffWvsHEhEoK2et0pHdi4grUgGrclW
 Q3jaDzECeXLv/8umrByCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:riUzJJmGYYo=:xZzqPtVRGKA3UzftccTLFy
 7AGycAdbJFDgW+i/rNJucCGytCZfFR/GdzAHgGl/lpZVfS57h4AeAiP89ZVOiyCt1wHWCCTol
 W5XnGYd+Zl4CR8a+ebF9gRhUVBk+jiSOkGM/rbTxFRAOoFYE4i/2Rr7ZAQqec71bgxkHX+GSZ
 QFudA2HNDVW39bMSKAV5VOVPihpFAA5Umf8n741Stk0IKmwOHmL8+JD3zNZPbcK3g12Uuycv/
 LkPGF/ImYIAVa3tnz98KpEmwYrsfFvUr22C5suYr8CCmp3W9zYiOJjXVf8mxV22x13QjPWnkq
 Yl1hbHHVZvRrB0/2Gc+cXaPhv/hBf8tctB3BHdYPisK1V/75b96Zu64j4S9aydD93Oe4ZzKcX
 D9CkZC49PNdS71yDCSBsFHWonpCIA2N4b1P/dLcYjZHgnGBB6RzHhp296ybaGDSuIID7cDNVJ
 v15qdAcs4DhPnm3NSDq7fSklcZySdfX6XDh8Gj2eKq1MxQjxTkZpmT2WnUUc5lpoJwV5Xasfz
 uoHvrIR7mBfpmqMRq4FYG0+NTNwQBeP14EQMAzn0+ta718R9J53K9re0m2/TFWhzVSk0zHrBd
 1aSG1pWwz+hru901XaSyDyha5ntDtnSU/IQZE6s7nCi1skqalZx7dBzEuR4Zr0uzwWwbwty70
 WAhwWEzGVKaIPH08xeTcQt9i/ro4cP4Kdm+jyvoT66V0u7JYMuJv/0YwYTF7lx8Cg/4nQA42y
 uMnU3Xgo0SPwHWuNg8p4JhCYtFUHAXcTEGNCBBct07KjVG83f/vCaWknf2pYBP2CZWYZDY/fG
 issiidON1pXsHqwa6lHTx+i/YT7Z5LaMkug8730PfuP8HT3xbI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 4:03 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> On 1/12/22 4:20 PM, Arnd Bergmann wrote:
> > On Wed, Jan 12, 2022 at 10:34 AM Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> >> Add the CPU Partnumbers for the new Arm designs.
> >> @@ -74,6 +74,7 @@
> >>  #define ARM_CPU_PART_NEOVERSE_N1       0xD0C
> >>  #define ARM_CPU_PART_CORTEX_A77                0xD0D
> >>  #define ARM_CPU_PART_CORTEX_A710       0xD47
> >> +#define ARM_CPU_PART_CORTEX_X2         0xD48
> >>  #define ARM_CPU_PART_NEOVERSE_N2       0xD49
> >
> > No objections to the patch, but would it be possible to just add all the missing
> > ones here to the degree that they are known already? I don't see any entries for
> > Cortex-A34, Cortex-A65AE, Cortex-A78, Cortex-A78C, Cortex-A78AE,
> > Neoverse-E1, Neoverse-V1, Cortex-X1, Cortex-X2, Cortex-A510, Cortex-A710
> > and Cortex-R82 among the Arm-designed cores that can run Linux, and there
> > are probably others that I missed going through the list.
>
> Hi Arnd,
>
> IIUC the part numbers are enumerated here only if there is an errata
> applicable for them which needs to be detected at boot. I am not sure
> whether all cpu versions that can run Linux, needs to be defined here.
> But then I might be missing something.

They clearly don't need to be defined here, and for other constants such
as the system registers we may not want to list them all, but I think for
the CPU IDs it makes sense to just list them all here rather than adding
them one at a time, as we tend to need them sooner or later anyway.

It also helps me personally to have a known place to look up the names
by value rather than chasing through reference manuals.

      Arnd
