Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42263496168
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351027AbiAUOqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:46:13 -0500
Received: from mail-vk1-f171.google.com ([209.85.221.171]:43895 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351060AbiAUOpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:45:25 -0500
Received: by mail-vk1-f171.google.com with SMTP id w206so5681703vkd.10;
        Fri, 21 Jan 2022 06:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9amB51vgOg9wG6zd+Vn5CfbKLBlfH1ZXSkeVyjjDxo=;
        b=SCkA+Metp1dH+TkP9GZBz+YL+1tgZ/pN+Sox4G/Kq6mILU84u7uJz6/s5bJ0gTWH6d
         +v3SffOQikE76wBjcO6KYSw0e5MkVMBNLUmzYvDE8A6ZOuVmmWjphUVAPwvVJDF/z+WJ
         cMtD3SYJwCSjUorbEl2AQxZtQBDxsj0/u1eKKpt2KxYVLE4Y2GxUB4e9+nEHgbXQREWL
         a766LYy1u66QBmwIlwKZKEb3J3ve8PvIokY2FAGMysI0rzs9Y2+8Vpas6CFE7MYxWu8K
         AjAqYWyNQsS0qP7ss5GkFfkemyWLParOEX/H4dQHdxVktQfIKpCTDKvmwDzE8U1iabqR
         IPHw==
X-Gm-Message-State: AOAM533F0ugIgvDv3EPdcw7S4Aaa1XkhTzQJnDo9wmJqSFdlns2/Kug8
        lLhg0YADbg0egRHm06DW6W0hMoX3JE2/iw==
X-Google-Smtp-Source: ABdhPJyWEnvzjigW/4JoYtecj0g/mZN2zsgQ1gxa+F0wk2cA0zdeE3BKQIWGf/AgYWA8UbMptrmpcw==
X-Received: by 2002:a05:6122:920:: with SMTP id j32mr1697681vka.41.1642776324770;
        Fri, 21 Jan 2022 06:45:24 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id m7sm1571058uam.0.2022.01.21.06.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 06:45:24 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id 2so17268170uax.10;
        Fri, 21 Jan 2022 06:45:24 -0800 (PST)
X-Received: by 2002:a67:e985:: with SMTP id b5mr1504560vso.77.1642776324170;
 Fri, 21 Jan 2022 06:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220110134659.30424-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110134659.30424-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 15:45:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX7f_iWZvkQ5OLjcJR5n7NJPaLT3pyr8DVYjbqf_7xbPw@mail.gmail.com>
Message-ID: <CAMuHMdX7f_iWZvkQ5OLjcJR5n7NJPaLT3pyr8DVYjbqf_7xbPw@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] dt-bindings: clock: renesas: Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
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
> Document the device tree binding for the Renesas RZ/V2L SoC.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v5.18.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
