Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912F6546397
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348580AbiFJKaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347450AbiFJKaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:30:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E357A3B2AD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:30:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u12so52643930eja.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q1gr3NrnB39CoRuCt8vX807hgcXw9Mek2bCnOsXpGQo=;
        b=QSvTbaU77/wWFvrHNSjvh11fTizVqERqxJuaRgPrXbIgYWkB3CNmRbgVdVuKjtHqg3
         EhSrgR3EDatDWGn50GSs7FLRqgSt7xMwyUPawjSnOhbxJydoSzj+Z5VWNx0tqz85MBMo
         Vk1XUUH3JEvlwH6cKqlREF9eU8xDoGFMNMu5Nl/jmUm64Flgc2ocZwbJyXi3drtRY6Ce
         OtC/dRTh7/xtSe2jqd0/wVwIMillp/6cVXMKcDPCOT+jHNM5BWJhsKtk2KgZCrb75QJt
         eb/XTr0mcr6gpXFDyxvAmk7j805M3kAuK/PDlIPjgsoRIylJTb3LlTJmGIUjbAD05Lm2
         PkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q1gr3NrnB39CoRuCt8vX807hgcXw9Mek2bCnOsXpGQo=;
        b=GJidxNFFl6q8wYrMK758nQ7JQMTT2RuNT/ZHBSJStLqhGmsIsYMuBr1DJnEDCLDuSs
         kaFQePIE4a+GQjesISBWSjB2F+dmKnh3CFvclZHpU9svKIlEr81Q+YWQTSfX46diXpQL
         gEfMxbX2JGeVsuZrmv25uUh6N3qVv3n9XuLCWI7zC0CTOdZ5UhZtpT06i4pC0CRTj+m/
         8B+QC0Y/w98teC+NTIm8pjC0g++CDbytOHLP6MeOiDyJHDvfPZ9pAnNtNsInAz+2+DpL
         t4VW8dfYB2w4puCcqe3W4jWHaDf2AarxD+MS5QWbfg71Z9rE2OGifgc+eoryUP41W2m0
         KCGg==
X-Gm-Message-State: AOAM531xwmZW2iK+ntmbUM0ZHLCqAbhFNDkwaRGfAmlv8m92i5fJzQhc
        dI2gUe5k9gjVdySwDBjUWHHPmw==
X-Google-Smtp-Source: ABdhPJw7PvzVwnAjoaC8oJ5ApDXIoYkN0OCc5cmycobzyGZiBOEgvGwNWQ7HGD/AvnfFZNoUw76PJQ==
X-Received: by 2002:a17:907:8195:b0:710:b40:95d2 with SMTP id iy21-20020a170907819500b007100b4095d2mr31029973ejc.604.1654857011476;
        Fri, 10 Jun 2022 03:30:11 -0700 (PDT)
Received: from [192.168.0.202] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e20-20020a056402149400b0042bd75c53casm16186593edv.83.2022.06.10.03.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 03:30:11 -0700 (PDT)
Message-ID: <e68724b0-4a9f-f564-c833-befd6c3515fb@linaro.org>
Date:   Fri, 10 Jun 2022 12:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 1/2] thermal: Add thermal driver for Sunplus
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>,
        rafael@kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "lh.kuo" <lh.kuo@sunplus.com>,
        =?UTF-8?B?5ZGC6Iqz6aiwTHVXZWxscw==?= <wells.lu@sunplus.com>
References: <CAGcXWkzJwOPXfE6ESAtwBbe7W-UkApKosKUy=UBRh0kmi-Bc2Q@mail.gmail.com>
 <395072af-3349-cead-fe07-62d3d758d635@infradead.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <395072af-3349-cead-fe07-62d3d758d635@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 05:19, Randy Dunlap wrote:
> Hi--
> 
> On 6/9/22 18:32, 郭力豪 wrote:
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 0e5cc94..c85e668 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -504,4 +504,14 @@ config KHADAS_MCU_FAN_THERMAL
>>     If you say yes here you get support for the FAN controlled
>>     by the Microcontroller found on the Khadas VIM boards.
>>
>> +config SUNPLUS_THERMAL
>> + tristate "Sunplus thermal drivers"
>> + depends on SOC_SP7021 || COMPILE_TEST
>> + help
>> +   This enable the Sunplus SP7021 thermal driver, which supports the primitive
>> +   temperature sensor embedded in Sunplus SP7021 SoC.
>> +
>> +   If you have a Sunplus SP7021 platform say Y here and enable this option
>> +   to have support for thermal management
> 
> End the sentence above with a period ('.').
> 
> And the indentation here is all messed up.
> See Documentation/process/coding-style.rst:
> 

It's not only this one. Entire file has wrong indentation.

Best regards,
Krzysztof
