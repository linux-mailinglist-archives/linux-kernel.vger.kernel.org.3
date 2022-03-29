Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990E64EB3DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbiC2TGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiC2TGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:06:51 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19EC122220;
        Tue, 29 Mar 2022 12:05:03 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id t21so15100518oie.11;
        Tue, 29 Mar 2022 12:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=v1oONrnLlRXGbMfvDqdmlw1VwUihrZs/319cP9C0i2s=;
        b=BkA3LuaMXzDy/sr5tI7+WCpdUZZ4vhuyOVKljUb+1yZUEUgs7Z8mALScWnzpWiVeIg
         Y65qYAPnPh8Djt8vIdv/JErPVKlKuKkGOcLBanu/kEyKbrShldTc0SpDS8DP1mZiexeE
         mXxIVW5C11gf5bwBWJv1klfLklju1ZmUR6D6okm7UbOByp4YPrqyUkssTaxVqvQhevXI
         Gu9nW5A08Y3VtJuH6phxkXqdbqTUV1Bbe76AOImekvwMkAFQUbSjCQnhl7PGxxpNk+z/
         bq4f1zVqGHP8nvlSKqWkrvRv3dXYPG5iZOxb6nomGEwEfrot19ypxtro+fPW32cLyNUD
         XelA==
X-Gm-Message-State: AOAM532gkNzeJn2rdaYAapwuxmmwuu8NBvJseqawYkeBE6dh2LIRqU+9
        MrMelbUjSmGZgrDwn65AGBOAjW0uDA==
X-Google-Smtp-Source: ABdhPJyXRr4zxXyWQ9FG9aYqpt0gXmHwOT5iuYgCBFk9X2WBHWElBXyZOF2Hf/klYpci/snl1JFIbw==
X-Received: by 2002:a05:6808:1804:b0:2f7:69ab:a06f with SMTP id bh4-20020a056808180400b002f769aba06fmr325060oib.41.1648580702835;
        Tue, 29 Mar 2022 12:05:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 21-20020a056870121500b000ddb064e097sm8459972oan.31.2022.03.29.12.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 12:05:01 -0700 (PDT)
Received: (nullmailer pid 1067576 invoked by uid 1000);
        Tue, 29 Mar 2022 19:05:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi@vger.kernel.org
In-Reply-To: <20220329112717.252647-1-krzysztof.kozlowski@linaro.org>
References: <20220329112717.252647-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema
Date:   Tue, 29 Mar 2022 14:05:00 -0500
Message-Id: <1648580700.635474.1067575.nullmailer@robh.at.kernel.org>
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

On Tue, 29 Mar 2022 13:27:16 +0200, Krzysztof Kozlowski wrote:
> Convert the GENI based Qualcomm Universal Peripheral (QUP) Serial
> Peripheral Interface (SPI) bindings to DT Schema.
> 
> The original bindings in TXT were not complete, so add during conversion
> properties already used in DTS and/or in the driver: reg-names, dmas,
> interconnects, operating points and power-domains.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/spi/qcom,spi-geni-qcom.txt       |  39 ------
>  .../bindings/spi/qcom,spi-geni-qcom.yaml      | 131 ++++++++++++++++++
>  2 files changed, 131 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.example.dt.yaml:0:0: /example-0/spi@880000/tpm@0: failed to match any schema with compatible: ['google,cr50']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1610589

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

