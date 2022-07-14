Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3115752C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiGNQ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiGNQ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:29:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A626576;
        Thu, 14 Jul 2022 09:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D5BA61FB9;
        Thu, 14 Jul 2022 16:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A34C34114;
        Thu, 14 Jul 2022 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657816159;
        bh=SnQc6p3PeqS1n3VRIcugq60v7kSKmJEFyoz8QtpbexQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjRz+faWGfxgMxT7jllxUWJWqUPhg+FB4QKsQrOiXTNOLgxrmCXGGrSneo++XwKZd
         1aLi9Q1BAvF9QU3pSooD2HTnG5Y5SSF+ZTDfmz5J7sFFyTPIiuOVAd5A0ThQ2QF/Dc
         YkwawbPoK0l6BmHreuiMx/f0+0NmzXKn4eWpA2+oX5WaS6o67+tCqBSjYvsL9ekp8Z
         /JudLDyKoQyHGVsLrSTJE+0ca3CkzZFm5gVAAsCr8O4vaYMxFTaIXQwXDWXgHhrj5/
         kYpA7Fr/K/mkIFnFDUwGTacMwfb52m89oK4fcsZ9S6i7AHoSwrCqtDrJjqkVaGJgop
         AwK7mtfRI80ag==
Date:   Thu, 14 Jul 2022 09:29:17 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: linux-next: Tree for Jul 14
Message-ID: <YtBEXdrsthFamQs8@dev-arch.thelio-3990X>
References: <20220714185514.7d1a2ac9@canb.auug.org.au>
 <Ys/42uMzQy+CFTGI@debian>
 <YtA+127QgRifnRBZ@dev-arch.thelio-3990X>
 <CADVatmOTNA8uVqDEx6kp=+_O=wEhV2jbS9-frct-c4ZqBxcspg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmOTNA8uVqDEx6kp=+_O=wEhV2jbS9-frct-c4ZqBxcspg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 05:21:32PM +0100, Sudip Mukherjee wrote:
> Hi Nathan,
> 
> On Thu, Jul 14, 2022 at 5:05 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Sudip,
> >
> > On Thu, Jul 14, 2022 at 12:07:06PM +0100, Sudip Mukherjee (Codethink) wrote:
> > > Hi Stephen,
> > >
> > > On Thu, Jul 14, 2022 at 06:55:14PM +1000, Stephen Rothwell wrote:
> > > > Hi all,
> > > >
> > > > Changes since 20220713:
> > >
> > > Build failures on next-20220714:
> >
> > <snip>
> >
> > > x86_64 allmodconfig with clang fails with:
> > >
> > > drivers/clk/qcom/gpucc-sm8350.c:111:2: error: initializer element is not a compile-time constant
> > >         gpu_cc_parent,
> > >         ^~~~~~~~~~~~~
> > > drivers/clk/qcom/gpucc-sm8350.c:126:2: error: initializer element is not a compile-time constant
> > >         gpu_cc_parent,
> > >         ^~~~~~~~~~~~~
> >
> > I sent https://lore.kernel.org/20220711174004.3047516-1-nathan@kernel.org/
> > for this a few days ago, it just needs to be picked up.
> >
> > > arch/x86/kernel/cpu/bugs.c:58:21: error: section attribute is specified on redeclared variable [-Werror,-Wsection]
> > > DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
> > >                     ^
> > > ./arch/x86/include/asm/nospec-branch.h:283:12: note: previous declaration is here
> > > extern u64 x86_spec_ctrl_current;
> >
> > This is now fixed in -tip so it should be fixed in -next tomorrorow:
> >
> > https://git.kernel.org/tip/db866d3352ec85e821e730e191481cba3a2bfa6e
> 
> This should also go to Linus. This failure is in the mainline also.
> https://lore.kernel.org/lkml/Ys6sZj6KYthnDppq@debian/

Yes, it is in the x86/urgent branch so it should get there by -rc7. Our
CI is red too :(

> > In the future, consider CC'ing our mailing list (llvm@lists.linux.dev)
> > for any clang related issues so that we can get them taken care of ASAP,
> > we have a MAINTAINERS entry for a reason :) thank you for testing with
> > clang; the more people that use it, hopefully the easier it will be to
> > get things unbroken.
> 
> Sure. I run arm, arm64, powerpc and x86_64 allmodconfigs with clang
> (along with gcc) every night for mainline, started with linux-next
> from today. Trying to setup the mips build also, I will mail llvm list
> asking for help with the mips build.
> Currently I only monitor the clang output from x86_64 as thats the one
> which builds. If you want I can send the other reports also.

Sure! I am not sure that we have tested mips or powerpc allmodconfig now
that I am thinking about it but we'll certainly take a look at any
issues that come from them and see what we can do.

arm and arm64 are not warning free so disabling CONFIG_WERROR will help
out there (arm64 is a recent failure that I have not been able to
entirely figure out: https://github.com/ClangBuiltLinux/linux/issues/1642)
but I do want to get those warning clean soon so they just build out of
the box.

Cheers,
Nathan
