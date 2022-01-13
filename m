Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066C048D662
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiAMLKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:10:37 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:42681 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiAMLKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:10:36 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MgzWP-1mgtWB356j-00hJe6; Thu, 13 Jan 2022 12:10:34 +0100
Received: by mail-wm1-f54.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso3381561wmd.5;
        Thu, 13 Jan 2022 03:10:34 -0800 (PST)
X-Gm-Message-State: AOAM532UYgRrjedyMYJ9kQeiJMP2nXippbwlRn5AjslmuTz4S0yHmPnQ
        y15Kt4ItPHIPIq9PS99/B6D8+E1Blyf/iZl0iMQ=
X-Google-Smtp-Source: ABdhPJwyJNjDJe6g9IqOlmOuo4XRBlGbBJ6S5R+pEnE5PJ59so8o5FUGRVoYbyoifHh7K/xwu46GnaSGCZkpF8bZDcs=
X-Received: by 2002:a05:600c:5c1:: with SMTP id p1mr10610658wmd.1.1642072234254;
 Thu, 13 Jan 2022 03:10:34 -0800 (PST)
MIME-Version: 1.0
References: <266065918e47e8965bb6a0ab486da070278788e4.1641996057.git.geert+renesas@glider.be>
 <BY3PR18MB47375336D4AC1FE79D493945C6529@BY3PR18MB4737.namprd18.prod.outlook.com>
 <CAK8P3a2jLgtcuJ6MD7LmJzagiRQSk85eL3tiHDmB33i_n3CZ2w@mail.gmail.com>
 <BY3PR18MB4737E57C0DC616FFE73CC7AEC6529@BY3PR18MB4737.namprd18.prod.outlook.com>
 <CAK8P3a0Eeyt=rWG6CjYCKck-k5+uT5GkLuDG+S4GkQgD49-H1A@mail.gmail.com> <BY3PR18MB47371C7C66042D7982C00474C6539@BY3PR18MB4737.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB47371C7C66042D7982C00474C6539@BY3PR18MB4737.namprd18.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Jan 2022 12:10:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0qxMDFie3SvciMNUOq0G6njqqqVdBOxrXexFWMv+0png@mail.gmail.com>
Message-ID: <CAK8P3a0qxMDFie3SvciMNUOq0G6njqqqVdBOxrXexFWMv+0png@mail.gmail.com>
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
X-Provags-ID: V03:K1:oX0guH3ljFzut7gKm23e+Y4CY4MECr1A1xsq2zK++cTDmOcRwYU
 QNu5wA06Whmt4Z32ZxQ2nPlm5cS1bNfav/pt+lJxx/SReg9o4WGH/igdCkXV74REBSsy03h
 3SMcwNcJ2W1ayFHYCKuDK4o8w+p5DL9W5L1hMQsBBijzvv+2Xg5QBsDcaaQixPrCHIOEwAh
 Lhbvl4kH3HG1B5Kikr5Ag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iMNjJcTUpAA=:D1ue1FXdaKQST6RU9r1o47
 WfpcXTevvRrxdJ0j00QJ+KsdPdK+QPG3EiQ/1cZ+7+yxDqAJHg5mJBTSaLrVXAr7fLsbhi12A
 Lp5rJe3FWPPVZH5i+2B/IbI76/jfgo69feO6odtkQus2NS1R5zpZqIR3Lgd+hEKyRNzrGckM6
 u/fXleuNLM5jFtu1d6fEczduG0kYvbxrgnKeYv2smhuzJqpIewV1rBUlNrujJkb7ZtQC022VR
 mkLILBtoOcxYCkZ6fUDTSb2AdX57WxomwsUJy7BoWmm4Jh8eu0tt454VGuL4HcQcNxSXsoEbb
 h1xU8+6qpEmgWOlt7GpxTtNjoT8hzlVFf9/89Uj1YbLHwEp0DA4nlEkteOWM0R9krLD9asjhi
 RHTFETrkfnmmJO28l6lf3mkdyfrD+ooIJtB0WWJhAkwOq5LHcyi4C+UhULVsaxsuKV8FE0tP7
 Rb3j+QyzqGTIXfmZT+qZdK0MMMzYk8RWCFnDPfKORZDeSjv2ZLRLec8rfS3qWS2vplIQWNaUu
 Dfj1edB+W8H98bVxpLt6AW+4aPkAYmYdd24B925yG8vgv/r9sa2Tfe4jTMCXJlL+Z6T+Eeijk
 t867brBLe2biNqDBA5tKKYfXHYDzOvRALm4fvQ3nitOf17jtWCS3tgl7QkzY3g2RydILFSYzn
 +j6yH9l4U8Uk0IVaRuYY0Kk1H8yTw97Bn49THHuD4ffsY1QPuuL7SSNnYz6mlzBHXQkGiJt7T
 +rnGIXIdAJmA36R+NT9Jm00tmJzYRJuogrvOm6nMzjcBka+GKdwenmzf1DPbMCT5KPMiN3q82
 pownIWxeOm9igJhWYp8eo8GjZ9lNy6ZrVJFhVWGX++JE8HwYRk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 10:42 AM Sunil Kovvuri Goutham
<sgoutham@marvell.com> wrote:
> >From: Arnd Bergmann <arnd@arndb.de>

> >
> >Ok, and those are the same family as the earlier cnMIPS based OCTEON
> >CN3xxx/CN5xxx/CN6xxx/CN7xxx/CNF7xxx and the later ARMv8.2
> >Fusion CNF9xxx, right?
>
> Yes, except the CNF9x.

Ok, what is CNF9x then?

> >> Octeon 10 and OcteonTx2 (9x series) are different families and not related to
> >> Armada as well.
>
> >I assume with '9x' you mean only the CN92xx/CN96xx/CN98xx/CN10x/DPU400
> >family here, not the OcteonTx2 CN91xx that is clearly part of the Marvell
> >Sheeva/Kirkwood/MVEBU/Armada family, and the CN99xx in the
> >Netlogic/Broadcom family.
>
> By 9x I mean CN96xx, CN98xx, CNF9xx, base architecture is same across all.

> >Is there anything that you can say about this product line? It looked like it
> >was derived from the cnMIPS/OcteonTX line, and it seems to share its
> >mystery (presumably ThunderX1-derived rather than Cortex or Vulcan)
> >ARMv8.2 core with the CNF9xxx.
>
> 9x core is Marvell (or Cavium) developed core and is next-gen of 8x.
> 10x and DPU400 have ARM cores.

I don't care about the CPU core, only about the SoC design for the family,
the old octeon family includes both cnMIPS and ThunderX cores already
and those are not even the same ISA, so going from custom ARMv8.2
cores to Neoverse ARMv9 is not relevant at all.

> CN91xx is Armada.

Ok

> >> But I am fine if ARCH_THUNDER is renamed to ARCH_OCTEON to include all.
>
> >I'd really prefer to have sensible names, so if there are six unrelated Marvell
> >SoC families (pxa/mmp, armada/mvebu/cn91xx, xlp/vulcan/thunderx2,
> >berlin/synaptics, cavium/octeon/thunderx/fusion, and whatever turned into
> >non-cavium cn92xx/cn96xx/cn98xx/cn10x/dpu400) instead of five, we should
> >probably have six ARCH_* names for those. (Note: for some other
> >manufacturers such as Broadcom or Mediatek, we do use just the company
> >name as the CONFIG_ARCH_* symbol, but I feel that for Marvell or NXP,
> >that ship has sailed long ago, based on the number of acquisitions and
> >spinoffs).
> >
> >Any suggestions for the name? Were these acquired from some other company?
>
> For OcteonTx2, CN10K and future silicons, ARCH_MARVELL_OCTEON  / ARCH_MRVL_OCTEON ?
> Different ARCH_* config for each family is not needed IMHO.

It does sound like these are all the same family then. Ideally we'd use the same
name as the MIPS based parts, but those currently use
CONFIG_CAVIUM_OCTEON_SOC, which doesn't fit the same naming scheme,
and we seem to have a duplicate set of drivers.

We usually pick shorter names, so I'd just leave it with CONFIG_ARCH_OCTEON
as I have in my current patch. That also means it's less likely to
require a rename
after the next acquisition or spinoff ;-)

        Arnd
