Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A235853263D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiEXJTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiEXJTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:19:20 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257835DA6D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:19:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u7so19439990ljd.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+Niw7yGnL20+GOOqZstdr0jY47BSBTsmVF0esVnrOoU=;
        b=hBgqF51egRRRpK5ROssbMOsnBHZkpb14VjYKSk4amJX6s2phfdQzunu0CpQ9Dw0LnF
         GspY4wM3l7i7okD+Yd6VJnU/sQhGM5DT0dmU7OlUATQLSuyOardrb8kQjQGd7iaGz+JQ
         hg7LXVVzZ+ViDvGBCqcIS1o60FmiZMGtZr8CLk1CkqMvHBm2Csb4WVdJ/pDuasFIaFLn
         CDrZPh3WmBQZf0j+5HGHT7MFzCSDtLJN/cD7KU/gBB1olBl3dbQuxG2OMTqUtHCMPYbN
         4475rFIiv60wCs9+pve8mGr8PzgdKf/Xs/4fSrRveN58TDmisoqOcEpWf7rCKU3Zc3nK
         sRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+Niw7yGnL20+GOOqZstdr0jY47BSBTsmVF0esVnrOoU=;
        b=lYHsJbwXA3O06LFtk0F52dDJS/UkDmh6zJ1Z8PnHozf49GwFObDOJDxF+gCCNuXDq5
         FBhCgTEttWz/9LsAbWtIrB9aCpvbZztKJpvxdGvMOYcd4RZ5/0Q+QSgPOBV3D9P1scIY
         1G3xNGGNL35jaZLRKSMIx0W/yJW/TzcDsIm6akM56zmoM0N68dALkLI8uD9VZic6INxO
         UQF8D0uZ5XdhAOIbF9Wf9hpu2NdcnoTViCnGk6vPMZKq+SUVzofT6KvgEDXQFenO7FpH
         srqscxZ8t6Y67/ge1fr4CwEcMG0xKyLiFe0FzNdLOgoBCjhyanOLUTQQg3yA0GipRfnI
         KmLw==
X-Gm-Message-State: AOAM53391zZZ2SMBPJ+yxBro/2Yuf25SnCHomQF/DzXLG7ZrkRHfWiYu
        CSAMm3krWV7dMztOp/6Yi1edEg==
X-Google-Smtp-Source: ABdhPJznpV2FUoCtb1XbNeFXg7bMAoJTuMYnDIlZJD+gLtUepUGBy4u89LrrCyXkaFuoNCi1VLc3Ng==
X-Received: by 2002:a05:651c:a11:b0:253:f347:734a with SMTP id k17-20020a05651c0a1100b00253f347734amr2373641ljq.449.1653383955367;
        Tue, 24 May 2022 02:19:15 -0700 (PDT)
Received: from [172.20.68.48] ([91.221.145.6])
        by smtp.gmail.com with ESMTPSA id b14-20020a2eb90e000000b00253bc0f63ffsm2323272ljb.13.2022.05.24.02.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 02:19:14 -0700 (PDT)
Message-ID: <1b117e49-28d0-da75-68ee-c2fcef9fc9a9@linaro.org>
Date:   Tue, 24 May 2022 11:19:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
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
 <45fea4a1-387f-9684-a90b-58b695b54172@linaro.org>
 <c97d61b0-8a38-5054-d5f1-bc7c5e7bcf61@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c97d61b0-8a38-5054-d5f1-bc7c5e7bcf61@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 23:38, Tanmay Shah wrote:
> Thanks for reviews Krzysztof. Please find my comments below.
> 
> On 5/21/22 8:12 AM, Krzysztof Kozlowski wrote:
>> On 18/05/2022 21:44, Tanmay Shah wrote:
>>> +description: |
>>> +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
>>> +  real-time processing based on the Cortex-R5F processor core from ARM.
>>> +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
>>> +  floating-point unit that implements the Arm VFPv3 instruction set.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: xlnx,zynqmp-r5fss
>>> +
>>> +  xlnx,cluster-mode:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [0, 1, 2]
>>> +    description: |
>>> +      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
>>> +      lock-step mode(Both RPU cores execute the same code in lock-step,
>>> +      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
>>> +      core 1 runs normally). The processor does not support dynamic configuration.
>>> +      Switching between modes is only permitted immediately after a processor reset.
>>> +      If set to  1 then lockstep mode and if 0 then split mode.
>>> +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
>>> +
>>> +patternProperties:
>>> +  "^r5f-[a-f0-9]+$":
>>> +    type: object
>>> +    description: |
>>> +      The RPU is located in the Low Power Domain of the Processor Subsystem.
>>> +      Each processor includes separate L1 instruction and data caches and
>>> +      tightly coupled memories (TCM). System memory is cacheable, but the TCM
>>> +      memory space is non-cacheable.
>>> +
>>> +      Each RPU contains one 64KB memory and two 32KB memories that
>>> +      are accessed via the TCM A and B port interfaces, for a total of 128KB
>>> +      per processor. In lock-step mode, the processor has access to 256KB of
>>> +      TCM memory.
>>> +
>>> +    properties:
>>> +      compatible:
>>> +        const: xlnx,zynqmp-r5f
>>> +
>>> +      power-domains:
>>> +        description: RPU core PM domain specifier
>>> +        maxItems: 1
>>> +
>>> +      mboxes:
>>> +        items:
>>> +          - description: mailbox channel to send data to RPU
>>> +          - description: mailbox channel to receive data from RPU
>>> +        minItems: 1
>>> +
>>> +      mbox-names:
>>> +        items:
>>> +          - const: tx
>>> +          - const: rx
>>> +        minItems: 1
>>> +
>>> +      sram:
>>> +        $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +        minItems: 1
>> maxItems instead
> 
> 
> Here, I am not sure how many maxItems are really needed as TCM bindings 
> are not
> defined yet. For now, I will just keep maxItems as 8. i.e. 4 OCM banks 
> and 4 TCM
> banks. However, that can change once bindings are defined.
> Is that fine?

Yes, although shrinking might not be allowed once binding is being used.

> 
> 
>>
>>> +        description: |
>>> +          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
>>> +          the RPU can execute instructions and access data from, the OCM memory,
>>> +          the main DDR memory, and other system memories.
>>> +
>>> +          The regions should be defined as child nodes of the respective SRAM
>>> +          node, and should be defined as per the generic bindings in,
>>> +          Documentation/devicetree/bindings/sram/sram.yaml
>>> +
>>> +      memory-region:
>>> +        description: |
>>> +          List of phandles to the reserved memory regions associated with the
>>> +          remoteproc device. This is variable and describes the memories shared with
>>> +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
>>> +          vrings, ...). This reserved memory region will be allocated on DDR memory.
>>> +        minItems: 1
>>> +        items:
>>> +          - description: region used for RPU firmware image section
>>> +          - description: vdev buffer
>>> +          - description: vring0
>>> +          - description: vring1
>>> +        additionalItems: true
>> How did this one appear here? It does not look correct, so why do you
>> need it?
> 
> 
> Memory regions listed in items: field here are used for default current 
> OpenAMP demos. However,
> other demos can be developed by user that can use more number of memory 
> regions.
> As description says, memory-region can have variable number phandles 
> based on
> user requirement. So, by additionalItems I just want to notify that user can
> define more number of regions. We can limit memory-regions with 
> 'maxItems: 8'.
> In that case, I will add 'maxItems:' field in next revision and even, 
> that can change in future.

That sounds fine.

> But, User should have flexibility to define more memory regions than 
> what is in list
> of 'items:' field. I think this is similar to what is defined in 
> ti,k3-r5 bindings.
> 
> Please let me know your thoughts.

I see. If schema accepts such combination (listing items + maxItems +
additionalItems), then it's fine.

> 

Best regards,
Krzysztof
