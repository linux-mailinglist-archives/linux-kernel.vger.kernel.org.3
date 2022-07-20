Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9AD57C0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiGTXjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGTXjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:39:10 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C000649B42;
        Wed, 20 Jul 2022 16:39:09 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id 125so148879iou.6;
        Wed, 20 Jul 2022 16:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lb6X3LLhxQpqyGQLth/kNVm94pHi43Px3THDwjaav0k=;
        b=O8FdA995V3ik0y5Zs0qK5r2J32dgC+1UhCnxzhhkaGS0+GijAaH8Vx9VkuqnXVdah7
         Cn6GCJqV1lXRek9JfM6pSSJPrExAMBWAfwpzbYl52CajT9G3IphyPO3O2SUMKYrLpD0o
         DGkOjTO0gCS7OnhOgF1HffZifDg++22h/iYkoHZUDVp3cb/V6q0aSiUpkJPBxCF+ijH5
         L34a9ZHjz4zRea9ynjhNB/LoqXr25Z3S4wmS3qVshpaZnqVfFVdiy+uRi/cbcY+sZty5
         +ZZfvpaPZ0sUqdOqIhjgyaUMWaarjxqk/lQe1QcdWURKjiQbQbDwWWUBSoJnZ865ygfN
         Ozmg==
X-Gm-Message-State: AJIora/FKSW/QszzztY+5Fz+7PygwrDC8zmAZw1+1L3t9wMknZyaSgG8
        QcszQDL3YRGSaILuo1WEAgk9FYseeg==
X-Google-Smtp-Source: AGRyM1vQa0Gvbtc/zVLTBqAc6iU4EThzGOxFo0GOODM1j7h0Qj40cOQ5/VRTBDR5CkDGrIOuQHayPw==
X-Received: by 2002:a05:6602:2ccf:b0:67b:e772:a7a2 with SMTP id j15-20020a0566022ccf00b0067be772a7a2mr12704835iow.109.1658360349008;
        Wed, 20 Jul 2022 16:39:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r27-20020a02b11b000000b0033e9c4c6a9esm112748jah.82.2022.07.20.16.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 16:39:08 -0700 (PDT)
Received: (nullmailer pid 1321 invoked by uid 1000);
        Wed, 20 Jul 2022 23:39:06 -0000
Date:   Wed, 20 Jul 2022 17:39:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, nm@ti.com,
        kristo@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.c, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 04/14] regulator: dt-bindings: tps65219: Add
 power-button property
Message-ID: <20220720233906.GB4187584-robh@kernel.org>
References: <20220719091742.3221-1-jneanne@baylibre.com>
 <20220719091742.3221-5-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719091742.3221-5-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:17:32AM +0200, Jerome Neanne wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Add a power-button property to configure the EN/PB/VSENSE pin as a
> powerbutton.

Belongs in the first binding patch.

> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---
>  Documentation/devicetree/bindings/regulator/ti,tps65219.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> index 6a60e62a313c..3f7f4c0280c3 100644
> --- a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> +++ b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> @@ -36,6 +36,11 @@ properties:
>        include/dt-bindings/interrupt-controller/irq.h
>      const: 1
>  
> +  power-button:

ti,power-button

Though doesn't 'system-power-controller' imply this?

> +    type: boolean
> +    description: Optional property that sets the EN/PB/VSENSE pin to be a
> +      power-button.
> +
>  patternProperties:
>    "^buck[1-3]-supply$":
>      description: Input supply phandle of one regulator.
> -- 
> 2.17.1
> 
> 
