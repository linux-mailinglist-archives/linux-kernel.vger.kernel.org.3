Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B41518B86
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbiECRxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240692AbiECRxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:53:38 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18F529813;
        Tue,  3 May 2022 10:50:05 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso12121741otj.5;
        Tue, 03 May 2022 10:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vhN5KYczMmv9TNqtRlooIo1ReYjcW4rlopTFOjfZfxg=;
        b=Q+3X+Ho1oeRngLCagsyeDyi1D+8FD57AJRmgSonq9QkSnjHmUWIjEqSef/roiVnNAO
         bOqrcM8BB4UYK+yPnIEcRmfSs4y3sRJwYM1iYUc6wkc7lVPvympLK+Wi1uL04nJhGGuP
         kyX/2hhqU8iggnGnSTEIPlXfMq/4QxqJpZzAb0N3umraKaCImuo+1cfH1CutccUT/Psu
         UqmfpBPE8BYVMNSjwHfKctwa5mTTg2EUfJfuVnxZjpryivliTqlGzifOCM69Z8PNuBXT
         yVVkhCBbpDYQpe8qGLCkdEVrkxSBQnH/2AobuX1Cc94Ori4FajeMiedFzypiPTS8nXli
         6MDw==
X-Gm-Message-State: AOAM531TZJwoNQla8e1kKac9dsXdAJpoAm8YicTBG2UHJ4Yi0gaUoDt8
        VyUzzYtnjgZy46JnvqkYaA==
X-Google-Smtp-Source: ABdhPJwzR+vsrHG/iK5QzquHREpyKtDwFyhoKABv6B6DjZnIdhtBOWnkv7gmbbHlpz7BD8FJ9Gq8cw==
X-Received: by 2002:a9d:19a3:0:b0:605:9af6:225c with SMTP id k32-20020a9d19a3000000b006059af6225cmr6226688otk.195.1651600205064;
        Tue, 03 May 2022 10:50:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i5-20020a9d68c5000000b0060603221236sm4179544oto.6.2022.05.03.10.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:50:04 -0700 (PDT)
Received: (nullmailer pid 3948010 invoked by uid 1000);
        Tue, 03 May 2022 17:50:04 -0000
Date:   Tue, 3 May 2022 12:50:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] dt-bindings:thermal: Add Sunplus schema
Message-ID: <YnFrTAqRJziPeo5T@robh.at.kernel.org>
References: <cover.1651543731.git.lhjeff911@gmail.com>
 <e9f65ca9a2b3205b91210398d743415f6c799d90.1651543731.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f65ca9a2b3205b91210398d743415f6c799d90.1651543731.git.lhjeff911@gmail.com>
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

On Tue, May 03, 2022 at 10:13:08AM +0800, Li-hao Kuo wrote:
> Add bindings for Sunplus thermal driver
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v8:
>  - Modify yaml file.
>    modify the setting compatible
>  - Change yaml file name.
>  - Modify driver.
>    mosdify and simply the nvmem setting and remove valiable
> 
>  .../bindings/thermal/sunplus,thermal.yaml          | 43 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
> new file mode 100644
> index 0000000..1ecf6f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sunplus,thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus Thermal controller
> +
> +maintainers:
> +  - Li-hao Kuo <lhjeff911@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,thermal

I don't think is is what was suggested. This must be SoC specific.

> +
> +  reg:
> +    maxItems: 1
> +
> +  nvmem-cells:
> +    maxItems: 1
> +
> +  nvmem-cell-names:
> +    const: calib
> +
> +required:
> +  - compatible
> +  - reg
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    thermal@9c000280 {
> +        compatible = "sunplus,thermal";
> +        reg = <0x9c000280 0xc>;
> +        nvmem-cells = <&calib>;
> +        nvmem-cell-names = "calib";
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 82143ff..ff49023 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18900,6 +18900,7 @@ SUNPLUS THERMAL DRIVER
>  M:	Li-hao Kuo <lhjeff911@gmail.com>
>  L:	linux-pm@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
>  F:	drivers/thermal/sunplus_thermal.c
>  
>  SUNPLUS UART DRIVER
> -- 
> 2.7.4
> 
> 
