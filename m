Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD7E581483
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbiGZNvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiGZNvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:51:20 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4467B248DC;
        Tue, 26 Jul 2022 06:51:20 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-10d6ddda695so18723631fac.0;
        Tue, 26 Jul 2022 06:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=CsJWLbupbPaLIrMNaESke+SXVtIQDiCRc5v86bUOhk0=;
        b=R4UowwFSlwFpS88lAhJCvBUk8X5hGMfAZiGlH6ErHu/pDLYew/HrshjvtE+1eo1aNk
         fiWHlDcgqLoeRXTu3GzhzG93gsGM1G0YXVwZpUD0QKc7CqL+AW2lLjxotht0LmpIrOsR
         mSZ9G9l/ruO3P69OzogHQI2M2MxPNIf2YmTguPSl5EDMjpfQdSFzGFf5o1I31V+NDFWu
         DLeCPsMLATKZCKQVw3mRgMemaTcD/i//QSVYGXHhUzFzXpB4QOpTsq+wDZ1h9Ocw13C8
         jMTZbj3vUCKLqhiAhUppfvnyviIKp4EcEs8Z1BtpAtKfKpHDQ/tWH2LVAeC35Ik3Ps1S
         uX+w==
X-Gm-Message-State: AJIora/NitMhxFHfQNcuZ8UdCFrtMRHQmKp9uJWIupFhVlQ7h/hw7knz
        CWoxBDP6meOlYXTmbytcDPc1wVKddg==
X-Google-Smtp-Source: AGRyM1u8g+tfKK6g98F3726L2+/CnUZHjUgGrnlUMu9639KKM9TG4kiPb6hf9D5BTKRpI8XyP8bNtA==
X-Received: by 2002:a05:6870:41d3:b0:10d:c25f:9c0d with SMTP id z19-20020a05687041d300b0010dc25f9c0dmr9386508oac.280.1658843479484;
        Tue, 26 Jul 2022 06:51:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e21-20020a9d63d5000000b0061ca70905absm6332750otl.49.2022.07.26.06.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:51:18 -0700 (PDT)
Received: (nullmailer pid 179935 invoked by uid 1000);
        Tue, 26 Jul 2022 13:51:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, mranostay@ti.com,
        lars@metafoo.de, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20220726072553.5136-3-jpanis@baylibre.com>
References: <20220726072553.5136-1-jpanis@baylibre.com> <20220726072553.5136-3-jpanis@baylibre.com>
Subject: Re: [PATCH v1 2/2] dt-binding: iio: time: add capture-tiecap.yaml
Date:   Tue, 26 Jul 2022 07:51:16 -0600
Message-Id: <1658843476.622431.179934.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 09:25:53 +0200, Julien Panis wrote:
> This commit adds a YAML binding for TI ECAP used in capture operating mode.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>  .../bindings/iio/time/capture-tiecap.yaml     | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iio/time/capture-tiecap.yaml#
Error: Documentation/devicetree/bindings/iio/time/capture-tiecap.example.dts:24.27-28 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/iio/time/capture-tiecap.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

