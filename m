Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A80599B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348919AbiHSMIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348909AbiHSMIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:08:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C55440E01
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:08:33 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x25so4334700ljm.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gYlvSOH2ZR9yG5YZYS73Kks2lSHpxherM/3sStGglc4=;
        b=AKhBopHyjkUUD476uCKPXZ5kZ6ivNsGEekgLzlL5gUSf/81dCqgMambzpDHAL/7k+U
         bmJR+ty8AhG9TfyVnceVHuxsvUVa0KEmCGn564GbAPcm1aVr5HhPyadAbJR2WK3EwxYQ
         e51htsDMYPPnUu2KrhJHVjHR/mNFY74nJCIeZMMnUbzaizyKvRZ+7b1fusxNapEgV5rf
         +lG4t90FG+3BAn1/beHjVzbM2KENz/91MLkC1YBXlHS+KtEKapadviz6+bw16RgFNZOU
         2RYCThIzGC0hwZ5q+m1YpfZ5NaVbe25AIQ1Edoi4rX+cERbQLsG7L/FCw0EboKYDEzki
         UsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gYlvSOH2ZR9yG5YZYS73Kks2lSHpxherM/3sStGglc4=;
        b=nj7or0dYElrwdJ75Ze7t+WybbWx6+93A5PPvksciezdJCVS86cSss31DZNbVoM0ojK
         IrF9Z1OtzKqNGRILMcdSi+EarhVL9eruTrmRy91XVN7mDb1IrsENK25WxOUUdRfIBIBl
         Kpz87x6UHWwEjvTJtBxA8tvd2apm6hnDVCOgV5vzeR+jW4oCGu/UNLhoiMhrKZwr4a0F
         7NCfUZIGm2z4VJOHH9RtSdEMenhIWHErvwGUF4nuehiZidlolqGOu7OK3Ctc9h3LzJOr
         ey5i8URNVG4Xi0kib1QNxvQjUxb1U65GchBS8PZN/TZveONlQd3ymhV0A9vjB26sn1XE
         casA==
X-Gm-Message-State: ACgBeo1inZzn2nR7jBIinuJo7xOg6YtRt6029DMJ/Yuh7596FcFR1+J8
        e5IbYKnbLnOIDDBrem60tdzGQDeYN+r3jCEq
X-Google-Smtp-Source: AA6agR4BSkJikacdrzsgi9+x3yFGN1+/XRQnM3CVNSTuiVQe3d9K9BmB1TO0kshDrImlqJDE9oUeKA==
X-Received: by 2002:a2e:a44c:0:b0:25e:7181:dc7a with SMTP id v12-20020a2ea44c000000b0025e7181dc7amr2026838ljn.504.1660910911386;
        Fri, 19 Aug 2022 05:08:31 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id i9-20020a198c49000000b0048b31fa9f3asm616101lfj.179.2022.08.19.05.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 05:08:30 -0700 (PDT)
Message-ID: <a2d671da-ff4d-5c7e-7136-63cd51098207@linaro.org>
Date:   Fri, 19 Aug 2022 15:08:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/3] driver: input: matric-keypad: switch to gpiod
Content-Language: en-US
To:     Gireesh.Hiremath@in.bosch.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        m.felsch@pengutronix.de, swboyd@chromium.org,
        fengping.yu@mediatek.com, y.oudjana@protonmail.com,
        rdunlap@infradead.org, colin.king@intel.com
Cc:     sjoerd.simons@collabora.co.uk, VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
References: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 09:59, Gireesh.Hiremath@in.bosch.com wrote:
> From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> 
> Switch from gpio API to gpiod API
> 
> Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> 
> Gbp-Pq: Topic apertis/guardian
> Gbp-Pq: Name driver-input-matric-keypad-switch-gpio-to-gpiod.patch

What's that? I don't recall such tags in Linux kernel process... Is it
documented anywhere?

Best regards,
Krzysztof
