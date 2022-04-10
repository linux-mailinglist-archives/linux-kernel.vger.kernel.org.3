Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9440E4FAFC7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbiDJTY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239612AbiDJTY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:24:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3AF61A38
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:22:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w18so15838688edi.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s6KjH9J3ytpASWaQQB4P5MO6mBW14v4qfdZP5NXbNT4=;
        b=oLuTi98g+Wdw5qPwwn5hP22zOCPhryp+4nyUj6UfFG29yTGiWEaT7fPcbqEEbdjqDg
         urUPjUKu8t8lNEP1V5nReYVu4Pi3XlfHg1AAU8Pt974pzKlUT9aDDJW3WTSMz5WODnnO
         2/XQpm+hbjqIBHUVDHNwpZdUFvm/al1ejJAMZWONzVLSFmW+Pw2D56OejF+K/NhAvJWW
         WzRmWk1qT0WcXB+BgPUAlhJB4GzUkrS4kysDrYl2YAcFcxazQtohQ6GnpkWdxXdueJfG
         1e78ZaIet0s2fUVTBern6ieCmkSsR/HtDlx5QKbWyGko/kMkL7kQk3q3HjYHLTj7AV2V
         JByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s6KjH9J3ytpASWaQQB4P5MO6mBW14v4qfdZP5NXbNT4=;
        b=ZkeW3+PMJ0Y6gPIXbSRrbavp9rHadOsETzuAqbYguAnhLPbu/6YuhIUh93Suy0F9XT
         IEYeTkH5HKFptzQ20iLWOFLEd57N8vkoAWod/4EPsOUAXwNgPlXztQ1zJKCK8i39hZi8
         v1LaQWxSE+SAvRuK9NHBwHAJkppLqexd4YVrSgjzJTMFASb/aYRAJvRJlnfs7cgyHwYZ
         WujvB60nqIFhg2spjeqHtcShigs6ph/2zZnofkT9H1/0I/hk1KWdTLP9y9tha9C001KT
         yn/OYDXYQo2rh8khPFKbT4LBe8x8J081QbTbxEAF22PZrecTsXF+OSDUJtS9hjJcnbeE
         KzmQ==
X-Gm-Message-State: AOAM530hl72bTKEBlJtjqhnx1sKeCUI7y5hI/LfsNLc3zY+C80/4iinZ
        CGljqKEyhAXqRMsRU5iOWszUBg==
X-Google-Smtp-Source: ABdhPJx3cpzWE+zgaW9gPdnaedxS3xosxveySly6+/6lSyGnvAOznTJckftEgJaLGW0IBNmNpDCj8g==
X-Received: by 2002:a05:6402:11d4:b0:419:5a50:75a4 with SMTP id j20-20020a05640211d400b004195a5075a4mr30229188edw.226.1649618533103;
        Sun, 10 Apr 2022 12:22:13 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709064a0100b006e89334f5dfsm441488eju.136.2022.04.10.12.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 12:22:12 -0700 (PDT)
Message-ID: <14ecb746-56f0-2d3b-2f93-1af9407de4b7@linaro.org>
Date:   Sun, 10 Apr 2022 21:22:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA binding
 to json format
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
 <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2022 19:50, Kuldeep Singh wrote:
> Convert Qualcomm BAM DMA controller binding to DT schema format using
> json schema.

Thank you for your patch. There is something to discuss/improve.

(...)

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  iommus:
> +    minItems: 1
> +    maxItems: 4

This is something new and it seems only one SoC defines it (not even one
BAM version). I wonder whether this is actually correct or this
particular version of BAM is slightly different. Maybe someone could
clarify it, but if no - looks ok.

> +
> +  num-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Indicates supported number of DMA channels in a remotely controlled bam.
> +
> +  qcom,controlled-remotely:
> +    $ref: /schemas/types.yaml#/definitions/flag

type: boolean

> +    description:
> +      Indicates that the bam is controlled by remote proccessor i.e. execution
> +      environment.
> +
> +  qcom,ee:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Indicates the active Execution Environment identifier (0-7) used in the
> +      secure world.

maximum: 7

> +
> +  qcom,num-ees:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Indicates supported number of Execution Environments in a remotely
> +      controlled bam.
> +
> +  qcom,powered-remotely:
> +    $ref: /schemas/types.yaml#/definitions/flag

type: boolean

> +    description:
> +      Indicates that the bam is powered up by a remote processor but must be
> +      initialized by the local processor.
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - "#dma-cells"
> +  - interrupts
> +  - reg

clocks, clock-names, qcom-ee - these are required according to old bindings.


Best regards,
Krzysztof
