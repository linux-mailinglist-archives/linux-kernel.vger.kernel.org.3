Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D438502BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354475AbiDOOfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344879AbiDOOfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:35:11 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6F32E6BC;
        Fri, 15 Apr 2022 07:32:43 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id r85so3353028oie.7;
        Fri, 15 Apr 2022 07:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=PWkFmsh5Xu4+fKnCCwdt0tVV4sCcc9ioI4xTfndA/mQ=;
        b=uRbEX1smBihFX6vWqUoftP9cvyM7tZs1s86jC4+u2D6RKOgRY7Sg4ehNBG3yHaEr+N
         zp+7KjP5E5NLLOSv3x4c9e9iYtHX+qRIEf8jPwK1pOup685X/kMRTnIZdOcnaM8riyN/
         V9htAquK3GFg9Ue9Yw5A/9Xtib2IxBs9iaAHZ0u1DFOkOlp/hI9KWgqDtv0cMooDr7pD
         7f5S1Bp6aDCdZEUsfjWvBiD2BQkFEvZ60Uk1T+lZXfvBqX/3N6OB3lTpEZlPg0wy4c4A
         yPudZJG4vR/ZudGZguB3Ztk1x1hSez23IdkwADBagIVZyBaqUMpA2GJ7upQcV96o2YfU
         OiUw==
X-Gm-Message-State: AOAM533aEMldptddOKRh5+k6WfBTkcTbHjYel7D8MjXaHULSZlBdtCep
        SgUcxIbi8kEVGbeg4S5/bw==
X-Google-Smtp-Source: ABdhPJyIHQEfmVJhe8R8epLhEwBEi+YFfcMZyMoMZDbG+RnujEOdN/75D+3Psr7DA3LmCirjREEBtw==
X-Received: by 2002:a05:6808:199d:b0:2fa:2f20:7212 with SMTP id bj29-20020a056808199d00b002fa2f207212mr1742895oib.251.1650033162752;
        Fri, 15 Apr 2022 07:32:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a056830290300b005b2316db9c9sm1105553otu.30.2022.04.15.07.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 07:32:42 -0700 (PDT)
Received: (nullmailer pid 251786 invoked by uid 1000);
        Fri, 15 Apr 2022 14:32:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, phone-devel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220415110014.7384-3-markuss.broks@gmail.com>
References: <20220415110014.7384-1-markuss.broks@gmail.com> <20220415110014.7384-3-markuss.broks@gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: mfd: Add bindings for Silicon Mitus SM5703 MFD
Date:   Fri, 15 Apr 2022 09:32:41 -0500
Message-Id: <1650033161.773468.251785.nullmailer@robh.at.kernel.org>
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

On Fri, 15 Apr 2022 14:00:11 +0300, Markuss Broks wrote:
> This patch adds device-tree bindings for the Silicon Mitus
> SM5703 MFD.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../bindings/mfd/siliconmitus,sm5703.yaml     | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
schemas/regulator/siliconmitus,sm5703-regulator.yaml: ignoring, error parsing file
Error: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.example.dts:28.39-40 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

