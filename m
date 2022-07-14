Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A725F5756D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbiGNVYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGNVYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:24:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8483728E30
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:24:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22E34B82942
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 21:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8373CC34114;
        Thu, 14 Jul 2022 21:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657833852;
        bh=aLCC/tzGrl4JLgsRiVAJXvFl+1z5/lLOZIt/Tgalp5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DitiNwOImS/39CrkT49KqO9aKcjzMfdIop4yqy/QyO+xFRRu5/ChXt0wrQ1a6i5HZ
         QknrPiVfUheoeEMo3VM9WPCLxiKxh4AEMZNZgCYzAMqkhT1gh7ekakZNpGx2l5aLZm
         peVNdjZ/1cbw1PlmlaT6OvobAG0eVUJTQEAWBVWV1Q0+jcPyRPXvPsNYesW70T7Kz4
         Tm04ch2XIBqZV7ZojCYFwoka3cTjMib0B+06RXW/d86+dNIAwEqz+1RZaQgG/sMGlc
         wcdDy0elHtbUsAlR3GAfJNOK3F9QveDgNrjZ9s9phzfrpAsldV4KMuwwxglyzoQUo0
         th95JkOuqc5Fw==
Date:   Thu, 14 Jul 2022 14:24:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: linux-next: Tree for Jul 14
Message-ID: <YtCJeieW4Mz1VfRx@dev-arch.thelio-3990X>
References: <20220714185514.7d1a2ac9@canb.auug.org.au>
 <Ys/42uMzQy+CFTGI@debian>
 <YtA+127QgRifnRBZ@dev-arch.thelio-3990X>
 <CADVatmOTNA8uVqDEx6kp=+_O=wEhV2jbS9-frct-c4ZqBxcspg@mail.gmail.com>
 <YtBEXdrsthFamQs8@dev-arch.thelio-3990X>
 <CADVatmNOV+jn1WSFo=z4F9KqzYAgxCWr0cxTFL_5myJKFkQNzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmNOV+jn1WSFo=z4F9KqzYAgxCWr0cxTFL_5myJKFkQNzQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropping the next list and Stephen as these issues are likely present on
mainline as well.

On Thu, Jul 14, 2022 at 07:26:27PM +0100, Sudip Mukherjee wrote:
> Hi Nathan,
> 
> On Thu, Jul 14, 2022 at 5:29 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Thu, Jul 14, 2022 at 05:21:32PM +0100, Sudip Mukherjee wrote:
> > > Hi Nathan,
> > >
> > > On Thu, Jul 14, 2022 at 5:05 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > Hi Sudip,
> > > >
> > > > On Thu, Jul 14, 2022 at 12:07:06PM +0100, Sudip Mukherjee (Codethink) wrote:
> > > > > Hi Stephen,
> > > > >
> > > > > On Thu, Jul 14, 2022 at 06:55:14PM +1000, Stephen Rothwell wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > Changes since 20220713:
> > > > >
> > > > > Build failures on next-20220714:
> > > >
> > > > <snip>
> > > >
> 
> <snip>
> 
> >
> > Sure! I am not sure that we have tested mips or powerpc allmodconfig now
> > that I am thinking about it but we'll certainly take a look at any
> > issues that come from them and see what we can do.
> 
> The build errors from powerpc allmodconfig with clang:

Thanks for testing!

> 1)
> Error: External symbol 'memset' referenced from prom_init.c

Good to know this is not clang specific.

> 2)
> drivers/clk/qcom/gpucc-sm8350.c:111:2: error: initializer element is
> not a compile-time constant
>         gpu_cc_parent,
>         ^~~~~~~~~~~~~
> drivers/clk/qcom/gpucc-sm8350.c:126:2: error: initializer element is
> not a compile-time constant
>         gpu_cc_parent,
>         ^~~~~~~~~~~~~
> 3)
> sound/soc/intel/avs/path.c:815:18: error: stack frame size (2672)
> exceeds limit (2048) in 'avs_path_create'
> [-Werror,-Wframe-larger-than]
> struct avs_path *avs_path_create(struct avs_dev *adev, u32 dma_id,
>                  ^

Right so this one is the one I linked early that impacts arm64 (also
arm and riscv). It appears to be related to KASAN + FORTIFY_SOURCE and I
have a diff that works but I am not sure if it is acceptable. I guess I
should just submit it and see.

> 4)
> drivers/net/ethernet/mellanox/mlx4/main.c:3332:12: error: stack frame
> size (2128) exceeds limit (2048) in 'mlx4_load_one'
> [-Werror,-Wframe-larger-than]
> static int mlx4_load_one(struct pci_dev *pdev, int pci_dev_data,
>            ^
> 5)
> In file included from drivers/scsi/BusLogic.c:51:
> drivers/scsi/FlashPoint.c:1712:12: error: stack frame size (2896)
> exceeds limit (2048) in 'FlashPoint_HandleInterrupt'
> [-Werror,-Wframe-larger-than]
> static int FlashPoint_HandleInterrupt(void *pcard)
>            ^
> 6)
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1093:12: error: stack frame size
> (2128) exceeds limit (2048) in 'vcn_v3_0_start'
> [-Werror,-Wframe-larger-than]

I don't see any large variables on the stack in these functions so I am
guessing we are just getting murdered by inlining in combination with
KASAN instrumentation, as KASAN gets turned on by allmodconfig.
Unfortunately, this has been an issue for a long time:

https://github.com/ClangBuiltLinux/linux/issues/39

It has not been as bad with CONFIG_KASAN_STACK force disabled for clang
but it is still there for certain architectures, namely ARCH=arm. I
would be curious to see if all those -Wframe-larger-than instances
disappear with CONFIG_KASAN disabled.

Cheers,
Nathan
