Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D6250B51B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446598AbiDVKdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344416AbiDVKdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:33:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3A3DF4F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:30:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a1so4238320edt.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EM/g9GQPepqt/1Hqpj9DFQ9VXH5iBM8LW7YClivD+HM=;
        b=cVHE+MQ4RqMoauzz/cc7arlqLacNIpEab0hGnfwWwJ8tz3mbFmzfvXRookGL7CsuRj
         h4Ue+EvapB0MhOQkRHuD/xsAW88lMeUpz+5a4S/gmQYsLvjGgBsWeYmXfHG+T9PyBFvu
         5Rz/q/W/05kpz1zJ9RgFm6Vw8zhpuHnvdV/c0azeoFu7zqp1/cheslvB78pzJriLHiZg
         PCTgulewthFqt40hi/PXzA934/nuDMoG/CkcOw8tnZA/jZn3shJSKssJG+6aZrwYsfr/
         6HseulRNnsXNAFRhgtqdGXr20k2BtuWAReu0su3tVfo3btQAjVnSs+cZJxYrGeIoJYzN
         YBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EM/g9GQPepqt/1Hqpj9DFQ9VXH5iBM8LW7YClivD+HM=;
        b=FRQZMcd2Nhu2RYAf+HhzqR1ZRtm2BNMuzlcx8rURHOK+immmZCRJJk0WnDF0wmg47T
         N1w6xBPhTW8qkmrbcQ/7EEVKL+Bshqid00X1l3goPN16r6+XyQHcDNlA4YsOP2kFXQha
         1ZHnpogs/7Jre1NjJDS1eik2KLZ33WXb4jdEjpP9nqIf0iA8Nc4RVpz7wUiusLiSXYQ5
         GH3knh+dWEKyRgx1326AzI4gugkLtvKVxy0KVjpPoRZ+zsR5Y6ZsNeJEwn0UquQ2VuGV
         uJIlkc+T0b4YNnRyTor6IE7bBerBxjywfI0a11Qug7+3h3VdFGGlSmK+tW8cOocWS53J
         JFJQ==
X-Gm-Message-State: AOAM532s2GYHAxtj+umuI8wOew5qZ7GHKMQkfCo3X1hTixdNfsoRs/O1
        sbExdq60sgeASEo9zmxuqchRWV7+7CV2KA==
X-Google-Smtp-Source: ABdhPJz8CbwXKiMdoZM435jaKFYmhtcig80PHos2oozJonLpiiwUlfWniaM5smj/GLjS2jrTazr0FA==
X-Received: by 2002:aa7:c9ce:0:b0:425:c396:dde with SMTP id i14-20020aa7c9ce000000b00425c3960ddemr669481edt.397.1650623448000;
        Fri, 22 Apr 2022 03:30:48 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906540700b006d5eca5c9cfsm611021ejo.191.2022.04.22.03.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 03:30:47 -0700 (PDT)
Message-ID: <c60f5823-4e25-39d5-c62a-0392fe9eb322@linaro.org>
Date:   Fri, 22 Apr 2022 12:30:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] NFC: nfcmrvl: fix error check return value of
 irq_of_parse_and_map()
Content-Language: en-US
To:     cgel.zte@gmail.com, davem@davemloft.net
Cc:     kuba@kernel.org, lv.ruyi@zte.com.cn, yashsri421@gmail.com,
        sameo@linux.intel.com, cuissard@marvell.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
References: <20220422084605.2775542-1-lv.ruyi@zte.com.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422084605.2775542-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 10:46, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> The irq_of_parse_and_map() function returns 0 on failure, and does not
> return an negative value.
> 
> Fixes: 	b5b3e23e4cac ("NFC: nfcmrvl: add i2c driver")

Some unneeded indentation above.

Except that:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>




Best regards,
Krzysztof
