Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40366596EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbiHQMi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiHQMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:38:57 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659F229CB1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:38:55 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o2so18869194lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=G7C+uP4vsY5z6nSOlzdUyPyVwCYsWGzimxMi3pHMeVM=;
        b=KkF6mjlHbtt61VHdcRD3fymGK0+19LzU2thK1AXf4H9hrjnRyIgS2mBu1KRwjz/trz
         FUM1EX3j1D7Zg2nrY2hKU4T9ng/UaoqTsFxlsPEQcIDZG0tdYmr2lOMAckQNK1XblqeY
         1MaorgtZ+otVAFPiGhWvH2jPu3JOqYgqHKEf/mXL4IkfW+J5ukl3g83Zut5AFOho7lyW
         RhxRQGlpL0WhaNYHQH5qorN+Lm3r9d5k5+ItItOumNFG/jU6CkiCCLBz/DwzMofF8OkR
         W9SpDGtNeLJSDHX2zYkARPIiLLyEJUUx9PNCM7D3maqJVqcJS5mzg56//9cyyAd2nO6h
         Ka5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=G7C+uP4vsY5z6nSOlzdUyPyVwCYsWGzimxMi3pHMeVM=;
        b=nVNdq3rdzWrpDU1mvbqxV5555qBJbQ4QzSXBcRHJbPm4ZupdfK8GGytSUB6/OQk397
         GWvJxByTK7cU0krH/DS0MZWD7dIvXSK1NjMlkWXY4YuSzUn8OOkLAf4LVZPTbhTKDUa8
         Ti0WrIIuVjG7BAcPQavtmJxfrg6+MF3Vi286qK2wkYbqjlJDJx1I23YJvcPIuinL5Eqr
         /UOi6ISusD3LWi4SkbD5jjjK5tmPLlBL6nkHakY8FnuttqO52WZ3OdT7HtK+s3pQgbjs
         vUtPoH6raKY7Tbj9oSwfXjzmBVVAtdoKzaoYxHRZi22kIp0voPXyQTm4z5F2IY81NtS0
         kCsw==
X-Gm-Message-State: ACgBeo36EoSSjIYgJZnSJVNDqiHwlEzrXQ60xWrQ4riplpblhO8rRjbf
        hPjzvLe9PX5JQ8u2FNmTWGY94LF783dhIvr3
X-Google-Smtp-Source: AA6agR6BCAevMUm6IC/vnumrG7Tse0F+RngB8s2G6Y6Ye/0UH9PSGLwdoCLthKjOfIpbqD0cfa03PQ==
X-Received: by 2002:ac2:43d4:0:b0:48a:f6bf:1185 with SMTP id u20-20020ac243d4000000b0048af6bf1185mr8631932lfl.197.1660739933626;
        Wed, 17 Aug 2022 05:38:53 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1b1c:14b7:109b:ed76? (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id 6-20020ac25f06000000b0048a9b197863sm1671644lfq.235.2022.08.17.05.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 05:38:53 -0700 (PDT)
Message-ID: <e7c29e37-3ff8-775f-292f-a87e419ac3ee@linaro.org>
Date:   Wed, 17 Aug 2022 15:38:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFT PATCH 06/14] arm64: dts: qcom: sc7180: add missing TCSR
 syscon compatible
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220817120403.458000-1-krzysztof.kozlowski@linaro.org>
 <20220817120403.458000-8-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817120403.458000-8-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 15:03, Krzysztof Kozlowski wrote:
> TCSR syscon node should come with dedicated compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index b82c335c25af..49f28cb531f6 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1468,7 +1468,7 @@ tcsr_mutex_regs: syscon@1f40000 {
>  		};
>  
>  		tcsr_regs: syscon@1fc0000 {
> -			compatible = "syscon";
> +			compatible = "qcom,sc7180-tcsr", "syscon";

Compatible is wrong here. I will send a v2 tomorrow.

Best regards,
Krzysztof
