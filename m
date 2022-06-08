Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12B3542C2D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiFHJ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbiFHJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:57:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FB115A854
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:30:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id m20so40190569ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5OSQTqUpVQqGdtiWsQiVzCNGN/W+6rXCSBNE12Fte78=;
        b=enw+NAUpYeQlR6hfdS6xQpRkqLghi6Z2iYYF2YW+inYhh6MXxx9ps2oboBmw7sVEaJ
         0Mm50RUaA2kKP4rEFFIkDypeMAPgiSRifYJiTO6UfFGqAVDtF510NJmQco/zdGYMrpt8
         P4W9osQMjyrRrhHw8bE/7fUsJ35fRglmf5U6JjyJJYqA/Iix9L53C0zF/KO3yMC7dZH2
         9cS6XaOgTZGDQw+iegdG0lnsyzIdjsMEzbBw6RGqT9IfmFXE9bcg6U7Ay4T1+xU8Sgbg
         uqyDXRmd3nCM1nm2XObVyaU40A9z1m+U2qcV/fdQAqE0d6MF6ISUaupq7c98IUFaFGOb
         eMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5OSQTqUpVQqGdtiWsQiVzCNGN/W+6rXCSBNE12Fte78=;
        b=YhgCiVnwt3F2IqQsrsw0n9T00WLI47ABXfF8zvX2623eJlRFk7QRv55rM/ooV5tP3w
         rXOYuL6sZqX+rMO87qXFV5A9dvucPbmtW5C83gfAvLLZYEgYGWOeH/w24vhkVi9fuWDM
         JLklgoVNoa9gskH0Sf+lcV0U//h3sTD/WJxqXwgj8V+b+9SI7qXrB4ccHUP40Ks5tW/M
         /2vDENhYS6BXEqtK3HMFj11VzFHNU02nUsqHcl2HRPrLVio0b9oCoogztHSeV7Ar4upv
         Yt2nRyJhMJuyxS7grnIsc+N1xPw4ansA5U7o3GukSS446LrbAZX6rL/yDS8+h2vkixmU
         9hJw==
X-Gm-Message-State: AOAM530qKaEkOZ6jw9oCrxUj16kxHdMmsYTNYfSmHZwAKIsVsJxMrE1b
        9iZoNk4aT2vJGzW2afaSJe4vXw==
X-Google-Smtp-Source: ABdhPJzdM9jQq7Knm4/sB2ExOoHBLPfrsf5VDhDvQZsiispnrNYZsvuDkJKUdXzIVPgg30O3pT7bMg==
X-Received: by 2002:a17:907:868f:b0:702:f865:55de with SMTP id qa15-20020a170907868f00b00702f86555demr30709192ejc.24.1654680601876;
        Wed, 08 Jun 2022 02:30:01 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7c698000000b0042bb229e81esm11830571edq.15.2022.06.08.02.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:30:01 -0700 (PDT)
Message-ID: <3c9abbcf-086b-07ab-2638-cd25fa9f329b@linaro.org>
Date:   Wed, 8 Jun 2022 11:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH][next] spi: s3c64xx: Fix spelling mistake "hannel" ->
 "channel"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608081912.2083086-1-colin.i.king@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220608081912.2083086-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 10:19, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
