Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8A566A70
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiGEL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiGEL7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:59:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4D7261B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:59:00 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q8so1760081ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 04:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pJ7EuHzT7tGyPRYJa/JXc5Wvnw7Fpu6vsSqUw7XjkiA=;
        b=is66VQF0SAirKrEP3O7KWpr8p1KpL/fm9JRmaXj2pUgKwJ031nC9ut0lrdjc4iP5gO
         vyZaAUmkU4nZkKjxYLMtRb4iLIMu/UmNrvrN8UySsDxSW0/dFODy0uYE8rp8TaaPbQls
         +20tK4JgrEAjhh8cArQ34/sSMUwGiWVBDgEReEepFdScrOK0a4pH6aCPVKByVO8y5IO7
         sJLnqXLva1onz6vJRQfXSoLCZqdWwD5EE/gnBMRsk4aWx1pack62Q8zlS62n0iBpeeiT
         tUv5lF1XzdkLhLmmRNScw37ke6MOr6NXEbw4ieUczAzBNTkRJy/Xwfr4cbHOaI+oqfZW
         QMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pJ7EuHzT7tGyPRYJa/JXc5Wvnw7Fpu6vsSqUw7XjkiA=;
        b=PM/FhSLPPyfsylQ02svqk61ZWUfGPLx/uuI9UNfkvbw27YXrgy0POusloNe8N3eEa1
         TME72Sosx9gnuwq+A0tnsln0gqzeqP/9oV/3ZqDym3SdOv3/gjAAESgSDBTazXvf6Iyq
         ugy7t1KFHsPlP20g4NpGYuoKo+XsRo3K3DbRMSJ5P79FDOiMSdmeXiVqeJ+BHxNBoSkb
         53BrMNjmg1j9alHF6Piz4BSkyRSoRbgvZegAjX3O/59CYTr2eyoODmiEmmJJpIjJIX38
         rJ0mzfmEG6yOsfRiCVee9t0l5LOU6nlQGC5ULyMc/kp7GoqKDZOeVGhOYz+ZdwEdNOCq
         hkKQ==
X-Gm-Message-State: AJIora8ehFwA8V/UJyX1zxxxTUcv/FGBGs/E9PiUZE8VMrLyd/UnPwht
        KrQe6hOAXcUIOCG3Z3OZl8jtow==
X-Google-Smtp-Source: AGRyM1uWLI/JRV4d0wbhewqt2FTO8w/7lgoffpvuPqNLIj8dqWaQ0fJmfG6BBgn2wuAW+CudwGhXHA==
X-Received: by 2002:a2e:7012:0:b0:25b:e535:51ed with SMTP id l18-20020a2e7012000000b0025be53551edmr19277289ljc.282.1657022338989;
        Tue, 05 Jul 2022 04:58:58 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bj11-20020a2eaa8b000000b0025a72db0cf1sm5528243ljb.118.2022.07.05.04.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 04:58:58 -0700 (PDT)
Message-ID: <0a94cb9a-822f-e726-6ceb-e6e638f8982c@linaro.org>
Date:   Tue, 5 Jul 2022 14:58:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 04/14] arm64: dts: qcom: ipq8074: drop USB PHY clock index
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705114032.22787-1-johan+linaro@kernel.org>
 <20220705114032.22787-5-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220705114032.22787-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 05/07/2022 14:40, Johan Hovold wrote:
> The QMP USB PHY provides a single clock so drop the redundant clock
> index.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   arch/arm64/boot/dts/qcom/ipq8074.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

-- 
With best wishes
Dmitry
