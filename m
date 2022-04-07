Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A174F7B35
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbiDGJQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243755AbiDGJQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:16:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E2414FB82
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:14:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ot30so9417998ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T9hbqxWr3I36mglxxaMPa10oONO0MCgwf6BD0FLzWtw=;
        b=eO4MUCyyGxX9SOB5z9Lont0uzM3DcZSWLOusZOuj8rzTIb6Fp2yFzTdSQDIpCWauqS
         vtK2nv1Um/l7zzyAQFdfYN8jhZM2BxO2cM3X4HvKKNAEBZZ8kEaqGR9buc2NadHdFLtV
         1rw7v0SPt1GAerhe6wVNUOxjln43HXUZXXes5AG/QwahrnirdDcE7w5Xn0CMJ4X9ZEk0
         SQsypivARX3TBNAp7cqf5R1dbbCCMX5sACcACcf8tXCYfWbPIVmlcNJzo6u4iOMgP+kz
         Sg18cqif/zI9ejI2zGIHfJMmB1Zb8zW7JVigRNnLWzFX1Mc/0H0SlCHzZgd4F7hFB3jL
         lY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T9hbqxWr3I36mglxxaMPa10oONO0MCgwf6BD0FLzWtw=;
        b=4XCGJxYWHdgFDGZSPF5+AkuMzSI1wDpChNeErmnBlzVMV8uyxSPx9LdUTfzkNlq0vx
         5gz6vJtDtSBJRU0+sR2FIStMrVTX7ObKoVHAgc0dBgVGyeHSJ66asFYmpVSEMXbl5r11
         hUfB3GSXWBmMVW96RoTRSk4Zc4tTTbOzDON0r7B+l2h0wXAxcok3qFvt+E8mzr/qEaUa
         P8si0K4FA/MFlDMtWEfX89xgi9iG99KsPlLl3/d3PPd7bgEWKWAuxS7ZVqAS/t/b/ybd
         +twnXw5rgSsbv27MGlOPMT4v8YFNAVue4AXGaGStbqFojplTdi/yoWjHJhTAU40afhRa
         enCA==
X-Gm-Message-State: AOAM5307yhkjz9RVgMbdslVvPL4PSJPMpOFnvouYEoACeMDBy1ksN0oO
        TVFARGUtUguSeHqrXlMl3aK0YA==
X-Google-Smtp-Source: ABdhPJwWNaQ5itZKFjdK/emZRoqIvnB/M7RMtAvxJPctGsYKAbriUxk7937cvCqFjNX/RfsRsgbTaw==
X-Received: by 2002:a17:907:97c5:b0:6da:c285:44f5 with SMTP id js5-20020a17090797c500b006dac28544f5mr12375007ejc.208.1649322854974;
        Thu, 07 Apr 2022 02:14:14 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906128e00b006e4b67514a1sm7515638ejb.179.2022.04.07.02.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 02:14:14 -0700 (PDT)
Message-ID: <ee0439ca-cf95-909c-3a9b-38dceac2daab@linaro.org>
Date:   Thu, 7 Apr 2022 11:14:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] phy: samsung: fix missing of_node_put()
Content-Language: en-US
To:     cgel.zte@gmail.com, kishon@ti.com, vkoul@kernel.org
Cc:     alim.akhtar@samsung.com, lv.ruyi@zte.com.cn,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
References: <20220407085958.2491783-1-lv.ruyi@zte.com.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407085958.2491783-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 10:59, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> of_parse_phandle returns node pointer with refcount incremented,
> use of_node_put() on it when done.
> 

Please add fixes tag and rebase on this:
https://lore.kernel.org/all/20220309170028.51913-1-krzysztof.kozlowski@canonical.com/

I'll resend it because it might be forgotten.

> Reported-by: Zeal Robot <zealci@zte.com.cn>

I cannot find this report. This is an open source work and public
collaboration. The “Reported-by” usually means that the issue was
reported. Usually in public. Can we see the report?

> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/phy/samsung/phy-exynos5250-sata.c | 1 +
>  1 file changed, 1 insertion(+)
> 



Best regards,
Krzysztof
