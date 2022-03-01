Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008814C9798
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbiCAVPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiCAVPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:15:38 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E567660A9C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:14:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bk29so5175558wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 13:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=21ZpNKZmtS6JPBiLSHjJqzNPL83E2JLLr9bEtvwDEDQ=;
        b=N36JrrJ95ywm/orOhQxmlD2cenBh7/qOWIj80Xh/pqxDJbOzgFJkN/NBq6JrMUJA5E
         Ket39SuYBMCgMNmzNL27D0ndZ5xiDOrej/f4pu+tyzTcPaOAKcat1fmzzIUQTSfKFozA
         J5igyhIAK3nrXF2DiHap/utxdulPzBRi1ZLfEdEM4D66OBOTcfaOTdo8a8vJM+lmMorp
         qa+cKfduNHANXkmKTiv+fqZ/hmTXj/OLD+YnPOGDLMJUnlpVQfX57VB9zv2+cs5UxaAu
         JDlz/pMJEddC9Ox5kn1RYSi3pHNcb0f61FfK/2azMPfQw5M0MFg8V8CQhUVMO5u6AOYp
         ARcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=21ZpNKZmtS6JPBiLSHjJqzNPL83E2JLLr9bEtvwDEDQ=;
        b=li0JYmbZVNTM/+zHIEvWJcuGZ4lPBA0jEXAU1XR4XksYm8cQGTKzvqs4VCr+t+d58p
         SMzJKjJKYD4CfA+REUSQoQEMgI3hdX1z0VEk5GqmqxL83JmGxjeqAG4wzl8XrTt2m70I
         TowJN4pKNSMESWDXKSrW2c+Jg30bBuRcliuE+7An1L7kufCaiIcnLFSlaeq8weqcx+LR
         1ud4L3x5pRb3J9EVjEjgksuL2hd3cXAPz9oOqRRDjGbD+gX5P8C1MxCteXhU3zMNwaNY
         4Bsgj9FZj+vTYAK3kAE3Ej/sH8YTmB+AlCqutKeXnCi5cdiurcksxixzR7JED28tWD2e
         qEBg==
X-Gm-Message-State: AOAM532akW63vXYVxRnkhWiXXuXaQlENrQMmrr5vQSW9WtVInYEbu5En
        7yxbAvvjqRTNmTHXNdtq2ztEjc5NfhJ/Gg==
X-Google-Smtp-Source: ABdhPJz/NzJQfpV+F5/ncYyb4EOEOL40IlDTOJLKtBg9iwn/LvVqEHH3566ZJ78yn36Uyq3VlQ5oEQ==
X-Received: by 2002:a05:6000:1565:b0:1ea:6673:c0b5 with SMTP id 5-20020a056000156500b001ea6673c0b5mr20429412wrz.469.1646169294438;
        Tue, 01 Mar 2022 13:14:54 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:49e8:f41b:b2a3:3a55? ([2a01:e34:ed2f:f020:49e8:f41b:b2a3:3a55])
        by smtp.googlemail.com with ESMTPSA id az37-20020a05600c602500b0038144e509dfsm3630394wmb.20.2022.03.01.13.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 13:14:53 -0800 (PST)
Message-ID: <548c9794-12be-f5f0-0cd8-649df695afd9@linaro.org>
Date:   Tue, 1 Mar 2022 22:14:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Use event stream
 scaling when available
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Mark Rutland <mark.rutland@arm.com>
References: <20220203170502.2694422-1-maz@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220203170502.2694422-1-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2022 18:05, Marc Zyngier wrote:
> With FEAT_ECV and the 1GHz counter, it is pretty likely that the
> event stream divider doesn't fit in the field that holds the
> divider value (we only have 4 bits to describe counter bits [15:0]
> 
> Thankfully, FEAT_ECV also provides a scaling mechanism to switch
> the field to cover counter bits [23:8] instead.
> 
> Enable this on arm64 when ECV is available (32bit doesn't have
> any detection infrastructure and is unlikely to be run on an
> ARMv8.6 system anyway).
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
