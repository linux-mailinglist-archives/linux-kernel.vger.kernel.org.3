Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC01A50E656
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbiDYQ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbiDYQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:59:27 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC30238DA6;
        Mon, 25 Apr 2022 09:56:22 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id g28so8798767ybj.10;
        Mon, 25 Apr 2022 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nHqpeRMqi5ydu/1+qACR0gpSXJ+684PjSvA8TxDFDQ=;
        b=TNxzFJ8skf6JzWlQLq0qfcPcp7scN5ongV1p4rF70j/cQMSIwM3xmHdr80cGpfnQ8t
         bwU+6TOYcj9nf/oQV2ZDfEAdjpln2UkrxwU/0EGj0iOaLrsX4/cm/hZEEALcXe5VrY6/
         epw0T6c0XF4XjmANfKc5Ro97ve1Wni1Yb4QjwuoQ0ic9X4aaAhzZ3QkwzFRrCGZEw+9F
         4DxdR8elStD1ojHmhL/sxWsFJ1pSQ3sm5tHtwLFQtbLxEz9Au5fk5Y/8i2DZIhaNnmNy
         Lnr3yoHg7X4I2WDsUGxjIcgC/MW+iUyyipAXDluVM+TRG+++tnVEarotaTD+ex+NJAu4
         gtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nHqpeRMqi5ydu/1+qACR0gpSXJ+684PjSvA8TxDFDQ=;
        b=M4WARQ91y+4nbqa7G+njd7DlU/p2qi33X9j2v9cuwsidtrlNdyVZPfnWW1rmzfeBzx
         oslWWwe1eulQkgZZixoJQnbhhGrD2Vk99Mo0M7B5JoVyVNdajFJ3nUGg9j8qHYyC/N1A
         jq4LHi2vQto3nZqMr1XMSCB2Tqt4VXrDxodvoP3811NBF0BJd48+Ho1cHbjOiAm7sR+e
         e3nweB4HIOe2nMmMVEHx3hrFS8wr8GMa1YDCp8CWugVgNRzIK0AUFBA/RPrTYjTX4MG/
         1ydv/NnDDwmd3CfFX/q4/R9dW5cu5SlNEktnEE/XFlGibcgXdfPb1cX1MW9u4uV/AE33
         gF7Q==
X-Gm-Message-State: AOAM532P+gHh1KhkPSlewkx5R/ko2Ue1kADw8FI/B18+zV5POaUxeGuC
        2imYEw1gB12VKbS5hnxPTtMYVkVRS+05t19q6yM=
X-Google-Smtp-Source: ABdhPJyWZiXKSCBdfFrt30g49h5Yv7uJinQN6d/QX58gjVXXpGO8EFW+Kr8l2GgSAyg0gVQdgXt/gqLoy+hS947pohI=
X-Received: by 2002:a25:42cd:0:b0:645:d805:4fcb with SMTP id
 p196-20020a2542cd000000b00645d8054fcbmr13531376yba.182.1650905782127; Mon, 25
 Apr 2022 09:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220421203555.29011-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421203555.29011-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX4_PKsGGRj6yGhDGfaRD-6PqiJeCnKq0yUicfMutOP4g@mail.gmail.com>
 <CA+V-a8uJM0etygB-v+rs0+EKY6_tz90wH_ZOVH8Zbc8dQPmQGw@mail.gmail.com> <CAMuHMdXHqn5_segVMhn_biEXnOSyaLpPfv4jkFp2uxv-=bfqew@mail.gmail.com>
In-Reply-To: <CAMuHMdXHqn5_segVMhn_biEXnOSyaLpPfv4jkFp2uxv-=bfqew@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 25 Apr 2022 17:55:55 +0100
Message-ID: <CA+V-a8sYWv+K8_QRFFzEupWMD3i4Y9MCta-FfM2_Qv37dHNsAg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: sh: rz-ssi: Drop unused macros
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pavel Machek <pavel@denx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Geert,

On Mon, Apr 25, 2022 at 5:14 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Apr 25, 2022 at 6:09 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Mon, Apr 25, 2022 at 1:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Apr 22, 2022 at 7:32 PM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > Drop unused macros SSIFSR_TDC and SSIFSR_RDC.
> > > >
> > > > Reported-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > What does this fix?
> > > Is the real issue that there are 32 FIFO entries, and the TDC and RDC
> > > fields are 6 bits wide, while the mask uses 0x1f instead of 0x3f?
> > >
> > I was in two minds here as you have already spotted the masks are
> > incorrect, instead of fixing the masks I choose to drop the macros
> > itself as they were not used. Let me know what are your thoughts on
> > this.
>
> IC.
>
> I don't have a preference.
> So please either remove them, and make it clear they were wrong,
> so no one is tempted to just revert the removal to start using the
> definitions, or either keep them, and fix the definitions.
>
I'll go with dropping them and make it clear they were wrong.

Cheers,
Prabhakar

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
