Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FEC4F5DC4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiDFMW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiDFMWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:22:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8721BF94E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:00:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r64so905453wmr.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 01:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3CWJoajGROo+VFwvzgEegMB4GcuwlyDmSWZ5URHb0Ag=;
        b=DqaqMNzJzj1mGrjxPhOo5IyJ8mFICRglbcOdQKfbcWuajDLjyQlsSDp+4G8kEBwgyJ
         YOpqOPu34bnaloDtL8hXfp5i600OfbwBLcVQFXgtL55xHomu3+w2EVdjdpGRQmRFZJRX
         3HX5KQJkwZueF2Mm8pfnFesaW6dViwDrqBvoAhUA+hJsWhDme5QCg3QBQiHk+qVS+DqP
         kBsJAeyqVbNgyu20RnI2cR7XUue/EZWEhEKDTgrQWmeIGX2o316C9Nfv3hy9Jxt+tCF2
         xArQUtKOpIWx2/risIDqDAPfHWH/WcW/0Sti3YNUBq/bBpaHy1N24WuFSYGxP2hbDsif
         TYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3CWJoajGROo+VFwvzgEegMB4GcuwlyDmSWZ5URHb0Ag=;
        b=KoCI2P5LQ7stWdHxThX/yQnybQsG+tfdqa+NwiOmtaHXVdC17q00ziLrzE5RiI2sQc
         F0eTITkI/GnR6FjaRVI8lwvSVINQl8LpI5N1c33tQxSOUAU5w3IwL93q+2ucpwwBSPPz
         gfbKya4O76TmnU8/4tENaabBrNRROzJXFcmZvA/Jo7oyqCZMOuEO9rlUFTX1SVnO5uU8
         KzFIgm53+1pUdN1x/yadJVisASPhdN7XXzSE6FJCWxClVWM4hKeG3viYYHLb37psVyOf
         Tm/368niFcb6/BipFMI/QnYe/UP64TBGxufkmUkb/cASfiaZS5Bxf+ka2JjPS5J4aIMg
         fZ5A==
X-Gm-Message-State: AOAM533X8yU6TtCizi+AVQVOMLi3uj5/+1Gpto0b0hIse0fuyfb70u5u
        9FWRjClP2rilP7xjnswsAVqMzw==
X-Google-Smtp-Source: ABdhPJyUHJds9tzNi/hUOJ3tIpyNPFbPf3UWyJ4l7kTkS8TsUGjYX+gKXMHFqOUmfPmZD9+g9z89QQ==
X-Received: by 2002:a7b:c844:0:b0:38e:7c92:a9e3 with SMTP id c4-20020a7bc844000000b0038e7c92a9e3mr6245631wml.140.1649232027233;
        Wed, 06 Apr 2022 01:00:27 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:261f:c14c:d23b:d177? ([2a01:e34:ed2f:f020:261f:c14c:d23b:d177])
        by smtp.googlemail.com with ESMTPSA id x17-20020a5d4451000000b002061a0a9a13sm4851747wrr.1.2022.04.06.01.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:00:25 -0700 (PDT)
Message-ID: <f526d227-ffbb-4ac0-ceb6-c793ab912559@linaro.org>
Date:   Wed, 6 Apr 2022 10:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/4] tools/thermal: thermal library and tools
Content-Language: en-US
To:     rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
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


Hi,

if there is no comment for the series, shall I pick it so we can go 
forward ?



On 30/03/2022 12:04, Daniel Lezcano wrote:
> These changes are providing the following tools and library:
> 
>   - A thermal library doing the netlink abstraction from the kernel in
>     order to make the userspace thermal implementation easier. Having
>     the library integrated with the kernel tree is also a guarantee to
>     keep the message format and their encoding/decoding aligned
>                                                                                                                                                                                                                                                                                 
>   - A thermal tools library providing a set of functions to deal with
>     usual features like the log, the mainloop and the time. This
>     library is used by the provided tools below
> 
>   - An data acquisition program to capture the temperature of the
>     different thermal zone during an amount of time or during the
>     execution of an application. The output is formated to be easily
>     parsed by gnuplot, a spreadsheet program or a statistical command
>     line utility. The timestamp is based on the system uptime, thus
>     giving an indication of when a thermal event happened, that can
>     help to spot or reproduce thermal issue in the long run
> 
>   - A thermal monitoring program based on the thermal library. It gives
>     a skeleton to build any logic on top of it and shows how to use the
>     thermal library. It does nothing except discovering the thermal
>     zones, their trip points and listening for events like cooling
>     devices state changes or trip point crossed
> 
>   Changelog:
> 
>   v1: Initial post after a RFC
> 
>   v2:
> 
>    - Fixed all trailing whitespaces and some other checkpatch
>      warnings. Some warnings remain but they can be considered as false
>      positive
> 
>    - Added in the thermometer tool:
>      - Usage/help option as well as a man page
>      - The ability to execute a program
>      - The capture duration
>      - Create the output directory if it does not exist
> 
>    - Add in the thermal-engine tool:
>      - A usage/help option
>      - A message telling the userspace it is waiting for events
>      - A daemonize option
> 
>    - Minor bug fixes here and there, as well as typos
> 
> Daniel Lezcano (4):
>    tools/lib/thermal: Add a thermal library
>    tools/thermal: Add util library
>    tools/thermal: A temperature capture tool
>    tools/thermal: Add thermal daemon skeleton
> 
>   MAINTAINERS                                   |   1 +
>   tools/Makefile                                |  36 +-
>   tools/lib/thermal/.gitignore                  |   2 +
>   tools/lib/thermal/Build                       |   5 +
>   tools/lib/thermal/Makefile                    | 165 ++++++
>   tools/lib/thermal/commands.c                  | 349 +++++++++++
>   tools/lib/thermal/events.c                    | 164 +++++
>   tools/lib/thermal/include/thermal.h           | 142 +++++
>   tools/lib/thermal/libthermal.map              |  25 +
>   tools/lib/thermal/libthermal.pc.template      |  12 +
>   tools/lib/thermal/sampling.c                  |  75 +++
>   tools/lib/thermal/thermal.c                   | 126 ++++
>   tools/lib/thermal/thermal_nl.c                | 215 +++++++
>   tools/lib/thermal/thermal_nl.h                |  46 ++
>   tools/thermal/lib/Build                       |   3 +
>   tools/thermal/lib/Makefile                    | 158 +++++
>   .../thermal/lib/libthermal_tools.pc.template  |  12 +
>   tools/thermal/lib/log.c                       |  77 +++
>   tools/thermal/lib/log.h                       |  31 +
>   tools/thermal/lib/mainloop.c                  | 120 ++++
>   tools/thermal/lib/mainloop.h                  |  15 +
>   tools/thermal/lib/thermal-tools.h             |  10 +
>   tools/thermal/lib/uptimeofday.c               |  40 ++
>   tools/thermal/lib/uptimeofday.h               |  12 +
>   tools/thermal/thermal-engine/Build            |   2 +
>   tools/thermal/thermal-engine/Makefile         |  28 +
>   tools/thermal/thermal-engine/thermal-engine.c | 326 ++++++++++
>   tools/thermal/thermometer/Build               |   2 +
>   tools/thermal/thermometer/Makefile            |  26 +
>   tools/thermal/thermometer/thermometer.8       |  93 +++
>   tools/thermal/thermometer/thermometer.c       | 558 ++++++++++++++++++
>   tools/thermal/thermometer/thermometer.conf    |   5 +
>   32 files changed, 2878 insertions(+), 3 deletions(-)
>   create mode 100644 tools/lib/thermal/.gitignore
>   create mode 100644 tools/lib/thermal/Build
>   create mode 100644 tools/lib/thermal/Makefile
>   create mode 100644 tools/lib/thermal/commands.c
>   create mode 100644 tools/lib/thermal/events.c
>   create mode 100644 tools/lib/thermal/include/thermal.h
>   create mode 100644 tools/lib/thermal/libthermal.map
>   create mode 100644 tools/lib/thermal/libthermal.pc.template
>   create mode 100644 tools/lib/thermal/sampling.c
>   create mode 100644 tools/lib/thermal/thermal.c
>   create mode 100644 tools/lib/thermal/thermal_nl.c
>   create mode 100644 tools/lib/thermal/thermal_nl.h
>   create mode 100644 tools/thermal/lib/Build
>   create mode 100644 tools/thermal/lib/Makefile
>   create mode 100644 tools/thermal/lib/libthermal_tools.pc.template
>   create mode 100644 tools/thermal/lib/log.c
>   create mode 100644 tools/thermal/lib/log.h
>   create mode 100644 tools/thermal/lib/mainloop.c
>   create mode 100644 tools/thermal/lib/mainloop.h
>   create mode 100644 tools/thermal/lib/thermal-tools.h
>   create mode 100644 tools/thermal/lib/uptimeofday.c
>   create mode 100644 tools/thermal/lib/uptimeofday.h
>   create mode 100644 tools/thermal/thermal-engine/Build
>   create mode 100644 tools/thermal/thermal-engine/Makefile
>   create mode 100644 tools/thermal/thermal-engine/thermal-engine.c
>   create mode 100644 tools/thermal/thermometer/Build
>   create mode 100644 tools/thermal/thermometer/Makefile
>   create mode 100644 tools/thermal/thermometer/thermometer.8
>   create mode 100644 tools/thermal/thermometer/thermometer.c
>   create mode 100644 tools/thermal/thermometer/thermometer.conf
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
