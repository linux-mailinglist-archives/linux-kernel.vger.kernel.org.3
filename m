Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BC049F078
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345020AbiA1BUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:20:48 -0500
Received: from mail.loongson.cn ([114.242.206.163]:60914 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345001AbiA1BUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:20:46 -0500
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxiuDeRPNh7R0FAA--.15345S3;
        Fri, 28 Jan 2022 09:20:31 +0800 (CST)
Subject: Re: [RFC PATCH] kdump: Add support for crashkernel=auto
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <ptesarik@suse.cz>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1643275911-19489-1-git-send-email-yangtiezhu@loongson.cn>
 <d513dea3-7300-9684-73af-0b51f5f0e572@suse.cz>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f28c65f0-9bbb-6bf8-a223-0e18b861c805@loongson.cn>
Date:   Fri, 28 Jan 2022 09:20:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <d513dea3-7300-9684-73af-0b51f5f0e572@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxiuDeRPNh7R0FAA--.15345S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZry8tw1ruryDGFykGF4kZwb_yoW5ur1fpF
        WUKr4FkryrGryDA348Jws3u3y8tw48Cr9ruwn8Ar18AFnxA3WfGr18Wr43uFW2vr4Y9F1Y
        qw43KwnIga48ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
        Y4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbNzVUUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/27/2022 11:53 PM, Petr Tesařík wrote:
> Hi Tiezhu Yang,
>
> I'm afraid the whole concept is broken by design. See below.
>
> Dne 27. 01. 22 v 10:31 Tiezhu Yang napsal(a):
>> Set the reserved memory automatically for the crash kernel based on
>> architecture.
>>
>> Most code of this patch come from:
>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-8/-/tree/c8s
>>
>
> And that's the problem, I think. The solution might be good for this
> specific OS, but not for others.

Hi Petr,

Thank you for your reply.

This is a RFC patch, the initial aim of this patch is to discuss what is 
the proper way to support crashkernel=auto.

A moment ago, I find the following patch, it is more flexible, but it is 
not merged into the upstream kernel now.

kernel/crash_core: Add crashkernel=auto for vmcore creation

https://lore.kernel.org/lkml/20210223174153.72802-1-saeed.mirzamohammadi@oracle.com/

>
>> [...]
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 256cf6d..32c51e2 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -252,6 +252,26 @@ static int __init __parse_crashkernel(char *cmdline,
>>       if (suffix)
>>           return parse_crashkernel_suffix(ck_cmdline, crash_size,
>>                   suffix);
>> +
>> +    if (strncmp(ck_cmdline, "auto", 4) == 0) {
>> +#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
>> +        ck_cmdline = "1G-4G:160M,4G-64G:192M,64G-1T:256M,1T-:512M";
>> +#elif defined(CONFIG_ARM64)
>> +        ck_cmdline = "2G-:448M";
>> +#elif defined(CONFIG_PPC64)
>> +        char *fadump_cmdline;
>> +
>> +        fadump_cmdline = get_last_crashkernel(cmdline, "fadump=", NULL);
>> +        fadump_cmdline = fadump_cmdline ?
>> +                fadump_cmdline + strlen("fadump=") : NULL;
>> +        if (!fadump_cmdline || (strncmp(fadump_cmdline, "off", 3) == 0))
>> +            ck_cmdline =
>> "2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G";
>> +        else
>> +            ck_cmdline =
>> "4G-16G:768M,16G-64G:1G,64G-128G:2G,128G-1T:4G,1T-2T:6G,2T-4T:12G,4T-8T:20G,8T-16T:36G,16T-32T:64G,32T-64T:128G,64T-:180G";
>>
>> +#endif
>> +        pr_info("Using crashkernel=auto, the size chosen is a best
>> effort estimation.\n");
>> +    }
>> +
>
> How did you even arrive at the above numbers?

Memory requirements for kdump:

https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_monitoring_and_updating_the_kernel/supported-kdump-configurations-and-targets_managing-monitoring-and-updating-the-kernel#memory-requirements-for-kdump_supported-kdump-configurations-and-targets

I've done some research on
> this topic recently (ie. during the last 7 years or so). My x86_64
> system with 8G RAM running openSUSE Leap 15.3 seems needs 188M for
> saving to the local disk, and 203M to save over the network (using
> SFTP). My PPC64 LPAR with 16G RAM running latest Beta of SLES 15 SP4
> needs 587M, i.e. with the above numbers it may run out of memory while
> saving the dump.
>
> Since this is not the first time, I'm trying to explain things, I've
> written a blog post now:
>
> https://sigillatum.tesarici.cz/2022-01-27-whats-wrong-with-crashkernel-auto.html
>

Thank you, this is useful.

Thanks,
Tiezhu

>
> HTH
> Petr Tesarik

