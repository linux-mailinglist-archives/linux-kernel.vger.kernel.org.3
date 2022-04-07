Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D3E4F7B75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243740AbiDGJVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240372AbiDGJVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:21:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238091DFDDA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:19:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l26so9568239ejx.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=OhZn55oqpDXIvKLvKoNusLeA/Le7lGuQ4Qseb8DPsUQ=;
        b=o4mWa8llyJhR0hXytKXYg8Jm7+j7FbG2XIo9m1ek+brBno+uQo2HZZWkbmW5W/9QcG
         c9Py20S5rz3TcDCjRoQnwxvRO8Pkrhkzh4ftv0afwjRkBsyuHD5Vw70dKpJ84c8wdxnO
         WXI4ShYaC9NoYd9QFGcYQRCek9oQ5gLfsybO/i8ECbYTP1uaaZ6ak7bZ4nXz2PPHNC5S
         j+glrsqr34TjNHReLgx1ujxSXbR82hJgdwJbkae2lxWzi+cz8tIm+kVPdBoGMyS+mCk6
         dUp0UjvY9vxal/bAIH62k2ihxs6F5Ge99WJ7y2gJUnump2hDZi2/9Gv6/qM72qx9usWL
         08rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OhZn55oqpDXIvKLvKoNusLeA/Le7lGuQ4Qseb8DPsUQ=;
        b=KQy7Xi/pRoDPa4wilpY52P6/8VAEvnDDO00BBTNTCQXZBTQbUISs7/5TDN6//LBp4o
         I4e0hDRBvZpTw/tZ4JHU3/LUSz0XXUEVne7xrYHYSOliw8/7o/Q/LYUS0nhusT03euaH
         WQ/fsutmCzmNCBAv8Oksq8eNZAbrNkKMMGoEXEWy8r2tAjUamMx5vbXW26y9pPegDZPW
         5mF1i9Vd4pbWgigJw1DW99xJ/mAPzNEiiE78HDOCBq0ggR7/41eoFeeg0Sx3AKnc/wA1
         GDXFms9M7fOR8b1YgFOMrCU6O9kzrT34Gc6HsFkmq7gQoBi7LtuF7IR050AW4jpsoIL4
         fdoQ==
X-Gm-Message-State: AOAM532hBtARi/OJ+BABYaF5NgN7gdMcrVPP4uzMXY+uXYYbrfhql4dE
        kCKjNUQe8vQ0vIF6mCRc8dkaZw==
X-Google-Smtp-Source: ABdhPJwrfOj4aHp2YqJnDOzcr0lhU3Ho+3z/I+Snr1r/9J1rjLJks+IfGB/rZ/rf9fpkMv+YT4ttzA==
X-Received: by 2002:a17:907:608c:b0:6e7:fc15:2db9 with SMTP id ht12-20020a170907608c00b006e7fc152db9mr12144063ejc.344.1649323187671;
        Thu, 07 Apr 2022 02:19:47 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f15-20020a50e08f000000b004134a121ed2sm9146929edl.82.2022.04.07.02.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 02:19:47 -0700 (PDT)
Message-ID: <7da30fdc-cef7-879a-69ef-6993e05beda5@linaro.org>
Date:   Thu, 7 Apr 2022 11:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH 2/2] phy: samsung: exynos5250-sata: fix missing
 device put in probe error paths
Content-Language: en-US
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Girish K S <ks.giri@samsung.com>,
        Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>,
        Vasanth Ananthan <vasanth.a@samsung.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220407091857.230386-1-krzysztof.kozlowski@linaro.org>
 <20220407091857.230386-2-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407091857.230386-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 11:18, Krzysztof Kozlowski wrote:
> The actions of of_find_i2c_device_by_node() in probe function should be
> reversed in error paths by putting the reference to obtained device.
> 
> Fixes: bcff4cba41bc ("PHY: Exynos: Add Exynos5250 SATA PHY driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/phy/samsung/phy-exynos5250-sata.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

I forgot:
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

https://lore.kernel.org/all/018501d834eb$01e62ad0$05b28070$@samsung.com/


Best regards,
Krzysztof
