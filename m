Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A12555B0DA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiFZJOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiFZJOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:14:50 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D353E56;
        Sun, 26 Jun 2022 02:14:48 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id b125so5005973qkg.11;
        Sun, 26 Jun 2022 02:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbPraZXafoS9hoTYKTZ34AOWnSsSx8JmOQi+FZJXy5o=;
        b=7805PzomCq7irGRYCGTH0DbQJ7yVnuoNMTEcvXHbvQcGWoZQbVN7fEKsPhmNnyMZxp
         JBX2c9pZGuNfZreubKg3tyCOvTMdNEbI+YrEs/wIupOnyvtzsghOgU9m8akp8nx5hoWW
         RtVf8ylVQgnAM1ntSN/UgnGE3+syYLc//IH/UaBhxMigqvRiC13cPhRIDNcw319NiPk8
         Zi27fjzItyr/cjLVSWugL9W3wGCc0YE+vrWbZ+1NUTA0znl0azeasXiasf2vakxLqL4Z
         gKx4wUO0ZL5qHt4MtMfLz1pL5Lsk43LCt0J7hbcobtsxK69w6re2hdrX9FNfjUcwH0p6
         3MSQ==
X-Gm-Message-State: AJIora/FgzCs1SPssKC5mivdIXrbUzzBV9/PV9LPBFqKq1/VW3xURnJ8
        H1n2W02k6DjHsIq/mpz+tSVVnHsvjsUMxA==
X-Google-Smtp-Source: AGRyM1uD91pSXgG6pa19BRUmEZPCsvKJEdw3NaYit4C9PLiRW6MyvdMCHwpONNxrPkT+Fz7sA1wxsQ==
X-Received: by 2002:a05:620a:4712:b0:6a7:304f:89c2 with SMTP id bs18-20020a05620a471200b006a7304f89c2mr4950769qkb.46.1656234887485;
        Sun, 26 Jun 2022 02:14:47 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id g18-20020a37e212000000b006a691904891sm5620392qki.16.2022.06.26.02.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 02:14:47 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id i7so11812211ybe.11;
        Sun, 26 Jun 2022 02:14:47 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr7820984ybu.604.1656234886883; Sun, 26
 Jun 2022 02:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656234456.git.mchehab@kernel.org> <d6e3482ed622b6953db69cddb70f20c55c96e4da.1656234456.git.mchehab@kernel.org>
In-Reply-To: <d6e3482ed622b6953db69cddb70f20c55c96e4da.1656234456.git.mchehab@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 26 Jun 2022 11:14:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXu_v28veaFva_VSKMKWjCYSosSr6pGpj5W3kj-MXfzsg@mail.gmail.com>
Message-ID: <CAMuHMdXu_v28veaFva_VSKMKWjCYSosSr6pGpj5W3kj-MXfzsg@mail.gmail.com>
Subject: Re: [PATCH v2 16/20] arch: m68k: q40: README: drop references to IDE driver
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Finn Thain <fthain@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
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

On Sun, Jun 26, 2022 at 11:11 AM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
> Since IDE support was deleted by Christoph Hellwig <hch@lst.de>,
> Jun 16 2021, drop the left-over from README file, updating the
> documentation to point to ata/pata_falcon.c.
>
> Fixes: 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver with pata_falcon and falconide")
> Fixes: b7fb14d3ac63 ("ide: remove the legacy ide driver")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
