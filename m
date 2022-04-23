Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94CF50C8A2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 11:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiDWJdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiDWJdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:33:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7CF5D668
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:30:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a1so7450838edt.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=gWNw5+tyYy38JczrM/Le6iFuWZtqe0ibvfQtEBkowsM=;
        b=XrZhBiLZkTj6awE8Oa2tePjxJTvXAsAMkci6X9xRgDwn6KkvTCZio19A+yzapOy4wB
         wJu16oPNvOEvZzboyd2oTUeA6n+AgzqlviXIq1j6WOUpGCRDlZR3Mb1DuX+AzWjaaPOy
         KfwppWcQ//QZpmYHA+FU0n5TmhObH/Lb6NH0uhMAUjW2jC0gCEwh7+4SyylHHctS96eK
         vf/591cZagJ5+bIJaXpBE8X+B14kd5HHB69aqjvd+mDHQrk8H/Rpnpj9MUrLttvB6Ron
         JrvDpqredRVY6I/BdegUFJk4fOe4L+7I4MazPvzJy7tcVKfhGYYi5k0wh4wl8+9BxTgN
         csPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gWNw5+tyYy38JczrM/Le6iFuWZtqe0ibvfQtEBkowsM=;
        b=fi1uCyeLuuJzQQlyl/4Y+yoSOSJqpMpSl2+HFt161GaGKTkdhuRNDYaO6+kcE5ffN8
         zOjysaYWSFARqSGva8PFVer7x/qiUK7mpVSFdoxfmlNXpOvWPAvq1DHG+Ngcy9H4gvTM
         DCgx3rEoMWZYGUxXRD1BmNFeJGgABMa3feIv/p+fIsP1riwK8dCgoanhVFMGd7QxzCYr
         5z4y93HHTUZQ/QFic/nkCyCuXNeNP1128uED7LSeRfRdXkgiE50NxGixO+VZz54h1ccE
         uCpUg5diFNTjFmepyQfFx8TJcc9PRjd3Abge4JrSkNcI6kBJlyvkRfIuthTphXtQq0s6
         r58A==
X-Gm-Message-State: AOAM532xoai19Y9vmRAUZ+iRduOrd6sqVPmCZrumNEphF7zFjtPmWdJH
        xfUUghwrzP8pSqsaeWmtPpI4MVYJMk21Kg==
X-Google-Smtp-Source: ABdhPJxeDR7QS2kOkE0ODj+LMaknx4juR2ZAXuS9FLTupPezfuk6ii3SSBINfNMgM2GUf4ES/6+/JA==
X-Received: by 2002:a05:6402:14c2:b0:41d:816a:4eb0 with SMTP id f2-20020a05640214c200b0041d816a4eb0mr9178123edx.301.1650706205187;
        Sat, 23 Apr 2022 02:30:05 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bw3-20020a170906c1c300b006e88cdfbc32sm1529556ejb.45.2022.04.23.02.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 02:30:04 -0700 (PDT)
Message-ID: <b96bb266-e4d2-c291-ddb3-f27e55d10fbd@linaro.org>
Date:   Sat, 23 Apr 2022 11:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: (subset) [PATCH] rpmsg: qcom_smd: Fix irq_of_parse_and_map()
 return value
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org
References: <20220422105326.78713-1-krzysztof.kozlowski@linaro.org>
 <165068558593.2759280.17055526649115604333.b4-ty@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <165068558593.2759280.17055526649115604333.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2022 05:46, Bjorn Andersson wrote:
> On Fri, 22 Apr 2022 12:53:26 +0200, Krzysztof Kozlowski wrote:
>> The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
>>
>>
> 
> Applied, thanks!
> 
> [1/1] rpmsg: qcom_smd: Fix irq_of_parse_and_map() return value
>       commit: 1a358d35066487d228a68303d808bc4721c6b1b9

Thanks, unfortunately Jakub Kicinski pointed out issue with returning 0
later, which needs a fix. I'll send a fix which can be squashed.


Best regards,
Krzysztof
