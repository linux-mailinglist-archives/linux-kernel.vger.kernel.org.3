Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B2651E84C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389390AbiEGPuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385869AbiEGPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:50:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9023668F
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 08:46:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z19so11727791edx.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qlyXe/PCI3WzsN++V/F01ukEV4Sfb+BkaPj3isarbsE=;
        b=xrTpFictnSpYWAbaK34I5kAuP6u5mfh8p4ZMdPl0gsNf9yZLSy+FOyYutaX2wDGMOQ
         E7Zuc9LI7nZu8m1CWX2xYsvVftdkHwfMkFcNy2nJX0h6II8jhWy8eqzHl1Rjmtjdjc5T
         Ivqt1O7dpycqNAadYpSoGnJBeYmzXmdJYelpWiJcRux6AkSgU1/QlzpIE5V9MVxiChAE
         7aHnGEqOOG8D0w7DtTw32j0yAU5jdk5Yvp8v18xR+GyYQmZNfzPlK/UPBTQsQ8MHFcnB
         9lj34pnxk6fqrnjDy4sl+XVF012uBkJ50EHDhZ5fQxkPq8lHtWig0KVDQvA8jZ9jdQx8
         FpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qlyXe/PCI3WzsN++V/F01ukEV4Sfb+BkaPj3isarbsE=;
        b=JXpjDTEbg5w2DeNQYI1GYbTL/DAOtnrEmSgiQQo3zomYu5b174C0BJvYArodrni9Y4
         bCtKiEHeFlmnSIjBUTtt/C0G7KyS1Vl6NMatxl8q2eCE3LaVw8QslBIGIVtZ2GaKF56N
         7GYrykXGCWsiCLDAqvLwC4pjmJVfR/g9GG6PAeTbwAy4B/a6tJoC3lC/wOLVYErwSc1o
         4CjtMmvoCi157gaXp3l2Plu8VECiS40c89nBK59YSjsjiK2fzFX70czShwk0wpUb0D8o
         HKIVfko0a43UurXIclEXA0+NBTuupYxk3Dgj9vXNUPoWwvJDr9q17vv98bp3yg3iWxzb
         h5vA==
X-Gm-Message-State: AOAM533XqtoTd8GGqJHWmLyog+dI3DHIF9hGsmL6eqPAa2IDX3gxsx2v
        A/5usR3FXKk6XU2RBf7uKXuFpQ==
X-Google-Smtp-Source: ABdhPJxJf8kIvRK6Bki9YpxPo960c5ocwQlBvB85sRQc9cAbdz7vRzpsUHob3PP+BzKSzUC3Lz8m8g==
X-Received: by 2002:a05:6402:520e:b0:428:22d0:e996 with SMTP id s14-20020a056402520e00b0042822d0e996mr8987898edd.250.1651938407017;
        Sat, 07 May 2022 08:46:47 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gz12-20020a170906f2cc00b006f3ef214de8sm3109579ejb.78.2022.05.07.08.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 08:46:46 -0700 (PDT)
Message-ID: <1b180b09-f2e6-e3dc-ba93-45b03dfcdcbb@linaro.org>
Date:   Sat, 7 May 2022 17:46:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/4] Input: mt-matrix-keypad: Add Bosch mt matrix
 keypad driver
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
References: <20220506072737.1590-1-Gireesh.Hiremath@in.bosch.com>
 <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 09:27, Gireesh.Hiremath@in.bosch.com wrote:
>>
>>> both matric_keypad.c and mt_matrix_kepad.c logically operate differently,
>>> my openion is not to merge both.
>>
>> IMHO from the user/system-integrator pov it is looking the same and so
>> one driver should be fine. To distinguish between both modes we could
>> add dt-property or add a new dt-compatible like "gpio-matrix-keypad-v2".
>>
> 
> as mentioned above our keypad is not complete matrix keypad  and it will
> not be compatible with matrix_keypad diver. that is the reason we derived
> mt matrix keypad driver.
> 
> to avoid confusion, we will rename the driver as bosch_mt_keypad.c
> if you suggest.

Sending a new version while discussions are ongoing is not how we reach
consensus.

Make the driver as part of matrix-keypad driver or bring real arguments
why it cannot be merged.

Best regards,
Krzysztof
