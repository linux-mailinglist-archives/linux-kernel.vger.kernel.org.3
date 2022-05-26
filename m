Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1553487F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbiEZB7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345897AbiEZB6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:58:54 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B766BCE91;
        Wed, 25 May 2022 18:58:50 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-f1d5464c48so678973fac.6;
        Wed, 25 May 2022 18:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u1k8n/bnMYLdf6Ge4xddMp84AvG888eR8uyJpk19AXI=;
        b=zy2FUOExz4TusGKVBn4/T4GZ9APONZf4lrp+bXvQ9oHs4OBT22jZvKA4ztFmfVGTaY
         WAcUYgFvjlFE3iM9heH9oz1H9yVXO9iK8T/MyTBwHbb5PxTKE4TIY3gtALyon9lihwVH
         3jnFLAuZRv9qb7eja9vAJylwReZYmLwddsCarUt0XCuo/PTmfV4HkcNILHfi76/cr7MZ
         fb1ZovQCEXv6WyBh6rXOl32Q7sVk/GlJHOwAGICLvkuYR3e0dIvyPZ3H3ZlOhfJuhcJ3
         l4+9nFWHxql3tcuxb5Yqrpl07HAUpYH3E4qT4hQT4EEg6RoxJbNR9cwZamYZG07Jpy5A
         N9Ug==
X-Gm-Message-State: AOAM530BOdL3W1cA8378+9Bv+BtQj//QWMbAO1zduiHf2N8RZKvmSo9+
        lY4BzUvj8n1JN8pv/0ER2Q==
X-Google-Smtp-Source: ABdhPJwm0i+e0VsW1YFMx88HUodQOXevLnzV1/8atr9allVCR9Q5IuKOcmK9q2gmX2vgMB5I2FGcjw==
X-Received: by 2002:a05:6870:ea8d:b0:e6:135c:1a2e with SMTP id s13-20020a056870ea8d00b000e6135c1a2emr25954oap.9.1653530329601;
        Wed, 25 May 2022 18:58:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 25-20020a544199000000b0032aea9c2c23sm193918oiy.40.2022.05.25.18.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:58:49 -0700 (PDT)
Received: (nullmailer pid 2898004 invoked by uid 1000);
        Thu, 26 May 2022 01:58:48 -0000
Date:   Wed, 25 May 2022 20:58:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 2/2] dt-bindings: pinctrl: mt8192: Use generic bias
 instead of pull-*-adv
Message-ID: <20220526015848.GA2897970-robh@kernel.org>
References: <20220525155714.1837360-1-nfraprado@collabora.com>
 <20220525155714.1837360-3-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525155714.1837360-3-nfraprado@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 11:57:14 -0400, Nícolas F. R. A. Prado wrote:
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
> Fixes: edbacb36ea50 ("dt-bindings: pinctrl: mt8192: Add mediatek,pull-up-adv property")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>  .../bindings/pinctrl/pinctrl-mt8192.yaml      | 29 ++++++++++---------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
