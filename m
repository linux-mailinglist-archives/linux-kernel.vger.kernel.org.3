Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E014828AB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 23:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiAAWB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 17:01:59 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:36823 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiAAWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 17:01:57 -0500
Received: by mail-ua1-f47.google.com with SMTP id r15so52007059uao.3;
        Sat, 01 Jan 2022 14:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ib7VxLrH+wz9KcO4aEP5G0wyP6h6Sx532OQ1mK/6MNA=;
        b=lDuLo15UmbtIdpgbcbTCSTycm5SyFXAEeZwgP51xgZit+og/MGEsnhTsnEJTA/eK34
         0Mvdbn+bvINR+Xc1KhpCjsXC2BOjGtFgjOuPr6PU0sxnKyivyqCmkEF0FaLtiPXkHmcW
         hapa6x0mOimZOr2dPUYnNOT5ftPwdDnf5/xFP/BiKXa8QN7Ai6LgLATvNg3NISacQn8W
         Cf2j/kizHs67knbGY+eVSTi418GJemCHyUK+RlEpuAnzi/mu++um+Ksmc8YFkujOBm70
         nil4VJGkZM2YbcbePtHBny6+/A1bSVgG0uBIcSsyamOogd1R9bjRJ7KO6bczurOx6utT
         q0SQ==
X-Gm-Message-State: AOAM5307t+Y4mQp6yzUksX9cB34rmahMSkhl4Y6Mx+Pd5eOMoG9Usakh
        Y7o5RQehls2R8uY1i80VxyJRou2uVV7b
X-Google-Smtp-Source: ABdhPJwf0BdYPyh284WfH5DaVslcyK+esQPXh84kVI+AYK2HFSTsPjwU9ipp4CkPSPV4rx8fj3uvkg==
X-Received: by 2002:a9f:3f08:: with SMTP id h8mr12967902uaj.128.1641074516353;
        Sat, 01 Jan 2022 14:01:56 -0800 (PST)
Received: from robh.at.kernel.org ([209.91.235.3])
        by smtp.gmail.com with ESMTPSA id u33sm5942815uau.7.2022.01.01.14.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 14:01:55 -0800 (PST)
Received: (nullmailer pid 839553 invoked by uid 1000);
        Sat, 01 Jan 2022 22:01:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Iain Hunter <drhunter95@gmail.com>
Cc:     iain@hunterembedded.co.uk, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211231131951.1245508-1-drhunter95@gmail.com>
References: <20211231131951.1245508-1-drhunter95@gmail.com>
Subject: Re: [PATCH v4 1/2] Add binding for ti,adc1018. It allows selection of channel as a Device Tree property
Date:   Sat, 01 Jan 2022 18:01:44 -0400
Message-Id: <1641074504.089913.839552.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 13:19:15 +0000, Iain Hunter wrote:
> New binding file uses the adc.yaml to define channel selection
> 
> Signed-off-by: Iain Hunter <drhunter95@gmail.com>
> ---
>  .../bindings/iio/adc/ti,ads1018.yaml          | 126 ++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/adc/ti,ads1018.example.dts:24.19-31.15: Warning (spi_bus_reg): /example-0/spi/adc@1: SPI bus unit address format error, expected "0"
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,ads1018.example.dt.yaml: adc@1: 'ti,adc-channels' does not match any of the regexes: '^channel@([0-3])$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,ads1018.example.dt.yaml: adc@0: 'ti,adc-diff-channels' does not match any of the regexes: '^channel@([0-3])$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1574373

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

