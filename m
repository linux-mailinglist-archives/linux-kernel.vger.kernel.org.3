Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE55F4A8BB2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353513AbiBCScl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiBCSck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:32:40 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392CAC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 10:32:40 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p125so2987607pga.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 10:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CStqatCFpz912B730JqT0/m95vKPMDIyMRP8Nqc1jck=;
        b=ZZMtM4hs1+cg9gQRqBcWN8i5argUMu6UwlC8W+NMCIwMlt9Jf6RVIF9Vjql+/NMiFs
         HyhzvJjqfFcfHuX9K/oLkkb1vpbwaTCR32c9TuA9GkI0LVaO4CeLL5ANhNIAxgKcQC/R
         kALSHTzaxeALnTjuoggbBqTqP9p8Om230p6WSC8NfWs5A3xbrW4XkyMUNpuru3VXN+/V
         zUIT4C5oVT8O/zWCmzr6o10TZsNKBFlbB9Rqma2MVR/nuqm7jjlBUu4YwbxpCJcut05w
         m1YgCaluKhTgSaB3UmpuxJY/ubwgG36B2NigfVUoZkTF3sNsplY3er8+kznZLf+TR7NU
         KkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CStqatCFpz912B730JqT0/m95vKPMDIyMRP8Nqc1jck=;
        b=HmCVNojMldo4thihJ/L1kVToBNHgpgah6NbvaWlzANgbkpPpMplEraWGjMEQ2wHFXy
         LMZhVswdSZDO8tFadP3bHJFhrKB1GdMKFVJTy7iQKPPE/xz2a1HAjjqab+NWszC33iHe
         EzyvKIg2D/3+YYPeIwbtyBBIaE+bJidZiioevbMf9O9A+isS7sBXm+mRrNusUkiM4BlG
         N+Bmb+YcgPFOC2tuB0RGGGSG9anaL3D04nVZhIQ3tQpTiTHoLbwM/ua9usoS0aqzWYFh
         mVf3M2/b0zOcA/O8TeIuDBSjSFJmFA4RgFHMWNIk4zbrSeYjVsTdlxR9gyvLK9o+/jqX
         U1wg==
X-Gm-Message-State: AOAM531KycodeKH6RyZoCS9/og1qTBMg4ykcpOQcqJnqxfMgff4GBtJs
        7/W6ne2FAUDh0+za6oZ2/BmLgEBaXxw=
X-Google-Smtp-Source: ABdhPJyTinZANEuphRwCpKdqCJFwWbd+ALdPRJRKSvl8EO7qkmzkDiQBpJkmx1HoX1kUSUGmM3ByqA==
X-Received: by 2002:a05:6a00:2447:: with SMTP id d7mr35116714pfj.64.1643913159652;
        Thu, 03 Feb 2022 10:32:39 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id 9sm10531208pjg.50.2022.02.03.10.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 10:32:39 -0800 (PST)
Message-ID: <f412df05-ffb6-51b6-6b5e-b25d663bd5e9@gmail.com>
Date:   Thu, 3 Feb 2022 10:32:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] Broadcom STB PM PSCI extensions
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
 <YfuysSBnZbnMF4OC@FVFF77S0Q05N>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <YfuysSBnZbnMF4OC@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 2/3/2022 2:47 AM, Mark Rutland wrote:
> On Fri, Jan 21, 2022 at 07:54:17PM -0800, Florian Fainelli wrote:
>> Hi all,
> 
> Hi Florian,
> 
>> This patch series contains the Broadcom STB PSCI extensions which adds
>> some additional functions on top of the existing standard PSCI interface
>> which is the reason for having the driver implement a custom
>> suspend_ops.
> 
> I *really* don't like the idea of having non-standard PSCI extensions, because
> it somewhat defeats the point of PSCI being a standard, and opens the door for
> the zoo of mechanisms we had on 32-bit.
> 
> I think this needs a fair amount more explanation and justification.
> 
>> These platforms have traditionally supported a mode that is akin to
>> ACPI's S2 with the CPU in WFI and all of the chip being clock gated
>> which is entered with "echo standby > /sys/power/state". Additional a
>> true suspend to DRAM as defined in ACPI by S3 is implemented with "echo
>> mem > /sys/power/state".
> 
> Why isn't a combination of CPU_SUSPEND and SYSTEM_SUSPEND sufficient here?

This is exactly what we are using, just the use of CPU_SUSPEND is not 
done via the CPU IDLE framework because our platforms did not wire up 
the ARM GIC power controller interrupt signals back to the power 
management controller of the system, but via registering a "standby" 
state into suspend_ops instead.

> 
> What specifically *can't* you do with standard PSCI calls?

Since you looked at the patches now, nothing at all, everything we do 
(with the exception of the funky SIP calls which are not strictly 
mandatory for system suspend operations) is done by using standard PSCI 
calls and leveraging the existing vendor space when needed (as with 
SYSTEM_RESET2 for instance).

> 
>> These platforms also may have an external Broadcom PMIC chip which can
>> cause the SoC to be powercycled assuming that we communicate that intent
>> via a vendor specific PSCI SYSTEM_RESET2.
>>
>> Since it is desirable to get any new functionality added to the kernel
>> to be loadable as a module as part of shipping said products in a Google
>> Kernel Image (GKI) environment, we need to export a couple of symbols from
>> drivers/firmware/psci/psci.c.
> 
> I really don't want to export the guts of psci.c.

I can appreciate that, and really the sticking point that required me to 
export the couple of symbols needed was because the alternatives would 
be to:

- to not make this code modular in the first place but that won't fly in 
the Google Kernel Image grand scheme of things where *everything* that 
is not necessary for boot must be a loadable module

- not support the "standby" mode which is not really an option since we 
rely on it to achieve our power targets

- export cpu_suspend from arch/*/kernel/suspend.c which is probably 
going to be a no-go plus duplicate the entire set of PSCI function calls 
to re-implement the psci_system_suspend_enter() functions

Thanks for taking a look!
-- 
Florian
