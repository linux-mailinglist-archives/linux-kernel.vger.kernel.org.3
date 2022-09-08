Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D86D5B22BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiIHPpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiIHPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:45:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6974FAC24F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:45:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y127so18346273pfy.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=2cXPsEEmqpGjBnsgwBYy/qYjnBkOZjWcTGgc9Qs3P1k=;
        b=XWke3P1iCAuKHT1QtigkpG28d1MXKN2BF0T2iwIcmo7/sL6blxCmndF8dVnY6nCH5K
         u1dlJ1I08sc1L4h317dDD+Ey9RKBqK0zkeRocHgjCkHyjocAfqGFYNNpq1d/niqcgSDA
         NR8BUxRUtxKJ6P3IR5IX4xYXYYMu7HWYuwCoh6eWPQfyVwpwNoE5cp+CKeQBOusznsoU
         OpHaTkG4qW11y5KsMKJ5dGHuJIonfuZKeLfuz6mWnES++N1hTOYmTHNffrneg8VVJnNB
         XSYxu9vWegZlVMV2EhOkMKqXxhIs2OcuXjpYqNgyvt0clDbhDXbXNqLm0xRBx8xtHbup
         IYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2cXPsEEmqpGjBnsgwBYy/qYjnBkOZjWcTGgc9Qs3P1k=;
        b=6YYNisRHCaFZ9o8UEFS8PAzI3/mWe19omF7ABICsCD2U79ayKByLJHuapPuB3I6wOM
         kPozN7sEt83nn5QP2GAjdvPGG89Z1IZPwXfJsrt7fhYz5o4GljJklGUw7P0lYiBrDyaH
         vDefUomhuEluINJrtxSEs/njtodP6+DMjr8rrv8h3d7Qzk+g1vglXmLDxSMD1ffGV3le
         t3eJLzIxzxjMBCycu86UktfrW1lC03qFzWQoUuuOkZcVqrgMwQ10AKaDu1xBpdhr3/Hn
         lqnE1bhz4yBg9ye1xcbChw52ZphD1xhZTGa8Q/krWb/Bcaa8jd5sekoXg215/plhux8z
         V0KQ==
X-Gm-Message-State: ACgBeo0R4aozXeSlZv5gL/Fh718kwf4/tcE2nEq43CjDn4rbHw7XDUG/
        Dpjc/uM7c7ZAljeGG7wlMJVyl+x7lbexmncmkhF12g==
X-Google-Smtp-Source: AA6agR5MSnQiwdnCkNknY/8pzsC6gDsw/OawAUwBq8sjFGwEMGwBRzl2H61BoEmA0jSkLSHyatRfkreEjSN9EynVGqs=
X-Received: by 2002:a63:8043:0:b0:434:fe8f:6cd0 with SMTP id
 j64-20020a638043000000b00434fe8f6cd0mr6366514pgd.115.1662651935822; Thu, 08
 Sep 2022 08:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220812173526.15537-1-tharvey@gateworks.com> <20220812173526.15537-2-tharvey@gateworks.com>
 <CAJ+vNU3QWWza-Q956GSLVvYJHC9owApyQD8Y1WNVDs0=qqz8-A@mail.gmail.com>
In-Reply-To: <CAJ+vNU3QWWza-Q956GSLVvYJHC9owApyQD8Y1WNVDs0=qqz8-A@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 8 Sep 2022 08:45:24 -0700
Message-ID: <CAJ+vNU3qv6yi48W6jX3-x-MiAFTU3AtbqsM-V8Dw29ZJFDrdKQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: imx8mp-venice-gw74xx: remove invalid and
 unused pinctrl_sai2
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
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

On Mon, Aug 22, 2022 at 10:03 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Fri, Aug 12, 2022 at 10:35 AM Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > pinctrl_sai2 is not yet used and not properly defined - remove it to
> > avoid:
> > imx8mp-pinctrl 30330000.pinctrl: Invalid fsl,pins or pins propert
> > y in node /soc@0/bus@30000000/pinctrl@30330000/sai2grp
> >
> > Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400 dts
> > support")
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > index de17021df53f..80f0f1aafdbf 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > @@ -768,15 +768,6 @@ MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09       0x110
> >                 >;
> >         };
> >
> > -       pinctrl_sai2: sai2grp {
> > -               fsl,pins = <
> > -                       MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC
> > -                       MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00
> > -                       MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK
> > -                       MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK
> > -               >;
> > -       };
> > -
> >         pinctrl_spi2: spi2grp {
> >                 fsl,pins = <
> >                         MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK   0x82
> > --
> > 2.25.1
> >
>
> Shawn,
>
> You can drop this. I didn't see Peng's patch commit 706dd9d30d3b
> ("arm64: dts: imx8mp-venice-gw74xx: fix sai2 pin settings") which
> takes care of this.
>
> Best Regards,
>
> Tim

Shawn,

Did you need me to re-submit the series this patch was in without it?
I haven't seen any responses to the rest of the patches in this
series.

Best Regards,

Tim
