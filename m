Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC3D59C491
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbiHVREP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiHVREN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:04:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AEA2AE0D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:04:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u6so9703442eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=o4G6R0VMB8OZ3qPmdHch9f/GUeGaJ8wf4k21qG3+9ug=;
        b=vjb2dZ1LaAraxqJSC00yMnUxygA8YYf8l+V8QfrZ3YiFF0nm8LUVjjdI4gHdiW1bBO
         Z36mfQuVmYtmb0VnkyndDSMuwdgi8Ja5LNyJMXnPGfR74OqkDjVUcnslC1OD+SGX8V4R
         vfO3Jz+U+gfsJyEJrpFUv6ijEb2shry3M2qFN7lQJYkpt/awNFOnC0PeySxnIouzbpOr
         NAwuYhdMP8Plm/MlvSZwtv8h2ll6zPVb834v8hpkPXe2Qe91v+fFsADjAxOx7l88vXlu
         xY+Vlvgbjp5X+ru0ylKr+8bcWo+AIApP3ldIFhjlqihqQ311fImkHMD2WWVuSYFM1Tp+
         2LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=o4G6R0VMB8OZ3qPmdHch9f/GUeGaJ8wf4k21qG3+9ug=;
        b=dTMw5ZLWKSwCMcGSZ1CQspsv+BDuOmigRwr8iCWJMl+tFNzY32PVZEDWtbQWjxOx/w
         YnhCzvdjSnHpBg4EsY8w6w2euCGxqTlT2SNWivZFfyzioQJgZCaM+XMxFHyxdoGHbATB
         UegggJEloD32C+kZ2Z0z4ELWxVoXOVXIiDYcbEtqdxej3/e9CioHLe1xo5HGE8+qSuLM
         uiNwpHCTNWVtwa8zg6Qea5AwCgAhYzyfRiycxwYPQFmtHMO1oo5IrrwfwUgmEun714Og
         NR1IOI0WxTUND+wmc8nkosd8jdBW1jaBQR7NcGqc9Nriw4LQR0VCzOGRoMMnJL5aU4lx
         tJOg==
X-Gm-Message-State: ACgBeo0SkuISZdEo76V/D39VFqXkEBonPx05mot6D0Z9pSVNqIIj8b1D
        7W7Wiiap4HHl2zyCl4+oWzGNDj+UX87NcIo7cwQzyA==
X-Google-Smtp-Source: AA6agR7GWW0ftE+5YYbaeJnRvwBaccXdl8fUzPFaBAgaJC9oKss0YJMYs81qs25lhOtxY+eBeY6EO/lr1EpvWDsW71E=
X-Received: by 2002:a05:6402:369a:b0:43d:75c5:f16c with SMTP id
 ej26-20020a056402369a00b0043d75c5f16cmr106714edb.57.1661187851082; Mon, 22
 Aug 2022 10:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220812173526.15537-1-tharvey@gateworks.com> <20220812173526.15537-2-tharvey@gateworks.com>
In-Reply-To: <20220812173526.15537-2-tharvey@gateworks.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 22 Aug 2022 10:03:58 -0700
Message-ID: <CAJ+vNU3QWWza-Q956GSLVvYJHC9owApyQD8Y1WNVDs0=qqz8-A@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 10:35 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> pinctrl_sai2 is not yet used and not properly defined - remove it to
> avoid:
> imx8mp-pinctrl 30330000.pinctrl: Invalid fsl,pins or pins propert
> y in node /soc@0/bus@30000000/pinctrl@30330000/sai2grp
>
> Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400 dts
> support")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> index de17021df53f..80f0f1aafdbf 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> @@ -768,15 +768,6 @@ MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09       0x110
>                 >;
>         };
>
> -       pinctrl_sai2: sai2grp {
> -               fsl,pins = <
> -                       MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC
> -                       MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00
> -                       MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK
> -                       MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK
> -               >;
> -       };
> -
>         pinctrl_spi2: spi2grp {
>                 fsl,pins = <
>                         MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK   0x82
> --
> 2.25.1
>

Shawn,

You can drop this. I didn't see Peng's patch commit 706dd9d30d3b
("arm64: dts: imx8mp-venice-gw74xx: fix sai2 pin settings") which
takes care of this.

Best Regards,

Tim
