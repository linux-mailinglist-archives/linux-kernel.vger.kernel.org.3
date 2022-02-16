Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDBC4B8EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbiBPRSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:18:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiBPRSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:18:15 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0382CBECDA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:18:02 -0800 (PST)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N3K9E-1oKhju2rbe-010MBe; Wed, 16 Feb 2022 18:18:00 +0100
Received: by mail-wm1-f43.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso2141534wmj.2;
        Wed, 16 Feb 2022 09:18:00 -0800 (PST)
X-Gm-Message-State: AOAM5325pPJDChl3bxB7oFWlHQyjJXdwXW3Io6YScXDMD+1vXwKQgcKw
        UfRqpSqoOPsuREMwUgAVkuGd8tNq63O/5sTzPVc=
X-Google-Smtp-Source: ABdhPJyc/mWw7BZcqDmPeOb0/9e0zsIX4UzDnjikuc6xYXH+Y45DLjEbP22nAVw01wqU4hWYYZzBcFWGXH0CiAOKTKo=
X-Received: by 2002:a1c:21c5:0:b0:37d:40d0:94c7 with SMTP id
 h188-20020a1c21c5000000b0037d40d094c7mr2504948wmh.1.1645031880257; Wed, 16
 Feb 2022 09:18:00 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
 <YgtQkjRe7fbXI/lS@infradead.org> <alpine.DEB.2.21.2202150901170.34636@angie.orcam.me.uk>
 <Yg0YHHk7NVWjedgn@infradead.org> <alpine.DEB.2.21.2202161631020.34636@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2202161631020.34636@angie.orcam.me.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Feb 2022 18:17:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3F4x6XX9oZG+6L6NDYOMWv5O-vr2dN6=VF0SLGJzPMLQ@mail.gmail.com>
Message-ID: <CAK8P3a3F4x6XX9oZG+6L6NDYOMWv5O-vr2dN6=VF0SLGJzPMLQ@mail.gmail.com>
Subject: Re: [PATCH v2] parport_pc: Also enable driver for PCI systems
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0J4CkhRYRqmiNQDhtOXHNB5hJvR2kCEpr3fA06jnXgfco5wfpvD
 OWbR5p9X0MypMklaJkEeJx1YEW/QFwaPIWR9OhEofYOU8MGKl7UmLna2KlsX58zdZhn/1zL
 D4xakeWESeF7dNfdNDghbba/up3qASvGL4n/DHXf7K3Jk69tqa6h/ddtrsNj2b2O0WmawhC
 gUCCNvrurenqSPAvOalgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lq22F6LC/Zo=:/Md13+DKE/v8b4bBvIP1on
 tntecfEZTpgKWtue02hfZnkqfQ2aPcdhY9fb6Nv8bbVPW75LEUnYdtlIMfrDiixIWCC0iF/Lo
 m0DhfXuiOm8OFK0UR3AKQrH+WkIie4QBIrBHbDLaTDLsAzL6JJ+e7spC3Lp9zXYJX2Xkbv7FP
 j065EnzIbI1tbXLdr5tya/faxGAXMEImiHGvTvJLODfe3Rm2kJ3KPKoA0WVxmuBQXeaa6oUm6
 7gfFhlMPZBsYxJO46zGAt/fX0iKr2data/KJQJwmFuBYoahboz+UIF2n7jD/W5gYVLR1/gvKB
 Ssz5kRhsPXDGuqrVi8R+7wJF+iB1NFtqTWya4LWJ9eqQBn78P/THkwquGaTB3LUwO7FiJCO1t
 /6AxGDJlxpQQfZHIkdaNtIePN/gpd+yEFykX6rmuPjKZgx0Nx+NWP2byBjhXLAqxRn8SVlE2I
 Ta5ZNCUnVv1N/Ir0cO632JF7TKwUtRWLipzPMwWmScEn3i78rMe0JrRJq0bmRz0HIbu1zr1OW
 k6k9S5uy4hrHa4H6l2DeM8RaTvdsJAqlmN8/OXM0ZqbGSgN77WEhi4VFxIu5pBQNViSjyj4bJ
 SoVOhroEPy6fmm9b0QFDBnJ/j6E8EFlBXzyPgLuSwzWvlMAqNomhT+HBX+UKuSeHImI+A5v4Y
 RDWxpvw1d9hFIxJwDrX+8XySBw9NcIIPBH0mmXqjYuWjktkXG15XfhtjlrKZxJ+LAf7bo8xXJ
 FDMYfCvdOkFxqo72NOXG/mQHctCPc+x7DEUDHtjTRFZwf4HIN8xbJh0wnfuc3HoH2WFgrBGol
 k8FT5twqQIIrYq6iGbhjfNDElc2YaRzXaYrsdWhb2vFgZGACaE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 5:35 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Wed, 16 Feb 2022, Christoph Hellwig wrote:
>
> > > > Instead of adding generic-y just ad a mandatory-y in
> > > > include/asm-generic/Kbuild.
> > >
> > >  I'm inconvinced.  Not all archs want it, 5 don't.
> >
> > Which is exactly what mandatory-y is for.  Provide the asm-generic
> > version by default, but let architectures override it.
>
>  I don't think so.  Those 5 architectures don't want it at all; 7 other
> ones have their own versions.
>
>  Otherwise we could blanket-list all asm-generic headers as mandatory-y.

I think ideally the PCI driver should be a separate file from the rest, or
possibly it could get split up even further.

parport_pc_probe_port()/parport_pc_unregister_port() are already exported
by the driver and used by some of the front-ends. The parport_pc_pci_driver
looks like it could easily go into one file using module_pci_driver(), while
the platform driver stays in the existing file and the legacy detection logic
goes into a third one. The powerpc and sparc versions could technically
also be separate drivers, but I wouldn't take the rework that far.

       Arnd
