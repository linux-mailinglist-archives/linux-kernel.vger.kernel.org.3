Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA804C87FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiCAJds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiCAJdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:33:33 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C068CA1B3;
        Tue,  1 Mar 2022 01:32:51 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id q9so15905958vsg.2;
        Tue, 01 Mar 2022 01:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwfH+1+JkKgIxpL34p5Ilyuc9SUFRXXO2TVbV2HD9OA=;
        b=HvTNlezSHnZIQ17mwnaLQc6NNQ95bVosowlhdF3VbhMDdYNdyVjgKwgA7S5SbHlgEH
         129rj/ZyZujVZJmI0azko8uE1BYMBaKVGDMH/7+wjV9kpOsTPay4wlMqOU0UwZNDVk2q
         bYyyEwi4FZcbf43U7gh6krd8ILKAOC1qRMZofxt0QxkogQjFjUTcheqt+uvc245Wkiqh
         CzuQesm/I7MgbXgzGjtBXu9mV0k08Jvg9gS28v7i0uR85ZV/GLETKdWrybgYnlYTfxz3
         g3WNZxbaGdP2PmYuHnT/mtIoYL+d3f2fIdyVCUR1G+OFMzqVg0RDmZrfEsm3quXs9Hia
         dVkw==
X-Gm-Message-State: AOAM532whPH7Iy6tK+6CFsE91ycvirCq14WRlVYwbnGHZDWiXzlov065
        BSfn7JoKsA9rJuo0CqenepIr4nMpT5l7Kw==
X-Google-Smtp-Source: ABdhPJyk3p4e3KcRxQqnfXAjzz4HWP7RsrfyyE2zB00w8AwwvwQJgOrgMjtQ7QJDLbRToXo0ZmYtAw==
X-Received: by 2002:a67:ee0b:0:b0:31b:7ce1:e4e3 with SMTP id f11-20020a67ee0b000000b0031b7ce1e4e3mr10061242vsp.19.1646127170049;
        Tue, 01 Mar 2022 01:32:50 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id m13-20020a056122138d00b0032c5d72c395sm2130920vkp.55.2022.03.01.01.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:32:49 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id k5so7175804uao.2;
        Tue, 01 Mar 2022 01:32:49 -0800 (PST)
X-Received: by 2002:ab0:3da4:0:b0:306:a7f8:f28b with SMTP id
 l36-20020ab03da4000000b00306a7f8f28bmr10089162uac.47.1646127169083; Tue, 01
 Mar 2022 01:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220227203744.18355-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227203744.18355-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 10:32:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXq8gKGZphgNC=QA2jeLmr=M1VqQBYS0ouw2rszVeXRjw@mail.gmail.com>
Message-ID: <CAMuHMdXq8gKGZphgNC=QA2jeLmr=M1VqQBYS0ouw2rszVeXRjw@mail.gmail.com>
Subject: Re: [PATCH 08/12] arm64: dts: renesas: r9a07g054: Fillup the
 WDT{0,1,2} stub nodes
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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

On Sun, Feb 27, 2022 at 9:38 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Fillup the WDT{0,1,2} stub nodes in RZ/V2L (R9A07G054) SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
