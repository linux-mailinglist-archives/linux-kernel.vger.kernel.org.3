Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1EB52CDB9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiESH6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiESH5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:57:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A34F4EDE1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:57:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f4so7641357lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=HuQzDaY35vfZCNmG9Su+PiSDK9SQEsPfjOSbF3l6cC0=;
        b=obiMfT5pYrKc5nD9WjR1fPoAWUdsYHQYvWfrZsK0XVoJ3HcPczoiBrgaDkB1kI7gJN
         s1vjqH9l82aaKLDfHaeGyJ6LHAIirrRbSCFSfWiOzlykRRGkIUNYUFIWG9lXU2EcpmhZ
         zsUpzih/JZjhLEzEWETifdvNVbxtkdLM9dDz2Fn8RUseOExHe3W7d5VoQrSQuuZ9NgMZ
         4JGkx/IzK5ckpxjaFTUiX6qCyyXHtCIgjFc8RmDjF8/4O3Ksw+5xjcEsNEMrirm57pkT
         UNcqoXWGtayaKzTCyfAS3stDt6CB3uIpMwEn/wE8HKKBo6ci85J5i3YskN4AihbaIsWr
         tw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HuQzDaY35vfZCNmG9Su+PiSDK9SQEsPfjOSbF3l6cC0=;
        b=4fGs2PUBbv7y2d+jxkJhdfqxs3fWerpZknUlcSnrQNv3wwnXYLgu7H7Wd4mY+MAI+/
         WchppYyjzmXA/0G+n7u68MuSAUaKteHuRM7SRUWQExh4z5DUEJMRkbyuY2DNftnrPb5G
         5SLTS6161kXJO1KNkofhKSVpV0HMJsLeLyRhO89//jKvXmxIRwUAQjWuHmDftSufWjMl
         O0eXbRHCjvybyGrCgQAw5ZasakkrbaqSxXgPRB4xhD8+twS4MA6MQVPqanBhxkKHzC73
         BAvRp71FVGWrWaDBLTWVFohWJF8j9k56EGcYMaPnl1oX2v2iBB1E0wa84NS32GKKV5dw
         rhvQ==
X-Gm-Message-State: AOAM533/tALRxRkksWdIPo+J91J+b0eqcwY/aBt3dmGonLgGMxHWOtWx
        7Sm4aWvGeOizskkdAPYJJjtfELzjZgzwqhLZ
X-Google-Smtp-Source: ABdhPJyjOZMebZ4F64Blucw+z1ogLvaM6ccKb1Ss80lgGRWP0/rwRrml8FXa2EG+VUlJ4MxAk7zZIg==
X-Received: by 2002:a05:6512:b14:b0:477:c0fd:6dad with SMTP id w20-20020a0565120b1400b00477c0fd6dadmr2326962lfu.15.1652947068937;
        Thu, 19 May 2022 00:57:48 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m1-20020a056512114100b0047255d211f1sm192467lfg.288.2022.05.19.00.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 00:57:48 -0700 (PDT)
Message-ID: <c577027b-1f8a-404c-368f-cc24aa3f6d48@linaro.org>
Date:   Thu, 19 May 2022 09:57:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] mailbox: correct kerneldoc
Content-Language: en-US
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20220501103428.111286-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220501103428.111286-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2022 12:34, Krzysztof Kozlowski wrote:
> Correct kerneldoc warnings like:
> 
>   drivers/mailbox/arm_mhu_db.c:47:
>     warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/mailbox/qcom-ipcc.c:58:
>     warning: Function parameter or member 'num_chans' not described in 'qcom_ipcc'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Any comments on these patches? These fix warnings and they wait for
almost three weeks to be applied...

Can we get the warnings fixed?


Best regards,
Krzysztof
