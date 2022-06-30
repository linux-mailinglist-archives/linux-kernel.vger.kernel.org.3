Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818DF561643
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiF3JZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiF3JZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:25:17 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04023A71C;
        Thu, 30 Jun 2022 02:25:16 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id b125so13908923qkg.11;
        Thu, 30 Jun 2022 02:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24CMEFCHWbIRhmYUqpqkC6kLf9aI1+ezMoPxKMAQOcI=;
        b=jFRXSa75d0zEeKwjwWGD1OrDUceTJJ/FgqNOhaGBT6JP8kE6ngIYNGmlYcZHLia8AC
         PZmrwG3xSWDyeiF7JcopSBFeY24RwsIAWmhQOQCnZv3M2s/PFhiQPpEgaN8S7+lMTpir
         LvtE7EdzpqTFhDz1GcHRyzd/KwiAkDVw/z5928i6LSOi21k7uI3/d4rtE7uchq+PPnsv
         56Kktn7jVbmwAmZgPQnh6jaipRiPQbRe4dgX0zTSzWuLJ7foFC76KLXvq9N36cClavUa
         DCIdsgJpi46TG7Amc3WJRQAcDZH0zxWrh+H6nBAuzfTIgdQjEHBTy/GNEnf+uKKT0xHX
         S3nQ==
X-Gm-Message-State: AJIora8Jp9I/sbGt2w6t6ncSXN1BANmRHp5/7KiSaQRqWDouWcNuYFvA
        hKlzPNwCPwOBCIOQRgz9j+Oib/owCYfAug==
X-Google-Smtp-Source: AGRyM1vokc57zFo9ipAcAkPXJhSncE7N62Y6Zngrak6WmiVFgVZESiU5Tfap7pTOWk5+gprSxMLcfw==
X-Received: by 2002:a37:bb06:0:b0:6af:1396:733a with SMTP id l6-20020a37bb06000000b006af1396733amr5415781qkf.19.1656581115510;
        Thu, 30 Jun 2022 02:25:15 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id bk32-20020a05620a1a2000b006af1d3e8080sm11009475qkb.85.2022.06.30.02.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 02:25:15 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31772f8495fso172895027b3.4;
        Thu, 30 Jun 2022 02:25:14 -0700 (PDT)
X-Received: by 2002:a81:574c:0:b0:317:7c3a:45be with SMTP id
 l73-20020a81574c000000b003177c3a45bemr9028878ywb.316.1656581114644; Thu, 30
 Jun 2022 02:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220630151511.58281e52@canb.auug.org.au>
In-Reply-To: <20220630151511.58281e52@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jun 2022 11:25:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVD0XZg5grY251D4tqxmJ6bH4MWK2s_4+yLRBdUzPBLTg@mail.gmail.com>
Message-ID: <CAMuHMdVD0XZg5grY251D4tqxmJ6bH4MWK2s_4+yLRBdUzPBLTg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pinctrl-renesas tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

Hi Stephen,

On Thu, Jun 30, 2022 at 7:15 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> After merging the pinctrl-renesas tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/pinctrl/renesas/pinctrl-rzv2m.c: In function 'rzv2m_dt_subnode_to_map':
> drivers/pinctrl/renesas/pinctrl-rzv2m.c:37:33: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
>    37 | #define MUX_FUNC(pinconf)       FIELD_GET(MUX_FUNC_MASK, (pinconf))
>       |                                 ^~~~~~~~~
> drivers/pinctrl/renesas/pinctrl-rzv2m.c:306:31: note: in expansion of macro 'MUX_FUNC'
>   306 |                 psel_val[i] = MUX_FUNC(value);
>       |                               ^~~~~~~~
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>   1e18476c392f ("pinctrl: renesas: Add RZ/V2M pin and gpio controller driver")
>
> I have used the pinctrl-renesas tree from next-20220629 for today.

Thanks for the report.  This was missing an include of <linux/bitfield.h>,
which is included implicitly on arm64.

Fixed and updated.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
