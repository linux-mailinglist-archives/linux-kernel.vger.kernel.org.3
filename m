Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39AD589111
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiHCROX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiHCROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:14:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0966552FE3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:14:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p10so18124908wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=GUtktyRkXIhS+Fz7PPmZmEHdzJqtBsKjE1UhF4HSDMo=;
        b=hgURM5ANxcvq1WQMcHsEFrKc4g+wG97zSAqfnwBblL3ajda7Es9x+8sBzkuDU52XUm
         EUqhtzZNWYFzJzAgxjM15fqdeIybTL0lvpKoWK9e2lTFNC/KfjYJY04zznzuuKdt66iD
         ZRy1T+eqNlsZVTZQFUtLmK8GZAXV7qH5itA3HPzClVL+tGOhvWX7KzJj9rGlVYS/NqTR
         WYfjkgjREasgWqrvTY/hVSMONzXDc6qUnlFFoe/IwD1HZgifZgXMhtBaPkz7VpG2jUav
         eK4L+Ki4uqVT6GCPgitAAHVtDaUFtpFKMPGTows4TQTFLvXZE/XCVX67duIp15OuLV1Y
         NEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GUtktyRkXIhS+Fz7PPmZmEHdzJqtBsKjE1UhF4HSDMo=;
        b=q7043pXWSLmQP8dUoc1x0TPEBDGSTfB3OH7CIsspVBZKgmIFB4rmZHNz6I0FDyq9Ck
         CFd3wLm4Vg5S+qofgSmMvFQENLt2+kiyT9Vs+4M1/xnFhUd6AAIVu9rsRLMinOw+9n0D
         YOlloI1Mzk+okR/NWooEOGMteBOdXKXd6JPM5nNMK/4Rt96mMuxDJwQa/opeI8iZkNXX
         Li7YXeag0g7G3ulv5moyQM0lamBfpuM08InohlBF1AgkqPdMFqEihqiR/xmozz8kU/1/
         v27xFjrFBtz2WEhA1i6R5OOtKO3NcFJJUb6unjGWFBHIBtpWJNJSXveutrpo97zZHu/4
         LwVA==
X-Gm-Message-State: ACgBeo19ZalcZsXP2mS1bCiEBNm8MDyAfr2v29t5TdUV4fgp5v2A3fM2
        mRDWEc/7pAoufxLJIb0MaxRQzA==
X-Google-Smtp-Source: AA6agR5wBU/h1VzY7Of86k5Vjs0Yjyf4+h43iAnWFK5iP7bOZIUoXZkeuCrQwsHl+8vX59zAdlFSXg==
X-Received: by 2002:a5d:6b10:0:b0:21e:4bbd:e893 with SMTP id v16-20020a5d6b10000000b0021e4bbde893mr16903170wrw.613.1659546857496;
        Wed, 03 Aug 2022 10:14:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6e48:fbdd:280d:6dac? ([2a05:6e02:1041:c10:6e48:fbdd:280d:6dac])
        by smtp.googlemail.com with ESMTPSA id r4-20020a05600c158400b0039c96b97359sm2780146wmf.37.2022.08.03.10.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:14:17 -0700 (PDT)
Message-ID: <9110a859-9885-1dab-0412-e8f62cfff458@linaro.org>
Date:   Wed, 3 Aug 2022 19:14:16 +0200
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> 
> There is also a tmon patch from Florian that seems to be pending.
> Should I take care of it?

Mmh, let me check. I thought I picked them :/

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
