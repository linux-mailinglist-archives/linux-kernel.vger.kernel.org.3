Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4AB59FB7E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbiHXNhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbiHXNhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:37:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCCA7D7A9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:37:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d23so19676904lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3OQC25wWN31BCwSbCduRMMv4rNNc0uP1j1+GX/KbrNs=;
        b=wpEQNzNKOT3YdGIQFc9W5b5/EtVd8HmW0cSRtQ3McUNiI5LisGZjuU2uYAt2mKyQru
         AzMBKiyOgm8/Q3bG8aYCqcpFdm9vkK4P3WehHpgPTlCHqL6yuPNdZVF7C8uNWKCYlINn
         6+qUm2A6XD3U7BSDZ7Ou+pQ8uFQLnxaZ5xpm7Af3Es0Vkr2Ay4dmtnUkOdN3jXejV+nJ
         1k89Tr5XCrXGp0N2FYyKADU9eQnhR3PcvV86MxfyI/Vz5kstDIweKPpOOTfzTbuVb95p
         lpdUqQgEUOyHo3dBPAZfOOtruz07kPs1C7CdeE84Tq1nMu3TA4KnPpmaOAvqPJhPhf8v
         F8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3OQC25wWN31BCwSbCduRMMv4rNNc0uP1j1+GX/KbrNs=;
        b=Xcx/iPBDEI3zdx6Yy5OqwOgHWsdTpC6SroslETF9U33aVH++V3FDVoI+S2SZPRuKIZ
         fvy1XmMFJFYFIcEGTHl11urP1/qbi6EgU0PO56cEjOZ4m8VbiuWmrEYVv5gxTyGe5/j6
         8L/3dDqmFhpOhIBZjeI4MhcVrnRihYqcU0sAkkfcxrhCGqDi6xPFfSemE3SQzlwuzzkJ
         VZM3t+igsjYQ7LYcVTq1yOzlFHSkQke2VuV6uF5hf1vDxmyA/Ijx9nkZ7pZpwuM/DeH4
         vUZY44319Fr0Z38BL87PKkPLUQQW0WWL7Ck4QP870cApcmFMEOYun//sg+CFiBtj1IXx
         tNAw==
X-Gm-Message-State: ACgBeo3+SfU6ZpR7VcOAwKQKHPmmmK4cPltei7PE48wDFiuEBeuyqAU6
        vaLxzjzvTRGgNud9RiRYfGLuDg==
X-Google-Smtp-Source: AA6agR5mW8yFmhKsYKo2N4/NXGAdRcP64LGKPZsWPykSgeE9dIVxYgh3zulrgO870O0ziP3kisYhfg==
X-Received: by 2002:a05:6512:2385:b0:492:e4cc:17ca with SMTP id c5-20020a056512238500b00492e4cc17camr5102483lfv.132.1661348227725;
        Wed, 24 Aug 2022 06:37:07 -0700 (PDT)
Received: from [10.243.4.185] ([194.204.13.210])
        by smtp.gmail.com with ESMTPSA id t17-20020a2e9c51000000b0025e4c49969fsm108927ljj.98.2022.08.24.06.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 06:37:07 -0700 (PDT)
Message-ID: <c6826de7-591f-97f9-af44-35a6293d17ea@linaro.org>
Date:   Wed, 24 Aug 2022 16:37:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V4 1/6] dt-bindings: clock: meson: add S4 SoC PLL clock
 controller bindings
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220823022630.25007-1-yu.tu@amlogic.com>
 <20220823022630.25007-2-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823022630.25007-2-yu.tu@amlogic.com>
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

On 23/08/2022 05:26, Yu Tu wrote:
> Add the documentation to support Amlogic S4 SoC PLL clock driver and
> add S4 SoC PLL clock controller bindings.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
