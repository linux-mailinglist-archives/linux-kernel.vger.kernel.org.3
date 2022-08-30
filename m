Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7475A6CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiH3TEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiH3TEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:04:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0825861DBF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:04:20 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p7so5693881lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1HAJgIAHEJqsajZozy9olYgVARt50tT0qURDFW8nTY8=;
        b=RtLwh18UUnowDD0ksEDAXTTsjdpyz7Bv2R3AdBRP26eS9bcY6pwJj2Jcx+tBRBT0nW
         f5wU20+h7Yd15bBkoWHIoLmQ7Cb4yfDjBv0InNxlIbk0+n5u+E3S6HQ4so/UWs35vNS6
         z04qaQO7qifxa9JgXGSQ9fVhc3MX2L6uvh6jnSKD9e/+b+Czv8XUOV0qr/ESGYdEws7z
         qo7inpPDO6W7Iau2x59gtGAuOF9/G87zpf4EYJ5/JKuAlrEQDcQbQJKDGToElgSA0Yyw
         wIgTC8niiIfdI2TDPwIhD3pnt+grtE72n9t2O6aaDegfzDDZ6Qe0Do3KeP2F7hr6IsYO
         H+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1HAJgIAHEJqsajZozy9olYgVARt50tT0qURDFW8nTY8=;
        b=MXc/a2hDF2MuNpMQsia+0BRQzjlmF0JoodFGgeGk9uRts8rESn+E1ah5nKQ4Qys/F8
         n2fq850u+3I9d0pWAqVMM8RIsnd2vSL+hvgkRNZluFP48HybBlomvNO6lEACiO/DQM7a
         2DPeYyqau71y09br4P8rPOERky6VVhnISVN7eYyT0Q4r8/cjzQNOt43KFKXzuL7vpZrO
         PdnO0wH1kJEWBuSGE9laqawDJMQomaESSJXKG6yvWYe93V3HpcUZEKioW24L0jBf1JbA
         e513PrKSNedvQKbt5q2Y+72ZHpMZEyzjnzTE5N1leLzUErGkJOvxj4KDP266ovh8Y+6u
         d+dw==
X-Gm-Message-State: ACgBeo1paxWuzAgf3dXjcwlP5awZ79M6dDsLxRwvcgfELy2jclRbtHi/
        VqK4aTLWuERH38aQeiK2X1n8+g==
X-Google-Smtp-Source: AA6agR7TK8PMmhNU/ANRQ6U0u7NBMwa95d2Kcc/oVQSq5FihD56HEiuJhHEM4vHNoPhzEi3tZ6fq6g==
X-Received: by 2002:a05:6512:3b8e:b0:492:f799:76b9 with SMTP id g14-20020a0565123b8e00b00492f79976b9mr7687972lfv.207.1661886258245;
        Tue, 30 Aug 2022 12:04:18 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id q18-20020a2eb4b2000000b00265757e0e66sm886322ljm.48.2022.08.30.12.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 12:04:17 -0700 (PDT)
Message-ID: <7726d82f-d0fc-2a68-fef5-bb991b0d73ad@linaro.org>
Date:   Tue, 30 Aug 2022 22:04:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v9 1/3] dt-bindings: arm: qcom: document sc7280 and
 villager board
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>,
        Jimmy Chen <jinghung.chen3@hotmail.com>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220830182923.3720287-1-dianders@chromium.org>
 <20220830112818.v9.1.I4fa927a776951095d55c41ddb64149c8c0eae57c@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830112818.v9.1.I4fa927a776951095d55c41ddb64149c8c0eae57c@changeid>
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

On 30/08/2022 21:29, Douglas Anderson wrote:
> From: Jimmy Chen <jinghung.chen3@hotmail.com>
> 
> This adds a LTE skus for Chromebook Villager to the yaml.
> 
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> [dianders: adjust LTE as SKU 512; remove two variants of -rev0]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v9:
> - Squash https://lore.kernel.org/r/20220829084732.1.I9ef7f8b909a7afbef9ff2251a98c67033f37b516@changeid

FWIW:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
