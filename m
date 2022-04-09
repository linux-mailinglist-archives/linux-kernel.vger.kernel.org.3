Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988DE4FA7E9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbiDINDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbiDINDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:03:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B632EFD
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:01:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g20so12905927edw.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c9dM3853RnMFXxBz17KqwFXKDYGLlscOpcfs4FJdfuQ=;
        b=LWVdH3uG36OJu6zfwpvkQ2SDiedaK8SV5p22SMwUSqs/+bMmWey9Yy8KY032Ev9HjV
         Zg3p+3gn4h21XGfibpCDZaXgDQZ21MX3/dkYntudZPHMrdAWNrAu/xKig0HYAfuUhXEC
         ADsthBEnSHiGneX7/qKZp78xYZKXSxnDbtdRruRAnc+YmID/ALcQkPa19iL+8eVkYLkL
         TxWkEWZWVeuabTsGkl1logTyKyCTIdVv8Eq7JcvFQa7FvCVracdy23k8f9Pr6aBvmNST
         4z81dnu49+6N7c9GROhvdlphf0pY/WeDRhDTpCirpxpzzA0RD8YIbzX4VMn4FRfluOYa
         DnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c9dM3853RnMFXxBz17KqwFXKDYGLlscOpcfs4FJdfuQ=;
        b=KW5qNo6lKOXkX+qeP3Rd+X6i8S0GF0ovNPvnPf89wuvCWxjQ/ZVS1vaRxZzRx3eaKa
         sze0zrw9LGV4IzUyEu35W7B9aOzGK6YrF4m41OTq2fr6HBWL0TtckalBSUep8Opkto3q
         suIOwP/Moh0DqF2vDflHhVlmva2Iv1Tr8BCJvnBzoSNjZcHmIu+UCUjkd86H2OJbP0kz
         za8A3GBbqVyIDP1UY5om8R97vsiGemVGRccQCgCUGMHNTQb4aVb56YvWTxKl3wOqhs+2
         R2pQcwyBkip6CPg4Nmketapmy3DGGVQXHo/6Cph/58lupDHEUcBzMDThSKcC/3VUPvdR
         dkPQ==
X-Gm-Message-State: AOAM532rYYUH9zartJMffJ8/PSHkxthkqqoiYz8AzyNl1HwuHMdfZ/23
        XuuUiQ5+WK8RF2l4KZZBp2mY9g==
X-Google-Smtp-Source: ABdhPJz6VgeARo0M98zu/J/i+gEUu2WhD2bzJkY9CzUcO6xAjDrdkOP2Kd5xEhDGol+ZqT6u4pR6lw==
X-Received: by 2002:a05:6402:42c6:b0:41c:defd:24d1 with SMTP id i6-20020a05640242c600b0041cdefd24d1mr24532402edc.326.1649509286375;
        Sat, 09 Apr 2022 06:01:26 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090674c200b006e13403964asm9809747ejl.77.2022.04.09.06.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:01:26 -0700 (PDT)
Message-ID: <bff9b95b-7a92-5229-855c-0972e38eb222@linaro.org>
Date:   Sat, 9 Apr 2022 15:01:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 13/18] dt-bindings: fix jz4780-nemc issue as reported by
 dtbscheck
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <84adfe6237cd4cfd52cb9723416f69926e556e55.1649443080.git.hns@goldelico.com>
 <036b66b2-c221-6e9e-6a56-510e7a0d20d3@linaro.org>
 <VDO2AR.XO9112UD3KYT3@crapouillou.net>
 <2e1495ab-2773-a3bb-0ad2-4af607cccc11@linaro.org>
 <O7P2AR.D8D4QSYF9P8E@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <O7P2AR.D8D4QSYF9P8E@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 14:55, Paul Cercueil wrote:
>>
>> I saw the efuse children and that's why I asked who is expected to
>> populate them. You said that simple-mfd is required for this, I say 
>> no.
>> It should work without simple-mfd...
>>
>> I am kind of repeating myself but I really do not see the need of
>> simple-mfd in the bindings.
> 
> Well, it is a "simple MFD",

It's not a simple MFD, it is a memory controller. MFD is a purely
Linux/software term, so there are no devices which are MFD. Everything
which we model as MFD is actually something else in real life (e.g.
PMIC, memory controller, system controller).

> so I don't see why we can't use the 
> "simple-mfd" compatible. Why would we not want to use it?

No one said that you cannot. You just might not need...

> 
> Besides, if the nemc driver is responsible for populating the efuse 
> device, that means the nemc driver must be enabled for the efuse to 
> work, which is nonsense, the two IP blocks being unrelated.

That's actually the explanation I was looking for. It would be nice to
use it in commit msg instead of the dtbs_check warning.


Best regards,
Krzysztof
