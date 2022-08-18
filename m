Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FC85983AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244897AbiHRNBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244886AbiHRNBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:01:07 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0511975CC8;
        Thu, 18 Aug 2022 06:01:07 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id c20so1003335qtw.8;
        Thu, 18 Aug 2022 06:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=G6NRVtnuSqWqwGqpWt9DLp5hNULRC9LvfIAkNgdvtjM=;
        b=kJlGbGfmxfBqf+bVVh1QtEbfOKf4xTrV9NX0JzY8WP2LZQ5OM1y9CAD0vWzGEG4Vbc
         y0cTvjr7k8yiqbGarpUAFzx+Y6c/N9E98NxDQPJxD2wAkyiKgL+PnhGsU5umWk0qnyiZ
         ctEv0IQVLBpH4hBb0o6W5aheZcorfIsj6QjuoRcdY9S05iDuGO0/e9+FOiCYw1/IV3cx
         6lpZu8eCgnSve26GBIPYxqA00xxopWjum8UPHglF3rXQpjhmPNl5ZpIEyKsqL7TLzMn4
         6RzK/ht5jG9siNtp97ntMTc77gHdBBoR2VqOXS7zwfVuBA+hw0cqcHxhpNVH5BLV9ant
         4c8w==
X-Gm-Message-State: ACgBeo0KOUzAV1rn9SNnpToWhrZtnAfC5Otg6a2UAf7QqWqCg9ayZA7k
        LfT9VJCT6DObk5I8Twh5A4ee/qaww3znXg==
X-Google-Smtp-Source: AA6agR75szNWxxDWZq4k1aFKjLruPb048asQ5OckjyQNTnlEAHYjLNCu5y8pFD5TXmxu7gn1BzFIYg==
X-Received: by 2002:ac8:58c6:0:b0:343:6ea4:c5d with SMTP id u6-20020ac858c6000000b003436ea40c5dmr2339896qta.371.1660827665177;
        Thu, 18 Aug 2022 06:01:05 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 19-20020ac84e93000000b0033e51aea00esm1025051qtp.25.2022.08.18.06.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 06:01:05 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31f445bd486so38260767b3.13;
        Thu, 18 Aug 2022 06:01:04 -0700 (PDT)
X-Received: by 2002:a05:6902:100a:b0:676:ed53:25b0 with SMTP id
 w10-20020a056902100a00b00676ed5325b0mr2514289ybt.365.1660827625358; Thu, 18
 Aug 2022 06:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220815151451.23293-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220815151451.23293-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Aug 2022 15:00:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWWv0MUsxJgy1XLNm3CENoAkRgZ2dwcYDgPdAkApA4=fQ@mail.gmail.com>
Message-ID: <CAMuHMdWWv0MUsxJgy1XLNm3CENoAkRgZ2dwcYDgPdAkApA4=fQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: riscv: Sort the CPU core list alphabetically
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
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

On Mon, Aug 15, 2022 at 5:16 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Sort the CPU cores list alphabetically for maintenance.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
