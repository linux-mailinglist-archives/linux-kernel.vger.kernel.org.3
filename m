Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4AE48F753
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 15:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiAOOky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 09:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiAOOkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 09:40:53 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CACFC061574;
        Sat, 15 Jan 2022 06:40:53 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso11399549wmd.5;
        Sat, 15 Jan 2022 06:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/n55x+rW0Kb1T4WVGAuKWrikNjmvex0n+Y9oWsL//RI=;
        b=Jhy3e/7+sWwhU6YyA8UYhboOiVcuBCMbbnybhdYih73TBreaJv4/j2QUHys93HNYRN
         2F+oPvYAu9dRNRErpKuiOzLX+LwNXsT9a6DTDSQIdefABdMX9HAeRCnfxTMIlWhqdi5+
         gyA/MR9pV9yZY5zgX4HiTDA2N4PCwPYtkS/d4XtwFlGrin6vtv+JdQ0c4RQLqMDsKkX/
         e47ErV8mp7qF3kfj7OXI2Iy5N6fCirw6xEFGTizJVDwZShoX2V17rZKWRvEkbrLMSAlo
         cytDz9BVyLPNym8tmdeeuh2cXN7WysewhiU+BB+CI2faYGmKPU5jc1Ivbq97I+TsQAWi
         Ko/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/n55x+rW0Kb1T4WVGAuKWrikNjmvex0n+Y9oWsL//RI=;
        b=Qx7IbeXRFg4XWN3K0gOhfxum8iQcOy5T2LE58efsOsucR58byxOGFk3AHbKDbkxnOi
         T4lb2GFWEMBp9g+1zodtlZdJcYk5NGUnqrN6P72UH/k4BJsWa0bS3BsOK3EoLX4je2w8
         q9J9yX82Vv2x59v2kC/u2LadCpv1aBOBJFMd4a9j3OzDRADNIcalDzX7H/lgmWo/PHfD
         S6ZxL3cKSxtvfCT36K4l5xnG8KPqgZgz/MDt/Iz4hZ36I3HWaFv2NoxhwstyxjTAh/qw
         TzycPXEQRIYaFY9mbI6sThuAtNyZ9URHQsb6uBz/phAYsczJ1umr2HFKHGunHdhrsaJC
         KVcQ==
X-Gm-Message-State: AOAM531wBO3EnZSkEBH5+l8rlwz6ebtygAJuPEFEmfLNGcIl2WfxNlL/
        E8EqiNGpfJDuyURrpQi+vVw=
X-Google-Smtp-Source: ABdhPJw3CreaGPBR8Ai+PNIuljpvOdhwzdb3f2CL9x9GkUcvd29nx/xtJF6iGMo6+dbEnA6xg09vBA==
X-Received: by 2002:a5d:5709:: with SMTP id a9mr12506097wrv.707.1642257651966;
        Sat, 15 Jan 2022 06:40:51 -0800 (PST)
Received: from [10.19.0.4] ([194.126.177.12])
        by smtp.gmail.com with ESMTPSA id s22sm13024959wmc.1.2022.01.15.06.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 06:40:51 -0800 (PST)
Message-ID: <b00ae233-d446-6a22-21a8-aeb6619d6685@gmail.com>
Date:   Sat, 15 Jan 2022 15:40:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] platform/surface: Reinstate platform dependency
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220115140849.269479-1-geert@linux-m68k.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220115140849.269479-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/22 15:08, Geert Uytterhoeven wrote:
> Microsoft Surface platform-specific devices are only present on
> Microsoft Surface platforms, which are currently limited to arm64 and
> x86.  Hence add a dependency on ARM64 || X86, to prevent asking the user
> about drivers for these devices when configuring a kernel for an
> architecture that does not support Microsoft Surface platforms.
> 
> Fixes: 272479928172edf0 ("platform: surface: Propagate ACPI Dependency")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Seems sensible to me.

Acked-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
> index 5f0578e25f718f14..463f1ec5c14e9fa9 100644
> --- a/drivers/platform/surface/Kconfig
> +++ b/drivers/platform/surface/Kconfig
> @@ -5,6 +5,7 @@
>   
>   menuconfig SURFACE_PLATFORMS
>   	bool "Microsoft Surface Platform-Specific Device Drivers"
> +	depends on ARM64 || X86 || COMPILE_TEST
>   	default y
>   	help
>   	  Say Y here to get to see options for platform-specific device drivers
