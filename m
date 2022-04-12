Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B6E4FCBEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343699AbiDLBi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243978AbiDLBiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:38:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A462126A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:36:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z16so16138862pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFRvD+s5/CV5Fwvh/2Kxb6y/LQ1QtPgz7+1+S1OLjeI=;
        b=pqKOYr+LXaLecw0bb3DNqMe5E+IhIVzHNhjtZO1lym0KqdJPOKFntKwBTpuaiBTzQO
         fDVd8MCm8Y2D/De+jtEFuZjBJRjPTtB1+A0OhThytabGmrgoE3+7ZbQ3gjzAvkL5OiqT
         kj1+r1xM6lAgXNDoAcyF6S2c8LRJIiw0yHtBRi1rqfv3bxdWIk6NnxGvEvex7fyX90BM
         mzm1BsKvbOw22Mi4ytOyvzyjDUvvf3T+Rb1CphVJZ74sKzVBt3grHwndcAx5vFCgyqdJ
         6iq6UxkE+t27QKQfY4VKpMu0MHtdO/tzlmmv7iEdDhULluaGopxoj1hAUQy+udOxzaDH
         tZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFRvD+s5/CV5Fwvh/2Kxb6y/LQ1QtPgz7+1+S1OLjeI=;
        b=5cjZeDQeqqk0ecwrJ1JsU5kt/nFyVQR/SAtaj+ZMt0oG8afC5pjiL+WsDD57erC16p
         augly0Pxvaedv2lkRBqRijegYKc4Pj898eer+ldhio3czjb+gh7Glo5QDcJvhUns87Mt
         o3ziHnVO9FeiUBZ5baBHHUgOFeuVzlASw16DqSBE7+4IuzHrUGO6Ql1d4s+vQx3sHjzw
         2ULUh7R8jVOikfw4pQz5SEWmrrLNVZ6XfJltM8xIdmKfOTDLfR0+EAFhoOV8JJYGaKHB
         T5cX6svpyfCmFbQmGBDycVuLjGfObq09J3BrtP0Pda17u4s4YVegq9Gq6ZH4lC8OP3VK
         D96w==
X-Gm-Message-State: AOAM533jDq4TURVtasKtfK9Dvhe66EgcEu4YkBeQhkfBF34dZ3WWJMbY
        1XQ9y2CrOyXNZlVHy0FiVjei83Ikmj/gle+4sg==
X-Google-Smtp-Source: ABdhPJxOjebZBWztw/YCoC8rhytZT8acARz0zbn9BB5A9VE2qQTyOtE549aCPF8GIsh+UoJKJAW5VnRHIh6cfQSgFGs=
X-Received: by 2002:a63:610:0:b0:39d:300c:ad9b with SMTP id
 16-20020a630610000000b0039d300cad9bmr9563708pgg.113.1649727398350; Mon, 11
 Apr 2022 18:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjm2AdyEZ_-EgexdNDN7SvY4f89=4=FwAL+c0Mg0O+X50A@mail.gmail.com>
 <s5hk0bwcbjh.wl-tiwai@suse.de> <CAMhUBjmr_mHcz2G0tQ2qktGFw6XDLJiDTAHvM1yoRWzvtA6MYg@mail.gmail.com>
 <s5ha6csc7lq.wl-tiwai@suse.de> <s5h7d7wc75u.wl-tiwai@suse.de>
 <s5h35ijdiab.wl-tiwai@suse.de> <CAMhUBj=yiAtbYmGDuaBrSxNMrxz6S8DJotwTLihcs64JSOQuVg@mail.gmail.com>
 <s5hsfqjbqk7.wl-tiwai@suse.de>
In-Reply-To: <s5hsfqjbqk7.wl-tiwai@suse.de>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Tue, 12 Apr 2022 09:36:27 +0800
Message-ID: <CAMhUBjno-2qCe5FDF0ftuy5aoq=735N4_SeQyQRpDEsurAsU+w@mail.gmail.com>
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

On Mon, Apr 11, 2022 at 11:14 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 11 Apr 2022 12:34:56 +0200,
> Zheyu Ma wrote:
> >
> > On Mon, Apr 11, 2022 at 6:30 PM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Mon, 11 Apr 2022 11:15:41 +0200,
> > > Takashi Iwai wrote:
> > > >
> > > > On Mon, 11 Apr 2022 11:06:09 +0200,
> > > > Takashi Iwai wrote:
> > > > >
> > > > > On Mon, 11 Apr 2022 10:49:53 +0200,
> > > > > Zheyu Ma wrote:
> > > > > >
> > > > > > On Mon, Apr 11, 2022 at 3:41 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > > >
> > > > > > > On Sun, 10 Apr 2022 11:13:55 +0200,
> > > > > > > Zheyu Ma wrote:
> > > > > > > >
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > I found a bug in echoaudio.c.
> > > > > > > > When the driver fails at the function snd_echo_create(), it should
> > > > > > > > release resources requested before, otherwise we will get the
> > > > > > > > following warning:
> > > > > > > >
> > > > > > > > [    3.262866] remove_proc_entry: removing non-empty directory
> > > > > > > > 'irq/21', leaking at least 'snd_indigodj'
> > > > > > > > [    3.263577] WARNING: CPU: 3 PID: 261 at fs/proc/generic.c:717
> > > > > > > > remove_proc_entry+0x389/0x3f0
> > > > > > > > [    3.267098] RIP: 0010:remove_proc_entry+0x389/0x3f0
> > > > > > > > [    3.269976] Call Trace:
> > > > > > > > [    3.269979]  <TASK>
> > > > > > > > [    3.269988]  unregister_irq_proc+0x14c/0x170
> > > > > > > > [    3.269997]  irq_free_descs+0x94/0xe0
> > > > > > > > [    3.270004]  mp_unmap_irq+0xb6/0x100
> > > > > > > > [    3.270011]  acpi_unregister_gsi_ioapic+0x27/0x40
> > > > > > > > [    3.270017]  acpi_pci_irq_disable+0x1d3/0x320
> > > > > > > > [    3.270025]  pci_disable_device+0x1ad/0x380
> > > > > > > > [    3.270034]  pcim_release+0x566/0x6d0
> > > > > > > > [    3.270046]  devres_release_all+0x1f1/0x2c0
> > > > > > > > [    3.270057]  really_probe+0xe0/0x920
> > > > > > >
> > > > > > > Could you try the patch below?
> > > > > >
> > > > > > The following patch works for me, the previous warning disappears, thank you.
> > > > > > But I got another error, I have no idea about it.
> > > > >
> > > > > OK, that's bad, it's basically the destructor order problem.
> > > > > Could you try the patch below instead of the previous one?
> > > >
> > > > Sorry, the below one instead.
> > >
> > > Err, scratch this one, too.  It's a deeper problem than I thought.
> > > Will post a revised patch later.
> >
> > Yeah, you are right, these two patches do not work, I got the same
> > error message.
> > Thanks for your effort.
>
> Here we go, a revised patch.  Basically it enforces the call of
> snd_card_free() at the error path during probe.

Thanks for your patch, it works for me :)

Tested-by: Zheyu Ma <zheyuma97@gmail.com>

Zheyu Ma
