Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825334BE287
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381213AbiBUQsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:48:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381204AbiBUQsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:48:01 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4266122BEF;
        Mon, 21 Feb 2022 08:47:38 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id s14so13239510edw.0;
        Mon, 21 Feb 2022 08:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6uoQveL+AD9RUCzosFzI8fgp4aGHk8q16xyazzg5bDY=;
        b=CCgED8i18vq6cbHpVRExlsxnVU5/6OmxFJvjA2ZgmIb9BRhEy9tewKTbQO5BTFrDEZ
         wCKhZaLptVJrepeai8WbSp7fx2wphXSFk+oABigmcnbOAf3vTUssIIsYQlrlPPakbjYs
         VX4BrbonSxY3a/bq623BHi3PxgYBF1bDl/jrpXQA6nwMyb6dqpSR004xRKYY9/k+vpP4
         +j8gr7eRvPkB4whXgXy6IzvJsubh3vIT30xi/uRMoNRbVKIK/jTume8hFjhwc3LJ6GGQ
         x3nh2W3S0SYuKjx14v0c8KlcgZsW2r0xX9aLDo01UYDnnikQtSy+2gMxvqXdpykZ9LGb
         +YCQ==
X-Gm-Message-State: AOAM5320fgUtqGFkthFWvfbXF0KfEOvtqTG89ZbEXEadz+zAxe1D+oCb
        JGPIEFdyN33r/LyRtwK4Yfc=
X-Google-Smtp-Source: ABdhPJwLiISVhc2YR4ZxaIDiGLJ7BTzOKu2ot3AVX6stdd3PHhVYLTNRJ/enKvUfksmKQHriNQlsUg==
X-Received: by 2002:a05:6402:4245:b0:410:ee7d:8f0b with SMTP id g5-20020a056402424500b00410ee7d8f0bmr22300690edb.295.1645462056810;
        Mon, 21 Feb 2022 08:47:36 -0800 (PST)
Received: from [192.168.0.122] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id v12sm8942549edr.8.2022.02.21.08.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:47:35 -0800 (PST)
Message-ID: <3e1ee336-1c78-7719-826c-2a093a20ee8e@kernel.org>
Date:   Mon, 21 Feb 2022 17:47:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: remoteproc: Add AVM WASP
Content-Language: en-US
To:     Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220221135351.GA7342@ubuntu>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220221135351.GA7342@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2022 14:53, Daniel Kestrel wrote:
> AVM Fritzbox router boards may contain an additional ATH79
> based SoC that has the wifi cards connected.
> This patch adds bindings for this remote processor.
> 
> Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> ---
>  .../bindings/remoteproc/avm,wasp-rproc.yaml   | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
> new file mode 100644
> index 000000000000..21f3bbcc4202
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/avm,wasp-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AVM WASP processor controller bindings
> +
> +maintainers:
> +  - Daniel Kestrel <kestrelseventyfour@gmail.com>
> +
> +description: |
> +  This document defines the bindings for the remoteproc component that loads and
> +  boots firmwares on the AVM Wireless Assistent Support Processor (WASP) SoC
> +  that is attached to some AVM Fritzbox devices (3390, 3490, 5490, 5491, 7490).
> +
> +properties:
> +  compatible:
> +    const: avm,wasp
> +
> +  ath9k-firmware:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Should contain the name of the ath9k eeprom that is to be loaded from
> +      the lantiq host flash. Wifi on the WASP SoC does not work without it.
> +      The file should be located on the firmware search path.

Are you sure this is a property of hardware? It looks like runtime
configuration parameter.

> +
> +  ath10k-caldata:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Should contain the name of the ath10k caldata that is to be loaded from
> +      the lantiq host flash. Wifi on the WASP SoC does not work without it.
> +      The file should be located on the firmware search path.

Same.

> +
> +  wasp-netboot-firmware:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Should contain the name of the netboot firmware that is to be loaded
> +      and started on the WASP SoC using mdio in order to be able to load
> +      the initramfs image as a second stage.
> +      The file should be located on the firmware search path.

Same.

> +
> +  wasp-netboot-mdio:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Reference to the Lantiq GSWIP switch mdio.

Vendor prefix.

> +
> +  wasp-initramfs-port:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Reference to the network port, where the WASP SoC is connected to.

Vendor prefix.

> +
> +  wasp-initramfs-image:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Should contain the name of the initramfs linux image that is to be loaded
> +      and started on the WASP SoC.
> +      The file should be located on the firmware search path.

initramfs path looks even less like a property of hardware... If you
change initramfs from CPIO to initrd or GZ, hardware changes as well?

> +  reset-gpio:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: Reference and parameters for the reset gpio of the WASP SoC.

Wrong suffix, unneeded type. Did you run dt_binding_check?

"Reference and parameters" are obvious, so they should be skipped.

> +
> +  startup-gpio:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: Reference and parameters for the power switch gpio of the WASP SoC.

Same.

> +
> +required:
> +  - compatible
> +  - ath9k-firmware
> +  - ath10k-caldata
> +  - wasp-netboot-firmware
> +  - wasp-netboot-mdio
> +  - wasp-initramfs-port
> +  - wasp-initramfs-image
> +  - reset-gpio
> +  - startup-gpio
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    avm-wasp {

Generic node name describing class of a device. AVM is company, WASP is
product, so neither of them are generic.


Best regards,
Krzysztof
