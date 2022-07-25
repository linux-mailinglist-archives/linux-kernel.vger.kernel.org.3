Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A25D5800A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiGYOWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiGYOWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:22:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EFC167C2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:22:42 -0700 (PDT)
Received: from mail-ed1-f47.google.com ([209.85.208.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N0o3X-1nJuB32no5-00wiVn for <linux-kernel@vger.kernel.org>; Mon, 25 Jul
 2022 16:22:40 +0200
Received: by mail-ed1-f47.google.com with SMTP id x91so14181731ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:22:40 -0700 (PDT)
X-Gm-Message-State: AJIora/M9UMML4cUh5zgpPlPBCDuuryI4X9Ss9U3loIVyvjlnTwW7g0I
        QKT/8VZlAgaxSpGgJCPf3b7onmbVFIoT3xSGk6s=
X-Google-Smtp-Source: AGRyM1s2D8V5GQidovTCjEsN5J6TDfyCGeQYf90VamdInH5SBM48LWGGlcNHnEnjLsAHBe5C/yK484ns9dg/F49ME3k=
X-Received: by 2002:a50:ee13:0:b0:43b:aadb:a8cd with SMTP id
 g19-20020a50ee13000000b0043baadba8cdmr13542983eds.206.1658758960318; Mon, 25
 Jul 2022 07:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com>
 <25237c44-ebc4-fc9a-7c6f-3e990f968038@huawei.com> <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
 <4d5c9bfc-dc10-7019-cad4-751e21f02a18@huawei.com>
In-Reply-To: <4d5c9bfc-dc10-7019-cad4-751e21f02a18@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Jul 2022 16:22:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3QNjOSodb-ND=nZ=ThC9xZhEyUOaUsWCDF70s9g80r-w@mail.gmail.com>
Message-ID: <CAK8P3a3QNjOSodb-ND=nZ=ThC9xZhEyUOaUsWCDF70s9g80r-w@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64 defconfig: Get faddr2line working
To:     John Garry <john.garry@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        jpoimboe@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:uzENa2y0iR38I9xKxxXQNsFjXTgBXLPvyt1lMTnczlCLYrpa07E
 4GQHSvDLwjZnSZBdyeLTKN5/GQwn9p2bCUcmvn6QVBIQrpqDQAjXhS799EdBiMC8nfEFc6u
 IqaLxCYqL04bVCriJuTcbddETo3XOG/y0o+22AmGDRrRj/Im551ta4UPGtoMs7szeQYrbIX
 wssUfRjxuHMTXlp/VsPJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eMamlP4P4pc=:YNtUVFJlMQXCMVcHbq2Yi3
 Cuepgk/Z/8P+MCti5/Tlb4SVCV8G5deOMTodTHSocOQR8z1fiEr4QH/MB22Uccho0ekBoO4Em
 JnSoM2e6zymtKir+AmfL8x6lMnnqt2ZFnyECHTcrK9RQflEV1Rd8RXOkn0Ro/J/JX5c0QSe1j
 qlWEb13rqQ3UKRBvDVJyaqxlJoOosCG7yi/69qVAlAIii4mUNtxngEkZtAqY5RWkRF6ovMxq4
 9xR8ty8+whpZizcn3fJwXlRw4ifrela6u6begChqwYRXFEct96QloCq48N/cGJrU2knoHWJ1F
 1EiM6Ob25OXhFWxeBLIws59kl03zA++tq3vPh3F4EjEkmZBhTdKmmjZyyc5a4dAdCZOV9n+Gf
 3gR/dgq9t9O6p6RgjuoAmcDisTlcPeqlID3e6TD3CY4ayic/RumdNfWS5uP84CClvXWZOLzf9
 NX5ZeDEt2qhRB6kHDBZ+LvuicOvisLU+yRVoA1ci6gfSCkaQj/UyVYB9F3nxOSF6U47BFjXDk
 26bhDLF24OMOJe+UhFDd4HoZfC/qmmE/g85vG5GycnV7veRAOBABWzgdu5xIpVcehSRvazpRX
 UxtAdukX3Dz16I85SmG/m/80Xzb8lIltVhPVgYJQ5A1N8qu9Z78zRtKJ/omzyYZvDaX4hGUgC
 53Y8b5pnICrtVLyLUvOpOW4lBzp8naobVHCZg64MTmkaZdFr8bPA7GDmq3jivUI/QOQZ8WoMg
 JkkzTxaRg8mg0R7rQUdyfEcvLNzWn9D2raoaNiZEqyFfVNtnGAnEGndrBQVQTzmSn3J/6gqLJ
 c2usBBYokAxw+IgL/zSRihh7w8lhJm3IAFA+CZvYHKEOp1Z14tX73rcTjI8B6UVDCxsaeOBZa
 oGBbiB3jsoQ+eDuNqzRQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 4:03 PM John Garry <john.garry@huawei.com> wrote:
> >
> >>> CONFIG_MAILBOX=y
> >> In commit fc739069aa92, config MAILBOX was enabled in the defconfig but
> >> it was already being enabled from elsewhere. There was definitely no
> >> sync of the savedefconfig going on there:)
> > I see it's selected by a couple of drivers using mailboxes, and I
> > agree we shouldn't
> > need it here. It might be good to just hide the symbol in this case
> > and select it
> > consistently from all drivers using it.
>
> Uhh, we have ~15x "select" and ~18x "depends on"...

> >>> CONFIG_INTERCONNECT=y
> >> Since commit 06f079816d4c, config TEGRA_MC added a kconfig select on
> >> config INTERCONNECT, so no need to explicitly enable from the kconfig
> > We have one driver using 'depends on INTERCONNECT' and two drivers
> > using 'select INTERCONNECT', so at least one of them is wrong.
>
> INTERCONNECT has no dependencies, so "select" - like for MAILBOX -
> should be fine, I suppose

There are a couple of trade-offs between the two approaches.
The main advantage of 'select' is that you can enable drivers more
easily and all the required subsystems are there automatically.
The advantage of 'depends on' is that it becomes easier to disable
entire subsystems that one may not need.

Which of those two is more important is of course a matter of perspective,
I like to be able to turn things off more easily because that makes it
possible to test the corner cases with randconfig more easily, and it
helps produce size-reduced kernels for embedded systems.

Another aspect is that we overall have more 'depends on' than 'select',
and sticking with the more common way avoids circular dependencies,
both within an area of the kernel and overall.

The rule that I tend to follow with 'select' is to only use it on symbols
that you don't even want to show to users. If a feature is part of
a library (think zlib), then each user just needs to select the symbol
but you never actually have to decide whether to show it or not.

> >> And would each config item deletion merit a separate patch?
> > You send a combined patch for the obvious ones (secccomp
> > and mailbox AFAICT) or send them separately. For the other ones I think
> > we should try fixing the Kconfig files first, otherwise we just end up
> > putting them back afterwards.
>
> ok, fine. I'll deal with the obvious changes first plus
> CONFIG_DEBUG_INFO and then the non-obvious, non-trivial ones. I'll base
> on your arm/defconfig branch (for defconfig changes).

The CONFIG_DEBUG_INFO one should be fixed by my series from
last week already, do you still see another issue with that? I actually
have another patch to fix up all the non-Arm defconfigs for this one as
well, but haven't sent that one yet.

     Arnd
