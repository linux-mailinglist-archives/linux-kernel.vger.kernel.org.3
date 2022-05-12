Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED4524EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354676AbiELNtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354494AbiELNtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:49:32 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F60E166471;
        Thu, 12 May 2022 06:49:27 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id m6-20020a05683023a600b0060612720715so2724012ots.10;
        Thu, 12 May 2022 06:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=vJ0xwXGHdgMf7PxME7jBTyq9GxIj28ndUeZ7W7Wva48=;
        b=evzkP7Gp/W/YsZ6PN+JkHwxVfnDBzXzDL2xAY2l4rnkEf2zm/SjQQgWC/kBUOz8r3j
         +MniXuT3kOM4Dpq7DU94W5Ujh/MPURMqKfWLLQ4OPMaGGd3Za2SvhdrEfz3pwa+kqpEQ
         OhGpVUFMeZH4xDEHTZCyKaSpZN91VzusLqzAZ8q4th7tq8ROxDnx5A9hVCaUJ4Gl9xFY
         7fm89+2PZ8WcZAIGYlIfKmO402Wk56AsYCd0QZOCI5luWTFJbH/78gXexFG7QcZV2EoV
         Llx0bU9IhEi9CoqGu2R1tNM7gvhfLl2NXjIETNubvkG70oaVjksnZUPEFauPBzlVNCMd
         m6QQ==
X-Gm-Message-State: AOAM531SXkt78EJ8M55Mw9Dmc8HZCdYvMqzulXyvj5rOaQFNnN/06O4C
        oH1Ay4lH8Qp3YRa1wOUxG7VwlrQr7g==
X-Google-Smtp-Source: ABdhPJzqe5/3S2w811xiw2JqKWs4sXo67nY6qGngIxJLjxLZvC+PTeLU7TM84nQTRVAy06eLFUzQ+A==
X-Received: by 2002:a05:6830:1489:b0:605:e8d0:154f with SMTP id s9-20020a056830148900b00605e8d0154fmr11497otq.160.1652363366434;
        Thu, 12 May 2022 06:49:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t2-20020a056871020200b000e686d1388esm1542572oad.40.2022.05.12.06.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 06:49:25 -0700 (PDT)
Received: (nullmailer pid 2231010 invoked by uid 1000);
        Thu, 12 May 2022 13:49:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        dbarksdale@uplogix.com
In-Reply-To: <20220511190835.51046-2-eajames@linux.ibm.com>
References: <20220511190835.51046-1-eajames@linux.ibm.com> <20220511190835.51046-2-eajames@linux.ibm.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: humidity: Add si7020 bindings
Date:   Thu, 12 May 2022 08:49:24 -0500
Message-Id: <1652363364.570268.2231009.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 14:08:34 -0500, Eddie James wrote:
> Document the si7020 bindings with a new "silabs,skip-reset" property.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../bindings/iio/humidity/silabs,si7020.yaml  | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/humidity/silabs,si7020.example.dts:21.13-26: Warning (reg_format): /example-0/si7021-a20@40:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/iio/humidity/silabs,si7020.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/humidity/silabs,si7020.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/humidity/silabs,si7020.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/humidity/silabs,si7020.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/humidity/silabs,si7020.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.example.dtb: example-0: si7021-a20@40:reg:0: [64] is too short
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.example.dtb: si7021-a20@40: 'silabs,skip-reset' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.example.dtb: si7021-a20@40: 'silabs,skip-reset' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/trivial-devices.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

