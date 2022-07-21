Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E6A57CB93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbiGUNMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiGUNMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:12:51 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A4102E;
        Thu, 21 Jul 2022 06:12:50 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id b25so1198079qka.11;
        Thu, 21 Jul 2022 06:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVUevjNodf6wrQgVDSJxGIz5dN3UN5DudZrKST6CPDA=;
        b=EHDH7EOc9YmLo4PPNy7q33XJYpLczTUXlkWWKmlXWCSbfcunZ7jhLo46154Nhi1f1S
         wfAjF3AJQzZzVjFVN8nF+hX2Iq/bwGhcXfkccNC6xXt9u8gcFGj//EB13L6xkYeE/mVy
         AfJZMVfKOxgc/9Z0/rh5CEK8XOfePZjYREPG6JnFqU7py9I2QGdAzo5q2wPLmIF2/2eM
         FsUPYpNRUfV+elwgQ04RYlr78nwLenTsQQ7aFSWLnE2WxoPFgUZETEPIJW6wUteueBtF
         OFket5nRasPu7IYXFk7/zIcL0W8OzPQF2L07MGtezj9DMHZhBfizxmhIklFOpHWScqGA
         jY9g==
X-Gm-Message-State: AJIora9891el3hOgxPdhd0JvSZVCOGvYzXfORrLHdgJcI+WIVtmdno0j
        MNOW4gE5SaAAlSCrRqVLrcHe3mZSXu6GSg==
X-Google-Smtp-Source: AGRyM1ujv9raNrM23h6wSVy+NucAlX/m4eccSIAEgP3oxatjaF9pQvuMG+7BzIneI+Uy56LCkYeF/Q==
X-Received: by 2002:a05:620a:c55:b0:6a7:9e01:95c9 with SMTP id u21-20020a05620a0c5500b006a79e0195c9mr28418629qki.63.1658409169952;
        Thu, 21 Jul 2022 06:12:49 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id r6-20020a05620a298600b006a75a0ffc97sm1441905qkp.3.2022.07.21.06.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 06:12:49 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 6so2669847ybc.8;
        Thu, 21 Jul 2022 06:12:49 -0700 (PDT)
X-Received: by 2002:a25:bc8e:0:b0:66e:fe43:645c with SMTP id
 e14-20020a25bc8e000000b0066efe43645cmr41468394ybk.202.1658409169410; Thu, 21
 Jul 2022 06:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220718192824.7246-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220718192824.7246-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 15:12:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWvr4XsZO8U+HJ35ANQ+9Kuut92MeAN-f+XW2bi-NOGpA@mail.gmail.com>
Message-ID: <CAMuHMdWvr4XsZO8U+HJ35ANQ+9Kuut92MeAN-f+XW2bi-NOGpA@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: Kconfig: Enable IRQC driver for RZ/G2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Mon, Jul 18, 2022 at 9:28 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Select RENESAS_RZG2L_IRQC config option if ARCH_RZG2L is enabled
> so that IRQC driver is enabled on RZ/G2L (and alike) SoC's.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.21.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
