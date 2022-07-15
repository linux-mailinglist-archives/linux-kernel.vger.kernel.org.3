Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F765576A00
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiGOWj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiGOWjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:39:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0F123BFA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:39:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r2so7547241wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HKeRLYmaiyT0QsZN/+8k9YJ8hsv5aCHl1ye2RpuX0Rs=;
        b=WLbZVQbcn/Z4IL593ZAkHola/vlG7OV8nJTCeQDosjrQiYP5vBdw2mbpaRyDYQOl2G
         qP2r0VjAI1VaQvJVYWNf/wI4qNcFiW+TiKgDwwVbwRZK56/4PCQGEnghWwUOlEQnSMlh
         JHURe6dV4E87xo/4pTASuObsH5g5D1Fb2WJT1nTkZaew6OWwsjosDirUPdVZWuwTu70z
         5NiID/1AfjSp6CYcJXhgj+OZC+ZHBJoOpZ4vcq+Xz0j0bQ6ymvPko2KOapw3F0HINg27
         U/f/jmMkrFcwp8aGefLwhXQQMt7cLuApqUpWNB0qrBDtkRQ2m5k1+GeFS+ixGA4Bi53v
         YY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HKeRLYmaiyT0QsZN/+8k9YJ8hsv5aCHl1ye2RpuX0Rs=;
        b=6Wp3qQuQTk5vioqXjWkK8eRJexIHcS1mTdBxW5OWhX+5m7Z1vA8P6OL8r2XiIou6W0
         0UK+69wnOmMbDQikiOwFnBdTF1alrVwXUgF7uUGR1BZ6FzUTPhVT8NfUJ7dLdKd1Q6jx
         YrjCkBhqaR4OII+0j7uuCiJqM6QZaTH8E0vk9hszPxfxaaR6FsPTHKXu5/W6I1Kib13N
         ss1edq+EdP9csOWPpF1UAV4h0VgoVdJaLCbwqP3BatjEk93HCuQuq6d7VmxMgUkpfHGc
         axbW2zvEq47UGuOHmGrjB3GxBD6shK7cZCtuk++/5b6Icok2fK3YcHaE5MjfmviRoVkn
         M1Hw==
X-Gm-Message-State: AJIora9tBaxgrN3yQYYUF5MFRIQJlOfDlkN5L2/Pf8L5kTt3xkhJnzvd
        HUNXJI+HK6XQ0pgPzUmc6q5QAQ==
X-Google-Smtp-Source: AGRyM1vXQ8gvwtOOnPJdbUDyuoLyV70NJeblMrk1sKt5gbV6jwaZRFs4/gJY+FxUqi5uTp52DedCRw==
X-Received: by 2002:a5d:5847:0:b0:21d:b75e:12d0 with SMTP id i7-20020a5d5847000000b0021db75e12d0mr13850978wrf.208.1657924760237;
        Fri, 15 Jul 2022 15:39:20 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a223:f4b3:40c9:43fa? ([2a05:6e02:1041:c10:a223:f4b3:40c9:43fa])
        by smtp.googlemail.com with ESMTPSA id n15-20020a05600c3b8f00b003a3080eacb9sm5525243wms.24.2022.07.15.15.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 15:39:19 -0700 (PDT)
Message-ID: <c22f08d9-d55a-70e2-3413-b6cc279f6166@linaro.org>
Date:   Sat, 16 Jul 2022 00:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/6] clocksource: Add Tegra186 timers support
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Kartik <kkartik@nvidia.com>, tglx@linutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, spujar@nvidia.com, mperttunen@nvidia.com,
        rgumasta@nvidia.com, amhetre@nvidia.com, akhilrajeev@nvidia.com,
        pshete@nvidia.com, vidyas@nvidia.com, sumitg@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
 <1656922422-25823-3-git-send-email-kkartik@nvidia.com>
 <YshDgwTIUKanczPJ@orome>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <YshDgwTIUKanczPJ@orome>
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

On 08/07/2022 16:47, Thierry Reding wrote:
> On Mon, Jul 04, 2022 at 01:43:38PM +0530, Kartik wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> Currently this only supports a single watchdog, which uses a timer in
>> the background for countdown. Eventually the timers could be used for
>> various time-keeping tasks, but by default the architected timer will
>> already provide that functionality.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> Signed-off-by: Kartik <kkartik@nvidia.com>
>> ---
>>   drivers/clocksource/Kconfig          |   8 +
>>   drivers/clocksource/Makefile         |   1 +
>>   drivers/clocksource/timer-tegra186.c | 508 +++++++++++++++++++++++++++
>>   3 files changed, 517 insertions(+)
>>   create mode 100644 drivers/clocksource/timer-tegra186.c
> 
> Daniel, any more work needed on this? Looks good to me, so:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> I've picked up patches 1 and 4-6 into the Tegra tree, so you only need
> to take patches 2 and 3.

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
