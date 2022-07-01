Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C645636F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiGAPbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiGAPbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:31:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CC1D11D;
        Fri,  1 Jul 2022 08:31:19 -0700 (PDT)
Received: from notapiano (unknown [193.27.14.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5210F660194C;
        Fri,  1 Jul 2022 16:31:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656689478;
        bh=z052kP4hfB8gSwGmauqevNpl/h4dfkQWDsl3Df3UJEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ie+CqVG7TZ1FdMjN8qXgzQKJ5XPLxMvIDk5BuEFxgGtv7A1mgat8nsFLiRVWMw6L8
         bnkTSzr8FRMZZtWQc+ywHUngWZFgurCK/Ysq7DxkQyCe0/b8GnDZuunLAaHfxMDQqT
         xogXa0h7rNiWHWmw/GtwTZh8fiTHpVdQJtCEKxQc4+VEp7X9h/rR5mg8s3fzBzWUQt
         PhGunL8AAgW8aHMu2T1PPm1bJf+9P2teAWWHlJVLgGD+rS5Nsd/ZCHW1Oz08bJEUhf
         RWTq3HaC0CcFe12HXJ63XtMvnshZzbvMzuUb7C1tIlkQ9aV9P2+v8gFV8O4cvEVDSJ
         FC7YVe2eafc8g==
Date:   Fri, 1 Jul 2022 11:31:11 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        allen-kh.cheng@mediatek.com, gtk3@inbox.ru, luca@z3ntu.xyz,
        sam.shih@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: Re: [PATCH 01/11] dt-bindings: arm: mediatek: Add MT8195 Cherry
 Tomato Chromebooks
Message-ID: <20220701153111.glbd6gophzipwtjk@notapiano>
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
 <20220630153316.308767-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220630153316.308767-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:33:06PM +0200, AngeloGioacchino Del Regno wrote:
> Document board compatibles for the MT8195 Cherry platform's
> Tomato Chromebooks, at the time of writing composed of four
> revisions (r0, r1, r2, r3-r4).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index dd6c6e8011f9..3e0afa17ed2e 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -144,6 +144,19 @@ properties:
>            - const: google,spherion-rev0
>            - const: google,spherion
>            - const: mediatek,mt8192
> +      - description: Google Tomato (Acer Chromebook Spin 513)

Hi Angelo,

searching for "Acer Chromebook Spin 513" I found that there are two different
chromebooks:

https://www.acer.com/ac/en/US/content/series/acerchromebookspin513
https://www.acer.com/ac/en/GB/content/series/acerchromebookspin513cp5132h

The first one is a Qualcomm based one, while the second is mt8195-based, so I
assume that's Tomato.

They can be telled apart by the model name though: the Qualcomm one is
"CP513-1H", while Tomato is "CP513-2H". So I suggest to add the "CP513-2H" here
in the description, as well as in the cover letter, to avoid confusion between
the two.

Thanks,
Nícolas

> +        items:
> +          - enum:
> +              - google,tomato-rev2
> +              - google,tomato-rev1
> +          - const: google,tomato
> +          - const: mediatek,mt8195
> +      - description: Google Tomato (rev3 - 4)
> +        items:
> +          - const: google,tomato-rev4
> +          - const: google,tomato-rev3
> +          - const: google,tomato
> +          - const: mediatek,mt8195
>        - items:
>            - enum:
>                - mediatek,mt8186-evb
> -- 
> 2.35.1
> 
