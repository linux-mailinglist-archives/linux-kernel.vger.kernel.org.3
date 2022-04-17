Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BD850470F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 10:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiDQIWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 04:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbiDQIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 04:22:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937CB2CC9D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 01:20:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p189so7214438wmp.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TzAp20TyMggJ/3dlwCML8H4wPPcwMOB3OFkk3qHv2EU=;
        b=vQO4uELCDDzsMfRgLrfTelyLBMc8KQ07iI57ReU0wxV+FwKBVCLsXn8jRZmitnn3I9
         XG2KFp9m0i17zE1VTMP0/fOtDELoSuXfdKGNxLegNs/x57z6QLK6a/ZasJe1YCYNUUcr
         3bU7On0PhXFyoYDJRkDPtD1WI2C2vEjP0sxZCbAjy9RdfzTtTPFmzCohUR37/9gZmF7c
         4KZaGYvmiTXzJGCKRSjLPt5bnHJZ0CjD4wtmEDXaMSI3gQvGf627CjNd9bgt7Wf+XM5v
         WMJNM7MNPjypilpQdlinVQDf7OD4DFtf24VPquqh6Iz7eHY2sdm6oIPlytCCCyZQtNCW
         mjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TzAp20TyMggJ/3dlwCML8H4wPPcwMOB3OFkk3qHv2EU=;
        b=0mjRxmlejhC3ymgGmeuysWgN6TxC9OqgctbW48bl7sLikwd/OMyvep8JUlAlAGTsqx
         +xUlmoh6ylP990yLcBtJwDRNf3Qp5vjojmK4hSWBAsrc6HcsmLUwROgOkMOukqMrUFZf
         vz0PaHUUs2ZlLKyxl14SbC89MFoEQiqitohqfmoVYOZ0YmbcBeJXI4mk6ILLQdvD8U4W
         Ac0RRRKLImZcDiW7nXU3tj/ykuNFLBsHNVsEClOV2BHb8IJ6RDNMV8znjMpzPldFPwD0
         cQCTYN9hzoE5vzkGnL7kqi6zaaexTA8AxBB8MQBSb91kuvkxzpWaZcl8ZqKSuyCvl/DI
         tuHA==
X-Gm-Message-State: AOAM533hbH0wmQlH5H9poDM10C1Vc0lFsQWqcgh+Ue7e+zA9MUL7ET/I
        Z63rospV1iLiCUZj68oIttm5jg==
X-Google-Smtp-Source: ABdhPJzGnkcDeyXu+oFujzOuJQv+pXyMhgDrA7BYkcX1gAE+nlz4/amM1Bq8yxQYYJ1IVBpjbBN+Cg==
X-Received: by 2002:a05:600c:a4b:b0:37b:ea2b:5583 with SMTP id c11-20020a05600c0a4b00b0037bea2b5583mr10560785wmq.139.1650183611998;
        Sun, 17 Apr 2022 01:20:11 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm11250651wmp.14.2022.04.17.01.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 01:20:11 -0700 (PDT)
Message-ID: <ba3cbf3d-938b-1530-1178-68b447f20a9c@linaro.org>
Date:   Sun, 17 Apr 2022 10:20:10 +0200
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <dc9b317f88f7d43cd30141376156c0f3eec687d8.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Srinivas,

thanks for the information. I've indeed not tested on x86_64 but on ARM64.

I'll give a try to reproduce and fix the issue.

Thanks again for taking the time to run it

   -- Daniel

On 17/04/2022 06:23, srinivas pandruvada wrote:
> Hi Daniel,
> 
> On Sat, 2022-04-16 at 09:55 +0200, Daniel Lezcano wrote:
>>
>> Hi Srinivas,
>>
>>
>> On 16/04/2022 05:50, srinivas pandruvada wrote:
>>> On Wed, 2022-04-13 at 10:21 -0700, srinivas pandruvada wrote:
>>>> On Wed, 2022-04-13 at 17:06 +0200, Rafael J. Wysocki wrote:
>>>>> On Wed, Apr 6, 2022 at 4:44 PM Daniel Lezcano <
>>>>> daniel.lezcano@linaro.org> wrote:
>>>>>>
>>>
> 
> [...]
> 
>>> root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/thermal-
>>> engine# LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
>>> ./thermal-engine -l DEBUG
>>> Segmentation fault (core dumped)
>>> root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/thermal-
>>> engine# LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
>>> ./thermal-engine --loglevel DEBUG
>>> Segmentation fault (core dumped)
>>> root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/thermal-
>>> engine# LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
>>> ./thermal-engine -s
>>> Segmentation fault (core dumped)
>>
>> Is CONFIG_THERMAL_NETLINK set ?
> 
> Yes, Thermometer program works fine. Just thermal-engine fails.
> CONFIG_THERMAL=y
> CONFIG_THERMAL_NETLINK=y
> CONFIG_THERMAL_STATISTICS=y
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_BANG_BANG=y
> CONFIG_THERMAL_GOV_USER_SPACE=y
> CONFIG_DEVFREQ_THERMAL=y
> CONFIG_THERMAL_EMULATION=y
> 
> This may help
> 
> #gdb ./thermal-engine
> GNU gdb (Ubuntu 8.1.1-0ubuntu1) 8.1.1
> Copyright (C) 2018 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later
> <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show
> copying"
> and "show warranty" for details.
> This GDB was configured as "x86_64-linux-gnu".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
> <http://www.gnu.org/software/gdb/documentation/>.
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from ./thermal-engine...(no debugging symbols
> found)...done.
> (gdb) run
> Starting program:
> /home/labuser/development/linux/tools/thermal/thermal-engine/thermal-
> engine
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-
> gnu/libthread_db.so.1".
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7402036 in parse_tz_get_trip (info=0x7fffffffdf60,
> tz=0x555555607898) at commands.c:143
> 143		__tt[size].id = -1;
> (gdb) backtrace
> #0  0x00007ffff7402036 in parse_tz_get_trip (info=0x7fffffffdf60,
> tz=0x555555607898) at commands.c:143
> #1  0x00007ffff7402233 in handle_netlink (unused=0x0,
> cmd=0x7ffff76052f8 <thermal_cmds+120>, info=0x7fffffffdf60,
> arg=0x555555607898) at commands.c:206
> #2  0x00007ffff7003435 in ?? () from /lib/x86_64-linux-gnu/libnl-genl-
> 3.so.200
> #3  0x00007ffff6810c1c in nl_recvmsgs_report () from /lib/x86_64-linux-
> gnu/libnl-3.so.200
> #4  0x00007ffff6811049 in nl_recvmsgs () from /lib/x86_64-linux-
> gnu/libnl-3.so.200
> #5  0x00007ffff7402eaf in nl_send_msg (sock=0x555555606040,
> cb=0x5555556065d0, msg=0x555555606110, rx_handler=0x7ffff70036f0
> <genl_handle_msg>, data=0x555555607898) at thermal_nl.c:70
> #6  0x00007ffff7402327 in thermal_genl_auto (th=0x5555556048a0, id=1,
> cmd=2, flags=0, arg=0x555555607898) at commands.c:282
> #7  0x00007ffff74023e0 in thermal_cmd_get_trip (th=0x5555556048a0,
> tz=0x555555607898) at commands.c:304
> #8  0x00007ffff74039db in __thermal_zone_discover (tz=0x555555607898,
> th=0x5555556048a0) at thermal.c:71
> #9  0x00007ffff7403842 in for_each_thermal_zone (tz=0x555555607860,
> cb=0x7ffff74039b8 <__thermal_zone_discover>, arg=0x5555556048a0) at
> thermal.c:33
> #10 0x00007ffff7403a5b in thermal_zone_discover (th=0x5555556048a0) at
> thermal.c:87
> #11 0x00005555554019bd in main ()
> 
> Thanks,
> Srinivas
> 
>>
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
