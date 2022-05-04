Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C1451A345
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351944AbiEDPM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351910AbiEDPM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:12:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D85640E60
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:08:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n10so3472272ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OvVWFDJHVBQ2gAFb6YOBhaG9PIC2m/VMXu8QQADNdLc=;
        b=ZsTJAqdm18tvarOdlZrUplyaMpMT48eO1YW7m3yfZgW/UzuBzQ/EYGlto1CYFX3vFy
         t9amHZIt1/kbASG/QbevQmMPhD1h+kcKS1Wwlga9uXmY/FmReaG4/qDZemD2p2m9oS8O
         moXPoMXcscuD5b/POKA/BkOKlc9GY2/c9MN4Q7ld2yRoqrGpK15M48iv2SPKGpzJQRZy
         5FJpb+eDExfJRJbSCGZMAapmNhojdD+N5FIhzshM4OL7iu/IxlAO5B92tddt6g0ng0+G
         Cjzcxhpx9iU/EvG7ChlbYQ+OQGQdiYdHilgo+cAL5QO88Y5DPOs/RByJdT/6zLteAvse
         jL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OvVWFDJHVBQ2gAFb6YOBhaG9PIC2m/VMXu8QQADNdLc=;
        b=WPvT+Hcvv8AtADShHNIJCA64Z7l2T5UlbS7iH+HwlKXX39y+X/Z71fOFL79GDLJYTD
         1GjJscuwy8sz2gzfF32mjwcxzXHqJK4XsZBnqtPboELGqO/GbCAmCMRi7U2AzLWA7nEo
         B1FabbHsXrlPjU7fc1dKpfyHFCHBdiK5sgm/p14pZqLTxmur9oQyxM8PMuWNmvOLV7qT
         aelGo6L7tz5N8e3oLNuSw61s8tbyToTk0xtYqoK9wb+aAxAKEebHz8T51cr4YLL5an+R
         q0N2vuiQKeHFWFbunBpvyM/VkN26W4YbiKF8B9FUwFbBxezzNcyGWPnkHCZHRANKN1tK
         vONg==
X-Gm-Message-State: AOAM532ra93rhPunYy+VrRFYDvzsmsLbXlifO/bA9a+hHvFgjlkoftu3
        SgZ9pJgZR/lOnkvOw2ZJXWoi4Q==
X-Google-Smtp-Source: ABdhPJxmVQA4qV7ej58brqZ2gGQycy2rr2zls5Bx7lvSEtC5wJ7j+/HiJkxyVO+vbZE/6lEnkT3GVA==
X-Received: by 2002:a17:906:c114:b0:6f3:ad4c:c886 with SMTP id do20-20020a170906c11400b006f3ad4cc886mr21460881ejc.124.1651676920086;
        Wed, 04 May 2022 08:08:40 -0700 (PDT)
Received: from [192.168.0.215] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402345500b0042617ba6393sm9202157edc.29.2022.05.04.08.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 08:08:39 -0700 (PDT)
Message-ID: <02b65b74-c37d-0bf6-5cfa-883b20c716ae@linaro.org>
Date:   Wed, 4 May 2022 17:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible for Qualcomm
 SC8280XP
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220503163429.960998-1-bjorn.andersson@linaro.org>
 <20220503163429.960998-2-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503163429.960998-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 18:34, Bjorn Andersson wrote:
> Add compatible for the Qualcomm SC8280XP platform to the ARM SMMU
> DeviceTree binding.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
