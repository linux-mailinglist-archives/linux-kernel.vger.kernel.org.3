Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C884F8F52
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiDHHSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiDHHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:18:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2A21E6FA3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:16:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bg10so15521371ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ieIB5YqKCN+PKXGT2YPOFVPgHW/BR3G7k5u78AwWmig=;
        b=GcgJvyKPOGEwA1acdO+/0TE7/6G823io8jdY0AOuSRmGqbqrioIZUnDMq8g4JIoaER
         KwVlPY86OcLfbvqvHXq2jqy71sShCcBthzAmNCZOXq8PT7804u5TSAach/lu3Q9GxXT+
         Y16TKLuKtjy+WksAlSEbML5TJzj6WrRXV5YUAvaRJadV6K+F7t9iZra3KYbodEBQae2B
         nfT4RKsFeRDp6OIVkSGRFsku5AMdL9AuS0VmDqaZLsNxbXpVfwn9OtLH5NJsPaTsn6IF
         Z21YdpKH1H2+eKO0fFXhn2efRdGZGSitICMgvTHRYNYYqxj2/IzBvBvzMFaW+J2w4yP2
         56kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ieIB5YqKCN+PKXGT2YPOFVPgHW/BR3G7k5u78AwWmig=;
        b=45YMlNPNtrcEI07Is/9hKP0/bGn+RX4/2AQGmZlA4DGSG42qfBVSdW3DURoEfU+mXu
         GLB+0Yw6ZCRhkMmYZK4927VmXeDSSapyQaUNUJbB5Qh3kfqWcm7iSP+B8Ons81D8kKJB
         SxBWs8hW3zvLY/AfT6KR3ceywU54xDYKUWkmqj5BpvmhD6XJrxG2UXEvs8h0/ISf5c9V
         qYIMCvfL71+WvxaZicTqXcHKsj77c0CprtjUkEpFRLxWA98/eDwh+1dd27L66SO2ZfD9
         ZZhbv/NRpfauvZFwPRb04v6IgBuyjmlr2J8iByRZSjTn5s+WfbcT4uXmbqNm+ZRtE5hF
         Cjeg==
X-Gm-Message-State: AOAM530hTxqnmR4m/sO0TKe5av/nS63e9zgyIlcxSYy7RJr+8VvLr6lI
        CwMr44dK3HKXTosHyj2PKz0wPQ==
X-Google-Smtp-Source: ABdhPJwzgDoQ0K2hEotiMSP4godR914nen/RCVo6vbJ+AvYQCq2Vhtw0UBtd9Jl/fMpd3FmrhXEVaQ==
X-Received: by 2002:a17:907:8a02:b0:6e7:18b9:5f43 with SMTP id sc2-20020a1709078a0200b006e718b95f43mr17251110ejc.148.1649402198311;
        Fri, 08 Apr 2022 00:16:38 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090654c300b006e4e1a3e9d5sm7963714ejp.144.2022.04.08.00.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 00:16:37 -0700 (PDT)
Message-ID: <f56df7f8-9ec5-efe4-df36-c3e2151b1cf0@linaro.org>
Date:   Fri, 8 Apr 2022 09:16:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/4] dt-bindings: timer: exynos4210-mct: Add ARTPEC-8
 MCT support
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220407074432.424578-1-vincent.whitchurch@axis.com>
 <20220407074432.424578-2-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407074432.424578-2-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 09:44, Vincent Whitchurch wrote:
> The ARTPEC-8 has an MCT with 4 global and 8 local timer interrupts.
> 
> The SoC has a quad-core Cortex-A53 and a single-core Cortex-A5 which
> share one MCT with one global and eight local timers.  The Cortex-A53
> and Cortex-A5 do not have cache-coherency between them, and therefore
> run two separate kernels.
> 
> The Cortex-A53 boots first and starts the global free-running counter
> and also registers a clock events device using the global timer.  (This
> global timer clock events is usually replaced by arch timer clock events
> for each of the cores.)
> 
> When the A5 boots (via the A53), it should not use the global timer
> interrupts or write to the global timer registers.  This is because even
> if there are four global comparators, the control bits for all four are
> in the same registers, and we would need to synchronize between the
> cpus.  Instead, the global timer FRC (already started by the A53) should
> be used as the clock source, and one of the local timers which are not
> used by the A53 can be used for clock events on the A5.
> 
> To support this hardware, add a compatible for the MCT as well as two
> new properties to describe the hardware-mandated sharing of the FRC and
> dedicating local timers to specific processors.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 

This is rebased on my patch:
https://lore.kernel.org/lkml/20220407194127.19004-1-krzysztof.kozlowski@linaro.org/


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
