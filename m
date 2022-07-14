Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0525751FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbiGNPiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiGNPiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:38:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818C0481D0;
        Thu, 14 Jul 2022 08:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F969B823DE;
        Thu, 14 Jul 2022 15:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A856CC3411C;
        Thu, 14 Jul 2022 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657813089;
        bh=U9G5H+F5ke4Ig1zhCGdP+JXYur2miSUshKx7+9DJkZk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ntY6kk5rfRV/jplMtoO0VwrEPFtoYYymHPd19E+KscZ4zy+/+P+t9mZYZEf9XC2DC
         bhYylukM6lpZwkEwUgC9UdUJliEBYkJQ4g/4soxJmsjapha3zIDibt9L/oBuv0g68M
         redoVX+gBo2DDaV2XvKK4Kt7sGYWdxiWFm8Nn2U4xiJXLXat/FfzWN0WagJcrKbJM6
         P0AEstXeJfYTDI7D0UfxoP7Jps1ciz97fusNVpTfCRRU5ExLryBTL4cTyuyWhEqcto
         u9wprbirqr0GcN/ny3jsWZc5g6opGKzmcaxd+QywRP7Z4Wc7QLPkM7tsN2DrLSKQHk
         +xo8rO5Ua7BDw==
Received: by mail-vk1-f172.google.com with SMTP id m188so983298vkm.3;
        Thu, 14 Jul 2022 08:38:09 -0700 (PDT)
X-Gm-Message-State: AJIora/IhV7sWcsfkG6T8ozxIoEBvDVRlcP9dMlxHGasYRAvLy7pNCTx
        nq5NxCxRbzuLR4DgowYbVlt8TYikv0XE47tobQ==
X-Google-Smtp-Source: AGRyM1ueakcaqefdrg7VLkKXk8mWYborOH3gMs/rbv3OLb8P/RdVgXMatAj03gLpnDmmrBTDHwqD6nygYxHFXTW2Wnk=
X-Received: by 2002:a1f:2049:0:b0:374:866b:6dd8 with SMTP id
 g70-20020a1f2049000000b00374866b6dd8mr3907873vkg.15.1657813088619; Thu, 14
 Jul 2022 08:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220630131543.225554-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220630131543.225554-1-angelogioacchino.delregno@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Jul 2022 09:37:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLY7eSLKhRrL7hx9jFxTm-s=MmdXOVVJv3667fSoeSvSQ@mail.gmail.com>
Message-ID: <CAL_JsqLY7eSLKhRrL7hx9jFxTm-s=MmdXOVVJv3667fSoeSvSQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8195: Add and use drive-strength-microamp
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 7:15 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> As was already done for MT8192 in commit b52e695324bb ("dt-bindings:
> pinctrl: mt8192: Add drive-strength-microamp"), replace the custom
> mediatek,drive-strength-adv property with the standardized pinconf
> 'drive-strength-microamp' one.
>
> Similarly to the mt8192 counterpart, there's no user of property
> 'mediatek,drive-strength-adv', hence removing it is safe.
>
> Fixes: 69c3d58dc187 ("dt-bindings: pinctrl: mt8195: Add mediatek,drive-strength-adv property")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/pinctrl/pinctrl-mt8195.yaml      | 27 ++-----------------
>  1 file changed, 2 insertions(+), 25 deletions(-)

Now failing in linux-next. Looks like the example needs updating:

Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.example.dtb:
pinctrl@10005000: i2c0-pins:pins: 'mediatek,drive-strength-adv' does
not match any of the regexes: 'pinctrl-[0-9]+'
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
