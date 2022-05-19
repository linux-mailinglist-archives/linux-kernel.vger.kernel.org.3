Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7378252CB96
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiESFpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiESFpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:45:14 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330AEBA57B;
        Wed, 18 May 2022 22:45:13 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i11so7203828ybq.9;
        Wed, 18 May 2022 22:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OO5QfkSjnZ/cUUUJ0aPadwaoIkqNmNY8ULRaHcmvwDI=;
        b=LlU651kk2sjEpLEGf81r+AAuqbC1cCColEFLQMJpvNK2KJZXq3EteAT2fkzG+fBJLq
         J3uWu4ZpkZvauoeZn4SqYuOd3WlnzNscTxb+tITJ29GVpXzRf5KJPimMSAEatrK6VLdd
         VojQFvyEQec5wkJ5w4G0F3Fws5pPia44QYC6Tpo/Eduy7zY+pmVH0grE+Bdt9c77jFrv
         uAGRsjUej2bsi9hJZTAEnzFdulu39S6CaFvuW5vTJGCpRbLrGgds3iyg7n/kt0zbbkwT
         PLMVtgYEwPT5aqyGuHDNYSHb4W44bz0uhWpHq4N97n3bb6EWsP/Gp6lSspz54Ip0ohi8
         Yt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OO5QfkSjnZ/cUUUJ0aPadwaoIkqNmNY8ULRaHcmvwDI=;
        b=xl63eaerSJe27zur1iM3Jio1xfzugWN9T3K49AZwmWdUPZgqgCx+LamXFLTab03lwO
         vWcJHFGS4wHi1orOcY0tAqncicFweUEgQ7aExc/Lh5ZpLBZLbna2SaUBbQLO0YGlnmUA
         XtA0kDbXZZQ40DbIQUhlqqjy9X8LntCIfytOC+WMZKtJoTfO2JticfDgzw2XdHfYMPl0
         PYQpS0YqsQTA16M/SWI5BsE2VbyShTv5zs46ht/pPXQdvusAcXvaFhBGFDqpTOHotIH+
         m48eRSCbTmeILYdc+ATVumQuQJyu7vvkiHbprZZPImVaVHAhfWLKUlW7BJ6Ku7gUxgmK
         HFBw==
X-Gm-Message-State: AOAM531EmhYNi/LHUO9TBpI9O0fVDXuFIp/zq42E2JrDLy8EI6uYIkfg
        7hvHqbks2toRxp9EHEkwuuUERwcRRj+FTpJRuVGcNPpECFw3lA==
X-Google-Smtp-Source: ABdhPJw6GBlelR+tbudinQOnNGE8N4fHr2U489qVow3itikJQLf6uJMmLuAe8AFXaamN81tR1nT/2QX8pO95R5L8e1s=
X-Received: by 2002:a25:ad8a:0:b0:64d:e1ef:a214 with SMTP id
 z10-20020a25ad8a000000b0064de1efa214mr2766567ybi.417.1652939112051; Wed, 18
 May 2022 22:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220505193143.31826-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdX0egGvyu94-=tJdvW0=q6Y==ZNkexCJpnmrNJezuiqDw@mail.gmail.com>
In-Reply-To: <CAMuHMdX0egGvyu94-=tJdvW0=q6Y==ZNkexCJpnmrNJezuiqDw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 19 May 2022 06:44:45 +0100
Message-ID: <CA+V-a8sxZOZRXG_gsCnQGJdNDw-uVLmuTZ-dOsmUfhS9KL0Esg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] dt-bindings: clock: r9a07g043-cpg: Add Renesas
 RZ/Five CPG Clock and Reset Definitions
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
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

Hi Geert,

Thank you for the review.

On Tue, May 10, 2022 at 3:02 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> Thanks for your patch!
>
> On Thu, May 5, 2022 at 9:32 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Renesas RZ/Five SoC has almost the same clock structure compared to the
> > Renesas RZ/G2UL SoC, re-use the r9a07g043-cpg.h header file and just
> > ammend the RZ/Five CPG clock and reset definitions.
>
> amend
>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > --- a/include/dt-bindings/clock/r9a07g043-cpg.h
> > +++ b/include/dt-bindings/clock/r9a07g043-cpg.h
> > @@ -108,6 +108,15 @@
> >  #define R9A07G043_ADC_ADCLK            76
> >  #define R9A07G043_ADC_PCLK             77
> >  #define R9A07G043_TSU_PCLK             78
> > +#define R9A07G043_NCEPLDM_DM_CLK       79      /* RZ/Five Only */
>
> While NCEPLDM_DM_CLK is listed in the clock list spreadsheet, its
> control bit is not documented.
>
> > +#define R9A07G043_NCEPLDM_ACLK         80      /* RZ/Five Only */
> > +#define R9A07G043_NCEPLDM_TCK          81      /* RZ/Five Only */
>
> While NCEPLDM_TCK is listed in the clock list spreadsheet, its
> control bit is not documented.
>
I have got the feedback for the above, NCEPLDM_DM_CLK and NCEPLDM_TCK
clocks cannot be stopped as a result there are no register bits for it
in the HW manual (clock spreadsheet will be updated). I will drop this
and send a v2 including your RB.

Cheers,
Prabhakar

> The rest LGTM, so with the above clarified
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
