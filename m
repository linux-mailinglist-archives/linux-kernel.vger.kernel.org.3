Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D975A4D1304
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbiCHJF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345198AbiCHJFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:05:20 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C47C3CA53;
        Tue,  8 Mar 2022 01:04:24 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id v189so5286088qkd.2;
        Tue, 08 Mar 2022 01:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phYHKaDp3iu7d/YQ5n28M+fKfbNGfwGCdmxQu5jfrxQ=;
        b=bFBktnL+3vRZCIqa5W8rfV+DMd85Urm37liXIlaO5gwdL1ko6F40MSjAIphH1fZ6Uo
         Q96vUvy24MrqxdZebsjlx4+2YR7qs3bRb5vt1i7FeBYvGxKtoTcII0iJJIIQzcKtBzDX
         ZscthDETRBL0EdI0c7gQ//P3WL5XDNuRMksWBy8ZyXiWLMkzOrjDVk4JZT2biK9srI6U
         SBjBl+oLlZlIin79A7E+aQ/dr2rtl8QEwndzao8k+3nckGsHR/+hNvgsMk6DPzFywu3N
         wjqU+7UI4+w21SAhmY48kDA5/phl5PQLWGt1/K4KRiut8Y3zUB59oa3rDRD03kQMCxjW
         IhFA==
X-Gm-Message-State: AOAM532pFkmRGFBD+jPdYImvw7z+LkD+5IPoyqXZVUkVvz/gJJtpV8o5
        QJrWfmPIGL7TbDQWhnft5wyzGIc3zSJoow==
X-Google-Smtp-Source: ABdhPJzJLVgkJDbJXbQ+FMgzII9DfrzotprkYS06w0GZMSDhl9N1H/S9M6llGCLgqI1AJ4fys/RLcg==
X-Received: by 2002:a37:45d4:0:b0:47e:c694:2370 with SMTP id s203-20020a3745d4000000b0047ec6942370mr9482859qka.773.1646730263358;
        Tue, 08 Mar 2022 01:04:23 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id c11-20020a05622a024b00b002ddb43850fdsm9905983qtx.15.2022.03.08.01.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 01:04:23 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2d6d0cb5da4so193474957b3.10;
        Tue, 08 Mar 2022 01:04:22 -0800 (PST)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr11937869ywb.132.1646730262599; Tue, 08
 Mar 2022 01:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20220308085136.30753-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220308085136.30753-1-lukas.bulwahn@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Mar 2022 10:04:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXPtgSRwwXyKwROkuKY3m8YY-bOfvobB58X55Hm8B3qfw@mail.gmail.com>
Message-ID: <CAMuHMdXPtgSRwwXyKwROkuKY3m8YY-bOfvobB58X55Hm8B3qfw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: rectify entry for ROHM MULTIFUNCTION
 BD9571MWV-M PMIC DEVICE DRIVERS
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Lukas,

On Tue, Mar 8, 2022 at 9:51 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> Commit 983b62975e90 ("dt-bindings: mfd: bd9571mwv: Convert to json-schema")
> converts bd9571mwv.txt to rohm,bd9571mwv.yaml, but missed to adjust its
> reference in MAINTAINERS.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
>
> Repair this file reference in ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE
> DRIVERS.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks, my bad.
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
