Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E147D4F2495
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 09:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiDEHWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 03:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiDEHVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:21:32 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659002673;
        Tue,  5 Apr 2022 00:19:06 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id r127so9594161qke.13;
        Tue, 05 Apr 2022 00:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QPcHUa3F1FA3vGNrAzISpugHlEW8eB7hP5JHaRv4hrM=;
        b=2VeVDB7OZ21ARY3D6FR+O6Qd4/cMURF/Xhkjv6Yo8mMgNi4K1hPphfinp2kY0pWQvo
         3TS38hjc5WmkvAZkq5ydxXv++oLtFuqRSbUilFOrNx7g/1JthZzBO5ESrz8eWHZMqJNR
         ieHoh6+eWz3Ux8csG9ccca/ibnRbeIZ5p/T1F2JhBIvf8LVlPQBf58adciPdafODgT6P
         NwbzLAlwZpatFTy8x6C/iRAILxvaoBZ+xSfzRpVzULDFZZFWP2IC4CB+ZAFr1UtiY8Bt
         ZqQJU5h/+vQHfNVxZJbYsHdKlTsCXmTPCZ1hdDrU+nfW2+18F1cX8Yb8QmS0EQcwvR22
         g/6Q==
X-Gm-Message-State: AOAM533VbF/QSwTJcX/fOHRsVQFnsf9mkw0bvRak6wbsfstOes4X90YU
        uB/yjlLd6oSwXecioUZqI7XcoXXTUwWPJg==
X-Google-Smtp-Source: ABdhPJzS64ah6w0hW3u2e851zl5OCdww2oZHYhBXIowQVAYee0J8TD5wZs/52A+TpOIlRNryXMeFjQ==
X-Received: by 2002:ae9:ed97:0:b0:67b:2755:310f with SMTP id c145-20020ae9ed97000000b0067b2755310fmr1260790qkg.117.1649143145432;
        Tue, 05 Apr 2022 00:19:05 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id o21-20020ac85a55000000b002e16389b501sm10098113qta.96.2022.04.05.00.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 00:19:05 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id x131so9251734ybe.11;
        Tue, 05 Apr 2022 00:19:04 -0700 (PDT)
X-Received: by 2002:a5b:a8f:0:b0:633:fd57:f587 with SMTP id
 h15-20020a5b0a8f000000b00633fd57f587mr1518396ybq.506.1649143144568; Tue, 05
 Apr 2022 00:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404172322.32578-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Yks3Q75ZrUkXSjwz@ninjato> <CA+V-a8skF4h6yhjSFw5PXQEbgKEQt6kMs9bEsO3OCNfE1hu46A@mail.gmail.com>
 <YkvJXu7Y6Tc68U9e@shikoro>
In-Reply-To: <YkvJXu7Y6Tc68U9e@shikoro>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Apr 2022 09:18:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXWexUCJeFQwTM8X=27KoU8gyE8HGH0bTJV=VvgXfun+A@mail.gmail.com>
Message-ID: <CAMuHMdXWexUCJeFQwTM8X=27KoU8gyE8HGH0bTJV=VvgXfun+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: renesas_internal_dmac: Fix typo's
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Tue, Apr 5, 2022 at 6:51 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > > -     /* This DMAC cannot handle if buffer is not 128-bytes alignment */
> > > > +     /* This DMAC cannot handle if buffer is not 128-bytes aligned */
> > >
> > > Well, as we are here now, I think this can be further improved.
> > >
> > "The internal DMAC supports 128-bytes aligned buffers only", does this
> > sound good?
>
> I'd think it should be "128 byte aligned"? But I can't explain why, just
> a gut feeling.

I'd say "128-byte aligned".
But let the native speakers^Wwriters decide ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
