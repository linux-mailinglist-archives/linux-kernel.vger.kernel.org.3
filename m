Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB035076E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbiDSR70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbiDSR7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:59:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDCDB1E4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:56:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so2080425wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bmuCPCXtKhNbfQCMSfkHBeQsIjHW0Bsetzr2CJ2qtYA=;
        b=drKsGHsxEBWVXxr1s6qoryQJHh/r9LCkkU8Y09HwD+xRcrkKaWf6AvnMEy0RqBf685
         AAzqEbK0N4oNKPiPfA6smvlLY1MaW+lnRKr2p1ziOgGNTDk77VTSpwnhs+/AeFr3XlSo
         oKbf+MFgG3LdkS8AhKKGa/kL+cMleqIIKCW7hkLwQL7d3xW6jg1C3ryMUhNqrW0YgEGf
         JLvkeubNcVkKnIbPxp9oJzGUei8vL7I+XYLcPV1Fp8fO0iSJeeYlFoXsUVfXvHMWxHsG
         GoJ7rECxN+lGSZ2z6SfFWn926hI3UQRNhouoHhqbda7MufErL+hH3QDL0+UaJFOcrnhp
         RHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bmuCPCXtKhNbfQCMSfkHBeQsIjHW0Bsetzr2CJ2qtYA=;
        b=npYENIG7DHyDKV+UFMq6Z5IFe6mDj+sv7u8Vn09Z1QZ6XWmAbTAxxUVsz6jDclnhG1
         wSIqR/4DjvFA25UIXexOTwYAXS06BPup1uPD7WV2Q2j388Rvulvo/V/xB5UnNA2lE499
         gJw3JpALG9p//mhhdhl/rl4RUCussjCHmhYgaVoeNmCXn7dbpjDPT7YvBxu2PtUxiho0
         YLyvchCcOj3X2FeA1pG4jVuqP77NfEwloIFm0aAMjIxuuk4KvdUjvc0kdtzBsBGSeCGp
         ti3Dmyn8cnKUXEfXzvEwP4DDWlzKkmVWis5W0S1hPgrFBB72G43DITHZL/2hsQIUyhFi
         qgbw==
X-Gm-Message-State: AOAM533xQtnV710yJoydAcyze/WATtcMz9j5jqQsYbMUEBzlm+5Hc5p/
        /nwNX9cwBoxrRK0gGSbsFRHcGw==
X-Google-Smtp-Source: ABdhPJzN/nsP389ntEldrnrL4UTUMJqyex/4UMPiNLZweFq3BS/ZgW4E3wgiRh5yQTXrTg5i2KA0JA==
X-Received: by 2002:a05:600c:3b1c:b0:392:7bb0:b0ec with SMTP id m28-20020a05600c3b1c00b003927bb0b0ecmr17626986wms.185.1650390997508;
        Tue, 19 Apr 2022 10:56:37 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id p1-20020a1c7401000000b0038ed3bb00c9sm16095047wmc.6.2022.04.19.10.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 10:56:36 -0700 (PDT)
Message-ID: <ddbbc1db-2dd3-0c4d-26c0-0992867d35be@linaro.org>
Date:   Tue, 19 Apr 2022 19:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] thermal/core: change mm alloc method to avoid kernel
 warning
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, Junwen Wu <wudaemon@163.com>,
        rafael@kernel.org, amitk@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20220417125601.18535-1-wudaemon@163.com>
 <a7861e9a6a311f09c03b2e6e47dd4d3283cb58e2.camel@intel.com>
 <01f72a07-6adc-4854-eae2-286786d33aab@linaro.org>
 <df7e04d86dd64dc85125d536434d93bab3d6314d.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <df7e04d86dd64dc85125d536434d93bab3d6314d.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 15:54, Zhang Rui wrote:
> CC Viresh.
> 
> On Tue, 2022-04-19 at 11:14 +0200, Daniel Lezcano wrote:
>> On 19/04/2022 10:48, Zhang Rui wrote:
>>> On Sun, 2022-04-17 at 12:56 +0000, Junwen Wu wrote:
>>>> Very high cooling device max state value makes cooling device
>>>> stats
>>>> buffer allocation fails,like below.Using kzvalloc instead of
>>>> kzalloc
>>>> can avoid this issue.
>>>
>>> When a cooling device has big max_state, this patch can get ride of
>>> the
>>> warning here, but still we end up with the read failure of the
>>> trans_table in sysfs because it is larger than PAGE_SIZE.
>>>
>>> $ cat /sys/class/thermal/cooling_device8/stats/trans_table
>>> cat: /sys/class/thermal/cooling_device8/stats/trans_table: File too
>>> large
>>>
>>> IMO, unless we can fix both places, I'd suggest we skip allocating
>>> and
>>> creating the broken trans_table attr. Like a prototype patch below
>>
>> Why not create a thermal debugfs with real useful information and
>> get
>> rid of this broken code ?
> 
> The idea looks good to me.

What about doing a percentile approach of the state indexes changes 
instead of a raw matrix full of zeros ? So we show the most significant 
transitions, perhaps something like:

99%:	7->6	6->7
98%:	6->5	5->6
95%:	5->4	4->5
90%:	7->5	5->7
80%:	6->4	4->6
70%:	7->1	7->2
50%:	...	...

total:	123456	124573


And another statistics file containing some timings information like the 
total duration in mitigation, and the duration in the most significant 
states above?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
