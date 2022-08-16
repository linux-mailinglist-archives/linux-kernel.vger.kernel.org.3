Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31CC595A65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiHPLk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiHPLkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:40:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6CA101E8;
        Tue, 16 Aug 2022 04:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8EC0B8169F;
        Tue, 16 Aug 2022 11:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7580DC43143;
        Tue, 16 Aug 2022 11:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660648059;
        bh=4MGnUkOgJK43wRliQHo1gFwCDv8iRH3dd6NYX9GNPIw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R3ovARCdESQqVaYpRUbH6uXKRwjXj+Vm+LnYM+P15vzzUy7GoD8QStsOlasG65hr7
         UoJPlBJ40zGKn/Cq2RgcziJbvZ/wqz8rnVdwC/s5xzqrXE/TulNExtKKI2ik12urWa
         OcOun3Ljy4hg6OycARvqUM/qiAQRpGtwt//b/KkTRcAjBgWEEsoE3KHktQRw5bw9sx
         KndrPWBid8D3oehdLbPWj5iKgMxfqcd2S2p7IHCRpL+mBTUnGyA1dbpy9z+1Mb9I1K
         +jcbog+0fnxkF50r4fGMC1KM186utajlGvqpaZmFkmPtRrLlIQN/N6HVD8kBam9zBN
         GijK15UGbxb2Q==
Received: by mail-vs1-f48.google.com with SMTP id o123so9749219vsc.3;
        Tue, 16 Aug 2022 04:07:39 -0700 (PDT)
X-Gm-Message-State: ACgBeo2joEZUgvDzhwfLo8D3//M3wvjOMbZpqj+XDjcw/w4uuAcFY15L
        0Tb4yXxMMz1CsgBmv9fGWFVC4Q94Ow9u/Eat/6I=
X-Google-Smtp-Source: AA6agR6jPSaNNOF5k9aH9Wvt0lAB54bLIxg5uSvrINyZxUK1+FmKqYfk1bSdzRgwlPgw75Neoa0irEIOwci8GPjPWYs=
X-Received: by 2002:a05:6102:b14:b0:38a:88dd:c169 with SMTP id
 b20-20020a0561020b1400b0038a88ddc169mr8394631vst.84.1660648058275; Tue, 16
 Aug 2022 04:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220815143959.1511278-1-zi.yan@sent.com> <Yvtxv2jywm3+Q3ut@arm.com>
In-Reply-To: <Yvtxv2jywm3+Q3ut@arm.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 16 Aug 2022 19:07:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Np=L9JcrGjh8zy1Kxb8b9f_dzD00kgV6odzZV-L5pbA@mail.gmail.com>
Message-ID: <CAAhV-H6Np=L9JcrGjh8zy1Kxb8b9f_dzD00kgV6odzZV-L5pbA@mail.gmail.com>
Subject: Re: [PATCH] arch: mm: rename FORCE_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Zi Yan <ziy@nvidia.com>, Linux-MM <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Qin Jian <qinjian@cqplus1.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-oxnas@groups.io, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For LoongArch:

Acked-by: Huacai Chen <chenhuacai@kernel.org>

On Tue, Aug 16, 2022 at 6:30 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Aug 15, 2022 at 10:39:59AM -0400, Zi Yan wrote:
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 571cc234d0b3..c6fcd8746f60 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1401,7 +1401,7 @@ config XEN
> >       help
> >         Say Y if you want to run Linux in a Virtual Machine on Xen on ARM64.
> >
> > -config FORCE_MAX_ZONEORDER
> > +config ARCH_FORCE_MAX_ORDER
> >       int
> >       default "14" if ARM64_64K_PAGES
> >       default "12" if ARM64_16K_PAGES
>
> For arm64:
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
