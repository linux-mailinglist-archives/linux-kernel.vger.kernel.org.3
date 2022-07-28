Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD08D5842AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiG1PMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiG1PMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:12:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B0657C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:12:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j7so2583120wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=uCtOpSLEyYITt1GhmlZoX1Tk1BoXGqoBQ38x+3SsId8=;
        b=Jbk91Xo7z1E8LsUhOjCQDWG3VX4cMDv2wfqn2eYN2QPSaZZ0LvLVctBmTTfmIbz998
         N4/efl8shL6RjV1B4BkhZSxzZuW4lk6MBUB/Pk08da+RJC7ZuS+PwlU+ONBINbgDAVwg
         gNj9G9MqHIIpNrfUQ0fcS4kzk6blurfzZ8PCYXQGhwqQkjbOWKTmzuiBmMm4hd71BCfY
         1I46V40i6Vn/Zr2mrqoFvE2/+tO8kQRqD91IfGMzELxIkQi4b/5GVVILRczLq6BzDzCk
         BhZocduHB9ZkpWvNLwtEuHLBCJfLLbvCFPYGd/8GXDSA1a2S4JYGfZVstA3pL9aJxqzx
         Y2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=uCtOpSLEyYITt1GhmlZoX1Tk1BoXGqoBQ38x+3SsId8=;
        b=NpiVcIB2tjzXEbiDarGW5TYJIkn8j8e4mfZ/I+xhq0JWAAQnenNMWGeePSdlTwiNyJ
         w7uKAfKOEEzrneKX6rIjKgpEE5hQljVp8efrZq4GcIlZzr1Fjcmq6o94yryABEw1xKP1
         R10tvindsN3cgjrG9HSYGds1BPffsGd7JBo9H83n38zrqag88DAzStLvvdpEqgiVQxEy
         XHlFv2lzS3aGqsaZ5cm725l0tY8hamFs7oRJlVduMynsf/q7QpsMtUCqwcjPwfSfiDd+
         0AllFp7+5nMh7FfmFqyft9DQxmE087w72+qlEWrgnvNxI/vt6DKmf2kRLv/i8bDTDEyw
         qQcQ==
X-Gm-Message-State: AJIora87JdYfWqmc4+ZdA6J8XA8O1l3wUT/7fZMUn9dI0KI31U4eetEg
        Efc6pPnU0D7i330CpkiFWXHMMA==
X-Google-Smtp-Source: AGRyM1sSYzkoI1RkUnZVaOYNyE4Zx/bks6NheYViyHpM6quQF66pbsx22U6oAt/CX2/mX6KXaHPYoQ==
X-Received: by 2002:adf:de0d:0:b0:21e:8f26:4719 with SMTP id b13-20020adfde0d000000b0021e8f264719mr12008233wrm.473.1659021139858;
        Thu, 28 Jul 2022 08:12:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5d20:dcaf:6a60:450c? ([2a05:6e02:1041:c10:5d20:dcaf:6a60:450c])
        by smtp.googlemail.com with ESMTPSA id g17-20020a5d4891000000b0021f0558e51asm1299748wrq.55.2022.07.28.08.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 08:12:19 -0700 (PDT)
Message-ID: <aa53e832-2744-8a67-1803-552187c9c570@linaro.org>
Date:   Thu, 28 Jul 2022 17:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 00/32] New thermal OF code
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Mark Brown <broonie@kernel.org>,
        damien.lemoal@opensource.wdc.com, Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        mhiramat@kernel.org, Talel Shenhar <talel@amazon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, anarsoul@gmail.com,
        Yangtao Li <tiny.windzz@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        glaroque@baylibre.com, Miquel Raynal <miquel.raynal@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Keerthy <j-keerthy@ti.com>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
 <35457e1c-fe6b-2212-9624-70369f04ef0d@linaro.org>
 <CAJZ5v0g5gtQGyLM2C+D5-Y-T_7+GHp4=Ptt7Reh6xgL-D77asQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0g5gtQGyLM2C+D5-Y-T_7+GHp4=Ptt7Reh6xgL-D77asQ@mail.gmail.com>
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


Hi Rafael,

On 28/07/2022 16:37, Rafael J. Wysocki wrote:
> Hi Daniel,
> 
> On Wed, Jul 27, 2022 at 11:46 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rafael,
>>
>> we are close to release v5.19.
>>
>> I want to send a PR this week but it would be nice if this series could
>> be part of it, so the trip point rework we discussed earlier (it is a
>> long series) could be merged more easily for v5.21-rc1 as it will depend
>> on these changes.
>>
>> This series was tested on different platforms, rk3399, broadcom and
>> rcar. The external drivers as ata, touchscreen, regulator, hwmon were
>> acked/reviewed and some other thermal drivers reviewed also. Some others
>> remain without feedback because the maintainer is unresponsive or the
>> driver is orphaned, falling under the thermal framework maintenance
>> umbrella. All the drivers changes are the same.
>>
>> I do believe it does a nice cleanup and consolidation of the OF thermal
>> code and realign it with the core thermal framework.
>>
>> Is it ok to merge the series?
> 
> I would prefer to put it into linux-next for a few days.
> 
> Why don't you send 2 pull requests, one with all of the other material
> you have for 5.20 and another one with this series (it may be on top
> of the first one)?
> 
> I will be able to defer pushing the second one till the second half of
> the merge window.

Yes, I agree, if it is fine to do two pull requests, it seems very 
reasonable to let this series to mature in linux-next.

I will setup the 'next' branch with the first pull request material.

Thanks

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
