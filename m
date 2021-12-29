Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180A848145C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbhL2PWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbhL2PWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:22:07 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E40C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:22:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j18so45096622wrd.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=sTlsJk6fgdPgEQy5tYoKBcpGYLJ94wt81Boye+wusEo=;
        b=f864DTdNmKce0giPakxwtHGURp8fPIziMVJHYwP95w2JcxVM0EExuXgzoBDMjH8RUQ
         YpufOVjhtOooCC7mnQGjZo2P9/jPqQlInglH99xiXSLaShOt7Z1KLfj8T28FAgqlxJKT
         DmFtbqrWJsiMdLcgTZ/L/EDoOMX6OAJBV+yPSHJ7k3DzcJPt4fjbgfm2/FmqIMC4oz8z
         O28FMpbp9KCoXmkPmn+N4taU4oPhGO7Ly2NAo8lbXSv/5o12d8ECoNTia3Id5whYwQOJ
         YfDIElQIuxmtEsAm2lDi3I/G9vLDc0aKb8CzzSYpIAr3rXPQ4kAXPajtK4oxdSNoXYGN
         nZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=sTlsJk6fgdPgEQy5tYoKBcpGYLJ94wt81Boye+wusEo=;
        b=UFy0QT0UX74wZrLskmLCu1s2G3CitQb/5Osnnulhg8IXgvJJbt3AZr7ANzXrlSi+Ye
         6kpp2Nq2egxx86q151/Kt8eQ9Ou/yZHgLjRhgtxt3OP09oDYodbQKwu1/1L5AsRokohu
         4TH3CpIk96q919vV3JbEMGxVTfTuzrvQ+HcCo/UUky4EtXFGxriv4JvMzz3Y7EWkSURg
         612B7lGv+LEpLLM6DdMZ6g3S4bUF3bdva2+BreOhdCYF1oNxQQNPNkYBc1e0wetgUYwY
         qBKzsZqvOZmIwO2xxGJ6nrMeWByytR9UZFulyai8DTfGvP2DHQHbdZ7xvHsPkTQxN5Xj
         vilA==
X-Gm-Message-State: AOAM530P3juUig/bHqCR6fyg1MLY2w+V4OD+yTMMNK9PmRDsma9lKPKr
        vhS1O9AUdfKircQvHQQsvMY=
X-Google-Smtp-Source: ABdhPJzDT7+Rp/h+VzuaTTtrAX0MHh/t0UPWuFAwiATQA5boBr3ec55ht8diSgECzfKzwSYNSwcxZA==
X-Received: by 2002:adf:fa83:: with SMTP id h3mr21479889wrr.434.1640791325584;
        Wed, 29 Dec 2021 07:22:05 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id s1sm23919768wmh.35.2021.12.29.07.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 07:22:05 -0800 (PST)
Message-ID: <872b08a5-169e-45da-9e7e-4ece481514c7@gmail.com>
Date:   Wed, 29 Dec 2021 16:22:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Cc:     john@phrozen.org, linux-kernel@vger.kernel.org
References: <20211220211854.89452-1-nbd@nbd.name>
 <20211220211854.89452-5-nbd@nbd.name>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v8 04/14] ARM: Add basic support for Airoha EN7523 SoC
In-Reply-To: <20211220211854.89452-5-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/2021 22:18, Felix Fietkau wrote:
> From: John Crispin <john@phrozen.org>
> 
> EN7523 is an armv8 based silicon used inside broadband access type devices
> such as xPON and xDSL. It shares various silicon blocks with MediaTek
> silicon such as the MT7622.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   arch/arm/Kconfig | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f0f9e8bec83a..8dcd05ef31cc 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -573,6 +573,18 @@ config ARCH_VIRT
>   	select HAVE_ARM_ARCH_TIMER
>   	select ARCH_SUPPORTS_BIG_ENDIAN
>   
> +config ARCH_AIROHA
> +	bool "Airoha SoC Support"
> +	depends on ARCH_MULTI_V7
> +	select ARM_AMBA
> +	select ARM_GIC
> +	select ARM_GIC_V3
> +	select ARM_PSCI
> +	select HAVE_ARM_ARCH_TIMER
> +	select COMMON_CLK
> +	help
> +	  Support for Airoha EN7523 SoCs
> +

We should add a new subfolder
arm/mach-airoha or add the config in arm/mach-mediatek, as it re-uses part of 
the MediaTek IP.

Please merge this with 3/14

I also wonder if this actually boots. I suspect we need DT_MACHINE_START() macro 
and the compatibles defined. It's many years ago I did this for MediaTek but I 
remember that the system won't boot without that. Maybe things have changed over 
time though.

Regards,
Matthias

>   #
>   # This is sorted alphabetically by mach-* pathname.  However, plat-*
>   # Kconfigs may be included either alphabetically (according to the
> 
