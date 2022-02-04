Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5EA4A93A8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243460AbiBDFe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:34:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32972 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242596AbiBDFe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:34:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8F6B81F44F;
        Fri,  4 Feb 2022 05:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643952865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNw+nGjUHDQakYjw3+X14IyzO2Y8Kr9oAu13SBRPZf4=;
        b=mv4ilpe30xcinrhAii9WR96Si9esfs3AkBWai7WTMb3HbunWBhSRLv2GF7nH5tRZbmNT00
        yVjXuaoQUPJ7k+ft1slrny0eplOAXPA06laML6OnKFa5rqfYEpKlFJ/KPnM3Yd+ePvZjBY
        WD/y9Z6h4Z89dGeHCMkUwOWoXGdYuJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643952865;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNw+nGjUHDQakYjw3+X14IyzO2Y8Kr9oAu13SBRPZf4=;
        b=q32YkSqxNNYQ8u8Z1bW3VUk6APdAzWtpSZOJNVoqOF8n7PKmL1le/BosU1SBiqCmcje89s
        75tEYe1+r9xHj7Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 531A11331A;
        Fri,  4 Feb 2022 05:34:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /dgnE+G6/GFIJwAAMHmgww
        (envelope-from <ptesarik@suse.cz>); Fri, 04 Feb 2022 05:34:25 +0000
Message-ID: <e58be621-be9f-ea10-502c-82b95bee63e4@suse.cz>
Date:   Fri, 4 Feb 2022 06:34:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <ptesarik@suse.cz>
Content-Language: en-GB
To:     Philipp Rudo <prudo@redhat.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1643275911-19489-1-git-send-email-yangtiezhu@loongson.cn>
 <d513dea3-7300-9684-73af-0b51f5f0e572@suse.cz>
 <f28c65f0-9bbb-6bf8-a223-0e18b861c805@loongson.cn>
 <ba065272-78bd-65d0-1e76-08455519b6db@suse.cz>
 <20220131113351.49a47caf@rhtmp>
Subject: Re: [RFC PATCH] kdump: Add support for crashkernel=auto
In-Reply-To: <20220131113351.49a47caf@rhtmp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Dne 31. 01. 22 v 11:33 Philipp Rudo napsal(a):
> Hi,
> 
> On Fri, 28 Jan 2022 11:31:49 +0100
> Petr Tesařík <ptesarik@suse.cz> wrote:
> 
>> Hi Tiezhu Yang,
>>
>> On Jan 28, 2022 at 02:20 Tiezhu Yang wrote:
>>> [...]
>>> Hi Petr,
>>>
>>> Thank you for your reply.
>>>
>>> This is a RFC patch, the initial aim of this patch is to discuss what is
>>> the proper way to support crashkernel=auto.
>>
>> Well, the point I'm trying to make is that crashkernel=auto cannot be
>> implemented. Your code would have to know what happens in the future,
>> and AFAIK time travel has not been discovered yet. ;-)
>>
>> A better approach is to make a very large allocation initially, e.g.
>> half of available RAM. The remaining RAM should still be big enough to
>> start booting the system. Later, when a kdump user-space service knows
>> what it wants to load, it can shrink the reservation by writing a lower
>> value into /sys/kernel/kexec_crash_size.
> 
> Even this approach doesn't work in every situation. For example it
> requires that the system has at least twice the RAM it requires to
> safely boot. That's not always given for e.g minimalistic VMs or
> embedded systems.

If you reserve more RAM for the panic kernel than for running your 
actual workload, then you definitely have very special needs, and you 
should not expect that everything works out of the box.

> Furthermore the memory requirement can also change during runtime due
> to, e.g. workload spikes, device hot plug, moving the dump target from
> an un-encrypted to an encrypted disk, etc.. So even when your user-space
> program can exactly calculate the memory requirement at the moment
> it loads kdump it might be too little at the moment the system panics.
> In order for it to work the user-space would constantly need to monitor
> how much memory is needed and adjust the requirement. But that would
> also require to increase the reservation during runtime which would be
> extremely expensive (if possible at all).
> 
> All in all I support Petr that time travel is the only proper solution
> for implementing crashkernel=auto. But once we have time travel I
> would prefer to use the gained knowledge to fix the bug that triggered
> the panic rather than calculating the memory requirement for kdump.

Yeah, long live patching! :-)

>> The alternative approach does not need any changes to the kernel, except
>> maybe adding something like "crashkernel=max".
> 
> A slightly different approach is for the user-space tool to simply set
> the crashkernel= parameter on the kernel commandline for the next boot.
> This also works for memory restrained systems. Needs a reboot though...

The downside is that if you remove some memory while your system is off, 
then a reservation calculate for the previous RAM size may no longer be 
possible on the next boot, and the kernel will boot up without any 
reservation. That's where "crashkernel=max" would come in handy. Let me 
send a patch and see the discussion.

Petr T

>>> A moment ago, I find the following patch, it is more flexible, but it is
>>> not merged into the upstream kernel now.
>>>
>>> kernel/crash_core: Add crashkernel=auto for vmcore creation
>>>
>>> https://lore.kernel.org/lkml/20210223174153.72802-1-saeed.mirzamohammadi@oracle.com/
> 
> The patch was ultimately rejected by Linus
> 
> https://lore.kernel.org/linux-mm/20210507010432.IN24PudKT%25akpm@linux-foundation.org/
> 
> Thanks
> Philipp
> 
>>>    
>>>>   
>>>>> [...]
>>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>>> index 256cf6d..32c51e2 100644
>>>>> --- a/kernel/crash_core.c
>>>>> +++ b/kernel/crash_core.c
>>>>> @@ -252,6 +252,26 @@ static int __init __parse_crashkernel(char
>>>>> *cmdline,
>>>>>        if (suffix)
>>>>>            return parse_crashkernel_suffix(ck_cmdline, crash_size,
>>>>>                    suffix);
>>>>> +
>>>>> +    if (strncmp(ck_cmdline, "auto", 4) == 0) {
>>>>> +#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
>>>>> +        ck_cmdline = "1G-4G:160M,4G-64G:192M,64G-1T:256M,1T-:512M";
>>>>> +#elif defined(CONFIG_ARM64)
>>>>> +        ck_cmdline = "2G-:448M";
>>>>> +#elif defined(CONFIG_PPC64)
>>>>> +        char *fadump_cmdline;
>>>>> +
>>>>> +        fadump_cmdline = get_last_crashkernel(cmdline, "fadump=",
>>>>> NULL);
>>>>> +        fadump_cmdline = fadump_cmdline ?
>>>>> +                fadump_cmdline + strlen("fadump=") : NULL;
>>>>> +        if (!fadump_cmdline || (strncmp(fadump_cmdline, "off", 3) ==
>>>>> 0))
>>>>> +            ck_cmdline =
>>>>> "2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G";
>>>>> +        else
>>>>> +            ck_cmdline =
>>>>> "4G-16G:768M,16G-64G:1G,64G-128G:2G,128G-1T:4G,1T-2T:6G,2T-4T:12G,4T-8T:20G,8T-16T:36G,16T-32T:64G,32T-64T:128G,64T-:180G";
>>>>>
>>>>>
>>>>> +#endif
>>>>> +        pr_info("Using crashkernel=auto, the size chosen is a best
>>>>> effort estimation.\n");
>>>>> +    }
>>>>> +
>>>>
>>>> How did you even arrive at the above numbers?
>>>
>>> Memory requirements for kdump:
>>>
>>> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_monitoring_and_updating_the_kernel/supported-kdump-configurations-and-targets_managing-monitoring-and-updating-the-kernel#memory-requirements-for-kdump_supported-kdump-configurations-and-targets
>>>
>>>
>>> I've done some research on
>>>> this topic recently (ie. during the last 7 years or so). My x86_64
>>>> system with 8G RAM running openSUSE Leap 15.3 seems needs 188M for
>>>> saving to the local disk, and 203M to save over the network (using
>>>> SFTP). My PPC64 LPAR with 16G RAM running latest Beta of SLES 15 SP4
>>>> needs 587M, i.e. with the above numbers it may run out of memory while
>>>> saving the dump.
>>>>
>>>> Since this is not the first time, I'm trying to explain things, I've
>>>> written a blog post now:
>>>>
>>>> https://sigillatum.tesarici.cz/2022-01-27-whats-wrong-with-crashkernel-auto.html
>>>>
>>>>   
>>>
>>> Thank you, this is useful.
>>>
>>> Thanks,
>>> Tiezhu
>>>    
>>>>
>>>> HTH
>>>> Petr Tesarik
>>>
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
