Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F9A496175
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348692AbiAUOqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:46:44 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:46001 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381267AbiAUOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:46:34 -0500
Received: by mail-ua1-f45.google.com with SMTP id x33so17203455uad.12;
        Fri, 21 Jan 2022 06:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPNVDiHsqulqgmBGZEJycEoGFhQJV8Yu49pqLyO98rY=;
        b=fwyj2pejcDFUbHBXBfflqcQJ46qNW0+Bs2fnfZJ+ouL1/4oHzPdLBpcwkU+rX7+3VR
         6BPerYVyUIQIB5DVVcxqOWis2LTRMETsb8SJU79yNxpqVL0+myfFT80+awq89P0NKS5e
         Pn698A329SlAhZcs9iDmZDj88xziuUEhLpOLMHS8Sm8+OXOfBKCh2FxbN8DZn1pc+xpx
         aDT+0NhMFgj3sQYW/CDJdnQPh5LS/HGeFMsZVKyr9SvNcOV3mQ7Lj+B8aB0J6IT9D+I9
         CxrgZNZi1qPZB62LQ5RtI3lRhbHkGu6+KqAQ9Cc5clZUgMKBqntyt4Ij355G0VUbC82J
         BRsg==
X-Gm-Message-State: AOAM530YizEvds71l88GxgWVpPTzS1MrZ4a7O3IG83+tf2EE0Swus3LM
        R75mJO+6kyFBRr6d6H57G2CHZwj6l3ydHw==
X-Google-Smtp-Source: ABdhPJxubX9Pg26oiBx7FvQ6i1UUR4Wnlh6IFb5XqAKgl1sV8N9u4p7TAPmuNAbCAy2fqAIarbG5UQ==
X-Received: by 2002:a67:a606:: with SMTP id p6mr1996248vse.23.1642776392822;
        Fri, 21 Jan 2022 06:46:32 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id z142sm1388650vkd.22.2022.01.21.06.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 06:46:32 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id j185so1984242vkc.1;
        Fri, 21 Jan 2022 06:46:32 -0800 (PST)
X-Received: by 2002:a1f:384b:: with SMTP id f72mr1796455vka.0.1642776392191;
 Fri, 21 Jan 2022 06:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220110134659.30424-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110134659.30424-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 15:46:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWxtV7Ye5jYCQ-x8Xg0-W3_UmmTqUKx6+rbX==B2dizFw@mail.gmail.com>
Message-ID: <CAMuHMdWxtV7Ye5jYCQ-x8Xg0-W3_UmmTqUKx6+rbX==B2dizFw@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] pinctrl: renesas: Kconfig: Select PINCTRL_RZG2L
 if RZ/V2L SoC is enabled
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 2:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Enable RZ/G2L pinctrl driver if RZ/V2L (R9A07G054) if
> ARCH_R9A07G054 is enabled.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v5.18.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
