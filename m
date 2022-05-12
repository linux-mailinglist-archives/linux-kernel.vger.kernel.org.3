Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E661524AED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352913AbiELLDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352912AbiELLDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:03:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44883EF1B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:03:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g23so5702610edy.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4W+EWFwTLMcvqtazd7YfR5ty4ZGfdsLbilZrX8H2gfk=;
        b=imvSXQ6JRWKyV/MYdh+IR3cd2ooB/vZcIpg9HNZn/+WxC4uI0S3uZnSp7Vo5VlE4m8
         7gK8oBdeQ92snzIIl4RmLIPyUSGhmnuzrMrvJPCrB4jgojgFyvXaRB0Wd5WGDjfWsam9
         vt9J8z2cHVdQo7b9oOnNhQkGgQSauD3pM9GYkh3RSgIsfw37HJlGJhYkBOOhetWvQxxz
         mEKk+gqCuE6P5P0ifEbFTahxa3cVFpJ8BY5/auxZRkPe1bRXXRbCYIYGffMKfM/o08CO
         k70DXD2EReK9ZV+krbJQ0FKGZHSm21oeBTIioW0grFcvQb5KFcGxPx6hbdAkUcU9hA2o
         AWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4W+EWFwTLMcvqtazd7YfR5ty4ZGfdsLbilZrX8H2gfk=;
        b=whsmmQJf5CK1hk+uZ/R7KMqpdr68TdD7fo1yxM4Wvtk3s+rs1QMdpedEnr+RsTMokC
         r1415zPSX6smpEJjFB2UIev2pz/7OzRo4dwJ38chHMxSzFPrLST0oqVBomod7YYtdy/m
         XRE11fEW2cjwScI6dJEWUFyRaE/p96MZP6RoJgcq++Y2esCEMO3sJ8qLq8B6nyAxKW9j
         qlGnZRYOgwIAMLfThsjNUzY1q8ZdFg1gIizIpStQyUvyUewyp3TuL9GAaD2UmJ4l+Ltu
         vKWkq3cGHoTBrUXgA9aGnJKtEqxD6pzCSRWx/3Nkj+M7foNaZiKvrbBC+xaHJ5GNPJ16
         kSVQ==
X-Gm-Message-State: AOAM533dNwAVWq3EPKnzvlce1aA0HnmrHcoknAjUwYnJRTO0pu67lw4O
        gXR8h2bG6uA0fyu8cGmfbhYLlg==
X-Google-Smtp-Source: ABdhPJygH822wt5D8aP9h7KZFPJLFCW+aD/eXNVN38SfCqZZxciklchUGpALnHNr0eaO0hI3ZWw3rA==
X-Received: by 2002:aa7:c5c8:0:b0:426:34a7:f8b with SMTP id h8-20020aa7c5c8000000b0042634a70f8bmr33895941eds.321.1652353379837;
        Thu, 12 May 2022 04:02:59 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906414b00b006f3ef214ddcsm1989617ejk.66.2022.05.12.04.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 04:02:59 -0700 (PDT)
Message-ID: <58a6391b-b930-0095-4f50-618dee4f24e2@linaro.org>
Date:   Thu, 12 May 2022 13:02:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 4/9] dt-bindings: remoteproc: qcom: wcnss: Convert to YAML
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-5-sireeshkodali1@gmail.com>
 <00234f36-9bae-31d5-5b83-ea238e7e3c11@linaro.org>
 <CJXL0SG2GHN1.1IO2JOR5ARNV8@skynet-linux>
 <a62822a4-a771-dfa9-f46d-586fdccedf66@linaro.org>
 <CJXOGJIR1ONQ.2ZT3JQGVWWHFB@skynet-linux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CJXOGJIR1ONQ.2ZT3JQGVWWHFB@skynet-linux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 11:32, Sireesh Kodali wrote:
>>>>> +          - enum:
>>>>> +              - qcom,pronto-v2-pil
>>>>> +          - enum:
>>>>> +              - qcom,pronto
>>>>
>>>> This does not look correct. The fallback compatible should not change.
>>>> What is more, it was not documented in original binding, so this should
>>>> be done in separate patch.
>>>>
>>>
>>> This was not a change to the fallback compatible. 
>>
>> You made it an enum, so you expect it to use different fallback for
>> different cases.
>>
>>> msm8916.dtsi's wcnss
>>> node has "qcom,pronto" as the compatible string, which is why this was
>>> added. It is however not documented in the txt file. Is it sufficient to
>>> add a note in the commit message, or should it be split into a separate
>>> commit?
>>
>> Please split it, assuming that fallback is correct. Maybe the fallback
>> is wrong?
> 
> The code doesn't recognize "qcom,pronto", so perhaps the best solution
> is to just remove that compatible from msm8916.dtsi?

Eh, I don't know. You need to check, maybe also in downstream sources.

(...)

>>>>
>>>>> +
>>>>> +  iris:
>>>>
>>>> Generic node name... what is "iris"?
>>>>
>>> Iris is the RF module, I'll make the description better
>>
>> RF like wifi? Then the property name should be "wifi".
> 
> RF like wifi and bluetooth. However there are wifi and bt subnodes in
> the smd-edge subnode. Iris is just the antenna hardware if I understand
> correctly. Also this is just a documentation of the existing nodes that
> are present in msm8916.dtsi, but for whatever reason their documentation
> was missing in the txt file. Without adding this node in the YAML
> dtb_check fails.

It seems commit fd52bdae9ab0 ("wcn36xx: Disable 5GHz for wcn3620")
 added usage of "iris" property but did not document it in the bindings.

You can fix it by documenting (separate patch) existing practice or
document with changing the node name. I am not sure if it is worth the
effort, so just new patch please.

Best regards,
Krzysztof
