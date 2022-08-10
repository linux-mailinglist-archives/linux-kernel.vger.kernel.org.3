Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6190858EF08
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiHJPLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiHJPLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:11:39 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840186555E;
        Wed, 10 Aug 2022 08:11:38 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id v185so12351366ioe.11;
        Wed, 10 Aug 2022 08:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=VdGy62arhSt+BL4EouUN4IOHP2gTgnK0/wSx3k0+9GQ=;
        b=p37LXXtLjMmIAU65imJU+wvg6/LUkO86YE89axN8BOwgPRTamgDuZl6PptzZ75cZIw
         RijsKK4+zwCMTAR9Jesc81TptEB3ScbH7OxFD8X1Ja7qxcPAa6w0X9GFcLZyIzG5AvXK
         4MoAVHocMX5EAF5kHOjx55dbDEoxnumfL0Bjtujx6rKvTc55ewAZ37DzrKdyWp7uWB4v
         Y+HyW7QYVipqmnCP4gFfBQLj3mbSPRz1e3Y+wOwGp0/P8rTb7L7q/njtSG69Z78OPzEX
         LnAeiAyBPxscaIeUtbyW4s2EhGntNCvJi377S5W++5NRtyXKbSrHNqM9wA89JAnuMWQF
         zdGw==
X-Gm-Message-State: ACgBeo0qIJod+uWvEc4Y5W99mjYgq2xTf+5bC0pv/0Y0RXtCGwxZAty2
        M/4pNjix1FfFZ4ieS0n2NmVipX2g0g==
X-Google-Smtp-Source: AA6agR7WvN3Kq0NUIrMMMSYd3sVfG//5Whijw3XcGTtSkmrFdqmuuuPSGfS3vF6YdeztcytZilJZnQ==
X-Received: by 2002:a05:6638:380c:b0:342:ceb9:7af2 with SMTP id i12-20020a056638380c00b00342ceb97af2mr9653346jav.227.1660144297690;
        Wed, 10 Aug 2022 08:11:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id bs27-20020a056638451b00b0033f51f165e3sm7487923jab.140.2022.08.10.08.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:11:37 -0700 (PDT)
Received: (nullmailer pid 4155387 invoked by uid 1000);
        Wed, 10 Aug 2022 15:11:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20220810030500.2793882-2-bjorn.andersson@linaro.org>
References: <20220810030500.2793882-1-bjorn.andersson@linaro.org> <20220810030500.2793882-2-bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add Lenovo Yoga C630 EC
Date:   Wed, 10 Aug 2022 09:11:36 -0600
Message-Id: <1660144296.239515.4155386.nullmailer@robh.at.kernel.org>
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

On Tue, 09 Aug 2022 22:04:59 -0500, Bjorn Andersson wrote:
> Add binding for the Embedded Controller found in the Qualcomm
> Snapdragon-based Lenovo Yoga C630.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../power/supply/lenovo,yoga-c630-ec.yaml     | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.example.dtb: embedded-controller@70: connector@1:ports: 'port@0' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.example.dtb: connector@1: ports: 'port@0' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/connector/usb-connector.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

