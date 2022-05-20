Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59F052EDB9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350075AbiETODj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiETODh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:03:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950E67A466
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:03:36 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d22so7430823plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=063ezhYK00oOD0O3np9MiZov9T9NDQ8sKKbZLJUDrOo=;
        b=g34MOi6WvBE4sRpeu+nVW+KFx0yeRu32UQPhpVqRrLOEKzKteO0A5U12rD4yPBsFJ5
         gE+zVhXnE7a4gIgAo16AVLBybluAyEdh15CiR7zbr5iBZmf6QJnsYwwpNCT7GiDP6gm3
         hUsxWXOvCj5PJk6SO0UNXUCrR2KxEKGwW6dvlrbqFEuCXKRZyNVFuuzTnQ10fHsor6Vx
         81sLl1sOiaRdCITzLAZJNpNqS+KjKaP5MtcopakGZmEoxyQjK2WSSJMmIop0VMzULlxC
         AkEvRHJqUS105dYac0LjIggKvmFMnNmicl/0+igpG1nsqHqyTW0r+8odj/1urDB3kWWj
         2YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=063ezhYK00oOD0O3np9MiZov9T9NDQ8sKKbZLJUDrOo=;
        b=L6bR2sQp72EAfvvwZY1l0VmsssT0udiaOTBcUc2+vm8eLBdgGkD4OZ1Ka/tDyStOnv
         aMmyNE3oDBHW4GY8ZAnhQsyKL1bMM90b5/YMz1HpIzBvLpVz5NK+kpaaRv+3d0ooL8IY
         IjZlZFC8kY8nTg682HpeGoq2LUSuIfOrs48EGygzEngJffSZpdGVOKMH2ZLekzlOR88V
         jdLVVQthWYKWz4DVpnhpZaxATdH71tzXzU7d1XXG6cJtS36M5WUty+Nn8qqHchpR97iq
         zf7W/q2c8VMNKgpbgYP5DIyo2qqh/Wg1ja42XQkDRAXn4nFe9MrfSspD1OjK9jIDQm8Q
         /xFQ==
X-Gm-Message-State: AOAM532yCskMLOwliHqAaO17t9MqknXDwnqWgX+tN04fxOonZFZH6FDd
        2ptRL/hug2MMuK3iX8zSG1o=
X-Google-Smtp-Source: ABdhPJx1UsxBJb9YvmtVDDe83XBjCxoa8QrYDWEtlAtlKAxuJPm0ogO9XMOBgA3X2lLAsgHjs1ZYIA==
X-Received: by 2002:a17:90b:1a8c:b0:1dc:1c62:2c0c with SMTP id ng12-20020a17090b1a8c00b001dc1c622c0cmr11833310pjb.140.1653055416080;
        Fri, 20 May 2022 07:03:36 -0700 (PDT)
Received: from [192.168.0.103] ([106.51.243.174])
        by smtp.gmail.com with ESMTPSA id s7-20020a056a001c4700b0050dc76281dcsm1817607pfw.182.2022.05.20.07.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:03:35 -0700 (PDT)
Message-ID: <f05264ce-e90f-0b1a-4796-ec1f3b75c09c@gmail.com>
Date:   Fri, 20 May 2022 19:33:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v1] x86/vmware: use unsigned integer for shifting
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     srivatsa@csail.mit.edu, amakhalov@vmware.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Shreenidhi Shedi <sshedi@vmware.com>
References: <20220520114712.595583-1-sshedi@vmware.com>
 <YoeA4pf5OWxfjE0J@zn.tnic>
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <YoeA4pf5OWxfjE0J@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/22 5:22 pm, Borislav Petkov wrote:
> On Fri, May 20, 2022 at 05:17:12PM +0530, Shreenidhi Shedi wrote:
>> Shifting signed 32-bit value by 31 bits is implementation-defined
>> behaviour. Using unsigned is better option for this.
>>
>> Fixes: 4cca6ea04d31 ("x86/apic: Allow x2apic without IR on VMware platform")
>>
>> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
>> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
> 
> This is not how this is done - you need to set your author email
> properly in git so that it adds your From: ... @vmware.com> instead of
> having two SOBs.
> 

I deliberately did it because I was lacking clarity on using my org mail & personal mail id.
Thanks Srivatsa for the help and making things clear on this.

>> ---
>>  arch/x86/kernel/cpu/vmware.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
>> index c04b933f48d3..7f44ea073436 100644
>> --- a/arch/x86/kernel/cpu/vmware.c
>> +++ b/arch/x86/kernel/cpu/vmware.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/cpu.h>
>>  #include <linux/reboot.h>
>>  #include <linux/static_call.h>
>> +#include <linux/bits.h>
>>  #include <asm/div64.h>
>>  #include <asm/x86_init.h>
>>  #include <asm/hypervisor.h>
>> @@ -476,8 +477,8 @@ static bool __init vmware_legacy_x2apic_available(void)
>>  {
>>  	uint32_t eax, ebx, ecx, edx;
>>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
>> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
>> -	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
>> +	return (eax & BIT(VMWARE_CMD_VCPU_RESERVED)) == 0 &&
>> +	       (eax & BIT(VMWARE_CMD_LEGACY_X2APIC)) != 0;
> 						    ^^^^^^^^
> 
> You did hurry too much with sending a new version.
> 

Oops :(
