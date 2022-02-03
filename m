Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3155A4A8597
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243099AbiBCN46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:56:58 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54912 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232957AbiBCN44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:56:56 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nFcbM-0002C8-Tr; Thu, 03 Feb 2022 14:56:44 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        linux-riscv@lists.infradead.org
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Subject: Re: [PATCH v1 0/2] Provide a fraemework for RISC-V ISA extensions
Date:   Thu, 03 Feb 2022 14:56:43 +0100
Message-ID: <1859467.Zi3Bu27KEa@diego>
In-Reply-To: <CAOnJCULirV30g6ti7QvY40=p_W9+-XG+nAbxiZ4qDZLo28RJ6A@mail.gmail.com>
References: <20211224211632.1698523-1-atishp@rivosinc.com> <mhng-791652b4-53f0-48e4-a640-f4c418c9926b@palmer-ri-x1c9> <CAOnJCULirV30g6ti7QvY40=p_W9+-XG+nAbxiZ4qDZLo28RJ6A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

Am Samstag, 8. Januar 2022, 03:24:12 CET schrieb Atish Patra:
> On Fri, Jan 7, 2022 at 1:58 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Fri, 24 Dec 2021 13:16:30 PST (-0800), atishp@atishpatra.org wrote:
> > > This series implements a generic framework to parse multi-letter ISA
> > > extensions. It introduces a new DT node that can be under /cpus or
> > > individual cpu depends on the platforms with homogeneous or heterogeneous
> > > harts. This version of the series only allows adds support for homogeneous
> > > harts as there are no platforms with heterogeneous harts yet. However,
> > > the DT binding allows both.
> > >
> > > The patch also indicates the user space about the available ISA extensions
> > > via /proc/cpuinfo.
> > >
> > > Here is the example output of /proc/cpuinfo:
> > > (with debug patches in Qemu and Linux kernel)
> > >
> > > / # cat /proc/cpuinfo
> > > processor     : 0
> > > hart          : 0
> > > isa           : rv64imafdcsu
> > > isa-ext               : sstc,sscofpmf
> > > mmu           : sv48
> >
> > IMO this is the wrong way to go.  I get that the ISA string is very
> > complicated to parse, but we've tried to come up with other
> > representations of this we've ended up having that interface break when
> > the ISA string rules eventually change.  We should just stick to the ISA
> > string for these interfaces, as that's at least something everyone can
> > agree on because they're defined by the spec.
> >
> 
> Fair enough.
> 
> > That said, we should add the spec versions into this interface.  At
> > least the user spec version is relevant here, but given that we're
> > passing through some other priv-level details we might as well pass that
> > though too.
> >
> 
> Tsukasa already has a version that extends the isa string parsing for
> multi-letter extensions
> and versions parsing. We just need to add the ISA bitmap support on top of it.
> 
> I will coordinate with Tsukasa to have a complete framework based on
> string parsing.
> It would be good to have this series asap as all other series  (perf,
> svpbmt) will rely on it.

out of curiosity, did this go anywhere yet in terms of the coordinated
approach you wrote about?

Thanks
Heiko


