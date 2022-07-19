Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFC957942A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiGSH3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiGSH3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:29:48 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBE333347
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:29:47 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id by8so12763575ljb.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=qYJ2Ci7a1lf89U1vcDBY/8u8HhjuVkqjFLJSEkMj5js=;
        b=YPtJ4Ht2+jDuXfhE+S4rx1PKtgJo9YPPW+4ozWIKgJ+vHqvy9qGnTbe9sWKLtoZoxU
         CIQF/Mt1IONb9Ra5dk0390QEA2tGt1mm+GgCKjw2+4c9uyS8422nmCdd2rPx7iG3XKgW
         ZQdhWeTtw/d/Ezu3bhQIYliiHmc1xTho/A3cWmoCvGfSaiqHx7R5YRvW2ieDYoCPzAVd
         TW3a9EhghwNm1zI/xon36cf4dFHRTexgl/Fa5Gj5l21cFOocZ6eUB2DqaTaIfFFSb7T6
         a11R70OvPvJ0uo1ytdEv84d5IRofuGVfuiBWdwQLAn1jpwP0TstN5ZXJsh5qcYv5hhrC
         DTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qYJ2Ci7a1lf89U1vcDBY/8u8HhjuVkqjFLJSEkMj5js=;
        b=Dnt8hkz16dlQzpqM/tbj+Vu68mnumfL6AfStpeAX1wQAWEC7vsARi1SM0Uo2o2lh72
         EA9WBFiw8kaEAbdlea7emRWCTRq9Ld/JXj/DfaaNl1TEbaBwXjgp+KCmu6Kq/kE9TU1Z
         k1Je/2UkzTCXCKnF8EUfCL+lza7lxXH8bBAhvl/OCr0O12kPS0MvuSroSuUdFdJ7tNpB
         MrMumOs1EccTF5cOzqwgQJkKRAgEAmwX4oxCl9VmBV2EXrZndz45vwvmk/Rm6c7HLg9C
         1sGhkhIPCjjTtu4aMrV6q1Ij+gjpGKjI2HN6Yl+go+/5TFip1leiI9I7kuc9lhLqxDjl
         /lNA==
X-Gm-Message-State: AJIora9qDqcrGTNmG/UgVFX5lABN8CkRf7pnXWF8iidc7yWkScI8dGfN
        NdAnUNc61FqigRI10Bece0F0pw==
X-Google-Smtp-Source: AGRyM1sxC2K13iDqWHb5X25rEERWhy/0IQ2/nnzau7ycdv9fY+X1L0+CnVLZLjqYFJO9YORihTHvZg==
X-Received: by 2002:a2e:9992:0:b0:25d:8e5f:bb96 with SMTP id w18-20020a2e9992000000b0025d8e5fbb96mr13646884lji.113.1658215785732;
        Tue, 19 Jul 2022 00:29:45 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id h11-20020ac25d6b000000b00489d16820ecsm3067155lft.165.2022.07.19.00.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 00:29:45 -0700 (PDT)
Message-ID: <12a2487c-6d49-af99-aa5c-edd7a2eff071@linaro.org>
Date:   Tue, 19 Jul 2022 09:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] clk: meson: s4: add s4 SoC clock controller driver
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
References: <20220708062757.3662-1-yu.tu@amlogic.com>
 <20220708062757.3662-4-yu.tu@amlogic.com>
 <7fe9aab5-73a2-6209-ae65-d955c426f745@linaro.org>
 <f5bf2abd-4d60-523a-3f84-879da2f1c78a@amlogic.com>
 <152cee25-9a36-a948-98e7-847d9ee36c1f@linaro.org>
 <50078eed-3c24-a4b5-1e21-3187daa9867a@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <50078eed-3c24-a4b5-1e21-3187daa9867a@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 08:58, Yu Tu wrote:
>>>>> @@ -1772,7 +1772,7 @@ M:	Jerome Brunet <jbrunet@baylibre.com>
>>>>>    L:	linux-amlogic@lists.infradead.org
>>>>>    S:	Maintained
>>>>>    F:	Documentation/devicetree/bindings/clock/amlogic*
>>>>> -F:	drivers/clk/meson/
>>>>> +F:	drivers/clk/meson/*
>>>>
>>>> Why?
>>> Warning is displayed when using checkpatch. I will correct it.
>>
>> What warning?
>   ./scripts/checkpatch.pl --strict 
> 0001-clk-meson-s4-add-s4-SoC-clock-controller-driver.patch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> If I add that strange change, I won't have this WARNING.
> Should I ignore this warning?

Yes, it's not related to the patch and the change you made looks not
correct.


Best regards,
Krzysztof
