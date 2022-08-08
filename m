Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5606E58C550
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbiHHJMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiHHJL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:11:59 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDE3CE30
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:11:58 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s9so9138286ljs.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CycT57vVE3vgGAz0KIYGpbiFM2jY0orH9VOKiiAVo8k=;
        b=h/KzhTM9AyqGJqRxlc+MhTcUqbcC5Osbk81KsnuqZ9dsr0zYdaUhe0RABAO6JEgUkY
         PRkJ4YCWidaQ5WGM6noYjyxHtgrM0q2VuJYnG0Pj+93mfKhkOr88h70QJOLbvkIJ7KtH
         jLIWBrGZ8fRs82pofBtvs4b3hZ/ijIJBvGv6b5om6GGciGXyTClKHLt80MkuZ3RN9l0d
         ndWKD2XsfRm4wDxqeyKgdOQO47P1zQ9xMQjJ9bJmf1HLEOHuC2IVX061Qz+5xNzZdeGp
         YLMtp2Fbb+JZW21uAqbsjLmrl5exIXOjsO57AuxuYo5x++HyVDAXNEjFqvs9ttnPBD/O
         0+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CycT57vVE3vgGAz0KIYGpbiFM2jY0orH9VOKiiAVo8k=;
        b=ry1IF7ZckLm2MynfbvYY9FKtgugv2fFfYYeTOBHY18qnwK7cJ+lah400cyBRZzHN4Q
         r9vakfOdKRt6mqdNsBHaFeNak5+vnoi7Wv6jwFc3hxvW7qHz3e25jT0uXj8lJ5xsxHnC
         K/CjXoNI22ll0Y5NMas+73WKFdkV8TKCm9i2Ny7X8NRkyZRvIVnkzBF/kbmeDM3pnTy5
         kBL78mwxHeqRXEoMEk+K2fZ3nzPTRQdBxE3wKQukjBBqJHDWx7rp0x0cusL5U9q55KNH
         avOekcs7jll+rznD5mZBxgS1TxpcmLE5gBHpk+Q09ovC7w3GfJ6GlHbceE6qWyZOIe6k
         L2lg==
X-Gm-Message-State: ACgBeo3eaArZnCAKg2KAo4Fz8V6Hr8Nr9ulczyiwboveqOKhDZl2lNuB
        t/dSK9nSb2ZfFa1l/eNMP57TAg==
X-Google-Smtp-Source: AA6agR73xNKLU2mEOXi/EQfEY8FWOs6hGN3OQLAXUKAb1QGwMJsgDLjFWMbS4/umCukX5wXQKC4SLg==
X-Received: by 2002:a05:651c:1581:b0:255:48d1:fdae with SMTP id h1-20020a05651c158100b0025548d1fdaemr5548770ljq.286.1659949917159;
        Mon, 08 Aug 2022 02:11:57 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id u17-20020ac251d1000000b004786eb19049sm1356477lfm.24.2022.08.08.02.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:11:56 -0700 (PDT)
Message-ID: <fef0b306-065a-2635-2342-0d50ec93f705@linaro.org>
Date:   Mon, 8 Aug 2022 12:11:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 22/28] mfd: max77686: Remove #ifdef guards for PM related
 functions
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20220807145247.46107-1-paul@crapouillou.net>
 <20220807145247.46107-23-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220807145247.46107-23-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2022 17:52, Paul Cercueil wrote:
> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
> to handle the .suspend/.resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards.
> 
> The advantage is then that these functions are now always compiled
> independently of any Kconfig option, and thanks to that bugs and
> regressions are easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Drop the address. Does not work.

Although of course I wished address was fixed (about which we were all
pinging long time ago).

Best regards,
Krzysztof
