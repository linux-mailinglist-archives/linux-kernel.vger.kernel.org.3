Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EFA4F667F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbiDFRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238365AbiDFRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:08:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1C423B3FA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:44:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w4so3522342wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q7tTbUPj80zQFrsreVSfIyDmqBy9SR/9Gbp8AYxxfBQ=;
        b=QeNOqhK6B2CXR8G/hrFhDjbWjL1lx7JCOEk3CHVDMkgvFSBTGaM2Mg+fj2Nm1zo8Ey
         SyAtjm8ke72MI/W/IETggJqBL/Ht5+gD/vb8YoTbnxp2Ya8SVoV8oWklM0TgP2O88WO0
         NMEFNI2hUIDHZXrTXl5S5wRHohvOgI5C9/gVX8U4+ZSdqPusTi5A0UfVskscfSdKrhAf
         yAnVr3qSFXmJ67PzUiDzxftUEucttojSRWQZlUNG4AeyPHXDMNm4JXR1q2mMR/RiQaLQ
         fwSBn+nSCXH60hduajUDRB2MkMX7Cc1Q2OKgKLXITnp8LQf+Jp/+NjPd0LP472JUoVw7
         f/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q7tTbUPj80zQFrsreVSfIyDmqBy9SR/9Gbp8AYxxfBQ=;
        b=cBlHbDB/t28bMl9agUlm94cN4kspsH1jFVuEuwgen/LWQ7daqpNG7s6IgsppPziY3l
         nF5ZAeDRfDc7St15Q7CmmeRvzvK+ZyIEVI52vAhm5bOw/ZpLUaPxXV7mlhslDY9Cl8LJ
         6pupjbU8dqRj8FiYt4MQOyNdeU2j46hRnT7xpJHbPNViF+Yrk2jQVdlEUSGSuyhv5CKN
         F/n1xxVTpTr3kg5mYqlGxdDonRJI6YhGLyLZ12KPMjl9/asUJGCE4ncPpjEhiZvvS582
         3ghm+X/VAKFy8YZoL6inmmNxlpuG8AuZmV2CnVwNLEe0WCYXApp+JhyIlKsFdfGsev4b
         yanw==
X-Gm-Message-State: AOAM530sCpRB3gvMEW/ErG7CVNIlgA/v3HYhJqT65Jg0Q7+HB/E9jjiV
        hZRofXUH0/fdXmHFCZyxcCvMrQ==
X-Google-Smtp-Source: ABdhPJyX2H6+/xrddJqBK7sgjp1Of7OvV2pwupg2yuPXedmLBl5N4VGH82cdf/FI6si47PLAHHoKHw==
X-Received: by 2002:a05:6000:10cf:b0:206:1d1c:5480 with SMTP id b15-20020a05600010cf00b002061d1c5480mr7051977wrx.546.1649256249144;
        Wed, 06 Apr 2022 07:44:09 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:261f:c14c:d23b:d177? ([2a01:e34:ed2f:f020:261f:c14c:d23b:d177])
        by smtp.googlemail.com with ESMTPSA id l20-20020a05600c1d1400b0038cba2f88c0sm7191217wms.26.2022.04.06.07.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 07:44:07 -0700 (PDT)
Message-ID: <9ccb342b-2f20-6efd-a668-96d593aa921e@linaro.org>
Date:   Wed, 6 Apr 2022 16:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/4] tools/thermal: thermal library and tools
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
 <f526d227-ffbb-4ac0-ceb6-c793ab912559@linaro.org>
 <5380fef6d45f2f7a0b8a5f681934f02943d5e138.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5380fef6d45f2f7a0b8a5f681934f02943d5e138.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 16:28, srinivas pandruvada wrote:
> Hi Daniel,
> 
> On Wed, 2022-04-06 at 10:00 +0200, Daniel Lezcano wrote:
>>
>> Hi,
>>
>> if there is no comment for the series, shall I pick it so we can go
>> forward ?
> Didn't get time to check yet. It will still be for the next merge
> window, correct?

Right, but I would like to continue adding more features, scripts and 
tests. Iteratively.

>>
>> On 30/03/2022 12:04, Daniel Lezcano wrote:
>>> These changes are providing the following tools and library:
>>>
>>>    - A thermal library doing the netlink abstraction from the kernel
>>> in
>>>      order to make the userspace thermal implementation easier.
>>> Having
>>>      the library integrated with the kernel tree is also a guarantee
>>> to
>>>      keep the message format and their encoding/decoding aligned
>>>                                                                     
>>>                                                                     
>>>                                                                     
>>>                                                                     
>>>     
>>>    - A thermal tools library providing a set of functions to deal
>>> with
>>>      usual features like the log, the mainloop and the time. This
>>>      library is used by the provided tools below
>>>
>>>    - An data acquisition program to capture the temperature of the
>>>      different thermal zone during an amount of time or during the
>>>      execution of an application. The output is formated to be
>>> easily
>>>      parsed by gnuplot, a spreadsheet program or a statistical
>>> command
>>>      line utility. The timestamp is based on the system uptime, thus
>>>      giving an indication of when a thermal event happened, that can
>>>      help to spot or reproduce thermal issue in the long run
>>>
>>>    - A thermal monitoring program based on the thermal library. It
>>> gives
>>>      a skeleton to build any logic on top of it and shows how to use
>>> the
>>>      thermal library. It does nothing except discovering the thermal
>>>      zones, their trip points and listening for events like cooling
>>>      devices state changes or trip point crossed
>>>
>>>    Changelog:
>>>
>>>    v1: Initial post after a RFC
>>>
>>>    v2:
>>>
>>>     - Fixed all trailing whitespaces and some other checkpatch
>>>       warnings. Some warnings remain but they can be considered as
>>> false
>>>       positive
>>>
>>>     - Added in the thermometer tool:
>>>       - Usage/help option as well as a man page
>>>       - The ability to execute a program
>>>       - The capture duration
>>>       - Create the output directory if it does not exist
>>>
>>>     - Add in the thermal-engine tool:
>>>       - A usage/help option
>>>       - A message telling the userspace it is waiting for events
>>>       - A daemonize option
>>>
>>>     - Minor bug fixes here and there, as well as typos
>>>
>>> Daniel Lezcano (4):
>>>     tools/lib/thermal: Add a thermal library
>>>     tools/thermal: Add util library
>>>     tools/thermal: A temperature capture tool
>>>     tools/thermal: Add thermal daemon skeleton
>>>
>>>    MAINTAINERS                                   |   1 +
>>>    tools/Makefile                                |  36 +-
>>>    tools/lib/thermal/.gitignore                  |   2 +
>>>    tools/lib/thermal/Build                       |   5 +
>>>    tools/lib/thermal/Makefile                    | 165 ++++++
>>>    tools/lib/thermal/commands.c                  | 349 +++++++++++
>>>    tools/lib/thermal/events.c                    | 164 +++++
>>>    tools/lib/thermal/include/thermal.h           | 142 +++++
>>>    tools/lib/thermal/libthermal.map              |  25 +
>>>    tools/lib/thermal/libthermal.pc.template      |  12 +
>>>    tools/lib/thermal/sampling.c                  |  75 +++
>>>    tools/lib/thermal/thermal.c                   | 126 ++++
>>>    tools/lib/thermal/thermal_nl.c                | 215 +++++++
>>>    tools/lib/thermal/thermal_nl.h                |  46 ++
>>>    tools/thermal/lib/Build                       |   3 +
>>>    tools/thermal/lib/Makefile                    | 158 +++++
>>>    .../thermal/lib/libthermal_tools.pc.template  |  12 +
>>>    tools/thermal/lib/log.c                       |  77 +++
>>>    tools/thermal/lib/log.h                       |  31 +
>>>    tools/thermal/lib/mainloop.c                  | 120 ++++
>>>    tools/thermal/lib/mainloop.h                  |  15 +
>>>    tools/thermal/lib/thermal-tools.h             |  10 +
>>>    tools/thermal/lib/uptimeofday.c               |  40 ++
>>>    tools/thermal/lib/uptimeofday.h               |  12 +
>>>    tools/thermal/thermal-engine/Build            |   2 +
>>>    tools/thermal/thermal-engine/Makefile         |  28 +
>>>    tools/thermal/thermal-engine/thermal-engine.c | 326 ++++++++++
>>>    tools/thermal/thermometer/Build               |   2 +
>>>    tools/thermal/thermometer/Makefile            |  26 +
>>>    tools/thermal/thermometer/thermometer.8       |  93 +++
>>>    tools/thermal/thermometer/thermometer.c       | 558
>>> ++++++++++++++++++
>>>    tools/thermal/thermometer/thermometer.conf    |   5 +
>>>    32 files changed, 2878 insertions(+), 3 deletions(-)
>>>    create mode 100644 tools/lib/thermal/.gitignore
>>>    create mode 100644 tools/lib/thermal/Build
>>>    create mode 100644 tools/lib/thermal/Makefile
>>>    create mode 100644 tools/lib/thermal/commands.c
>>>    create mode 100644 tools/lib/thermal/events.c
>>>    create mode 100644 tools/lib/thermal/include/thermal.h
>>>    create mode 100644 tools/lib/thermal/libthermal.map
>>>    create mode 100644 tools/lib/thermal/libthermal.pc.template
>>>    create mode 100644 tools/lib/thermal/sampling.c
>>>    create mode 100644 tools/lib/thermal/thermal.c
>>>    create mode 100644 tools/lib/thermal/thermal_nl.c
>>>    create mode 100644 tools/lib/thermal/thermal_nl.h
>>>    create mode 100644 tools/thermal/lib/Build
>>>    create mode 100644 tools/thermal/lib/Makefile
>>>    create mode 100644 tools/thermal/lib/libthermal_tools.pc.template
>>>    create mode 100644 tools/thermal/lib/log.c
>>>    create mode 100644 tools/thermal/lib/log.h
>>>    create mode 100644 tools/thermal/lib/mainloop.c
>>>    create mode 100644 tools/thermal/lib/mainloop.h
>>>    create mode 100644 tools/thermal/lib/thermal-tools.h
>>>    create mode 100644 tools/thermal/lib/uptimeofday.c
>>>    create mode 100644 tools/thermal/lib/uptimeofday.h
>>>    create mode 100644 tools/thermal/thermal-engine/Build
>>>    create mode 100644 tools/thermal/thermal-engine/Makefile
>>>    create mode 100644 tools/thermal/thermal-engine/thermal-engine.c
>>>    create mode 100644 tools/thermal/thermometer/Build
>>>    create mode 100644 tools/thermal/thermometer/Makefile
>>>    create mode 100644 tools/thermal/thermometer/thermometer.8
>>>    create mode 100644 tools/thermal/thermometer/thermometer.c
>>>    create mode 100644 tools/thermal/thermometer/thermometer.conf
>>>
>>
>>
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
