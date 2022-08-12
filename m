Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1C65915A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbiHLSvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbiHLSvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:51:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ED42F8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:51:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k14so1707340pfh.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nZViEdSBzXu2fQrhABwX+EwUi8ilQIR8gtlHJif3W58=;
        b=E0l5Fg3hWxENLdXvd5uMkoenmbrqG1sZ6T/PqIO+x2YscxkUyzp+nEwG53prW/NDte
         kDmNyrqlPnCrPKJSfbgjeONdijBy/IUIvf1qmEe0JO1crmQBYs4TL46M1abH8yj665HL
         dA7mfOYDn2006d+fFWcEsHllwlmWmqY3Iks5L6afT8Lo3QBtBi1fXFC6HYcV5/46DF9p
         IcSVOF1UK9j3Nas+6ysIJ0bFb33EYr7mh5iDr4hsXswZ1X68gL2wi0gtVfg8zaf3EuFk
         lArAX6vm/oVmmDehO7/qLY3VK1voiSwm7mIMwyhQ6r5lHcHHLZeMER6JydNuft3o2XHd
         WEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nZViEdSBzXu2fQrhABwX+EwUi8ilQIR8gtlHJif3W58=;
        b=ouZxLpISfuP9U+o+u+sxzmVxjZVsxcWzyw7ChTbl9WDUA1n/SRdgOJ0dngsfewj0Aj
         dwruPK/FV39TKWot+uzrsnPO/roi/BLwZWByYmfFYVyf8A63FfpqRYJSnL04EAZxE2ne
         MaMRNxy5yV2jNwUiIAAX3BdmZz8me5bUF93MXWyLevr9PZ8bM6M39EiHSjfF+yGgbM58
         c3/AmxVeCrkc7RBIJX5ISFbZoovXNflrAsfgCkZis0tI+t8hUq8IIxj6H8fMEGGBsw2z
         0V0VMM5DWfjlgh9IDBoV7bWdXr81OwarcEYTVj+oy35yrAlNOwgTIvNBTbS6aTk/5Iui
         FEJA==
X-Gm-Message-State: ACgBeo0cssK1kTkFuTK2vzRVuS61ahyxtGmF585jjGOayRnET9qyky6t
        BmfWBft/JEEWcRrp+Vc8bgnHKP21qC+8Jp/463Rfag==
X-Google-Smtp-Source: AA6agR7TmDXwXXpixA9Q5bXBZTjcdI0zqcFrwO16eaIC1gzV7Hi3Uyiq+gk7rIYYFmycG3wuFaCbNSPl+yxG1TlxS4s=
X-Received: by 2002:a63:3e88:0:b0:41c:d12e:d2d9 with SMTP id
 l130-20020a633e88000000b0041cd12ed2d9mr4174233pga.533.1660330306011; Fri, 12
 Aug 2022 11:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220812173526.15537-1-tharvey@gateworks.com> <CAOMZO5B5OMFMjXuM6Lk7iy_f3GnvWC-O_0uEds3jD-5oTtjMZA@mail.gmail.com>
In-Reply-To: <CAOMZO5B5OMFMjXuM6Lk7iy_f3GnvWC-O_0uEds3jD-5oTtjMZA@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 12 Aug 2022 11:51:35 -0700
Message-ID: <CAJ+vNU3E+5DWR5tQyUurLzGkinjX2fidbVNZ4T70CNmhM6eNTw@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: dts: imx8mp-venice-gw74xx: fix CAN STBY polarity
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 10:51 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Tim,
>
> On Fri, Aug 12, 2022 at 2:35 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > index 521215520a0f..de17021df53f 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > @@ -123,8 +123,8 @@ reg_can2_stby: regulator-can2-stby {
> >                 pinctrl-names = "default";
> >                 pinctrl-0 = <&pinctrl_reg_can>;
> >                 regulator-name = "can2_stby";
> > -               gpio = <&gpio3 19 GPIO_ACTIVE_HIGH>;
> > -               enable-active-high;
> > +               gpio = <&gpio3 19 GPIO_ACTIVE_LOW>;
> > +               enable-active-low;
>
> This 'enable-active-low' property does not exist. Just remove it.

Fabio,

Thanks - I see now that for active-low you just omit the
'enable-active-high' prop. I will send a new version.

Thanks,

Tim
