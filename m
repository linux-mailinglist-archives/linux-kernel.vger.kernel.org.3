Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7D4594A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 02:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346883AbiHOX6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 19:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355367AbiHOXv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 19:51:59 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A602D92F4B;
        Mon, 15 Aug 2022 13:16:41 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-32a17d3bba2so100485077b3.9;
        Mon, 15 Aug 2022 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=F3WR7fgDxcCodVgsjoOsS+f77Gv20JzgJQeYT8zBw8Y=;
        b=m4GdyZOqTzEPFE5ZNoXqTb7eVjWUfyZNn3ENU/zHMsrwZhp3Byl1BKCAW+70SAfFlX
         7/EnRFBWxMB+0PFZFjCFYokpp3R6JFLkyEt7jKdgUe3iREKIe2pwbnnEQKGdq9zSi/Rk
         8eRe2Y2oLaOqAyYlPvVRk5Dtbl/ti9cBijHFqsXdih7YukZVF22d5LMh2iNLnv1op0mO
         eAFtV1e+FeT9O3GtU65MlTg4wC+BxRO5o4bPRQ/FaMXPRNu0/3PBw2+xt6gnYop4UatJ
         /2kZkldAP8qpB7fze71ZA2XURtodoYr5XChHX6Es3I896c5gDy65wASUMMfjRHpWbtU9
         mSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=F3WR7fgDxcCodVgsjoOsS+f77Gv20JzgJQeYT8zBw8Y=;
        b=wLh0XxfeOvD68bwRu8MMpuYR3RFBkzFstxulgJAZeKpaDDlIJrFQDhPA00vR70rp6q
         mFiNiQCbK5/cEIOfZZHUpRZek0Dfee/50q3a5+yKt6rLCgItpVI6+2NcGuYzTRTJ5k4J
         Q/KEYdiKqjQ2vKGMLrfNVXOc/Zdy7ucOQSGsg9cAnlI6ZZaBmOJwMrfldp5STsKQMLck
         7JLcEYeOCiVYZswGJI3FVooP8SqTi0oAZ2+0ZrdSJXE/yABxxaYmlf+3iagt9ZIFhLcS
         fC8VyPtpCYJLQlWVq47nIx9p3YvOHjqueOL8GslZdDbconSloe0V9w7c/v1uyHD+6PFb
         WpzA==
X-Gm-Message-State: ACgBeo00DAU/KFS5fyXSw7kVxFcJXih9z8OZ019/wZDbQkikvxK6I4jg
        BkWYsu6Tx5NRvrKcE7TS+nkUKutNIiSo5DS+lwE=
X-Google-Smtp-Source: AA6agR53x6Ky5DFoyiOZsi1UNCdLAREHkkmy3+pa3bj7rCyr5qdJmXVXVMo0vrQdOzqePpsCUG0fqZm8CD4XyiuvFwk=
X-Received: by 2002:a25:3206:0:b0:677:2480:ffa6 with SMTP id
 y6-20020a253206000000b006772480ffa6mr13207204yby.335.1660594600950; Mon, 15
 Aug 2022 13:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <07342070-d96c-59fc-f9dd-b65cd742d97a@microchip.com>
In-Reply-To: <07342070-d96c-59fc-f9dd-b65cd742d97a@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 15 Aug 2022 21:16:13 +0100
Message-ID: <CA+V-a8uNRr+WPX=YC+UMT4ch4S5XwsatHCzUoSt+hTk4C=cheA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
To:     Conor.Dooley@microchip.com
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mon, Aug 15, 2022 at 8:00 PM <Conor.Dooley@microchip.com> wrote:
>
> On 15/08/2022 16:14, Lad Prabhakar wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Enable the minimal blocks required for booting the Renesas RZ/Five
> > SMARC EVK with initramfs.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * New patch
> > ---
> >  arch/riscv/boot/dts/Makefile                  |  1 +
> >  arch/riscv/boot/dts/renesas/Makefile          |  2 ++
> >  .../boot/dts/renesas/r9a07g043f01-smarc.dts   | 16 ++++++++++
> >  .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 22 +++++++++++++
> >  arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 32 +++++++++++++++++++
> >  5 files changed, 73 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/renesas/Makefile
> >  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
> >  create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
>
> Just to sort out some of my own confusion here - is the smarc EVK
> shared between your arm boards and the riscv ones? Or just the
> peripherals etc on the soc?
>
RZ/Five SoC is pin compatible with RZ/G2UL Type 1 SoC (ARM64). RZ/G2UL
SMARC EVK carrier board can be swapped with RZ/Five or RZ/G2UL SMARC
SoM and still be used.

> If it is the forver, does the approach suggested here for the
> allwinner stuff make sense to also use for risc-v stuff with
> shared parts of devicetrees?
> https://lore.kernel.org/linux-riscv/3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com/
>
it does make sense. But I wonder where we would place the common
shared dtsi that can be used by two arch's.

> Would at least be interesting in hearing more opinions from the dt
> people, Geert & Palmer. We have some SOM based stuff too with carriers
> so I am interested in seeing how the cross platform part of that works
> out.
>
Yep, that would be interesting.

Cheers,
Prabhakar
