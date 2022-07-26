Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F25F580BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiGZG5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiGZG5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:57:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91105205F7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:57:11 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m12so20226325lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a/nsJTo76/ZSi4Jb8rP892B+zPLMmhE4PPpI4xGA5Qc=;
        b=DjlM/06RrYekNQUVoksqzwygMA6OhhU/TSxsYbYxoKU8FvmxkCFh0LevX3PqMZs+AM
         wVB6xkwOCZz9P8u3XI5lhRklLMcBwP+Wj+MANth4qKLi+KgHYQY5YCcbGKU8XE4awvC3
         2jhO2aTfKAM0Z3n4OM597FioUwKRvz/qfgZNcKCb2vP6Jz/zn0g5yoXrzMOQICIOQ6kw
         J/U5g3d0nt99n9/LOOJh33/TVlPI1qyQWLb5gokws2Oe3laWxzRhIeGmnCpf7jBNjwNw
         72iSQPmAkhT/fK7ZE7IRO/jFove0nXGhpuFd2kpTEk+P3qGPkyYRFx3teQgz60nAHNq2
         fCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a/nsJTo76/ZSi4Jb8rP892B+zPLMmhE4PPpI4xGA5Qc=;
        b=eHyphsSIjsfwSqadOeHVlxARTUmGEppH0knpnEQJhGi5gNrrIEuZGlUuub0X+ZiEVR
         3gxSdMlppmNQeTgnvBmkVE/9g4LnkWjORnT1z2YJtAuSmi2Mt6cneth3AHG6ct4hYlUR
         UM48NtqFZwhVb1qSkjfIRGHhbN5h/xjhBaDY8XUPtiI+7zzzTS2Gok06kNah/Q6XTnVf
         QZnyUhfhd7VMIhd0veanKaTL8y3xkThAq7+K2HnPIE1RyRAHlGIAKqfa4MG1Jy/U4FZv
         TtkUSAXA93Na1Mk8mA4fiJq0eONnq+p2d95sWHX1mC0FLvafhiSlEAnHODVay9hZKeiP
         Ju+A==
X-Gm-Message-State: AJIora93S30L71ghNtRklWqKLVHPO/Alk9HUhBrOks/SsatGnUs/XD3w
        3OTtNqGR8TFMUBBgcpmEy1aSSg==
X-Google-Smtp-Source: AGRyM1twE05S+ZYJgkbZAbx/JA6EM7VJunNeFf+2CWhW5hV6yNHi8A991h80iQkX7kR6gYWPYbfYWQ==
X-Received: by 2002:a05:6512:523:b0:48a:7257:b71c with SMTP id o3-20020a056512052300b0048a7257b71cmr5733057lfc.582.1658818629836;
        Mon, 25 Jul 2022 23:57:09 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05651c169100b0025bda317bdcsm3115725ljb.88.2022.07.25.23.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 23:57:09 -0700 (PDT)
Message-ID: <70255b63-294c-bda6-e7ad-7009f735b336@linaro.org>
Date:   Tue, 26 Jul 2022 08:57:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/9] Samsung Trinity NPU device driver
Content-Language: en-US
To:     Jiho Chu <jiho.chu@samsung.com>, gregkh@linuxfoundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Cc:     yelini.jeong@samsung.com, myungjoo.ham@samsung.com
References: <CGME20220725065308epcas1p2f6de3d74792854bb312cca4b310badac@epcas1p2.samsung.com>
 <20220725065308.2457024-1-jiho.chu@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220725065308.2457024-1-jiho.chu@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 08:52, Jiho Chu wrote:
> Hello,
> 
> My name is Jiho Chu, and working for device driver and system daemon for
> several years at Samsung Electronics. 
> 
> Trinity Neural Processing Unit (NPU) series are hardware accelerators
> for neural network processing in embedded systems, which are integrated
> into application processors or SoCs. Trinity NPU is compatible with AMBA
> bus architecture and first launched in 2018 with its first version for
> vision processing, Trinity Version1 (TRIV1). Its second version, TRIV2,
> is released in Dec, 2021. Another Trinity NPU for audio processing is
> referred as TRIA.
> 

Why there are no bindings? How is it supposed to be used on ARM64 platforms?


Best regards,
Krzysztof
