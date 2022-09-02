Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C465AB4E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiIBPSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiIBPST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:18:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6714D810;
        Fri,  2 Sep 2022 07:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84FA8B82C4E;
        Fri,  2 Sep 2022 14:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333CBC433C1;
        Fri,  2 Sep 2022 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662130279;
        bh=4Hkr87g3PnzCLM9ZxFNQa5qADO4ZTPUXVLBqOM+przo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h89XrqJuOXVQ4/8j/RjAq2NaBhz3+B4MWMgpH+S85BBgwuJpO7HMyGFtHxu9/UISb
         Ooo9ElCQqawa3/ew19xm+Tz8ntL2NNlg5mAxSK0mq26A0evpSb4NxGfhghyXeznQXl
         /aHP8dyeitoacHRZMR1sxLILr14GNLypUZxk2V5lEPeSv+9Ou0tnxKyOviLCLvJGqH
         nCTIO4INBz1uA6d8Mp3wUvJL8ixuaiePPI1AhxbL4ojKFomWDsXe4zwK1IqJNXOipd
         sHAb2Ql5+ML2QYQ8EHQtg0orVkUV23sLA/WQA20OOSIVe1Qav+eGismKrmZ/GiiczB
         WC/lWgSOFhgew==
Received: by mail-vk1-f174.google.com with SMTP id w129so1073449vkg.10;
        Fri, 02 Sep 2022 07:51:19 -0700 (PDT)
X-Gm-Message-State: ACgBeo1WSC1wHxzO0oslDPREe9xoTEs1WcPm2keKBbt+VAnl2sqGh1g6
        SHbT5SqCZW83jQQF6tBE3o8RNcG3hij2kubHDg==
X-Google-Smtp-Source: AA6agR7gPR2eoNK8OlOt6H6YcAAUxzaXErLPZTaQL7XqzgtAc9mBmf8rXIp3NGDWwMeU3NPODBPf4sb4u9Hs3ebXLSY=
X-Received: by 2002:a05:6122:d86:b0:37d:3fe:df43 with SMTP id
 bc6-20020a0561220d8600b0037d03fedf43mr10496067vkb.15.1662130278184; Fri, 02
 Sep 2022 07:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220823145649.3118479-4-robh@kernel.org> <13083804.uLZWGnKmhe@kista>
In-Reply-To: <13083804.uLZWGnKmhe@kista>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 2 Sep 2022 09:51:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJTgrSZcKNr1ky5LAXRQbj3MADMpCCYVC26rcZvzwY1Xw@mail.gmail.com>
Message-ID: <CAL_JsqJTgrSZcKNr1ky5LAXRQbj3MADMpCCYVC26rcZvzwY1Xw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: Add missing (unevaluated|additional)Properties
 on child nodes
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Ripard <mripard@kernel.org>,
        - <patches@opensource.cirrus.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        Alistair Francis <alistair@alistair23.me>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 3:49 PM Jernej =C5=A0krabec <jernej.skrabec@gmail.c=
om> wrote:
>
> Dne torek, 23. avgust 2022 ob 16:56:35 CEST je Rob Herring napisal(a):
> > In order to ensure only documented properties are present, node schemas
> > must have unevaluatedProperties or additionalProperties set to false
> > (typically).
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../mfd/allwinner,sun6i-a31-prcm.yaml         | 40 +++++++++++++++++++
> >  .../mfd/allwinner,sun8i-a23-prcm.yaml         | 10 +++++
> >  .../bindings/mfd/cirrus,lochnagar.yaml        |  5 +++
> >  .../devicetree/bindings/mfd/dlg,da9063.yaml   |  7 ++--
> >  .../bindings/mfd/gateworks-gsc.yaml           |  5 ++-
> >  .../bindings/mfd/maxim,max14577.yaml          |  1 +
> >  .../bindings/mfd/maxim,max77843.yaml          |  1 +
> >  .../bindings/mfd/rockchip,rk817.yaml          |  2 +
> >  .../bindings/mfd/silergy,sy7636a.yaml         |  1 +
> >  .../bindings/mfd/st,stm32-lptimer.yaml        |  4 ++
> >  .../bindings/mfd/st,stm32-timers.yaml         |  3 ++
> >  .../devicetree/bindings/mfd/st,stmfx.yaml     |  1 +
> >  .../bindings/mfd/stericsson,ab8500.yaml       | 22 ++++++++++
> >  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  1 +
> >  .../bindings/mfd/x-powers,axp152.yaml         |  1 +
> >  15 files changed, 100 insertions(+), 4 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
> > b/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml i=
ndex
> > d131759ccaf3..021d33cb3dd6 100644
> > --- a/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.ya=
ml
> > +++ b/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.ya=
ml
> > @@ -22,6 +22,7 @@ properties:
> >  patternProperties:
> >    "^.*_(clk|rst)$":
> >      type: object
> > +    unevaluatedProperties: false
> >
> >      properties:
> >        compatible:
> > @@ -34,6 +35,45 @@ patternProperties:
> >            - fixed-factor-clock
> >
> >      allOf:
> > +      - if:
> > +          properties:
> > +            compatible:
> > +              contains:
> > +                const: fixed-factor-clock
> > +
> > +        then:
> > +          $ref: /schemas/clock/fixed-factor-clock.yaml#
> > +
> > +      - if:
> > +          properties:
> > +            compatible:
> > +              contains:
> > +                const: allwinner,sun4i-a10-mod0-clk
> > +
> > +        then:
> > +          properties:
> > +            "#clock-cells":
> > +              const: 0
> > +
> > +            # Already checked in the main schema
> > +            compatible: true
> > +
> > +            clocks:
> > +              maxItems: 2
>
> Last time node with allwinner,sun4i-a10-mod0-clk compatible was used, it =
had 3
> clocks. See:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/
> arm/boot/dts/sun4i-a10.dtsi?id=3Df18698e1c66338b902de386e4ad97b8b1b9d999d=
#n406

Humm, we already have constraints in
bindings/clock/allwinner,sun4i-a10-mod0-clk.yaml. I'll just make it
'clocks: true' here instead.

Rob
