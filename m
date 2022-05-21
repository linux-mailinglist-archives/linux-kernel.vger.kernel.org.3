Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982D752FD94
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 17:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbiEUPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiEUPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 11:13:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AD8554A3
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 08:12:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y32so18772242lfa.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Jk8LaQh3YbYcgetXkqyBJpq8LYQteQJ9EbjKOpTl0XY=;
        b=oGIquCyjTa0KYp6tHKz3oefhMdccABhkE4D7b90SYfLT5XULA4lw+u6xfvLSufi/dF
         NCULivkTUv3fXSRlUYn4cEHbDx6WGdAq2W91sR+9n6AbecrbJiovgm6dYyxCx/AIwGsC
         qGbMaTByAgUSifSq0sW583YfPXVDXTluKd0qnGrGlnwLyTi8UgVbwYOG3mM8LMsVRp8d
         1dFJ422/GfrNVIR8IaqYhpESo6BheeQN9HsEBZzwJY+trSKTiIzdKD4NY2V/ejnoxUY9
         ftWUjFrBdlCy1g7z0N59nJx34G61hPNcgIHw80QuFpAV14tURwW+UpsqzF3Yww2qwuhK
         gjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jk8LaQh3YbYcgetXkqyBJpq8LYQteQJ9EbjKOpTl0XY=;
        b=tAsSKTaXZK+f6c7yGYDoIf9Vd9MgzQR3yHt45hLpr7/6CZ2Jw4OGMNTvWhvdA8tI1m
         qHmm1kSdvRzmLWmCoIZg7JVMOGruqSvfhLsfV7mpeK76m5cBIKv5GJUwT4PniXFCdzNX
         X3wbJ8fzftXNdYYyPQddxgZIrsCulwfvIEELAF0jIFOmUG/ci+pkoz3P5KicRYowR/El
         fjC+pMLZNUp6S82ixV7S40CeN0RpeWqrdfM7sZswpWSA/Ntfnbfm9iIP89cOayCyYCh0
         e8C4F+H+kOs8yvQkioQzbb2bRc/BTHiD2YCpnUrOhlyqKxEVuwy/y/F6JVMVQiF3ccdS
         Hezw==
X-Gm-Message-State: AOAM533VkUSccKsKFknukQSJC+TfQRpDqsUMrKVtXfOg0zHqgaFE0nlm
        piU5md5thpFK0nzJP7Idu+u1yw==
X-Google-Smtp-Source: ABdhPJzHBGbNgQUS6N5McRNLoRvhDms8eVo9NAyIsoae8EZeyxTurbcJ6pSNiu3YwGjGlMOUPBD83Q==
X-Received: by 2002:ac2:484e:0:b0:477:b102:c8df with SMTP id 14-20020ac2484e000000b00477b102c8dfmr10795390lfy.415.1653145976844;
        Sat, 21 May 2022 08:12:56 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f11-20020a05651c02cb00b00253e1fca85asm318558ljo.85.2022.05.21.08.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 08:12:56 -0700 (PDT)
Message-ID: <45fea4a1-387f-9684-a90b-58b695b54172@linaro.org>
Date:   Sat, 21 May 2022 17:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@xilinx.com>, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        michal.simek@xilinx.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220518194426.3784095-1-tanmay.shah@xilinx.com>
 <20220518194426.3784095-2-tanmay.shah@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220518194426.3784095-2-tanmay.shah@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 21:44, Tanmay Shah wrote:
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
> +        items:
> +          - description: mailbox channel to send data to RPU
> +          - description: mailbox channel to receive data from RPU
> +        minItems: 1
> +
> +      mbox-names:
> +        items:
> +          - const: tx
> +          - const: rx
> +        minItems: 1
> +
> +      sram:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        minItems: 1

maxItems instead

> +        description: |
> +          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
> +          the RPU can execute instructions and access data from, the OCM memory,
> +          the main DDR memory, and other system memories.
> +
> +          The regions should be defined as child nodes of the respective SRAM
> +          node, and should be defined as per the generic bindings in,
> +          Documentation/devicetree/bindings/sram/sram.yaml
> +
> +      memory-region:
> +        description: |
> +          List of phandles to the reserved memory regions associated with the
> +          remoteproc device. This is variable and describes the memories shared with
> +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
> +          vrings, ...). This reserved memory region will be allocated on DDR memory.
> +        minItems: 1
> +        items:
> +          - description: region used for RPU firmware image section
> +          - description: vdev buffer
> +          - description: vring0
> +          - description: vring1
> +        additionalItems: true

How did this one appear here? It does not look correct, so why do you
need it?

> +
> +    required:
> +      - compatible
> +      - power-domains
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +\

Best regards,
Krzysztof
