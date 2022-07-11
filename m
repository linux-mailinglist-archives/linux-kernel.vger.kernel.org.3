Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7398556D47B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiGKGFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKGFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:05:23 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4E311449
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:05:21 -0700 (PDT)
Received: from mail-yb1-f176.google.com ([209.85.219.176]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mdvyi-1nbzgn1KcA-00b0Cw for <linux-kernel@vger.kernel.org>; Mon, 11 Jul
 2022 08:05:19 +0200
Received: by mail-yb1-f176.google.com with SMTP id f73so7091033yba.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:05:19 -0700 (PDT)
X-Gm-Message-State: AJIora+vCcNHGpa9Hu54R1RrhJuQ9ibKWWyYA4gQs0XrCN1hcTVI2B/o
        00NZ3V0+1XOz+JURGmdSwfkaOEkr0RIXdLODmhI=
X-Google-Smtp-Source: AGRyM1tPfwQLWVGFNJv200YPAwP2Ym4eh/2LMH3iarHxSqOtUeMPoy+HIGyJVB9MVyfKwjsDS+Cz/sBwWQtviAbR0Bw=
X-Received: by 2002:a25:3b05:0:b0:66e:c216:4da3 with SMTP id
 i5-20020a253b05000000b0066ec2164da3mr16437619yba.550.1657519518013; Sun, 10
 Jul 2022 23:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220709211549.1163327-1-shorne@gmail.com> <20220709211549.1163327-2-shorne@gmail.com>
 <CAK8P3a0Mw0Q9_W+xawMe=7UfiQiJT98wybygqg8E8gEuurZCuw@mail.gmail.com> <YstDEargBYwjN2Yp@antec>
In-Reply-To: <YstDEargBYwjN2Yp@antec>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Jul 2022 08:05:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0o1rd4BiYwGq_JnWthBG11rxCevKE3+x3fE-S2EnbTxg@mail.gmail.com>
Message-ID: <CAK8P3a0o1rd4BiYwGq_JnWthBG11rxCevKE3+x3fE-S2EnbTxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] openrisc: Add pci bus support
To:     Stafford Horne <shorne@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ryWmCXIoNP2HiCshAxaiFMmqRJCSx8bDSy94b7TpXnDeGNAgtxP
 8aUXozGwsxZdhWQKEYIE5v7wyiPQJ+OWgH6DTNCYZdLqWJAV95Bgzvy6d5sXTMUxOmTC415
 KYORE/yqAYX27hBcdWUt3UJ9Rs3zLCY7iHVED5PZEqQxRN3cMSqP4pFwdQKyR7jAPBQlw3V
 TTKYrIn37NWpl9iA/ApiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NfQssdFs/iM=:FsfmL0wsR7xSst/WdxIH7M
 nVolL2lREUvWKjDzVFZf0Kvi9221yz70SPJPrOo6neG24RqXeFThZZhzeqsoR7o9zX8r2DOm5
 0MUMRkV1kCupU8XHUyDomBjgKmLgelHyx2E3cpKVs/C8Z8SPK/u5sNIWZRyN7VThamJkV/z1J
 3VpzSUYDADvzDHraukoO5pZs8rNBRV6FyzM7MGm0HMckyzC9DnUaODJjGLSnr2iOYJepbMvL4
 HXDntr/tScg7wdJomUNdLB3B0WEcvTSALgOb4kJTkOV8c0rup9NalHGJhpGX0V/pZPrk6Gz1c
 Qq1D3hjjkeCyud/35fhTtCr6t77tSVjgRY1srvd9kyynfxpVTDFeSmvS8/SWLcdf0vc5xbp/f
 it/FeinSQJv2dKS+MVvU8wD3xTTL8cn1wm1ZNN3TO0T7yeEKWU41Sl9gHzMb47y3XQn+iWsJE
 C/sf/p7cbJzgLXLugbXiCUjsELT6KoQgRtQ0HG9Tw4mckADw3syjWwXcgPxNhUEtyD8vDurhk
 hQlbfnrxsjn50NwxrxgtlCqrOdGu6XSzrns2QQ1UfwC7z9cQliKlhltgnDA9xp7QE2Y++0viR
 eIJKw0mLbO0GQ/VZ1Ij/yE+LrtReRrwUf990RyAqrT2rFLrMWcHA6aSVvQxc37dCLVW48PG2n
 QP1RSpZx9tr/S4UMdKlYjY/TYrAtNqZq7IuriavaoPiXY/6McMwu25nZTeW9/4cyzI6Sbqicg
 3hmIzJdkZcs3LwKY1FNt9yfuoAQzTRsfYK9a9PLN00rzdsU8z2qzpgPfJMuy9RHAp+qwsJQ1h
 aOsHyMUfE0ps3LpaJgIojasT+x17NM0dUyTCTPkFBcUcmBQfQeSdXTR+rUHKoQCkX0oxMVFpL
 d3E/dV7Uo0GJ2pqqnlLg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 11:22 PM Stafford Horne <shorne@gmail.com> wrote:
> On Sun, Jul 10, 2022 at 05:54:22PM +0200, Arnd Bergmann wrote:
>
> OK, I see, but I think IO_SPACE_LIMIT needs to be defined as something other
> than 0.  It is used to define kernel/resource.c's ioport_resource.

I think the kernel/resource.c one is fine, it just means that any attempt to
register an I/O port resource below the 0-length root resource will fail, which
is what you need when inb/outb cannot be used.

> For example on risc-v they set it to 16MB.
>
> I will setup a LIMIT smaller than 4GB and add a PCI_IOBASE.

Do you support multiple PCI domains? Usually you want at most 64KB
per domain, as that is the traditional limit and what the normal
pci_remap_iospace() will assign to a domain. The 16MB limit for riscv
is way more than what one may need on a 32-bit machine, since that
is enough for 4096 domains even with the largest possible I/O space,
and each domain has up to 65536 PCI functions attached to it.

> > Most PCI controller are however able to map I/O ports into the
> > physical address space of the CPU, and in that case you can just
> > define an otherwise unused address as PCI_IOBASE and map the
> > ports there from the PCI host bridge driver.
>
> OK, understood, do you think this needs to be documented in a architecture
> manual?  Maybe it's fine for it to be linux specific.

Of course it's Linux specific, but it's also architecture specific since
there are different ways of making I/O space available: Generally you
can leave it out completely, unless you have to support devices from
two decades ago, some architectures that existed back then have custom
instructions, some hardcode part of the virtual address space to access
MMIO registers at a fixed location, some rely on an indirect method
going through a particular MMIO register to access all I/O space, and
some use a per hostbridge window that gets mapped using
pci_remap_iospace().

Do you have a driver for your host bridge available somewhere?
It should be clear from that driver which method you need.

       Arnd
