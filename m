Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D9950E538
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbiDYQNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243301AbiDYQMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:12:54 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71FD3D4A7;
        Mon, 25 Apr 2022 09:09:50 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2f16645872fso153580947b3.4;
        Mon, 25 Apr 2022 09:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+YGyyvxmVQsjoghQqTNW1wKDQoME3+KpFRO6Pk4ojM=;
        b=UOw5xEgrezVMySsWbd7cQD1CpEjNyLxCCoI6oPAr8GLZz1AK7woJPeLzkysiCJ/fCH
         jg5VdERY072dJgMScLn/8Wyu9cpQKldbZJIRfucUcyZB+jXaf67NiAstomWuMxemFa6a
         pmkVOpohdd5uXCGYNPB4kGih9e6VNKbEe0KwlStq6nsqlelDF+AIox9Zq+cqv0T4Dlg8
         Hkghu0N6XX90phMspeEOuMWq6PA+/upYOZb1m3PNQsMckH0Ueyvxg/R1Gs/0fIwUpFbK
         XuTVWiE5a5yjSrA0k9SyLSoYFSzYX4W+fehemBKMukB8elacGxIjjVkmrvwCjrc0rxK0
         y7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+YGyyvxmVQsjoghQqTNW1wKDQoME3+KpFRO6Pk4ojM=;
        b=gP513mPHtRlpDdYrXhuLVY7zS5pVkU6JGSfp3ah6G7gugNrvKAmgoZSNZH6cA62a5q
         WCwU7AaFjcVznabsjzTBaLDPl/UsE0lCPNgoa4Q4rHKgdfNUXzj4TVAEXo+OBcRkA4Xs
         CcLPw3KZ/nS0GZoOIsW4u+rd0d9v1Ho/n8FRP49FnVw9eC8bxjVtnNYHprX/vLqhjdCP
         6zRa3+YMFbSQO2GlQeA/S9SViMtYfHFtdvFr0Ln43zyKsO3soososPVzQX1NbODcLnrj
         k87IzmCKr+Fd1Uz22uqnhenLigPIRHfxwYKKrAhqiBuVTM8tpKnjc2J6NnhJhsIAEiDj
         /P1A==
X-Gm-Message-State: AOAM532/MF/JkCGvX1pWURTSNT0HNRf/LPZwy+cxWUcFCCKay5CeS9dJ
        PhcI3UYj53jp7wBmMazll/GIhhI96cjBHy4Iv24=
X-Google-Smtp-Source: ABdhPJwSk+XEHjpr8/LhP/EKsZTQ6fi7CuJfqMiakpJg7HM+CpmMFudO8mcVoBL6s1KoWOeKBCr8MKF+xn9qMETzjn8=
X-Received: by 2002:a81:9210:0:b0:2f4:d8f7:98e9 with SMTP id
 j16-20020a819210000000b002f4d8f798e9mr17613086ywg.265.1650902989991; Mon, 25
 Apr 2022 09:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220421203555.29011-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421203555.29011-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdX4_PKsGGRj6yGhDGfaRD-6PqiJeCnKq0yUicfMutOP4g@mail.gmail.com>
In-Reply-To: <CAMuHMdX4_PKsGGRj6yGhDGfaRD-6PqiJeCnKq0yUicfMutOP4g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 25 Apr 2022 17:09:23 +0100
Message-ID: <CA+V-a8uJM0etygB-v+rs0+EKY6_tz90wH_ZOVH8Zbc8dQPmQGw@mail.gmail.com>
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

Thank you for the review.

On Mon, Apr 25, 2022 at 1:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Apr 22, 2022 at 7:32 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Drop unused macros SSIFSR_TDC and SSIFSR_RDC.
> >
> > Reported-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> What does this fix?
> Is the real issue that there are 32 FIFO entries, and the TDC and RDC
> fields are 6 bits wide, while the mask uses 0x1f instead of 0x3f?
>
I was in two minds here as you have already spotted the masks are
incorrect, instead of fixing the masks I choose to drop the macros
itself as they were not used. Let me know what are your thoughts on
this.

Cheers,
Prabhakar

> > --- a/sound/soc/sh/rz-ssi.c
> > +++ b/sound/soc/sh/rz-ssi.c
> > @@ -59,9 +59,7 @@
> >  #define SSIFSR_RDC_MASK                0x3f
> >  #define SSIFSR_RDC_SHIFT       8
> >
> > -#define SSIFSR_TDC(x)          (((x) & 0x1f) << 24)
> >  #define SSIFSR_TDE             BIT(16)
> > -#define SSIFSR_RDC(x)          (((x) & 0x1f) << 8)
> >  #define SSIFSR_RDF             BIT(0)
> >
> >  #define SSIOFR_LRCONT          BIT(8)
>
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
