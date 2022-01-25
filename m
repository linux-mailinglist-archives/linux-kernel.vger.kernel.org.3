Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974C449BDCE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiAYVUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:20:16 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:49121 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232080AbiAYVUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:20:13 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id CF89A320221C;
        Tue, 25 Jan 2022 16:20:12 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Tue, 25 Jan 2022 16:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=+XK7GOa+swOf6r
        z0G8CH7ag+vxD78I6t78GKfVKq1vk=; b=UvlJQsPNCXxmaCiICA/7jaRTtFrecu
        Hx2gVkqd1+/dZ6CkHJICzKJIQxQUb7tSVi8I/gvRJOQNgXjy7A7sVbNkF3YSCsFb
        f6c5z5fBw+rq7vfbHN8yt18s1521sC5u4HWPEN3XFPhRYgCTfJEWWFcVPASFiqaG
        H+7wd68GLLEJ5GKfjqKgIpetR2PVO5qdUeQbEwIZBVGSXK6TgALqHPaScsTBn1xD
        4dfQhCyFS00s4mY/nCYlXtPLnEgsNwjTVr/smDvUDHf4kspFBz5llGBcnjqGKH9K
        AiCZWlsYCHvLMKrnKurAGW7BLTCDgj3h15Bb/DNvr7cRxXQXkKC6PkGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=+XK7GOa+swOf6rz0G8CH7ag+vxD78I6t78GKfVKq1
        vk=; b=JrsA0goGqbTCCr9ziSbHxc85qV+ODJjBOgruqSzNSQ8FPcrUApy1N+ipr
        zOGd5j+3M96puO3A4ZviMZ36GulvR5U7OcxNX44j4FpHwqDnsn+jfTbsbih379oI
        zmfGEYOqu5M5SXFAEuC0OJHE2UxtB+Oi0lySy9Kp/k8NkjokxgdIMl3qYYhbOIrq
        xIlSbq3raHB3IDqOxzLCE7mATVmGvZMpy8RZTW2x09jqg1BqdZcaCM58ZYEFrVGA
        W4RJy3XTeAMB6zs7CddW3xtXTGcX24G1v1OQyQ88Wx5ErBTcwl5a7Y4jcLo8w2JQ
        zWfnmCD5HbWGK7rsANAcfX3MUjv/g==
X-ME-Sender: <xms:i2nwYVHBj5E_niaaiUdzZ9jWnZRXmnmPACXQZ5JUWAjsQgXzcQuu1g>
    <xme:i2nwYaUxht7_jqQT3_RHaEhcFiLYCaibX6rc9PSod9fjBkkagl6j8eKNcADiF5mC9
    eKj7DriAfnaZ3sEA6Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdelgddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepfeetgeekveeftefhgfduheegvdeuuddvieefvddvlefh
    feehkeetfeeukedtfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:i2nwYXK5OSErPqTYGWkRbdQ_k5-ERBLH21uZgLGBZqhetRjk9hH5DA>
    <xmx:i2nwYbHNKxib6l3IEptB75CbcCvjLnV48Wh8YaFyj2B04Ixafvyy3w>
    <xmx:i2nwYbVe4_6KotsacmvADn25bUlRxHuVK1OjvLaGc1Sg421knZK-zw>
    <xmx:jGnwYRyOq5tkVnCmDSsrYpuOmVuKcvMnClKDHfO1ttVMRys4prg8Mw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BD4E2FA0AA6; Tue, 25 Jan 2022 16:20:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4585-ga9d9773056-fm-20220113.001-ga9d97730
Mime-Version: 1.0
Message-Id: <525d4804-7cc4-49b7-9427-cb278c8e40e8@www.fastmail.com>
In-Reply-To: <Ye9Rk4y9Ck7Bg5pv@dev-arch.archlinux-ax161>
References: <20220120214001.1879469-1-nathan@kernel.org>
 <CAKwvOd=4QBW5uFLM7zbHfG+5499tT_zqBTaZQgzqegmuq_5+MQ@mail.gmail.com>
 <c88b0d87-b238-4889-b033-226bed85bb01@www.fastmail.com>
 <Ye9Rk4y9Ck7Bg5pv@dev-arch.archlinux-ax161>
Date:   Tue, 25 Jan 2022 21:19:48 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Nathan Chancellor" <nathan@kernel.org>
Cc:     "Nick Desaulniers" <ndesaulniers@google.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] MIPS: Loongson64: Clean up use of cc-ifversion
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82022=E5=B9=B41=E6=9C=8825=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=E5=
=8D=881:25=EF=BC=8CNathan Chancellor=E5=86=99=E9=81=93=EF=BC=9A
[...]
>
> So something like this (completely untested)?

Yep, tested with multiple GCC toolchains and it works :-)

Thanks.

>
> diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Plat=
form
> index 3e660d6d3c2b..36ab2fe00835 100644
> --- a/arch/mips/loongson64/Platform
> +++ b/arch/mips/loongson64/Platform
> @@ -5,24 +5,9 @@
>=20
>  cflags-$(CONFIG_CPU_LOONGSON64)	+=3D -Wa,--trap
>=20
> -#
> -# binutils from v2.25 on and gcc starting from v4.9.0 treat=20
> -march=3Dloongson3a
> -# as MIPS64 R2; older versions as just R1.  This leaves the=20
> possibility open
> -# that GCC might generate R2 code for -march=3Dloongson3a which then =
is=20
> rejected
> -# by GAS.  The cc-option can't probe for this behaviour so=20
> -march=3Dloongson3a
> -# can't easily be used safely within the kbuild framework.
> -#
> -ifeq ($(call cc-ifversion, -ge, 0409, y), y)
> -  ifeq ($(call ld-ifversion, -ge, 22500, y), y)
> -    cflags-$(CONFIG_CPU_LOONGSON64)  +=3D \
> -      $(call cc-option,-march=3Dloongson3a -U_MIPS_ISA=20
> -D_MIPS_ISA=3D_MIPS_ISA_MIPS64)
> -  else
> -    cflags-$(CONFIG_CPU_LOONGSON64)  +=3D \
> -      $(call cc-option,-march=3Dmips64r2,-mips64r2 -U_MIPS_ISA=20
> -D_MIPS_ISA=3D_MIPS_ISA_MIPS64)
> -  endif
> -else
> -    cflags-$(CONFIG_CPU_LOONGSON64)  +=3D \
> -      $(call cc-option,-march=3Dmips64r2,-mips64r2 -U_MIPS_ISA=20
> -D_MIPS_ISA=3D_MIPS_ISA_MIPS64)
> +ifdef CONFIG_CPU_LOONGSON64
> +cflags-$(CONFIG_CC_IS_CLANG) +=3D -march=3Dmips64r2
> +cflags-$(CONFIG_CC_IS_GCC) +=3D -march=3Dloongson3a
>  endif
>=20
>  # Some -march=3D flags enable MMI instructions, and GCC complains abo=
ut that
>
>> >
>> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>> >
>> >> ---
>> >>  arch/mips/loongson64/Platform | 13 +++----------
>> >>  1 file changed, 3 insertions(+), 10 deletions(-)
>> >>
>> >> diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/=
Platform
>> >> index 3e660d6d3c2b..981d3abc150e 100644
>> >> --- a/arch/mips/loongson64/Platform
>> >> +++ b/arch/mips/loongson64/Platform
>> >> @@ -12,17 +12,10 @@ cflags-$(CONFIG_CPU_LOONGSON64)     +=3D -Wa,-=
-trap
>> >>  # by GAS.  The cc-option can't probe for this behaviour so -march=
=3Dloongson3a
>> >>  # can't easily be used safely within the kbuild framework.
>> >>  #
>> >> -ifeq ($(call cc-ifversion, -ge, 0409, y), y)
>> >> -  ifeq ($(call ld-ifversion, -ge, 22500, y), y)
>> >> -    cflags-$(CONFIG_CPU_LOONGSON64)  +=3D \
>> >> -      $(call cc-option,-march=3Dloongson3a -U_MIPS_ISA -D_MIPS_IS=
A=3D_MIPS_ISA_MIPS64)
>> >> -  else
>> >> -    cflags-$(CONFIG_CPU_LOONGSON64)  +=3D \
>> >> -      $(call cc-option,-march=3Dmips64r2,-mips64r2 -U_MIPS_ISA -D=
_MIPS_ISA=3D_MIPS_ISA_MIPS64)
>> >> -  endif
>> >> +ifeq ($(CONFIG_CC_IS_GCC)$(call ld-ifversion, -ge, 22500, y), yy)
>> >> +  cflags-$(CONFIG_CPU_LOONGSON64) +=3D -march=3Dloongson3a -U_MIP=
S_ISA -D_MIPS_ISA=3D_MIPS_ISA_MIPS64
>> >>  else
>> >> -    cflags-$(CONFIG_CPU_LOONGSON64)  +=3D \
>> >> -      $(call cc-option,-march=3Dmips64r2,-mips64r2 -U_MIPS_ISA -D=
_MIPS_ISA=3D_MIPS_ISA_MIPS64)
>> >> +  cflags-$(CONFIG_CPU_LOONGSON64) +=3D -march=3Dmips64r2
>> >>  endif
>> >>
>> >>  # Some -march=3D flags enable MMI instructions, and GCC complains=
 about that
>> >>
>> >> base-commit: 2c271fe77d52a0555161926c232cd5bc07178b39
>> >> --
>> >> 2.34.1
>> >>
>> >
>> >
>> > --=20
>> > Thanks,
>> > ~Nick Desaulniers
>>=20
>> --=20
>> - Jiaxun

--=20
- Jiaxun
