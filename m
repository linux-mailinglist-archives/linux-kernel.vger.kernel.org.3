Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4A44BFF64
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbiBVQzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiBVQzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:55:00 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A0B158EB6;
        Tue, 22 Feb 2022 08:54:35 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id z66so290110qke.10;
        Tue, 22 Feb 2022 08:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CcdY16oA6AEJHhyCwLx6vJhNTGI8QJ+QzSpB8t1ill0=;
        b=Lm9rDh7gw/7aiB+6W42iKUvP8tfWj3lREmLaWJRa/Nfpo3AX9V6cVg0yylDmCEmCqV
         mTG3Ht6w4bbWmcOuDGNlALpznlM9HvxV3hrDszNM1FJk91Ij8ybmOyCIhV2yozbqGCxp
         rGqb9ijbBvMr67n8xvdH6V8xSEw6gHUfMePRmP+d0NgfE/NluJ9u9lHGISdcv8xOjllH
         6acFw+h3DYj1g7xPqAPDCl7mYvLXljQM2k2lSRdHV37oIXPHoeW9kKRRnF6NPLYlygcL
         mCzQhHCuqqMo5ndvltPdKbEdAHgGFXJi73il3OFb3OgEjnChGiKL2ZPT6uwGBqhOB3wB
         6cpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CcdY16oA6AEJHhyCwLx6vJhNTGI8QJ+QzSpB8t1ill0=;
        b=wuDfxw56b5xs0zO+HqCMMBd6IXkzag8YQSqqa7LLxD1krkszSdL/wEGf+eP+J27X1c
         ZfVTHKT68bF1wftRgyxhjQy4HZRKs50jAOU73bj3DP1c/V3ooqMBRZV9XF9NLf3TwBF+
         J+qgfARzPy17Ip4tp+m8godw9Geks2HYk1SxvwOjExRBm6a+6gM8cnvV8zyweBNvJuin
         G5QQUJmHoISmwzngpSAcfd3eVMwBx5T/GxUvPk2B6/252BvQgfMZ3cNdrGFCv+43wPw+
         aL3yjii9u5HQbgCpwtxpIXm32hIagnh266cVlON4BF6VoTg5vQCTwC6hweu/qNMyiQS5
         S8sw==
X-Gm-Message-State: AOAM530it6O/erwRmn5BvwI1/qpnKgu6xkhKnqBphtS79HGmCapZmYAO
        1LD6XvOR8dnXcLvEiqKDPA2q5dOvWCpQTA==
X-Google-Smtp-Source: ABdhPJwt8k/RMr/TJJpH9bdEihTLWOJoPqU2p9KS7pP8nagJkzh/bXCDjpJT+RCZpycVVkWxB6JYPQ==
X-Received: by 2002:a37:b882:0:b0:649:1532:fcbf with SMTP id i124-20020a37b882000000b006491532fcbfmr2717960qkf.151.1645548874136;
        Tue, 22 Feb 2022 08:54:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2sm63456qkf.84.2022.02.22.08.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:54:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 22 Feb 2022 08:54:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, David.Laight@ACULAB.COM,
        linux-hwmon@vger.kernel.org, linux-assembly@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: (dell-smm) Improve assembly code
Message-ID: <20220222165432.GA255373@roeck-us.net>
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

It would be great if I can get some Tested-by/Acked-by/Reviewed-by
tags for this patch.

Thanks,
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
