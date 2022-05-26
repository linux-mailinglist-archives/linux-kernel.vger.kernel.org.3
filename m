Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1A8534ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345040AbiEZHVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiEZHVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:21:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A4831DC8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:21:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id rq11so1391522ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hc5WJxpCJDyVBDEvY69Dh9h8QnuVZ+60jKtLKAF2hwA=;
        b=NY5j1qQZ3zuQBRuvXBwy3T9uIZGJL4d8Rkl/5QM6aWBuym9SQBTCtvDlmbVhzkohv4
         i3tm4naS6sehS+t4500dvC7cVuqK7UroqrRb/nELHpJDgttNXVWjFIoAvmPUZ/kYkqh5
         hqVh5AaM1CM82qmtM4mnF5w3iK88pPIhSPCn3DiSPR8bcnUbYMr1KgO2sEYQaB4TVdgq
         yfnmb58z8XZblOHEMP7rPTBEQDXKUFl5Hoqa9b9Oo0g3FvVZI8n7UYID6jRhs2k+8IOw
         RNOOapYsDOqm2Bz3eoG4dKMcZXTfvkTfYt8iSdbpXiiTlfahVFSdRnCclye7prVpIljX
         GOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hc5WJxpCJDyVBDEvY69Dh9h8QnuVZ+60jKtLKAF2hwA=;
        b=y/Hy+ESq0Qx5BFYkrZv1gF+wzopks5/IQ49lk9MtrvNHrTOJZHNTqX07fY9XvWLmSF
         WU7Udgi90XXQzauswKqU6lsoL+nBlJgWKeabdy5I0oZowtiwNwEgxzGshyU8vGUYSQwA
         GSSk0iz2vhWCC6CT0zaFDLFTOVaY6uf+lxfYKUCEbQz3QhEU9WKTYSZrT89BNRniHofn
         xKaunH8PfhbYY0ojtDMiHd3TntBEpBCfFEyzY2mwjLhtrGynuGP0xqo2P6//w+b99bI9
         1zytJm7Y45CyGjtp1CS5hCeNCyzW/FuLVvd4Ptoy0z2PL+ERlkMGd21pFRhXNLcbmuoA
         B1tQ==
X-Gm-Message-State: AOAM5336IB98dzCN86Djpy4GtfL4Q6wqne5uUJZwAbm4MNDUXH4ySSLM
        auhAtYTCiNVwH/1aDd6/7hrQwA==
X-Google-Smtp-Source: ABdhPJxzN00DjmF4ZI4mQycshnN5aJuXx97ZwlJCev/twfdd8ygK3/+eZU2fZQbnzmVyrh0uAy5D0A==
X-Received: by 2002:a17:907:6d99:b0:6fe:c1c3:feea with SMTP id sb25-20020a1709076d9900b006fec1c3feeamr21831935ejc.89.1653549688973;
        Thu, 26 May 2022 00:21:28 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o19-20020a170906775300b006f3ef214e24sm243866ejn.138.2022.05.26.00.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 00:21:28 -0700 (PDT)
Message-ID: <2eda61c1-a076-3467-91bc-8c2e14f4f516@linaro.org>
Date:   Thu, 26 May 2022 09:21:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] clk: samsung: exynos7885: Correct "div4" clock
 parents
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220526055840.45209-1-virag.david003@gmail.com>
 <20220526055840.45209-2-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526055840.45209-2-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 07:58, David Virag wrote:
> "div4" DIVs which divide PLLs by 4 are actually dividing "div2" DIVs by
> 2 to achieve a by 4 division, thus their parents are the respective
> "div2" DIVs. These DIVs were mistakenly set to have the PLLs as parents.
> This leads to the kernel thinking "div4"s and everything under them run
> at 2x the clock speed. Fix this.
> 
> Fixes: 45bd8166a1d8 ("clk: samsung: Add initial Exynos7885 clock driver")
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
>  drivers/clk/samsung/clk-exynos7885.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
