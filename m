Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD024FB9CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbiDKKhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345613AbiDKKhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:37:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360686585
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:35:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p25so7491932pfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+2f7Abc00wPGCUaOzHgs4cliFCaq+b85+1pgNfFOUw=;
        b=nsP9/lNa1p6mkmttdJL8bAdKCkQhON94LcD76TtZTldX0FYDD2BRfgS2MCjrN40/G2
         WOtJVsWLjqyT3hKJ4i7qVq4/Y8MHqZAKVLerLdIxJaM1xXX82rNtvrN9qmelsHjDTYrc
         dDxt4EC+mHtiGGwQ8aKjybT9yZkzYLHexCc8s6zGZEJjxDDy/LxugtFytkWQ4eEggPWh
         nboQjVoHg9RycawUFKLDoIZ27P1J+GKVxtQyj1XslNclAAzPAj0Afka/cKSxGWiPkBib
         PEnhor6KZpHhYMhQAmiAY8aZqEXGthRnSA7qCdgD1DNjt4vfnGF71JECCV8DzQ0jcAMH
         318g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+2f7Abc00wPGCUaOzHgs4cliFCaq+b85+1pgNfFOUw=;
        b=O4hm6KD2HHvmAuF9c30/9rhcDNtxwt7IPSCN9YiDjmz3EysN1+Kg6C0hlBPImsa0Z4
         YU2T8DYLVUkmOPIoMo9nUlqe5IE/Y454J0RRrL8aiQkpftFQQv0ra02zPRwGpY4s/HGK
         oLnt9edxwKPUtCgtDF5ZIL8kzX2dZhm1rSNNpX+J4oEpwJXv3W3jyD2L+/6SEDnoBXG/
         GobJkZ3iqOUAyl9ZuQiB3ARACzaCWwv9RWhul2tfJ8kN/Fd5tidRB3LgqRi2njtgm2d9
         uLjGZPiR09JuPjHdpxKzt3EbW3Rky7Jbm8LmocuXuNfimvS1l/8KMZPcaaWhaEi2EajE
         kPcQ==
X-Gm-Message-State: AOAM533UbHbELXHNTlSVzyNT1wSoZGNjPn1PLcy016eM4KSnXW8b69PK
        fp6ywhgASt2OZcAI6uFwtvrcX45/sBQkyFpgtg==
X-Google-Smtp-Source: ABdhPJxG+CRHg/FH/WEFO7yrrptD7wJGkDoNJFoGqpXLMitue3imgpkMlqtC5Zwwf2F7U7XRqd0UBfwLEOXwUaq7O+M=
X-Received: by 2002:a63:ce45:0:b0:399:1124:fbfe with SMTP id
 r5-20020a63ce45000000b003991124fbfemr26375616pgi.542.1649673307723; Mon, 11
 Apr 2022 03:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjm2AdyEZ_-EgexdNDN7SvY4f89=4=FwAL+c0Mg0O+X50A@mail.gmail.com>
 <s5hk0bwcbjh.wl-tiwai@suse.de> <CAMhUBjmr_mHcz2G0tQ2qktGFw6XDLJiDTAHvM1yoRWzvtA6MYg@mail.gmail.com>
 <s5ha6csc7lq.wl-tiwai@suse.de> <s5h7d7wc75u.wl-tiwai@suse.de> <s5h35ijdiab.wl-tiwai@suse.de>
In-Reply-To: <s5h35ijdiab.wl-tiwai@suse.de>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Mon, 11 Apr 2022 18:34:56 +0800
Message-ID: <CAMhUBj=yiAtbYmGDuaBrSxNMrxz6S8DJotwTLihcs64JSOQuVg@mail.gmail.com>
Subject: Re: [BUG] ALSA: echoaudio: warning when the driver fails to probe
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 6:30 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 11 Apr 2022 11:15:41 +0200,
> Takashi Iwai wrote:
> >
> > On Mon, 11 Apr 2022 11:06:09 +0200,
> > Takashi Iwai wrote:
> > >
> > > On Mon, 11 Apr 2022 10:49:53 +0200,
> > > Zheyu Ma wrote:
> > > >
> > > > On Mon, Apr 11, 2022 at 3:41 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > > >
> > > > > On Sun, 10 Apr 2022 11:13:55 +0200,
> > > > > Zheyu Ma wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > I found a bug in echoaudio.c.
> > > > > > When the driver fails at the function snd_echo_create(), it should
> > > > > > release resources requested before, otherwise we will get the
> > > > > > following warning:
> > > > > >
> > > > > > [    3.262866] remove_proc_entry: removing non-empty directory
> > > > > > 'irq/21', leaking at least 'snd_indigodj'
> > > > > > [    3.263577] WARNING: CPU: 3 PID: 261 at fs/proc/generic.c:717
> > > > > > remove_proc_entry+0x389/0x3f0
> > > > > > [    3.267098] RIP: 0010:remove_proc_entry+0x389/0x3f0
> > > > > > [    3.269976] Call Trace:
> > > > > > [    3.269979]  <TASK>
> > > > > > [    3.269988]  unregister_irq_proc+0x14c/0x170
> > > > > > [    3.269997]  irq_free_descs+0x94/0xe0
> > > > > > [    3.270004]  mp_unmap_irq+0xb6/0x100
> > > > > > [    3.270011]  acpi_unregister_gsi_ioapic+0x27/0x40
> > > > > > [    3.270017]  acpi_pci_irq_disable+0x1d3/0x320
> > > > > > [    3.270025]  pci_disable_device+0x1ad/0x380
> > > > > > [    3.270034]  pcim_release+0x566/0x6d0
> > > > > > [    3.270046]  devres_release_all+0x1f1/0x2c0
> > > > > > [    3.270057]  really_probe+0xe0/0x920
> > > > >
> > > > > Could you try the patch below?
> > > >
> > > > The following patch works for me, the previous warning disappears, thank you.
> > > > But I got another error, I have no idea about it.
> > >
> > > OK, that's bad, it's basically the destructor order problem.
> > > Could you try the patch below instead of the previous one?
> >
> > Sorry, the below one instead.
>
> Err, scratch this one, too.  It's a deeper problem than I thought.
> Will post a revised patch later.

Yeah, you are right, these two patches do not work, I got the same
error message.
Thanks for your effort.

Zheyu Ma
