Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DF650C8A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 11:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiDWJbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiDWJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:31:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEB41FF57E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:28:38 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r13so20622036ejd.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XwRX3dQQKVCbO7y3tkBOfJG0TaUkfPDXzwv86ykznLY=;
        b=boWjgTSfPOJYrFX2B0Ktpyn5wSiTeF8DJCpuoxmuJ5hXlU9dNVdJCtMl5uvEoKYFgG
         anir+PwRSZmLlILbfYNShfNFRvRW4MIT6EemUwjMm2EYb2vWis8kzsJXy+6r/bK2u0jr
         tmMgZeXQ0YsI7F8esO+qzObvcgW2D42acLxKF+m4Z00P5y5B/fnHMZWEGJSGi7s7KVX4
         qQObLL9gWTC2MQU3uwcCjqo9hRBE1rpGgEklbKcVtfcz+ujYY5W4ErnoBqfZgQtTHOLO
         vwfV9E+OvRZ3284K9e5NU+r16af/bGCVTKJvbJ141gzri749z6Z2ib2N7pFJ8gR/Pbed
         2TEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XwRX3dQQKVCbO7y3tkBOfJG0TaUkfPDXzwv86ykznLY=;
        b=UlEFIlP7w7tl3zdCiPK82adMhmltjcco+DrV54qGzcWDjnr89B6bYg2spB4/flYlHA
         rpu8WvsUSKlLq1cH1F/Kuoa2DJdbzTaSQo77C0fbW9ZojVwiCVYaj46FYmp2Ea6CG0Ax
         O78DVeCElaQzsEKJ19QPQWqosAFhLvvG6nTiYC8iPansfPI5bVJRzmh81N4uyWRBts+f
         LWWeqJzoVzIYj3lZaRoxVF0XuA9bh3Z26dxDx2aDjg+H7mpibn+HNQXCe/Fa1dglCUJQ
         IUDmi/rSLrn5hHSieDj+fTIHfbUpElk/c2wapxOIiiSP+hUVg/SXSV6/dpMGX8o/pQXg
         MQlQ==
X-Gm-Message-State: AOAM533PwrW6wRCIb8NPqsMg50QvcORrBd/YHTc31ywZz3B470FhQScj
        TeNjx3DOYHFDM2o/TwGXBUMUbw==
X-Google-Smtp-Source: ABdhPJwQyTIIz1uqkkA/2Gzfz8WyLrZPTzJtXQA4DG3JJPeEuT8o/0o90kidYqWbdlzjNwJ9n9n+3w==
X-Received: by 2002:a17:907:2da3:b0:6f3:6e74:67b0 with SMTP id gt35-20020a1709072da300b006f36e7467b0mr2726572ejc.766.1650706116579;
        Sat, 23 Apr 2022 02:28:36 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id tk22-20020a170907c29600b006de43e9605asm1450030ejc.181.2022.04.23.02.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 02:28:36 -0700 (PDT)
Message-ID: <e7eb0c05-7056-7aeb-ebca-399f11d22122@linaro.org>
Date:   Sat, 23 Apr 2022 11:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] nfc: nfcmrvl: spi: Fix irq_of_parse_and_map() return
 value
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Vincent Cuissard <cuissard@marvell.com>,
        Samuel Ortiz <sameo@linux.intel.com>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220422104758.64039-1-krzysztof.kozlowski@linaro.org>
 <20220422161305.59e0be38@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422161305.59e0be38@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2022 01:13, Jakub Kicinski wrote:
> On Fri, 22 Apr 2022 12:47:58 +0200 Krzysztof Kozlowski wrote:
>> The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
>>
>> Fixes: caf6e49bf6d0 ("NFC: nfcmrvl: add spi driver")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>> This is another issue to https://lore.kernel.org/all/20220422084605.2775542-1-lv.ruyi@zte.com.cn/
> 
> Maybe send one patch that fixes both and also fixes the usage of ret?

Bah, I just blindly copied one part of his patch without deeper check.
Thanks for noticing it.


Best regards,
Krzysztof
