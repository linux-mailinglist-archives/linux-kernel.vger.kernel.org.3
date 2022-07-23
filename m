Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F4E57F18A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 22:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiGWU4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 16:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiGWU4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 16:56:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B402C18396
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:56:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b16so237370lfb.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=BSddQZU4tvxR23/v1w3cQiBY/TQtEQeiurrpTf9SqqA=;
        b=D4+v3raDZoCrf761Th36KUpA2Zw5VnhnOBMwfmqlwEtRrFOOSEMl1es0SpIxuzqNoB
         lSgZgfDrN5s4durJatNnpOq/wQfgJn/Djes1LhP28s5IMFF6ETIIYGgvDwtKvaDTTaBI
         WxBVR+lALaO2OdhyQMMbQkH6s4t3u/F7AtjUQyw60UjIc53HKoP8TSHhjD00EIeFVbL8
         T+YWsRRkPnXNza6dgVyh5rDn8//nYYU0sgHEX0naBMQuPkco3q0HSomtGuF414rhJOPe
         3EXgbTkZNmRBLe01fyaIoToKelJ7IdcLJ2UuWnT5/yFwNlrxJ3KOFdjzxZBCkT3qXuZD
         obHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BSddQZU4tvxR23/v1w3cQiBY/TQtEQeiurrpTf9SqqA=;
        b=eRIArTSWMZ+WzkC5uxPgwWaXe1ZedESrbDD5gJNIGMBy7MQ8ywpVTyps+XqKCiqnxq
         ZbQVXENSDWxgZlhirjISSaP6HCSxQiS4tfcF3kO+TwM2wqqQLIQoKQFTzFZAL2nABW0B
         EjvikMMeD0x0dDl3KmfWcSaBxf0wYNXLL2tZay4lkAFFkAc+qxBjfrAJaeVHkDM18eUy
         23JnBikSeYserd2vqxwn93cedxiUQ3u2heuzUzHJvZrhuu8yonEnadwjaW5MOf2RRf5Z
         5+Q1W3othVfWwzWGdnDcV8Svi+O8eXjvAqC2Bxy+HmZvLhCJgitc+ZiIMQOmKQdbw5AY
         aSaQ==
X-Gm-Message-State: AJIora+F9q17DxwMkSipKeuQwKX1o6Xn/HQQIKLroxTAGzzqUQSEWM2u
        6cARY1CTDK7WAxEw4tpisxnAtw==
X-Google-Smtp-Source: AGRyM1vu3x5Eguf+cpjJ//lggceGbEIs3f64Bw0DXVLRSc/hW1Uplx6a+UOVP8Sr6mEbZzQzjD1KOw==
X-Received: by 2002:a05:6512:33c3:b0:48a:83a9:52e1 with SMTP id d3-20020a05651233c300b0048a83a952e1mr937646lfg.344.1658609808654;
        Sat, 23 Jul 2022 13:56:48 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id j10-20020a056512028a00b0048a86146831sm174867lfp.186.2022.07.23.13.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 13:56:48 -0700 (PDT)
Message-ID: <7d6595c2-1200-9c27-dac9-8f76ea743447@linaro.org>
Date:   Sat, 23 Jul 2022 22:56:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] ARM: qcom_defconfig: order items with
 savedefconfig
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220721155356.248319-1-krzysztof.kozlowski@linaro.org>
 <2246145.ElGaqSPkdT@g550jk> <c5150e83-0e50-3be6-b6bd-bf30fe5e94d1@linaro.org>
 <2109260.irdbgypaU6@g550jk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2109260.irdbgypaU6@g550jk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2022 20:52, Luca Weiss wrote:
> On Samstag, 23. Juli 2022 20:44:08 CEST Krzysztof Kozlowski wrote:
>> On 23/07/2022 20:17, Luca Weiss wrote:
>>> On Samstag, 23. Juli 2022 19:36:17 CEST Krzysztof Kozlowski wrote:
>>>> On 23/07/2022 11:58, Luca Weiss wrote:
>>>>> See also
>>>>> https://lore.kernel.org/linux-arm-msm/20191104210943.101393-1-luca@z3ntu
>>>>> .x
>>>>> yz/ (never applied for some reason)
>>>>
>>>> Mentioned patch is incorrect so should not be applied - it removes at
>>>> least TMPFS which is not desired. I did not check other removed symbols.
>>>
>>> For this example: TMPFS is still enabled after this, it's selected by
>>> other
>>> options, like DRM or COMMON_CLK.
>>
>> I know, it does not matter. We had this case (with DEBUGFS and probably
>> others) and the decision was - user visible symbols must no be removed
>> by savedefconfig.
> 
> So savedefconfig is "broken" (not doing the correct thing) then or what? Sounds 
> like a topic for kconfig maintainers?

I agree.

Best regards,
Krzysztof
