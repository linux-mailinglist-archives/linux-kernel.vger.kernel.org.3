Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA025B1F4B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiIHNeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiIHNd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:33:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E04B4AA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:33:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q21so13522566lfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=e8wSZ6/ARvfoxWmxi51W3Fwm24Kdxtc42HcCeMYjHNo=;
        b=eovUKAtpE41UQW7qGW3eBcEEErnGOyTG65Qhl07fuirqov42GeV/tS7+eyubIuQ41D
         9C8X5jIjRhUlA8dLUNTnUJRdm+Ww98oWWUrwe4WjSbF1BjqlPT2AsxQRhgSvYMYlVWFG
         /iz6/heE0L2L3W7hVpOUGZLVcSopQHgXR71p9BCE8HlAaYMK8P2Dn2hl347pMQIBs0GM
         k4hydZJaSqyzxwu5971dlm3YTqqSFpzhkCfC0d+y13Xv+OSjSp0046zhYQCXZ3ouEozI
         1MCl4ABoP8vsvhb7OSY2AYjkRvg7DOttzZAye35pRA48tjCOb4nRNrxeWSCtucEAHT4z
         Dilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=e8wSZ6/ARvfoxWmxi51W3Fwm24Kdxtc42HcCeMYjHNo=;
        b=T241GK2P4QJjHUl8ZqMCqmHs9cz2ZKDQjpD7qEJWWQqcsOEPGWWTph7OSVJ9v4VQVp
         nmHGh4v5FcC9XCctZKVL5U4f0il0/GIAQc5L6pXhWQ/LAK3OR6X8VwIexzDNp4byTM1n
         l5t9r4Bz16OM/r4uRBfIgTW+cg0mNloU3xxx6eeVWPvGsmEiFA4//yoMbHh1M3Ud7Syn
         8PcpjBhpYdt2obRlcTCyvlvOG4yT2DWLby+yp5ORlJIPfIdsKDIV/Wi5oq3yrLN6gfjC
         Ony0wlKEWlgoGtp2BZ4tDRV2hpyJTQL0RWnImLNwHu2qCboB9T2dMzbNTV99Zj9+8x7D
         tiGw==
X-Gm-Message-State: ACgBeo15gmvmeH01mWtYU7RYMKvmRpOSJdCuNMuKX10e0bNmuGxhVG02
        HwdFbCE4QQmF48vJvR7qYLImwA==
X-Google-Smtp-Source: AA6agR6/6BS21FEgKD1GoLv4nnZaenZ5VuuECe+4AmpJvmNHsdtsf2joiv/84fftEPb3wab40df7/w==
X-Received: by 2002:a05:6512:2605:b0:492:dbb3:9b85 with SMTP id bt5-20020a056512260500b00492dbb39b85mr2544346lfb.669.1662644027956;
        Thu, 08 Sep 2022 06:33:47 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i22-20020a056512341600b00497a123d8b7sm1451870lfr.172.2022.09.08.06.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:33:47 -0700 (PDT)
Message-ID: <b70236b8-acae-05b8-1344-47db082f60ba@linaro.org>
Date:   Thu, 8 Sep 2022 15:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 3/4] ASoC: qcom: sm8250: move some code to common
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220908063448.27102-1-srinivas.kandagatla@linaro.org>
 <20220908063448.27102-4-srinivas.kandagatla@linaro.org>
 <6e6b12aa-f516-6ea1-58e5-f46033b84985@linaro.org>
In-Reply-To: <6e6b12aa-f516-6ea1-58e5-f46033b84985@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 15:31, Krzysztof Kozlowski wrote:
> On 08/09/2022 08:34, Srinivas Kandagatla wrote:
>> SM8450 machine driver code can be reused across multiple Qualcomm SoCs,
>> Atleast another 2 of them for now (SM8450 and SM8250XP).
> 
> s/Atleast/At least/
> 
>>
>> Move some of the common SoundWire stream specific code to common file
>> so that other drivers can use it instead of duplicating.
>>
>> This patch is to prepare the common driver to be able to add new SoCs support
>> with less dupication.
> 
> s/dupication/duplication/
> 
> 
>>
> 
> Assuming there were no changes against v2:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I see now ifdefs. Seems ok, so only the typos above.

Best regards,
Krzysztof
