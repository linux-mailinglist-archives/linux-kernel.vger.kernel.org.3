Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C433A5273BD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 21:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiENTcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 15:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiENTcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 15:32:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55771B79C
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 12:32:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h29so19765478lfj.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fXzV1fpic6FIBZFtsxUjhfRXDG+va5qpRFfngHIik8E=;
        b=WMwBL9u+A7cVFaSFpoSvfQhotjddSY3EEfSStc/go3iWLy7T4NqDaod58gnHU1T6tR
         wCYfEEHhQ5L1xTZcF8uiyLWh2mJET+ibN/8dtyMkATHs1Y+W/rIhs+qVls6IG+J1Qnyf
         0wRGdwZhCF3ZFyfePovHpgZYVssiFt1X4SnGLnQkPv6o9t+0fWEUzT05nVparICioHLg
         FWsIDfC7Ta3IiKHQS81GQyErMdey8NdrKvgB3l4VDgqAS8V9XoOSMI7dCIbBcuRMHP0V
         OkWnBgClT2qMSjiFN4LPWsNPbZAiwo+XJJ6Qd2muplhM2Mqi3MCQECnKH13Cx5WN6Ib6
         PQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fXzV1fpic6FIBZFtsxUjhfRXDG+va5qpRFfngHIik8E=;
        b=2JXHWv5cm2URCadKh6UHIla6DYlBkghsSQR2KbTrAI7xS+lu3yvha3JZzPuBVTb7FC
         iZYQIlnafCkgkLAVAmUzFJSHcwRcMDrNVxQ2JF1B5jqPojngfikvEAFDfQ8oHztrh0t6
         OtWJPyUB6CfK2oZdlwX/IDK6xWSKDQhsoFCapu8zGROSGQ6KxnvF4EKLXixrPv45zEGM
         D3nPWg7ynFP+cdXK9w9bkdO8ov/yWgb1gWt3LI4tBkZb4/KwlUk98U42s7frK/HOJr9Q
         0uhBKuLtcFS+Y9L80nEiqCf+3Horypt4B+gaWrDFrDh/rCTuf9LVQYAZttF8Cle0Hfui
         wAOQ==
X-Gm-Message-State: AOAM531iNCE2n3LeTfu+nl0iJcGrSbOoj8gg3XIsaudQNFX72gyv7SI8
        V3+QKRxzMLoJvldPW8vZEPEGWg==
X-Google-Smtp-Source: ABdhPJwe5i88awrmyIJNqgBJD6YgpXCrsim3T+efhyaQX+lVYDbU3HXxwumOjap7znAZcwsvxAG5iA==
X-Received: by 2002:a05:6512:3f8c:b0:45d:cb2a:8779 with SMTP id x12-20020a0565123f8c00b0045dcb2a8779mr7745769lfa.499.1652556729330;
        Sat, 14 May 2022 12:32:09 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f13-20020a2eb5ad000000b0024f3d1daedfsm896630ljn.103.2022.05.14.12.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 12:32:08 -0700 (PDT)
Message-ID: <93181c1d-16a7-697e-976c-190b1c99f2c2@linaro.org>
Date:   Sat, 14 May 2022 21:32:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ath10k: do not enforce interrupt trigger type
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Govind Singh <govinds@codeaurora.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
References: <20220513151516.357549-1-krzysztof.kozlowski@linaro.org>
 <87zgjl4e8t.fsf@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87zgjl4e8t.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 17:57, Kalle Valo wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> Interrupt line can be configured on different hardware in different way,
>> even inverted.  Therefore driver should not enforce specific trigger
>> type - edge rising - but instead rely on Devicetree to configure it.
>>
>> All Qualcomm DTSI with WCN3990 define the interrupt type as level high,
>> so the mismatch between DTSI and driver causes rebind issues:
>>
>>   $ echo 18800000.wifi > /sys/bus/platform/drivers/ath10k_snoc/unbind
>>   $ echo 18800000.wifi > /sys/bus/platform/drivers/ath10k_snoc/bind
>>   [   44.763114] irq: type mismatch, failed to map hwirq-446 for interrupt-controller@17a00000!
>>   [   44.763130] ath10k_snoc 18800000.wifi: error -ENXIO: IRQ index 0 not found
>>   [   44.763140] ath10k_snoc 18800000.wifi: failed to initialize resource: -6
> 
> So you tested on WCN3990? On what firmware version?


I run it on a Qualcomm RB3 board with Qualcomm SDM845 and WCN3990.
However on that kernel I did not manage to WiFi actually work -
regardless of that patch - so I would no count it yet as fully tested.

It would be great if someone would provide some tests. I saw Steev's
replies - thanks!

Best regards,
Krzysztof
