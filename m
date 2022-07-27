Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C226581F22
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbiG0Eu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 00:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiG0Euo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:50:44 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5D118E13;
        Tue, 26 Jul 2022 21:50:43 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31f56c42ab5so27026827b3.10;
        Tue, 26 Jul 2022 21:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTNmcaMw9QvgqHO+YoH2dFnS2SnbPcs32jRU+D9RKsw=;
        b=S55/LOwSsetgb9AdSrVMimQUtPFSfyfkaRnZmF8tgbT65fzGostkqICQ7h4BUrWO5y
         OO7mh1xlbSW28PUpP2/bMtcfgzfzNfUOH4N2TAYtZWQgNfDu8sNsCeOxxQ6umxztYHXP
         GW0neJbKVH9BnKahCGooBGW07/j3081Hbh8KNyGlE7dIZhIYxbJzJBdLI23rQyWk1lkt
         OSLvShrGZnL23pGaWGWV/y+QnppKpXH4quF00ZhGyc+19rpJZLs1lQ8QsuNw32SmdRGB
         RMBH+aWjlne8DMe4/We5xHG8rgKk88uKgCpnJBYd0+9sTIYW4ZUmI6yTLbrwhHPVXJTd
         yvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTNmcaMw9QvgqHO+YoH2dFnS2SnbPcs32jRU+D9RKsw=;
        b=CuxmB9U0KXQUjl+vXkCDDod2+Z8rDf9hChp7o4ybCEOuu34jOc6IVyQFWB+q1TAMwc
         B7B7/g0Pl3n4EsjPyN3z6Fware1ufSTHIWDoLLbkrCGvXVs/C6OYEVzUW5DNI8AVs/f8
         nbN1Rm/t5H15thHIqO7E0zCrW49WUoqjbD54ufAhQ15vFDaVTg1cDzwQB7GGt3T6f9wU
         7rwL1DY35+i5PXhEgPc7ScojyVVV/WPbbKEA77Q0t5P7xDP1vGcSi2y3e3Eyxj/OidoM
         XvNE56VycWsIPmQ2KT8e/4iN3PxT8nZXWcRVS+OMVeblqAqSpED7THfDqmsmXVXDeWkI
         agJg==
X-Gm-Message-State: AJIora8jQf89x6P/JiBRsGGfv5N9AkZp+AVyVoGoOPt9gRwQpn8A5UiX
        Zhj9Yw238VwuNZ7Rdb+hbFdpOg1hcfizWJfV6iA=
X-Google-Smtp-Source: AGRyM1uGvmARrifH1o9uKHBNIU9ajd7uBJMhD7B/8pdfd/h4544lbfXOHRlKv5OxHYCQhqxsO5zb7vtYxugglhUk5Qo=
X-Received: by 2002:a0d:de86:0:b0:31e:9672:b0c6 with SMTP id
 h128-20020a0dde86000000b0031e9672b0c6mr17214010ywe.481.1658897442509; Tue, 26
 Jul 2022 21:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220722121815.27535-1-lukas.bulwahn@gmail.com> <Ytq6GO0JJcqT2gOw@zn.tnic>
In-Reply-To: <Ytq6GO0JJcqT2gOw@zn.tnic>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 27 Jul 2022 06:50:31 +0200
Message-ID: <CAKXUXMxtJPmEe4o8qs4PejJzhu+pBmhUJWUpVQJy5q8y1=Qr0g@mail.gmail.com>
Subject: Re: [PATCH] x86/configs: update configs in x86_debug.config
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 4:54 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jul 22, 2022 at 02:18:15PM +0200, Lukas Bulwahn wrote:
> > Commit 4675ff05de2d ("kmemcheck: rip it out") removes kmemcheck and its
> > corresponding build config KMEMCHECK.
> >
> > Commit 0f620cefd775 ("objtool: Rename "VMLINUX_VALIDATION" ->
> > "NOINSTR_VALIDATION"") renamed the debug config option.
> >
> > Adjust x86_debug.config to those changes in debug configs.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  kernel/configs/x86_debug.config | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/kernel/configs/x86_debug.config b/kernel/configs/x86_debug.config
> > index dcd86f32f4ed..6fac5b405334 100644
> > --- a/kernel/configs/x86_debug.config
> > +++ b/kernel/configs/x86_debug.config
> > @@ -7,12 +7,11 @@ CONFIG_DEBUG_SLAB=y
> >  CONFIG_DEBUG_KMEMLEAK=y
> >  CONFIG_DEBUG_PAGEALLOC=y
> >  CONFIG_SLUB_DEBUG_ON=y
> > -CONFIG_KMEMCHECK=y
>
> While at it, you might also whack the last mention of KMEMCHECK:
>
> $ git grep KMEMCHECK
> kernel/configs/x86_debug.config:10:CONFIG_KMEMCHECK=y
> tools/testing/selftests/wireguard/qemu/debug.config:21:CONFIG_HAVE_ARCH_KMEMCHECK=y
>

Boris, I did so and sent out a patch for wireguard selftests:

https://lore.kernel.org/all/20220726130058.21833-1-lukas.bulwahn@gmail.com/

I hope you can pick this patch for the x86 config.

Thanks for the pointer.

Lukas
