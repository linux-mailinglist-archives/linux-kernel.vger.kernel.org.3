Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A2595F74
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiHPPjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbiHPPiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4276514034;
        Tue, 16 Aug 2022 08:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE22C611EB;
        Tue, 16 Aug 2022 15:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ACCC433C1;
        Tue, 16 Aug 2022 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660664272;
        bh=V49dgqu/RAkWRS3001yah3EjBpkjCkpA7y5OPLHrM9Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HM6nA176MfOgvwM4aYzgxrXtkZNsyPzieWFtOM7wfa7Y6HbUs11ekwRDWDVFGGXGw
         27V34YIPzdRIqrOl8k53roAb4tMeD5UDDV3RvxJs4/nEufjpEz3ytpRzUlb75UoX7f
         SROELHAJ8Mbne9KSmP6mgvraDA/lHVPnonXJXTuB2h/9bkscGKgJ5nrdhIZtDpIjEo
         kBNP11wnL1imt6wjN99dVad9lNWWj9FE1BCqH6GH4kVXnOR+yujHEy4YqWd9AVAx0H
         WxHwbprxicMp3T+ovVm4DD6URYmFQxUHfQ68vJnbup2ojgM6/H6z1HwLET+nn0RO97
         fcXe1fZzFaopQ==
Received: by mail-ua1-f41.google.com with SMTP id s18so4160730uac.10;
        Tue, 16 Aug 2022 08:37:51 -0700 (PDT)
X-Gm-Message-State: ACgBeo0ajzHlMuRIr+AeGlSE5R8WgtFK0ktXaZCMoN2zXAc19FX9wQp2
        +PVs+UzAGu/wzazL6+zG2WxB/szrdxviIa7vtw==
X-Google-Smtp-Source: AA6agR6P6tx9Y0Tb4qmdIdqjNQDONt+9JZtqem7UsItHKI1hbGP9NpYbZ5qL4HTr0AbwT9oos2Tvh2M0MtkHzHMsHgQ=
X-Received: by 2002:ab0:2b06:0:b0:384:c4af:107c with SMTP id
 e6-20020ab02b06000000b00384c4af107cmr8599136uar.77.1660664270971; Tue, 16 Aug
 2022 08:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220805070610.3516-1-peterwu.pub@gmail.com> <20220805070610.3516-7-peterwu.pub@gmail.com>
 <YvJdpq0MWNPQZw5c@google.com>
In-Reply-To: <YvJdpq0MWNPQZw5c@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 16 Aug 2022 09:37:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJriSbJvejCi7n50T-NaOW+GF8yb6Fi4m-GvUkggf-9kw@mail.gmail.com>
Message-ID: <CAL_JsqJriSbJvejCi7n50T-NaOW+GF8yb6Fi4m-GvUkggf-9kw@mail.gmail.com>
Subject: Re: [PATCH v7 06/13] dt-bindings: mfd: Add MediaTek MT6370
To:     Lee Jones <lee.jones@linaro.org>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 7:14 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 05 Aug 2022, ChiaEn Wu wrote:
>
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add MediaTek MT6370 binding documentation.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > ---
> >  .../devicetree/bindings/mfd/mediatek,mt6370.yaml   | 280 +++++++++++++++++++++
> >  include/dt-bindings/iio/adc/mediatek,mt6370_adc.h  |  18 ++
> >  2 files changed, 298 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> >  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
>
> Applied, thanks.

Without the backlight schema applied, this is the result:

./Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml: Unable
to find schema file matching $id:
http://devicetree.org/schemas/leds/backlight/mediatek,mt6370-backlight.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:
pmic@34: backlight: False schema does not allow {'compatible':
['mediatek,mt6370-backlight'], 'mediatek,bled-channel-use': b'\x0f'}
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:
pmic@34: charger: False schema does not allow {'compatible':
['mediatek,mt6370-charger'], 'interrupts': [[48], [68], [6]],
'interrupt-names': ['attach_i', 'uvp_d_evt', 'mivr'], 'io-channels':
[[1, 5]], 'usb-otg-vbus-regulator': {'regulator-name':
['mt6370-usb-otg-vbus'], 'regulator-min-microvolt': [[4350000]],
'regulator-max-microvolt': [[5800000]], 'regulator-min-microamp':
[[500000]], 'regulator-max-microamp': [[3000000]], 'phandle': [[2]]}}
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:
pmic@34: tcpc: False schema does not allow {'compatible':
['mediatek,mt6370-tcpc'], 'interrupts-extended': [[4294967295, 4, 8]],
'connector': {'compatible': ['usb-c-connector'], 'label': ['USB-C'],
'vbus-supply': [[2]], 'data-role': ['dual'], 'power-role': ['dual'],
'try-power-role': ['sink'], 'source-pdos': [[570527844]], 'sink-pdos':
[[570527944]], 'op-sink-microwatt': [[10000000]], 'ports':
{'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg':
[[0]], 'endpoint': {'remote-endpoint': [[4294967295]]}}, 'port@1':
{'reg': [[1]], 'endpoint': {'remote-endpoint': [[4294967295]]}},
'port@2': {'reg': [[2]], 'endpoint': {'remote-endpoint':
[[4294967295]]}}}}}
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:
pmic@34: indicator: False schema does not allow {'compatible':
['mediatek,mt6370-indicator'], '#address-cells': [[1]], '#size-cells':
[[0]], 'multi-led@0': {'reg': [[0]], 'function': ['indicator'],
'color': [[9]], 'led-max-microamp': [[24000]], '#address-cells':
[[1]], '#size-cells': [[0]], 'led@0': {'reg': [[0]], 'color': [[1]]},
'led@1': {'reg': [[1]], 'color': [[2]]}, 'led@2': {'reg': [[2]],
'color': [[3]]}}, 'led@3': {'reg': [[3]], 'function': ['indicator'],
'color': [[0]], 'led-max-microamp': [[6000]]}}
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:
pmic@34: flashlight: False schema does not allow {'compatible':
['mediatek,mt6370-flashlight'], '#address-cells': [[1]],
'#size-cells': [[0]], 'led@0': {'reg': [[0]], 'led-sources': [[0]],
'function': ['flash'], 'color': [[0]], 'function-enumerator': [[1]],
'led-max-microamp': [[200000]], 'flash-max-microamp': [[500000]],
'flash-max-timeout-us': [[1248000]]}, 'led@1': {'reg': [[1]],
'led-sources': [[1]], 'function': ['flash'], 'color': [[0]],
'function-enumerator': [[2]], 'led-max-microamp': [[200000]],
'flash-max-microamp': [[500000]], 'flash-max-timeout-us':
[[1248000]]}}
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:
backlight: mediatek,bled-channel-use: b'\x0f' is not of type 'object',
'array', 'boolean', 'null'
 From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/dt-core.yaml
