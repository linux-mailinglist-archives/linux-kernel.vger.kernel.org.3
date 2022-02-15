Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB074B7ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbiBOWyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:54:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiBOWyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:54:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD490FCD;
        Tue, 15 Feb 2022 14:54:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 049F5B81C23;
        Tue, 15 Feb 2022 22:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC332C340EB;
        Tue, 15 Feb 2022 22:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644965676;
        bh=vp0AA5rWNWbwH+h7RrfOW+1FW77YNO31CyLQUGfkQek=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K3AFijseqC8GbeefAxP32BuWuyj0dYJ4Ia8GwqQo5txlC7d37OSdcvqOOFYVv0m9d
         p9c7lXNewgA3CMClmpJMlhEs3ny9AIOz4VjKR9B/mdBdLVIM/oLm6kEPK6pgdzyDBL
         zM8oPb/ZUR89LdED7edEt+40xGFeFzBCdW/hXy5yGi8DaxCTd5Au6JmMSpXguLl4aO
         FyaLJyh1Fe3S1hAah9W6rQ/PH1UjVuDraKPwXavoOLlVmA3T6EKGdxWkIS/7xeMRdT
         ad0bYkM0C6ws46CuOa+fN0IXMoMux61pGYcI8tyf/ShRV6XYeySDAQP4tzm+UUo9lL
         +towKOuOi7cng==
Received: by mail-ed1-f54.google.com with SMTP id h18so760971edb.7;
        Tue, 15 Feb 2022 14:54:36 -0800 (PST)
X-Gm-Message-State: AOAM532kvvFMEpjTGmhV9lf2Rd3KzR3qSNGkQDdJqcz3k9ohqVARLoqP
        WuQFeyuIqjPkpxI//nQ7+FlWNhqTHmkuHL+Rww==
X-Google-Smtp-Source: ABdhPJwIhjgFezkhGh/JThuKg8ThIEnytIpHYE2ZFs4zMkn1bSCelwpeUJLERmuj2x6h/ToJGmqArMx73XuAI+0Vol0=
X-Received: by 2002:a05:6402:5242:b0:40f:6a4f:ff33 with SMTP id
 t2-20020a056402524200b0040f6a4fff33mr126833edd.30.1644965675039; Tue, 15 Feb
 2022 14:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Feb 2022 16:54:23 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+bfr=csxzKN3T=tBY7bZ6Gny+sm5xtMP8nmyiD3joNFg@mail.gmail.com>
Message-ID: <CAL_Jsq+bfr=csxzKN3T=tBY7bZ6Gny+sm5xtMP8nmyiD3joNFg@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] pwm: dt-bindings: Include generic pwm schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 3:22 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Hi,
>
> Changes since v1:
> 1. Add tags.
> 2. Adjust subject (Uwe).
>
> Best regards,
> Krzysztof
>
> Krzysztof Kozlowski (15):
>   dt-bindings: pwm: allwinner,sun4i-a10: Include generic pwm schema
>   dt-bindings: pwm: imx: Include generic pwm schema
>   dt-bindings: pwm: intel,lgm: Include generic pwm schema
>   dt-bindings: pwm: iqs620a: Include generic pwm schema
>   dt-bindings: pwm: mxs: Include generic pwm schema
>   dt-bindings: pwm: rockchip: Include generic pwm schema
>   dt-bindings: pwm: sifive: Include generic pwm schema
>   dt-bindings: pwm: renesas,pwm: Include generic pwm schema
>   dt-bindings: pwm: toshiba,visconti: Include generic pwm schema
>   dt-bindings: pwm: brcm,bcm7038: Do not require pwm-cells twice
>   dt-bindings: pwm: intel,keembay: Do not require pwm-cells twice
>   dt-bindings: pwm: samsung: Do not require pwm-cells twice
>   dt-bindings: pwm: tiecap: Do not require pwm-cells twice
>   dt-bindings: pwm: tiehrpwm: Do not require pwm-cells twice
>   dt-bindings: pwm: renesas,tpu: Do not require pwm-cells twice

For the series:

Reviewed-by: Rob Herring <robh@kernel.org>
