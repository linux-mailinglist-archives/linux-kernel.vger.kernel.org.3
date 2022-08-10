Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10AA58E7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiHJHnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiHJHnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:43:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D80F6DFB6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:43:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e15so20177801lfs.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4Uo3ZWK2PkqauuhMI//wUmEctHGdo/pIjPS16v/DLy0=;
        b=VsR7QQ+QVl+fX96n/HiH0wVDzNeE/WujLyYrlwS1BUaKKAtXTn39Y/yX5Jvr0xQwBr
         hgSx7b9UUY9CgTJn2HLMQkSj3kKrtFIKhTylXbGKe21axbHXA9+Twz5kcDcEsDqmvIMO
         rlw2XvctfsD+OdXlSeTx8TTPOFzPDdFUzArtLxb5k5d9S1m3pGpJ/PyfL3uBHtLSOBgk
         +LP1d9yjOEL8kpceYEfO5dmCXrAKZWM6GLbApJTToj4MxGYteyxcaXFo6aSNzpH7ZbhL
         Gbytzdm46sAP39As6HGxp/6tmDxeVC30B3AnrxM+BR7EuKINP9sI5WcIJZcssAZG7m7y
         fXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4Uo3ZWK2PkqauuhMI//wUmEctHGdo/pIjPS16v/DLy0=;
        b=x/k1N84YNs0She7v9yZRKUKDY1HbSlQsqt12nS3kB3YTRmw9R8gwRycjcvFJxlcHv5
         2hRWFM0KGhbG/EXxmcwcjVPROzX7OyZ//yaBOTOB3gRHyW8rxBsKcCE1zXXXeQMCRW80
         CD31D6sqc6KilOarIbkuzXvALSJmNna1tawMj9W61ca4qb+zjjKc1bpGkqBaemLe0kYz
         0wwXN3qV60Z2h3a+lGAFxvd7JxGBBipfN9OGHWKFH1FpBbkteKBlC6Gsyv6ixE8cnllp
         YGXuKk+GM1mS2/8dyXyPyHF3LhBBzx7kBNtUt2DWiX6gyqyHfrx+uehlbmWJLDPUKgPg
         0aFA==
X-Gm-Message-State: ACgBeo2zOgZqeH+GhF3WlsJLH5HFZLSVtzH2Ici0zt1ci36jlkFpFS9S
        dIkH8rEZAoHECCPNN1xQP4/sQw==
X-Google-Smtp-Source: AA6agR6syBfgrUlsJSc6hKtDPcOaY8F+c1yciw+joV8Nk7hcfd3tYDrltR8Qxi4yFU1zgBfg0xHe3g==
X-Received: by 2002:a05:6512:e8c:b0:48a:f47a:63e3 with SMTP id bi12-20020a0565120e8c00b0048af47a63e3mr9953796lfb.325.1660117414618;
        Wed, 10 Aug 2022 00:43:34 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id b22-20020a056512071600b0048bd7136ef3sm237892lfs.221.2022.08.10.00.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 00:43:34 -0700 (PDT)
Message-ID: <25eefb70-a7ae-876e-c05a-bd308d41053e@linaro.org>
Date:   Wed, 10 Aug 2022 10:43:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: Add IBM OCC bindings
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, joel@jms.id.au
Cc:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        devicetree@vger.kernel.org
References: <20220802194656.240564-1-eajames@linux.ibm.com>
 <20220802194656.240564-2-eajames@linux.ibm.com>
 <297ddf1f-8ddc-902c-ff3d-06b9d19c6a7b@linaro.org>
 <59ee8c2f-3d6c-14ed-c9f8-2bbd9377a7da@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <59ee8c2f-3d6c-14ed-c9f8-2bbd9377a7da@linux.ibm.com>
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

On 09/08/2022 22:42, Eddie James wrote:
>>> +  ibm,inactive-on-init:
>>> +    description: This property describes whether or not the OCC should
>>> +      be marked as active during device initialization. The alternative
>>> +      is for user space to mark the device active based on higher level
>>> +      communications between the BMC and the host processor.
>> I find the combination property name with this description confusing. It
>> sounds like init of OCC and somehow it should be inactive? I assume if
>> you initialize device, it is active. Or maybe the "init" is of something
>> else? What is more, non-negation is easier to understand, so rather
>> "ibm,active-on-boot" (or something like that).
> 
> 
> Well, the host processor initializes the OCC during it's boot, but this 
> document is describing a binding to be used by a service processor 
> talking to the OCC. So the OCC may be in any state. The init meant 
> driver init, but I will simply the description and change the property 
> to be more explicit: ibm,no-poll-on-init since that is what is actually 
> happening. Similar to the FSI binding for no-scan-on-init.

no-scan-on-init is not a good example. It wasn't even reviewed by Rob
(looking at commit). In both cases you describe driver behavior which is
not appropriate for bindings. Instead you should describe the hardware
characteristics/feature/bug/state which require skipping the initialization.


Best regards,
Krzysztof
