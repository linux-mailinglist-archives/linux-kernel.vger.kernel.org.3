Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CE857537C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbiGNQzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbiGNQzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:55:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52A4A837;
        Thu, 14 Jul 2022 09:55:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 64so4177579ybt.12;
        Thu, 14 Jul 2022 09:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtZPLFwxYNKanG+h3QDUM6ra0yijWiFb3B9BIWY3S/E=;
        b=cMrZXi0Pvn7gE8mgb+Kk7Z7fqa/En6zp7q4PLY0uwK8QhR7RMf1b0JXavpeGSzBnxK
         UWPM+TBWB5uze16RTTsVLuvsNJEproQtmwbQbuW1pOoPc1Tf7st0Bv0t97YZUPrmV4GZ
         P/7VWUA0694iTSby/WA+82ey0a1XTfOuFW/qFwnjySlKYRSxYMmQIGJR8WqR8n8xikVd
         0xyjI2VM3KgR9L+BsD0vNH6HovcV5XwpdeOnBteFNkAia/CX3FsyLbOnFERoH2YDwY/Q
         Oq8vnXmwceEn4JnIN55o8kz9+NJDXsIQ8tIyNRWhTv7ah5dEIXSbQjlk1f70wFhrvyMK
         1dAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtZPLFwxYNKanG+h3QDUM6ra0yijWiFb3B9BIWY3S/E=;
        b=Vv2Mur/9bVYvMk/sVKWvnvYX5j6FNmDNro97Onne05kSvhSXahoYowJ/gZa/xpkLzn
         jekuJJ6fjMgnE1PYO+69jqOQNg4oQd135vaa0w0zvMGrQOLzEmtfocPLLpK5n51RXo94
         YnZrAbaCb4J+qL0GoLACnY9ClumEs6w9arO3nrBRjYMcB6LaOEmJcqJULQ0ZMoyBwRoN
         zsmGzbFYOgarjcGLQzRL152CZOzPKLwMqHPiCFrrm2WpInNb/2MiqVeTSHowoeSHK7K4
         rfuPnK2fvx8M+b6F59u9nTU2PRwb9LPoDDYjUEJUfIE6VO03H+AzTAn8kYkFQXT4uvd1
         JY9Q==
X-Gm-Message-State: AJIora9SXjPhOVWQTT2o8+/Ert+T6RvnnkgrunkXFceUNPmqcwB/Y742
        sIfKPY/UPr1swmpLG4E6MwwBElbXkNXPaiEbobE=
X-Google-Smtp-Source: AGRyM1umoixex0sO+mcpexwT3t4HYjZOSBppDD8uRoW0tGM/uVoGSmFrclS/FHlDdVoimeoDUxODbtUIoj2Fka4tDMQ=
X-Received: by 2002:a05:6902:1109:b0:66e:f386:61ce with SMTP id
 o9-20020a056902110900b0066ef38661cemr8895044ybu.364.1657817744896; Thu, 14
 Jul 2022 09:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220714185514.7d1a2ac9@canb.auug.org.au> <Ys/42uMzQy+CFTGI@debian>
 <YtA+127QgRifnRBZ@dev-arch.thelio-3990X> <CADVatmOTNA8uVqDEx6kp=+_O=wEhV2jbS9-frct-c4ZqBxcspg@mail.gmail.com>
 <YtBEXdrsthFamQs8@dev-arch.thelio-3990X>
In-Reply-To: <YtBEXdrsthFamQs8@dev-arch.thelio-3990X>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 14 Jul 2022 17:55:08 +0100
Message-ID: <CADVatmNBWnPxmMCs_LdTKgiy=+ebTZV7KT3E-62bZuK8LJyMfg@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 14
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 5:29 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Jul 14, 2022 at 05:21:32PM +0100, Sudip Mukherjee wrote:
> > Hi Nathan,
> >
> > On Thu, Jul 14, 2022 at 5:05 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Hi Sudip,
> > >
> > > On Thu, Jul 14, 2022 at 12:07:06PM +0100, Sudip Mukherjee (Codethink) wrote:
> > > > Hi Stephen,
> > > >
> > > > On Thu, Jul 14, 2022 at 06:55:14PM +1000, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > >
> > > > > Changes since 20220713:
> > > >
> > > > Build failures on next-20220714:
> > >
> > > <snip>
> > >
> > > > x86_64 allmodconfig with clang fails with:
> > > >
> > > > drivers/clk/qcom/gpucc-sm8350.c:111:2: error: initializer element is not a compile-time constant
> > > >         gpu_cc_parent,
> > > >         ^~~~~~~~~~~~~
> > > > drivers/clk/qcom/gpucc-sm8350.c:126:2: error: initializer element is not a compile-time constant
> > > >         gpu_cc_parent,
> > > >         ^~~~~~~~~~~~~
> > >
> > > I sent https://lore.kernel.org/20220711174004.3047516-1-nathan@kernel.org/
> > > for this a few days ago, it just needs to be picked up.
> > >
> > > > arch/x86/kernel/cpu/bugs.c:58:21: error: section attribute is specified on redeclared variable [-Werror,-Wsection]
> > > > DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
> > > >                     ^
> > > > ./arch/x86/include/asm/nospec-branch.h:283:12: note: previous declaration is here
> > > > extern u64 x86_spec_ctrl_current;
> > >
> > > This is now fixed in -tip so it should be fixed in -next tomorrorow:
> > >
> > > https://git.kernel.org/tip/db866d3352ec85e821e730e191481cba3a2bfa6e
> >
> > This should also go to Linus. This failure is in the mainline also.
> > https://lore.kernel.org/lkml/Ys6sZj6KYthnDppq@debian/
>
> Yes, it is in the x86/urgent branch so it should get there by -rc7. Our
> CI is red too :(
>
> > > In the future, consider CC'ing our mailing list (llvm@lists.linux.dev)
> > > for any clang related issues so that we can get them taken care of ASAP,
> > > we have a MAINTAINERS entry for a reason :) thank you for testing with
> > > clang; the more people that use it, hopefully the easier it will be to
> > > get things unbroken.
> >
> > Sure. I run arm, arm64, powerpc and x86_64 allmodconfigs with clang
> > (along with gcc) every night for mainline, started with linux-next
> > from today. Trying to setup the mips build also, I will mail llvm list
> > asking for help with the mips build.
> > Currently I only monitor the clang output from x86_64 as thats the one
> > which builds. If you want I can send the other reports also.
>
> Sure! I am not sure that we have tested mips or powerpc allmodconfig now
> that I am thinking about it but we'll certainly take a look at any
> issues that come from them and see what we can do.

Uhhh.. I just checked powerpc build log and have now raised:
https://github.com/llvm/llvm-project/issues/56530

I am also part of Elisa project and there we run clang-analyzer on
defconfig of linux-next every day and the results are stored in a web
interface to check and compare. I have added Lukas if you both think
it will be good to collaborate.


-- 
Regards
Sudip
