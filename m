Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08BF57226F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiGLSUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiGLSUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:20:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4BFA44CC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:20:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u13so15342009lfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1gzR+wNqtuyrFm1FNlb8hG1Ws+B4tsa2kbSPanKefOs=;
        b=MdrqVdGHPFBC9uUzUWcPjdhJI4i9ybaD17Rg0ed5ztTaTJU0xfsWJLypKwrV3fEV6F
         aM7QgXJnr+avFwhfNGHGsGoLiIycb7aF7eawv4qbSo0vZy6S2wZqkHWzf66F29z9Nn1n
         Z4Wb2D6t3BbQxnVXcTv5JRMi1YzZ2sNhLkRXoleFt44jBS55WWgtWYlB7HoVC/0LCx2V
         FdnvaVwggTcMoOVfi3M7BJflf0EdG6xTQ5rv/dI8pVft1Mh255g6DFc6/CROUiLNLCKH
         lvvlD/wOCa569Jh+/06kHzoilhwxHI95TvwJYg0N472u1D3m1yTNOOnENnxhPPLtGsBE
         s9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1gzR+wNqtuyrFm1FNlb8hG1Ws+B4tsa2kbSPanKefOs=;
        b=hPqzexDweUob1lyQ+R7NL+v9HoasO5efYAeLWXjCmh4coD+8fr4RoMKdIKPjZSFVPu
         CnIMgcmFnXf69dwB9kjnjcNHrw7gSRaottsfYdkJFUN+/I86CMEQoN6sxdvQGQBMp9ZC
         g0iERsb65XyiTEdQ3ZoaWqMw2GkwuVmIzwdABTJiV1umuij1tquTg3+hnkwVVZZtARDw
         8kvS5Bqz6bQF6POLhZlWgjtwKx6DWR3UB8iMBSBwmvZBJh4r3oFZ/7JhEAE25PaDRqFA
         EqrEajG5JlXlO1bLy2kS6rGbVGTiKd+Mqage8a4nMLDHnQLLW52BipnqGnvGBTt3jhiO
         uYzA==
X-Gm-Message-State: AJIora/mcrjVD4YS3o7KJhChge8OyCyhbqkCX1BRGB9b2x17PHadqYZm
        Od+jsy5psFowPzFemVj+YIrKDg==
X-Google-Smtp-Source: AGRyM1vHeLvHwkweub6jEy2PrrfXVMh6MiTdXVhFvmcdwtG8Yv2b+E2aj/xsO+uWv9VWbmmSPmeBKg==
X-Received: by 2002:a05:6512:39d5:b0:47f:6e9a:5bf with SMTP id k21-20020a05651239d500b0047f6e9a05bfmr15826527lfu.580.1657650035973;
        Tue, 12 Jul 2022 11:20:35 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512070b00b0047a0300746fsm2299470lfs.304.2022.07.12.11.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 11:20:35 -0700 (PDT)
Message-ID: <5c79330d-7786-61a8-b464-d7e7171a7aab@linaro.org>
Date:   Tue, 12 Jul 2022 20:20:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 3/3] arm64: dts: bcmbca: update bcm4808 board dts file
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712021144.7068-1-william.zhang@broadcom.com>
 <20220712021144.7068-4-william.zhang@broadcom.com>
 <d93e55fa-3359-2609-aad5-c80eca78f380@linaro.org>
 <900ac3ed-a77c-3cc0-f5ab-c45267a1a4ba@gmail.com>
 <6b7bab04-90ce-6111-35bd-42cb3a1f73f8@linaro.org>
 <9bc3e0b6-833e-375e-70d6-1dbd036ef25a@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9bc3e0b6-833e-375e-70d6-1dbd036ef25a@broadcom.com>
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

On 12/07/2022 19:48, William Zhang wrote:
>>
>> Best regards,
>> Krzysztof
> 
> The reason for this patch is to keep the bcmbca board dts in the same 
> format and keep everything in the same yaml file. 

Not a good reason to change compatibles. You can have the same format
and keep everything in same YAML file without replacing compatibles.

> Understand 4908 was 
> already upstream but luckily there is no driver in linux and u-boot that 
> uses these 4908 compatible strings. They are only used in the board dts 
> as far as I can see.  So it does not really break anything in the end, 
> unless someone use them in any driver but never upstream their code...

So maybe just briefly mention it in the commit msg?

Best regards,
Krzysztof
