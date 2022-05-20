Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408A552EE83
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350514AbiETOwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350500AbiETOwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:52:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C5E1737CA
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:52:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o22so9931684ljp.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=t4cBrKeJtdPwBWEs6cNQFiz2k88jVwV/q/Fcx7GSQ1I=;
        b=wNWXSDQBptmUZC0tIJV9zQckCzxtUc6HjyEQju3BoeKlXd/WmARYVMMzI0AVfbpGQ3
         1GzA2Pd6mpq8QL1Lu8IeyRxBNVzxaYr1ERcueH12TJnojGwUzz5dY8tzhp2w37rSA6Dx
         A1rk2KGqd5QlheBPeI8aHLK0/GbjdqdvqaKOv6OnwDOwNUyRrrgmHEbYw1qac4RIc7N5
         gASPxjb7MnPys81/KJ1dFXS7ZgOuNz9CCtectXs+FQetduvKiFYygoqUXPbvX771ZQvw
         b4tm1UEFAIcEnoVLJCKedJbmq7VtFErvA2tD2c8veVK06Lge8F9jrqbo0nG/9a40GOmq
         gvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t4cBrKeJtdPwBWEs6cNQFiz2k88jVwV/q/Fcx7GSQ1I=;
        b=gm48ccTeUrxBVNAbBI0T3sgADeSScOgW5YG0UJ8XGW3zq+F2me6RN6DdSqWapUuwOk
         LsvRyHh2DDRp2f/GLitnpzbigBc0RYONUz3cHcKoV9qBFa9ytLXVgGUHWYGaIM5OPbua
         LLWutm+M8m8OhOUClRLXrVTaYzCyxP1DJ4HZg6Mw9t+S149u0laLLKrGxOlHsBtsPuSV
         6X8qoGQVx9C60feJtRwXvlMXcXekiZI+EyEopUgAGrD+fqxKbe3TjSL3CP5IpfhnZ3ZQ
         LU/PQVAsdV+poAlxTr+dA9xJsrHxscsd7H7D/xi3nOpTxup+0AfANP85i5dpSM4ZWD63
         Piqg==
X-Gm-Message-State: AOAM531Np3qOfFmVxu/rcVdgesbWXZ7Wy0GIOxMiAr0el246CltMkIHg
        D2HCuffA+krQ26OM5FXeIp6ncg==
X-Google-Smtp-Source: ABdhPJy5o1vgxnl59wae9iXl1D22FA2IlNVCbZH8udHF3OcZpjC7pAHcsx83XNC+TDl7q0Om5TtICQ==
X-Received: by 2002:a2e:b6cc:0:b0:253:c64f:ed23 with SMTP id m12-20020a2eb6cc000000b00253c64fed23mr5622442ljo.501.1653058359449;
        Fri, 20 May 2022 07:52:39 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c19-20020a056512075300b0047255d21114sm690355lfs.67.2022.05.20.07.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:52:38 -0700 (PDT)
Message-ID: <c173a336-1f57-0712-fce4-d6885e343d2f@linaro.org>
Date:   Fri, 20 May 2022 16:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map()
 return value
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-oxnas@groups.io
References: <20220422104101.55754-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422104101.55754-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 12:41, Krzysztof Kozlowski wrote:
> The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
> 
> Fixes: 89355274e1f7 ("clocksource/drivers/oxnas-rps: Add Oxford Semiconductor RPS Dual Timer")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This was sent a month ago and it is a fix. It also received a review.
Any comments from maintainers? Is it going to be picked up?

Best regards,
Krzysztof
