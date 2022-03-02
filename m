Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB214CACF5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244416AbiCBSI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbiCBSI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:08:26 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C843220CB;
        Wed,  2 Mar 2022 10:07:41 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso2797016ooc.12;
        Wed, 02 Mar 2022 10:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J/s4xqCRoWiFmWXpzdAOAxlkHW471J5Hy/uYDHz0d/w=;
        b=JGo4WaorBbqcjTp++mSkoEhTIVI9A4GY6eRo+ydHC3Ijjg633y9/PwTqXe9nGmy4eY
         ZAYBWBwJ75GuA3NvGRfKn1gMonZO5Z5mFWIYvPSSZy+/d1Pl2gKyKKV5w/lhS3Sz8mPG
         jyjjswc6Q6C5jqcQO274YdbbAKy2cDPN5ve5dC44/Vn7KPNsXTP5mcQKXH6qoyzu0+eT
         TYlwuONO+bkgqqDSgeTs4d8JJQToUUk3+rt3z+pT6E5TewVGmGX+H1/AP7fPat+hAAzv
         kxwNPLOo/O3N5C/7hGGiB7bqD9c3TEHT3iQUOXsyBj1WyFhIgMSDXIz97B+4aY+zTXE3
         D7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=J/s4xqCRoWiFmWXpzdAOAxlkHW471J5Hy/uYDHz0d/w=;
        b=5bu2RBvAU5EgqeFvbZNo9aLEA9gFuuIoxh6SkhJjaDLbEYymUVmtu/m1urTKErtrQ2
         rQ9Qd51ny+nQCPuo7vR3ky6US0mqEnsh8RNEXUQOb9WcuWn1Cx5hCSO1qbLQfnbPpTAG
         OMXOkyFCSChFJPDDmp4JRlLT3QFKQ3DrqW5PLy8g203eiHLUEj3McACbTKGZaf2tUXXF
         Jr3Bbbj7ShUBHSJipKAIndhaDp5Lot1QowiJNOIYKq87NvNzeE628dXoGkfRDMqGZhnv
         OFaR6U48QOXBUwtHU1lNVo5YdNtjYqa1XB+qRp8KNWcJo3Dn26YSMHiCC07JY0rXbSso
         Wj2w==
X-Gm-Message-State: AOAM5313bNOSYOMaaDTzCObMRGvHElVQagx5yuHEF5EpayraHL5oHlp0
        HP7ftrEgy4QSEyMkVbqi7gD/uFGEIyg=
X-Google-Smtp-Source: ABdhPJxoGjEyS/1+OJYj+JdipE7YzymuX0KSN+LA/PHHMr2yp/LdeMXKkT1vJHY5zuHipRZz3BkUuA==
X-Received: by 2002:a05:6870:e389:b0:d9:9ecc:1f23 with SMTP id x9-20020a056870e38900b000d99ecc1f23mr891762oad.20.1646244460943;
        Wed, 02 Mar 2022 10:07:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 7-20020a4a1e07000000b002fcc8003c36sm8073887ooq.14.2022.03.02.10.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:07:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Mar 2022 10:07:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, David.Laight@ACULAB.COM,
        linux-hwmon@vger.kernel.org, linux-assembly@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: (dell-smm) Improve assembly code
Message-ID: <20220302180739.GA2523230@roeck-us.net>
References: <20220220190851.17965-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220190851.17965-1-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 08:08:51PM +0100, Armin Wolf wrote:
> The new assembly code works on both 32 bit and 64 bit
> cpus and allows for more compiler optimisations.
> Since clang runs out of registers on 32 bit x86 when
> using CC_OUT, we need to execute "setc" ourself.
> Also modify the debug message so we can still see
> the result (eax) when the carry flag was set.
> 
> Tested with 32 bit and 64 bit kernels on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

I still did not get any Reviewed-by: or Tested-by: tags for this patch.
There was a suggested change (to either set or clear the carry flag
before executing the out instructions) but that would actually change
the behavior of the code and should be implemented as separate patch
to make it easy to revert without impact on this patch if needed.

Unless someone steps up, that leaves this patch (unfortunately) in limbo.

Guenter



> ---
> Changes in v4:
> - reword commit message
> 
> Changes in v3:
> - make carry an unsigned char
> - use "+a", ... for output registers
> - drop "cc" from clobbered list
> 
> Changes in v2:
> - fix clang running out of registers on 32 bit x86
> - modify debug message
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 78 ++++++++--------------------------
>  1 file changed, 18 insertions(+), 60 deletions(-)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index c5939e68586d..38d23a8e83f2 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -119,7 +119,7 @@ struct smm_regs {
>  	unsigned int edx;
>  	unsigned int esi;
>  	unsigned int edi;
> -} __packed;
> +};
> 
>  static const char * const temp_labels[] = {
>  	"CPU",
> @@ -164,74 +164,32 @@ static int i8k_smm_func(void *par)
>  	struct smm_regs *regs = par;
>  	int eax = regs->eax;
>  	int ebx = regs->ebx;
> +	unsigned char carry;
>  	long long duration;
> -	int rc;
> 
>  	/* SMM requires CPU 0 */
>  	if (smp_processor_id() != 0)
>  		return -EBUSY;
> 
> -#if defined(CONFIG_X86_64)
> -	asm volatile("pushq %%rax\n\t"
> -		"movl 0(%%rax),%%edx\n\t"
> -		"pushq %%rdx\n\t"
> -		"movl 4(%%rax),%%ebx\n\t"
> -		"movl 8(%%rax),%%ecx\n\t"
> -		"movl 12(%%rax),%%edx\n\t"
> -		"movl 16(%%rax),%%esi\n\t"
> -		"movl 20(%%rax),%%edi\n\t"
> -		"popq %%rax\n\t"
> -		"out %%al,$0xb2\n\t"
> -		"out %%al,$0x84\n\t"
> -		"xchgq %%rax,(%%rsp)\n\t"
> -		"movl %%ebx,4(%%rax)\n\t"
> -		"movl %%ecx,8(%%rax)\n\t"
> -		"movl %%edx,12(%%rax)\n\t"
> -		"movl %%esi,16(%%rax)\n\t"
> -		"movl %%edi,20(%%rax)\n\t"
> -		"popq %%rdx\n\t"
> -		"movl %%edx,0(%%rax)\n\t"
> -		"pushfq\n\t"
> -		"popq %%rax\n\t"
> -		"andl $1,%%eax\n"
> -		: "=a"(rc)
> -		:    "a"(regs)
> -		:    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
> -#else
> -	asm volatile("pushl %%eax\n\t"
> -	    "movl 0(%%eax),%%edx\n\t"
> -	    "push %%edx\n\t"
> -	    "movl 4(%%eax),%%ebx\n\t"
> -	    "movl 8(%%eax),%%ecx\n\t"
> -	    "movl 12(%%eax),%%edx\n\t"
> -	    "movl 16(%%eax),%%esi\n\t"
> -	    "movl 20(%%eax),%%edi\n\t"
> -	    "popl %%eax\n\t"
> -	    "out %%al,$0xb2\n\t"
> -	    "out %%al,$0x84\n\t"
> -	    "xchgl %%eax,(%%esp)\n\t"
> -	    "movl %%ebx,4(%%eax)\n\t"
> -	    "movl %%ecx,8(%%eax)\n\t"
> -	    "movl %%edx,12(%%eax)\n\t"
> -	    "movl %%esi,16(%%eax)\n\t"
> -	    "movl %%edi,20(%%eax)\n\t"
> -	    "popl %%edx\n\t"
> -	    "movl %%edx,0(%%eax)\n\t"
> -	    "lahf\n\t"
> -	    "shrl $8,%%eax\n\t"
> -	    "andl $1,%%eax\n"
> -	    : "=a"(rc)
> -	    :    "a"(regs)
> -	    :    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
> -#endif
> -	if (rc != 0 || (regs->eax & 0xffff) == 0xffff || regs->eax == eax)
> -		rc = -EINVAL;
> +	asm volatile("out %%al,$0xb2\n\t"
> +		     "out %%al,$0x84\n\t"
> +		     "setc %0\n"
> +		     : "=mr" (carry),
> +		       "+a" (regs->eax),
> +		       "+b" (regs->ebx),
> +		       "+c" (regs->ecx),
> +		       "+d" (regs->edx),
> +		       "+S" (regs->esi),
> +		       "+D" (regs->edi));
> 
>  	duration = ktime_us_delta(ktime_get(), calltime);
> -	pr_debug("smm(0x%.4x 0x%.4x) = 0x%.4x  (took %7lld usecs)\n", eax, ebx,
> -		 (rc ? 0xffff : regs->eax & 0xffff), duration);
> +	pr_debug("smm(0x%.4x 0x%.4x) = 0x%.4x carry: %d (took %7lld usecs)\n",
> +		 eax, ebx, regs->eax & 0xffff, carry, duration);
> 
> -	return rc;
> +	if (carry || (regs->eax & 0xffff) == 0xffff || regs->eax == eax)
> +		return -EINVAL;
> +
> +	return 0;
>  }
> 
>  /*
