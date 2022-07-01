Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BDD563C26
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiGAWEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiGAWEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:04:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37EB5A467;
        Fri,  1 Jul 2022 15:04:12 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6321266016D9;
        Fri,  1 Jul 2022 23:04:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656713050;
        bh=FS8tHQQbEegKqv0OZKb+CidvdIdHGPU9aGVYrYy84Bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDeAqTDdKBq9w9PKOo5APAaJRkM442HanA7T45CaCWWp82p7InVtQOceYpZrCFqsQ
         EyPfmpGQ/P5jugbjirM98XD9/OWPZMpphSYFS+oVcOQbowVj7OcniOWGEopP2HcCL3
         SDmAX00W2lcJHciYY6sucsAnhLyNR7vdLhFNDdYqNu/WpFDLs4clzNuJFkzomiylm3
         ADhkbZ4IPyFjNd641IsaGIrlPWzApc/b525SbrFjlPUC4lss3iN8kIeUiYgZWnA3jb
         K3dc8KMeM06rgEoPOMjUR1ykAezPMkWsM5tiu2Fvl0OHJ7A5S9+dq4OKPyEuSS3/Wk
         pyjjdNMS4lm3Q==
Date:   Fri, 1 Jul 2022 18:04:02 -0400
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
Message-ID: <20220701220402.v4g6u75mzptb2fly@notapiano>
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

Though r0 is not added in this series?

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

Angelo, this patch is depending on the patch from the asurada-spherion series
[1] to apply. Since this isn't the case for patch 2 as well, I assume this was
a mistake. And it does seem better to keep them independent.

[1] https://lore.kernel.org/all/20220629155956.1138955-2-nfraprado@collabora.com/

Thanks,
Nícolas

> +      - description: Google Tomato (Acer Chromebook Spin 513)
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
