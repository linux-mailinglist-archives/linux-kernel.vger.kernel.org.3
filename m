Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C9F565566
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbiGDMbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiGDMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:31:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511631054D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:30:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t19so14899215lfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=2WKW73jnC4LWzwI3qorj4+ZQ81YVaSquXphoilzakuA=;
        b=VUXfxjc4uz9mvItvgzJKGaKKyy9+JPixtYfsrCplalcxutWLi9VsiA16DUjdvWUBay
         BDWtLuOWaB6UnWumLfNIqwrEuALvpfeksgE6/acnEnyjSYvCcpI+eq7V1LgckjQ5P5UB
         VN/MET+Eh3aVLSKGSm7CVQt+2hDdE3XEmAOm+sH75oEFWG1WHOwpdj0c/RnpJnJf/Gki
         Q3/X+sTEFyn4Drq9baiwaoqfzNZB0VhAqW2e49URUwoOOwv3EDFuH+Rdz+oNKFpSsS6T
         Nq5nHLgGVaw4S2WX2r+Xu87sw7ZGEhnhllN2TLvCp7fLOevNXZM/I/CN7cUurqq3t+Wa
         9Txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2WKW73jnC4LWzwI3qorj4+ZQ81YVaSquXphoilzakuA=;
        b=vi8YgfuuBoBYHc8afKUYnsjAyClR4QfYH/xJid9wQRpxh2ogvckimehQEROnnxnpVh
         l45vZvurE1EwZqlD9TGsINBOcODp1wkKiKVjfleE8Vu4L2kkLMPa6AJdb3YmA0iaH4g2
         L1FHL+QqX/wKRfsChCeOaPwYxh+YMO3SBPxMf9QUiMnEj1cGkblhiWowpIRQDepnwHsa
         n023XSuOLY+Hb1nw2Uu9D8YLL8b13t2pFFutnAwPSZhr37rNmShPhgevsLrI2dvvKRQY
         PU7GFmsNmgdD+knjd7Wi3F+kkXxQGJ47ce2+7hqkZRg3X/mqMCGtlEEdPKsbeLHeZFLF
         PZ7g==
X-Gm-Message-State: AJIora9cvHdCWHT4kBKXBhs4IiNxw2PIKYVRd2DDIzsRa0HBbHnqubXb
        jwy/NlHkq7yCw/GYhyUXMWZyvA==
X-Google-Smtp-Source: AGRyM1sY/fZMUL+/U63wdSeuPYyZncc1o5an/SXYkBTqwQdP2tP1zi1o6eYwviMKyV5kW1nXHLjWIA==
X-Received: by 2002:a05:6512:e95:b0:47f:9d60:d90a with SMTP id bi21-20020a0565120e9500b0047f9d60d90amr19901224lfb.591.1656937854643;
        Mon, 04 Jul 2022 05:30:54 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id t30-20020a05651c205e00b0025a75057c46sm4954452ljo.91.2022.07.04.05.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 05:30:54 -0700 (PDT)
Message-ID: <8f6f1bad-6ad7-7092-7395-145cfe565ced@linaro.org>
Date:   Mon, 4 Jul 2022 14:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64: dts: ipq8074: move ARMv8 timer out of SoC node
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220704113246.622917-1-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704113246.622917-1-robimarko@gmail.com>
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

On 04/07/2022 13:32, Robert Marko wrote:
> The ARM timer is usually considered not part of SoC node, just like
> other ARM designed blocks (PMU, PSCI).  This fixes dtbs_check warning:
> 
> arch/arm64/boot/dts/qcom/ipq8072-ax9000.dtb: soc: timer: {'compatible': ['arm,armv8-timer'], 'interrupts': [[1, 2, 3848], [1, 3, 3848], [1, 4, 3848], [1, 1, 3848]]} should not be valid under {'type': 'object'}
> 	From schema: dtschema/schemas/simple-bus.yaml
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

This is a duplicate, I guess... I responded to newer patch.


Best regards,
Krzysztof
