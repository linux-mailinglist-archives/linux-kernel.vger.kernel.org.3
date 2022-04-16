Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D350350C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 09:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiDPH6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 03:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiDPH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 03:57:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD8665CD
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 00:55:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k22so12926341wrd.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 00:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0Z/W81aibCi7sL0/StQ7Jt11jrZjdA1d8v+1Q33ahWI=;
        b=X1awk6DHUaoooLVFABP0ldTMOEPsD2YHIGSk6gDRxFgvhONqyBosWnnkfRL91EZ0K3
         8s8l4atfe1UGhlscpBFIZMUHxp4dWns53SgtvzNMxs2poN9KzS//dYJKi2nDhjeNAw2H
         MFqDhZ65oQH1cn74nPyErsr0u8Rmkxo0uzlnzPPlo2Ctts4liVIURSEjHcTc+MwmR2j6
         y9I9K9FkOrnQBu2aiw10lWGRHuwSsZsXIrhqztViKe8OztcY09tJJyB3O3cqVudLchTG
         UVQZS2SXcorYKlqNg3Gbs4QT4cjLTpq3G+ulZblPxZSllu67bE1rnV2p7Z/uSnWPU/dZ
         up3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0Z/W81aibCi7sL0/StQ7Jt11jrZjdA1d8v+1Q33ahWI=;
        b=MeQgvswFo8FT3lIdLoKa0NLxKTJ7CQZBZbC/DBE0Pjjy/t90H95blg8FOp4At8ieqB
         sIVz6twSh/oygKPhqqnF0YMtFUkY1rq0jhNwM88CCaFGpw4yCwQ4qYGuyN8E5/hWkmp4
         Tj/Cs2xKEGFzZUNtx3kLRH0I/B+d15OFD+wHmNVgMEwE/wMbpP1b9dO/tlhgJN6vKk1l
         L9LRGnojBqjPkmGNfagDfrkEFBw5HMNW0R4fbQdnO/DeaI/p241Hey+qoDV0X1wl4az5
         U6r9Fhol1ODRKTX9zpid+kJwuAP0LLEnew+jMiF+xehaMSGCWdQ8/PqSl1g96OoYt3NO
         fKHA==
X-Gm-Message-State: AOAM531W7uAS+WdVsRPCBX0vZdd03GgXlXgj+2Sjf/9LjZUZ9qkc2V36
        VYdOR8cJssFSsmqZvXZjHx2w06x7idPpYA==
X-Google-Smtp-Source: ABdhPJwB+cZviGHllZV9G2s8X+fYEb1nevgdh5ALPNUcbDAriRZ/2fj5T/hzd7ARt3+v4IyzJqX6Tw==
X-Received: by 2002:adf:efc1:0:b0:207:8436:20ab with SMTP id i1-20020adfefc1000000b00207843620abmr1771660wrp.622.1650095721626;
        Sat, 16 Apr 2022 00:55:21 -0700 (PDT)
Received: from [192.168.0.46] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id x16-20020a5d4450000000b00207a459ca80sm6402035wrr.99.2022.04.16.00.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Apr 2022 00:55:20 -0700 (PDT)
Message-ID: <916d2e4c-7224-f824-f3cf-5c1dee411ed1@linaro.org>
Date:   Sat, 16 Apr 2022 09:55:19 +0200
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <f1d2b1c7a9691c64ece07fbc1fc5a2d4e70aa00a.camel@linux.intel.com>
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


On 16/04/2022 05:50, srinivas pandruvada wrote:
> On Wed, 2022-04-13 at 10:21 -0700, srinivas pandruvada wrote:
>> On Wed, 2022-04-13 at 17:06 +0200, Rafael J. Wysocki wrote:
>>> On Wed, Apr 6, 2022 at 4:44 PM Daniel Lezcano <
>>> daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 06/04/2022 16:28, srinivas pandruvada wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> On Wed, 2022-04-06 at 10:00 +0200, Daniel Lezcano wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> if there is no comment for the series, shall I pick it so we
>>>>>> can go
>>>>>> forward ?
>>>>> Didn't get time to check yet. It will still be for the next merge
>>>>> window, correct?
>>>>
>>>> Right, but I would like to continue adding more features, scripts
>>>> and
>>>> tests. Iteratively.
>>>
>>> Srinivas, if you can give this a go, please, it will help.
>>>
>>> Otherwise, I think that all of your comments so far have been
>>> addressed, or have I missed anything?
>>>
>> I will provide by the end of this week.
> 
> 1. Some warnings in applying patch
> 
> Applying: tools/lib/thermal: Add a thermal library
> Applying: tools/thermal: Add util library
> Applying: tools/thermal: A temperature capture tool
> .git/rebase-apply/patch:795: space before tab in indent.
> 	      	polling = 100; }
> .git/rebase-apply/patch:90: new blank line at EOF.
> +
> .git/rebase-apply/patch:221: new blank line at EOF.
> +
> warning: 3 lines add whitespace errors.
> Applying: tools/thermal: Add thermal daemon skeleton
> .git/rebase-apply/patch:86: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.

Strange, I did not have those but I'll try to reproduce

> 2. Thermometer is fine
> 
> 3. segfault for thermal-engine
> 
> LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH ./thermal-
> engine
> Segmentation fault (core dumped)
> root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/thermal-
> engine# LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
> ./thermal-engine --help
> thermal-engine : A thermal monitoring engine based on notifications
> Usage: thermal-engine [options]
> 	-h, --help		this help
> 	-d, --daemonize	capture duration
> 	-l <level>, --loglevel <level>	log level: DEBUG, INFO,
> NOTICE, WARN, ERROR
> 	-s, --syslog		output to syslog
> 
> root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/thermal-
> engine# LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
> ./thermal-engine -l DEBUG
> Segmentation fault (core dumped)
> root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/thermal-
> engine# LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
> ./thermal-engine --loglevel DEBUG
> Segmentation fault (core dumped)
> root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/thermal-
> engine# LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
> ./thermal-engine -s
> Segmentation fault (core dumped)

Is CONFIG_THERMAL_NETLINK set ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
