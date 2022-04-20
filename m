Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45282508555
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377425AbiDTKBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377401AbiDTKBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:01:13 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE593C71E;
        Wed, 20 Apr 2022 02:58:26 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id ay11so585210qtb.4;
        Wed, 20 Apr 2022 02:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wU49MG03D+M8OtsmGdiD3cYVYIgAsNZvGgteteaKNo=;
        b=C17CqwmJ+XIF9t1S7bnqE6u/WJIe3/MHQrYaTcD4PEm9fJMvwU3UIe0zJPfuBTb0y1
         VfT9rFMqTovbV4SQuNL2TGLP9FehYlo7R0djscGML0Z6Sgz4+oWXFj3iHIC/dsZD9yFZ
         xYefk4l+6/ixru2c/IDkdGadz5danbHSUckyZNXRJ4PQkM1YLiHl8ccja0LJFvEcTaJo
         o70ExLO2dyjs9Atcenaqs1AGxmZ36VFBOC9yvwKaBtVqgBygaFFTEVxGzL6JwNddK409
         lrUtUf6RBQsZ9KRc1N08r8q738djv+6v1F/XaM5IKPuZtu5X8oFFYivdQGSDK6eWDRgW
         sBIQ==
X-Gm-Message-State: AOAM533Ige2T5yHFGEk1AKveEpN0teN7eGbdF/OMx1ofBTyAmY8784Vy
        zUMvHOsMqb43aLea0YWX95SYMx6p5kL1+Q==
X-Google-Smtp-Source: ABdhPJwJW1gR/1/6QSs/qljEsGdCUYw2OPItozBWu1poMjIGVMnBwPXIj3RvEIFh7qFETYsfDGa6rQ==
X-Received: by 2002:a05:622a:1211:b0:2f2:167:55dc with SMTP id y17-20020a05622a121100b002f2016755dcmr8194727qtx.105.1650448705917;
        Wed, 20 Apr 2022 02:58:25 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a258400b0067d47fb5aa4sm1280578qko.63.2022.04.20.02.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 02:58:25 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id p65so1882740ybp.9;
        Wed, 20 Apr 2022 02:58:25 -0700 (PDT)
X-Received: by 2002:a25:9e89:0:b0:63c:ad37:a5de with SMTP id
 p9-20020a259e89000000b0063cad37a5demr19016820ybq.342.1650448705364; Wed, 20
 Apr 2022 02:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220420145517.445e41b1@canb.auug.org.au>
In-Reply-To: <20220420145517.445e41b1@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Apr 2022 11:58:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW2ve9WHRO=ghNvu5z8hpFHd-14zMTPvWFsrAbkvD5b3w@mail.gmail.com>
Message-ID: <CAMuHMdW2ve9WHRO=ghNvu5z8hpFHd-14zMTPvWFsrAbkvD5b3w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pinctrl-renesas tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Apr 20, 2022 at 6:55 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> After merging the pinctrl-renesas tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> In file included from include/asm-generic/bug.h:22,
>                  from arch/x86/include/asm/bug.h:87,
>                  from include/linux/bug.h:5,
>                  from include/linux/io.h:11,
>                  from drivers/pinctrl/renesas/core.c:16:
> drivers/pinctrl/renesas/core.c: In function 'sh_pfc_check_info':
> include/linux/kern_levels.h:5:25: error: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Werror=format=]

> Caused by commit
>
>   be1a0d45cdd5 ("pinctrl: renesas: checker: Rework drive and bias pin iteration")

Thanks  for the report!
I have fixed the offending commit.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
