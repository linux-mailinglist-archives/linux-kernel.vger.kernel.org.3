Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53D15132ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345799AbiD1L7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbiD1L7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:59:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBB4888D8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:55:54 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k14so3829782pga.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nNaL4oWbSaoZkugEaXO//WHohZesy6t6T5egzcvNBJU=;
        b=UE5paQOXIHvF+isxo/nkvMlIFVMoOhZoeSphPe2amLG90ZyGcyfxpF4r3SAfjM3I3l
         FSYZoVv6EmF4O+hzZ60QiNtYcspZ6TeKJAQsXgKt7PBF7yzn9IpVuWAbQ4TKvgAlrRRR
         tJHf/NwVNB+it9VNHHhpIpA99ZfIfetWmM6au/TMlwiZizoHaLGf5eQOwUwViLrN7vpN
         yR8tqWZCedbNBJt5wGh+Zw2Rg35LZgIpwIArw3gZtoARF0DZlPZHGyLrIaQLJAwqM0PK
         AHUPTFgemhWKs6bzsmiZi0rIG9eshdOgu0rbj+uJFTxf6sA5ZTFLNPC1L74aSxUB6D3U
         r7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nNaL4oWbSaoZkugEaXO//WHohZesy6t6T5egzcvNBJU=;
        b=pHfKW7YxaxjQzmfc5tt77T926v0rPhBbuEnazSRM9nBpNImKP915EfqZg9OEsf0pWr
         yHz81dlbw3IfUSSFD0ToyZ0XLI7LC98x2fKa+3wtZYnCUI1v2bMyPusQCtojopcHLlc7
         q1EBaZ8qXHwiXsR80W1twuEeQ7vUegwfzCGUjW8FnoeBiaWA0pm9KPDru/OhJg2jN1//
         zjBCLkAPQXvwKYfqAITAuqvGv4yCZn2gbvtxCA43s8yPJqI8UgPMBPHmjUvAvBZ6y0iF
         ayxvSNapC0CBF9ovyT/bfOlsSXH0iKL8wxOhIa76xkrPvA8JplWDCYKrjTWN5xrF6NSC
         FzPw==
X-Gm-Message-State: AOAM530AuHNC1pWzEpsszBIAeR9buvJFI0dV4+/QTfzfEa4VOQ2u+ZcD
        OKuCw76S16Iohsv6kMlzQcKBhMXN85U=
X-Google-Smtp-Source: ABdhPJxM4TdmZDJGCeZu3o4bX2/jcid6E3rTBlyeeKlcZ3F9o6XszzHtsfq7fRTAYiVk6TSn/Uvebg==
X-Received: by 2002:a62:5ec6:0:b0:50d:a467:3cb7 with SMTP id s189-20020a625ec6000000b0050da4673cb7mr569675pfb.85.1651146953687;
        Thu, 28 Apr 2022 04:55:53 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a064200b001cd498dc152sm12244744pje.2.2022.04.28.04.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:55:53 -0700 (PDT)
Date:   Thu, 28 Apr 2022 20:55:51 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] openrisc: define nop command for simulator reboot
Message-ID: <YmqAx31dtXCaNn7R@antec>
References: <20220428111139.1330966-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428111139.1330966-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 01:11:39PM +0200, Jason A. Donenfeld wrote:
> The simulator defines `l.nop 1` for shutdown, but doesn't have anything
> for reboot. Use 13 for this, which is currently unused, dubbed
> `NOP_REBOOT`.
> 
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Link: https://lore.kernel.org/all/YmnaDUpVI5ihgvg6@zx2c4.com/
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/openrisc/kernel/process.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> index 3c0c91bcdcba..4cce95fa6eb5 100644
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -52,6 +52,8 @@ void machine_restart(char *cmd)
>  {
>  	do_kernel_restart(cmd);
>  
> +	__asm__("l.nop 13");
> +
>  	/* Give a grace period for failure to restart of 1s */
>  	mdelay(1000);
>  
> -- 
> 2.35.1

This seems fair, probably it would be good to have a comment mentioninmg what
the nop is for, fyi for context these are the nop numbers used to control
simulations.

    #define NOP_NOP          0x0000      /* Normal nop instruction */
    #define NOP_EXIT         0x0001      /* End of simulation */
    #define NOP_REPORT       0x0002      /* Simple report */
    /*#define NOP_PRINTF       0x0003       Simprintf instruction (obsolete)*/
    #define NOP_PUTC         0x0004      /* JPB: Simputc instruction */
    #define NOP_CNT_RESET    0x0005      /* Reset statistics counters */
    #define NOP_GET_TICKS    0x0006      /* JPB: Get # ticks running */
    #define NOP_GET_PS       0x0007      /* JPB: Get picosecs/cycle */
    #define NOP_TRACE_ON     0x0008      /* Turn on tracing */
    #define NOP_TRACE_OFF    0x0009      /* Turn off tracing */
    #define NOP_RANDOM       0x000a      /* Return 4 random bytes */
    #define NOP_OR1KSIM      0x000b      /* Return non-zero if this is Or1ksim */
    #define NOP_EXIT_SILENT  0x000c      /* End of simulation, quiet version */
    /* New! */
    #define NOP_RESET        0x000d      /* Reset the cpu */

I will queue this once we update the spec to define some of these, I am thinking
if qemu should allow for the shutdown to work in user mode.

BTW, are you working specifically on openrisc? Or just setting up test
environments for all architectures?

Acked-by: Stafford Horne <shorne@gmail.com>

