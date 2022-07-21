Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545B857CDAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiGUOa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGUOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:30:27 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610602B604
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:30:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bv24so2553321wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XhhMsY9RfWRqTmpaxcMmlEuk/6JY2Q0sFPTnxJuSH/c=;
        b=HF/GiANUG1tbwXOkMqbonr5uqgeDDqKXeHrpOGj9X1YCLcgJ31NlFsLSr19G+Us9iB
         fje0mIeU4RN4HWR/+C1BatWkzkD/Cylb//dKW0uio4/xskDi7YQBjPIcNnhBgkbOV6fq
         cz3WwLwdCrtnco6bL63SgRQ+LFIrLEeVdrNP0RRdcf76IGydcR4HYfLgo9tel4+DH2QI
         JeHWn8SsvVabE2yEQKwfRToTepvHML+GqcfARbnjBlMIaMQlZv5gxMdz9lK0EmltBh1A
         8Tk9OVCAkTsnvvLX1Fen9dReiGaKEXmKgJ26gzi0HuWd2GiYsq0GPBQy3SqgYxJf49ul
         MCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XhhMsY9RfWRqTmpaxcMmlEuk/6JY2Q0sFPTnxJuSH/c=;
        b=tfJaT2UCR/4pF+P3+65RY53eoug/59i/YYaqL7mNQ9SiruiVW36bbOfBGj+q83ngXA
         wdQChWE6AJliSra8EYm+X+apUbSLie8R2IbMxUFOfZqfhacOLIVc2H4RAbdkF6ZBi/in
         XF9nUhwSR8TAmt+ahjadBDVyzSEHPg/eu4frdHbRmH2d7oCa4I1XhY6P9DiN4QofS5Pj
         eDtV5KTq7IyF5IM23u88y8XIyn12yc/iunxHt9s52NCTrWI/ewq7FAgY8JEB4m/jEm6I
         Nhc9ySYo91LyigUQjoTNOyIFPMdfL5g60zui747wWzHh5BhM7UvcaNb7jfTAwvglQ2Wq
         rA2A==
X-Gm-Message-State: AJIora/UEvKRZPPgqaDQTjPFzCG7HQOFY1u2DjAWyYvrjAvtThYEftMf
        /mSyTmfo5N7QSDBDkmTsEyncew==
X-Google-Smtp-Source: AGRyM1tSv2LRbOsioc1gUtCnwKFEXIgzbpBFTfyM17uLvH/QU77KYxhHSkynSfcLTg2qDA6NtYC+Xw==
X-Received: by 2002:a5d:59a2:0:b0:21d:a96b:b3dd with SMTP id p2-20020a5d59a2000000b0021da96bb3ddmr32689302wrr.128.1658413823838;
        Thu, 21 Jul 2022 07:30:23 -0700 (PDT)
Received: from [10.205.160.53] ([95.83.233.54])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d4486000000b0021e47fb24a2sm2138817wrq.19.2022.07.21.07.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:30:23 -0700 (PDT)
Message-ID: <157e8ae8-2456-dca3-ab2e-5f60a5223ca2@conchuod.ie>
Date:   Thu, 21 Jul 2022 15:30:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 3/4] pwm: add microchip soft ip corePWM driver
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Conor.Dooley@microchip.com
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Daire.McNamara@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220712142557.1773075-1-conor.dooley@microchip.com>
 <20220712142557.1773075-4-conor.dooley@microchip.com>
 <c49776c2-4807-91c1-010a-a33bd98b68b7@microchip.com>
 <ee05749f-c33f-3505-4309-f4d036de92a1@microchip.com>
 <20220721142030.yh7x3ebr2b4fcunc@pengutronix.de>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220721142030.yh7x3ebr2b4fcunc@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 15:20, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Jul 21, 2022 at 11:05:54AM +0000, Conor.Dooley@microchip.com wrote:
>> Should I resubmit now with the warnings fixed?
>> It is a pair of unused-result on the mutexes & a unused-variable so
>> they should not have much of an impact on any review you would give
>> for this version.
> 
> Don't wait for me to find the time to look. If you have some pending
> changes I prefer not to look at the series with known drawbacks.
> 
> So fire at will.

Cool, didn't want to send a revision if you could've been in the
process of looking at it. I'll send the fixed version so that if
you do get a chance to look it'll at least be a better one than
v6.

Thanks!
