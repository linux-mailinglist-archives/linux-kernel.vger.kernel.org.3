Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2889E57D89A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiGVC0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiGVCZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:25:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C523C8AB29
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B879B82712
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4396EC341C0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658456738;
        bh=9hNut5aXzPPWmdaB6oLy3TShgl7iSl0c/MXIQrywLT0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P4HmO5fpbM3EPeLaHvwsW24SFAY8mVRMidfOQPJuxULYXCVyC+gXC/0xhasYTEH0T
         Sw+NM1N68EP7cefL0mKsxjsXYQ6FuMexmqzg5NYPicVThcf7kO1gpoiUpOUrmumub7
         uRdO6LXx0i/kIs//vc57mtJNJ5sjc+oYZHA4nnqXIOMuCXOA/u/K3eI6+dBeFCjMhJ
         Ju1IkjXS99RHMSV8AZFsSczfnrBtytT6x5fHetnA8Fi1RIayA/m90pCAYY5rMQrooT
         HiPG5PIkxS6kiFmbKd+lLZ64iSK+7B9alfJpQk0Fxdk1vUSmW19MmnLQya8DLsA6RM
         CRY9nyn2TRE6w==
Received: by mail-vs1-f43.google.com with SMTP id k129so3213728vsk.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:25:38 -0700 (PDT)
X-Gm-Message-State: AJIora8X4vgzScVAbXg9Lyys0wvt040jdxsgJDLj6ZTRbV734DvzxwiW
        tll2mk0w2qxtkVVMQfE9u+IalxUE934G5v5JFkI=
X-Google-Smtp-Source: AGRyM1vzJ7unRFTrJy5bUsfbbvStI9KFANj6KNpqiwg/HXh1rdw+Zeo5iHmZuLSr2MT8bVDrMMae9XFhrXpheebqaDw=
X-Received: by 2002:a05:6102:330a:b0:357:ee75:a914 with SMTP id
 v10-20020a056102330a00b00357ee75a914mr403227vsc.43.1658456737209; Thu, 21 Jul
 2022 19:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <1658314292-35346-1-git-send-email-lvjianmin@loongson.cn> <874jzcyrjl.wl-maz@kernel.org>
In-Reply-To: <874jzcyrjl.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 22 Jul 2022 10:25:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4LXGE1mPQDf1wbuaCuB1G02RG1JA-B78+pNTPwwwKPWw@mail.gmail.com>
Message-ID: <CAAhV-H4LXGE1mPQDf1wbuaCuB1G02RG1JA-B78+pNTPwwwKPWw@mail.gmail.com>
Subject: Re: [PATCH V18 00/13] irqchip: Add LoongArch-related irqchip drivers
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

On Wed, Jul 20, 2022 at 7:03 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 20 Jul 2022 11:51:19 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
> >
> > LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> > LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> > version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> > boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> > are already added in the ACPI Specification 6.5(which may be published in
> > early June this year and the board is reviewing the draft).
> >
> > Currently, LoongArch based processors (e.g. Loongson-3A5000) can only
> > work together with LS7A chipsets. The irq chips in LoongArch computers
> > include CPUINTC (CPU Core Interrupt Controller), LIOINTC (Legacy I/O
> > Interrupt Controller), EIOINTC (Extended I/O Interrupt Controller), PCH-PIC
> > (Main Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Controller
> > in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).
>
> [...]
>
> OK, that's 4 versions in quick succession, so I suggest we stop the
> bikeshedding and focus on getting this actually merged.
>
> I'm going to stick this in a branch and throw it at -next. Any change
> will need to go on top of it, no rebasing. If anything that breaks
> cannot be fixed easily, I will drop the branch.
Thank you very much for this series finally get merged.
But there is a question that has puzzled me for a long time so I want
to consult with you: Why exporting fwnode_handle in the driver is
acceptable but exporting irqdomain is not? In my opinion, exporting
irqdomain is more simple and direct because it can avoid
irq_find_matching_fwnode() in the consumer side.

Huacai
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
>
