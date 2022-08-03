Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B8C589125
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbiHCRTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237672AbiHCRTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:19:07 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDCF5465B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:19:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bv3so8432099wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4UY8py3X0/BN1P3gwjm+tuZ8tcpmzyPC+aOTBqJeSt8=;
        b=isXyHaMQW8qF2UKO6Lo9HB8KAV6BgkxuW6EUeqWLRPODlINo6vsuJneytGBi0CyXCF
         umBnZMHsxaM3bNv50RmrF3o69tHPjJYzxYTxhNm4uM8X4h7TGgzpvKbe39+zGv+Oz6np
         J82oD55Hycu2/T8xrB5VLcLU4a5GbYQ/HGs9t2kqoEDIYsPjWYaSSRbWJTGj/cTiIAHd
         HR+o7bPHEylf+y640X7UbsK61JM4ZvUEZUyWovtcvWh3GJwmkkWGD0UlCn7D3STtKvzm
         dZCFd8O+Hzrazi20lK3GNC2R82qQLaGFmvRHR3gIsdC35XvvUqavW64VFPr0cVjMO4dJ
         S77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4UY8py3X0/BN1P3gwjm+tuZ8tcpmzyPC+aOTBqJeSt8=;
        b=KyPBrDlnR9zktmLKBOmdP1sJFIOSsYuAIztb12FMnf3PV2wBowcPhMu5vDrgVYV8x/
         95IBUsAgY7af3NmlHHL5tAWH5PlnWZwRLbODU76uYVOgk9T2FAK3cL2EtRJtBniKfwNs
         d8+Q2KKuIo2H4k54SEShGTzJXxmD2Y6a+hhAUrjlg1mtmGLKYZbA+yPVpaHwC9s1hgrC
         bSc7mQ5qgfZ4v6IUoRJg+1qri3MzO81sLUBD2rG0v8dEOnjkZ4RoR//dVooyZcFYZliU
         eKI5bxibyb9FJhO0aPGEOuBi1UoVvuDU9Ww2H47BtkP52kCpEChRZonEJv7FZBXkRj2W
         DdPw==
X-Gm-Message-State: ACgBeo3QE80S+s7VN84kqBZOGz3QLDcXKp1x81p/tr8HghqC/hmBg4DT
        9g3b3cbKlXGtqrr90EhY8SW4KQ==
X-Google-Smtp-Source: AA6agR5Wv0gfa95g78ZnToqxbtcFp8H7zlGXCEu06c6mWg6qxteAX/Wj7uKUwhKAuRvMlmz+D4auQA==
X-Received: by 2002:a5d:6687:0:b0:21e:d501:1b03 with SMTP id l7-20020a5d6687000000b0021ed5011b03mr16643286wru.387.1659547144183;
        Wed, 03 Aug 2022 10:19:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6e48:fbdd:280d:6dac? ([2a05:6e02:1041:c10:6e48:fbdd:280d:6dac])
        by smtp.googlemail.com with ESMTPSA id g2-20020a5d64e2000000b0021b970a68f9sm2224839wri.26.2022.08.03.10.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:19:03 -0700 (PDT)
Message-ID: <1c129750-4ac0-e4aa-f3b1-80ca1d35e23c@linaro.org>
Date:   Wed, 3 Aug 2022 19:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] tools/thermal: Fix possible path truncations
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20220725173755.2993805-1-f.fainelli@gmail.com>
 <CAJZ5v0hL46vdr=f8YiAPnRmmehZs51n+tkgoY7PMTVyJD0cpEA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hL46vdr=f8YiAPnRmmehZs51n+tkgoY7PMTVyJD0cpEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2022 19:07, Rafael J. Wysocki wrote:
> On Mon, Jul 25, 2022 at 7:38 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> A build with -D_FORTIFY_SOURCE=2 enabled will produce the following warnings:
>>
>> sysfs.c:63:30: warning: '%s' directive output may be truncated writing up to 255 bytes into a region of size between 0 and 255 [-Wformat-truncation=]
>>    snprintf(filepath, 256, "%s/%s", path, filename);
>>                                ^~
>> Bump up the buffer to PATH_MAX which is the limit and account for all of
>> the possible NUL and separators that could lead to exceeding the
>> allocated buffer sizes.
>>
>> Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Daniel, are you going to pick up this one or should I?

Yes, you can pick it

> There is also a tmon patch from Florian that seems to be pending.
> Should I take care of it?

I'm not sure which patch you are referring but if it is the pthread 
compilation issue, it should be already applied for v5.20-rc1 from the 
thermal pull request

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/tools/thermal/tmon/tmon.h?id=c1dbe9a1c86da098a29dcdca1a67b65e2de7ec3a

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
