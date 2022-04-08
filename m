Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9A64F98FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbiDHPHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbiDHPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:07:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5B62405BF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:05:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso7767670wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z2vqFQdPAyfvut6ovQoXQ5XOm4NDygCMv5XEJBGIwVs=;
        b=kZbVnHdSrExx7M2nYO683DIu9cLpkisfrS1P7V37RaHZVOCRV6srvL65ZqTkgVgpps
         5es1L1ZX8PiQ6lYbBqafkUOufe0j48/IAtOG7kYWyFGkMUmjVJ8ypzm/SI2w1sdQR5P1
         2lZroaCY2AVXV4lNW9kMFwge7FxP+Dm2U7tamg63N0QSKHVeVE7TOhT0wwD65RqnVfWu
         6LgitVy/dU9rQr/Ddx2Q8d1ay/ddTBYfj7X63J9gyHcS0dhn3xZd+JFNG8WqXEqzdkKA
         sZ8MKmIUPDQRPFgnyPigaKFfyBrT3C6gKcZNb8jiYsr8TRg/uUGPvlXy6QoWviwnHxss
         smhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z2vqFQdPAyfvut6ovQoXQ5XOm4NDygCMv5XEJBGIwVs=;
        b=Ngf1lkJZkTlTbHtaeigrFWKKwgip6r5ye6cZMhyi/voN7QyjksfJYYEcu4o9HUSDb5
         N8FB3fKzWvJJXJylcnIe4OcMLWJFLG0R6N3fOKo4mY6cBOv1JURZwRktaUA3dMaW/YYF
         FCigLqhD5CHRI2nIy0nbzWCrKw+EvuejntvLJt9Nu7lTXp8H56iLxN5hQbXsHMqpq75d
         4YtsL8X8i2gO14LRrwykUOC5T7P/QQxUviBuGGnMadLBEYbXd7JfRWQvlLqXs23fQniM
         RskB2WYR+ZNvOALh4T3492s3ZnUUWEhwtSQkb/w6RiOUEEW9+H+zDwtDd5c9tTmT+tuN
         Qz2A==
X-Gm-Message-State: AOAM532OA+Hn0kabJ1Zy7/+j963D9qg6fyJcqxnpi3ByoQJmBa/2PUdG
        5fhAdqNwVA1wX4vVpwtDqd95Og==
X-Google-Smtp-Source: ABdhPJzaJKjlfwBc4j57iWbiUBbG/JGU1kd5M0DvZJTA45YHU8Zkq5kzdGmXh1xKiEp/TQEZIXxUVQ==
X-Received: by 2002:a05:600c:4f42:b0:38c:21:fffe with SMTP id m2-20020a05600c4f4200b0038c0021fffemr17300289wmq.63.1649430329411;
        Fri, 08 Apr 2022 08:05:29 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b0038e8fb63293sm4576689wmq.22.2022.04.08.08.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 08:05:28 -0700 (PDT)
Message-ID: <1a45984a-752b-6bad-0320-f0946d83f2b9@linaro.org>
Date:   Fri, 8 Apr 2022 17:05:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] dt-bindings: input: Add bindings for Awinic AW8695
 haptics
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220408115311.237039-1-luca.weiss@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220408115311.237039-1-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 13:53, Luca Weiss wrote:
> Add a document describing the bindings for the AW8695 LRA Haptic Driver.

(...)

> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to RSTN pin (active high)
> +
> +  awinic,f0-preset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Default value for the f0 of LRA
> +
> +  awinic,f0-coefficient:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Coefficient between actual f0 and the value in the registers
> +
> +  awinic,f0-calibration-percent:
> +    maxItems: 1
> +    description: Limit of f0 deviation from awinic,f0-preset
> +
> +  awinic,drive-level:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Level of drive waveform in normal driving
> +
> +  awinic,f0-detection-play-time:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Drive waveform play times in the first period in the f0 detection

Use standard unit suffixes for known units (e.g. time).

> +
> +  awinic,f0-detection-wait-time:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Waveform wait times in the f0 detection

Ditto.

> +
> +  awinic,f0-detection-repeat:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Repeat times in the f0 detection
> +
> +  awinic,f0-detection-trace:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Drive waveform play times in the second period and later in the f0 detection
> +
> +  awinic,boost-debug:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 3
> +    maxItems: 3
> +    description: Values for BSTDBG1-3 registers

Do not encode device programming model (registers) into the binding. You
need to define it as a property related to hardware itself, not its
registers (e.g. boost value in mV).

> +
> +  awinic,tset:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: Value for TSET register

Ditto.

> +
> +  awinic,r-spare:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: Value for R_SPARE register

Ditto.


Best regards,
Krzysztof
