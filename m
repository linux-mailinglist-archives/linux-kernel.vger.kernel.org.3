Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990CC4C6F81
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiB1ObA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiB1Oa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:30:58 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16877EB2E;
        Mon, 28 Feb 2022 06:30:19 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id e5so13100702vsg.12;
        Mon, 28 Feb 2022 06:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLDg9b1GHF+fe9nzYW7P+voNdzuk8gxLdevvVVqMTeA=;
        b=F9bUwdb9FGS8VzXIaDrcOoT1f5PnlnW+a6o/5esAAwoPIvw1eHupFMjcB6vvitODnU
         L2RK3K63T0JtwTDurEHzSyXmun310qjeKK6qomiAHnE1BmRJwNyLiRxXlx12e5XkHTPZ
         ZJEzpO6GWkODH1HlxJua2n2SLypOZjnqZoVxdg0/IaJkZHYCWVGfFThLZi9ZMkmnEE96
         1kQbKfC0iOqJ2VbCKJMw/GZwbZ4wj2Zg2EfmY8gd1jK1+bImmm902VR/QG4RmSsU1und
         kaWoh6Gbs3KwvI9ukeBtdcy0zpI2VeUrfnEyiRHQejgAZwgR6scLxXukFsFIelXRHb8P
         aFGA==
X-Gm-Message-State: AOAM530xq7pQfIXE5XlQCZu4ZWvBb/c0UkSfbvS/VP55s6ETIfDek5tF
        lWuJV81l2FrIdklg61XPiXS6s8H6qQNy7A==
X-Google-Smtp-Source: ABdhPJybWC/1NAsc24SK88u8C3rWhPmobnnbH2FLr9u1MmV06w/LWEB2rGyGZiJxyRk5XMcyA5X1WQ==
X-Received: by 2002:a05:6102:14a8:b0:31c:1cd1:be56 with SMTP id d40-20020a05610214a800b0031c1cd1be56mr8020334vsv.7.1646058618810;
        Mon, 28 Feb 2022 06:30:18 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id y5-20020a1f4b05000000b003314159259bsm1690241vka.3.2022.02.28.06.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:30:18 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id d11so13147694vsm.5;
        Mon, 28 Feb 2022 06:30:18 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr7624667vsl.68.1646058618146; Mon, 28 Feb
 2022 06:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20220227215308.26135-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227215308.26135-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 15:30:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXaPc0bPE1Rf33hHg7c3Mq0UfYAqFcc+_q-NLG2y8WcYQ@mail.gmail.com>
Message-ID: <CAMuHMdXaPc0bPE1Rf33hHg7c3Mq0UfYAqFcc+_q-NLG2y8WcYQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
> ---
> DTSI changes have been posted as part of series [0].
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> patch/20220227203744.18355-7-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  .../devicetree/bindings/memory-controllers/renesas,rpc-if.yaml   | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> index 294f1036420d..f051ffb2a421 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> @@ -40,6 +40,7 @@ properties:
>        - items:
>            - enum:
>                - renesas,r9a07g044-rpc-if      # RZ/G2{L,LC}
> +              - renesas,r9a07g054-rpc-if      # RZ/V2L
>            - const: renesas,rzg2l-rpc-if       # RZ/G2L family

Please drop the comment on the previous line.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
