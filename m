Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C844852E558
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346061AbiETGvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbiETGvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:51:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD3313F9C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:51:34 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u30so12707168lfm.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2sD0n6yJXGuDhEewc3lorHaqBnUR099vPCJ5WEpCDzU=;
        b=mOoGc9M7MZgxeaun4PGlBRo4C1JXBlLpYBpB0L6MScXAzAz4CQjEupqeEEiqIWVtoS
         yzsod5WBURL9tjzxFjdaKzclp79TQIts7pzJufezPjonrPmOg2kLST6Yz5yk0poAdEkv
         1FokQMf2YtyUEt6qDRhGfKp0jAmlbIhEPE0Y9yp1BlWPZddAsy6avCDFyvojQByppw3U
         YZdF+69jR6WSNT6qja7BKlhcm6UOQBYfk6GgCQMdG/v+I34ZPzvjSe2msGn5TGD8lKrK
         CkEzOdKtdYsHqPbRhaDRxiJDH5hUlWVIVsUbCi9Mslb5JOHLhOU32ArxKxPNHc/7iUZR
         xWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2sD0n6yJXGuDhEewc3lorHaqBnUR099vPCJ5WEpCDzU=;
        b=7knAv4VqKZcOpCgiyCIHsveerHwiiSiJdLhjcm+fK2pVhFORkwv0vv8Rh4uJlkLBD+
         7yMKV9EZiGYMSS8mGt/U/p7q2RhjK3KZ8ZFJR8wq52br6MKwO70bde2LwYNqDlqKjD1U
         YUd+RSuyN8kUKTQjeUxgKEyWer4WL1RsVjyB9PsPS4RXc2PLfMNte2gSWiMZccCwCMfy
         QyByNbkRJz7bYJPmZNk8FDZ6b/auRQ0AzdTfl/uu7htDxMjJgRwoPPUxjjDABHjKx2HD
         kUvi5e8Deg4blljNZhH1JKnOQP0Tqs5VgIK0+MF1blJ/fjwROZEy5bD7tvXh1rgB+hPP
         KApA==
X-Gm-Message-State: AOAM531qEPGnAI5V/cq0PPVWSDLhvEAbKeOiMdnyGHZy40rFhTfWZFFj
        XgeK0iQQul/TAY6nm9TamJWc2g==
X-Google-Smtp-Source: ABdhPJzaGbv04buuDHGp4NLG8WTmLEncJfxtJuLSgfyJWSMt4wxUrF1jnVPHvL9DO/40kuanoOGM6w==
X-Received: by 2002:a05:6512:398c:b0:473:ab45:1f7c with SMTP id j12-20020a056512398c00b00473ab451f7cmr5937130lfu.341.1653029492370;
        Thu, 19 May 2022 23:51:32 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g23-20020a2e9e57000000b0024f3d1daebbsm192250ljk.67.2022.05.19.23.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 23:51:31 -0700 (PDT)
Message-ID: <a0eed04a-1380-d96a-a406-217f053354b9@linaro.org>
Date:   Fri, 20 May 2022 08:51:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/6] ASoC: tegra: Add binding doc for OPE module
Content-Language: en-US
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1652895372-29885-1-git-send-email-spujar@nvidia.com>
 <1652895372-29885-2-git-send-email-spujar@nvidia.com>
 <049173a1-0fa6-510b-9169-ebe869b8a3b3@linaro.org>
 <90680cfb-c611-63cd-ab5f-5afb86c91cec@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <90680cfb-c611-63cd-ab5f-5afb86c91cec@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 06:19, Sameer Pujar wrote:
> Thanks Krzysztof for review.
> 
> 
> On 19-05-2022 17:10, Krzysztof Kozlowski wrote:
>> On 18/05/2022 19:36, Sameer Pujar wrote:
>>> +description: |
>>> +  The Multi Band Dynamic Range Compressor (MBDRC) is part of Output
>>> +  Processing Engine (OPE) which interfaces with Audio Hub (AHUB) via
>>> +  Audio Client Interface (ACIF). MBDRC can be used as a traditional
>>> +  single full band or a dual band or a multi band dynamic processor.
>>> +
>>> +maintainers:
>>> +  - Jon Hunter <jonathanh@nvidia.com>
>>> +  - Mohan Kumar <mkumard@nvidia.com>
>>> +  - Sameer Pujar <spujar@nvidia.com>
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^mbdrc@[0-9a-f]*$"
>> Why? We enforce only generic names in shared schemas and this is neither
>> shared schema nor is it generic name.
> 
> Idea was to keep these node names consistent across DT files and parent 
> node can allow a given list of child nodes with strict checks. Does name 
> like "dynamic-range-compressor@xxx"

The checks are not coming from device node name, but from matching
schema to compatible. Why do you need consistent names across DTS files?
They should be anyway generic but what happens if they differ?

Additionally, the parent schema enforces nodes of children, so if this
is included in other schema, then the change is pointless.

I propose to drop it, unless it is a shared schema for many different
vendors.

>>
>>> +
>>> +  compatible:
>>> +    oneOf:
>>> +      - const: nvidia,tegra210-mbdrc
>>> +      - items:
>>> +          - enum:
>>> +              - nvidia,tegra234-mbdrc
>>> +              - nvidia,tegra194-mbdrc
>>> +              - nvidia,tegra186-mbdrc
>>> +          - const: nvidia,tegra210-mbdrc
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +
>> No need for space
> 
> will remove
> 
> 
>>> +
>>> +  compatible:
>>> +    oneOf:
>>> +      - const: nvidia,tegra210-ope
>>> +      - items:
>>> +          - enum:
>>> +              - nvidia,tegra234-ope
>>> +              - nvidia,tegra194-ope
>>> +              - nvidia,tegra186-ope
>>> +          - const: nvidia,tegra210-ope
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  "#address-cells":
>>> +    const: 1
>>> +
>>> +  "#size-cells":
>>> +    const: 1
>>> +
>>> +  ranges: true
>>> +
>>> +  sound-name-prefix:
>>> +    pattern: "^OPE[1-9]$"
>>> +
>>> +  ports:
>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>> +    properties:
>>> +      port@0:
>>> +        $ref: audio-graph-port.yaml#
>>> +        unevaluatedProperties: false
>>> +        description: |
>> No need for |
> 
> will remove.
> 
> 
>>
>>> +    ope@702d8000 {
>> I would suggest generic node name, if it is possible.
> 
> May be "processing-engine@xxx" ?

Sure.


Best regards,
Krzysztof
