Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948544C5E8F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiB0U0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiB0UZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:25:58 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C70356C0D;
        Sun, 27 Feb 2022 12:25:21 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id l25so11660616oic.13;
        Sun, 27 Feb 2022 12:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3oGq/WbLwmz7KN3XbETWGjhz7d0eJO8ekg3r1g92xVY=;
        b=UrEewe4onucaK+Jmd2kil3s4UgXpFqfBdMVPHI/zmBE2fvga0MW4AMTiAh9DIVwRUn
         /1CTuW47xVeJqrODcoccJP7UmHU7OWM+IroE8fcI9a1khpa8VgZiIONvZepNwbHVOpop
         eakmhnKZLYV7Zll+sFvcgme5wqAN6WG3cIm1eZ5yAa1IGUE0O9shtAjCwpuZez1g850K
         WiHeFOAWjeINSfg465Hvd6N0bviOyaT4tGtpUxfAanpTTDn8y3YSlm+V0L3m1C24cWWq
         IEvCyxwqtuU01y7A/PMFXu/wuQo4voEyUNv8HkrXRY8Qs1Gvvu9y/ecCeJE6GoUDCBtK
         QPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3oGq/WbLwmz7KN3XbETWGjhz7d0eJO8ekg3r1g92xVY=;
        b=npm6qa9mOrh0sBPmtIuKYFD3SIC6++21UqLcSYX3FQBTK1HePZOjvsVMQ/ftumAnic
         jYdRlGQjQAqb93q/wP31ZSjf9raU0KHXxvQw879xj5Xqsi5jmKqplrC3dw+cNsbAQq//
         w9LBtpRJLS3rtfj9OaQswPkag8eTgu+Hr/yUcVuaxe4FKYLPsQj27g31jktlbFHnvDi+
         +yju7HZgX37u+xW20SgU6A0eJV8+PRSLF4T1+dALF6x2bM5QXOs1c8EEW9Gskok1Ip1c
         SRfRCjzuXoKydJWWAW/vCpOGKUkUAv/hZ5rE8ZsXWDrI6kAi64RA64DxSJOY22LTh0xn
         9LJg==
X-Gm-Message-State: AOAM531O7ZGpXArxCrbDJd4MaJKsYa0LAU349HyxAFx0OleRDWkv6ptm
        IxV4Y4EP6hS5zkGuvl2YkB62C7UpRJE=
X-Google-Smtp-Source: ABdhPJyQFTQUgKf61NsB+1VVQG3RALfP83rLJe5Ud+V8V03vU/HuGqFOK7XfGM7CXyUB8sWNVPvFlQ==
X-Received: by 2002:a05:6808:114e:b0:2d5:4101:844e with SMTP id u14-20020a056808114e00b002d54101844emr8500979oiu.169.1645993520557;
        Sun, 27 Feb 2022 12:25:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a10-20020a056808120a00b002d404a71444sm4907333oil.35.2022.02.27.12.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 12:25:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7d08c2e4-61f8-af0c-1653-fcd4cd494557@roeck-us.net>
Date:   Sun, 27 Feb 2022 12:25:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] x86/boot: Wrap literal addresses in absolute_pointer()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220227195918.705219-1-keescook@chromium.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220227195918.705219-1-keescook@chromium.org>
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

On 2/27/22 11:59, Kees Cook wrote:
> GCC 11 (incorrectly[1]) assumes that literal values cast to (void *)
> should be treated like a NULL pointer with an offset, and raises
> diagnostics when doing bounds checking under -Warray-bounds. GCC 12
> got "smarter" about finding these:
> 
> In function 'rdfs8',
>      inlined from 'vga_recalc_vertical' at /srv/code/arch/x86/boot/video-mode.c:124:29,
>      inlined from 'set_mode' at /srv/code/arch/x86/boot/video-mode.c:163:3:
> /srv/code/arch/x86/boot/boot.h:114:9: warning: array subscript 0 is outside array bounds of 'u8[0]' {aka 'unsigned char[]'} [-Warray-bounds]
>    114 |         asm volatile("movb %%fs:%1,%0" : "=q" (v) : "m" (*(u8 *)addr));
>        |         ^~~
> 
> This has been solved in other places[2] already by using the recently
> added absolute_pointer() macro. Do the same here.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
> [2] https://lore.kernel.org/all/20210912160149.2227137-1-linux@roeck-us.net/
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: x86@kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/x86/boot/boot.h | 36 ++++++++++++++++++++++++------------
>   arch/x86/boot/main.c |  2 +-
>   2 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
> index 34c9dbb6a47d..686a9d75a0e4 100644
> --- a/arch/x86/boot/boot.h
> +++ b/arch/x86/boot/boot.h
> @@ -110,66 +110,78 @@ typedef unsigned int addr_t;
>   
>   static inline u8 rdfs8(addr_t addr)
>   {
> +	u8 *ptr = (u8 *)absolute_pointer(addr);
>   	u8 v;
> -	asm volatile("movb %%fs:%1,%0" : "=q" (v) : "m" (*(u8 *)addr));
> +	asm volatile("movb %%fs:%1,%0" : "=q" (v) : "m" (*ptr));
>   	return v;
>   }
>   static inline u16 rdfs16(addr_t addr)
>   {
> +	u16 *ptr = (u16 *)absolute_pointer(addr);
>   	u16 v;
> -	asm volatile("movw %%fs:%1,%0" : "=r" (v) : "m" (*(u16 *)addr));
> +	asm volatile("movw %%fs:%1,%0" : "=r" (v) : "m" (*ptr));
>   	return v;
>   }
>   static inline u32 rdfs32(addr_t addr)
>   {
> +	u32 *ptr = (u32 *)absolute_pointer(addr);
>   	u32 v;
> -	asm volatile("movl %%fs:%1,%0" : "=r" (v) : "m" (*(u32 *)addr));
> +	asm volatile("movl %%fs:%1,%0" : "=r" (v) : "m" (*ptr));
>   	return v;
>   }
>   
>   static inline void wrfs8(u8 v, addr_t addr)
>   {
> -	asm volatile("movb %1,%%fs:%0" : "+m" (*(u8 *)addr) : "qi" (v));
> +	u8 *ptr = (u8 *)absolute_pointer(addr);
> +	asm volatile("movb %1,%%fs:%0" : "+m" (*ptr) : "qi" (v));
>   }
>   static inline void wrfs16(u16 v, addr_t addr)
>   {
> -	asm volatile("movw %1,%%fs:%0" : "+m" (*(u16 *)addr) : "ri" (v));
> +	u16 *ptr = (u16 *)absolute_pointer(addr);
> +	asm volatile("movw %1,%%fs:%0" : "+m" (*ptr) : "ri" (v));
>   }
>   static inline void wrfs32(u32 v, addr_t addr)
>   {
> -	asm volatile("movl %1,%%fs:%0" : "+m" (*(u32 *)addr) : "ri" (v));
> +	u32 *ptr = (u32 *)absolute_pointer(addr);
> +	asm volatile("movl %1,%%fs:%0" : "+m" (*ptr) : "ri" (v));
>   }
>   
>   static inline u8 rdgs8(addr_t addr)
>   {
> +	u8 *ptr = (u8 *)absolute_pointer(addr);
>   	u8 v;
> -	asm volatile("movb %%gs:%1,%0" : "=q" (v) : "m" (*(u8 *)addr));
> +	asm volatile("movb %%gs:%1,%0" : "=q" (v) : "m" (*ptr));
>   	return v;
>   }
>   static inline u16 rdgs16(addr_t addr)
>   {
> +	u16 *ptr = (u16 *)absolute_pointer(addr);
>   	u16 v;
> -	asm volatile("movw %%gs:%1,%0" : "=r" (v) : "m" (*(u16 *)addr));
> +	asm volatile("movw %%gs:%1,%0" : "=r" (v) : "m" (*ptr));
>   	return v;
>   }
>   static inline u32 rdgs32(addr_t addr)
>   {
> +	u32 *ptr = (u32 *)absolute_pointer(addr);
>   	u32 v;
> -	asm volatile("movl %%gs:%1,%0" : "=r" (v) : "m" (*(u32 *)addr));
> +	asm volatile("movl %%gs:%1,%0" : "=r" (v) : "m" (*ptr));
>   	return v;
>   }
>   
>   static inline void wrgs8(u8 v, addr_t addr)
>   {
> -	asm volatile("movb %1,%%gs:%0" : "+m" (*(u8 *)addr) : "qi" (v));
> +	u8 *ptr = (u8 *)absolute_pointer(addr);
> +	asm volatile("movb %1,%%gs:%0" : "+m" (*ptr) : "qi" (v));
>   }
>   static inline void wrgs16(u16 v, addr_t addr)
>   {
> -	asm volatile("movw %1,%%gs:%0" : "+m" (*(u16 *)addr) : "ri" (v));
> +	u16 *ptr = (u16 *)absolute_pointer(addr);
> +	asm volatile("movw %1,%%gs:%0" : "+m" (*ptr) : "ri" (v));
>   }
>   static inline void wrgs32(u32 v, addr_t addr)
>   {
> -	asm volatile("movl %1,%%gs:%0" : "+m" (*(u32 *)addr) : "ri" (v));
> +	u32 *ptr = (u32 *)absolute_pointer(addr);
> +	asm volatile("movl %1,%%gs:%0" : "+m" (*ptr) : "ri" (v));
>   }
>   
>   /* Note: these only return true/false, not a signed return value! */
> diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
> index e3add857c2c9..c421af5a3cdc 100644
> --- a/arch/x86/boot/main.c
> +++ b/arch/x86/boot/main.c
> @@ -33,7 +33,7 @@ static void copy_boot_params(void)
>   		u16 cl_offset;
>   	};
>   	const struct old_cmdline * const oldcmd =
> -		(const struct old_cmdline *)OLD_CL_ADDRESS;
> +		absolute_pointer(OLD_CL_ADDRESS);
>   
>   	BUILD_BUG_ON(sizeof(boot_params) != 4096);
>   	memcpy(&boot_params.hdr, &hdr, sizeof(hdr));

