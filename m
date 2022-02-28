Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D4D4C6F72
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiB1O3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiB1O3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:29:05 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8A21EAF3;
        Mon, 28 Feb 2022 06:28:26 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id g21so13128262vsp.6;
        Mon, 28 Feb 2022 06:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZ6qZoqKg/a9hxQ5kCVFAIHRQEXqX2mM/Si50qd6+Ek=;
        b=rO3WjKMJq8636QH2m8snV0UKH2Cwgxwuy6SAQjE+Y5dCxe8hZ18UY+RT561imNXxEv
         GkokUVW7Uq5PKiJutf5/w1jmg7RPsQ/M3U9FYKXUVAICDH5Rlof8pQjPG7TpTPPApKfk
         j0Tz5alhtF8+vN2kaNNf/fDkSnI6Bw9PujciDPZf3D9k9Q77qCf+3Iq64tWWIjh6AHw2
         6r7vApZo0787hLTm7xZi2zo3yxMxBx8XEWdb3jSVngP4BAgluf+OrXMuSKd4pDMSiCis
         DMIQMUh/HpyEvC/tr5xhQuJfQudNfZw2bEJYZax3KHlgWDQdlG13HK9J9cNzdxlyYph1
         iAQA==
X-Gm-Message-State: AOAM530v7Z/lUtJL7Ihhiq4wjXSA/wKVMZEK1O8qG+A00U6l1eCXarcI
        hcATIxGDHecbJ6kf9dY/ZsqN4rFIYHUajw==
X-Google-Smtp-Source: ABdhPJxQYX9NkDE3XxApsSchIcS9CUmUIGM2a49IHKTTbAURKLIzDwVQDKWVpwRyucnRLGHwY3gWTQ==
X-Received: by 2002:a67:cc14:0:b0:300:24fa:bf44 with SMTP id q20-20020a67cc14000000b0030024fabf44mr7755623vsl.20.1646058505779;
        Mon, 28 Feb 2022 06:28:25 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id f13-20020a67ea8d000000b0031c01ea6d05sm1358728vso.33.2022.02.28.06.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:28:25 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id j5so5219342vkc.12;
        Mon, 28 Feb 2022 06:28:25 -0800 (PST)
X-Received: by 2002:a05:6122:114e:b0:32d:4662:65a8 with SMTP id
 p14-20020a056122114e00b0032d466265a8mr7744721vko.0.1646058505049; Mon, 28 Feb
 2022 06:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20220227215308.26135-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227215308.26135-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 15:28:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXYKe2e0RR2rscFQ-GUgLkX0DoNRMLJJ90_5j6Az8znzA@mail.gmail.com>
Message-ID: <CAMuHMdXYKe2e0RR2rscFQ-GUgLkX0DoNRMLJJ90_5j6Az8znzA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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

On Sun, Feb 27, 2022 at 10:53 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/V2L RPC-IF bindings. RZ/V2L RPC-IF is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-rpc-if" will be used as a fallback.
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
