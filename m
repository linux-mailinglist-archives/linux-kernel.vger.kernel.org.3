Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A695B1668
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIHIJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiIHIJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:09:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D8ED6B92
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:09:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m15so6752018lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2uHrS5IyfnxI/NDFuBzpGUtE32OKmUy5qZV4Ecgh0oc=;
        b=gF6W14in+Ehs6sp+AkS6psdFKC/u4aP5AwvCVT6W7WcMV39HehtaNvK/fLYjGYxA5g
         Nhc9N6aJleHtixfkONiJHyrm/HegZT+iB2eenV2M2Lgj+ENipbo5KciZ0G9z/M0HYoL5
         riazXZfVNz4oT1ixjDcJTt2AVdoaX4YXTQVG5Hau0NfLNUhp76n7Yu0wZFR/GKg2lGtI
         YaGu9Y1nl9XdU1AzjckgVIOSnPq+bCQc+Fn7sy2Z6djkrtjOR6sHIC08TPyb5fkIBscd
         Uo6670mqhTDaqhPfc4eSSSKGllq4gzpoe41yi9xRZH94vcgIvO6DZUTG42MVzQwVlHOG
         uk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2uHrS5IyfnxI/NDFuBzpGUtE32OKmUy5qZV4Ecgh0oc=;
        b=KxXdWbL1KRy+uugjrXPXUdMPGu8TzEnNxUR2GoG6FmVn3k99AWYp9cZrBA0QIcSh//
         SWSZ545ja4qwQxhCA6rt4f9V8oOtQI0vFml59yVF1+uErgcCRLT3zSGadwLlyglWjkIe
         L750EvAtqf8BBPcwCkN0pT1ahGP1IPzzxgaOst4QyF14UsJU4czjfKHLNy37bVDqRhWe
         6G0WI28ILS0SR86FIXk3UkAXLDsdE2i2BVoeUVsJObrF9xI5Kk+tem2FTZp1azYK2ZO0
         Z/KrVb27ipvPSLdAHSvH+cn19idEFVKj98+oA+PtCUj+k1P8EdP6tJR6U2tmxn66ghum
         kWOQ==
X-Gm-Message-State: ACgBeo0CwD2t4teiZFfM2yQSvyUVh72MnmAyuSGgdVUuNNobOGmjysMQ
        M5+hFgt8Xihn1+KMDG0DnX2lDg==
X-Google-Smtp-Source: AA6agR7pxVb5YwWUQEZSo/a3AgfqoV97EsEwBgmAxmp1OkHqO2X/cm6gPU6guzwl2xQwUmTGx2Tvaw==
X-Received: by 2002:a05:6512:3f4:b0:497:a33e:365e with SMTP id n20-20020a05651203f400b00497a33e365emr2484276lfq.638.1662624548677;
        Thu, 08 Sep 2022 01:09:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p1-20020ac24ec1000000b0048cf7e8145asm535993lfr.117.2022.09.08.01.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 01:09:08 -0700 (PDT)
Message-ID: <0728587d-1c11-f83b-8266-21f4179519db@linaro.org>
Date:   Thu, 8 Sep 2022 10:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: qcom,pmic-mpp: make compatible
 fallbacks specific
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220908080801.28910-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908080801.28910-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 10:07, Krzysztof Kozlowski wrote:
> Instead of allowing compatibles followed by any fallback (for SPMI or
> SSBI PMICs), make the list specific.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Arh, I am sorry, this is a duplicated patch (mistake when
git-format-patching). Please ignore this patchset.

Best regards,
Krzysztof
