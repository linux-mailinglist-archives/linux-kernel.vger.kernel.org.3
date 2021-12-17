Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0780F479102
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhLQQLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:11:02 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:35807 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbhLQQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:11:01 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N8EdM-1mTKs81bE0-014FWh for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021
 17:11:00 +0100
Received: by mail-wr1-f52.google.com with SMTP id o13so4943633wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:11:00 -0800 (PST)
X-Gm-Message-State: AOAM533riPdPCbNJab1yTwIE1YI1K9gXUAvFH/llIpT3fojmLwSNgjCb
        hT/jn8t/hI0o7QrxK1Q7THg4kaFa7lFVhC5Rk/k=
X-Google-Smtp-Source: ABdhPJyRMqlCm9oM4/6HkLIIRw91n15vAuP9POgQRnbi3DunXAWqw7Gf6RA2oyTa80FOiPp7vdpBNgSC57+ieFUaBHk=
X-Received: by 2002:a5d:6989:: with SMTP id g9mr3049267wru.12.1639757460078;
 Fri, 17 Dec 2021 08:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20211217154921.cagzppcensxx6wm4@pension> <20211217160007.etfr5urg76j2n5sf@reissue>
In-Reply-To: <20211217160007.etfr5urg76j2n5sf@reissue>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Dec 2021 17:10:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0nPN=e1QaLPaf5TLJgj19SE5OQ2D3YWM2KepM6r+oh7Q@mail.gmail.com>
Message-ID: <CAK8P3a0nPN=e1QaLPaf5TLJgj19SE5OQ2D3YWM2KepM6r+oh7Q@mail.gmail.com>
Subject: Re: [GIT PULL] soc: Keystone driver update for v5.17
To:     Nishanth Menon <nm@ti.com>
Cc:     Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:khIznMWAb5ff6hMhoC4t9PtxjpYl5T1to0LldVNrepbQ0hhJNVT
 JkTsMuGVHmAZkX+PoZGgJXAgXWApOQO3kxewZ6lIGoJDFXlSIZvvyFwHi9+T8fA7lhCSECV
 5A2TOI32awGdpe2cdmmm+DcH+QKMcjC8MRjq5bZXIrkoPuP31XCJC/hrNDvPOQLBgYQzkLO
 5uBPDdddU8lb50C92Yp9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8pyfk2jgoSg=:RO83jI12CeVoXVdL/rn+9F
 OJaCgU/hqvrNRBpAHekR8ccXzeJccr/gRb4pBPOIUI0oOa5xQuqAqxFOYbSdqLgG/zM++33KV
 gyjRaAqPZYeOVscchUzVPqVSQJobJSHDf8MRVCcBYyq+AA0CFEw6XENaK59F8RMd4Q8eLOYJG
 3XmD25rBR80k9cGR01frSIMd9nlAQ4aWdPR8tX21Pa2N/GkOP03hWPa6N3/s0HhoGEOalXREG
 yVh/kOTlzr/B8HWTwaM9I2gA6EA4Sek+iHWF/rCE5/z6BqYL4sfZumThzO9wPuCsH/0HkIGlU
 XnngKuloilX7H2N4mr8bIci+vfGV4VfGfHPOMPGTJQEzwXIQuVRFahogSddXRq4ip38vRF/4O
 csI65L/WnrubD3KNzR5uAtM+OUTGEkf9p6AWO9m6gtSEgNLram+8gg1pvkrGZtbRaKdrcNtws
 R04MYvgW8u8ACzGxU/dC0xojIy41MoIo7T8b/DSkpFnjUYzYrGps11W33JIG9bmUU1TuDeiho
 mDtnSHD+TTzGpowbqVmdxTnJiX7Y6PYCryWJcdGIPeneRwqkMZSJQ3wPXVqvjtRo/oRggMnDr
 AZMLD5cyeS35Ky+CFb3/IJCv6niy/G1KQBs+qihfmMbdMXfqW9Ay1EcWyL1OCcP+rchBkq0iJ
 AOMDSxRQIO1fjjnKku31ko3DySLS7RkFckj7JcN/IJXE10h1uBfpWoReL82USXdM6BmlLKP3o
 bSdTbbKX9lDCNHrnAs4M2FX5P1dxr5H6GFPfjs668Zj54nRPKM3tVT2EjDOrP7/SloU8+ekZA
 gsgm1YYM7bopoStBeS9X61D84NW/Gko4IAIIZTSKtVWAyBxiYE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 5:00 PM Nishanth Menon <nm@ti.com> wrote:
>
> On 09:49-20211217, Nishanth Menon wrote:
> > The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> >
> >   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driver-soc-fixes-for-v5.17
>
>
> uggh.. Could have been tags/ti-driver-soc-for-v5.17 mostly fixes threw
> my thought off a bit there.. - Do let me know if you folks prefer it
> as ti-driver-soc-for-v5.17 instead of ti-driver-soc-fixes-for-v5.17
> and I can retag and respin the PR..

I don't care about the tag name. However, if any of the patches qualify
as bugfixes that make sense in 5.16, please split up the branch into fixes
and new work and send them separately.

       Arnd
