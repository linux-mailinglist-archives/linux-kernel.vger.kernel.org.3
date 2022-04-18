Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81919504D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiDRHtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 03:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiDRHtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 03:49:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5877812AAC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 00:46:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i20so17651127wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 00:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s7kT8l0sl8+OhaJJZSAGVVrmqAaGW5JCBigejiw9azA=;
        b=Bk/TFaAXnpaA67NDY7CYQt2yjCAzscM9fQpgb7ObGschBr57GNCMUTDT161Jf0+T7C
         zqQ0W07vsb+mzDE3QxFgVg2dlIaongS9a1x6zjnC9B+BoUUidPJjpLb+vbcHPV9VTPXk
         46zOS7fQJGOVoFji841SzlxJVARNGEpJX9LjJbZxvl0trILE8C0KfG5aXFM7QnqaOBuR
         XxKRMTwyr5a3gMuaSftqWfZy/6urnrt2BWZpXsdvabt4gKigTU81Z8djom3VXzExaLfF
         X/UK1ep0oqfksXR1ZHbesEffmtRCuYUyPBFtIsolcGXIaS0AlH8SEONw59dHd28uYw+O
         261w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s7kT8l0sl8+OhaJJZSAGVVrmqAaGW5JCBigejiw9azA=;
        b=Wh6HU/tnTxme4hik4l3gjDl7xM/R5ysziwUCxGyxefpN/6GMK3ATWBaL/zscaDnk7X
         KivTht3JXfk1NVrw+zdc+d1nzFMjJXHG+wkcOc0V/CXed8nSWUizyh/gOTE8kPTHHvXW
         dZDDBX7PYvTXApJPFh0aS/kUddLnmayDnSIDnSxoyj2ncq8HbcNRThX965Hxasg57Hd8
         28b8A1EaQWE6wIPmhIvZTO12ttQGtp5z+BRCi28mwPnelFsKFHp7zSQen8gvxSQAo+2y
         1Ha7rZnBShQmkUQS6uKr3FdqxU6u9kdvNWdO5yrmGCXbu0uDUY2cdG9fvUW+Q8m/52RN
         j+7A==
X-Gm-Message-State: AOAM531Bic+JFLW4rRokJnXRpTPXZxA9ovPYXqD1M3VhPOtuGXaGq/1g
        FBvktDULpXG6CSFlENbEHHCVUw==
X-Google-Smtp-Source: ABdhPJxNJMWnPRARXvoGwKBa7j+9kLL/agzx0E6HN78ndKs1xKtDKEXgvpg+KLRbHaXBiaIFVh4VCw==
X-Received: by 2002:adf:eb86:0:b0:1e6:8c92:af6b with SMTP id t6-20020adfeb86000000b001e68c92af6bmr7340476wrn.116.1650267986749;
        Mon, 18 Apr 2022 00:46:26 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm16232460wml.10.2022.04.18.00.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 00:46:26 -0700 (PDT)
Message-ID: <679f73ad-1ee7-3077-407a-aedc5c212c28@linaro.org>
Date:   Mon, 18 Apr 2022 09:46:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/4] tools/thermal: thermal library and tools
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
 <f526d227-ffbb-4ac0-ceb6-c793ab912559@linaro.org>
 <5380fef6d45f2f7a0b8a5f681934f02943d5e138.camel@linux.intel.com>
 <9ccb342b-2f20-6efd-a668-96d593aa921e@linaro.org>
 <CAJZ5v0hrRuVz8pgD6-m7EhVdHPPn67O4ajx_7vkOOOYdTkv2BQ@mail.gmail.com>
 <0181977f5843fb9df4eae7d397d96c890846a0db.camel@linux.intel.com>
 <f1d2b1c7a9691c64ece07fbc1fc5a2d4e70aa00a.camel@linux.intel.com>
 <916d2e4c-7224-f824-f3cf-5c1dee411ed1@linaro.org>
 <dc9b317f88f7d43cd30141376156c0f3eec687d8.camel@linux.intel.com>
 <ba3cbf3d-938b-1530-1178-68b447f20a9c@linaro.org>
 <f7e4f4604f122dfab4aa5e589d68eb2c8773e00d.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <f7e4f4604f122dfab4aa5e589d68eb2c8773e00d.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Srinivas,

thanks for the fix !

On 18/04/2022 05:36, srinivas pandruvada wrote:
> Hi Daniel,
> 
> The attached diff fixes the crash,
> 
> Also when you run in daemon mode, you need to use some pid lock file.
> Otherwise it launches multiple daemons.

Thanks for the feedback, I'll add it

   -- Daniel

> 
> On Sun, 2022-04-17 at 10:20 +0200, Daniel Lezcano wrote:
>>
>> Hi Srinivas,
>>
>> thanks for the information. I've indeed not tested on x86_64 but on
>> ARM64.
>>
>> I'll give a try to reproduce and fix the issue.
>>
>> Thanks again for taking the time to run it
>>
>>     -- Daniel
>>
>> On 17/04/2022 06:23, srinivas pandruvada wrote:
>>> Hi Daniel,
>>>
>>> On Sat, 2022-04-16 at 09:55 +0200, Daniel Lezcano wrote:
>>>>
>>>> Hi Srinivas,
>>>>
>>>>
>>>> On 16/04/2022 05:50, srinivas pandruvada wrote:
>>>>> On Wed, 2022-04-13 at 10:21 -0700, srinivas pandruvada wrote:
>>>>>> On Wed, 2022-04-13 at 17:06 +0200, Rafael J. Wysocki wrote:
>>>>>>> On Wed, Apr 6, 2022 at 4:44 PM Daniel Lezcano <
>>>>>>> daniel.lezcano@linaro.org> wrote:
>>>>>>>>
>>>>>
>>>
>>> [...]
>>>
>>>>> root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/the
>>>>> rmal-
>>>>> engine#
>>>>> LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
>>>>> ./thermal-engine -l DEBUG
>>>>> Segmentation fault (core dumped)
>>>>> root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/the
>>>>> rmal-
>>>>> engine#
>>>>> LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
>>>>> ./thermal-engine --loglevel DEBUG
>>>>> Segmentation fault (core dumped)
>>>>> root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/the
>>>>> rmal-
>>>>> engine#
>>>>> LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
>>>>> ./thermal-engine -s
>>>>> Segmentation fault (core dumped)
>>>>
>>>> Is CONFIG_THERMAL_NETLINK set ?
>>>
>>> Yes, Thermometer program works fine. Just thermal-engine fails.
>>> CONFIG_THERMAL=y
>>> CONFIG_THERMAL_NETLINK=y
>>> CONFIG_THERMAL_STATISTICS=y
>>> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
>>> CONFIG_THERMAL_HWMON=y
>>> CONFIG_THERMAL_WRITABLE_TRIPS=y
>>> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
>>> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
>>> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
>>> CONFIG_THERMAL_GOV_FAIR_SHARE=y
>>> CONFIG_THERMAL_GOV_STEP_WISE=y
>>> CONFIG_THERMAL_GOV_BANG_BANG=y
>>> CONFIG_THERMAL_GOV_USER_SPACE=y
>>> CONFIG_DEVFREQ_THERMAL=y
>>> CONFIG_THERMAL_EMULATION=y
>>>
>>> This may help
>>>
>>> #gdb ./thermal-engine
>>> GNU gdb (Ubuntu 8.1.1-0ubuntu1) 8.1.1
>>> Copyright (C) 2018 Free Software Foundation, Inc.
>>> License GPLv3+: GNU GPL version 3 or later
>>> <http://gnu.org/licenses/gpl.html>
>>> This is free software: you are free to change and redistribute it.
>>> There is NO WARRANTY, to the extent permitted by law.  Type "show
>>> copying"
>>> and "show warranty" for details.
>>> This GDB was configured as "x86_64-linux-gnu".
>>> Type "show configuration" for configuration details.
>>> For bug reporting instructions, please see:
>>> <http://www.gnu.org/software/gdb/bugs/>.
>>> Find the GDB manual and other documentation resources online at:
>>> <http://www.gnu.org/software/gdb/documentation/>.
>>> For help, type "help".
>>> Type "apropos word" to search for commands related to "word"...
>>> Reading symbols from ./thermal-engine...(no debugging symbols
>>> found)...done.
>>> (gdb) run
>>> Starting program:
>>> /home/labuser/development/linux/tools/thermal/thermal-
>>> engine/thermal-
>>> engine
>>> [Thread debugging using libthread_db enabled]
>>> Using host libthread_db library "/lib/x86_64-linux-
>>> gnu/libthread_db.so.1".
>>>
>>> Program received signal SIGSEGV, Segmentation fault.
>>> 0x00007ffff7402036 in parse_tz_get_trip (info=0x7fffffffdf60,
>>> tz=0x555555607898) at commands.c:143
>>> 143             __tt[size].id = -1;
>>> (gdb) backtrace
>>> #0  0x00007ffff7402036 in parse_tz_get_trip (info=0x7fffffffdf60,
>>> tz=0x555555607898) at commands.c:143
>>> #1  0x00007ffff7402233 in handle_netlink (unused=0x0,
>>> cmd=0x7ffff76052f8 <thermal_cmds+120>, info=0x7fffffffdf60,
>>> arg=0x555555607898) at commands.c:206
>>> #2  0x00007ffff7003435 in ?? () from /lib/x86_64-linux-gnu/libnl-
>>> genl-
>>> 3.so.200
>>> #3  0x00007ffff6810c1c in nl_recvmsgs_report () from /lib/x86_64-
>>> linux-
>>> gnu/libnl-3.so.200
>>> #4  0x00007ffff6811049 in nl_recvmsgs () from /lib/x86_64-linux-
>>> gnu/libnl-3.so.200
>>> #5  0x00007ffff7402eaf in nl_send_msg (sock=0x555555606040,
>>> cb=0x5555556065d0, msg=0x555555606110, rx_handler=0x7ffff70036f0
>>> <genl_handle_msg>, data=0x555555607898) at thermal_nl.c:70
>>> #6  0x00007ffff7402327 in thermal_genl_auto (th=0x5555556048a0,
>>> id=1,
>>> cmd=2, flags=0, arg=0x555555607898) at commands.c:282
>>> #7  0x00007ffff74023e0 in thermal_cmd_get_trip (th=0x5555556048a0,
>>> tz=0x555555607898) at commands.c:304
>>> #8  0x00007ffff74039db in __thermal_zone_discover
>>> (tz=0x555555607898,
>>> th=0x5555556048a0) at thermal.c:71
>>> #9  0x00007ffff7403842 in for_each_thermal_zone (tz=0x555555607860,
>>> cb=0x7ffff74039b8 <__thermal_zone_discover>, arg=0x5555556048a0) at
>>> thermal.c:33
>>> #10 0x00007ffff7403a5b in thermal_zone_discover (th=0x5555556048a0)
>>> at
>>> thermal.c:87
>>> #11 0x00005555554019bd in main ()
>>>
>>> Thanks,
>>> Srinivas
>>>
>>>>
>>>
>>>
>>
>>
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
