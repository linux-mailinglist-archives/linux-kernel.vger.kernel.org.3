Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FE049F832
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiA1LWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiA1LWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:22:04 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2374C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:22:03 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x11so11145329lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Vvp4f8p4kJgg8RYCX/3wsqIxKNWP+tFC5nwJxihACm0=;
        b=n+TaXA2TQr+391SxSP/W6CjVk+2AurlJiYBG3Ujsuzr6ZvwZUaVsESp8vJmzlUq7E/
         C+mWzJdmhRdVLglrWLOlNWCzYA0VmVif35hQvQ/+gq63Ko2kgDX9sxWPxl4yo0rqe4wN
         GR7QoW0cL8Y+AZvVMl+B68M13bhbd8pEHqkBBR2bi2eHHP9imlvMDrUuwc7Tcmtj3Z0M
         1uOw2LQWmAreUiuHCIbyRH2qI+8MAbPi24ckMIQgcTzXek9plvt3V7f0t8MxpF+fW1FR
         q24VB7pR9cQRt4hKoXarsAj5jTpTLIbkEBedHK50DEcwqQEtVcfGV3fk8a7iFdSn6vpN
         a6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Vvp4f8p4kJgg8RYCX/3wsqIxKNWP+tFC5nwJxihACm0=;
        b=3Wgz9AIloUroYV1CZ/owzBLaIsQspbo3UGlt9DziGWBizQFCrFU2x0mlaQ3gBCudhk
         G7Fk6mCAmNTstSvgQo8kPZ0bdVeJFa0NNcPzhDYBoj00HsJgbIsRok2gKDirvxVu6aAW
         eyYTVG+Suu3TY4DVOWLATEFGbkdO2ozuXjlSdLgK36UP+wqRHILuF4+NZ9mygUh9uVKO
         UQC9aQsmiPFwJiRKIoTfaAQm0myS+4bMAjyKtgp8z32If9x3lcEegGu3187RzsID8+Nd
         QMThOkuiI0MRQ5o+wjPuT7tvcwnCiZDZR/O+Ou5Ywt0+7gEN0qaJF5KvHIUgc6ygWBwR
         r3oQ==
X-Gm-Message-State: AOAM531RP5W9oRwF00c0GPcRkaNZhm3327YibTmlpiu6PIP9NcuFWGi1
        91CtRBkrFUcjh3goDY+MeRI=
X-Google-Smtp-Source: ABdhPJwuE6zDiUEvL/Y8p7G3dV6j4q1w9Z3XuqS9tg6dNyEwXVv9IBZUu8Ci7UMujF2vhAJ6wGSMQA==
X-Received: by 2002:a05:6512:3984:: with SMTP id j4mr5972535lfu.388.1643368922164;
        Fri, 28 Jan 2022 03:22:02 -0800 (PST)
Received: from ?IPv6:2a00:f41:80ea:4a21:823:c5ac:f37f:2677? ([2a00:f41:80ea:4a21:823:c5ac:f37f:2677])
        by smtp.gmail.com with ESMTPSA id b12sm1692675lfj.228.2022.01.28.03.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:22:01 -0800 (PST)
Message-ID: <48499a57afb3d27df26b39aa4255b4ba583c1148.camel@gmail.com>
Subject: Re: [PATCH 07/16] tools/include: Add io.h stub
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jan 2022 12:21:59 +0100
In-Reply-To: <YfKngOPLeI3rQOn3@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
         <2d9aa000afe81b45157617664134b871207c2067.1643206612.git.karolinadrobnik@gmail.com>
         <YfKngOPLeI3rQOn3@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-27 at 14:09 +0000, Matthew Wilcox wrote:
> On Thu, Jan 27, 2022 at 02:21:25PM +0100, Karolina Drobnik wrote:
> > Add a dummy io.h header.
> 
> Rather begs the question of what memblock.c needs from linux/io.h.
> 
> Wouldn't it be better to:
> 
> +++ b/mm/memblock.c
> @@ -18,7 +18,6 @@
>  #include <linux/memblock.h>
> 
>  #include <asm/sections.h>
> -#include <linux/io.h>
> 
>  #include "internal.h"
> 

That was something I considered in the very beginning, but didn't have
a chance to verify it works for all architectures. I can take a look
after I'm finished with other v2 changes.

> (allmodconfig on x86-64 builds fine with this; I have not done an
> extended sweep of other arches / build options).


