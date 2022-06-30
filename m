Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1135156250E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiF3VWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiF3VW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:22:29 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177E04D157;
        Thu, 30 Jun 2022 14:22:29 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id p9so212209ilj.7;
        Thu, 30 Jun 2022 14:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T4909o+ZJwgi1L8MENIjc0OE7vRQ1YbJuBfUhGjWQ1Y=;
        b=X8pUNAquAXfSF/uIdQO/a2jFB2pKta48hmSBJ7I+sX3P3PoIFYLYf8dOX46bm2N9fp
         ODNn9jmEg2AQQn42m0nS2ks/IvwS/PL6TAa92R9Kfc6qHvWn2jOtNOQHXD+XD4Do5H9S
         wrm5ovy20+TSiUSqhSpe9XR3gu6ioR7cYhYi2yhvH8XAxdXllu2HhjjNJAQ5gSMLMOJd
         vSwa24OqYbCYaN+jp4+IPMCa0T9pCb9tHHuHxxUcRwdL/0gyh4mSgBksKC+14L+uO0lq
         rhI/5e0TwRJFitI+MYk3Q249AP2sXnh68X1R69AxJv8lLEobLE0fEBUdMEH+QQyRqeeN
         /pxg==
X-Gm-Message-State: AJIora/Nkvei6StRl5rwJcl8CY7ADuVWCd/nDHWVvZMwO6tIyIIQK0MD
        4q8h9/KXBm+dHSNMcxN8Og==
X-Google-Smtp-Source: AGRyM1tUHkRznlT3Zwq7RVA5PUw0xyPJTRlCsDeBnrR2kcY+djt+IfRnZuYf80Z7Nv6TfFTCt9EuSA==
X-Received: by 2002:a92:d5cf:0:b0:2d1:d9b0:d5b1 with SMTP id d15-20020a92d5cf000000b002d1d9b0d5b1mr6199947ilq.252.1656624148343;
        Thu, 30 Jun 2022 14:22:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m4-20020a924b04000000b002d3edd935e5sm8402748ilg.53.2022.06.30.14.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:22:27 -0700 (PDT)
Received: (nullmailer pid 3323810 invoked by uid 1000);
        Thu, 30 Jun 2022 21:22:26 -0000
Date:   Thu, 30 Jun 2022 15:22:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, matthias.bgg@gmail.com, sean.wang@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org, nfraprado@collabora.com,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8195: Add and use
 drive-strength-microamp
Message-ID: <20220630212226.GA3323748-robh@kernel.org>
References: <20220630131543.225554-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630131543.225554-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 15:15:43 +0200, AngeloGioacchino Del Regno wrote:
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
> 

Reviewed-by: Rob Herring <robh@kernel.org>
