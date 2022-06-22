Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AD5555309
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377190AbiFVSLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358337AbiFVSLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:11:53 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C7B3B00C;
        Wed, 22 Jun 2022 11:11:52 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id b133so1328663qkc.6;
        Wed, 22 Jun 2022 11:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhD0MOrYe6T8ixwnqaaVek/KZReGo+sSJrdYPS9fFGA=;
        b=zxc+UPeSoLSAg4zD0EnKH3Q6Fagnad1rSDF3x7BM1JnAd0BFaHJRz9XPetmBeFimxX
         6qipss9+6jVKfNro0jy/WKuF7O/XgQkDlVWPXasoey9BjlGoLvuNZrLZHd0Nhg8ozD33
         wmW4B8tSNrs1fxWzBZPt8bE1oBoQIzFtJDHkW3jeqMq+k0uYZg7OxC1WFcwi7ftd8K3K
         uzaJ2M6Ffr3PL0z6gkaa07kh4BiEsmF1dZW3HdSJ1i5OFi2I3GA53ObaHBss0nrncKVA
         ETHJAelTUOwcH6kZUxMMv7oErA9Ej0gwpJpYeTEPLvLOs8+DzkZO/XjVi0vlkySVUNhF
         WOew==
X-Gm-Message-State: AJIora+TN7c5ihpVpKhbIOml+SU3llQljahaNjdWNNpEt7vZ3Rtd+A2J
        L8odygPdPrNZjC4zfvkF9gYhQOcS62kP3g==
X-Google-Smtp-Source: AGRyM1vauPaQThk1rkTaI9N6Ov2YYKy7VCkXnDIx4Z/ZNPqxduL+MHYw8Mks7ZKrDn9IXUz2j1acyg==
X-Received: by 2002:a05:620a:1aa5:b0:6a6:c208:fb94 with SMTP id bl37-20020a05620a1aa500b006a6c208fb94mr3408626qkb.434.1655921510648;
        Wed, 22 Jun 2022 11:11:50 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id bx4-20020a05622a090400b002f3e2435ee2sm14869070qtb.63.2022.06.22.11.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 11:11:50 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-317710edb9dso171295337b3.0;
        Wed, 22 Jun 2022 11:11:49 -0700 (PDT)
X-Received: by 2002:a81:574c:0:b0:317:7c3a:45be with SMTP id
 l73-20020a81574c000000b003177c3a45bemr5877104ywb.316.1655921509513; Wed, 22
 Jun 2022 11:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173614.12778-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220622173614.12778-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220622173614.12778-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Jun 2022 20:11:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWbQ1VHH4ugQs2mamS2KGEj5AdWmNtmg=6eUJmyGRDTVw@mail.gmail.com>
Message-ID: <CAMuHMdWbQ1VHH4ugQs2mamS2KGEj5AdWmNtmg=6eUJmyGRDTVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: renesas_sdhi: Fix typo's
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
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

Hi Prabhakar,

On Wed, Jun 22, 2022 at 7:36 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Fix typo's,
> * difference -> different
> * alignment -> aligned
>
> While at it replaced 128-bytes -> 128 byte.
>
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -355,7 +355,7 @@ renesas_sdhi_internal_dmac_map(struct tmio_mmc_host *host,
>
>         data->host_cookie = cookie;
>
> -       /* This DMAC cannot handle if buffer is not 128-bytes alignment */
> +       /* This DMAC cannot handle if buffer is not 128 byte aligned */

128-byte? ;-)

>         if (!IS_ALIGNED(sg_dma_address(data->sg), 128)) {
>                 renesas_sdhi_internal_dmac_unmap(host, data, cookie);
>                 return false;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
