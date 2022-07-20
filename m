Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1957B0D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbiGTGLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiGTGK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:10:58 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC5749B5B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:10:56 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x10so19488256ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R724gXzbsAes7qqV9vmgsnDK2zNWLN0xtkY5GrfADYc=;
        b=dKF3Gni2mdRt3jsXRwkxlKFvWbGSErW4PONf3JI+seKboTnKaEP1LKMZc2V2Yf0mCX
         Xq9qhYogXQ/xM95ueLCzbwh7u0zjURJaAyMWouojT5GE7tSy6r9YmXzHcn/grBKIg/py
         Yem9FHhoUFtffdyMuSvfVsDHsQCiqWF52J+fLWjedr6aKNoAtWdRj1eWGbgHOJbIpQkr
         5FAnT/saqAtNXyOUbtBJP18NoCKNn2SMEul0Fg5VD2nQddV1oid1XrlZZ6nQDz2quCfW
         xBntlBx5NW5M6g62SABxrKTjGgF5fwECiCPaBTM+qoS5vACF93uMwVeAeabk3OaRXy3j
         S28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R724gXzbsAes7qqV9vmgsnDK2zNWLN0xtkY5GrfADYc=;
        b=jS7d+LmXFuweXZBvoXzmB/AdjJ4I1BgcfGVd6k+YEFPRoyZ3r9aQAzxZYqb1l7HGyD
         43w/OG4BaQk7lD7LoW0DHqobKWxnkSOHkx0L216LluCnvWcRoB2ISxErdM062qqK8dYh
         UVk1h7zFTCApdDfTAb000ytE2/PuJKzZ7k8AykILa5SQ0ebXKIDFW2ALkOZttDKmBk41
         YA3coP2oC/KmXseY1cqdExVyNJ71kAfgQtRlj86N8V8PBnwqT43u9hSoTlkp/GN1WYcv
         uDUg53Lyfs7Lq1VEB0lj20Vc3apWb39I1GXaAiVPxYYER1iH+d6pP0ByxZ3T57g87ZRN
         3jVQ==
X-Gm-Message-State: AJIora8HcgUvx3cWgjzpNLMfcyAEZ0r2+Hmo9zQTwSPcRjr3Uq865YNT
        l/wUhPsJK45T+84WGvcicRFTmQ==
X-Google-Smtp-Source: AGRyM1sqMk/IxWNdfO/ZrAP8MTy5lfGn6Ymb6DxouAFaqjIbx2YNSH3cIx2gJo6fAJyUsVlKMcg7Dw==
X-Received: by 2002:a2e:9917:0:b0:25d:a469:75da with SMTP id v23-20020a2e9917000000b0025da46975damr10463914lji.55.1658297455004;
        Tue, 19 Jul 2022 23:10:55 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id k7-20020ac24f07000000b0048602d54471sm3584486lfr.156.2022.07.19.23.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 23:10:54 -0700 (PDT)
Message-ID: <7a04c9af-0ccb-7711-249f-73908fe7ec36@linaro.org>
Date:   Wed, 20 Jul 2022 08:10:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: qcom: Add SKU6 for
 sc7180-trogdor-pazquel-lte-parade
Content-Language: en-US
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Henry Sun <henrysun@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220720025058.1.I5bfba8857ea0d43c747ecdc3a950875abd56927f@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720025058.1.I5bfba8857ea0d43c747ecdc3a950875abd56927f@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 04:51, Yunlong Jia wrote:
> SKU6 is LTE(w/o eSIM)+WIFI+Parade
> 
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> ---
> 
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> index 764c451c1a857..4649eaec6318d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> @@ -14,7 +14,7 @@
>  
>  / {
>  	model = "Google Pazquel (Parade,LTE)";
> -	compatible = "google,pazquel-sku4", "qcom,sc7180";
> +	compatible = "google,pazquel-sku4", "google,pazquel-sku6", "qcom,sc7180";

You miss binding change and sku6 should be rather added before sku4 as
it is more specific, isn't it?


Best regards,
Krzysztof
