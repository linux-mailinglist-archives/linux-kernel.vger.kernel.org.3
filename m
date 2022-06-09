Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D2054481B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241796AbiFIJ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiFIJ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:56:48 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084773A780A;
        Thu,  9 Jun 2022 02:56:47 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id s39so13323973ybi.0;
        Thu, 09 Jun 2022 02:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trU76HfpJ1kVO7VlsUAYRiM1gRVI7EygRQZUmQ7VGqo=;
        b=fgKM2m+rhk/HGRenipS8Qk3+m9xu5wfr47e9uF7eE1YRJ0ybfQejhpfXLQChff+XYv
         hafih0d855i3MrUhMB2sGhxM9w2JmLEH9tiJZNdGufcB0lrtJEIjQ2SIAw0JO7YYutDQ
         Xv+uK+WlC5o9hlCyfk43tb0wBV0AsDfy863XUjzH6HNO4sFwN3t4i1SAb2BuU+z6n+XH
         kvzJyEFiBzfNsQXOsByiXIoe1vLrWoLmvlzrZTSyOj2JfcPrrYb9Y0YjYsV/i4XmA0mN
         h732l4AK8a0K2QVLtpMqmWZnCfoqvT18IUxfP5xWulq0rpRiIdhkYa3U3h8RWxgbEc9g
         JgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trU76HfpJ1kVO7VlsUAYRiM1gRVI7EygRQZUmQ7VGqo=;
        b=Yz1oJtwJB5SxzppO5o7e6XshCfJv6x6R9prr0m0S9CNuHVjypTLMLZ+QHpPKGWMzoo
         r/rs8bo1kvoDdVuumVttOzDfmhKWEG3qVgKUGoBq5GQ1xNDhnNLG0TvVRPb3j9xOmMdf
         CSR4AGfLYvwnN+aA5AZxTDRU2RgtAkLbCGMAhfoIfpWeq0A2NsIYPyuHCcHgG3SnMs+5
         EWMNDvdqZrbghKBFLLoPiMe1a+hWPDVxvb6n5ygn/aoZkyBb+jQgeUodk9NoZLL9n0mq
         aq53Xv6JAvtN4q+MYifV+nlbXMU5TvwzxN8Yk1zC1rW4mIMV0j/XbQo/VlsIWOJWZJij
         gxrg==
X-Gm-Message-State: AOAM5313VHESguNN1i+QRfIpjABZD1Xpec43zcViLLvucLg/Jr/0D9Mp
        K8SBMMvSv6vIyIfJ57vK/vXCSwRS4GvVtReth7k=
X-Google-Smtp-Source: ABdhPJxhy2kL9Nq1aL2YQVFH7TdE2ydKeKC87G9lJV827pmes5MPSF3+nz+aCbGUsxsZ9EA+TZcoqpeUR27tr8/ClLA=
X-Received: by 2002:a25:cc4c:0:b0:65c:8e83:fd5e with SMTP id
 l73-20020a25cc4c000000b0065c8e83fd5emr41469747ybf.563.1654768606253; Thu, 09
 Jun 2022 02:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220505193143.31826-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX0egGvyu94-=tJdvW0=q6Y==ZNkexCJpnmrNJezuiqDw@mail.gmail.com>
 <CA+V-a8sxZOZRXG_gsCnQGJdNDw-uVLmuTZ-dOsmUfhS9KL0Esg@mail.gmail.com> <CAMuHMdW0hbVnCcbcC5E8J7Jc_UZPVSpHkmtPd3Haio-WnhhbpQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW0hbVnCcbcC5E8J7Jc_UZPVSpHkmtPd3Haio-WnhhbpQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 9 Jun 2022 10:56:20 +0100
Message-ID: <CA+V-a8tD5E7J5pG7yFZ7aiJ58Zt5MMRiC8o3VRFhudkqW1y5XQ@mail.gmail.com>
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

Sorry for the late reply.

On Thu, May 19, 2022 at 7:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, May 19, 2022 at 7:45 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Tue, May 10, 2022 at 3:02 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, May 5, 2022 at 9:32 PM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > Renesas RZ/Five SoC has almost the same clock structure compared to the
> > > > Renesas RZ/G2UL SoC, re-use the r9a07g043-cpg.h header file and just
> > > > ammend the RZ/Five CPG clock and reset definitions.
> > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > > --- a/include/dt-bindings/clock/r9a07g043-cpg.h
> > > > +++ b/include/dt-bindings/clock/r9a07g043-cpg.h
> > > > @@ -108,6 +108,15 @@
> > > >  #define R9A07G043_ADC_ADCLK            76
> > > >  #define R9A07G043_ADC_PCLK             77
> > > >  #define R9A07G043_TSU_PCLK             78
> > > > +#define R9A07G043_NCEPLDM_DM_CLK       79      /* RZ/Five Only */
> > >
> > > While NCEPLDM_DM_CLK is listed in the clock list spreadsheet, its
> > > control bit is not documented.
> > >
> > > > +#define R9A07G043_NCEPLDM_ACLK         80      /* RZ/Five Only */
> > > > +#define R9A07G043_NCEPLDM_TCK          81      /* RZ/Five Only */
> > >
> > > While NCEPLDM_TCK is listed in the clock list spreadsheet, its
> > > control bit is not documented.
> > >
> > I have got the feedback for the above, NCEPLDM_DM_CLK and NCEPLDM_TCK
> > clocks cannot be stopped as a result there are no register bits for it
> > in the HW manual (clock spreadsheet will be updated). I will drop this
> > and send a v2 including your RB.
>
> The question is not if the clocks can be stopped or not, but if there
> is any need to refer to them from a DT node.
As per DT rule we have to add ;)

> What's the nature of the future update to the clock spreadsheet?
>
I have got confirmation from HW team, the UM and clock list will not be updated,

* NCEPLDM_DM_CLK, NCEPLDM_TCK and NCEPLDM_ACLK actually exist, and
should be listed on the clock list. Only NCEPLDM_ACLK has a mechanism
to stop.
* Therefore, only NCEPLDM_ACLK should appear on the Clock Control
register on the UM.

> Of course, if we don't add these clock definitions now, they can
> still be added later. DT binding definitions are append-only.
>
For now I will keep them.

Cheers,
Prabhakar
