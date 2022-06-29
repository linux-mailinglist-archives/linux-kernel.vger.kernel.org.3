Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF65155FCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiF2KHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiF2KHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:07:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492803DA6F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:07:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fw3so3880490ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UI9cYbOS287xUrQaY8UIv5U4S9Lu0ZwNP7V9PXH0PV4=;
        b=NCZHWN/cJfm3yny65P8YlLhwiDOO26ZGNIOI86H8qkah4/8sC2HH4UF0vcAQBvnhR/
         JuzFrPrnGn7/VJSNEfJGL45unlg7C7ye2LcicTxY0l/+dyalv/069wFcagPKFYOMcQeK
         V4zFV6PwhuwiL7Ra/0J9qJQ9BW26dVMAgqP8dqpYZgVm4srrH/kUApqswi6gyA64RmDs
         MSGD66lRTRCTNHu0f2FfNzS7Acg9ZA1hk568F7ku7Jt1AkKOYJTLkXLYKx1qqKfx/hov
         HPA146AMhxsHv1o9tnYM3yyQiPcUSYNYlvNaUjBw6ZkDxFMyQ4ktdIoL/Q+HXWFZg9XQ
         lTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UI9cYbOS287xUrQaY8UIv5U4S9Lu0ZwNP7V9PXH0PV4=;
        b=Lr9t1tphRfNGlUahh6HZ/3XraVZEtbdiea9/pozohVMGLO+Ro1cRhDaEUAfoVWl07G
         U+IqnYi7VwAM5qiwTU/Wr7EVqnlOo3PZuLNwmTU+TG99Go4MoKl+nl+CGn8ymr/V2wVT
         XUa3nEwIotO+0VQOltq6QvyoxZsBJV5aMhStAiWj3P9YhSrqIhLTndNcKmD+jJkASxIi
         L3lai+CETU9/jMXsimfGTiuaTp8LD3MU1bGbqf2Tf/qm8WEUbV0knfx2h0izGQ8eDay8
         Nf11Br4jYflDeqhC5h24abg57AgTZkKrCaaQY0YyXzx+tHLX6YWvCaZHrHS/NHKsJzW0
         nALA==
X-Gm-Message-State: AJIora+ldFUh4wBnX19GuVzb+Tu1zGeuW0Mm8TagvrvSsaWabA1vXYT4
        U9PtspU6YJrTT6mhtGxdhbE7ug==
X-Google-Smtp-Source: AGRyM1t88ZULBHs8ccIHaDmNBddyVX1Qha12QXv8ndf/tZldlCtfEPBLrfk8gfi9BQDElKx1RSrzJw==
X-Received: by 2002:a17:907:c1d:b0:726:3239:fe83 with SMTP id ga29-20020a1709070c1d00b007263239fe83mr2513343ejc.51.1656497237837;
        Wed, 29 Jun 2022 03:07:17 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k25-20020a170906971900b00724e6a55d1asm7469511ejx.197.2022.06.29.03.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:07:17 -0700 (PDT)
Message-ID: <fc685f00-41e5-e64c-09b8-662b01a46f6c@linaro.org>
Date:   Wed, 29 Jun 2022 12:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-bindings: misc: tmr-manager: Add device-tree
 binding for TMR Manager
Content-Language: en-US
To:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org
Cc:     git@amd.com, git@xilinx.com
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
 <20220628054338.1631516-2-appana.durga.rao@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628054338.1631516-2-appana.durga.rao@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2022 07:43, Appana Durga Kedareswara rao wrote:
> This commit adds documentation for Triple Modular Redundancy(TMR) Manager
> IP. The Triple Modular Redundancy(TMR) Manager is responsible for handling
> the TMR subsystem state, including fault detection and error recovery
> provides soft error detection, correction and recovery features.
> 
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
>  .../bindings/misc/xlnx,tmr-manager.yaml       | 48 +++++++++++++++++++

This is not a misc device. Find appropriate subsystem for it. It's not
EDAC, right?

>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
> new file mode 100644
> index 000000000000..f6cb4d235981
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/xlnx,tmr-manager.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx TMR Microblaze Device Tree Bindings

s/Device Tree Bindings//

> +
> +maintainers:
> +  - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> +
> +description: |
> +  The Triple Modular Redundancy(TMR) Manager is responsible for handling the
> +  TMR subsystem state, including fault detection and error recovery. The core
> +  is triplicated in each of the sub-blocks in the TMR subsystem, and provides
> +  majority voting of its internal state.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,tmr-manager-1.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  xlnx,magic1:
> +    minimum: 0
> +    maximum: 255
> +    description:
> +      Magic number 1, When writing to the control register the first write data
> +      byte (bits 7:0) must match this value in order to have any effect on the
> +      nominal recovery function.

Register values are usually not in the scope of bindings. We describe
here hardware, not programming model, although in case of soft cores
maybe it's a bit different.

Anyway you need to describe the actual feature, not OS behavior.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - xlnx,magic1
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    tmr-manager@44a10000 {

Depending on what is this, you should use appropriate generic node name.

> +            compatible = "xlnx,tmr-manager-1.0";
> +            reg = <0x44a10000 0x10000>;
> +            xlnx,magic1 = <0x46>;
> +    };


Best regards,
Krzysztof
