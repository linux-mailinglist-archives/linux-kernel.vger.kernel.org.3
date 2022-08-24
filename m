Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEEA59FA1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiHXMjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbiHXMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:38:57 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC3F901A7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:38:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v10so16289028ljh.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1JURZKRSXiPsq1aQoArSPrF7VbYfsdAOZBVEhHgf0qg=;
        b=lIuQSPRYFpK3xeF/YO5ZxQ7B6w7t+DhHc3Hfgca06zyLBLitokytTZj8pnmYlOoq8V
         qf/bFMuZA945cWHO6RCl33i697zEda6PHMHZU0pXne0e86Vh2XC6fKY1uTvj6xV2NBfT
         kzPMocEYTZlbyQY5QVyk2mKpT9MUFbTvDlTGDu648HxCjAfuKPwkgZb6L9/Lfa8Kmd8J
         f/MEr2C4ZFa/1CMB/Bjp+Hy/KyYnpmmM17e5NTG7x63DEN0lUK9N8Fs+1LnvikDXcjga
         YU9tBjJEo58PCQ7i5Y1f+VHDXiPjkYdA9vvKcjn4mtZXNWsEqn8G6FYdvUa1rCGz0Cz6
         T8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1JURZKRSXiPsq1aQoArSPrF7VbYfsdAOZBVEhHgf0qg=;
        b=clExb+RegjpQ7V3OV3C/Q5qHB6IB5CAC2DVsQ9BoaYtzs59YFZFu+4M41tnIvbd6Lz
         mYnzHQ49hXmzYzPJtanzimi1iGt1yDUgM+M0PpCSpqcYia5dBcBfXS4FpBQH2/Tf2XDN
         RLKQ/gLGZNy7+B7F8S1zrTwaB13vloY73hwfag21oDiPwFPK4FAWfSCCC+wSVNUehSqT
         OwmSc6ASDABunbeqwyXWSGXR5LjeZNEheEI+lYTHAiTMrSS2x8qwIhcPvNeT6/yCuAf2
         UdebY4YVVQV2QmZ9aTUzlftsZC2ytb1tcrMjeaLqTjysRQIrKLkQZdbiY7LFqHIa597b
         eJUA==
X-Gm-Message-State: ACgBeo3NdbWUczpks7FaecXf0QhsmD/Ohx5bqlmlMlAQnJDFo0zjDKL3
        vVslsXbjVSHltBX/Edjc0Qe//Q==
X-Google-Smtp-Source: AA6agR6DDILkYCrPbHxwgs8HO8yo8QJR93m3lMZtF97e5asxsLHLBfNejtRFxVymf6v5djRy2mE5/w==
X-Received: by 2002:a2e:a914:0:b0:25d:f74a:54c0 with SMTP id j20-20020a2ea914000000b0025df74a54c0mr8789721ljq.290.1661344734001;
        Wed, 24 Aug 2022 05:38:54 -0700 (PDT)
Received: from [10.243.4.185] ([194.157.23.230])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512114700b00492e5d31201sm1490440lfg.7.2022.08.24.05.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 05:38:53 -0700 (PDT)
Message-ID: <3237265e-9f1f-d5cf-c37c-ee39bce2eabf@linaro.org>
Date:   Wed, 24 Aug 2022 15:35:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V2 1/2] bindings: fsl-imx-sdma: Document 'HDMI Audio'
 transfer
Content-Language: en-US
To:     Joy Zou <joy.zou@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>
Cc:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220524080337.1322240-1-joy.zou@nxp.com>
 <AM6PR04MB592501ABD3A369F913137E1FE19D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <AM6PR04MB5925CFC53026A11F57115D1FE1739@AM6PR04MB5925.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM6PR04MB5925CFC53026A11F57115D1FE1739@AM6PR04MB5925.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2022 13:31, Joy Zou wrote:
> Gentle ping...
> 

You pinged again instead of implementing the review... Second ping
instead of doing what we asked you to do. You also did not respond to
our comments on your first ping.

This is not how you collaborate over email.

> BR
> Joy Zou
>> -----Original Message-----
>> From: Joy Zou
>> Sent: 2022年8月2日 11:58
>> To: vkoul@kernel.org
>> Cc: S.J. Wang <shengjiu.wang@nxp.com>; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
>> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
>> dl-linux-imx <linux-imx@nxp.com>; dmaengine@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org
>> Subject: FW: [PATCH V2 1/2] bindings: fsl-imx-sdma: Document 'HDMI Audio'
>> transfer
>>
>> Gentle ping...
>>


Best regards,
Krzysztof
