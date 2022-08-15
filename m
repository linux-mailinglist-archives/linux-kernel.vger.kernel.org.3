Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A46D593065
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242489AbiHOOBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiHOOBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:01:52 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA6220C6;
        Mon, 15 Aug 2022 07:01:51 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id mk9so5383918qvb.11;
        Mon, 15 Aug 2022 07:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=dKfzpcSJcyLaUeyLXairrh0uvdiYsvVZa/B4hAX3xzE=;
        b=ruJny7kPNGTZt2cVQJSFUU66WH7m0vXI1oBJEJwoBHPht/RLmwD7kNRYxlGldODBJh
         GL1aH7qwIcZbQlNgpQTRHYbiKFSeK3AOA2UbL879cxznR0gI7fHXl0FeIyOywNj+jxjI
         S5TYYXdM5d6tbfMjKkt6/sxIVivRZUtIqyRMUWmqf9B++NfJ6ml71Qh1b66WeTq+4shX
         xaIDtcCZIX9BHTtCOR3WmZrr8K6I8Hsi/TPvFhCEwTndC82iwpXO/Vd7XbkBXYAB9ZjB
         6Zyc1XRB/nhT+p/JSFRmyBTJU3d7A9pw+X0c5Bu6baIvYdiw7uiChnaolV3CLji0oEjx
         e00w==
X-Gm-Message-State: ACgBeo3MCST4Sl92Dhawe6wEKsQvH6npAyyFJwZgTYWEtm6IkI+obzOq
        zs8i2GImHoV3gf6+BzK/1g==
X-Google-Smtp-Source: AA6agR5+zNDBXvl94ryaYajiHWUcq2LRnBtS5fKnVsr31dTCfohTIhxzYK5K4DDtpF/JFQwd4bjNPA==
X-Received: by 2002:a05:6214:5099:b0:477:4ed2:633d with SMTP id kk25-20020a056214509900b004774ed2633dmr13604542qvb.16.1660572109711;
        Mon, 15 Aug 2022 07:01:49 -0700 (PDT)
Received: from robh.at.kernel.org ([50.206.145.23])
        by smtp.gmail.com with ESMTPSA id x2-20020ac87302000000b00342b7e4241fsm8057678qto.77.2022.08.15.07.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:01:49 -0700 (PDT)
Received: (nullmailer pid 1103614 invoked by uid 1000);
        Mon, 15 Aug 2022 14:01:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20220815043436.20170-4-samuel@sholland.org>
References: <20220815043436.20170-1-samuel@sholland.org> <20220815043436.20170-4-samuel@sholland.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: sram: sunxi-sram: Add optional regulators child
Date:   Mon, 15 Aug 2022 08:01:47 -0600
Message-Id: <1660572107.469120.1103613.nullmailer@robh.at.kernel.org>
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

On Sun, 14 Aug 2022 23:34:34 -0500, Samuel Holland wrote:
> Some sunxi SoCs have in-package regulators controlled by a register in
> the system control MMIO block. Allow a child node for these regulators
> in addition to SRAM child nodes.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v3:
>  - Require the regulators node to have a unit address
>  - Reference the regulator schema from the SRAM controller schema
>  - Move the system LDOs example to the SRAM controller schema
>  - Reorder the patches so the example passes validation
> 
> Changes in v2:
>  - New patch for v2
> 
>  .../allwinner,sun4i-a10-system-control.yaml   | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.example.dtb:0:0: /example-1/syscon@3000000: failed to match any schema with compatible: ['allwinner,sun20i-d1-system-control']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

