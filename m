Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BE6542C25
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiFHJ4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbiFHJzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:55:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32A1275B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:28:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x5so21158545edi.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tYlyFzass8h6qw1uVJCGkyhUXjbk3smDlrzXeVxT2u0=;
        b=nkmMdQf5gBkPPQncIiRbX4OmocdVvb04QgoCyoOvb8/BiZwuwtHzO3RYNw51QcVBLn
         FUDNeSqLLD0qO2q19UR6R3rElVE/6r+TzOl8iFFLxMGm+f9TKQKPmS9CjnbvO4KEaxI9
         jh1wHL6AsGDk2UTWVzk6V6D5Yie/8QFRJ3me7cKSRKv7+q9LE9L1KGKbADEBUDnyevjO
         dcoTdsctg5XxZ89ef8k9GYLUvvZSeXpYS79pvU3vGvVXxDvHlyQcqEP/V6Y89LA3RQb1
         ndcc/WGZ7LAgsabiri48VMWywJfIz1fEJb8CYw7jZzOYumL5/Qt60W3Ghlr5GznqczUM
         nReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tYlyFzass8h6qw1uVJCGkyhUXjbk3smDlrzXeVxT2u0=;
        b=ygVuay+A0HbIQTfdhLi2RTnrxW/UeZfSfQb7pAe8r6dbuZdL3ytahh0YkoAiNCQrsJ
         rEVvuJNKsBLoSGtNcEaGTFTbT8Sxm5dWrzw7PHKhC2UxTEI/RFO3xCpf7x6cD258h0jF
         Sp6dq+1yKZmn1J+AKx9wLa9t+wfNb9PxYmj1EhNwNUOEJ7d2eS50MLK+4yJhP5mmTLFU
         lsXu/5gPo5DDtVHX1KBJv6uAGW7+uRskbu4RyBNJ7ebxiUV/jLoFv1p01UHIFHqT/cw/
         Ogrx+vUcb8NM0lrGTWcQWEhHNsSKt0o8hBcunJoZtlBcuePYtaeXLv8uN5GwOWlpOELF
         LX1g==
X-Gm-Message-State: AOAM533fzjxNoZFUIkLTZ8qjj8yyDL4YNyP47z+WfcDcJ1J7UXjA+rfE
        ZxM4bY8dYG5JieyooSYJkX35CA==
X-Google-Smtp-Source: ABdhPJxSvoedkDPLE3K7WO2Ng7V7WDi6E5/s8bE2TvqYyjk3hC0W2h/BYjqHyqu0LAowzu3WzqtrZA==
X-Received: by 2002:a05:6402:c44:b0:431:52cc:f933 with SMTP id cs4-20020a0564020c4400b0043152ccf933mr18473131edb.41.1654680529297;
        Wed, 08 Jun 2022 02:28:49 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090608cd00b006fedcb78854sm8876898eje.164.2022.06.08.02.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:28:48 -0700 (PDT)
Message-ID: <e8f8f42b-9df3-d9a1-893e-0f972e27ef80@linaro.org>
Date:   Wed, 8 Jun 2022 11:28:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: virt_to_phys outside array bounds warning (GCC 12.1.0)
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
References: <YqBgWoXQmzVczRDo@debian.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YqBgWoXQmzVczRDo@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 10:39, Bagas Sanjaya wrote:
> Hi everyone,
> 
> When cross-compiling arm 5.19-rc1 kernel using GCC 12.1.0 (armv7 with neon
> fpu, multi_v7_defconfig), I got outside array bounds warning pointing to
> virt_to_phys() macro:
> 

Thanks for the report!

I think this was already reported:
https://lore.kernel.org/all/CAK8P3a3X0UwQiVNZqvGmSKi8BX6zg=k07+9Q3rDGqHVkc8Hdsg@mail.gmail.com/

Anyway, for the future:
I don't think the CC list matches the problem. Please bisect this issue
(since it is reproducible build time, it should be straightforward) to
find offending commit and then Cc responsible people and maintainers
(scripts/get_maintainer.pl). Ccing half-random people might not get
necessary attention.

Best regards,
Krzysztof
