Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379635AC4C7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 16:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiIDOYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 10:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiIDOYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:24:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB4032ECD;
        Sun,  4 Sep 2022 07:24:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id p16so12456078ejb.9;
        Sun, 04 Sep 2022 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=WQd/3yVISfVxzbk67RJMWa5vojDrpagddwxD0a038Uw=;
        b=QqWTf6BD3mAcwBbQhW+iE5V/E+pc/i599Io0yu7zs7OL0jZjgl13SMU5ZJiDa0ASLK
         mGvDvGkf/GxZHd4oLfupzwlYd4zZMmjS8qWbBDMgu0vtrBQIT4N1ou5ZyJOkGnrXOFcg
         l/EA//E12X9HxXFWyML+wozFbQvI+4SoVv0iOZo2/kssS4lRnA5krZLujtIVDyX5NNW0
         zOi+TAl8NNy2vUdkskbZqEfM97tQAjw+yuVDzqlMoawPUEC2sbhMjpWlVYpspxcr5Qy7
         ZRmHkcIgcW5WytAShqXWxtCBYaAt9KW1ItBP+iC+sa6QBr32DkLKhs5rewc9GFc/0Ibg
         N9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WQd/3yVISfVxzbk67RJMWa5vojDrpagddwxD0a038Uw=;
        b=d7cbPbF71DsPtBBUZDyTiuiDKtL/evDHog6wQ8iYOgrDj0Dl8awpAdKCQsm+zOXznb
         3ZdJ7dUdNcD800FAZVBbxKHSkzXM6/5MIWM4BpqnqSssuQfp5bNCnAYeP1hWtJktulCW
         zkAoQuMxhdi/uhvr+MrpL2b3Wkh2/NNhc5GrcnQ5SOAC6UF3OBurijrhBeRB0GWAK7yd
         U/qG91cPjsdNITVaOQpmAJJIoiFacjeIb/s/3WCeWtv5xsbBGBQZ7K04dfEA9x3mAiU4
         LD0U9aseXol1D1LvVHXC8mT8+N32sz14x9I03m/Skfp/gRtE9Ta8JzB5MMm2BBo6R8jZ
         xRnw==
X-Gm-Message-State: ACgBeo3YWfRBJt4hRfjAWmNOn+ycIFfDmHNTGviqNcRE3IYKwMGhcf2c
        TxYDVQEoMyYO+WEd8tal4jpWUy15EsNz+iqamts=
X-Google-Smtp-Source: AA6agR4R7Bgy6wTffALjU0IQVwUxVsAM/a/tF2prkx1VQZUnUNx0Euixd76lpoNdKjThz2Xy6nNtSB6yhMgYjaB+K5g=
X-Received: by 2002:a17:907:7dac:b0:739:8df9:3c16 with SMTP id
 oz44-20020a1709077dac00b007398df93c16mr32591399ejc.9.1662301444582; Sun, 04
 Sep 2022 07:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220821173051.155038-1-peron.clem@gmail.com> <20220821173051.155038-5-peron.clem@gmail.com>
 <0c028109-bb50-fbaa-de18-9876706a7477@sholland.org> <CAJiuCcf7NuXFFLw6-RFcyZPNFPagfSB5aR7rY5528USzNB-iKg@mail.gmail.com>
 <CAJiuCcf0io5T=+Ap8io2uKn+CNqrCi2pbaCtyq2PVW=bEqKakg@mail.gmail.com> <26ebdc2d-caca-2d53-45bc-8c8b90c7c1fd@sholland.org>
In-Reply-To: <26ebdc2d-caca-2d53-45bc-8c8b90c7c1fd@sholland.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 4 Sep 2022 16:23:53 +0200
Message-ID: <CAJiuCcdGS-H+tq0o47Zm=UJNEL+Ff0_mkUU1N86ttE=iOTbknw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: allwinner: beelink-gs1: Enable GPU OPP
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Sun, 4 Sept 2022 at 05:32, Samuel Holland <samuel@sholland.org> wrote:
>
> On 9/3/22 2:06 PM, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Samuel,
> >
> > On Sat, 3 Sept 2022 at 20:41, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail=
.com> wrote:
> >>
> >> Hi Samuel,
> >>
> >> On Tue, 23 Aug 2022 at 05:07, Samuel Holland <samuel@sholland.org> wro=
te:
> >>>
> >>> On 8/21/22 12:30 PM, Cl=C3=A9ment P=C3=A9ron wrote:
> >>>> Enable GPU OPP table for Beelink GS1
> >>>>
> >>>> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts=
 b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> >>>> index 6249e9e02928..20fc0584d1c6 100644
> >>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> >>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> >>>> @@ -5,6 +5,7 @@
> >>>>
> >>>>  #include "sun50i-h6.dtsi"
> >>>>  #include "sun50i-h6-cpu-opp.dtsi"
> >>>> +#include "sun50i-h6-gpu-opp.dtsi"
> >>>>
> >>>>  #include <dt-bindings/gpio/gpio.h>
> >>>>
> >>>> @@ -261,6 +262,7 @@ reg_dcdca: dcdca {
> >>>>                       };
> >>>>
> >>>>                       reg_dcdcc: dcdcc {
> >>>> +                             regulator-always-on;
> >>>
> >>> Why is this necessary? This file already has:
> >>
> >> This is a relica from the first serie at this time the OPP doesn't
> >> properly enable the regulator it's now fixed since:
> >> https://patchwork.kernel.org/project/linux-pm/patch/81eb2efeeed1556d12=
4065252f32777838a6d850.1589528491.git.viresh.kumar@linaro.org/
>
> This should have nothing to do with the OPP driver; lima already has a "m=
ali"
> regulator consumer that should be enabled whenever the GPU is in use.

Okay so you propose to add a regulator_enable() in the panfrost
drivers in addition to the OPP consumer right?

I will send a patch to add this and see what's panfrost maintainer
think about it.

Regards,
Clement

>
> _Adding_ a regulator consumer from the OPP driver should not somehow decr=
ease
> the refcount.
>
> >> I will drop it.
> >
> > After retesting it, it seems to still no take the regulator and make
> > my board hang... :(
> >
> > [   17.698597] sun8i-dw-hdmi 6000000.hdmi: registered DesignWare HDMI
> > I2C bus driver
> > [   17.708475] sun4i-drm display-engine: bound 6000000.hdmi (ops
> > sun8i_dw_hdmi_ops [sun8i_drm_hdmi])
> > [   17.718350] [drm] Initialized sun4i-drm 1.0.0 20150629 for
> > display-engine on minor 1
> > [   17.877443] Console: switching to colour frame buffer device 320x90
> > [   17.936050] sun4i-drm display-engine: [drm] fb0: sun4i-drmdrmfb
> > frame buffer device
> > [   17.961881] platform 5200000.usb: deferred probe pending
> >>>>> [   31.710731] vdd-gpu: disabling <<<<<
>
> Are there any messages from lima, especially about mali-supply? Can you p=
rovide
> regulators_summary from debugfs?
>
> Regards,
> Samuel
