Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFA349A7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315440AbiAYCxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:53:25 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41253 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2370182AbiAYADy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:03:54 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6F7365C0062;
        Mon, 24 Jan 2022 19:03:53 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Mon, 24 Jan 2022 19:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=xrVlhzn9aqAvyt
        XYY/7c6YYYVRGhNM6WvivtbLM07nw=; b=iq7pi02PS8sL3wMUrWNyF5p7h24mDK
        sM3thbyjTfoF7TylAYssOVXZtD9s+jCqJ0TwGcUTBTEHbmCJtTzqeh0ZC7PGZdnC
        DnvYqeLd13a5LAWuX15LfuI3UAEyCfpLWDZokM1cXwVr1grQiM/pPVZ+hK9Nq1we
        miFX4xyrtWqIYb/xhy9xnTs5ZnZqcBdxOuA9bO3gxhjAeuSwvb+RzDyTfuv22Cny
        Jx4wt3qz5Df1pHMIfkK4UH6kwVMuBXc3hEJ2RThHzpUC8eCEZxWcOfB7kQ5XYmXZ
        hp6F19TgshFiN/QqifsCsc0g/eKlYYxRno1UCJbqcG15SlVJRJIn2OWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=xrVlhzn9aqAvytXYY/7c6YYYVRGhNM6WvivtbLM07
        nw=; b=aN0JG3UjJA56Pt3PMsJFofak4UiP4GBcbYFIt+naPgqfyYg/s4cPGtPyo
        YnNhdaT7JclRWvreVn2Jf+JudWggWln8T/T3X4sZu0scOCtI1bnTQDIZbJTzS072
        7Jl9ntDcFEyKkWfnFP6brtx+WDW7l6MLYG6d1gLckM9r9venKRZj5iz1oBAAE8e5
        JBQWDCOYI93f7AvVQxjl+YhqXMySbTs0UbAVy4ARvsmYcHMXTU3mb1XMIYI7vmp2
        sWc4XfmI9pVaIgXxuLGMQKk9b40UWuFCbHU4ym6vQNBDaGfDF5Sv2036QrToO+Zl
        OeJYPtp/VUvb2bnuA5JJ3QfFNqUhA==
X-ME-Sender: <xms:aT7vYQy7RALPBf3IQRAxeZXGRB5ziOOcPbJybZbHOBS7jhK2O94REQ>
    <xme:aT7vYUSIVtYt8J3NH4EyjNQYvD3oRGuVIZ-rwanFt7S_ytctiUACJZ3Eq_UHzxRU7
    jr6ZMV1HxN-J8f-hXY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdekgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeefteegkeevfeethffgudehgedvueduvdeifedvvdelhfef
    heekteefueektdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:aT7vYSV1VY_-rDLXexeWyX8qYkX78SD2hCk_PvuHn80ggXwsQMEfvg>
    <xmx:aT7vYeiKoSdInKeM3dd12OH62u5k8MciwxOfivc5lGWbKXlJaxYSKQ>
    <xmx:aT7vYSBZuHwpGZxH-MRl3r5m0Ei-Xc5gicij4-B48qOGw0VG9PZNZg>
    <xmx:aT7vYV_ro25vKsYJago2ixa0Ls4DLvaiunrlEiYT-WB6Mf6u_VamDw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 154A5FA0AA6; Mon, 24 Jan 2022 19:03:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4585-ga9d9773056-fm-20220113.001-ga9d97730
Mime-Version: 1.0
Message-Id: <c88b0d87-b238-4889-b033-226bed85bb01@www.fastmail.com>
In-Reply-To: <CAKwvOd=4QBW5uFLM7zbHfG+5499tT_zqBTaZQgzqegmuq_5+MQ@mail.gmail.com>
References: <20220120214001.1879469-1-nathan@kernel.org>
 <CAKwvOd=4QBW5uFLM7zbHfG+5499tT_zqBTaZQgzqegmuq_5+MQ@mail.gmail.com>
Date:   Tue, 25 Jan 2022 00:03:32 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc:     "Huacai Chen" <chenhuacai@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] MIPS: Loongson64: Clean up use of cc-ifversion
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82022=E5=B9=B41=E6=9C=8824=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=E5=
=8D=888:31=EF=BC=8CNick Desaulniers=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Jan 20, 2022 at 1:40 PM Nathan Chancellor <nathan@kernel.org> =
wrote:
>>
>> This Makefile checks that GCC is 4.9 or newer, which is redundant aft=
er
>> commit 76ae847497bc ("Documentation: raise minimum supported version =
of
>> GCC to 5.1"), so cc-option can be removed.
>>
>> Clang does not support -march=3Dloongson3a so it needs to continue to=
 use
>> -march=3Dmips64r2, along with binutils less than 2.25, so check that =
both
>> GCC and binutils 2.25 or newer are being used before using
>> -march=3Dloongson3a. These flags do not need to be checked with cc-op=
tion
>> anymore because all GCC versions support -march=3Dloongson3a and
>> -march=3Dmips64r2 and all clang versions support -march=3Dmips64r2.
>>
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>
> Thanks for the patch. I wonder why `_MIPS_ISA` only seems to be set at
> all for `-march=3Dloongson3a` AFAICT, though that question is orthogon=
al
> to this patch. Perhaps the Loongson or MIPS maintainers know more?
> Otherwise seems like most uses of _MIPS_ISA can either be deleted or
> simplified now.

This is because earlier GCC mistakenly set loongson3a to MIPS64 not MIPS=
64R2.

But given that it's earlier than the minimal requirement GCC of kernel t=
oday, I think it should be safe to just move the whole logic.

Thanks.

>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
>> ---
>>  arch/mips/loongson64/Platform | 13 +++----------
>>  1 file changed, 3 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Pla=
tform
>> index 3e660d6d3c2b..981d3abc150e 100644
>> --- a/arch/mips/loongson64/Platform
>> +++ b/arch/mips/loongson64/Platform
>> @@ -12,17 +12,10 @@ cflags-$(CONFIG_CPU_LOONGSON64)     +=3D -Wa,--tr=
ap
>>  # by GAS.  The cc-option can't probe for this behaviour so -march=3D=
loongson3a
>>  # can't easily be used safely within the kbuild framework.
>>  #
>> -ifeq ($(call cc-ifversion, -ge, 0409, y), y)
>> -  ifeq ($(call ld-ifversion, -ge, 22500, y), y)
>> -    cflags-$(CONFIG_CPU_LOONGSON64)  +=3D \
>> -      $(call cc-option,-march=3Dloongson3a -U_MIPS_ISA -D_MIPS_ISA=3D=
_MIPS_ISA_MIPS64)
>> -  else
>> -    cflags-$(CONFIG_CPU_LOONGSON64)  +=3D \
>> -      $(call cc-option,-march=3Dmips64r2,-mips64r2 -U_MIPS_ISA -D_MI=
PS_ISA=3D_MIPS_ISA_MIPS64)
>> -  endif
>> +ifeq ($(CONFIG_CC_IS_GCC)$(call ld-ifversion, -ge, 22500, y), yy)
>> +  cflags-$(CONFIG_CPU_LOONGSON64) +=3D -march=3Dloongson3a -U_MIPS_I=
SA -D_MIPS_ISA=3D_MIPS_ISA_MIPS64
>>  else
>> -    cflags-$(CONFIG_CPU_LOONGSON64)  +=3D \
>> -      $(call cc-option,-march=3Dmips64r2,-mips64r2 -U_MIPS_ISA -D_MI=
PS_ISA=3D_MIPS_ISA_MIPS64)
>> +  cflags-$(CONFIG_CPU_LOONGSON64) +=3D -march=3Dmips64r2
>>  endif
>>
>>  # Some -march=3D flags enable MMI instructions, and GCC complains ab=
out that
>>
>> base-commit: 2c271fe77d52a0555161926c232cd5bc07178b39
>> --
>> 2.34.1
>>
>
>
> --=20
> Thanks,
> ~Nick Desaulniers

--=20
- Jiaxun
