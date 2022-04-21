Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657D750A8C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391779AbiDUTL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378558AbiDUTL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:11:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458624CD49;
        Thu, 21 Apr 2022 12:08:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA259B828CD;
        Thu, 21 Apr 2022 19:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEDCC385A1;
        Thu, 21 Apr 2022 19:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650568113;
        bh=pEYDq1Q4e5rDzN3eRyGF3xFFJcxwOp83q2iiOlT0aSY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TGhrCQam+BzI8AblkY9oJC5GBIJvanyAPz+qTOneMa7ZXEkJd0ybqeh7WpQ+iYAgk
         4eHrDvon85rWmiDFwa142SjfqfGihwK8beAXTWWnN0KPbf9pe6wCuhEU8Oatv6ZMOz
         HhYTuF4oVgUeReR8Cx4b8p9897zD7cGevATUxdhUMDgwZQaj1pMFrp2saUfNqm67aK
         lAsoOOhK23C79Kkj7ZiuoKnojUV33ZZaCobm8yJADOKqbpJFrjRAKscdVPS+SLB2am
         LJ31ENmBc/jmfe2MvEk4jlS95eeLuq4edHC4xC9CxdoPlMBcQ3cKg0x1QQgN8VvrFo
         b3ZIPlxe0Yvqg==
Received: by mail-pl1-f172.google.com with SMTP id d15so5825022pll.10;
        Thu, 21 Apr 2022 12:08:33 -0700 (PDT)
X-Gm-Message-State: AOAM530g0RZKoVWj6k/0+OjJKyvOGwmvB1t1447Hi6VKbg1AmcGo4OVq
        /tb3ZjrMba1ucf9pjzcc1OXLP+tugxUbwxnXAw==
X-Google-Smtp-Source: ABdhPJx2/vfWAJgwxYJ1KQbeNopS2+xzJdE+dbc/rOWErLiBExZaizfaFLAsh3z3f2E0CAdu5U/TeCXH+YWQgDptf/E=
X-Received: by 2002:a17:902:eb8c:b0:158:4cc9:6998 with SMTP id
 q12-20020a170902eb8c00b001584cc96998mr925604plg.35.1650568112939; Thu, 21 Apr
 2022 12:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <f6086989-a4c1-4223-fad0-79bd5719432e@linaro.org>
 <20220421094421.288672-1-michael@walle.cc> <YmFo+EntwxIsco/t@robh.at.kernel.org>
 <30f2f62406bab8225cc88013b414016d@walle.cc>
In-Reply-To: <30f2f62406bab8225cc88013b414016d@walle.cc>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 Apr 2022 14:08:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJr0fvqL_6CL__Q6aY0AVD+gL4=g46Y=j2r=fJy9jDwGg@mail.gmail.com>
Message-ID: <CAL_JsqJr0fvqL_6CL__Q6aY0AVD+gL4=g46Y=j2r=fJy9jDwGg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech sx1301
To:     Michael Walle <michael@walle.cc>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Changming Huang <jerry.huang@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang-Leo Li <leoyang.li@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:16 AM Michael Walle <michael@walle.cc> wrote:
>
> Am 2022-04-21 16:23, schrieb Rob Herring:
>
> > What's needed here is a connector node (and driver) for the mikrobus
> > socket. The connector node's purpose is to decouple the host DT from
> > add-on board overlay DT. Something like this:
>
> Funny I had a similar idea to have a connector with all the
> properties, but I failed to see how that would be of any help.
>
> Do you mind an example of such an overlay? Judging by the spi
> and i2c subnode, I guess it will amend the connector node and
> fill in it's devices?

Right.

>
> And all the child device properties will reference the connector,
> correct?

Right.

>
> > connector {
> >       // And a more specific compatible if pins can have alt funcs?
> >       // Spec version needed?
> >       compatible = "mikrobus-socket";
> >
> >       // Will need regulators defined if child devices expect
> >       // regulators
> >       vcc-33-supply = <&reg33>;
> >       vcc-5-supply = <&reg5v>;
> >
> >       i2c-parent = <&i2c1>; // Already a defined property
> >       spi-parent = <&spi0>; // New
>
> uart/serial needed too?

Yes. Serial has the extra issue in the kernel that tty vs. serdev are
mutually exclusive and decided by presence or not of a child node for
the UART. That would need some work to dynamically switch. I think I
have some old patches doing that, but they probably break some aspects
of TTY expectations.

>
> >
> >       // RST pin
> >       reset-gpios = <&gpio 4 0>;
> >
> >       // remap 'INT' (index 0) to host interrupt
> >       #interrupt-cells = <2>;
> >       #address-cells = <0>;
> >       interrupt-map = <0 0 &gpio 3 0>;
> >
> >       spi {
>
> For example:
>
> my-device@0 {
>    reg = <0>;  // really needed? there is only one SPI CS line

Yes, needed.

>    compatible = "my-device";
>    reset-gpios = // may be left unset if it's optional, but what
>                  // what if it is a required property and in hardware
>                  // its connected to the RST pin of the module?

Probably should not be required and the connector driver manages it.

>    other-gpios = <&connector 2>;
>    vdd-supply = // what comes here? <&connector VCC_33>?

That has to be figured out, but *-supply doesn't take arg cells
currently. Probably the connector needs to define its own regulator
nodes.

>    interrupts-extended = <&connector 0 ..>;
> }

Rob
