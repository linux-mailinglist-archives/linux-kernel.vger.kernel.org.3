Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C650E557
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbiDYQRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiDYQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:17:14 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBB5119ECB;
        Mon, 25 Apr 2022 09:14:10 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id q13so3186595qvk.3;
        Mon, 25 Apr 2022 09:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/eL9GDYjRFCawoptuTGZi10s0YbWkPFKn9Go18nZjU=;
        b=Xr6ZCH7bTSE1olKl0pPMaf0soqx0/e3uBQV4wztBoEffrpjZbsFzLA0A/BSzRejmBz
         9nQ9hgyL/XGup5zcEG5j/HGpGN7t0XoQxT3doD9L1eFwsu5cyxtrkOGtJxCQ1LocY7lV
         04tzPvBVMtXUhmbOLRf1Y5l+yBb+5gEqbKSmzdbGA72x61nV62A2btwR3eD7USj2H+C6
         nwnLhPoVFVGhOk8jOzU0Gr9namyFbrbVmj1HgGWVTscGj0Q3puCqYgjlcVijNHTqNEVA
         ytPhuHNY78ZatGCJ2zfcPczFKhyq3mR2AdRsfpJkCXEqiqlK/J3zAcrjxV+G1feQyT59
         eLwA==
X-Gm-Message-State: AOAM530yKMUH4JjTG8eCT3KKRvvpR0oV4kucIBbI+duD1dpHWplAcSiq
        9frk/YNUDfvTxdmryniTC6xF1O8JO1J+OA==
X-Google-Smtp-Source: ABdhPJw3vOKWZ8diKGYP6ScuBbvAHyOpZ9JzQxviauKfC0ehpc5jcXT9vVPVKK/UhjS9xgcBLuluyA==
X-Received: by 2002:a05:6214:2387:b0:456:3f38:8298 with SMTP id fw7-20020a056214238700b004563f388298mr1636828qvb.32.1650903249309;
        Mon, 25 Apr 2022 09:14:09 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id j64-20020a375543000000b0069f16d1fb73sm5233881qkb.119.2022.04.25.09.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 09:14:09 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2eba37104a2so154261167b3.0;
        Mon, 25 Apr 2022 09:14:08 -0700 (PDT)
X-Received: by 2002:a81:e10d:0:b0:2f7:bb2a:6529 with SMTP id
 w13-20020a81e10d000000b002f7bb2a6529mr13948153ywh.62.1650903248631; Mon, 25
 Apr 2022 09:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220421203555.29011-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421203555.29011-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX4_PKsGGRj6yGhDGfaRD-6PqiJeCnKq0yUicfMutOP4g@mail.gmail.com> <CA+V-a8uJM0etygB-v+rs0+EKY6_tz90wH_ZOVH8Zbc8dQPmQGw@mail.gmail.com>
In-Reply-To: <CA+V-a8uJM0etygB-v+rs0+EKY6_tz90wH_ZOVH8Zbc8dQPmQGw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Apr 2022 18:13:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXHqn5_segVMhn_biEXnOSyaLpPfv4jkFp2uxv-=bfqew@mail.gmail.com>
Message-ID: <CAMuHMdXHqn5_segVMhn_biEXnOSyaLpPfv4jkFp2uxv-=bfqew@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: sh: rz-ssi: Drop unused macros
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Apr 25, 2022 at 6:09 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Mon, Apr 25, 2022 at 1:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Apr 22, 2022 at 7:32 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > Drop unused macros SSIFSR_TDC and SSIFSR_RDC.
> > >
> > > Reported-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > What does this fix?
> > Is the real issue that there are 32 FIFO entries, and the TDC and RDC
> > fields are 6 bits wide, while the mask uses 0x1f instead of 0x3f?
> >
> I was in two minds here as you have already spotted the masks are
> incorrect, instead of fixing the masks I choose to drop the macros
> itself as they were not used. Let me know what are your thoughts on
> this.

IC.

I don't have a preference.
So please either remove them, and make it clear they were wrong,
so no one is tempted to just revert the removal to start using the
definitions, or either keep them, and fix the definitions.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
