Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D2351F542
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiEIHZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbiEIHUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:20:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4088BC06
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:16:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ks9so18560772ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 00:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/q4d3OHrZvdq1tcu5svJ1FaMMKQIyrlKNH4TSyE5QtM=;
        b=mlL24byEHKNHhJD39spMy4tFbcQfcy8DCRoyWl+71T77EMUcEHWqYdlEHlmfA1IIkI
         ctwfNOdUTwHff30O3qav9Rlkcklgh2WdsOwicVaTOL2foZ7anYprqmnmNFjPH3fbi83f
         vVOncC1zPkceGlm6AmQ4bQMeqe+upmwsKelJBX4mls2c0h5p1kdRu9cZTTgma1KMUr2s
         aGr4vxSSb/BCNWDZG5z5z+Rm6KjozlnM23Z23ghY84QEOiwQUMZTQglnfWkmukjjlyTX
         TOvOzy2sOnLP5SIew4eWkX/oe6XjLxHVk5JLpgvMuDCdbqMt2p6ujPh24bbx0azI4aAI
         tTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/q4d3OHrZvdq1tcu5svJ1FaMMKQIyrlKNH4TSyE5QtM=;
        b=gqeIQeXx31absCOZKTryDe59BqJSpHV/9VqQSIVfPJYXKobwhYzTAJFjeehZwxZHW4
         blGegB5/wFSmKsPeg57Z26C1aqp8OQR4XDA3GPvr6dK/lvntwedWLjrfV+JdHXUG9od9
         v2jNaf9Ao1E4Os0r1eC4pRMXrOQ/wd/xOs284bCdX6KdVPXh2TNSacMpt4xJ2h8ICsgk
         +cyOGMb1eDGECz6caIAiH9kfbBBST4F6vFmP2ZvD0fCnOlIX01KYc4DywlEdsBH+llTy
         Oz0psBfllcyIX+rOTOqZ1yUziHT1/moOgcBVVjOWeQZullD9x1SZ306yKRjLL9ZyEo+f
         /IOQ==
X-Gm-Message-State: AOAM5306+HrkdIPO13mvh0ichzJTe0mtbCyQJcCbk4K8SK6mDGDyJCeV
        DAwdvn3e2ue4XTeZbOheHXfvOA==
X-Google-Smtp-Source: ABdhPJx11KaoIOBoxzezk7OjBrcz0m+M7R7hALB4LLuEiqyNltMkiAXGFjD3aRSGOCHjRpGmCIX/vQ==
X-Received: by 2002:a17:906:2a19:b0:6fa:7525:45d8 with SMTP id j25-20020a1709062a1900b006fa752545d8mr3201491eje.768.1652080554493;
        Mon, 09 May 2022 00:15:54 -0700 (PDT)
Received: from [192.168.0.242] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y1-20020a50eb01000000b0042617ba6392sm5845956edp.28.2022.05.09.00.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 00:15:53 -0700 (PDT)
Message-ID: <703ef9c7-40b2-6b57-82de-c66c2a1e8268@linaro.org>
Date:   Mon, 9 May 2022 09:15:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 08/11] dt-bindings: clock: qcom: ipq8074: add USB GDSCs
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, bjorn.andersson@linaro.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tdas@codeaurora.org, absahu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220507202948.397271-1-robimarko@gmail.com>
 <20220507202948.397271-8-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220507202948.397271-8-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2022 22:29, Robert Marko wrote:
> Add bindings for the USB GDSCs found in IPQ8074 GCC.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  include/dt-bindings/clock/qcom,gcc-ipq8074.h | 3 +++
>  1 file changed, 3 insertions(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
