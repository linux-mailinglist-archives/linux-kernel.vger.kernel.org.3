Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA92B4F0AE3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbiDCPsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiDCPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:47:50 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D74326FA;
        Sun,  3 Apr 2022 08:45:55 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h63so8510033iof.12;
        Sun, 03 Apr 2022 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pGyUTVKMo02GKY33McJFWCWUIseC1H085Y7lLhijdJc=;
        b=JJ49hrhhVCU0Gm4xCQ9lxBgLf18xe1UJ+WIknacd4WCSYkq9OE+B9VSOCHU/aapJ42
         PErCF4OxA2tknmH61SbcGBcBz9PY2jJ8WsPBzzijTA3Oeadw+u5uWnWyLO4Z+kPQp8mJ
         Dnqfw854vABsmSSuhmzZm4boVh56jQAqt/T0rO+/E0NRfGIDD7SbUorHRsWIDxiWMXb1
         tOWjF6Yy0K31uQ5XfNp2Y6eN+cqV2EbdIcdfIvMw9VxcS5zBS33xAHRXAHWd2uV4hl1p
         /bvsYK7MGOl0tzu8cyPK4MN5OaShYICYs7ZN7PFc0XZd7QsS/9/yHHAxSQz6F229znE0
         K2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pGyUTVKMo02GKY33McJFWCWUIseC1H085Y7lLhijdJc=;
        b=S200oOhb8tkdTRGclsQ2ysQ0ITgBprcgHckQP8cdlyvZ9QmCtdyWKtrEmcAJNedNKp
         7M4Lu5+efuGx0vffglICGXUMCWe5m5/o4LHdqQtKwrPgSNOwgvwd40z1qD/bcD3KI3SZ
         TbQb6QkUf9bd25ZRLQOJKRUJdRiiLR559gYuJ1rjmX1CHpmo01RYiNaaugzrLGqBDqhn
         EmuNUOnCBBcinjrAbLN7xIpmdDCGFGB5UYhxXn0WTQMXxOB2LwPtCeCxhze3V/jlxtLQ
         gCv+Nq4WqrHTlOoxviBf4c9bi8glcSsivSiY0bIZKqwg4Q6Vf5CCUU8/oiG/Fbl8qbZG
         lBiQ==
X-Gm-Message-State: AOAM5328NDgl77fhnpc3hMLm0x8+UC7sYrDxx9y8mHEishUEGm5yjZQo
        67IJZbvLFdKx1dfX9FAjpie9ZNmhvLJMivixIXs=
X-Google-Smtp-Source: ABdhPJxVtmRE6+JACUKYpv+v9aTat7WMhYxwZcAH/zg3oa+UdFpdX0n4dR/yutCA3MbI52TRFosqYTW1JwrmFtaBlgM=
X-Received: by 2002:a5e:9302:0:b0:648:c246:291 with SMTP id
 k2-20020a5e9302000000b00648c2460291mr3633567iom.88.1649000755209; Sun, 03 Apr
 2022 08:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220403131154.1267887-1-gch981213@gmail.com> <20220403131154.1267887-4-gch981213@gmail.com>
 <817dda10-39db-adfc-376d-a3d5e037937e@linaro.org>
In-Reply-To: <817dda10-39db-adfc-376d-a3d5e037937e@linaro.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sun, 3 Apr 2022 23:45:44 +0800
Message-ID: <CAJsYDVKYsz7c2yVe7TmPu_7kvBDXTih4+cceLsay2YJm21YntA@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: spi: add binding doc for spi-mtk-snfi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-spi@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sun, Apr 3, 2022 at 11:37 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> [...]
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt7622-snand
> > +      - mediatek,mt7629-snand
>
> One blank line, please.

I'll fix this in the next version.

>
> > +  reg:
> > +    items:
> > +      - description: core registers
> > +
> > +  interrupts:
> > +    items:
> > +      - description: NFI interrupt
> > +
> > +  clocks:
> > +    items:
> > +      - description: clock used for the controller
> > +      - description: clock used for the SPI bus
> > +
> > +  clock-names:
> > +    items:
> > +      - const: nfi_clk
> > +      - const: pad_clk
> > +
> > +  ecc-engine:
>
> The nand-chip.yaml defines a nand-ecc-engine, so how about using that
> one? I know mtk-nand.txt uses ecc-engine, but for new schema better to
> use properties from existing YAML.

The ecc-engine code is shared between mtk_nand.c and this driver, and
the property name is defined in the shared part. I left it as-is so that
existing dt for mtk_nand doesn't break.

-- 
Regards,
Chuanhong Guo
