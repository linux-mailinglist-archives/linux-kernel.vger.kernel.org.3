Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4C57A8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbiGSVZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGSVZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:25:18 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC8213F62;
        Tue, 19 Jul 2022 14:25:16 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so33684406fac.13;
        Tue, 19 Jul 2022 14:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=J7bWnlAb62adhuxmOvN388c36GLe9YtFfoQRxdiUgOg=;
        b=yPyhP8MjL1DNDBhEhsytqzIKn3iiCZq+o8QDVRUh0MLMdwt48Sz84L6TDdx0XrqS/h
         8gA+cAskHsKMLGwEcPzCeJfVUc+G9j/pfZimlScJJ9wZAi/BSo+oFigvNCkMK2oViWNH
         FwkyCeqvHyTGq1qN2rnlJUG66T/+cLXTwv+D5Rx+hxnw4kOJED8i52/dpJHjEYAzPSnR
         v82I3+Ro8nj83mxoIafBLOFoUklm0Q226RM8SZVr8SCfJmsCDLLAfu9ENLvQCHPA/O2r
         ryhqt9Ce2t9rSV30oXjPZfa5pyXMb40mXrJUQ2hbLhPShtJ493oh29M02AcGyp91fHCQ
         5MIg==
X-Gm-Message-State: AJIora/SGuyK35tfmXiT3rlZfzHhbDYlOfD6sAPcDdAxA2WJGiO339E7
        rwNMiMQSsKu4/wSgFNCKbA==
X-Google-Smtp-Source: AGRyM1vb+1kgnDsEX88q+xu9t0+egT0+ffaB2ygBs86S8RoFNx551NwExi0kKNi868vwpJtvrSYcHg==
X-Received: by 2002:a05:6870:899d:b0:10c:b531:17b1 with SMTP id f29-20020a056870899d00b0010cb53117b1mr780743oaq.271.1658265916131;
        Tue, 19 Jul 2022 14:25:16 -0700 (PDT)
Received: from robh.at.kernel.org ([199.114.228.113])
        by smtp.gmail.com with ESMTPSA id m5-20020a056870058500b000e686d1386dsm8327938oap.7.2022.07.19.14.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:25:15 -0700 (PDT)
Received: (nullmailer pid 1852594 invoked by uid 1000);
        Tue, 19 Jul 2022 21:25:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     marijn.suijten@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        sven.schwermer@disruptive-technologies.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, johan+linaro@kernel.org
In-Reply-To: <20220719191801.345773-4-jjhiblot@traphandler.com>
References: <20220719191801.345773-1-jjhiblot@traphandler.com> <20220719191801.345773-4-jjhiblot@traphandler.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: leds: Add binding for a multicolor group of LEDs
Date:   Tue, 19 Jul 2022 15:25:13 -0600
Message-Id: <1658265913.899205.1852593.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 21:18:00 +0200, Jean-Jacques Hiblot wrote:
> This allows to group multiple monochromatic LEDs into a multicolor
> LED, e.g. RGB LEDs.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  .../bindings/leds/leds-group-multicolor.yaml  | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-group-multicolor.example.dtb: multi-led: Unevaluated properties are not allowed ('color', 'function' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

