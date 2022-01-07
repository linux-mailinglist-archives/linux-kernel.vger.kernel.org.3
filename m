Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2149487CE7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiAGTSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiAGTSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:18:06 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168BCC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:18:06 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso5603401pjo.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 11:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=P06hzfcfIH0IXgLIP2r290wgSfaqspHtXhfZpQaUhyI=;
        b=IgZ6AQQzyPrjQQkKUS8MoyeCDGYdDN3XuALVhvUMByWXpSIxeP10zUhpShKgf5MRUa
         Eh4Wst88OPYg7V5vv1cbRV7KcGS/+t0iXLxcRVYzvxKldJMwWVG9ZU/ZRweIFwt55cZz
         PAhj1TlxLsJeq9x988ROVGb6YYRJqTHfNjgCYAt8nnCk/6NS6026OPCZmX4GeyxWFppK
         Kst5OyZBBZZqGwSADCVu2TMWeFgnV4DRGZbBQwN0dDQienhS8vWECimv8W5q5tv7ZDrK
         nyEtA1xGkVHojmkTwjg1T4nEUq3qBNnFQxnORqIhOLghw0P4h+grfyuu/dvNoZVWdcku
         N8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=P06hzfcfIH0IXgLIP2r290wgSfaqspHtXhfZpQaUhyI=;
        b=D3NcWwT9kc2RMWKNRX/OmHpp7q51R1wxMoUegB7/MOD7lNdBJaO4woMElm/8o4dKWc
         kGR4kQgrt7yfxLr6IvO89awzFhk484TSWAxAC21rKm/v0F/qoq5LgCz+NT5vP0QWXwXQ
         Q5SZAsm/CyDSAoq4SoWEPxKjTgByRtFftjcnAPqPvtHgKahudVx/0pEeUVliFq4iTGPM
         ehEPbR6gdY1I2EpcA9yjnpM2dEXyeV6ilo/66VjRVO7FPHmzDIRJMEm0aLx+CG6I/Mpg
         sAH9SHIGXRWidvBE7OeSCWlK3Z8FJxAiC9Y0szxDEwnY6IcPT3UsZ7BJ6rfBc+p+k2SX
         bFng==
X-Gm-Message-State: AOAM53269hM8j6n2Zzpm4/awwzqYxXe5A5MDmFXilSNV8lL4GQnqC7uY
        MiMKmQgfhR2FsV41SWlzQGf3wQ==
X-Google-Smtp-Source: ABdhPJyzHkAFz2bmgdBO56+zkfils+jFDnKCYaTiIqCcfSL4/dZJp3aUIBu+9dp8YSahrwSmiUvRvQ==
X-Received: by 2002:a17:903:2486:b0:149:1ce1:d45d with SMTP id p6-20020a170903248600b001491ce1d45dmr64219867plw.57.1641583085394;
        Fri, 07 Jan 2022 11:18:05 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l145sm6330979pfd.117.2022.01.07.11.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 11:18:04 -0800 (PST)
Date:   Fri, 07 Jan 2022 11:18:04 -0800 (PST)
X-Google-Original-Date: Fri, 07 Jan 2022 10:18:54 PST (-0800)
Subject:     Re: [PATCH] riscv/head: fix misspelling of guaranteed
In-Reply-To: <20211120142608.2068809-1-georgedanielmangum@gmail.com>
CC:     georgedanielmangum@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, alex@ghiti.fr, vitaly.wool@konsulko.com,
        anup@brainfault.org, mark.rutland@arm.com, ardb@kernel.org,
        181250012@smail.nju.edu.cn, wangkefeng.wang@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     georgedanielmangum@gmail.com
Message-ID: <mhng-047fcd51-673f-4bb7-a19f-beecd00667e8@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Nov 2021 06:26:05 PST (-0800), georgedanielmangum@gmail.com wrote:
> Fixes misspelling of guaranteed in comment describing why fetching fence
> is guaranteed to work when switching to kernel page tables.
>
> Signed-off-by: hasheddan <georgedanielmangum@gmail.com>
> ---
>  arch/riscv/kernel/head.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index f52f01ecbeea..469eccd3780f 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -135,7 +135,7 @@ relocate:
>  	/*
>  	 * Switch to kernel page tables.  A full fence is necessary in order to
>  	 * avoid using the trampoline translations, which are only correct for
> -	 * the first superpage.  Fetching the fence is guarnteed to work
> +	 * the first superpage.  Fetching the fence is guaranteed to work
>  	 * because that first superpage is translated the same way.
>  	 */
>  	csrw CSR_SATP, a2

Thanks, this is on for-next.
