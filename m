Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8C2521CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbiEJOpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344591AbiEJOog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:44:36 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584141D813F;
        Tue, 10 May 2022 07:02:45 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id h3so13557165qtn.4;
        Tue, 10 May 2022 07:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eo4bvoP53C2MoW6V75kNM+g38FmbVeaQf6g2Gfg1ZIw=;
        b=w9HN3UC6in9VO+I9lJ2TZ4RNLV7Qh2vqRUn9l6ZOU9Suj7HfwDxbslU91D2aGo/sNA
         qBMW+/2kCEHO3avNzENtmJcm1+Sb4W/pQanR102Sdtfbna2pxoX/ISv4Ug0154IYq4Nj
         Eg5iXxgcBGlL4NAbengjSzlUBxBltwmCOSdTJP6Y6uI64krdC9WgYLWhbQJrRl9GX3Rl
         teWcgEYZvZMLudq7pR/Be11TveT/5iZGC0ggjVJKfU7NwSxZRe+RECfmUoKHsgVtL9dg
         zFopbTek21PurBvLgN6ubMjLe3QCE2ihQqwNT9v2IQYmapCkDvNe76gcVg+ecdRH4DWV
         WFlQ==
X-Gm-Message-State: AOAM533di2dewDb5fyUXsEYfYFtmu79usIGIyBA4L1Sm7GHiR05KwaFP
        0mL5LUyKtYRVzZNj0aYtRj7eZ+IVSLO+FA==
X-Google-Smtp-Source: ABdhPJwhZWgXKzEZNlxRqwe1qWNt5FrI4bOzM8l7JcsE4GLFOcxOk1BC1zHhNZldQ7CbmAAKW+QBmw==
X-Received: by 2002:a05:622a:c4:b0:2f3:e383:7386 with SMTP id p4-20020a05622a00c400b002f3e3837386mr3255652qtw.521.1652191364329;
        Tue, 10 May 2022 07:02:44 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id j11-20020a05620a288b00b0069fcebf9c0asm9386809qkp.37.2022.05.10.07.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 07:02:43 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id r1so4180428ybo.7;
        Tue, 10 May 2022 07:02:43 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr18143399ybb.202.1652191363172; Tue, 10
 May 2022 07:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220505193143.31826-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220505193143.31826-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 May 2022 16:02:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0egGvyu94-=tJdvW0=q6Y==ZNkexCJpnmrNJezuiqDw@mail.gmail.com>
Message-ID: <CAMuHMdX0egGvyu94-=tJdvW0=q6Y==ZNkexCJpnmrNJezuiqDw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] dt-bindings: clock: r9a07g043-cpg: Add Renesas
 RZ/Five CPG Clock and Reset Definitions
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thanks for your patch!

On Thu, May 5, 2022 at 9:32 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Renesas RZ/Five SoC has almost the same clock structure compared to the
> Renesas RZ/G2UL SoC, re-use the r9a07g043-cpg.h header file and just
> ammend the RZ/Five CPG clock and reset definitions.

amend

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> --- a/include/dt-bindings/clock/r9a07g043-cpg.h
> +++ b/include/dt-bindings/clock/r9a07g043-cpg.h
> @@ -108,6 +108,15 @@
>  #define R9A07G043_ADC_ADCLK            76
>  #define R9A07G043_ADC_PCLK             77
>  #define R9A07G043_TSU_PCLK             78
> +#define R9A07G043_NCEPLDM_DM_CLK       79      /* RZ/Five Only */

While NCEPLDM_DM_CLK is listed in the clock list spreadsheet, its
control bit is not documented.

> +#define R9A07G043_NCEPLDM_ACLK         80      /* RZ/Five Only */
> +#define R9A07G043_NCEPLDM_TCK          81      /* RZ/Five Only */

While NCEPLDM_TCK is listed in the clock list spreadsheet, its
control bit is not documented.

The rest LGTM, so with the above clarified
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
