Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9BF574EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbiGNNOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiGNNOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:14:40 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457431C924
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:14:38 -0700 (PDT)
Received: from mail-yw1-f181.google.com ([209.85.128.181]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mi2Fj-1nYmAX0zq5-00e8DK for <linux-kernel@vger.kernel.org>; Thu, 14 Jul
 2022 15:14:36 +0200
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-31bf3656517so16228397b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:14:36 -0700 (PDT)
X-Gm-Message-State: AJIora87dVBX+DLh37CXKUqy3ESZ510y4pTRJQH+h1oG/NCEbkzVIilh
        8O9sUD5XiawQRXw1Ai2V7cV2/cxFX+G9TNOwL/A=
X-Google-Smtp-Source: AGRyM1uafSJFpQOlxzTuazebv+1foYrOHcDhoNoaVMnzWGhMXx70Y5podLuFPtEHoJzzuxj3TfSuVgA3zmXb+TXcIs4=
X-Received: by 2002:a81:9b02:0:b0:31c:9ae4:99ec with SMTP id
 s2-20020a819b02000000b0031c9ae499ecmr9597696ywg.495.1657804475066; Thu, 14
 Jul 2022 06:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220714042736.2133067-1-shorne@gmail.com> <20220714042736.2133067-2-shorne@gmail.com>
 <CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com> <YtAO/nxcsjjc8M/c@antec>
In-Reply-To: <YtAO/nxcsjjc8M/c@antec>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jul 2022 15:14:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2B82z3+qUDnm7hSn0y7Kqs3CoGtUDxUSrjG86UA56tAg@mail.gmail.com>
Message-ID: <CAK8P3a2B82z3+qUDnm7hSn0y7Kqs3CoGtUDxUSrjG86UA56tAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] openrisc: Add pci bus support
To:     Stafford Horne <shorne@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jHmubrKEqz1zeuuGx1djmsVNmjLP5jT81eHPCDSYJ+5UDzfG47g
 qIrCFWfqD+8IE3e4ZRwJQ/G6Ce4kgNSFcO2m42ndtAaTSA95hQHlESPMwYJaXl9zCnRwkK/
 YC0DJstaFhKKtZB5IB9hCJgupSK9Cs3sTMIGNjc04fa8hwmPs3nyn0m/YRHra7KPp93el8L
 nKAYHQ9nFAwop5JOisMCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:789tF/xj5OM=:EaTxDqXhyPyKfuuWsmMyvY
 auQ2FYUzmIEjm+Gn/iW3pBt1xDyjUGjtu2svgW/yoGZm43YYTYE6gz/dzlWwrBFLO7p4p94w7
 Gv+MUN8I8nHxesIuYFH6Zu9U8Fsl43P+xYfg7eC4e40piTQWWa/xHkZQO3awiuvyJl7gyeE1P
 xt5jo8WiD0MvBFAGzdRyiR2kbBHITqxSOehBKqZxkqCs34OeNX+t7dEtRIFTswRALS/d6Qk2K
 da4kShO3ClRl4UnnlgwyJXZJtY57Ve/cR6ETKJLyc5KwWlX/NerFBBkaa6OE7CfRpPC3oD/Ug
 EwnjyrZNPgdnZhFG0TuVwVRO+HQTZT82kQhWy3Odg1ZKjdIELIKUMA0VSCGvsxk1bCN661lKC
 wc8vGcNRs4Fx/d+FstOYEeV/YXgr46Ds4d18KnzwtlMmP1j19FjCMhYXLzeKL7zqd12YXYb3N
 9C4pHnXrTuePdkKItMx0DluNpcUzGj3ojgNXXptKnB6aY1emfysqgkugy874Yx5KG2HTg9y4y
 +ZK/fZN31eIXGbD4lGlMVRe20GraQParfayxJlnVrpHOSFGDSnhN+IgLKq8zDEZCkQFaEWl1W
 38X8hU302xvEpLgh7o1EFvOpCNy7qv7Rc/WDOnJ221RAUQkAxt1ceIWeMUrWo79Rcw7IrT+UC
 peWlpsbtwmdKZY4y4XfyRUupACS8W7Dg6cCg5d77A17DwmOeVKyc7DGqvv0oDw1OrLC3apt0J
 tbThgxDPRT+tayk6rjS8WMnpnWessrVYdLSs3A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 2:41 PM Stafford Horne <shorne@gmail.com> wrote:
> On Thu, Jul 14, 2022 at 09:56:44AM +0200, Arnd Bergmann wrote:
> > > diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> > > index e814df4c483c..327241988819 100644
> > > --- a/arch/openrisc/Kconfig
> > > +++ b/arch/openrisc/Kconfig
> > > @@ -21,7 +21,9 @@ config OPENRISC
> > >         select GENERIC_IRQ_PROBE
> > >         select GENERIC_IRQ_SHOW
> > >         select GENERIC_IOMAP
> > > +       select GENERIC_PCI_IOMAP
> > >         select GENERIC_CPU_DEVICES
> >
> > > @@ -46,9 +50,6 @@ config MMU
> > >  config GENERIC_HWEIGHT
> > >         def_bool y
> > >
> > > -config NO_IOPORT_MAP
> > > -       def_bool y
> > > -
>
> I tried the below patch on top of this but I get failures, as the __pci_ioport_map
> uses ioport_map.
>
>     lib/pci_iomap.c: In function 'pci_iomap_range':
>       CC      drivers/i2c/i2c-core-base.o
>     ./include/asm-generic/pci_iomap.h:29:41: error: implicit declaration of function 'ioport_map'; did you mean 'ioremap'? [-Werror=implicit-function-declaration]
>        29 | #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
>           |                                         ^~~~~~~~~~
>     lib/pci_iomap.c:44:24: note: in expansion of macro '__pci_ioport_map'
>        44 |                 return __pci_ioport_map(dev, start, len);
>           |                        ^~~~~~~~~~~~~~~~
>

Ah, I see. So setting NO_IOPORT_MAP without GENERIC_PCI_IOMAP
probably just works, but then you'd also build all the driver that use
ioport_map() when they cannot work.

Maybe add another

#define __pci_ioport_map(dev, port, nr) NULL

case to include/asm-generic/pci_iomap.h, or add an #ifdef to lib
pci_iomap_range() to not call it in this case.

> > GENERIC_IOMAP makes no sense without PIO, and I think you also
> > need to keep the NO_IOPORT_MAP. I think you still want
> > GENERIC_PCI_IOMAP, which in the absence of the other two
> > should turn just return an __iomem pointer for memory resource
> > and NULL for i/o resources.
>
> OK.
>
> If we keep NO_IOPORT_MAP, it causes HAS_IOPORT_MAP to be false and it removes
> the definition of ioport_map which still seems to be needed at link time.  Maybe
> thats an issue though.

This is the intention of CONFIG_NO_IOPORT_MAP, it's meant to be set
on architectures that have no way of defining ioport_map() in a sensible
way.

        Arnd
