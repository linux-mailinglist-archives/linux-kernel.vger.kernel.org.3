Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B267548B09B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiAKPO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:14:58 -0500
Received: from mail-oo1-f46.google.com ([209.85.161.46]:38423 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343535AbiAKPO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:14:56 -0500
Received: by mail-oo1-f46.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so4508314ooj.5;
        Tue, 11 Jan 2022 07:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=+Ve86bAGdGykE9lQJLEQz82ky5oOJ7dhVkEvbIarDHo=;
        b=kzBvxLXj49gN2gI33lHYfi4AQbKBb5ZATzINsmkPQBFx2bLrCLSVAIhOFFoFjrPFNY
         fLhV7XAeCGsvUmoWAcH4hQO4sPw7m7e1yN6Y7pIzOd+rojxqawkYVVPylFxawRr1FnBq
         iQE/KKwG4hSGKwLQ3qwAGQ5bR4xVTvWb8jioXdDSCftw7h/aBaRjWU2fvwq3/+qTf1xd
         HiHUS4YPiioerT7Ur20BgIUnc0wzHxNfG+aKZqbsAdwgY/7Nbo0rvvmLhfCMSktQtN2B
         NAVjLC5lJdSHnBcFcXZGIlFzYNdgFU4CeVOJT8gWRlXJa8+379zQBGmAPRRDy3vUKFHY
         HHKw==
X-Gm-Message-State: AOAM5310Rc9Uib0yLWqSruuADkUtSG0/d634ZXEnvGRovXz7B4JJOU67
        NFj1QHPcKTI5U5iFK81UPQ==
X-Google-Smtp-Source: ABdhPJzjz2Fl/tJM014yyLIjAKIl2z4NYeuhqHWYT1P04MdAmWcunSWmcc2GwFcYCq5ubVq1ltr1WA==
X-Received: by 2002:a4a:9446:: with SMTP id j6mr3393880ooi.87.1641914095662;
        Tue, 11 Jan 2022 07:14:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b17sm2165131ots.66.2022.01.11.07.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 07:14:55 -0800 (PST)
Received: (nullmailer pid 2944760 invoked by uid 1000);
        Tue, 11 Jan 2022 15:14:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <20220111115919.14645-1-cristian.pop@analog.com>
References: <20220111115919.14645-1-cristian.pop@analog.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: addac: one-bit-adc-dac yaml documentation
Date:   Tue, 11 Jan 2022 09:14:49 -0600
Message-Id: <1641914089.194827.2944759.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 13:59:18 +0200, Cristian Pop wrote:
> This adds device tree bindings for the one-bit-adc-dac.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> V1->V2
>  - I am aware of the recommendation of rename/move this driver. Should we
>    consider "drivers/io/gpio.c"?
>  - Add .yaml file
>  - Remove blank lines, remove unnecessary coma
>  - Remove macros for channels
>  - Check if channel is input for write_raw
>  - Use labels instead of extend_name
>  - Fix channel indexing
>  - Use "sizeof(*channels)" in devm_kcalloc()
>  - Remove assignment: " indio_dev->dev.parent = &pdev->dev;"
>  - Remove "platform_set_drvdata"
>  - Remove "adi" from compatible string since is not ADI specific driver.
> ---
>  .../bindings/iio/addac/one-bit-adc-dac.yaml   | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.example.dts:19.27-47.11: Warning (unit_address_vs_reg): /example-0/one-bit-adc-dac@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.example.dt.yaml:0:0: /example-0/one-bit-adc-dac@0: failed to match any schema with compatible: ['one-bit-adc-dac']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1578401

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

