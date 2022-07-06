Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CCA5681CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiGFIjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiGFIjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:39:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B4422290
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:39:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m18so6232722lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ld8cIYsdzjIDnkCt1ktjOPlaDX6VLGU5kv/wSF9GY8k=;
        b=aA808w1NUKJcg7JJsrdqlHpCDKYmWzmtV6KSh5jWXGbUJ/+XdNQ6YCM7BvMtvVyZqq
         TptE/zqZ01WFZ/iNjtJtCWth6hqrxarBuczyyytBbPT3J/nVqGnQRHl0fokNwrbhTEgz
         ENXvWYxPjJwOXmDdlVLxhg84kHL2AuDh8aMtjhb5sDjqXe60fv+KVyZRdoJ53jr/Ty7w
         OPq6QNGVNeRs3IWLs8BmRqEfNVReABTM+qO3XSQ+UUzEFzVZLwqg9tBzXOeYkXx0bMwE
         /WR1kHnIlIqf+cUqbnVGBxu19//em1i110dudwgPIArGv3DP9Ctr4trQJ41TcCt9FYWf
         NzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ld8cIYsdzjIDnkCt1ktjOPlaDX6VLGU5kv/wSF9GY8k=;
        b=57fAaJ97Di4vk+lqeR8E+uFz6liz49Y+p4c7B+AFgB3KvEQ9lMceFbzANffDm9EpC0
         3AzLJ9HXZT7KBGnZodmo+y9ldXRP8jCxTwDlp4cqFG8WqK/ayuimio8Gv3Ck4yTr/mtS
         6NBt7CBXmbz19X2f93M/ySVVa3uMn3o0L8qC/fd+IZcJV4F9eL72IYVa1Ui9UbNgaS/h
         E52O6PY0Pxr5R33/4YShRv5F8t/GCY5XVg9Eq0Jwmdt1g/H/qKjzkxUspivFCjI/RXEE
         YKcYkANWxkA0biWId2r7eIjU2yI6AFobW+LO1CcVpJ8pbcV+6kku7lImdM4Pz8UqLYHZ
         ufdQ==
X-Gm-Message-State: AJIora9VWEfiRwp209Uq3UjBH/8ZVEMSPFHbFnG59pcEAvqShLXflj/2
        gPYugZjH3trm8qaRb65RDpxNjA==
X-Google-Smtp-Source: AGRyM1tJZYtxnASCsxqK+7V49arOq5yF0QjZMg3KFV9qbbpzWtrgkfnbJu59YMD0iexUSexYY4hWBQ==
X-Received: by 2002:a05:6512:2205:b0:484:e296:62fa with SMTP id h5-20020a056512220500b00484e29662famr3118429lfu.142.1657096773723;
        Wed, 06 Jul 2022 01:39:33 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id q10-20020a056512210a00b00477a287438csm6176592lfr.2.2022.07.06.01.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:39:33 -0700 (PDT)
Message-ID: <5cc844ea-0853-16be-785e-2b08dbbb8493@linaro.org>
Date:   Wed, 6 Jul 2022 10:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/13] ARM: dts: qcom: add sic non secure node for ipq8064
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan McDowell <noodles@earth.li>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-11-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705133917.8405-11-ansuelsmth@gmail.com>
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

On 05/07/2022 15:39, Christian Marangi wrote:
> Add missing sic non secure node for ipq8064.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Tested-by: Jonathan McDowell <noodles@earth.li>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 98527a7d885e..ef8faee6dfd4 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -543,6 +543,11 @@ saw1: regulator@2099000 {
>  			regulator;
>  		};
>  
> +		sic_non_secure: sic-non-secure@12100000 {
> +			compatible = "syscon";

syscon alone is not allowed

> +			reg = <0x12100000 0x10000>;
> +		};
> +
>  		gsbi2: gsbi@12480000 {
>  			compatible = "qcom,gsbi-v1.0.0";
>  			cell-index = <2>;


Best regards,
Krzysztof
