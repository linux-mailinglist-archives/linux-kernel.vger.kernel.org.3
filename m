Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF8053388C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiEYIe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiEYIeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:34:22 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D923FD3E;
        Wed, 25 May 2022 01:34:22 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id f35so3812119qtb.11;
        Wed, 25 May 2022 01:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0kND5Wa+9pOerRMBCYU4fSimE0yKktYBrnLP5AV+p8=;
        b=edd5IEcjEmLMp0FWb140O9Q3WMsrPhze3PGb+dB/+b63CrbEX6jHl87LIzBDKEwgqL
         4nF4KoBsjYzcbXj8tb8sV6+cY8jrKxdeGMmznDmf6Cjlxr8DWkQfmnQH8sn82tBWrUaD
         mp8mGD+a8agaUvm223buneDHbfA1bMuLhNh2Vdxj1iwvPL+naPTi+PehoS/nt9qUjUGS
         A6qj0+JW+FAXixtRKbumSu3N+yEqTXgR8+nwNGFOzMCLM6iDddz2rtgCCouYDHh8ODWn
         +W0FCAbBf+0cH86Vge2kaea3HFBJmxI/OqVRaIOAHhZI1Y9rGYMmkhjUYzjAkK8skIrZ
         vZtg==
X-Gm-Message-State: AOAM5331a0CAiI7UGnOA3I7YCSlJvXTOkFeUHzQ0HK3gsCX+Oqv24TJF
        NBeJxzMiGR2m3bhv8S60fJ5dzrvx4+kShQ==
X-Google-Smtp-Source: ABdhPJzer+uBM4DHKSvvxJIUrdGlXeiXHkO4euT9g3MFoQ2+JOXJheVjysiSEaR8SaAYiXjmzN5sog==
X-Received: by 2002:ac8:5bc5:0:b0:2f9:2abd:b12e with SMTP id b5-20020ac85bc5000000b002f92abdb12emr15498818qtb.271.1653467660738;
        Wed, 25 May 2022 01:34:20 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id a4-20020ac844a4000000b002f8f406338fsm950603qto.42.2022.05.25.01.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 01:34:20 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2fee010f509so206852727b3.11;
        Wed, 25 May 2022 01:34:19 -0700 (PDT)
X-Received: by 2002:a0d:d493:0:b0:300:43da:57f0 with SMTP id
 w141-20020a0dd493000000b0030043da57f0mr4494354ywd.502.1653467659521; Wed, 25
 May 2022 01:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <b36280be-9993-9a78-0960-4094efeed1aa@linaro.org>
In-Reply-To: <b36280be-9993-9a78-0960-4094efeed1aa@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 May 2022 10:34:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWL93+r0cofwHKj1k-gUo9nk3OzUf6gtY68sK4JNibyNg@mail.gmail.com>
Message-ID: <CAMuHMdWL93+r0cofwHKj1k-gUo9nk3OzUf6gtY68sK4JNibyNg@mail.gmail.com>
Subject: Re: Getting rid of infradead.org - corrupted subjects
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     workflows@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC dwmw2

On Wed, May 25, 2022 at 10:07 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> The address list is semi-random as I don't know whom to approach.
>
> Problem: infradead.org corrupts email subjects by changing:
> s/,/, /
>
> Examples:
> 1. Previous discussion with Uwe about linux-arm-kernel:
> https://lore.kernel.org/all/20220215125856.es2euyoqo6mp4y2t@pengutronix.de/
>
> 2. My last email for MTD
> Modified email:
> https://lore.kernel.org/linux-mtd/20220408063720.12826-1-krzysztof.kozlowski@linaro.org/
> Proper email:
> https://lore.kernel.org/all/3e550deb-7c27-894b-a0b5-62609a60f17f@microchip.com/
>
> When people use Patchwork or b4, the email from the list is being used,
> thus the one with a changed subject. Example:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9547c4e74f6b4b56c2f9e4e7a286ce126fd333fa
> The subject should be "dt-bindings: mtd: jedec,spi-nor: remove unneeded
> properties" (no space after coma)
>
> This leads to real commits with a bit odd subject. At least not the
> original subject.
>
> Can we do something about infradead? Get rid of it and move the mailing
> lists to vger.kernel.org? Or fix it?
>
> Best regards,
> Krzysztof
