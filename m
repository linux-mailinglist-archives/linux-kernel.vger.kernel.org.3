Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5E14BF33F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiBVINW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiBVINU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:13:20 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3A6149960;
        Tue, 22 Feb 2022 00:12:56 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id j9so9956426vkj.1;
        Tue, 22 Feb 2022 00:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXhjrXQXAlA3S3+bOZSFWOBDZGrR5ez8yT5D070EooI=;
        b=q4ojHdR6rT+bxRHLecxj2lMr4WHr8GTUXUdGrGAwQM2+JvFJuNv/YxVYIa4sQKanQ3
         XGwDFtJeYsCMuwmwVUatqJ3ducR4jbkVl1IRnNDXfifxihHC8SYPR0nBtsD8w11hToWF
         ros5jbR2G3+Z0x2x8aWvX6BsacsmfOISJxvsVjUivXKDhxi5/1F++bA7HF2RBBudv5wK
         Pc2svnarm5JrUVdnKvZAUnOfnxHhw9Fi345OJYgBlcwmSN2XXC4nzP1WUQKDRucm0Mw8
         c8AQN4V8rW/v25M3EE3qg0GT0QDkspNmY6w9xm7urFvSyC9RK+MBava+6hy1639jGApa
         xH6A==
X-Gm-Message-State: AOAM53064zH5qKBUi7JcgQgNLZrVtR23rCL3D45UQvGSuRURncKexfMy
        af56DR3qTk97FhX0CyHrXoFAKpImQDiJuA==
X-Google-Smtp-Source: ABdhPJyeJFjlA/8Zk3RYIoLOBi91E2pfzyisn4VGc/46GG4Cydr7jbyBvqPe4rmMpehYLvAw4qiVyw==
X-Received: by 2002:a05:6122:635:b0:32d:1046:307f with SMTP id g21-20020a056122063500b0032d1046307fmr9885450vkp.0.1645517575220;
        Tue, 22 Feb 2022 00:12:55 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id n131sm3728475vkc.11.2022.02.22.00.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 00:12:55 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id b37so9176499uad.12;
        Tue, 22 Feb 2022 00:12:54 -0800 (PST)
X-Received: by 2002:ab0:6253:0:b0:341:8be9:7a1 with SMTP id
 p19-20020ab06253000000b003418be907a1mr7330603uao.114.1645517574714; Tue, 22
 Feb 2022 00:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20220221222450.5393-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220221222450.5393-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Feb 2022 09:12:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVb38_nhxVqUdtedyP0wMWmgkC-4K+OgbY0bOO8Hw4w4Q@mail.gmail.com>
Message-ID: <CAMuHMdVb38_nhxVqUdtedyP0wMWmgkC-4K+OgbY0bOO8Hw4w4Q@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: Kconfig: Explicitly select PM and
 PM_GENERIC_DOMAINS configs
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
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

On Mon, Feb 21, 2022 at 11:25 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Explicitly select PM and PM_GENERIC_DOMAINS configs for ARCH_R9A07G044
> and ARCH_R9A07G045 configs. PM and PM_GENERIC_DOMAINS configs are
> required for RZ/{G2L,V2L} SoC without these configs the SMARC EVK's
> won't boot.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
