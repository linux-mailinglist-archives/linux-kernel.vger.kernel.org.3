Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875D65431D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbiFHNpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbiFHNpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:45:23 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21B6270F00;
        Wed,  8 Jun 2022 06:45:21 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id f7so16573847ilr.5;
        Wed, 08 Jun 2022 06:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=3+NZrfVj/DoMxNSwGcwt9IuC/ula+cqk9XUZppUx5nQ=;
        b=ko1JAmlKdoQuZeWxKev1pSm8PoGjGGXNgYchLA47q66CbLBhwPhOXwpMwph9BEtY4j
         7kPP/vgofOl12fC0ktTfZz329i13dmDM/x/etdKJjxz90GphLSJoGWTz3uQTWH7JD+MS
         xPi0rz0lnq0HDUgnNGRuzN/f5L+FZQ5WBxtq/wLX4Ynb/h8UwHuo8FXkt43LHK2fF++1
         gMLTjOKvJ3uqbvDkQPUIbk1vct0higHnbJWkgcS/wxSg+Qt0eqNrgDYSScQPM7uoNR4G
         qZx34WoSe2Z2I/+6FEqrQfHlkWP4byg4IAt4dAQlvEpHRtGl29UzrmqzrPpqwAkRPpzq
         x0VA==
X-Gm-Message-State: AOAM5323hWjL+Xt5ZQAcH7U0Lvy7oAvHMSR7/4gfzygFnOICHS9NQ39F
        P3P5kPcsyuND/ath586igA==
X-Google-Smtp-Source: ABdhPJxxgcMnHYfi0fEQA49xGQFZL7pOyffVHEWeq6WyYcVp4K1iK/Vlu/qAyw063WKbDsfRnFCQQg==
X-Received: by 2002:a05:6e02:1d18:b0:2d3:bd9f:1a5f with SMTP id i24-20020a056e021d1800b002d3bd9f1a5fmr20405106ila.35.1654695920776;
        Wed, 08 Jun 2022 06:45:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id k2-20020a023502000000b003314bd44eb3sm8024110jaa.17.2022.06.08.06.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 06:45:20 -0700 (PDT)
Received: (nullmailer pid 1272092 invoked by uid 1000);
        Wed, 08 Jun 2022 13:45:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     devicetree@vger.kernel.org, alvaro.soliverez@collabora.com,
        kernel@collabora.com, digetx@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, krisman@collabora.com,
        jic23@kernel.org, Zhigang.Shi@liteon.com, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
In-Reply-To: <20220608113553.32083-2-shreeya.patel@collabora.com>
References: <20220608113553.32083-1-shreeya.patel@collabora.com> <20220608113553.32083-2-shreeya.patel@collabora.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: Document ltrf216a light sensor bindings
Date:   Wed, 08 Jun 2022 07:45:07 -0600
Message-Id: <1654695907.399493.1272091.nullmailer@robh.at.kernel.org>
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

On Wed, 08 Jun 2022 17:05:52 +0530, Shreeya Patel wrote:
> Add devicetree bindings for ltrf216a ambient light sensor.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> Changes in v5
>   - Remove deprecated string 'ltr' from the bindings.
> 
> Changes in v3
>   - Fix indentation in the example section
> 
> Changes in v2
>   - Take over the maintainership for the bindings
>   - Add interrupt and power supply property in DT bindings
> 
>  .../bindings/iio/light/liteon,ltrf216a.yaml   | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml: properties:compatible:const: ['liteon,ltrf216a'] is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml: ignoring, error in schema: properties: compatible: const
Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.example.dtb:0:0: /example-0/i2c/light-sensor@53: failed to match any schema with compatible: ['liteon,ltrf216a']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

