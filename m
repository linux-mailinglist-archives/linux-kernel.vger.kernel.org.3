Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0613C577D99
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiGRIgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbiGRIgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:36:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9782119287
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 07AC4CE12B0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B47C341CD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658133360;
        bh=Utq85yqlmc0oqjGiFf7tOo10tqJ0YyER4Ou+TzeovFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fgyc1IZkG4X7YfP2r3DTvnaT7HGQCAFEf8v6Wq/tCEvtxmt7vwXAJsFH1i/l7PXos
         dFvJ69nXP/cvo6In7HkoWdJ6dg5YJiGQq/ws87rG9+TaGjYfYEgrlc/fHFrl3gXtjn
         ES08QiTvGPN/WGvHtw1DZrWihE8BM+OAOCgtrD3HpRQ/qAoEgV4ctde8v2r+vo9MPu
         AQ+x+k0d4MEKeh8UuJne0FEb634TfOlNFA9dVIOBUnyvH/lBDOuy5UgH6xpI8wpye5
         wvl9Pukk3fsCjI8gQErBj4T/FTS/Q73s90DsluvFZi3FHz0n1Vg3q+ABiJam7679wk
         LNBxu+UCcf9tw==
Received: by mail-vs1-f48.google.com with SMTP id i186so9732716vsc.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:36:00 -0700 (PDT)
X-Gm-Message-State: AJIora86n0gvh8J/hQEtb5qBHfgZcwQ59stfv3zXhljU0C3mhwEmyxOF
        qt9C2wYvLpOPzSk439urlusPGWSgtfRyndxIWUw=
X-Google-Smtp-Source: AGRyM1tbP9r8V5AcXIs5WGpugO7RpdNhLr07LA9xt/zjLzMbMX5XmnAJKxhaZe/Ohi/TYLBRJwEor2kmTBzATWKXiyQ=
X-Received: by 2002:a05:6102:3543:b0:357:3ae7:bbd0 with SMTP id
 e3-20020a056102354300b003573ae7bbd0mr9208509vss.84.1658133359240; Mon, 18 Jul
 2022 01:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
 <87less52bx.wl-maz@kernel.org> <6e9def1e-31fe-787d-1b2b-a328424352f0@loongson.cn>
 <87ilnw3vlg.wl-maz@kernel.org> <20994a99-b5b1-442d-d23d-2a11ecef24a0@loongson.cn>
 <CAAhV-H6CJ-aF2s9D4QJ5zYZGt_=C4QHFCzKByT6urcFMgWv+4g@mail.gmail.com>
 <87y1wrzto7.wl-maz@kernel.org> <CAAhV-H74rSy3DkFFgyGwW-rGO5tVJhrthQ78vAztnzze7-NYrA@mail.gmail.com>
 <87edyi53av.wl-maz@kernel.org>
In-Reply-To: <87edyi53av.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 18 Jul 2022 16:35:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6gdDe4Yqj7nf1wJtU5jzFgPsXCTF0JUSXvm=8rhWzm8Q@mail.gmail.com>
Message-ID: <CAAhV-H6gdDe4Yqj7nf1wJtU5jzFgPsXCTF0JUSXvm=8rhWzm8Q@mail.gmail.com>
Subject: Re: [PATCH V15 00/15] irqchip: Add LoongArch-related irqchip drivers
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Mon, Jul 18, 2022 at 2:43 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 18 Jul 2022 03:38:09 +0100,
> Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Marc,
> >
> > On Sun, Jul 17, 2022 at 10:43 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Sun, 17 Jul 2022 15:08:14 +0100,
> > > Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >
> > > > Hi, Marc, Jianmin,
> > > >
> > > > I have an idea but I don't know whether it is acceptable: Marc gives
> > > > an Acked-by for the whole series, then this irqchip series goes
> > > > through the loongarch tree together with the PCI patches, then we
> > > > don't need other hacks except the ACPI definitions.
> > >
> > > Not sure how this solves the original problem. PCI should never be
> > > mandatory (it is actually super useful to be able to build a very
> > > small kernel without too many drivers), and there shouldn't be
> > > configurations where the kernel doesn't build.
> > Now, the pci-loongson controller code (A) is in the PCI tree, the pci
> > enablement code (B) is in the LoongArch tree, and the irqchip code (C)
> > is in the irqchip tree. If the order for upstream is (A) --> (B) -->
> > (C), there will be no build error. My above idea is to make sure the
> > order of (B) and (C) is controlled in the same tree. PCI/MSI is a
> > mandatory requirement for LoongArch, so I want to avoid some
> > unnecessary #ifdefs.
> >
> > >
> > > It is also my own responsibility to merge these things, and I'd rather
> > > not delegate this, specially as it touches a bunch of other
> > > subsystems.
> > I know, this is reasonable. Then if we can control the order of
> > (A)(B)(C) in three trees, the build error can be avoided in the
> > linux-next tree.
>
> This would require stable branches between all three trees, as we
> don't control the *order* of the merges. I'd have to carry (A) and (B)
> as part of (C), which is really over the top.
>
> Just queue a patch to remove the #ifdef once we're at -rc1 and that
> things have settled down. This will be simpler for everyone, and will
> allow everyone to have a clean tree without dragging tons of extra
> patches.
OK, I agree with your decision.

Huacai
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
