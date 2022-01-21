Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B41D496171
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381361AbiAUOqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:46:31 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:35441 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381281AbiAUOq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:46:29 -0500
Received: by mail-vk1-f173.google.com with SMTP id 19so5689472vkl.2;
        Fri, 21 Jan 2022 06:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4RYqC5zNnBU9vYEWQLodfuGNNVQBquLeHO9JO8gJtQ=;
        b=codyk/qqwB3CVYeMZge5XVqAZCmFH0cO6jeThbHq5lP5A/5Lr3HcvYAcFPP86F/6T7
         YrKqBq/MS+JhXX1TPLxrMpL/LgxJo85tLoh4Kgs2Qyk6NPocv2+sX2/Gz7+Q+syZeYlR
         kvWLaM7ZtEAVA7qsQe47ko3WJk7skS2MCHLIlkR6gb0Kt/YQpT6S40RbQhYXDHO89fqv
         c2ucWkHt/UbbB5x2dkaHWp6kdCe/f36cnZi+ZlDHn3TyC7d9r+4XRHX7tpXoRGZ82GO0
         OBf86suaq3fR7C2jc47Blb1FCGqOFo/NQe+k/kMdXAbVMzm3phgF7K5/6BlY1zEiURHL
         6+Kw==
X-Gm-Message-State: AOAM533yeXKeBony9wBwTMobKxmgs1aC2hVv7MmvztXm9oLh7M6GNS+K
        OBgWjG/SDHF0pPiWC+djgERVCMXNhkXniQ==
X-Google-Smtp-Source: ABdhPJyd+jyk37iW14CZb6fGwv9+I959o49gha/0xTr7ZvZg6sBKzsx9hEosjo22VmYHvHYm+jGRVA==
X-Received: by 2002:a1f:b241:: with SMTP id b62mr1798319vkf.1.1642776388116;
        Fri, 21 Jan 2022 06:46:28 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id o188sm1229453vsd.6.2022.01.21.06.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 06:46:27 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id u6so17378944uaq.0;
        Fri, 21 Jan 2022 06:46:27 -0800 (PST)
X-Received: by 2002:a05:6102:3581:: with SMTP id h1mr1769044vsu.5.1642776387295;
 Fri, 21 Jan 2022 06:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220110134659.30424-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110134659.30424-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 15:46:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW8GOuX6pUHKd4BCYmiN3t1OX5UD3Txg5i36ONAqOoakg@mail.gmail.com>
Message-ID: <CAMuHMdW8GOuX6pUHKd4BCYmiN3t1OX5UD3Txg5i36ONAqOoakg@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] dt-bindings: pinctrl: renesas: Document RZ/V2L pinctrl
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 2:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Document Renesas RZ/V2L pinctrl bindings. The RZ/V2L is package- and
> pin-compatible with the RZ/G2L. No driver changes are required as RZ/G2L
> compatible string "renesas,r9a07g044-pinctrl" will be used as a fallback.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v5.18.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
