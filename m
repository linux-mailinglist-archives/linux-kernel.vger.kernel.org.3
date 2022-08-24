Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F64D59FA7E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiHXMwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbiHXMwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:52:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1838A95E49
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:52:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d23so19501980lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qn9bLMzRw4TWagsZElRAxA7cKFvu2Mi/g+R4Ak/V31o=;
        b=ny8ePsgqdUMY2aOl5GLsn9h8H1FWPjRt+PjGl1/FzaqaQ9M1fECiwE0BAO0KoKAUqD
         HNDVxxt43whiV4mAcniuzN0VHo7iqMy8GGlYK2tTjUnMaC/qFVkTp4nOcN+CSa+nTcyn
         dz7y0jBYhXSiYgGUAMY4wAOg8A7no246xkYM8hN9UmeKW+GTiCdkrULiCAsuUIo25lHY
         le7f8DtwWmqY+BgRudkaXrE5z8Lr/My2e19M76+jzefjTeEsqYUu7JvRx0R9OnRWXsMt
         xocpy5usGfAonxeJl7sar9Ldl4NNbMztM2gZlBk3FE1c7qz/S2vsZqja0RnOySS1lOkD
         EuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qn9bLMzRw4TWagsZElRAxA7cKFvu2Mi/g+R4Ak/V31o=;
        b=inU8JS1/V64WKEOuSrQcaSSER3wZrjsGSRl0HI/p9rnycWAVOicYw4zNR3RBYwC99S
         10kFvF+5l91GoH7xbXvZoALSzLhGBq8PwPSTcFrK/ibpRZWLj4zs1wSedq20W8ZTY1NR
         b+v0ceFuE/M2IPZU1xaThL6bG33qKxUutrZlqI23H4GRTz8uaMsDV0yU45vI/PglBdwX
         rQUjJcjYB3o7BId4dE6gxmg9CVBWnwipgr/1epN4cO7LoSd7Wg2h5cf2iBJi16oh8nmF
         YZXM7DBP3cetHYbdgw2kWyCuIvJO2Ud2hNX3i/7ag7jklYoIMWkEm9xAldcMRtR2zllD
         rzGA==
X-Gm-Message-State: ACgBeo2d9q1/5n1k6ol/jRQxLoBtBdBfNwUIqeNDIRjO3u3yHiI67aSY
        15VcqvnVWuMu9joqIK7lYVMn0A==
X-Google-Smtp-Source: AA6agR7byK21kURSxHby1jwyhJHvEgjvPK+9OE+btQG1cQszbBV8p3p3jr1j4IFzhBHhpNLlelHrOQ==
X-Received: by 2002:a05:6512:401a:b0:492:b6b5:34d5 with SMTP id br26-20020a056512401a00b00492b6b534d5mr10121992lfb.570.1661345527495;
        Wed, 24 Aug 2022 05:52:07 -0700 (PDT)
Received: from [10.243.4.185] (213-212-21-103.static.ip-only.net. [213.212.21.103])
        by smtp.gmail.com with ESMTPSA id s20-20020a056512315400b00492e69be4d6sm1464494lfi.27.2022.08.24.05.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 05:52:07 -0700 (PDT)
Message-ID: <b2340a92-c083-bd83-aca1-fc2edccc825e@linaro.org>
Date:   Wed, 24 Aug 2022 15:52:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] spi: renesas,sh-msiof: R-Car V3U is R-Car Gen4
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220824094327.33685-1-wsa+renesas@sang-engineering.com>
 <20220824094327.33685-4-wsa+renesas@sang-engineering.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220824094327.33685-4-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2022 12:43, Wolfram Sang wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family. Hence move its compatible value to the R-Car Gen4 section.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 2 +-


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
