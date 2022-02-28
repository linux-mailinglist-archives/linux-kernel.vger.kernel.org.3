Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF86E4C6F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiB1OXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiB1OXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:23:53 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E64192BC;
        Mon, 28 Feb 2022 06:23:14 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id i27so13070930vsr.10;
        Mon, 28 Feb 2022 06:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5mSQXselbLEuJjsTNuLw+fQoeJTjUmyz7z46v3uwMA=;
        b=e1jke7zjfyAIypZTASxQZfxKnNswSBb1N/gujfu3ZuJpPt6tq7iagkYabTzLGEjxMp
         I+VgOPIOZ7tfRXvvYAhjuEpjvnVOlMssT3GKW+n/W9cO3CnuM0HLQ1IblUhH1Osp6jlp
         wffZzBmS7GY9In/jJRHiL2kaOwkolLxpcTjcCBsWKEcqrwpAmHNV32AMIaC38pONUWnt
         BxEVr94usaqx/QK+RMwSkgCBM+z0RFxAbsHW8ceMxejIDgxXbB4Vlvck5Y5SlYwHNeUu
         r3/yDr+s8Q/g++Fg7Q+SpsnVVjgGd9G7ALF08szo+NeEs2fAUfc2khgZdX75mcuqXjVz
         rDpQ==
X-Gm-Message-State: AOAM530N0LJCTpP6tgzr08NeOqr7v26BFWzHxhSyInaSpAmOa28k7wR7
        gDEq1FW59Dnx8dC84hxoWOfH505iiA3VmA==
X-Google-Smtp-Source: ABdhPJzACp7n3YWPXW8ElHVOLXVJo7LWKTzyM0qikiTi5T/8sqaq/EzKOTs3KJdWGWfZPuT0Fy2sog==
X-Received: by 2002:a05:6102:3e95:b0:31b:524c:e311 with SMTP id m21-20020a0561023e9500b0031b524ce311mr7551873vsv.21.1646058193659;
        Mon, 28 Feb 2022 06:23:13 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id k1-20020ab07541000000b00341f0ce5666sm1817489uaq.5.2022.02.28.06.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:23:13 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id w128so5231582vkd.3;
        Mon, 28 Feb 2022 06:23:13 -0800 (PST)
X-Received: by 2002:a05:6122:8ca:b0:332:64b4:8109 with SMTP id
 10-20020a05612208ca00b0033264b48109mr8035847vkg.7.1646058192797; Mon, 28 Feb
 2022 06:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20220224125843.29733-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220224125843.29733-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220224125843.29733-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 15:23:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWyyXEXh5OTpMzj=v0xtYKWjHN1GmZ+4hUD1Z7iTb6EOg@mail.gmail.com>
Message-ID: <CAMuHMdWyyXEXh5OTpMzj=v0xtYKWjHN1GmZ+4hUD1Z7iTb6EOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: r9a07g054: Fillup the ADC stub node
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-iio@vger.kernel.org,
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

On Thu, Feb 24, 2022 at 1:59 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Fillup the ADC stub node in RZ/V2L (R9A07G054) SoC DTSI.
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
