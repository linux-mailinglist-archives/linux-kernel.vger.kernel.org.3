Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E6D4F1A52
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiDDQEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 12:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352990AbiDDQER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:04:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541D942487;
        Mon,  4 Apr 2022 09:02:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id E45601F44731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649088140;
        bh=gXcTJN1wEbSuuha2o6PaxF2kCOHsWvsU4lW7wKZ/EhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIc5+GBU1VqyZ/IpAbIWiWDuHKZXEFZoZH2h/calTdrlh563WgQ6khtwNaWt4HrJ5
         noocOP+D1uVlFkkZ/D2ku2pgiYZEyJSO17BBcdEeSQ+7bzH3bP9zGCsWxQTqM/qufj
         BB1mNE37AKrgLb6lpHhrp75cl2xgQKAeO1cD9/1gamlzIMiMiJj818OwgMLCP1MnWp
         A+xfDaqUhaL+B5fwWXjYL7x2RAiOB4zNIWMi8kzvayptQzVj3MfH6YHdCpXwFkgUMh
         KmfUCMLMLzzr7aFN3qFlsFVSgdRP61LmmLplFSIN8Yghg33HV6eR/XSGDwADdMgU5O
         jIA1eAZdKHhxw==
Date:   Mon, 4 Apr 2022 12:02:14 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 0/4] dt-bindings: pinctrl: mt8192: Add missing
 wrapping node and properties
Message-ID: <20220404160214.w6wypnq3b6hfriub@notapiano>
References: <20220315211936.442708-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315211936.442708-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

If you could please also pick this series through your tree that would be great
:).

This would preemptively fix warnings for my mt8192-asurada.dtsi series [1].

[1] https://lore.kernel.org/all/20220316151327.564214-1-nfraprado@collabora.com/

Thanks,
Nícolas

On Tue, Mar 15, 2022 at 05:19:32PM -0400, Nícolas F. R. A. Prado wrote:
> 
> This series adds the wrapping node for pinmux nodes that was missing in
> the mt8192-pinctrl dt-binding as well as a couple other missing
> properties.
> 
> 
> Nícolas F. R. A. Prado (4):
>   dt-bindings: pinctrl: mt8192: Add wrapping node for pin configurations
>   dt-bindings: pinctrl: mt8192: Add mediatek,drive-strength-adv property
>   dt-bindings: pinctrl: mt8192: Add mediatek,pull-up-adv property
>   dt-bindings: pinctrl: mt8192: Add gpio-line-names property
> 
>  .../bindings/pinctrl/pinctrl-mt8192.yaml      | 155 +++++++++++-------
>  1 file changed, 98 insertions(+), 57 deletions(-)
> 
> -- 
> 2.35.1
> 
> 
> -- 
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.
