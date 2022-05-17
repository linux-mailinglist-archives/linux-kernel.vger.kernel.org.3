Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B129C52AD8E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiEQVbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiEQVbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:31:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8413337F;
        Tue, 17 May 2022 14:31:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 91C2F1F44529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652823075;
        bh=HRSS8woHfbhaBMvzaEElxv/TxCPiPytRs/B9ys0Aolo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7DGzljIgY1ZUvR5X0+e6kZMprNH2UzQ0A7u9HHHGywLCvjflIHY/vRiItTD1r2/z
         PQK6qSyuBWLGZatA2CENsvMqzWAs3ccA3dmVxFkZ5GiJtk4lhRC4C8yHkK+ixfzXMI
         uZfyEHtxSpggJFkbTYKHs8l6+yWib4hHXJkmRSROTIzvBOyD/VY8B+1nQgcBYkZwqA
         6i/5Ej9kgfoyU/cgrj9KEsQPWuWZH/QeMdygKYBjumnKQ4RCJXAA+04HCCvWRyxaQA
         9ezs/V0EEFsYXFXwyuljwTKZDQWkm9o606knMWZ6MEyFmZjTAISPUH58MFutFtRusi
         HJ1xFS6Hld++A==
Date:   Tue, 17 May 2022 17:31:11 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8192: Add mediatek,pull-down-adv
 property
Message-ID: <20220517213111.22slqxqhbaxc22f6@notapiano>
References: <20220429200637.2204937-1-nfraprado@collabora.com>
 <4adf790c-5773-a78e-3c8e-2a510e3dbd1e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4adf790c-5773-a78e-3c8e-2a510e3dbd1e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:31:52PM +0200, Krzysztof Kozlowski wrote:
> On 29/04/2022 22:06, Nícolas F. R. A. Prado wrote:
> > Add the mediatek,pull-down-adv property to the pinctrl-mt8192 dt-binding
> > to allow configuring pull-down resistors on the pins of MT8192. It is
> > the same as in mt8183-pinctrl.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > 
> >  .../devicetree/bindings/pinctrl/pinctrl-mt8192.yaml   | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
> > index c90a132fbc79..e462f49eae6f 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
> > @@ -117,6 +117,17 @@ patternProperties:
> >              $ref: /schemas/types.yaml#/definitions/uint32
> >              enum: [0, 1, 2, 3]
> >  
> > +          mediatek,pull-down-adv:
> > +            description: |
> > +              Pull down settings for 2 pull resistors, R0 and R1. User can
> > +              configure those special pins. Valid arguments are described as below:
> 
> Trailing ':' should be escaped, so '::'

OK.

> 
> 
> > +              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
> > +              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
> > +              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
> > +              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            enum: [0, 1, 2, 3]
> 
> It's okay, but for all these and other values (you have few such in the
> binding), you should maybe add header and defines. It's much more
> readable for humans...

OK. I'll look into adding defines for these.

> 
> Is the property valid without bias-pull-down?

Actually it doesn't really make sense to set this property together with
bias-pull-down, as they set conflicting register settings for the pin bias...
I'll add a condition to avoid both being present.

Thanks,
Nícolas

> 
> Best regards,
> Krzysztof
