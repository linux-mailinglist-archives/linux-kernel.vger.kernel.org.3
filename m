Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5F454C9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345442AbiFONVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbiFONVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:21:09 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839C938185
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:21:08 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3137c877092so60371357b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lLnEeD4HScX3wYTfaLfMTcXpGRNYwxAv7p4Jh61bcKg=;
        b=FAuYV82HbMz5SF8Z7r8LjZLY8Js1QZM8S6JoU4BP+yJW+/cPQITzEEsuzeuUPSFqbj
         cknm9RkZLDfM8pCMnBfGKMOBmpD2wRin39gPIaa4Wc0vF7A53qjSrsZNQYrQW2+63eHX
         /j64PsFHZlvSTFVpZgAvXiKd1MwQG2DwDHeYDWj9MJChIz4j4yj0G4AnzHd5R2/bXDGI
         p9AsvC5FJauhwdgFjUWfPZQWEKVUmpu7mcN/qvaaFutjh4y7Rfut/oK46cqLoiFv8Y3b
         PN6bs6TaE7EVVLE5vSJ1YBHMildxFf+0mCBB9DOccscXnPGY9tgcod5a+h/I5WzQVjNF
         NHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lLnEeD4HScX3wYTfaLfMTcXpGRNYwxAv7p4Jh61bcKg=;
        b=2AVG2jY2mzRIZbaIpm0gJaIgf7R/KcbJgksH/oZgMIlGy3bHz0lFJ7ncHG5uA+4HNO
         /UTc1sYHCC8t/T7nLFdXXwJP/z/aHHiGGDmjEXckAq5ilBpxKlXtjz0RLCQj/M9XtjeF
         WL9qBkeaMZ2lZteZ101KVkgv+EpTftXl4dzOAYzxHN475SLopJ0ojL2F7b339RP9OCeJ
         yEQlnFKIz5RqFp5oh47fArh+cRrA0lbSZDcuDAhU5FKDQoPCYxJD6GxdhemWbYkQyChY
         46UHkMDnCKYm5lTrh+RkURKAOFe4hetIPzvbapn/+CwCBp3nQ/u8Uwz328SLzsJgKfxF
         8TsQ==
X-Gm-Message-State: AJIora/oapmbi6P4ML973AYGXuhRtUkAhB81C5TeHgiOniM/lzvGK2eB
        kIoGjKyCzPieo1uWMXAjsybGK9Pyu1e7yiszFsrtAw==
X-Google-Smtp-Source: AGRyM1sWoBtACZMnUE5e9euq2R2bCswy4VmCdrOftup15FaJJZ5F8vphDQM3yFswuCusR6wCSWVBJAXvAZQH0EVE5QA=
X-Received: by 2002:a81:a00b:0:b0:30c:5c1a:19f with SMTP id
 x11-20020a81a00b000000b0030c5c1a019fmr11566849ywg.437.1655299267750; Wed, 15
 Jun 2022 06:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220525155714.1837360-1-nfraprado@collabora.com> <20220525155714.1837360-3-nfraprado@collabora.com>
In-Reply-To: <20220525155714.1837360-3-nfraprado@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jun 2022 15:20:56 +0200
Message-ID: <CACRpkdZL6SAHWgOjcJ=D-fjTwYL4ctgo4Tbre3QwPKSTpzPs4g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: pinctrl: mt8192: Use generic bias
 instead of pull-*-adv
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 5:57 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:

> Commit cafe19db7751 ("pinctrl: mediatek: Backward compatible to previous
> Mediatek's bias-pull usage") allowed the bias-pull-up and bias-pull-down
> properties to be used for setting PUPD/R1/R0 type bias on mtk-paris
> based SoC's, which was previously only supported by the custom
> mediatek,pull-up-adv and mediatek,pull-down-adv properties.
>
> Since the bias-pull-{up,down} properties already have defines associated
> thus being more descriptive and is more universal on MediaTek platforms,
> and given that there are no mediatek,pull-{up,down}-adv users on mt8192
> yet, remove the custom adv properties in favor of the generic ones.
>
> Note that only mediatek,pull-up-adv was merged in the binding, but not
> its down counterpart.
>
> Fixes: edbacb36ea50 ("dt-bindings: pinctrl: mt8192: Add mediatek,pull-up-=
adv property")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Patch applied.

Yours,
Linus Walleij
