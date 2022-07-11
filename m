Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD92157007A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiGKL2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiGKL1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:27:31 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854D973586
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:04:26 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a39so5733354ljq.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=FcPD4ifirYFuSYB+4m7Neq/k9V2vE0FU8ah5Vhxzqkc=;
        b=XPO5fyUuyaFVyokqrvz8S/Y3v1cJyoeYZnUu+pLonL/Sb9tky6Zbhr4pZwMrY+/sqF
         5KYMJOwcE1RTP4QrqbXoOxrHHPt+BSV6sOi7niPc5gMcHN+9A+E59s08MqKcrH0xbHAS
         DgnMHCBxNYke15GVDK9+3uHsUt2TvC2tq4MGMDMWDXMtVoxea5Tjz1+hijPjh8PnlL3Z
         QQx3rTuUKh47xfbhHiuCNLmT91MXojLd+DEIhrbUrBGwlctJccJZdyXic70fHPFbSbJw
         xZPt4Tv0DaIkLD4wG4BXjGb3AMxE58kjoowqqLeC84hGXaedgUYFwgGn1oh+9QAaa+f2
         9ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FcPD4ifirYFuSYB+4m7Neq/k9V2vE0FU8ah5Vhxzqkc=;
        b=ordWuDxhiOdCuAHrjoGgdYneu/Q3KuJsZ7Gk/eZw2GCO+7s4HJM/ga1gnqa93EKqgj
         e+1N1/qldKjUSmY6SJiojx+9I7Ofo9sOyBnUoqu4DNdp/yOe3iLD7C/eHTX7l5+sjo7p
         DQEYisBz4aaqj0SdUl+KUnro1ZyE5ZSLMzeg2yoAPypX1ojzc5MPv+MlVmcxkEafQa6n
         nk1tHvmX0lIDmaZTOQoLzxoNAbEWfqX0WJuc/RaXZghv9e3sM8JL+toTsuQ1OwU6hjRA
         ZaAhL2HbKki961mcUHz6cK7+UebzB5Q7z+mClJbqznHCtCnVT4hLVbU1fTU7q11E+7F3
         GpJw==
X-Gm-Message-State: AJIora/FZG1ZlpD1rPtfMg4mmj0DPyHr7uSSvO0k1UtzjnVQhlqIAWy8
        85nrtxh7FO0Sc/0MNz55IrbyCw==
X-Google-Smtp-Source: AGRyM1s+f/FraDvu9vaVd0mrJ8CWtpGy9hoN43l5cNzjkstfeo26jE67otBqly5d1l3gPmJJGFBsBg==
X-Received: by 2002:a05:651c:11c4:b0:25d:377d:3327 with SMTP id z4-20020a05651c11c400b0025d377d3327mr9444910ljo.225.1657537464812;
        Mon, 11 Jul 2022 04:04:24 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id i25-20020ac25239000000b004891b4a4acfsm1480762lfl.185.2022.07.11.04.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:04:24 -0700 (PDT)
Message-ID: <8f68fa6c-172c-688b-f5ee-2a59ccf04636@linaro.org>
Date:   Mon, 11 Jul 2022 13:04:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/6] dt-bindings: clock: qcom,a53pll: add IPQ8074
 compatible
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, bjorn.andersson@linaro.org,
        agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220711104719.40939-1-robimarko@gmail.com>
 <20220711104719.40939-5-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711104719.40939-5-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 12:47, Robert Marko wrote:
> Add IPQ8074 compatible to A53 PLL bindings.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
