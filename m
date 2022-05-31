Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682F95399B9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348554AbiEaWrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348400AbiEaWrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:47:00 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FFDA466;
        Tue, 31 May 2022 15:46:58 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f2a4c51c45so355449fac.9;
        Tue, 31 May 2022 15:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=AE9Fbrj6BPIXSH+6mmzzM5HJbPbBIVW+lbxzy622FhY=;
        b=FC7YLCXVp+3Ey9OIsvgjO8KDG576KFeauHlGw9t9IKSPQoYy+B6Ehbg9N7Ys8Qmj2b
         LmcAk4uBcXej5lFY3eJX00+fNT8nCYwM/FRlLQfSW+e63Gm5Ym6KP9OzTPCEBOOS4Nyb
         9zDQIgoWggBTkFJizFd/bNEYl5SFd/MmWq8FTMjpzoQchlx9V8rP/Wn/KsfApTRhgMSS
         LaPB5j8BSqzY4JQskTvNxp8wnrjQAM7K4YKN4W+xacuhXcIEcwiq4ZwFZ4MqP4kNam4g
         7BvXB8v5N932AluPgFhuJUMJPCODzVK25uYIeDByuuvShMa0raQfnf/DEX1Q0e4kpZxD
         VB+w==
X-Gm-Message-State: AOAM531mZzff7zTh95UL62AZHhRlpQ7yBeIKsHZgTgAJaKmDydXz1SO+
        k26Mv1kGjKXdj/z5e2B4Vg==
X-Google-Smtp-Source: ABdhPJz9hzTJNp12uYZ4vHIk6ZhMev4DpgOt2zBvhqRIr7g1l5auyN0vlOttAqh+FCiKDf2dw2zOIw==
X-Received: by 2002:a05:6870:b254:b0:ec:6ca4:c89f with SMTP id b20-20020a056870b25400b000ec6ca4c89fmr15083367oam.272.1654037217725;
        Tue, 31 May 2022 15:46:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u3-20020a056830248300b0060603221247sm7000503ots.23.2022.05.31.15.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 15:46:57 -0700 (PDT)
Received: (nullmailer pid 2476555 invoked by uid 1000);
        Tue, 31 May 2022 22:46:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     heikki.krogerus@linux.intel.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, pavel@ucw.cz, sre@kernel.org,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, linux-leds@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux@roeck-us.net,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        alice_chen@richtek.com, lee.jones@linaro.org,
        daniel.thompson@linaro.org, cy_huang@richtek.com,
        robh+dt@kernel.org, chiaen_wu@richtek.com,
        linux-fbdev@vger.kernel.org, jingoohan1@gmail.com, deller@gmx.de,
        linux-pm@vger.kernel.org, lars@metafoo.de
In-Reply-To: <20220531111900.19422-5-peterwu.pub@gmail.com>
References: <20220531111900.19422-1-peterwu.pub@gmail.com> <20220531111900.19422-5-peterwu.pub@gmail.com>
Subject: Re: [RESEND 04/14] dt-bindings: leds: Add Mediatek MT6370 flashlight binding
Date:   Tue, 31 May 2022 17:46:54 -0500
Message-Id: <1654037214.468113.2476554.nullmailer@robh.at.kernel.org>
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

On Tue, 31 May 2022 19:18:50 +0800, ChiaEn Wu wrote:
> From: Alice Chen <alice_chen@richtek.com>
> 
> Add Mediatek MT6370 flashlight binding documentation
> 
> Signed-off-by: Alice Chen <alice_chen@richtek.com>
> ---
>  .../leds/mediatek,mt6370-flashlight.yaml      | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/leds/mediatek,mt6370-flashlight.yaml#

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/mt6370.yaml
Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml: Documentation/devicetree/bindings/mfd/mt6370.yaml

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

