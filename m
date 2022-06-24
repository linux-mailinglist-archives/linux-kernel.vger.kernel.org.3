Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE98D55A01F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiFXR1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiFXR0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:26:54 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2012A725;
        Fri, 24 Jun 2022 10:26:48 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id r133so3399192iod.3;
        Fri, 24 Jun 2022 10:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=vaHHEauVvqkMWfLMfHxzFvsc9NwJ8Elmx8AaWGts9VE=;
        b=Bj9LRq4L8uB1RVMnmz5fw/iPvuxMrvnCr6xKyB29bNmdoDq5VRDtIxsie77Ob4O9GW
         FiiZVc+UHlo8uFoJRWJ8kqVUR441HZMQ3lZSPTRR5kNBvcI3HySOyTl5Bj5kzAUFQKQ2
         PgCHuN7ilQkj41KZwW6FZbp3xfLjL6ZUoeLDsYvWdLRhmZA4dApSgekidTrYd+27rR56
         oPjL4b+YHVwHCRc7RtXCkqUV46WZ8Zeos98bJ56haPEk9YedfAOdtXgw1imfI0syjVwu
         T9d5ZYNd6+Zz7ONpAGRZdEv24358Ki9HY/UCKFzX1FEsR3xYXdStHEgeGnH8OghZxZ5f
         +46A==
X-Gm-Message-State: AJIora8tx/NdbkoI/kzOAiaSEE/POnuj31CcVDG9ebyEOL8hZudkw5pi
        LqJUXAe8HAT3ZZ2mSqppevHU5p6QCw==
X-Google-Smtp-Source: AGRyM1vRutqEr41mUsHKGNxNx022yDHkG7fL3mpUC1VA5ARhOw6PzXDJLvpfjiu0/6t7pZQ6SdELnw==
X-Received: by 2002:a02:c942:0:b0:339:ec11:d04e with SMTP id u2-20020a02c942000000b00339ec11d04emr154237jao.174.1656091607954;
        Fri, 24 Jun 2022 10:26:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d8041000000b00674f9fb1531sm1433314ior.30.2022.06.24.10.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:26:47 -0700 (PDT)
Received: (nullmailer pid 146346 invoked by uid 1000);
        Fri, 24 Jun 2022 17:26:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20220624111325.96478-1-krzysztof.kozlowski@linaro.org>
References: <20220624111325.96478-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: leds: lp50xx: fix LED children names
Date:   Fri, 24 Jun 2022 11:26:34 -0600
Message-Id: <1656091594.405509.146345.nullmailer@robh.at.kernel.org>
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

On Fri, 24 Jun 2022 13:13:25 +0200, Krzysztof Kozlowski wrote:
> The lp50xx LEDs expects to have single-color LED children with unit
> addresses.  This is required by the driver and provided by existing
> DTSes.  Fix the binding to match actual usage.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Fixes: dce1452301e7 ("dt: bindings: lp50xx: Introduce the lp50xx family of RGB drivers")
> ---
>  Documentation/devicetree/bindings/leds/leds-lp50xx.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-lp50xx.example.dtb: led-controller@14: multi-led@2:#size-cells:0:0: 0 was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

