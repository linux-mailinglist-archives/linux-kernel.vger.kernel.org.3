Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21EE4D31FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiCIPnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiCIPnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:43:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E223F302
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:42:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u1so3654839wrg.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 07:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3vcE2BzC19U1bToG3IklyZnpOHB0d1uOJ1vYdf0dl7s=;
        b=M30F//gh49Flp6dEF31vRuWH1nH7zZdW/BSekGIDTpq2RJ2tpE7MDn+2/W/M1A7z84
         EgazRXcOgBBzTwrUmrvtcy6BTd0vcPALha1VBEQebpFo/5Xp3K2hRsX3CvAdrxiR6juy
         5gONkBihN57OScJYIiFx2i983dlUBPLJhKBqdIHnowvAcwuVXFCiiFaEi4MwdXghnDE1
         aWt240Vzp7G8pJJNTAMc5qTeI8UQpbT4ub53O25WvEZ/FAV4/ith8YlkrGK/YKsUUvn+
         RnpAbKoIAzqInUTqw8PGCI9GIS6YmApl+oHpVD2hCtH72jsDWSDjBIV0gu2odLsB/h+Y
         4vnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3vcE2BzC19U1bToG3IklyZnpOHB0d1uOJ1vYdf0dl7s=;
        b=AaSLe8RUjbbf9wmoei2V4vaxqOEAZIwOIZOytZVfdNni6M+wAV8YauygjSx4vTyt+B
         mkHNllv33kqKGBfzhiVqYVJuBLSGJPQLNE+bLlrUjff1rrVt08z6M2hEJSk+/2eGO6op
         gBqspbkYHicOwfAOs9UNkRQ4KKhz/oiqrb7vrOzCd0eyAE3nNQyaIlyaLBQ7mGBWCXfg
         wXo+fd9Ko59hJgDgb4MIWKFf7Vcsql/QdUz+lcr94TRTIvn8nWwDXT7br/W2VBJaIlrX
         0QPXEj2QGufqvBpNL2bQ7/In+HlMv/LkIGud+cWwINlJ/8r3KyeRTPwNj9HZfGnih5BM
         J5wA==
X-Gm-Message-State: AOAM532EPKZ9idoJKiJIOEkdzYD3iYQSSwq9DgwJaK9IkHlFElzbAKuI
        8s48WVDOhVkS8FNURbPLovDUdQ==
X-Google-Smtp-Source: ABdhPJw0ARLjLGciQKHKuoKW+S+Bhbrp6JrE6vOwrJuf9vxXeUdEXebJOntUcrVXov0tEG27/g2fCQ==
X-Received: by 2002:adf:e348:0:b0:1f0:537:1807 with SMTP id n8-20020adfe348000000b001f005371807mr176822wrj.11.1646840564014;
        Wed, 09 Mar 2022 07:42:44 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:1ffc:39b4:7538:de29? ([2a01:e34:ed2f:f020:1ffc:39b4:7538:de29])
        by smtp.googlemail.com with ESMTPSA id n4-20020a05600c4f8400b00380e45cd564sm2257267wmq.8.2022.03.09.07.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 07:42:43 -0800 (PST)
Message-ID: <949c4b4f-1741-6c5f-c23c-d619b02b40ee@linaro.org>
Date:   Wed, 9 Mar 2022 16:42:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 0/4] Thermal library and tools
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220218125334.995447-1-daniel.lezcano@linaro.org>
 <3a3320d1-c4a8-d5e0-63ef-dd098711f38e@linaro.org>
 <bcfcf159c62a2a071a7bc7020f811fd9383af6de.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <bcfcf159c62a2a071a7bc7020f811fd9383af6de.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Srinivas,

thanks for your feedbacks, I'll fix that.

   -- Daniel


On 28/02/2022 18:13, srinivas pandruvada wrote:
> Hi Daniel,
> On Thu, 2022-02-24 at 22:41 +0100, Daniel Lezcano wrote:
>>
>> Hi,
>>
>> What shall I do with this series? Is everyone ok with it?
>>
> Some comments
> 1. White space errors while applying
> $git am ../daniel/\[PATCH\ v1\ 1_4\]\ tools_lib_thermal_\ Add\ a\
> thermal\ library.mbox
> Applying: tools/lib/thermal: Add a thermal library
> .git/rebase-apply/patch:234: trailing whitespace.
> clean:
> .git/rebase-apply/patch:715: trailing whitespace.
> 				
> nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TEMP]), arg);
> .git/rebase-apply/patch:878: trailing whitespace.
> 	
> .git/rebase-apply/patch:879: trailing whitespace.
> struct thermal_handler;
> .git/rebase-apply/patch:1103: trailing whitespace.
> }	
> warning: squelched 5 whitespace errors
> warning: 10 lines add whitespace errors.
> 
> $git am ../daniel/\[PATCH\ v1\ 2_4\]\ tools_thermal_\ Add\ util\
> library.mbox
> Applying: tools/thermal: Add util library
> .git/rebase-apply/patch:152: trailing whitespace.
> clean:
> .git/rebase-apply/patch:259: trailing whitespace.
> 	
> .git/rebase-apply/patch:285: trailing whitespace.
> 	
> .git/rebase-apply/patch:385: trailing whitespace.
> 		
> .git/rebase-apply/patch:392: trailing whitespace.
> 		/*
> warning: squelched 1 whitespace error
> warning: 6 lines add whitespace errors.
> $git am ../daniel/\[PATCH\ v1\ 3_4\]\ tools_thermal_\ A\ temperature\
> capture\ tool.mbox
> Applying: tools/thermal: A temperature capture tool
> .git/rebase-apply/patch:165: trailing whitespace.
> 	regex_t regex;	
> .git/rebase-apply/patch:205: trailing whitespace.
> 	
> .git/rebase-apply/patch:208: trailing whitespace.
> 	
> .git/rebase-apply/patch:249: trailing whitespace.
> 		
> .git/rebase-apply/patch:265: trailing whitespace.
> 	
> warning: squelched 13 whitespace errors
> warning: 18 lines add whitespace errors.
> 
> $ git am ../daniel/\[PATCH\ v1\ 4_4\]\ tools_thermal_\ Add\ thermal\
> daemon\ skeleton.mbox
> Applying: tools/thermal: Add thermal daemon skeleton
> .git/rebase-apply/patch:170: trailing whitespace.
> }		
> .git/rebase-apply/patch:186: trailing whitespace.
> 	
> .git/rebase-apply/patch:197: trailing whitespace.
> 	
> .git/rebase-apply/patch:199: trailing whitespace.
> 	
> .git/rebase-apply/patch:348: trailing whitespace.
> 	
> warning: squelched 3 whitespace errors
> warning: 8 lines add whitespace errors.
> 
> 
> 2. No help or man page
> thermal_engine has some options. There is no --help or man
> 
> 3. Silent failure
> 
> For example:
> $sudo ./thermal-engine
> 
> 4.
> sudo ./thermometer
> Options;
>   * config: 'thermometer.conf'
>   * log level: '7'
>   * postfix: -2022-02-28_16:51:33
>   * output: .
> 
> What an user can do?
> 
> Thanks,
> Srinivas
>   
>>
>>
>> On 18/02/2022 13:53, Daniel Lezcano wrote:
>>> This series provides a thermal library providing the basic callback
>>> oriented
>>> netlink communication and events with the thermal framework, a
>>> temperature
>>> capture tool and a thermal monitoring skeleton using the thermal
>>> library.
>>>
>>> Changelog:
>>>    - V1:
>>>       - Took into account RFC comments (unsubscribe, error enum,
>>> thermal daemon
>>>         renamed to thermal-engine)
>>>
>>> Daniel Lezcano (4):
>>>     tools/lib/thermal: Add a thermal library
>>>     tools/thermal: Add util library
>>>     tools/thermal: A temperature capture tool
>>>     tools/thermal: Add thermal daemon skeleton
>>>
>>>    tools/Makefile                                |  36 +-
>>>    tools/lib/thermal/.gitignore                  |   2 +
>>>    tools/lib/thermal/Build                       |   5 +
>>>    tools/lib/thermal/Makefile                    | 165 ++++++++
>>>    tools/lib/thermal/commands.c                  | 351
>>> ++++++++++++++++
>>>    tools/lib/thermal/events.c                    | 164 ++++++++
>>>    tools/lib/thermal/include/thermal.h           | 141 +++++++
>>>    tools/lib/thermal/libthermal.map              |  25 ++
>>>    tools/lib/thermal/libthermal.pc.template      |  12 +
>>>    tools/lib/thermal/sampling.c                  |  75 ++++
>>>    tools/lib/thermal/thermal.c                   | 126 ++++++
>>>    tools/lib/thermal/thermal_nl.c                | 215 ++++++++++
>>>    tools/lib/thermal/thermal_nl.h                |  46 ++
>>>    tools/thermal/lib/Build                       |   3 +
>>>    tools/thermal/lib/Makefile                    | 158 +++++++
>>>    .../thermal/lib/libthermal_tools.pc.template  |  12 +
>>>    tools/thermal/lib/log.c                       |  77 ++++
>>>    tools/thermal/lib/log.h                       |  31 ++
>>>    tools/thermal/lib/mainloop.c                  | 135 ++++++
>>>    tools/thermal/lib/mainloop.h                  |  14 +
>>>    tools/thermal/lib/thermal-tools.h             |  10 +
>>>    tools/thermal/lib/uptimeofday.c               |  40 ++
>>>    tools/thermal/lib/uptimeofday.h               |  12 +
>>>    tools/thermal/thermal-engine/Build            |   2 +
>>>    tools/thermal/thermal-engine/Makefile         |  27 ++
>>>    tools/thermal/thermal-engine/thermal-engine.c | 287 +++++++++++++
>>>    tools/thermal/thermometer/Build               |   2 +
>>>    tools/thermal/thermometer/Makefile            |  23 +
>>>    tools/thermal/thermometer/thermometer.c       | 393
>>> ++++++++++++++++++
>>>    tools/thermal/thermometer/thermometer.conf    |   5 +
>>>    30 files changed, 2591 insertions(+), 3 deletions(-)
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
>>>    create mode 100644 tools/thermal/thermometer/thermometer.c
>>>    create mode 100644 tools/thermal/thermometer/thermometer.conf
>>>
>>
>>
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
