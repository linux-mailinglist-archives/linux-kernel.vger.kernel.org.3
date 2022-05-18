Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEEF52B342
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiERHNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiERHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:12:55 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3BEFD37D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:12:54 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h8so1424754ljb.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=NveFr5oBdZT2Fkapk4waWiUJsOPRpM4f+u8efBiPzeQ=;
        b=jHCADS67u2w6WRnpiH2hmQWcjZWcwTMZZjEIbjk41nZTH8+Nsr+9N5zM9OcExsaL+Y
         BeAm9bdsVUFE+6qQ1MmIXg1TDc8CxdE8TTYWo70EgZNbJJTqrqKRK43IyaB3tH3U7NF5
         EenS5AdVoX4/m8uzW93oDsVkWRU8MLEvKkOoyjBjtrlGTU3og1dQRnHqJvZPxNDIdUWq
         A30VNj/6Q0WDYvh72IEPo70Hgod0q3+8Ho3/f0wuK2zm8lwq5vT0eQFo4VQ2TXTfPXUz
         5pWI0ooLijSbS3Gi4r5Z4ymhjnRFe8kyfFqwmrkLv9INIhu1f/W15DZ9hZalW3rsuWqM
         AVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NveFr5oBdZT2Fkapk4waWiUJsOPRpM4f+u8efBiPzeQ=;
        b=4Yv521HIvIRkGBVcgoH9O9n7uixLin+ty9E273aTOlI2+GiC1VPJdoAWtLR7Bru2fV
         Vd98HZf2FsJSl+hVLYZ8hjDrCc5ZDPLBUNhfC9lFY1SxtbN33pf47HhjEPVmMsbALI6h
         0SuZoZMo/XWuDpO2uQNqqYP1Tw9Wz3OrhP/QfTzACXKIaUqrMRGKi2MPk5OS4tfOKC1Y
         SqHpB4Ef0PwvJ9n6m13EP4PfahllZn1NKt1B8lNZB4IGlSAQ2EndX/GQIKcyN9nhqbE0
         BPnjATRO7IQ9f68wdd2QawU4fY2OD2o0YqAz/eIu7/yiflY8X0gy93fNEspXVsz8fRIZ
         cWUQ==
X-Gm-Message-State: AOAM532dzpcFhFPHCnnR/WkFXsF/kXiSxRSJWI3n0xQb586aiVv76w7P
        eKDNkQ0PMmdzl/jzXzhwj6mCRQ==
X-Google-Smtp-Source: ABdhPJyoK2bfuMo1CXXcarmkwOAqt7fwbBO3No8og5UbwTMiGQcp9fvBYCPobo/etj3vprsEM4qU5Q==
X-Received: by 2002:a05:651c:23b:b0:24f:1286:c321 with SMTP id z27-20020a05651c023b00b0024f1286c321mr16139121ljn.521.1652857972902;
        Wed, 18 May 2022 00:12:52 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a7-20020ac25207000000b0047255d2110esm122512lfl.61.2022.05.18.00.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 00:12:52 -0700 (PDT)
Message-ID: <a4666047-4c07-a9ca-440f-1735da76c5fa@linaro.org>
Date:   Wed, 18 May 2022 09:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/4] dmaengine: sprd-dma: Remove unneeded ERROR check
 before clk_disable_unprepare
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220516084139.8864-1-wanjiabing@vivo.com>
 <20220516084139.8864-3-wanjiabing@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220516084139.8864-3-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 10:41, Wan Jiabing wrote:
> clk_disable_unprepare() already checks ERROR by using IS_ERR_OR_NULL.
> Remove unneeded ERROR check for sdev->ashb_clk.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
