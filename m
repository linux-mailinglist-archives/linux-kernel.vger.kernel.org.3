Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6515B581E83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbiG0EHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 00:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiG0EG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:06:58 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F032A25A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:06:57 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31f661b3f89so1241817b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tIslpZQHFFNT/K9JXOkB7aUsG71ZAPk/2bQTBwz7ToQ=;
        b=KUQtujJAjWwL90RNNQ4NGpYQsLaWmunFoO9ryhmUY4qibNJRzLDuja2VHm2YghJU/g
         onARSXsmS8n3KUCnD77tEw+eI0pP2RlmAHqF/KICXR7Cro2Z4Rfd3DnmdlvZ7UX1gia0
         0AiiF3U7QM1wEDQpA+LDJ74YmJ+r5kIX/dR7/1HdzAMSL8w8HZk9qzFqvSuGhgD1lYl8
         Ids+f7Qs8O+GhIWlu6rvn/zdRLAY34QrGHKZCwT9dfmd4jfuI8siSmDh7AMN+U2rwNG1
         wByWrxeQcr80cJotnT1IRrAU3iFcH4x6D1M6p6Dzqc73p5lJuOMocvrlL9FfjBcBz1Hv
         nZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIslpZQHFFNT/K9JXOkB7aUsG71ZAPk/2bQTBwz7ToQ=;
        b=hsIgPoEd0MBiRXPnA+eGRzDRymm1iug9DVj9QGG+7gfDxkiMWHPt5BVJcJ20/71u1s
         OT3n6CrCx2qRL5zhk8XU1JpiyquIZHqcIjxDWP762p0PFnGG3LBr7iChSs2JbpsHB781
         5EJfb/Io2i69zIgtJVmb9mF9it6CNgffS89NnIJb4heLdWpewdPtOya0m8XEJTDcFc2z
         y9cJg/GEJ6vJWNVeG/ZQFEJq5ESFxpWRHbE7E84vSC4TAvY/gO9SIf2YvAXfuKfb2ftZ
         ip/AlH+iWjc+eIqnsBNWgrb73ugXlksKiMPU3+kopjNiDQDhtNyHxpQhOBK+Fd4A4GA1
         4lnQ==
X-Gm-Message-State: AJIora/9X+f8wvpg8sM92FHacDOlZxOoXMqkv59tM7fomsQQM3tKoUe9
        3UN6yeQCAm+Y019TXvDaAqSTJjoDP/efm0N0flM=
X-Google-Smtp-Source: AGRyM1vXD6mc7sPNjd40/6i06v830sQUnZYUsuoYHjtDL0+FLAMC5vERedd5qQdHzUhcz3SOFvJ/8dK/bpRZU1Ijzww=
X-Received: by 2002:a81:1ed3:0:b0:31f:5186:91c0 with SMTP id
 e202-20020a811ed3000000b0031f518691c0mr4441014ywe.401.1658894816509; Tue, 26
 Jul 2022 21:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5Zw_zW6ez0_wvaXL1pbLnR2jWY=T7MgkT=4a-zNkiwVig@mail.gmail.com>
 <YtuceCr5OCJcDatJ@kroah.com> <874jz82kx0.wl-tiwai@suse.de> <CANX2M5Ywm+GpYY3+GsOWCLH24Nhy0M0LjBE-pHC8wFcd7SO=wQ@mail.gmail.com>
In-Reply-To: <CANX2M5Ywm+GpYY3+GsOWCLH24Nhy0M0LjBE-pHC8wFcd7SO=wQ@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 27 Jul 2022 06:06:45 +0200
Message-ID: <CAKXUXMz6EmQJqKg6UNC+qD8GLUpmHfhS7OH9X6tWKpLjFpKfSg@mail.gmail.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Write in snd_pcm_hw_params
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, consult.awy@gmail.com,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        fleischermarius@googlemail.com, its.priyanka.bose@gmail.com
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

On Tue, Jul 26, 2022 at 11:41 PM Dipanjan Das
<mail.dipanjan.das@gmail.com> wrote:
>
> On Sat, Jul 23, 2022 at 3:17 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Sat, 23 Jul 2022 09:00:08 +0200,
> > Greg KH wrote:
> > >
> > > Wondeful, do you have a fix for this that solves the reported problem
> > > that you have tested with the reproducer?
> >
> > ... or at least more detailed information.
>
> Here is our analysis of the bug in the kernel v5.10.131.
>
> During allocation, the `size` of the DMA buffer is not page-aligned:
> https://elixir.bootlin.com/linux/v5.10.131/source/sound/core/memalloc.c#L149.
> However, in sound/core/pcm_native.c:798
> (https://elixir.bootlin.com/linux/v5.10.131/source/sound/core/pcm_native.c#L798),
> the `size` variable is page-aligned before memset-ing the `dma_area`.
> From the other BUG_ON assertions in other parts of the code, it looks
> like the DMA area is not supposed to be equal to or greater than
> 0x200000 bytes. However, due to page-alignment, the `size` can indeed
> get rounded up to 0x200000 which causes the out of bound access.
>
> > Last but not least, you should check whether it's specific to your
> > 5.10.x kernel or it's also seen with the latest upstream, too.
>
> The bug is not reproducible on the latest mainline, because in
> sound/core/memalloc.c:66
> (https://github.com/torvalds/linux/blob/5de64d44968e4ae66ebdb0a2d08b443f189d3651/sound/core/memalloc.c#L66)
> the allocation function `snd_dma_alloc_dir_pages()` now page-aligns
> the `size` right before allocating the DMA buffer. Therefore, any
> subsequent page-alignment, like the one in `snd_pcm_hw_params()` does
> not cause an out of bound access.
>

Great analysis!

Now, you would just need to identify the specific commit in the
mainline repository, where 'function `snd_dma_alloc_dir_pages()` now
page-aligns the `size` right before allocating the DMA buffer.', and
then ask for applying that commit to the v5.10 stable branch,
following the guide from
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html.
Greg KH and Sasha Levin are then going to let you know if that works
or needs rework to backport.


Lukas
