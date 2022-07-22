Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8B257E777
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiGVTeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiGVTem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:34:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD997AB28
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:34:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n12so7796357wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hH95XjXDX7HfOaSlIRmgwv/BqeTgRb6XTDE5kgrObnw=;
        b=Y8kB1Cm6Ke5WUBLa2g5aeGLuqzWiz6e83CNVVFUNCaPFbl+6aviz0oAIgpcLgWeOhy
         8AU1egNqYttU1lL2dKfSgzutc0j+z3ioqjaDVks7OJS2alo52xnMwjeS+IpIWdVdcIhC
         Dw9RKhkBZBQZA+PF7D1CxXNC03o3HSsx8+ROsSlrH54kmv27qMC/+CofeRS3IoFNMgfP
         /nKdIoelZyposoh9WDt1Z3E5Fh6GcMo7bTiBnL3U6jSpaln49HOvCnq9isFeYc60Zkr4
         Npa5rEUcKkDb89O8uxo3m4HyaiYSKVIFs/p64TC1MHDan7molZifCYIep1kJu1FWSvmw
         h1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hH95XjXDX7HfOaSlIRmgwv/BqeTgRb6XTDE5kgrObnw=;
        b=VIEPWe5+dHYRcus+huFc8UUWorT+ZItB7PbOVwlPXrwMNXxFVxOcZJjw5Rg7ulNum/
         sxclcThga8PlTEpuV2is6dxaBF3gQ/VqQXdwCDm2MxaAHLdzqhwH86myeZGIZP6lEWPr
         WCmt+s3UloLdF8F/6+PVvr7m6RQLhoLXM5RVMvlAE5UY5daVzYMeo39J30uxNPi0Eej4
         bG0Z/i5DYq2YxmDIHdzS5V108QaD+NJPhgK+JFsD+mhc5AmfULUqKTyHl03hoideV/XQ
         OWMIIVNVIBd/qD1YG6DP5/B92TF/RwIFjq8ejCMLdEkS0yOnWE28AY3D5P7uEoEEpHw/
         9J7Q==
X-Gm-Message-State: AJIora9PUOoVhUox5UcimSi6z8QwrY2+Dn+IDfrr7qFyE7+P68D2zMYm
        bZATPLNWJxoxhDR/1zidkC4UYQ==
X-Google-Smtp-Source: AGRyM1sqYvtOfD5ZxusSG6eF2G7NJ/wP0OsL7fzH4mLrjxzusTUieovR6ixH239LoIGCoCpWBeA7+g==
X-Received: by 2002:a05:6000:100d:b0:21e:69b3:1901 with SMTP id a13-20020a056000100d00b0021e69b31901mr892749wrx.622.1658518479213;
        Fri, 22 Jul 2022 12:34:39 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:957f:d36d:87f9:5c17? ([2a05:6e02:1041:c10:957f:d36d:87f9:5c17])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003a31b00c216sm6380839wms.0.2022.07.22.12.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 12:34:38 -0700 (PDT)
Message-ID: <f5bd819d-2292-c247-5141-1dec8bd657f8@linexp.org>
Date:   Fri, 22 Jul 2022 21:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 17/33] thermal/drivers/rcar: Switch to new of API
Content-Language: en-US
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        khilman@baylibre.com, abailon@baylibre.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-18-daniel.lezcano@linexp.org>
 <YtZ1IExNlsYaJkC9@oden.dyn.berto.se>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <YtZ1IExNlsYaJkC9@oden.dyn.berto.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Niklas,

On 19/07/2022 11:10, Niklas Söderlund wrote:
> Hi Daniel,
> 
> Thanks for your work.
> 
> On 2022-07-10 23:24:07 +0200, Daniel Lezcano wrote:
>> The thermal OF code has a new API allowing to migrate the OF
>> initialization to a simpler approach.
>>
>> Use this new API.
> 
> I tested this together with the series it depends on and while
> temperature monitoring seems to work fine it breaks the emul_temp
> interface (/sys/class/thermal/thermal_zone2/emul_temp).
> 
> Before this change I can write a temperature to this file and have it
> trigger actions, in my test-case changing the cooling state, which I
> observe in /sys/class/thermal/cooling_device0/cur_state.
> 
> Likewise before this change I could trip the critical trip-point that
> would power off the board using the emul_temp interface, this too no
> longer works,
> 
>      echo 120000 > /sys/class/thermal/thermal_zone2/emul_temp
> 
> Is this an intention change of the new API?

Absolutely not :)

Thanks for taking the time to test and report back the issue. I'll 
investigate that.

   -- D.
