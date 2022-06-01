Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3E853A4CA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbiFAMWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352877AbiFAMWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:22:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588033A71A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:22:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n10so3395450ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZDgi6QT1T7EpVIAwPl8YawRZEJZufjvXhtek/OEXbdU=;
        b=IGH9KuLMT3HYQF2PpAJxEcijlE9gMLD3M570Hqtdk9x/5aqV4hW0tiLeZpxEfnOGKr
         9Shmi8k54+r6RaWu9Y0sPyM2ih3Q0AzczEqglxN5Hp0niQ5o5DAulAjuUjY3ehCwR8Ff
         jYZKYkjAJ4nkfeNbVwdNoh2xA4lOB6QEBXJrIQymVjr+viKC7z5M+lQ53kZFnRBkVgl4
         +IXuPqiQrAmLg52aD2xT5T3ypEPqCFUyc4vjiTk/GUocyo6a0AU8KMj2hOMV19gb29Gi
         srFj0P4uB0/cHWcpRL6uS70TGZnWX0nujTZ1suoxqMUiSqqsio6yptx+tZ8yM5hwMB9X
         VB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZDgi6QT1T7EpVIAwPl8YawRZEJZufjvXhtek/OEXbdU=;
        b=wYP5s5ZetKFsqmbccbQJQVbYGO8R+RFwo8/SRCMC+mN+jyehVCbWDCZ/a1HokLM+gh
         P6shS5OKwGgRtkP/vDi9/JrJR2UEB5oygLWatS3hsq0r/VeY4827BgTm3N487e5vFs32
         xhyhxvken5Ft1WRrVIwxsaAB3j64STptOR4Ubt34crrMNrXR91j2DRirnrseUABpYMDD
         Hhn0Y0SMC6Hz/lKaYrjcxyZ5ye2WoZzUQdBu2Pla6qYfB02sTqvN94s+NsY53URVj7pC
         EPf+XG3b8KJb8eGYBLi0FDWMIh8v/WmWm2FwM/I6rAyBkrGMMiBr5qCpRr0ABpqCc8KI
         mzMQ==
X-Gm-Message-State: AOAM533ZEayhRmHLkA3ZNkAMSKo+1xDWB4w/KLUmCHYeBWVfoVoiv/UY
        6xDzMK9alZl6raVkStfIchEZnQ==
X-Google-Smtp-Source: ABdhPJyvJbwGPjXVa+X3djqfGIJHVCyeFGfVCL8frzhyOFUP05z/hnZlK01sRTcQV+QNd9iwdn52IQ==
X-Received: by 2002:a17:907:2cc4:b0:6fe:1c72:7888 with SMTP id hg4-20020a1709072cc400b006fe1c727888mr58492508ejc.373.1654086158619;
        Wed, 01 Jun 2022 05:22:38 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709061b1100b006febc1ef61csm637801ejg.106.2022.06.01.05.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 05:22:38 -0700 (PDT)
Message-ID: <44053e7d-71fd-2012-dc7f-5641536c1f2c@linaro.org>
Date:   Wed, 1 Jun 2022 14:22:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@xilinx.com>,
        openamp-system-reference@lists.openampproject.org,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, michal.simek@xilinx.com,
        ben.levinsky@xilinx.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
 <20220531234308.3317795-2-tanmay.shah@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531234308.3317795-2-tanmay.shah@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 01:43, Tanmay Shah wrote:
> Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
> Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
> (cluster).
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
> ---
> 
> Changes in v6:
>   - Add maxItems to sram and memory-region property
> 
> Changes in v5:
> - Add constraints of the possible values of xlnx,cluster-mode property
> - fix description of power-domains property for r5 core
> - Remove reg, address-cells and size-cells properties as it is not required
> - Fix description of mboxes property
> - Add description of each memory-region and remove old .txt binding link
>   reference in the description
> 
> Changes in v4:
>   - Add memory-region, mboxes and mbox-names properties in example
> 
> Changes in v3:
>   - None
> 
> 
>  .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 129 ++++++++++++++++++
>  include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>  2 files changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> new file mode 100644
> index 000000000000..cbff1c201a89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx R5F processor subsystem
> +
> +maintainers:
> +  - Ben Levinsky <ben.levinsky@xilinx.com>
> +  - Tanmay Shah <tanmay.shah@xilinx.com>
> +
> +description: |
> +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
> +  real-time processing based on the Cortex-R5F processor core from ARM.
> +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
> +  floating-point unit that implements the Arm VFPv3 instruction set.
> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-r5fss
> +
> +  xlnx,cluster-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    description: |
> +      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
> +      lock-step mode(Both RPU cores execute the same code in lock-step,
> +      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
> +      core 1 runs normally). The processor does not support dynamic configuration.
> +      Switching between modes is only permitted immediately after a processor reset.
> +      If set to  1 then lockstep mode and if 0 then split mode.
> +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
> +
> +patternProperties:
> +  "^r5f-[a-f0-9]+$":
> +    type: object
> +    description: |
> +      The RPU is located in the Low Power Domain of the Processor Subsystem.
> +      Each processor includes separate L1 instruction and data caches and
> +      tightly coupled memories (TCM). System memory is cacheable, but the TCM
> +      memory space is non-cacheable.
> +
> +      Each RPU contains one 64KB memory and two 32KB memories that
> +      are accessed via the TCM A and B port interfaces, for a total of 128KB
> +      per processor. In lock-step mode, the processor has access to 256KB of
> +      TCM memory.
> +
> +    properties:
> +      compatible:
> +        const: xlnx,zynqmp-r5f
> +
> +      power-domains:
> +        description: RPU core PM domain specifier
> +        maxItems: 1
> +
> +      mboxes:
> +        minItems: 1
> +        items:
> +          - description: mailbox channel to send data to RPU
> +          - description: mailbox channel to receive data from RPU
> +
> +      mbox-names:
> +        minItems: 1
> +        items:
> +          - const: tx
> +          - const: rx
> +
> +      sram:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        maxItems: 8

Without minItems, this means maxItems=minItems and previously you had
here "minItems:1", so is it really what you want?

Anyway rest looks good to me.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
