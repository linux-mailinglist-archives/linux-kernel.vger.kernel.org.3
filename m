Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD2D566A6C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiGEL6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiGEL6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:58:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBC710C8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:58:42 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id j13so1013986ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 04:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ixOkSjqSv3S8pEEk/BdvTn/xwH4HKgghg04zBNBUfaQ=;
        b=Agcpr1EXhYaU9R92S8KGVA8cRs2KrHKFnMXRYHk+knToAcoA2A4mMYJ390qpgFUAV4
         CO0NXqIagQweDr4Asvm1+RqV9Zm5t30eZMgkE8ZpfONnhIPnm2O1bKryuZmx9ynakqVn
         MF06UWnYMfO/wxqiMV6EAkaO/dZcJD2XMv3exnO9EbCO2mOY2zdb+D/PpnGLOl5SOGcw
         kiOqM65gTwaMfssI+T9JQlWJD3IOu/EIdk0dPNDxbqvcoQOVPwi1e1/jS/H3nJZZR7z3
         BKZmc9gEgQJdRlwy67OHnz9HCPcpklxHHOPCgu4d3zmVfahQXoeMZeGvw87ty6hk9HoJ
         f9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ixOkSjqSv3S8pEEk/BdvTn/xwH4HKgghg04zBNBUfaQ=;
        b=UyMRAlm6qoSRbA4OAmkGOndx+pBIi9EbPYC5kYdngHyKX1S8OJ+nZfbyJ73MyZ1g3b
         ET7Gj5eE+a7IS4RX42HJuH5vLwNGUNwMDQsFhMwRX/mE3ntyx/z18+5i1READsu5KuBZ
         z8WJNBnG6husQnRZxyaXKICmy+mw77G11JXtSbT7fWGawhFSoLd3pPijMf/LnoAi/T4b
         F5d9NLPpzkNmjrOFZ+PaumbzbcFbqBVFaMofoj3GIm+ddC9FVuh5uYB4ppEbRn7yYaDU
         8/o8iFUCVLsU86vGUrZKWdmZIhCsiZguDPCjPoN2+IyCrCWXRkMcYt83BNfQBHZ0sT7n
         cIgg==
X-Gm-Message-State: AJIora8KyrLMKi22Uybc032NlR/GKuFzeJYsx9i51rWNtAYZ9RpAW0OU
        AumBWYEua0HZnm/ogPsYMOLS9g==
X-Google-Smtp-Source: AGRyM1vAgY1pWA4h6fcuceb241vDkPl5k2k0PA6Jo4yGx+M1WHPyyi1KSHv26sJNo5ThgUdQD1Si9g==
X-Received: by 2002:a2e:8941:0:b0:25d:3887:a4 with SMTP id b1-20020a2e8941000000b0025d388700a4mr1049380ljk.232.1657022321295;
        Tue, 05 Jul 2022 04:58:41 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x19-20020a056512079300b0047f785a3bd5sm5652654lfr.298.2022.07.05.04.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 04:58:40 -0700 (PDT)
Message-ID: <8cc0daa4-35c3-3225-3caf-6ed27f68f77b@linaro.org>
Date:   Tue, 5 Jul 2022 14:58:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 03/14] arm64: dts: qcom: ipq6018: drop USB PHY clock index
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705114032.22787-1-johan+linaro@kernel.org>
 <20220705114032.22787-4-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220705114032.22787-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 05/07/2022 14:40, Johan Hovold wrote:
> The QMP USB PHY provides a single clock so drop the redundant clock
> index.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
-- 
With best wishes
Dmitry
