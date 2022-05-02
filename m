Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5107517672
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351646AbiEBSYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbiEBSYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:24:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B57B659C
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:21:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g6so29318254ejw.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iItLeslMywWC75aXdXtU8Z+zXUhrV2MK1NBIxn2y2rs=;
        b=ememrw3mrzB87tbxst36sFZrP2L0uucEvly20Ws+EZFhF/pddU8fYcS7JEFCJUP+CL
         j+lGzY0fHbbQlSfH/ikTqPNafPooCBizg2Lq9AZYjeVZogIOGaFAnJ3yMaO2I572f1ch
         BtyoIhO+5B1oarNj/H8Of44qF1QB2Fofx3dByrN7GaTI3ePDmN7+tFLZvrpg0GfxKYO/
         Mn+Iv+6XPWcVY0artXR54yqQe0UEBo/Glqd773ezVvZaOxm3dOP1zOCExI2ZvwQfQy0s
         IClGWaKHCqD2zLbNOmB55lYjCMsm4C6vMLQl59E+qbMAufvlFzNaLZTja1LW/8VSq9Ap
         H3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iItLeslMywWC75aXdXtU8Z+zXUhrV2MK1NBIxn2y2rs=;
        b=65nZxJr+laisEyqAiI9NOgMulbNd3ngtoA9LDvhPAtWD/wh3nDZT6VF8YYw+pLarzc
         bj2sGy1fyU2dbfZPv3BI8qZ/nQZwjmJjvE+8FEPJ3BOy+8NSHt5AslvaYUaruJ8qofwf
         b2kYO29DOB6bqr7DIi9NPjdsC+v0wDjjn5h8A/9gXRx/8gLoF7sQdwkcW9i6aw9D4PKZ
         XcU8RAfyBLIeqBlbzZhbgjiPNKNMlID/hVl/jkSyvJMlvDFAo0GSpa/33qfWpRZtIHn5
         io7PDNXUl4vmFP1tAm+VDghvA0apB52wZW7+W2bNnNbHZTAtsFV4RMQrrJImEX8JTSzz
         jc1A==
X-Gm-Message-State: AOAM533vxFPJNn6V8x0Zfy/067f6pUcZMXWhbQlOcTzuYk7wFhxik65q
        I7aS+31rGcAXaFQK9XTVvWVTFg==
X-Google-Smtp-Source: ABdhPJxQs/h1jEPNSvWXNsY4p7A5yQi5Z4mXw2JDkI9IDc2ziVO/mSYH8FV79HltN8p7CElqnuj0Zg==
X-Received: by 2002:a17:906:c110:b0:6e0:dc2a:3393 with SMTP id do16-20020a170906c11000b006e0dc2a3393mr12215880ejc.512.1651515659085;
        Mon, 02 May 2022 11:20:59 -0700 (PDT)
Received: from [192.168.0.196] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y20-20020aa7ce94000000b0042617ba63a3sm7009742edv.45.2022.05.02.11.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 11:20:58 -0700 (PDT)
Message-ID: <717f54e9-9ca9-9ab1-2f03-2edfd7e684d1@linaro.org>
Date:   Mon, 2 May 2022 20:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] soc: qcom: icc-bwmon: Add bandwidth monitoring driver
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
References: <20220502174046.139234-1-krzysztof.kozlowski@linaro.org>
 <20220502174046.139234-4-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220502174046.139234-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2022 19:40, Krzysztof Kozlowski wrote:
> Bandwidth monitoring h/w sits between various subsytems like cpu, gpu
> etc and ddr subsystem. This h/w can be configured to monitor the data
> traffic between ddr and other subsytems. The bandwidth values obtained
> from this monitoring is used to bump up or down the corresponding
> interconnect speeds.


(...)

> +
> +MODULE_AUTHOR("Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>")

I should have checked last minute changes if they compile...


> +MODULE_DESCRIPTION("QCOM BWMON driver");
> +MODULE_LICENSE("GPL");


Best regards,
Krzysztof
