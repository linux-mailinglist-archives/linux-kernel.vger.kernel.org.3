Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A7754F1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380465AbiFQHNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380406AbiFQHNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:13:44 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD30B13FA5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:13:38 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o26Ag-0002uA-Uy; Fri, 17 Jun 2022 09:13:34 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, mick@ics.forth.gr,
        samuel@sholland.org, cmuellner@linux.com, philipp.tomsich@vrull.eu,
        Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 0/5] riscv: some svpbmt fixes
Date:   Fri, 17 Jun 2022 09:13:34 +0200
Message-ID: <37631570.10thIPus4b@diego>
In-Reply-To: <mhng-55ae586c-07b7-4e6e-b695-6df8608b87d5@palmer-ri-x1c9>
References: <mhng-55ae586c-07b7-4e6e-b695-6df8608b87d5@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

Am Freitag, 17. Juni 2022, 01:03:32 CEST schrieb Palmer Dabbelt:
> On Thu, 26 May 2022 13:56:41 PDT (-0700), heiko@sntech.de wrote:
> > Some additionals comments and notes from autobuilders received
> > after the series got applied, warranted some changes.
> >
> > So this is a small collection of cleanups for the svpbmt v10 series.
> >
> > changes in v2:
> > - add Guo's Review
> > - add patch dropping the use of function pointers in code
> >   that can run before relocation
> >
> > Heiko Stuebner (5):
> >   riscv: drop cpufeature_apply_feature tracking variable
> >   riscv: Improve description for RISCV_ISA_SVPBMT Kconfig symbol
> >   riscv: make patch-function pointer more generic in
> >     cpu_manufacturer_info struct
> >   riscv: fix dependency for t-head errata
> >   riscv: remove usage of function-pointers from cpufeatures and t-head
> >     errata
> >
> >  arch/riscv/Kconfig               |  9 ++++++--
> >  arch/riscv/Kconfig.erratas       |  1 +
> >  arch/riscv/errata/thead/errata.c | 38 ++++++++++----------------------
> >  arch/riscv/kernel/alternative.c  | 18 +++++++--------
> >  arch/riscv/kernel/cpufeature.c   | 37 +++++++++----------------------
> >  5 files changed, 40 insertions(+), 63 deletions(-)
> 
> IMO only three of these are actually fixes, the rest are cleanups.  I've 
> got ahead and put everything on a branch, with
> 
>     riscv: Improve description for RISCV_ISA_SVPBMT Kconfig symbol
>     riscv: drop cpufeature_apply_feature tracking variable
>     riscv: fix dependency for t-head errata
> 
> first.  Those are on fixes, the whole thing is in for-next.

thanks a lot.

For the fixes I think Nathan's "riscv: Fix ALT_THEAD_PMA's asm parameters" [0]
would also be quite important.

Heiko

[0] https://lore.kernel.org/r/20220518184529.454008-1-nathan@kernel.org


