Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434A65523F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245538AbiFTSfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245515AbiFTSfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:35:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A89F1AF01
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:35:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e2so5354029edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=MEpVHdTLad6DvaeX4T0f4vT7p4WxZITXRGbfMh9cG4M=;
        b=MVE7RAQ0LOmNd1+sMDBNkkvgx13MPrZq4jKtAz/fYeaKPYGKmlN+iP+bO+UVdUOoA0
         iXyK/4ZStJyHO/vRPvriDkxI32xTwXP+mHN1/H9hivhG+qn2UDsOLI1LwnwLyfySZyYh
         rzj31x9RZPtPKT1v7zgJL+8ZTDPzbZk7qHkIIO6iOfsrL9wdhcoRWLJTnxZcevrDqs+1
         MjsZLMTl1DPPsRUDIeTtbPVVW7n7uO5TmowCjuYiY4NlqxZTK7y07AFDp5TJKMN8446P
         Btne3I59RcUBbSST1petx3E+SdmKTM6gUfTRvh3M8iSXRHImQ8mdY5U8WHZCq+e6FBbv
         dMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MEpVHdTLad6DvaeX4T0f4vT7p4WxZITXRGbfMh9cG4M=;
        b=gFQZ0qdTLfEonMOWWeHbFX5KUS/a3oaIfZfkR/Uayq4k4wIMANqSCB6X0neuKya4/s
         /F6i0RUwphPHZ659vF9GAIa7FglG48g+JHX9T+gp2cRFT99wgtlOFVmrBJDBYlWjtNRU
         HNY3sv8qdQq5IVmCrFIsDxj/2ILo5eouDB0Qu/RBp4Heyjhjdn6rHf+KwK+rNBmP4aCn
         LN1K7H6hOe+0VmaY2KHPykqQKorqfWhDSjmf9VNi9rgK78HtoTAWgeWJdQ310y5O5r1c
         QrD0V4TsB1eZxZIzliy8AAGo6kRmjfWxcMqBu+f7e3OftsmOwGC2O2qFP5Yr+5WOrLz9
         S/KA==
X-Gm-Message-State: AJIora/e9nILUna/mkaS4HP2NGR8auZgJPE80G5T6ajwSH8/6aHRBvu3
        Ef/GXGhEs03NmJwEK6oVr1zWUg==
X-Google-Smtp-Source: AGRyM1t3arK3LUmq3jHdvl9EY67edPH6TgzlDQy9Ox6ntIuy+o60jK4JMqNxdLPAe3W9ufGABBthOA==
X-Received: by 2002:a05:6402:3807:b0:435:20fb:318d with SMTP id es7-20020a056402380700b0043520fb318dmr31444130edb.272.1655750099809;
        Mon, 20 Jun 2022 11:34:59 -0700 (PDT)
Received: from [192.168.0.211] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709061db100b00711d546f8a8sm6283170ejh.139.2022.06.20.11.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 11:34:59 -0700 (PDT)
Message-ID: <1e0a8169-1710-b875-637d-7362bd17cda5@linaro.org>
Date:   Mon, 20 Jun 2022 20:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] firmware: qcom_scm-legacy: correct kerneldoc
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220519073410.7358-1-krzysztof.kozlowski@linaro.org>
 <20220519221252.C1582C385AA@smtp.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220519221252.C1582C385AA@smtp.kernel.org>
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

On 20/05/2022 00:12, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2022-05-19 00:34:10)
>> Correct kerneldoc warnings like:
>>
>>   drivers/firmware/qcom_scm-legacy.c:133:
>>     warning: Function parameter or member 'dev' not described in 'scm_legacy_call'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Thanks!

This was month ago... Is there anyone willing to pick it up?

Best regards,
Krzysztof
