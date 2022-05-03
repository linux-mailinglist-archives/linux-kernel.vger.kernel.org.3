Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F90518183
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiECJqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiECJpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:45:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFDF39808
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:41:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i19so32303797eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 02:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b566PPGsjaHWkMbL7FSptu6pFhyMnCOUSbKGby8X3Q0=;
        b=Gkh9UXQVwF65yXWd0IuvhOJPE2joZBCrE654qMIDm7yDmntq/HBsiKJM6B1Dvk6yM/
         UxAlak39n8KEi8x+y9EDaAdz0pt6ygUE2PhIafxZikJGH0eJ4KmP+fGuFABxg81EG2uu
         VOu2fVuqy9LRgTJXSuA+3WD/EZxl1UTOOGU0nH8yhVB4jam+XQdnSncg+RIPoYoxS5MV
         YgzUvtGrKGzx7HuvL0Uuc26n+os8X/Tp7BWryHg5mYN7WHqDOyEWtH7GWlV9cfZOobHe
         4UZe5xOaVwe8Zngx24UUcyCBZrlSN55iVriTLbqs8Z8kooGqOOACp96tkFfGiZWJXMfS
         /RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b566PPGsjaHWkMbL7FSptu6pFhyMnCOUSbKGby8X3Q0=;
        b=icMSa/glzBge/6u7or6w8rDC3Sth/gCcA6absP2DGz94k+kNnl0iESrzjFEsDQBjit
         YB83hK818HM2CY5j0EZ21nZGw9LWuTd7zrEfjg4TdcQpiL12qBGGCKGTiED+sFscTKoQ
         xZHArMIc+t3omDJDd2wIJJxgIcOmGuf7SxtMsRKnJ5aLFUcCmVlNEhWF+hooNMbCRQrL
         m0Tik5g3118aAz7MXTDLEcb2Grmfw/1fCxEmv6T2QZIrDEsDRtyt+8iv9BtVyJmdKZ/4
         HrKQzeSuxBWxS+QIu9jjbrwwbOJLZmOaBt1N4sXbdAeOT48kpbAlxX1hf+kAQvHRMXsC
         KPCA==
X-Gm-Message-State: AOAM5330DEQp3BVsK86/pWZVcQJXPtHmq5Ep5RVnRTUka07DdnoYmmtb
        MgCjCuI4vA8W7Yx5H8C3ugzrkA==
X-Google-Smtp-Source: ABdhPJyzst4s7hrEZNpwk9DA5qdrjy5euejkI2joEvaH1c2+lrpv/9TjwCRAJBGmhr2xJVxo0oIkRA==
X-Received: by 2002:a17:907:3c81:b0:6e6:cf3e:6e14 with SMTP id gl1-20020a1709073c8100b006e6cf3e6e14mr15088988ejc.181.1651570910698;
        Tue, 03 May 2022 02:41:50 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g7-20020aa7d1c7000000b0042617ba63b1sm7680835edp.59.2022.05.03.02.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 02:41:50 -0700 (PDT)
Message-ID: <bacc123d-bedc-0034-6591-3ef0caf270ae@linaro.org>
Date:   Tue, 3 May 2022 11:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] clk: hisilicon: add CRG driver Hi3521a SoC
Content-Language: en-US
To:     "Marty E. Plummer" <hanetzer@startmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220501051020.2432338-1-hanetzer@startmail.com>
 <20220501051020.2432338-2-hanetzer@startmail.com>
 <0b66148a-c65f-2acf-9751-ae931778ad45@linaro.org>
 <20220501113215.rh6he5344hssziy7@proprietary-killer>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220501113215.rh6he5344hssziy7@proprietary-killer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2022 13:36, Marty E. Plummer wrote:
> On Sun, May 01, 2022 at 10:35:37AM +0200, Krzysztof Kozlowski wrote:
>> On 01/05/2022 07:10, Marty E. Plummer wrote:
>>> Add CRG driver for Hi3521A SoC. CRG (Clock and Reset Generator) module
>>> generates clock and reset signals used by other module blocks on SoC.
>>>
>>>
>> (...)
>>
>>> +		return;
>>> +
>>> +	hisi_clk_register_mux(hi3521a_sysctrl_mux_clks,
>>> +				ARRAY_SIZE(hi3521a_sysctrl_mux_clks),
>>> +				clk_data);
>>> +}
>>> +CLK_OF_DECLARE(hi3521a_sysctrl, "hisilicon,hi3521a-sysctrl", hi3521a_sysctrl_init);
>> Missing bindings.
>>
> Assume you mean the Documentation/dt/binding/... file? Will do. I
> probably should have prefixed it with RFC, as I'm mostly hoping to get
> the attention of the hisi people to see what's the deal with the mtd
> reads being borked.

Then just don't Cc devicetree folks and put in cover letter disclaimer
that this was intentionally omitted and will be later fixed.

It is a waste of time of reviewers to look/filter/organize such email,
if it is intentionally not for us.

Best regards,
Krzysztof
