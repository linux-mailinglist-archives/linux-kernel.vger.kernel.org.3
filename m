Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6E553B85B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiFBL4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiFBL4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:56:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7634523F8BD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:56:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 25so5680455edw.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VYkRhKv59af1KeqL/rucgV/mHExUmIzFqqIMFo3QP2w=;
        b=f/4iOzj2fjFbh9BHIpxiLcPJ8fw5lzBWiHDgOhfcATZHx4C+uUd8r/eNFmvIavnVl4
         dpOUk0BfUc1xjQartU7r+q7vseF3UETtFtDHF+37Alc5vnJlQ6ssNY7pEVeUy/XMRs85
         B6VWi3KiGu3vH8tpW57Mv4BJ1luzryGnrPIXZ2Rmth9r5r939N0ogdopXNkRGpOfN4pa
         S/NaQfmC86D2kewTZWZCOFKUUTXUVjexVByb6Cd/NSjKrk26DCSkq7CPSvW7nSFSfG18
         lonUXcIU+x6/EMY2m0ERnPFlxjbsU9Qbf+Mow1hULDq8FToYZPabEMSAPkmyc/PdaOw/
         BRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VYkRhKv59af1KeqL/rucgV/mHExUmIzFqqIMFo3QP2w=;
        b=3rqv+7oU9shJtC340BNksX/GrThUxGMRldAtVfLlK1Sqpa+r+5aWGsY+Hmh1RsXfZJ
         nK4EECAigBoJP06umAGb3Drr/RxMZAVb6faZhPikXMu19JMtn3qrZaK4LLSvN67SekX8
         rIL4HTv4SnJpBwkvCHHYown8adsVSnl5gYgbeREl9XVEOMzvkXH1LDkkk5/ZRjolQF5G
         cy1Uo1lmVUtG9+OwxY7tT8JIHobJ9h0X0ezR1iLNzukp+FlQfXSsfqH/A9fjdvWAHTbT
         4pMXh3GzF5UinDk3PRbUPa/Kb5D76HJUdUeTr7gUjBpcmN/DkgwpSVjNx0rDFdWh/Rdw
         LwTg==
X-Gm-Message-State: AOAM532QiZ3zwBgGJ816526A6LjbhF+IWFdy0jAorCqFPVKxc0D6KATh
        PyhqLkW15Wq4A8YcumqWM8Lhvg==
X-Google-Smtp-Source: ABdhPJyelEPbsqEleXXPro/QCHXWTp8zcnnilj3IxbJgwVsMW+YQkef2813NyyLt+qVfpqaDOunYWQ==
X-Received: by 2002:a05:6402:1941:b0:413:2b80:b245 with SMTP id f1-20020a056402194100b004132b80b245mr4961471edz.252.1654170973072;
        Thu, 02 Jun 2022 04:56:13 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e2-20020a1709062d4200b006fec2097d53sm1664095eji.118.2022.06.02.04.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 04:56:12 -0700 (PDT)
Message-ID: <a66ad5e4-0be1-bb3b-5e7b-c2a5b936a898@linaro.org>
Date:   Thu, 2 Jun 2022 13:56:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/5] clk: samsung: exynos7885: Implement CMU_FSYS domain
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     phone-devel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220601233743.56317-1-virag.david003@gmail.com>
 <20220601233743.56317-4-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601233743.56317-4-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 01:37, David Virag wrote:
> CMU_FSYS clock domain provides clocks for FSYS IP-core providing clocks
> for all MMC devices on Exynos7885, and USB30DRD.
> 
> This patch includes:

https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

s/This patch includes:/Add:/

>   - Bus clocks in CMU_TOP needed for CMU_FSYS
>   - All clocks in CMU_FSYS needed for MMC devices
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
