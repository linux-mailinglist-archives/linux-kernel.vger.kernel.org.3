Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625EB5612DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiF3HBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiF3HBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:01:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2386A340D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:01:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cf14so25254182edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4havqDPfkE39qEzmUo4R6ZOB4ks9d4XISp0Vg25orCk=;
        b=ESyenbJNerQxyg45Hhrne3TpmXrAgFhQ+9b6lJGxP6o/wpuQ6cAvD5LgxnbfNtvQvT
         XMw2BX8fNwTHhDkmtHSucgkcg1V50uiAoHBupaWnB84utVOV5Seb7bCnPTP6V9IDPXfb
         GZAohrcAH97stGZ2Mgd4Ptu5wYLXjA6vAfGyo/r+4wRCkMkOXngAkt39sfrxlBhF8lTk
         KC4VEHmE5A8p6pJv8FYCmBhwGQFuduZ4+j5uFKJ0nfZz7K/+XnmEwJ7bxzH0m46/aXeQ
         hSH0LQCQk3b0gH2BygZLPs+dRHBLSClYWmTm+1B+bjRwSjGQv5hSufAmqRWB04R9bYM3
         Cs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4havqDPfkE39qEzmUo4R6ZOB4ks9d4XISp0Vg25orCk=;
        b=7+wOkDKj7Rdy0niNTPZAgRUj92i0OufSPUcyS6d0gSveiuEQ6yDEDXvwopkqpns1NV
         yJIzUTzx687Sie1naTD/1IXdZGXA/kmnwQ7WfhLx93RNAu+dn4phHk224kMeA5F5oLL8
         +5rs84oJX+NSZ3/gq6Z3rAhgWTUdbxzxKkBBmeC2KOPQ96mvqAIApNHMOl1v8/cSALK8
         VkgXjsSEPWfjyOeXEywQPjwJ/HThNX40ENsxqnMf5sQGMKBhenOPWydYrgfsZnw0Ak1N
         3sqg0jz4sTJIvlA05vseRxg6Xk3jYBinFC/2Dg1t+DmJXwTqAhtG2/Ip3tXYVSuV9MKj
         XY7g==
X-Gm-Message-State: AJIora/JoIPguuS7uLtBKs+IODAvM3005dNrN0330D7pc1iI16vdbMDy
        HaUIbzMgk1BtmwmLDiqTyjd10g==
X-Google-Smtp-Source: AGRyM1uc1/mOfzibDoU7I3yoNDX5A5kAfZ70naoDZLeJmJZLOARoJjnXezRj5l0jWnMD1zMhzoVc3g==
X-Received: by 2002:a50:ef12:0:b0:435:81f3:a93a with SMTP id m18-20020a50ef12000000b0043581f3a93amr9224461eds.80.1656572469783;
        Thu, 30 Jun 2022 00:01:09 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bq15-20020a056402214f00b00435a742e350sm12695189edb.75.2022.06.30.00.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 00:01:07 -0700 (PDT)
Message-ID: <a8f8fbbd-60ac-3e45-6fc3-a128ba533683@linaro.org>
Date:   Thu, 30 Jun 2022 09:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ASoC: samsung: change gpiod_speaker_power and
 rx1950_audio from global to static variables
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, s.nawrocki@samsung.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, arnd@arndb.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220629185345.910406-1-trix@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629185345.910406-1-trix@redhat.com>
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

On 29/06/2022 20:53, Tom Rix wrote:
> sparse reports
> sound/soc/samsung/rx1950_uda1380.c:131:18: warning: symbol 'gpiod_speaker_power' was not declared. Should it be static?
> sound/soc/samsung/rx1950_uda1380.c:231:24: warning: symbol 'rx1950_audio' was not declared. Should it be static?
> 
> Both gpiod_speaker_power and rx1950_audio are only used in rx1950_uda1380.c,
> so their storage class specifiers should be static.
> 
> Fixes: 83d74e354200 ("ASoC: samsung: rx1950: turn into platform driver")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
