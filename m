Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA2A539892
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347936AbiEaVTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347946AbiEaVTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:19:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460359D4DD;
        Tue, 31 May 2022 14:19:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id C06CA1F43F0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654031966;
        bh=68k5y0jKYIIMSTFMtmsmSALMYTfSSep8zYGcyyvXciU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kB8pT4aFB5cbKdOyctjFzW6Hekmjw0u2cSQOLAshFZIQ0pRIK1muB9rFlcFy+4Yoc
         vJvJMBOOwvWF5XZXf9M0ZFg8p+6rVT2ZynREraW+MyNrqlI7HxyG/38GYV8g5S0Qpt
         wyMyBoiiYvZAzRMqvXaPnLiYgxEKFC6KahgxPsqaQVXffQ2t2OyZxtBma4piAMcRCJ
         pa70jEWdaBl/3kLXdVRkPZIEWg6cro/JU1n6IBaTNbQOs3aiAHXML92nrTuDF4YPoi
         WaCUyqnMxES1EOYtUjER5uKX655zDqtNhyxw8Kyq47+Eb0RRsEV/r9jZCPJ4WJjqjb
         06xP+NOEp36zw==
Date:   Tue, 31 May 2022 17:19:21 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 0/2] MT8192 pinctrl properties adjustments
Message-ID: <20220531211921.uhdd2exxv2uhic6x@notapiano>
References: <20220525155714.1837360-1-nfraprado@collabora.com>
 <74a6159b-40d0-bbc3-5b4a-ebf6ed98bac7@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74a6159b-40d0-bbc3-5b4a-ebf6ed98bac7@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 10:34:19AM +0200, AngeloGioacchino Del Regno wrote:
> Il 25/05/22 17:57, Nícolas F. R. A. Prado ha scritto:
> > 
> > The two patches in this series substitute properties in the mt8192
> > pinctrl dt-binding for ones which have a clearer meaning and are more
> > standardized. At this point there's no DT using the mt8192 pinctrl
> > binding, so if such changes are to be made, they need to happen now.
> > 
> > 
> > Nícolas F. R. A. Prado (2):
> >    dt-bindings: pinctrl: mt8192: Add drive-strength-microamp
> >    dt-bindings: pinctrl: mt8192: Use generic bias instead of pull-*-adv
> > 
> >   .../bindings/pinctrl/pinctrl-mt8192.yaml      | 58 ++++++-------------
> >   1 file changed, 18 insertions(+), 40 deletions(-)
> > 
> 
> Hey Nic,
> 
> As you know, I definitely agree with these changes, but they don't deserve
> to get any Fixes tag: backporting should be useless in this case... and you
> anyway aren't fixing a faulty binding.

Alright, I was on the fence on this one, but I can drop the tags for v2.

Thanks,
Nícolas

> 
> Cheers!
> Angelo
