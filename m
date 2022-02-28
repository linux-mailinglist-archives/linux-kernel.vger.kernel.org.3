Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABC84C6FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbiB1OtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbiB1OtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:49:07 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19DF2C119;
        Mon, 28 Feb 2022 06:48:26 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id u10so13168125vsu.13;
        Mon, 28 Feb 2022 06:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJ23gsehcCRJL2hoURWULkun0rl03C0V1Ey0lXOHbSY=;
        b=i3NG4tfvV/iC07EH6ziOJ6zfvvgCXGc02zCj31nd6pEZSu9XGilc4VXTB5+NhmTGp7
         AYStCorhM1DIYiT2VjRgUwckcmw1bi1i4nVaJuTaeiY36P9mRiQOhxtMgUcKecsGIApw
         O8HIEqmoxsjewKwaRDVGjtuoHFKJ8L6isWKljFiNGfP1APDMUItRIRzrhECqRZqMK/xz
         B7022oRWzgoU/tD3Bmqs0TFfAGlN8JP5XecxqlBFByq+dZG7m18JmKJz7oIrRMxPAvIU
         L0LFIqyiIctzuuwQVoP03Fjr9RjpvdzzZMv+u60HIW7VZDJ5I5oMF1W1k8LQDIw3KJ+D
         96pg==
X-Gm-Message-State: AOAM5336AsrK/r4V/DclPL1tpqx8wMHjWuqnCObRL6SH8nLW2QhsxDf0
        KXo1iuOLmB0B2r3EPlIcTopne2+eD8hmgw==
X-Google-Smtp-Source: ABdhPJxEFKePXraclsm7QPYxSyxAs3Pl32KE4X4J2ukyv3vTpIx0Nb6aU8Ib712+eEOMKS03Y1mIFQ==
X-Received: by 2002:a05:6102:14a5:b0:31e:7404:50e0 with SMTP id d37-20020a05610214a500b0031e740450e0mr4905554vsv.62.1646059705548;
        Mon, 28 Feb 2022 06:48:25 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id j192-20020a1f23c9000000b003319491b375sm1673594vkj.32.2022.02.28.06.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:48:25 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id j5so5252012vkc.12;
        Mon, 28 Feb 2022 06:48:25 -0800 (PST)
X-Received: by 2002:a05:6122:ca1:b0:330:b95b:e048 with SMTP id
 ba33-20020a0561220ca100b00330b95be048mr8261499vkb.39.1646059704668; Mon, 28
 Feb 2022 06:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20220227225956.29570-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227225956.29570-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 15:48:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWiQSj3nhxJGjghKhrx+qT+=Ry-Txw6tJrk0aBBcr0Vvg@mail.gmail.com>
Message-ID: <CAMuHMdWiQSj3nhxJGjghKhrx+qT+=Ry-Txw6tJrk0aBBcr0Vvg@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: renesas,rspi: Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>
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

On Mon, Feb 28, 2022 at 12:00 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add RSPI binding documentation for Renesas RZ/V2L SoC.
>
> RSPI block is identical to one found on RZ/A, so no driver changes are
> required. The fallback compatible string "renesas,rspi-rz" will be used
> on RZ/V2L.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

> --- a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
> @@ -22,6 +22,7 @@ properties:
>                - renesas,rspi-r7s72100  # RZ/A1H
>                - renesas,rspi-r7s9210   # RZ/A2
>                - renesas,r9a07g044-rspi # RZ/G2{L,LC}
> +              - renesas,r9a07g054-rspi # RZ/V2L
>            - const: renesas,rspi-rz     # RZ/A and RZ/G2{L,LC}

The last comment looks a bit strange now. Perhaps just drop it?

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
