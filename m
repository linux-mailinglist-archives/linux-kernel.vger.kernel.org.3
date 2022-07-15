Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351485762F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiGONnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiGONm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:42:59 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A927E006;
        Fri, 15 Jul 2022 06:42:58 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id b12so2533980ilh.4;
        Fri, 15 Jul 2022 06:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Z/R62/XfNcQVMTmrWk/l/EPI5fVciSHdC92bX/2kpIY=;
        b=jJbljiworMyciHluGiL8Q28bSp2pIKAdj4leK9XkzzDTw6nW4gUBv6aLWlPhKGUGTP
         xAWG3conD30TK5OJehHDabFXpdJ2UEBzUfmc/Quk+jo8m2FKJ4BkiId+rSm/qgrcXuQw
         /yGx08nlxqay5SpC9bo8wiSM3lLVL9ondqmuyfcanqFSpCJZAKk+6zoXWGIYu0ahAu9f
         Qf7TZ4IKcrx0C7nacAOSguCc0iPO413loyeM1BRxtzU0KYVa+WJRH/ZRh1yo2T15gOFW
         7LdSeyLi7qLMlJxGFxTh4qUu5vxpNEvps8bjr+eYKxeN+damSYiSisVZJtDRGt+j0Gjm
         d+jw==
X-Gm-Message-State: AJIora+fyXVST+y+ZJxKYXIMWjCE8Bybd59LT1C2cCMum+7tmeNP2X3H
        +HvkzzPW9u0m2TnogA8g8w==
X-Google-Smtp-Source: AGRyM1t6a5kEHo4Mrc8T7zv8UWHhMBbeNMJMzSeheyHsBVb7d5Xbopp9RO//FMCnNa5ZX4G7S8lRpw==
X-Received: by 2002:a05:6e02:1b85:b0:2dc:c1c5:c444 with SMTP id h5-20020a056e021b8500b002dcc1c5c444mr1423250ili.81.1657892577669;
        Fri, 15 Jul 2022 06:42:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g7-20020a05663816c700b00335d7c314b1sm1939544jat.53.2022.07.15.06.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 06:42:57 -0700 (PDT)
Received: (nullmailer pid 520284 invoked by uid 1000);
        Fri, 15 Jul 2022 13:42:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, nfraprado@collabora.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220715103029.204500-1-angelogioacchino.delregno@collabora.com>
References: <20220715103029.204500-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8195: Use drive-strength-microamp in examples
Date:   Fri, 15 Jul 2022 07:42:55 -0600
Message-Id: <1657892575.852530.520283.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 12:30:29 +0200, AngeloGioacchino Del Regno wrote:
> The property mediatek,drive-strength-adv was deprecated: change the
> example for i2c0-pins to use drive-strength-microamp.
> 
> Fixes: b6d9af2c6b69 ("dt-bindings: pinctrl: mt8195: Add and use drive-strength-microamp")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.example.dtb: pinctrl@10005000: i2c0-pins:pins: 'drive-strength-microamp' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

