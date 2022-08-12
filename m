Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74BF59141A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbiHLQnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHLQn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:43:29 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCCCA7A92;
        Fri, 12 Aug 2022 09:43:28 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id e28so1176631qts.1;
        Fri, 12 Aug 2022 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3USZWIN42TMGW91mrZdIe2fOGVO44/PRBAX2ZkSHa9w=;
        b=bV0o69XoHBOqPCgIjzUOW10xtQdByRjPI8METXiHSn32z7hV1Gp+iiGBe/3hHzXpKO
         MMax4ggbZUCPWuRnN7F9gcfZAr6fOi6xaX6qJX99iko/ctonw+QmsU6SOF41kPuIstlb
         1uqrks7uc/qy4gEi+Apy2uCw9mxxie1hkHGSetObOHPW0ChEhotmHjG2bIGsXG4PDNLj
         c8VfC1A2F2n+uIos2AXHdZduKMp82GK6oOwBzRDf5ZeKmFbCs/iwHA+4wtJQK/vaAbRG
         xKCFR60j0DtgHKcUAW/xGTKSOm7A1H2CJKwoWgFsh03tnZJAp2jLkPSYUEW0N4vse0Tq
         t1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3USZWIN42TMGW91mrZdIe2fOGVO44/PRBAX2ZkSHa9w=;
        b=Rvx2P1Le+JbqjI4kt5Xa5XZawhO7HA1DHTUOQ8R9ES46kektDBF4eV38tUlG05TV+G
         0C4+tfzqhNJvrTqAxhIPRXvxuIohpEwh5TJ7CL8FGL0c7leRHwoMWbSNVtqXJ6oHTaxG
         HMnSTKYTfcZi2YYnKsgUj2sMfRGkM4NNgSzsK9K/ulnuH91USIWXnzJZhYwhkM43kqsz
         WPTPqY3wIg4M0aiqFXn5ygAeBIyjTs+Pk8cxwHUF9w/AbtkurtnWnB7nLiiJofZ3dvHy
         dl+mJvoAhaRWPluVQdV+DTBG0F+ZqJKyZuckmUxOezr1HmPFQ3+z4w4ojafOjHQB6Z1t
         GACw==
X-Gm-Message-State: ACgBeo3n2FKLeE36W8WabpBZcrdrqvFL9HRrE+bxYbCtLulcnL2b1tsC
        ozlGx3joCAzHUwj0twu2mOU=
X-Google-Smtp-Source: AA6agR7FB9sjnJbz8bxM0fTIOs1CUGgdBpX/1WCCHOxG/ZfhC2Lu+d4G/6t1d5cOPCfSS1GTViBSsg==
X-Received: by 2002:a05:622a:48f:b0:343:6db4:d3b1 with SMTP id p15-20020a05622a048f00b003436db4d3b1mr4216701qtx.202.1660322607234;
        Fri, 12 Aug 2022 09:43:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c9-20020ac85a89000000b0033aac3da27dsm2259925qtc.19.2022.08.12.09.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 09:43:26 -0700 (PDT)
Message-ID: <ac5e544a-a9d7-37c7-3d0b-65e706d544a0@gmail.com>
Date:   Fri, 12 Aug 2022 09:43:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] MIPS: Expose prid and globalnumber to sysfs
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, linux-api@vger.kernel.org
References: <20220811101236.1925-1-jiaxun.yang@flygoat.com>
 <66e7f45b-2292-f76e-b9a1-3db2af8c24a9@gmail.com>
 <2ED0B1C9-07AB-4DE3-BC85-F490FA94785F@flygoat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <2ED0B1C9-07AB-4DE3-BC85-F490FA94785F@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 03:29, Jiaxun Yang wrote:
> 
> 
>> 2022年8月12日 03:21，Florian Fainelli <f.fainelli@gmail.com 
>> <mailto:f.fainelli@gmail.com>> 写道：
>>
>>
>>
>> On 8/11/2022 3:12 AM, Jiaxun Yang wrote:
>>> Some application would like to know precise model and rev of processor
>>> to do errata workaround or optimization.
>>> Expose them in sysfs as:
>>> /sys/devices/system/cpu/cpuX/regs/identification/prid
>>> /sys/devices/system/cpu/cpuX/regs/identification/globalnumber
>>> Reusing AArch64 CPU registers directory.
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com 
>>> <mailto:jiaxun.yang@flygoat.com>>
>>> ---
>>> v2: Drop static qualifier for kobj (gregkh)
>>> ---
>>>  .../ABI/testing/sysfs-devices-system-cpu      | 11 +++
>>>  arch/mips/kernel/topology.c                   | 96 +++++++++++++++++++
>>>  2 files changed, 107 insertions(+)
>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu 
>>> b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>> index 5bf61881f012..adf855e7bb9b 100644
>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>> @@ -512,6 +512,17 @@ Description:information about CPUs heterogeneity.
>>> cpu_capacity: capacity of cpuX.
>>>  +What:/sys/devices/system/cpu/cpuX/regs/
>>> +/sys/devices/system/cpu/cpuX/regs/identification/
>>> +/sys/devices/system/cpu/cpuX/regs/identification/prid
>>> +/sys/devices/system/cpu/cpuX/regs/identification/globalnumber
>>> +Date:Augest 2022
>>
>> typo: August
> 
> Thanks, good catch :-)
> 
>>
>>> +Contact:Linux MIPS Kernel Mailing list <linux-mips@vger.kernel.org 
>>> <mailto:linux-mips@vger.kernel.org>>
>>> +Description:MIPS CPU registers
>>> +
>>> +'identification' directory exposes the Processor ID and Global Number
>>> +registers for identifying model and revision of the CPU.
>>> +
>>>  What:/sys/devices/system/cpu/vulnerabilities
>>> /sys/devices/system/cpu/vulnerabilities/meltdown
>>> /sys/devices/system/cpu/vulnerabilities/spectre_v1
>>> diff --git a/arch/mips/kernel/topology.c b/arch/mips/kernel/topology.c
>>> index 9429d85a4703..0e3730f3c00f 100644
>>> --- a/arch/mips/kernel/topology.c
>>> +++ b/arch/mips/kernel/topology.c
>>> @@ -5,6 +5,8 @@
>>>  #include <linux/node.h>
>>>  #include <linux/nodemask.h>
>>>  #include <linux/percpu.h>
>>> +#include <linux/seq_file.h>
>>> +#include <linux/smp.h>
>>>    static DEFINE_PER_CPU(struct cpu, cpu_devices);
>>>  @@ -26,3 +28,97 @@ static int __init topology_init(void)
>>>  }
>>>    subsys_initcall(topology_init);
>>> +
>>> +static struct kobj_type cpuregs_kobj_type = {
>>> +.sysfs_ops = &kobj_sysfs_ops,
>>> +};
>>> +
>>> +struct cpureg {
>>> +struct kobject kobj;
>>> +struct cpuinfo_mips *info;
>>> +};
>>> +DEFINE_PER_CPU(struct cpureg, cpuregs);
>>> +
>>> +#define kobj_to_cpureg(kobj)container_of(kobj, struct cpureg, kobj)
>>> +#define CPUREGS_ATTR_RO(_name, _field)\
>>> +static ssize_t _name##_show(struct kobject *kobj,\
>>> +struct kobj_attribute *attr, char *buf)\
>>> +{\
>>> +struct cpuinfo_mips *info = kobj_to_cpureg(kobj)->info;\
>>> +\
>>> +return sprintf(buf, "0x%08x\n", info->_field);\
>>
>> Would not you be able to simplify this greatly with just:
>>
>> struct cpuinfo_mips *info = current_cpu_data;
> 
> Because some fields in PRID and globalnumber are not consistent between 
> cores
> so it needs to be per CPU.

Yes my bad, I was thinking that you could simplify things by always 
getting the registers of the CPU you are running on, but you need to 
create those attributes for each CPU in the system and ensure that they 
do resolve to the actual cpuinfo_mips of said CPU, such that when you do:

cat /sys/device/system/cpu/cpu*/regs/prid

we do return the actual information of that CPU number, not the one from 
the CPU we are on.

Thanks!
-- 
Florian
