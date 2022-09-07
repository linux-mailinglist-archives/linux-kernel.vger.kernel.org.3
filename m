Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196FE5B0237
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIGK6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIGK6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:58:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627FB4F670
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:58:12 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l12so7065193ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 03:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IKM8Q7h7DhmkZcNT/ovGbRUjTQGFQvPY8l9yVR39E2Y=;
        b=VN4CTK1wTSHhO/JQHt4YeD14+4Bex9SURm9ys2I9Y9E1VK321hgUU3Vg+BrhRsoJyH
         ZylejopAIlyxFTa2No8cof4nkKLZ5qwshND72RxfCBRPRs/TdR7XFigsAXXNt4o+NhkY
         8ygZol/PORK29rql4KzTPO7+oWoY/X1F2WPrKm9Oo4KYe6bHGB6/6FfawTwwZ6ykWo5t
         wEHIjKwWOUAXOSIWvSnszCDfyA+38LKjRxCaexpuENogUHm/YFnZ3FjiXScJ5yFQAhs8
         bY6R7v9DAv8JC/9qsJA/BceRVEQu7ON8HXX6yJ6IPHbEsIIvBVj2NJ0173M1V69yi50q
         yi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IKM8Q7h7DhmkZcNT/ovGbRUjTQGFQvPY8l9yVR39E2Y=;
        b=d/cV044VAnk0e3vbFihUrcPaIDEyKKNBOmgJlotmLpMr1wzJipJvNiwzyphDImlzzX
         H4DPfAmcNsIip9VPj0AlJaurPTW8dmQdwGftgqMO1CoR4tvHdOWxvqCoUdF+i5JlFEN7
         fL/YDmcJaxBdyehl85eLksr8mpQRtvYgoCx4ZDxSkhqG2mivbAx8CJ7I0K/F3rGFTA5c
         rXqA2CMZbjEjXiMLd/dx6SM7CeJShYam/EGHqPHOKCNtJuecCAgUfoen0a2IDdSp3H7b
         ZjZlzxsdL++HfBWzyJ0wv0VZf36rmBb8iou9e8uSBt25eiuqVGtSuKeTWWxEYjK9VOdx
         5fSg==
X-Gm-Message-State: ACgBeo2d8O5kBhGkLwPDRPJEjVs8F+lYFhznGFRRqIBIWbXW7nWkp9WE
        E11/c2ZtGj3UqtcB6LUsMOAWXA==
X-Google-Smtp-Source: AA6agR5oDFn7ilykcXLvWcVzwobc5wxgalg0pbv8etU2MwU03o/ikyPHsbImXPqq3CXmJF/7zRaurQ==
X-Received: by 2002:a2e:2d09:0:b0:25a:816a:2e62 with SMTP id t9-20020a2e2d09000000b0025a816a2e62mr759769ljt.147.1662548290798;
        Wed, 07 Sep 2022 03:58:10 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t12-20020a195f0c000000b0048aa9d67483sm2399815lfb.160.2022.09.07.03.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 03:58:10 -0700 (PDT)
Message-ID: <e1145bd8-e477-9a20-00cc-3d5f5e4f7977@linaro.org>
Date:   Wed, 7 Sep 2022 12:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/8] Support for NVDEC on Tegra234
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220906132823.2390953-1-cyndis@kapsi.fi>
 <68ff1b7e-51e1-f1e5-dac7-5419472e396a@linaro.org>
 <1dabfcbe-7729-1a96-816c-68ae524ed4aa@kapsi.fi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1dabfcbe-7729-1a96-816c-68ae524ed4aa@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 07:27, Mikko Perttunen wrote:
> On 9/6/22 20:50, Krzysztof Kozlowski wrote:
>> On 06/09/2022 15:28, Mikko Perttunen wrote:
>>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>>
>>> Hi all,
>>>
>>> this series adds support for the HW video decoder, NVDEC,
>>> on Tegra234 (Orin). The main change is a switch from Falcon
>>> to RISC-V for the internal microcontroller, which brings along
>>> a change in how the engine is booted. Otherwise it is backwards
>>> compatible with earlier versions.
>>
>> You need to describe the dependencies, otherwise I would be free to go
>> with applying memory controllers part.
> 
> Hi Krzysztof,
> 
> the memory controller patch can be applied independently.

OK then... but looking at the code it does not seem to. Anyway kbuild
robot complained so I expect v2.

Best regards,
Krzysztof
