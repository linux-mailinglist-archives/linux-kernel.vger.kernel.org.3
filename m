Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF5552CCBC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiESHU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiESHUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:20:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBF86EB2A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:20:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id h29so7570840lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=fdfSYz0vm9MQWJbSUfogROrxBfQQh8tD8bxvI5Fs7cI=;
        b=bbtch6XAWiN/DV2yOgt38hEl0PAk2t1n0PBAqWjkC07CKF2r50NEYLvYe/ajQO6DcL
         d9DV1AvR3EEGEbk+0vYrhRy1NQt960fzcROv5qDeTy8ne3IGxckoRyzheI5dPQTxIz7S
         UDF0rSA/3Cw7cMLZSIEDIk8uT1p2/71/hxT0yY0TFc3355n0CoxymE3WFNU9DT4nF2tv
         FeewUQe0FPJz7aNuzhm9YORUey8hvLIl6ZpXV8DNGWm4EFvUT54sLBjnSLPvvdSYcjzG
         3fk+BeIaVq33X9s6Z8kZVHoxNPECcQJqPwiTBpC7EIiPR8lsD56zFJoYiju+wtUpYs+e
         X7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fdfSYz0vm9MQWJbSUfogROrxBfQQh8tD8bxvI5Fs7cI=;
        b=hJfVd8SrUeCMF9yQI7RqmAu4psjA8EeM+HxkDJS/9O2aIQrVSEXySS/1mCjJ1BczOB
         Lshd7MRSEbWmtWCtFyglcofRvzyRVzVCObyAOg/49u2ctMVgUFk4a9kfIFnioFjibgLj
         8RnU4En8g16ts6vIraKo+LM404C+0aziOvwGGnlmC8tV8J85KzcaTiyIZ45AvN6pxNyd
         fO7/qDAtJKC7/JU1EL0CNzESPkXMulj3PYHE/OujJCtoEWuHU/XHVurQqVVHxlpWxhRQ
         vUTdIFkTiwhGN1q0+yqWcK26HH94tUaU2vBgv61iPNwR9eMW5zXtDsfkg7RxrhsrbaJm
         Iz9g==
X-Gm-Message-State: AOAM531k5hG6DxpFA53/nhAmjqa3ZgZkoxL+8Vr8TIWNGK6wdxfLorxt
        zoVgaUs4ctiljAaSm07vNqsslg==
X-Google-Smtp-Source: ABdhPJxoi/rsKjcwuY1nKxd+QQG6REhVdwGjY1Dy9hu/ZPzMp0gtsds4YLqAgc7BAe5dP8hSj4xH2Q==
X-Received: by 2002:a05:6512:1585:b0:448:3936:a5a0 with SMTP id bp5-20020a056512158500b004483936a5a0mr2318972lfb.108.1652944818555;
        Thu, 19 May 2022 00:20:18 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t1-20020a2e9c41000000b0024f3d1daeb1sm479424ljj.57.2022.05.19.00.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 00:20:18 -0700 (PDT)
Message-ID: <4b295be3-ae3b-f977-6922-d1505b7843f0@linaro.org>
Date:   Thu, 19 May 2022 09:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/8] firmware: qcom_scm-legacy: correct kerneldoc
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org>
 <20220501103520.111561-2-krzysztof.kozlowski@linaro.org>
 <20220519000350.DD5C0C385A9@smtp.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220519000350.DD5C0C385A9@smtp.kernel.org>
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

On 19/05/2022 02:03, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2022-05-01 03:35:14)
>> diff --git a/drivers/firmware/qcom_scm-legacy.c b/drivers/firmware/qcom_scm-legacy.c
>> index 1829ba220576..7854af4abc62 100644
>> --- a/drivers/firmware/qcom_scm-legacy.c
>> +++ b/drivers/firmware/qcom_scm-legacy.c
>> @@ -120,6 +120,9 @@ static void __scm_legacy_do(const struct arm_smccc_args *smc,
>>  /**
>>   * scm_legacy_call() - Sends a command to the SCM and waits for the command to
>>   * finish processing.
>> + * @dev:       device
>> + * @desc:      descriptor structure containing arguments and return values
>> + * @res:        results from SMC/HVC call
> 
> I think only SMC call is possible so drop HVC to not be confusing.

Sure.


Best regards,
Krzysztof
