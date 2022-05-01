Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D31B5162A2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbiEAIUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbiEAIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:20:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF581E03A
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 01:17:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z19so13487485edx.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 01:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EYMxrPRY3J2WekXOQlUGmVM4fNTTeU4P6bnwFue9aN0=;
        b=pM4ivJZfiRe9iOTmARBovljjO2oq0pxe5QakrVO842DZpiF8Hg5fhgRsqzTPOk9rG0
         SOOEG94VQcn8py37Q8Rt0HGcDjjLrvEdjYaT647NMzowT2O4JiFZApNqxcSJKR4AJfCe
         pil4A8nCEpq/uvRz0WpR3qeRi6Hf9bQF98ZrNIa72HQodV+6b7K7odIz3/HWXTf0bCtL
         U4FOelqw2VksG0E82Hv4BQ1lsrOZs15lc0d9J9DIcR+7zKwV0p7/tEQDcc8s8+2rkEME
         unctWNewVWjFmz+FAQ9uEH/AQg1CsB7E8ksPtnYQi7IkelE0WJLDG9VgtUIMFO/FPD/V
         b85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EYMxrPRY3J2WekXOQlUGmVM4fNTTeU4P6bnwFue9aN0=;
        b=rn/cwQB6UkNFnebQaMfrsf7WVgBoaLgaaeJN/429KihwUJ4nNgjfnR0EcMe4il7yL6
         7FwYpaXIPEXiYSM83blK+EgFnmtt0VOTaw1d2lU/kTl7La0ELXAKWHVPmJ/hlpyXCXfz
         f5vcHqVjzMmOX2UVwAwfQ26C6XzdRDauvb4RyK3um9GB5flPbBE7UTdZdc6Z9VLXtqiN
         SlbSK62AlU28fQtpslyVuXj5CsR+lWQeWnLasVNragf6B5RqVgbUOXFEWWGJc+3NrsGX
         GCkcnflmlXZpJKoU3r+OcO2HgGdkRYDc3dY46X57Kz9sGzts3NHDN0CB7dHurt+xFn8X
         CyMQ==
X-Gm-Message-State: AOAM533VDfmWJxyQZe3mmNJY2qETYIoQ2S1ZB5BO4uqECky3Vn7sZKnQ
        5/oAakb6JxDwWm9nccg5+bRlGw==
X-Google-Smtp-Source: ABdhPJwJfKYprVtgSwMv1foq2/oCXs/sEvqyI1//Vt1pmWYFBXMcO/AaEcENrAF0CEIlNJkmrTdKZw==
X-Received: by 2002:a05:6402:11cd:b0:427:bda5:542f with SMTP id j13-20020a05640211cd00b00427bda5542fmr1369606edw.290.1651393039410;
        Sun, 01 May 2022 01:17:19 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id zp15-20020a17090684ef00b006f3ef214e4esm2335099ejb.180.2022.05.01.01.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 01:17:18 -0700 (PDT)
Message-ID: <6c3ba4a7-80b0-5fd1-eb08-1f9e256b02c4@linaro.org>
Date:   Sun, 1 May 2022 10:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for
 Sercomm parser
Content-Language: en-US
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     NOGUCHI Hiroshi <drvlabo@gmail.com>, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220406195557.1956-1-csharper2005@gmail.com>
 <20220406195946.2019-1-csharper2005@gmail.com>
 <8d0d8b27-35ff-3693-cf80-897b80c26b4e@linaro.org>
 <57bebf2f-af4c-b2d9-10e5-19e5104946fb@gmail.com>
 <29cfa017-bbaf-3aba-fe1d-06771957dbaa@linaro.org>
 <1b391399-984b-7a63-3265-62ef09caec39@gmail.com>
 <bd533827-b575-caad-c230-af060851b231@gmail.com>
 <db70e53b-7484-43bf-e9c8-b6a2dce1fbb5@linaro.org>
 <25da3f43-c46e-8108-2da9-0e4f2b7cc1a4@gmail.com>
 <b279040a-a782-a2ca-2acb-2d8f07709081@linaro.org>
 <1c19faf9-fc1c-9adf-d038-97b673a8f0be@gmail.com>
 <a84df850-149e-9656-43fa-1f040368a9f1@linaro.org>
 <0450d781-c506-c28e-a0e5-435bee16721f@gmail.com>
 <2e51842a-d2c9-8953-13aa-02ad3abb3f14@linaro.org>
 <ee5f293a-e59a-03d8-d9e4-ef35d33b5383@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ee5f293a-e59a-03d8-d9e4-ef35d33b5383@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2022 20:54, Mikhail Zhilkin wrote:
>  patternProperties:
>    "@[0-9a-f]+$":
> -    $ref: "partition.yaml#"
> +    allOf:
> +      - $ref: "partition.yaml#"
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: sercomm,sc-partitions
> +        then:
> +          properties:
> +            sercomm,scpart-id:
> +              description: Partition id in Sercomm partition map. Parser
> +                uses this id to get partition offset and size values from
> +                dynamic partition map.

Partition offset and size values are not derived from scpart-id. I am
sorry but after all these questions - it's the third time now - you
never answer why do you need this property and what is it used for. From
all the examples it could be simply removed and the partition map will
be exactly the same.


Best regards,
Krzysztof
