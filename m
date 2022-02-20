Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BEA4BCF6A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiBTPac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:30:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiBTPa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:30:26 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8CA4E39C;
        Sun, 20 Feb 2022 07:30:05 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q5so8432550oij.6;
        Sun, 20 Feb 2022 07:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v9yDxdXjwfjcEmcv6Q/zczMsjG6fgA4wk/0Tx7xP4sI=;
        b=VTR+1+ba8QimGg/EB+ymwC2T9QsjGhjmRL6ovuUPN6kP0SriqXjo+4hPkFKzZ77HoZ
         szTVyzhp8ly4R5KMheLHsUtEpwyn49rKDEE1qS5BhDcGbaXgpBQZdFxF6pFcw4EXZE3D
         CdaWZllJIgMu0vVdidOmWzqlyxry/CZMcLVHDw0XvDOd/08WA0BHHXW9V+c6KejzNNUz
         jzfCcmUtADW272OqxkUkVNzSzzYDKg6iGVmXSHrs+0Na87vi6Yti3FvwArZ0VSW1C737
         5tfODeTf98+O6Uv8fFXA0P+2XROJFZubNsCxmBX5T36QFfwXJT+Lp5OgPL6w71sf6HJ3
         4EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v9yDxdXjwfjcEmcv6Q/zczMsjG6fgA4wk/0Tx7xP4sI=;
        b=Ipm/MOprtvXOvlmzP3X9zEAYwZ8qoDZaFLuDpagsQoklirYusYbVAftcrY8qxzy69h
         9NAvE4KucEJMFne6IX+ILadbrO16pDeb+2uozQkzWtJKXoDPiefV2uDRK6XX6OB4Gvu7
         Dd9NccftU6EeZ0IovJPE71RB2Qy4Q/nj5419Gb7zkiL5/+hhIVm72bs6XiqC1BZDWIBf
         ZbENp5HubXj8n+bLaRV6d//45ErySb9tYv62kQB7FTidD/4gxu0W45Il4QORS871iyBk
         i3xbPHvGuDt8HD9OotkvPCjI4eREC2N9pvpT+FAD/V1sysV7kxdDwGJWOop6OQFeKiiD
         erXA==
X-Gm-Message-State: AOAM531RPDGC+qvn86Zp1y8cJD4Xhjx34fXgnElAxHDqel6eVTa8NQE0
        rldsBZvf8+XuPVMPy5TaoLE=
X-Google-Smtp-Source: ABdhPJyR+bX5VZ+syJd8ZHj/h8NztoAD3ZKegIwwy3YXx8xIVyUo7wJTOXMgM4mdO2KfGmc7k3dSrg==
X-Received: by 2002:a05:6808:11c4:b0:2d4:9b19:6940 with SMTP id p4-20020a05680811c400b002d49b196940mr5895550oiv.199.1645371004879;
        Sun, 20 Feb 2022 07:30:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id be19sm5921088oib.31.2022.02.20.07.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 07:30:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7d387f96-1561-2eec-43e2-b971ff79d734@roeck-us.net>
Date:   Sun, 20 Feb 2022 07:30:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] hwmon: (dell-smm) Improve assembly code
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Armin Wolf' <W_Armin@gmx.de>,
        "pali@kernel.org" <pali@kernel.org>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-assembly@vger.kernel.org" <linux-assembly@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220219211011.16600-1-W_Armin@gmx.de>
 <d66ab183f32c49b2b901b432d284edc5@AcuMS.aculab.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <d66ab183f32c49b2b901b432d284edc5@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/22 04:20, David Laight wrote:
> From: Armin Wolf
>> Sent: 19 February 2022 21:10
>>
>> The new assembly code works on both 32 bit and 64 bit
>> cpus and allows for more compiler optimisations by not
>> requiring smm_regs to be packed. Also since the
>> SMM handler seems to modify the carry flag, the new
>> code informs the compiler that the flags register
>> needs to be saved/restored. Since clang runs out of
>> registers on 32 bit x86 when using CC_OUT, we need
>> to execute "setc" ourself.
> 
> You always need to save anything from the flags register
> inside the asm block - it is never valit afterwards.
> 

Does that matter here ? I thought setcc is used to get the carry flag.

Guenter

>> Also modify the debug message so we can still see
>> the result (eax) when the carry flag was set.
>>
>> Tested with 32 bit and 64 bit kernels on a Dell Inspiron 3505.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>> Changes in v2:
>> - fix clang running out of registers on 32 bit x86
>> - modify debug message
>> ---
>>   drivers/hwmon/dell-smm-hwmon.c | 85 ++++++++++------------------------
>>   1 file changed, 25 insertions(+), 60 deletions(-)
>>
>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
>> index c5939e68586d..f1538a46bfc9 100644
>> --- a/drivers/hwmon/dell-smm-hwmon.c
>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>> @@ -119,7 +119,7 @@ struct smm_regs {
>>   	unsigned int edx;
>>   	unsigned int esi;
>>   	unsigned int edi;
>> -} __packed;
>> +};
>>
>>   static const char * const temp_labels[] = {
>>   	"CPU",
>> @@ -165,73 +165,38 @@ static int i8k_smm_func(void *par)
>>   	int eax = regs->eax;
>>   	int ebx = regs->ebx;
>>   	long long duration;
>> -	int rc;
>> +	bool carry;
> 
> I'd use an explicit 'unsigned char' not bool.
> Matches the type of the 'setcc' instriction.
> 
>>   	/* SMM requires CPU 0 */
>>   	if (smp_processor_id() != 0)
>>   		return -EBUSY;
>>
>> -#if defined(CONFIG_X86_64)
>> -	asm volatile("pushq %%rax\n\t"
>> -		"movl 0(%%rax),%%edx\n\t"
>> -		"pushq %%rdx\n\t"
>> -		"movl 4(%%rax),%%ebx\n\t"
>> -		"movl 8(%%rax),%%ecx\n\t"
>> -		"movl 12(%%rax),%%edx\n\t"
>> -		"movl 16(%%rax),%%esi\n\t"
>> -		"movl 20(%%rax),%%edi\n\t"
>> -		"popq %%rax\n\t"
>> -		"out %%al,$0xb2\n\t"
>> -		"out %%al,$0x84\n\t"
>> -		"xchgq %%rax,(%%rsp)\n\t"
>> -		"movl %%ebx,4(%%rax)\n\t"
>> -		"movl %%ecx,8(%%rax)\n\t"
>> -		"movl %%edx,12(%%rax)\n\t"
>> -		"movl %%esi,16(%%rax)\n\t"
>> -		"movl %%edi,20(%%rax)\n\t"
>> -		"popq %%rdx\n\t"
>> -		"movl %%edx,0(%%rax)\n\t"
>> -		"pushfq\n\t"
>> -		"popq %%rax\n\t"
>> -		"andl $1,%%eax\n"
>> -		: "=a"(rc)
>> -		:    "a"(regs)
>> -		:    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
>> -#else
>> -	asm volatile("pushl %%eax\n\t"
>> -	    "movl 0(%%eax),%%edx\n\t"
>> -	    "push %%edx\n\t"
>> -	    "movl 4(%%eax),%%ebx\n\t"
>> -	    "movl 8(%%eax),%%ecx\n\t"
>> -	    "movl 12(%%eax),%%edx\n\t"
>> -	    "movl 16(%%eax),%%esi\n\t"
>> -	    "movl 20(%%eax),%%edi\n\t"
>> -	    "popl %%eax\n\t"
>> -	    "out %%al,$0xb2\n\t"
>> -	    "out %%al,$0x84\n\t"
>> -	    "xchgl %%eax,(%%esp)\n\t"
>> -	    "movl %%ebx,4(%%eax)\n\t"
>> -	    "movl %%ecx,8(%%eax)\n\t"
>> -	    "movl %%edx,12(%%eax)\n\t"
>> -	    "movl %%esi,16(%%eax)\n\t"
>> -	    "movl %%edi,20(%%eax)\n\t"
>> -	    "popl %%edx\n\t"
>> -	    "movl %%edx,0(%%eax)\n\t"
>> -	    "lahf\n\t"
>> -	    "shrl $8,%%eax\n\t"
>> -	    "andl $1,%%eax\n"
>> -	    : "=a"(rc)
>> -	    :    "a"(regs)
>> -	    :    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
>> -#endif
>> -	if (rc != 0 || (regs->eax & 0xffff) == 0xffff || regs->eax == eax)
>> -		rc = -EINVAL;
>> +	asm volatile("out %%al,$0xb2\n\t"
>> +		     "out %%al,$0x84\n\t"
>> +		     "setc %0\n"
>> +		     : "=mr" (carry),
>> +		       "=a" (regs->eax),
>> +		       "=b" (regs->ebx),
>> +		       "=c" (regs->ecx),
>> +		       "=d" (regs->edx),
>> +		       "=S" (regs->esi),
>> +		       "=D" (regs->edi)
>> +		     : "a" (regs->eax),
>> +		       "b" (regs->ebx),
>> +		       "c" (regs->ecx),
>> +		       "d" (regs->edx),
>> +		       "S" (regs->esi),
>> +		       "D" (regs->edi)
> 
> If you use "+a" (etc) for the output registers you don't
> need to respecify them as input registers.
> 
>> +		     : "cc");
> 
> No need to specify "cc", it is always assumed clobbered.
> 
> 	David
> 
>>
>>   	duration = ktime_us_delta(ktime_get(), calltime);
>> -	pr_debug("smm(0x%.4x 0x%.4x) = 0x%.4x  (took %7lld usecs)\n", eax, ebx,
>> -		 (rc ? 0xffff : regs->eax & 0xffff), duration);
>> +	pr_debug("smm(0x%.4x 0x%.4x) = 0x%.4x carry: %d (took %7lld usecs)\n",
>> +		 eax, ebx, regs->eax & 0xffff, carry, duration);
>>
>> -	return rc;
>> +	if (carry || (regs->eax & 0xffff) == 0xffff || regs->eax == eax)
>> +		return -EINVAL;
>> +
>> +	return 0;
>>   }
>>
>>   /*
>> --
>> 2.30.2
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

