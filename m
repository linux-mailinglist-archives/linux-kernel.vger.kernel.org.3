Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90A954D308
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349627AbiFOUxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348855AbiFOUxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:53:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C617554FB8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:53:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y6so6840215pfr.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dqUZddHd2eUD1yS52Gl+Px29FvkVippx8mvYDs3Nfp8=;
        b=oFBSWa5N5hISjc6dUgBXrl+Fi95HxIWz6sU0iEIXft5yBHzixVAob+7keHBHVtI8bk
         e5mZ/sXI+ax27roSpAiWEQ9TgGihz2l2U7+D87iAj4CgPM+JMMKh0hQ6AAnL+UMkPeUd
         Vqy/KUUW81mNLeV096MwdOSSUIKeoBuuu2FUzoJwSrEUaWMzj8YIGk3eHHy0Jv9hACL5
         7pLmRONbvAprOzld5Z32HqRfP3U/j2W4xDFjRx4KrGDe4AzgaZYC6268zC8Bi8snJX2F
         8B6pN4nI+fWaCApsLhalJRuLIpBIOvB79jHwdp58skjrLVNVf3B3ECibZdjspfqu5275
         VSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dqUZddHd2eUD1yS52Gl+Px29FvkVippx8mvYDs3Nfp8=;
        b=xnJJDRhPU23vois2hEWONf+sNEQ5eRqIg5+a2LUqEnoduV10esQBAp1uq24UXhvGdv
         EZJ/2mMiHGKy8+Tyu66126f8H38tz44+uxZhimdNN5XoGXSgYJYmrIqu6GhNOMkPaOCv
         QQloiYs+uXPUXIsRIE3IK8jyQQ8+NtQotv1izxYDqsMgG1eFqW6a0pNyoWp3aWQ3uMaK
         AB0MGznwCOe2hR8SSHnDMnaMDdQDB+35zG1QiaSuJktpjltwfiCgoj7nLKWlm/RcXch6
         GzHnrRjMu5J6DakRK3XUpzVExrrRyl++I+32Uv1kTm7J982KKVL0sI5UF7+51/2Iiaql
         vskQ==
X-Gm-Message-State: AJIora9PulSIjy04bmtlJFtrGCjKCVrXLqcwxPrZUUYMU+2G849rzyFs
        4mTOGA60AJ85MHC5//hdFT6yqA==
X-Google-Smtp-Source: AGRyM1uylt1sMxbqAyk47BNBSqxPP7neT6hLMSku9E/k6xbp/vkxQR34uadVNp9ZTysVcsegIEucZw==
X-Received: by 2002:a05:6a00:1811:b0:51b:fec8:be7b with SMTP id y17-20020a056a00181100b0051bfec8be7bmr1450763pfa.22.1655326426283;
        Wed, 15 Jun 2022 13:53:46 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902710700b00168a4ee4dc7sm78602pll.32.2022.06.15.13.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 13:53:46 -0700 (PDT)
Message-ID: <044dacdb-7d11-8c68-3fb7-ebd67621225e@linaro.org>
Date:   Wed, 15 Jun 2022 13:53:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] dt-bindings: clock: add pcm reset for ipq806x lcc
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220615163408.30154-1-ansuelsmth@gmail.com>
 <a92fe431-a995-4c7f-b90b-8e80298bc71a@linaro.org>
 <62aa1b41.1c69fb81.95632.5b71@mx.google.com>
 <717ad899-31ad-5e70-b299-ffb8ca287071@linaro.org>
 <62aa1dd0.1c69fb81.b9887.676e@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <62aa1dd0.1c69fb81.b9887.676e@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2022 10:04, Ansuel Smith wrote:
> On Wed, Jun 15, 2022 at 10:50:17AM -0700, Krzysztof Kozlowski wrote:
>> On 15/06/2022 09:53, Ansuel Smith wrote:
>>> On Wed, Jun 15, 2022 at 10:43:10AM -0700, Krzysztof Kozlowski wrote:
>>>> On 15/06/2022 09:34, Christian 'Ansuel' Marangi wrote:
>>>>> Add pcm reset define for ipq806x lcc.
>>>>>
>>>>> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
>>>> To prevent any confusion about identities (we have strict rules about
>>>> these), I need to ask - who uses this email address?
>>>>
>>>> https://lore.kernel.org/all/?q=ansuelsmth%40gmail.com
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> Same person. Started using extended name, wanted to do this change from
>>> a long time but all the patch were already pushed so I couldn't change
>>> it since they were already proposed and on the various mailing list.
>>
>> Previously "Ansuel Smith" was used entirely, without any parts of this
>> name. Here 'Ansuel' appears in quotes, which usually is used for nicknames.
>>
>> Is "Ansuel Smith" your real name or a nickname? What do you mean by
>> "extended name"?
>>
> 
> Ansuel is second name. Smith is not real... (sorry)
> So with extendend name I mean full name + second name that is
> Christian Ansuel Marangi.
> 
> Honestly it's a very stupid mistake by me not using the full name from
> the start.

Not-real names are no accepted [1] and since we cannot validate this, we
trust. Quite a lot in our process depends on trust. Once trust is gone,
it's not easy to get it back... Worth watching - Trust and the Linux
development model; Greg KH [2].

Anyway I have no clue which identity to trust...


[1]
https://www.kernel.org/doc/html/latest/process/submitting-patches.html?highlight=certificate#sign-your-work-the-developer-s-certificate-of-origin

[2] https://www.youtube.com/watch?v=nhJqaZT94z0&t=7044s&ab_channel=hupstream

Best regards,
Krzysztof
