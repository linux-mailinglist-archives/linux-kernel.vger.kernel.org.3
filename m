Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0948CC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344966AbiALThO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:37:14 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:42245 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356853AbiALTgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:36:40 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MI5Dj-1nABbl2dF9-00FFhG; Wed, 12 Jan 2022 20:36:38 +0100
Received: by mail-wr1-f45.google.com with SMTP id k30so6103563wrd.9;
        Wed, 12 Jan 2022 11:36:38 -0800 (PST)
X-Gm-Message-State: AOAM533UC8qhhTcs8GYDJ/+zKBpbNzYYByHcEZn/VBHiev3d1R4yabXf
        +jc+Q9qsqLC/OMyhjE9SDAgwZZdHPpNU6vx368E=
X-Google-Smtp-Source: ABdhPJxROagmxR5J8MlQaHRf+4tU5rG6aldq7qt4ZWTWnEwU5lUja8ML2hO9ZXqsHv5/gtcEfuFOzYdmiXAZiLGLabk=
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr1059496wrw.219.1642016198201;
 Wed, 12 Jan 2022 11:36:38 -0800 (PST)
MIME-Version: 1.0
References: <266065918e47e8965bb6a0ab486da070278788e4.1641996057.git.geert+renesas@glider.be>
 <BY3PR18MB47375336D4AC1FE79D493945C6529@BY3PR18MB4737.namprd18.prod.outlook.com>
 <CAK8P3a2jLgtcuJ6MD7LmJzagiRQSk85eL3tiHDmB33i_n3CZ2w@mail.gmail.com> <BY3PR18MB4737E57C0DC616FFE73CC7AEC6529@BY3PR18MB4737.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB4737E57C0DC616FFE73CC7AEC6529@BY3PR18MB4737.namprd18.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Jan 2022 20:36:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Eeyt=rWG6CjYCKck-k5+uT5GkLuDG+S4GkQgD49-H1A@mail.gmail.com>
Message-ID: <CAK8P3a0Eeyt=rWG6CjYCKck-k5+uT5GkLuDG+S4GkQgD49-H1A@mail.gmail.com>
Subject: Re: [EXT] [PATCH] hwrng: cn10k - HW_RANDOM_CN10K should depend on ARCH_THUNDER
To:     Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Joseph Longever <jlongever@marvell.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:S4HTrNCoawQZl4FCTePxhGeG5TMVCh1mvjOnRdOK0xojB5LuV35
 YDtQFyNVJwaScrDqzJUBhBiyFLrqYEK2GVizWFZ+C8WZWA5c3YYvCNng3NFGltGpNexZtaq
 nifnYvhSTtekV29XeeBU7QGsIl4Ta0Cay/rYPnmlIu5J9N1MCQpwhjraBbgTK9vApumYbOk
 liRZQ5gDBucO2kb6WpFpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:J1D/eof8IkU=:yMx0htCF84rQDTNkpZdJUh
 a+pUKseRnUCUDfaE8wZV7RzEsQ2lwdoD9w/cM93oVD4UxhWTa//joe9rCI/zC5jgotEEtsXIA
 ffMURRQnTQF/uTffGpHKQB5qVb/J9oVpdBbkEhD1X0Af9iINKJlspCMGnwpCbDCvCYF4QPDcE
 LNkYyUpT2y2vmWu9hIB+BMGBZU21yqU60Blo1EKLUxW1C/CNWxHa+lUNmqcK+kwJG1GddsW5j
 1CjWWUU/pkleHzJdWnk8JGyPHJ9qBgzmTL7JHXcup01BDzBwC5OWU9VsLevOIJFNXeKsM6gYM
 YJT/U/s5jub6l1kikF5xYvw7VYnjv5uDVkGOs458AjnDuQ9owhuf4dY6LLvwHI7ba6viN/RmA
 yF5hFgdi9B2yYUq/hhNBSNqE4DQ2LvyM4EpSPK55bTG0BMUzA4k6CiBzpwfVctcTCBLnxd8/j
 dL1viJdhMIGaDOQY677fu0n3oTEB5fMznLpO+5gg22DrJBmm2h8epp6dW2z3Fnv1+hheoFJSA
 MykmOeM6wXVqbAO8NvGL2dJfQryPpjY1WdpHc47xxMJcDv0XhmN5pYJuPSeTSuY+4v0SvDNyI
 U4/0edQwGuYtENW+iF1O70qj6iEiyH9L+vvqCKsX4TvJIfl2U/bv93XkNLhJzT2QLGTZvqzMq
 FxLjmd9aaUK8+sXamjWjBZ/2OJkxUWfgCtiWH4rzYXOgFRnvCxcBJsE9/3vgopobwFIs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 5:34 PM Sunil Kovvuri Goutham
<sgoutham@marvell.com> wrote:
> >Subject: Re: [EXT] [PATCH] hwrng: cn10k - HW_RANDOM_CN10K should depend on ARCH_THUNDER
> >On Wed, Jan 12, 2022 at 4:55 PM Sunil Kovvuri Goutham <sgoutham@marvell.com> wrote:
> >config ARCH_OCTEON
> >        bool "Marvell OCTEON and ThunderX data processing units"
> >       help
> >          This enables support for Marvell (formerly Cavium) OCTEON
> >          Family of DPUs and SoCs, including OCTEON 10, Octeon TX2
> >          CN92xx/CN96xx/CN98xx, OcteonTX CN8xxx, ThunderX CN88xx, and
> >          Octeon Fusion products.
> >
> >          Note: these are unrelated to the similarly named ThunderX2
> >         CN99xx server processors, the Octeon TX2 91xx SoCs and the
> >          Armada processors.
> >
> >config ARCH_THUNDER2
> >        bool "Marvell/Cavium ThunderX2 Server Processors"
> >        select GPIOLIB
> >        help
> >          This enables support for Marvell's discontinued ThunderX2
> >          CN99XX family of server processors, originally sold by Cavium.
> >
> >          Note: these do not include the unrelated ThunderX CN88xx or
> >          OCTEON TX2 processors, despite the similarities in naming.
> >
> >config ARCH_MVEBU
> >        bool "Marvell EBU SoC Family"
> >        help
> >          This enables support for Marvell EBU familly, including:
> >           - Armada 3700 SoC Family
> >           - Armada 7K SoC Family
> >           - Armada 8K SoC Family
> >           - Octeon TX2 CN91xx Family
> >
> >If that's not the correct interpretation, does that mean that OCTEON 10
> >and Octeon TX2 CN92xx/CN96xx/CN98xx are a different family from
> >Octeon/TX CN8xxx and ThunderX CN88xx and should have a fourth
> >symbol, or are they part of the Armada family?
>
> OcteonTx (8xx) are derivatives of ThunderX.

Ok, and those are the same family as the earlier cnMIPS based OCTEON
CN3xxx/CN5xxx/CN6xxx/CN7xxx/CNF7xxx and the later ARMv8.2
Fusion CNF9xxx, right?

> Octeon 10 and OcteonTx2 (9x series) are different families and not related to
> Armada as well.

I assume with '9x' you mean only the CN92xx/CN96xx/CN98xx/CN10x/DPU400
family here, not the OcteonTx2 CN91xx that is clearly part of the Marvell
Sheeva/Kirkwood/MVEBU/Armada family, and the CN99xx in the
Netlogic/Broadcom family.

Is there anything that you can say about this product line? It looked like it
was derived from the cnMIPS/OcteonTX line, and it seems to share its
mystery (presumably ThunderX1-derived rather than Cortex or Vulcan)
ARMv8.2 core with the CNF9xxx.

> But I am fine if ARCH_THUNDER is renamed to ARCH_OCTEON to include all.

I'd really prefer to have sensible names, so if there are six unrelated Marvell
SoC families (pxa/mmp, armada/mvebu/cn91xx, xlp/vulcan/thunderx2,
berlin/synaptics, cavium/octeon/thunderx/fusion, and whatever turned into
non-cavium cn92xx/cn96xx/cn98xx/cn10x/dpu400) instead of five, we should
probably have six ARCH_* names for those. (Note: for some other
manufacturers such as Broadcom or Mediatek, we do use just the company
name as the CONFIG_ARCH_* symbol, but I feel that for Marvell or NXP,
that ship has sailed long ago, based on the number of acquisitions and
spinoffs).

Any suggestions for the name? Were these acquired from some other
company?

        Arnd
