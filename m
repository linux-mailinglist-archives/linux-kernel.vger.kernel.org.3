Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0F7576A8D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiGOXUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiGOXUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:20:43 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD64491CF7;
        Fri, 15 Jul 2022 16:20:42 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id p81so5030231iod.2;
        Fri, 15 Jul 2022 16:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=357WJpKqK4n072gUDP2xO7EDnU9lyZF13OaAt7W+XvU=;
        b=2t71NgR3qCQ7mEg9vO0bZm0xoEmgVwYgvDYvOJOL81usXcQonEb/Nhn9ePoRqWLLgN
         ZA4CPj7Fu3naAjgN+ohG+7eXJBm4paugOdCxqdcs0ypljFPoozSfrv61m8P7YCd6gp8x
         BGeftFLZBOyftqo/jIlfuNTDa66VoChcUaPYOMpP+noOc9uNpcwl00U7YCVB0F5OPDyw
         jin0hMhlQ9xXj3mSiWuroP631L+P7VNGi1R3LEzYBLUcZ4SLw2jANYqBjlRdRIp0HgRi
         6lHfEB9+Y2wnmCiJ0D/7a3f6vdfs1S2e1oSEcsBd/mmr23CvdE6APylCq3O6C0vKdT+D
         K71g==
X-Gm-Message-State: AJIora9Y9iasRHZx5PIrjBIipFP7l/L1iCA/9KoLD2DTkE8poatBP5Zs
        vaSym2XNsf8nXXNqnlf/HA==
X-Google-Smtp-Source: AGRyM1tQ46xHJYDafNFQLDzbX9yaXJPf1IJ35ZWUtezEz3nl7DXHI+lRSk0NX8wn7O6/zhUIHiuMjg==
X-Received: by 2002:a6b:ed14:0:b0:675:9593:483e with SMTP id n20-20020a6bed14000000b006759593483emr7665689iog.65.1657927241909;
        Fri, 15 Jul 2022 16:20:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k7-20020a02c767000000b003415545d938sm600126jao.166.2022.07.15.16.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 16:20:41 -0700 (PDT)
Received: (nullmailer pid 1651421 invoked by uid 1000);
        Fri, 15 Jul 2022 23:20:39 -0000
Date:   Fri, 15 Jul 2022 17:20:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, nfraprado@collabora.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8195: Use
 drive-strength-microamp in examples
Message-ID: <20220715232039.GA1648171-robh@kernel.org>
References: <20220715103029.204500-1-angelogioacchino.delregno@collabora.com>
 <1657892575.852530.520283.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657892575.852530.520283.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 07:42:55AM -0600, Rob Herring wrote:
> On Fri, 15 Jul 2022 12:30:29 +0200, AngeloGioacchino Del Regno wrote:
> > The property mediatek,drive-strength-adv was deprecated: change the
> > example for i2c0-pins to use drive-strength-microamp.
> > 
> > Fixes: b6d9af2c6b69 ("dt-bindings: pinctrl: mt8195: Add and use drive-strength-microamp")
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> >  Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.example.dtb: pinctrl@10005000: i2c0-pins:pins: 'drive-strength-microamp' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml

Seems to be a false positive since commit b6d9af2c6b69 was not present 
in the test.

Acked-by: Rob Herring <robh@kernel.org>
