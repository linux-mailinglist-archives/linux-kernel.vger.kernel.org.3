Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0C5ACE41
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiIEInV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbiIEInR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:43:17 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D854220F9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:43:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g7so12074972lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mdfze3IG/68Q0hY7r9k6Tm1EFJSU0CNsI9YxIPTLjk0=;
        b=qkVcslTIhlFw7xN9p3IkpVjPpKwj+zO7BLAQeVpTAGrFgrmrq6BWqg6FYRv1e1W1xW
         n794WnRLrzFWWfX12O43B3g8Qj5HmUujHhsrXUFKTEYClZANggmHFcfyYHmJNO+YNhFh
         N3gWnMA5YOUsP1q2+yAmip4x6ZXAW/kPfA9d/99t4heflT06S3R4LeNp5ug/Dzw2jM7g
         c7P9Zc83t8lpD4mGXHjkmRviWbeV9XDCiXkZC/8MDBkHJBWn4krqgbnUbyv6AzPjPmPu
         QzT6gt1CEyckMK3nJ2TpOO3yTkPHMg5DhnK/eXl6lAz37r5QAZPRad31R/YxKZ+Ahi1W
         rm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mdfze3IG/68Q0hY7r9k6Tm1EFJSU0CNsI9YxIPTLjk0=;
        b=IwzQGgYvKBGX+Ba5dJ8/uF7+nT5Cnf0NZuzvQsUPEc8fKXZpVtlGOE4eJ3QTim/1rU
         XrCzCzjdErYkX1gh3OkKVHi9r35gVEBJkKP6qgCuip90SCYRwNN/XUMGDrYGfpzGP+4d
         CEDxQ/rVRbJxXc0PAKoz5bnsbhXKG81eT4ElFSW4VQStmcXJfi1q2xkCkWQxbtDmD0cu
         RiCnXCG3WXxkT+t1PFvlOPbbIllQI0EebeEOwJ9Y1qHO8xmAfgjtSyOmgeLf0WfAAoKw
         nBRZjY7iJtKtta4AGKr6PLELS9KyfLoRsq7ODNe7y0x43mYnwOua9FC8WBhKBIa/+syD
         lyag==
X-Gm-Message-State: ACgBeo2adhsfY+ymjCHV6fDyVttyFFV5YG7EOsIh+bLTef1zgNndonYj
        Q/aBNyg1mIkfE5K3WZg7JQh58Q==
X-Google-Smtp-Source: AA6agR5dHp6nWbwS4SLMTmNEn8otA25gZ0388rXlsjGhk5Cy661cLbJLcfVYEJPg5aAM0EJ/wCxspQ==
X-Received: by 2002:a05:6512:3191:b0:494:68ed:268e with SMTP id i17-20020a056512319100b0049468ed268emr13284484lfe.78.1662367393772;
        Mon, 05 Sep 2022 01:43:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s20-20020a2e98d4000000b00261bfa93f55sm1326777ljj.11.2022.09.05.01.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 01:43:13 -0700 (PDT)
Message-ID: <103f05e7-fcb7-75a4-f36b-bddf8385cef8@linaro.org>
Date:   Mon, 5 Sep 2022 10:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp-pmics: Remove reg entry &
 use correct node name for pmc8280c_lpg node
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, agross@kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20220905070240.1634997-1-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220905070240.1634997-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 09:02, Bhupesh Sharma wrote:
> Commit eeca7d46217c ("arm64: dts: qcom: pm8350c: Drop PWM reg declaration")
> dropped PWM reg declaration for pm8350c pwm(s), but there is a leftover
> 'reg' entry inside the lpg/pwm node in sc8280xp dts file. Remove the same.
> 
> While at it, also remove the unused unit address in the node
> label.
> 
> Also, since dt-bindings expect LPG/PWM node name to be "pwm",
> use correct node name as well, to fix the following
> error reported by 'make dtbs_check':
> 
>   'lpg' does not match any of the regexes
> 
> Fixes: eeca7d46217c ("arm64: dts: qcom: pm8350c: Drop PWM reg declaration")
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
> - v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220903084440.1509562-1-bhupesh.sharma@linaro.org/
> - Fixed the review comments shared by Krzysztof.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
