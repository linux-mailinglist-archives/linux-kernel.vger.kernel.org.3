Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3E84FB3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244923AbiDKGcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbiDKGcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:32:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47E6C5E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:29:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i27so28697197ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0yUNK3ZCKYDcOn5ZrB3/FxJrrtfEl7Fw4Ni9+59C8dU=;
        b=jjzMGMubAeZ1lFmTxBh6mg17L9CLxZ6L/8g7R9OSx4TYbz/WOdXtuowKx72IFtfsqu
         QzoJr3HWFtca8HIdbDFbdTZXW82MRdZMT2Ar6jcdDHsAnJGMC89ngSfFGQuCYwpDE14S
         Ug6W90bCGgUXsKgnl7hZnmTtNIW8V6ndulmmzFdJt7rPureVDtky2zIP/53RouKx+KBx
         6OtU8iOho9QoqPGcRqBrB7pmeU25YiRt5DMgy5Nea6yaNPRCUn1rUqGCMvt6qK9hPjh3
         zx7MTwE56Sj806SWtRi5tsNGl9f73YQGm9ftjcgtWKXlyQ9Z4B8cJtBr1bvPk8UiAFBB
         HhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0yUNK3ZCKYDcOn5ZrB3/FxJrrtfEl7Fw4Ni9+59C8dU=;
        b=KztalS5k7tK/P6YnV/c4B9d0/ycrRnN4vOaiqy6I1UFo1vmEqGyJiEg5u0UKynLn2M
         fRVwvp5EO7ctTgXta+zcMYy7SMFGwVkM4cf4CaxYo4tNMH0tzUxVN/ItBkrWZAy0kfK8
         zICM+r5S4lId4u/4sQmvSodsG39+SFfWXt9Upzizf+1xU6WHjOEwHjrz4eAKX4loss2G
         VpJ/RD8hiIhDnvvQzA40EMTD3ZElflRmKf3fI0oiKWtb2bic68fI7KfYvS1zTuBgS/Zv
         ZriW096dEzs0G/WG6mKgXetJrE5s23TY13vyBCiEt133B3L3UwVEUgPMAgRwulRQ76na
         bX4w==
X-Gm-Message-State: AOAM5329AIb/9CD9F76fs0UmWudseSzy5IMqp6a1I67MGovZnaEyjwfX
        LEO9WVDzrxf91T9S2g8MFx9U1g==
X-Google-Smtp-Source: ABdhPJwwVLHMPhdrjMNvxkSMXTsMCzYn4URc8/tDzb9b69Ns+YnUQjJlGNFB2RHrq+LZwSrM92Us2g==
X-Received: by 2002:a17:907:b98:b0:6e8:9335:1fca with SMTP id ey24-20020a1709070b9800b006e893351fcamr2990034ejc.123.1649658586482;
        Sun, 10 Apr 2022 23:29:46 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906774300b006e79ea98369sm9276137ejn.151.2022.04.10.23.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 23:29:45 -0700 (PDT)
Message-ID: <1f688a08-1e3f-363a-1442-4c6dd9251f11@linaro.org>
Date:   Mon, 11 Apr 2022 08:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: clock: Add compatible for D1 DE2 clocks
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220411044002.37579-1-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220411044002.37579-1-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 06:40, Samuel Holland wrote:
> Allwinner D1 contains a display engine 2.0. Its clock controller
> matches the layout of the H5 DE2 clocks (2 mixers, no rotation engine,
> and separate resets), so use that compatible as a fallback.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
