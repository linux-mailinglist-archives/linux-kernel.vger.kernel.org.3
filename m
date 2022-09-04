Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1A5AC593
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 19:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiIDRGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbiIDRGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 13:06:17 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1402E6B6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 10:06:16 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id d189so7210375ybh.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=i3qcw7HhCaizDTCANFYTUOQc7++Sck55u+h2cOgbcPs=;
        b=OYP4jkcIlMcod+Km7VNNnzjl/iJl8P+f+6yVA47ZdGTO3/+q4+BlixDe/RvXAN9SNp
         US2Eyn4jiiloGxRe3SDN0i89ntN9NUAeVYfkAmFqybzdPv9gVWOx2vACZmwWT+/GiFUa
         M8n5X9fufVUQna1T6WT2ksxjMe131y3B7HuMjv5jiQ/wDwSTy7XYzRQDVpeq+SaGdv2L
         H5dMGjalCG6+ZMKbA33wP+Guvh64bUvZzt3iW8kCyLtdaxj1rZkrrsO5zglrfZMSqmYC
         9aF3DFyCUCXZADs0ty/CtscuCA3v8QSDJubLJKOowqSX//5fYgn9KuIAU30TJ+/ZQGAI
         RLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=i3qcw7HhCaizDTCANFYTUOQc7++Sck55u+h2cOgbcPs=;
        b=4Ke3o8i8k0Fk0enR4FksksLr0qrInTdc1KN5auAU7bvNtKxXJBrggO+Z0t0dJD/vFu
         MtKZ7GtVxXWPHtkVOoW/OngWU9ZuI0tP3U+kUQJowLbleXlTN0Pu6d7aiakk3hgsYPAF
         VDTsDZKZOT9pepZTepiJHVycyk5LusrxpvYjBZuRwNMbkOVFX+dNnHB3KpNll39bLE9I
         hwhQCkVTE4T3n0in6SM2fr59WfBFRquyvXIKKEtSwdQ8CdvstZdrie3Zheo4rHNqD/9n
         8GMwf0Zrsi2VoSXHMhy9YC8NoLW+tpkqPcBJt7+ffNCRFqq/8OX2/gYJay37HWWTtKP9
         IhPw==
X-Gm-Message-State: ACgBeo0NIEVP0eXpnOUSWC0ePwa+zWw37h3j0X3ovcXLS6Z2FUhgPQ8e
        LvKOSQz/aCZa26uEL14UPPCJl2/5MIR7PWp0fXs=
X-Google-Smtp-Source: AA6agR4JfByjOTAG8W/b1uuPrWeQICvH9XJtruS1rRFbLq82UO6Hgg/YMreK7N3rx29y884t8A1ednfv0aoNQ1HxifQ=
X-Received: by 2002:a25:dfc5:0:b0:6a6:8214:d4f5 with SMTP id
 w188-20020a25dfc5000000b006a68214d4f5mr7909640ybg.155.1662311175820; Sun, 04
 Sep 2022 10:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAFcO6XN7JDM4xSXGhtusQfS2mSBcx50VJKwQpCq=WeLt57aaZA@mail.gmail.com>
 <87edwrl9i8.wl-tiwai@suse.de>
In-Reply-To: <87edwrl9i8.wl-tiwai@suse.de>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Mon, 5 Sep 2022 01:06:05 +0800
Message-ID: <CAFcO6XPxCN7DEXbUvtRTKq+ku0OJA21gCz_dqMacDpsNUrsUhg@mail.gmail.com>
Subject: Re: A new null-ptr-deref Write bug in snd_pcm_format_set_silence
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, cuibixuan@linux.alibaba.com,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
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

I have tested this patch, it works well.

Regards,
 butt3rflyh4ck.

On Sun, Sep 4, 2022 at 6:27 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sun, 04 Sep 2022 11:48:37 +0200,
> butt3rflyh4ck wrote:
> >
> > Hi, there is a new null-ptr-deref Write bug in
> > snd_pcm_format_set_slience in sound/core/pcm_misc.c in the latest
> > upstream kernel and can reproduce it.
> > We call SNDCTL_DSP_SYNC and SNDCTL_DSP_SPEED in multiple threads to
> > trigger the vulnerability.
> >
> > See the Call Trace:
> > ==================================================================
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
> >  check_region_inline mm/kasan/generic.c:183 [inline]
> >  kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
> >  memset+0x20/0x40 mm/kasan/shadow.c:44
> >  snd_pcm_format_set_silence sound/core/pcm_misc.c:441 [inline]
> >  snd_pcm_format_set_silence+0x215/0x350 sound/core/pcm_misc.c:424
> >  snd_pcm_oss_sync+0x60e/0x800 sound/core/oss/pcm_oss.c:1690
> >  snd_pcm_oss_ioctl+0x2087/0x3420 sound/core/oss/pcm_oss.c:2634
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > ==================================================================
> > We can see the function snd_pcm_format_set_silence code below:
> > ```
> > int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data,
> > unsigned int samples)
> > {
> >         int width;
> >         unsigned char *dst;
> >         const unsigned char *pat;
> >
> >         if (!valid_format(format))
> >                 return -EINVAL;
> >         if (samples == 0)
> >                 return 0;
> >         width = pcm_formats[(INT)format].phys; /* physical width */
> >         pat = pcm_formats[(INT)format].silence;
> >         if (!width || !pat)
> >                 return -EINVAL;
> >         /* signed or 1 byte data */
> >         if (pcm_formats[(INT)format].signd == 1 || width <= 8) {
> >                 unsigned int bytes = samples * width / 8;
> >                 memset(data, *pat, bytes);    ///// [1] ---------> data is NULL
> >                 return 0;
> >         }
> >        ......
> > }
> > ```
> > [1], the data pointer is NULL, we can know snd_pcm_format_set_silence
> > called in line 1690 in sound/core/oss/pcm_oss.c from call stack trace.
> > let we see code below:
> > ```
> > static int snd_pcm_oss_sync(struct snd_pcm_oss_file *pcm_oss_file)
> > {
> >         int err = 0;
> >         unsigned int saved_f_flags;
> >         struct snd_pcm_substream *substream;
> >         struct snd_pcm_runtime *runtime;
> >         snd_pcm_format_t format;
> >         unsigned long width;
> >         size_t size;
> >
> >         substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
> >         if (substream != NULL) {
> >                 runtime = substream->runtime;
> >                 if (atomic_read(&substream->mmap_count))
> >                         goto __direct;
> >                 err = snd_pcm_oss_make_ready(substream);
> >                 if (err < 0)
> >                         return err;
> >                 atomic_inc(&runtime->oss.rw_ref);
> >                 if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
> >                         atomic_dec(&runtime->oss.rw_ref);
> >                         return -ERESTARTSYS;
> >                 }
> >                 format = snd_pcm_oss_format_from(runtime->oss.format);
> >                 width = snd_pcm_format_physical_width(format);
> >                 if (runtime->oss.buffer_used > 0) {
> > #ifdef OSS_DEBUG
> >                         pcm_dbg(substream->pcm, "sync: buffer_used\n");
> > #endif
> >                         size = (8 * (runtime->oss.period_bytes -
> > runtime->oss.buffer_used) + 7) / width;
> >                         snd_pcm_format_set_silence(format,
> >                                                    runtime->oss.buffer
> > + runtime->oss.buffer_used,   ///// [2]
> >                                                    size);
> >                         err = snd_pcm_oss_sync1(substream,
> > runtime->oss.period_bytes);
> >                         if (err < 0)
> >                                 goto unlock;
> >                 } else if (runtime->oss.period_ptr > 0) {
> >
> > ```
> > [2]  runtime->oss.buffer + runtime->oss.buffer_used is the data
> > pointer, but runtime->oss.buffer is NULL here but it doesn't make
> > sense.
> > runtime->oss.buffter is allocated by kvzalloc, if runtime->oss_buffer
> > is NULL, it would return an ENOMEM error.
> > Maybe I think there is a race condition, the runtime->oss.buffer is
> > freed and set to NULL but we can use runtime->oss.buffter via ioctl.
>
> Yeah, likely it's in a small race window between two calls.
>
> Could you try the patch below?
>
>
> thanks,
>
> Takashi
>
> ---
> --- a/sound/core/oss/pcm_oss.c
> +++ b/sound/core/oss/pcm_oss.c
> @@ -1672,14 +1672,14 @@ static int snd_pcm_oss_sync(struct snd_pcm_oss_file *pcm_oss_file)
>                 runtime = substream->runtime;
>                 if (atomic_read(&substream->mmap_count))
>                         goto __direct;
> -               err = snd_pcm_oss_make_ready(substream);
> -               if (err < 0)
> -                       return err;
>                 atomic_inc(&runtime->oss.rw_ref);
>                 if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
>                         atomic_dec(&runtime->oss.rw_ref);
>                         return -ERESTARTSYS;
>                 }
> +               err = snd_pcm_oss_make_ready_locked(substream);
> +               if (err < 0)
> +                       goto unlock;
>                 format = snd_pcm_oss_format_from(runtime->oss.format);
>                 width = snd_pcm_format_physical_width(format);
>                 if (runtime->oss.buffer_used > 0) {



-- 
Active Defense Lab of Venustech
