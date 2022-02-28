Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67854C6FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiB1On6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiB1On5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:43:57 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB6F275CE;
        Mon, 28 Feb 2022 06:43:18 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id w4so13216446vsq.1;
        Mon, 28 Feb 2022 06:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ns+Arg4klDnlGygzEk76LpslXMQxYcezrQQdYtWZQRM=;
        b=Az6a6ZZMru/1c4jIsr8cqU6QUs1OEHKHuC0MSNMgBLCLBhKbWBFW4aE9Mf02OHX9EY
         56C4WFsPZT5Gpnkx3XSLAf6VVOWNfCQmGD8XNuA2Hr1crbqHr6FoUHowhMs5jR7W5tPN
         zZ26HFNhGpQkgHP6Rao8WEM3Qc6iAcEA4S9WHqtubLXejrL79/sCPCsMS6SE6xrGELTR
         Jng/N7hg6AncVZZGOLuyt4HvJNMiwPGGWgwJ0pFwsfP7PsqBf3IbIk+JOAgXZheTI/vF
         37Q/ol+IC7zbi0SfB6u8SgBoTTvBkE+Wn/b09MAiaku8ckXnBnd1BzCdSbGCAIjUCKC4
         CjCQ==
X-Gm-Message-State: AOAM532P0eaac71Tg3jck8dxizXS8bkI4nStYXFj20RiWlgvwCrtFbzu
        EiKiC8wGzMMIaUFbXiRvEp6Ks593JVBfjA==
X-Google-Smtp-Source: ABdhPJxl52M6ZZgpP5yjBITdm43oaD1BGSuWXEGpgKo6MbTulYbr3mBtKg3xCFjSV++zHuj3t+JmQA==
X-Received: by 2002:a05:6102:3a12:b0:31e:6646:b3d1 with SMTP id b18-20020a0561023a1200b0031e6646b3d1mr5199619vsu.51.1646059397136;
        Mon, 28 Feb 2022 06:43:17 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id t123-20020a1f4681000000b00333ad3ec70dsm106433vka.42.2022.02.28.06.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:43:16 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id w4so13216383vsq.1;
        Mon, 28 Feb 2022 06:43:16 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr7651662vsl.68.1646059396569; Mon, 28 Feb
 2022 06:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20220227224845.27348-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227224845.27348-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 15:43:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV+AFpiYwgPN6F1=nx6ivFAU3YYtM1xu4jwyKZh+VNQHQ@mail.gmail.com>
Message-ID: <CAMuHMdV+AFpiYwgPN6F1=nx6ivFAU3YYtM1xu4jwyKZh+VNQHQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: renesas: ostm: Document Renesas
 RZ/V2L OSTM
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Sun, Feb 27, 2022 at 11:49 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document the General Timer Module(a.k.a OSTM) found on the RZ/V2L SoC.
> OSTM module is identical to one found RZ/G2L SoC. No driver changes are
> required as generic compatible string "renesas,ostm" will be used as a
> fallback.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
