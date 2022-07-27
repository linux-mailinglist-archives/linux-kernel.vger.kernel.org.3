Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB015821B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiG0IBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiG0IBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:01:15 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF82422ED;
        Wed, 27 Jul 2022 01:01:13 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id c131so29002860ybf.9;
        Wed, 27 Jul 2022 01:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4DAUtMqWwVudJqi/niJOWb+6cSIXvBRzWlx03pK1Nc=;
        b=UE9j56sjpWAsYKOcxBMjUI2ak6h/MS5YtqYJaKzcqWKbuuqSfa+F3h8Vu5AdcTPsC3
         Sd9HGogbOgcFhU/EngE77Yk77wswd7O1Ml4szPquZR7tJAqQdFKdoGBq0iwxKU/fZgII
         NL1Dgpp8/t2Nkvdqyg0cfv/AfZuLNaB8m0kH4DM0E9t26sRsMKdPZII2imgB1jnpm61i
         TzYCQ7DWuVjbH/SC99Sc9W8s8TwR6zbvJyKlHw6MjoC9mW4UeCFC7XN6MEsQcmnrgDga
         gtXiAy3w1WXrtxtI015STtvB806cc5zGnVxMzt5tp7mtAcKn2J1O7TOjv5WlhxJjKvKz
         pUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4DAUtMqWwVudJqi/niJOWb+6cSIXvBRzWlx03pK1Nc=;
        b=rl0kM1AbyJU+mhkZslv1HF0STOLaQCiEhAMbUIHpTomaDPSDNkrnF/d+Xam+RuR+f5
         ytqX6uxQoszWzhNjOI/M/cX4OvvwexYjUGmKk5qPxdbkYpZHQLSgJNPNkBaE6RRonBKf
         gvf2mTFV0YbDnBTBs4EvP214eAvYBwfOehe/Xs1iN3cjOR9bJ/3TfAGrWR97FOEOGWTy
         cmWMn2bEoXqJzN1Oys0ezTAHWn78lxTZHo+jGsfVRtcsDSbNal+sFogPP41Z4pBUPbjy
         i2IDCzB3PgPBbPo5/vE58ddxA/bLMerePrUXONU0CI5VJgspyxx0wP04APdvFj87vgep
         shRg==
X-Gm-Message-State: AJIora/PJHwMJvq4C1Cq4TUuZQIF2WDWRQQk19aFPSfYftF+gU+1sKgx
        Nds37KReQJGQx1qL9YFv/zR/cWVZeAFfquOLzMk=
X-Google-Smtp-Source: AGRyM1vn+8Q6+I5xh7dntobwuywvhGo1l2I75PEVKouLyIip06Ow1NQMkw5NmUO6c3AaYmH8P2N2SYLMHai6GYktd/Q=
X-Received: by 2002:a25:9e92:0:b0:66e:c03e:c632 with SMTP id
 p18-20020a259e92000000b0066ec03ec632mr16366501ybq.279.1658908872552; Wed, 27
 Jul 2022 01:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <e05b7ef1-64ae-4c12-7664-c70c7a35f76d@microchip.com>
In-Reply-To: <e05b7ef1-64ae-4c12-7664-c70c7a35f76d@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Jul 2022 09:00:45 +0100
Message-ID: <CA+V-a8tkDSKtJZZt8U4ZXZ8dd2jA4o=pAmwXuvLXV9KvSCUeUg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add support for Renesas RZ/Five SoC
To:     Conor.Dooley@microchip.com
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Tue, Jul 26, 2022 at 7:51 PM <Conor.Dooley@microchip.com> wrote:
>
> On 26/07/2022 19:06, Lad Prabhakar wrote:
> > Useful links:
> > -------------
> > [0] https://www.renesas.com/us/en/products/microcontrollers-microprocessors/
> > rz-mpus/rzfive-risc-v-general-purpose-microprocessors-risc-v-cpu-core-
> > andes-ax45mp-single-10-ghz-2ch-gigabit-ethernet
> >
> > [1] http://www.andestech.com/en/products-solutions/andescore-processors/
> > riscv-ax45mp/
> >
> > Patch series depends on:
> > -----------------------
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> > 20220722141506.20171-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
> > [1] https://patchwork.kernel.org/project/linux-renesas-soc/
> > cover/20220630100241.35233-1-samuel@sholland.org/
> >
> > [2] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> > 20220726174525.620-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
> > [3] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> > 20220726174929.950-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
> > [4] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> > 20220726175315.1147-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> FYI, your mail client or w/e wrapped these links and none of
> them work properly :(
>
Sorry I had wrapped them around.

[0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220722141506.20171-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

[1] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220630100241.35233-1-samuel@sholland.org/

[2] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220726174525.620-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

[3] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220726174929.950-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

[4] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220726175315.1147-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
