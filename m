Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA8A5762FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiGONnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiGONnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:43:02 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F8F7E006;
        Fri, 15 Jul 2022 06:43:01 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id z132so3906892iof.0;
        Fri, 15 Jul 2022 06:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=03wcnwqW6SswNVSW3NYFh+nPKkFyDcywCPMc3nrTTzo=;
        b=TdH2JtsYB6QRHzBN/92KFqwdGYKhHjdyXCuZM2aotId2+++XH3D5mX4a+RmDrIHJRF
         U4WJ9tIylHXl9VKUOX+NGL0TfB5FLrH9wpgzuy5jCNZP3Bp1MvzEIyGmLVFCqex+W12A
         uUfauLWZrk6jRc/cI9hyxAyiHbFvvnWXIUSlZ2tWlV/osLK4UY2HQ8WDYbbXKS1RXVzk
         n9QIzRg0xTloij76/vYsdCDaR38UuSPuRM2MVjLNdufq4oovPcj8Zb1+4HM8a5lorraU
         Vg8TpjKC53Hv9mK2T4PgQmtUAKxEGVQiH/a2spjezQg9AWtDY4PZHNiK4mpFgvQQ7FTu
         8jZA==
X-Gm-Message-State: AJIora/9WOi3jRjfzDpdyk4s5MK2mprVAmOXui7m4wYtI7++wX9Ubv8G
        yMtc6M7C56PWWWEK8sF3MQ==
X-Google-Smtp-Source: AGRyM1uzHWN8yj4iBWno2bNl4tSBHdD45HjKJL19BAJUQTQyoHWpBthV9k3/tF7H+HVOqQ0U4hzPtA==
X-Received: by 2002:a02:ac0a:0:b0:33f:713a:9589 with SMTP id a10-20020a02ac0a000000b0033f713a9589mr7633647jao.289.1657892580691;
        Fri, 15 Jul 2022 06:43:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g7-20020a92dd87000000b002dc789a3dddsm1703976iln.5.2022.07.15.06.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 06:43:00 -0700 (PDT)
Received: (nullmailer pid 520291 invoked by uid 1000);
        Fri, 15 Jul 2022 13:42:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        lee.jones@linaro.org, heikki.krogerus@linux.intel.com,
        broonie@kernel.org, cy_huang@richtek.com, deller@gmx.de,
        linux@roeck-us.net,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        szunichen@gmail.com, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        linux-fbdev@vger.kernel.org, jingoohan1@gmail.com,
        chunfeng.yun@mediatek.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, pavel@ucw.cz, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, lars@metafoo.de, alice_chen@richtek.com,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        sre@kernel.org, chiaen_wu@richtek.com,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20220715112607.591-7-peterwu.pub@gmail.com>
References: <20220715112607.591-1-peterwu.pub@gmail.com> <20220715112607.591-7-peterwu.pub@gmail.com>
Subject: Re: [PATCH v5 06/13] dt-bindings: mfd: Add MediaTek MT6370
Date:   Fri, 15 Jul 2022 07:42:55 -0600
Message-Id: <1657892575.865405.520290.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 19:26:00 +0800, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add MediaTek MT6370 binding documentation.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt6370.yaml   | 280 +++++++++++++++++++++
>  include/dt-bindings/iio/adc/mediatek,mt6370_adc.h  |  18 ++
>  2 files changed, 298 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: pmic@34: indicator:multi-led@0:led@0: Unevaluated properties are not allowed ('reg' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: pmic@34: indicator:multi-led@0:led@1: Unevaluated properties are not allowed ('reg' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: pmic@34: indicator:multi-led@0:led@2: Unevaluated properties are not allowed ('reg' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: indicator: multi-led@0:led@0: Unevaluated properties are not allowed ('reg' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: indicator: multi-led@0:led@1: Unevaluated properties are not allowed ('reg' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: indicator: multi-led@0:led@2: Unevaluated properties are not allowed ('reg' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

