Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5AA4F0684
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 23:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354100AbiDBVyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 17:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346078AbiDBVx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 17:53:57 -0400
X-Greylist: delayed 1467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Apr 2022 14:52:05 PDT
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.55.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E04F3A5EB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 14:52:05 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 56F81400C5548
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 16:27:38 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id alHWnfWxfb6UBalHWneeUq; Sat, 02 Apr 2022 16:27:38 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+fqVS2YHoB85ngIYgaaiabTFUqnbMkVGBsGk+DSrzAU=; b=PyeH8okZjcl6Hb8vuAVnEJ/WIA
        ZOdJgvCd5kHIgpAILfxvGh6RiqquW3yB/bHt6OvbMHoaeLo2kfalL4iCMXnpKkErXmmMwTLJtH2+c
        btf95l4gZFxp3e0QuNryCkUkj3HwtPr9YTR/xjJvj+7GBqP3/mOPOmeBkJ6b09rbCs28hjZ5vRTa1
        HylW0lU/enP9O4fvxQtnL/3zW8RjbN3I/xg/3RD1I5HGLuM3tRTRqETofPzp+AeS8vdss9kNVVM5w
        H6U+nWz8ha8IUE2oMi2pqrhdt+AHnTt+PJ09q1MOVflPA6heVHW6rC+V1Yv2mikPE5MVp3yxe4Nv0
        l1OBfm7g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54666)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nalHW-0012pj-0x; Sat, 02 Apr 2022 21:27:38 +0000
Message-ID: <6353bc69-901e-32e7-e736-00dd6a09a1ea@roeck-us.net>
Date:   Sat, 2 Apr 2022 14:27:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] parisc: Switch from GENERIC_CPU_DEVICES to
 GENERIC_ARCH_TOPOLOGY
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>
Cc:     James.Bottomley@hansenpartnership.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220401154137.GA3745625@roeck-us.net>
 <57e79014-25e6-62d3-27de-64797e43992b@gmx.de>
 <927a54f9-b413-0c71-461d-28ed9d5ece96@roeck-us.net> <YkdiDJZ/XHODymRk@p100>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YkdiDJZ/XHODymRk@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nalHW-0012pj-0x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54666
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 10
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 13:35, Helge Deller wrote:
> Hi Günter,
> 
> * Guenter Roeck <linux@roeck-us.net>:
>> On 4/1/22 09:47, Helge Deller wrote:
>>> Hi Günter,
>>>
>>> On 4/1/22 17:41, Guenter Roeck wrote:
>>>> On Thu, Mar 24, 2022 at 07:46:50PM +0100, Helge Deller wrote:
>>>>> Switch away from the own cpu topology code to common code which is used
>>>>> by ARM64 and RISCV. That will allow us to enable CPU hotplug later on.
>>>>>
>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>
>>>> This patch results in the following traceback when
>>>> booting generic-32bit_defconfig - SMP in qemu.
>>>
>>> That's strange, because I just built this generic-32bit_defconfig myself and
>>> it boots up nicely in qemu for me. The only thing missing is CONFIG_CGROUPS=y so that
>>> systemd can start.
>>>
>>
>> Did you disable SMP (that is what - SMP was supposed to mean) ?
>> Also, note that the system does boot fine, it just spits out the warning.
> 
> The patch below fixes the warning for me.
> Could you try?
> 

I did, and it fixes the problem. I just sent a Tested-by: in response to
your patch.

Guenter

> Helge
> 
> 
> From: Helge Deller <deller@gmx.de>
> Subject: [PATCH] parisc: Re-enable GENERIC_CPU_DEVICES for !SMP
> 
> In commit 62773112acc5 ("parisc: Switch from GENERIC_CPU_DEVICES to
> GENERIC_ARCH_TOPOLOGY") GENERIC_CPU_DEVICES was unconditionally turned
> off, but this triggers a warning in topology_add_dev(). Turning it back
> on for the !SMP case avoids this warning.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 62773112acc5 ("parisc: Switch from GENERIC_CPU_DEVICES to GENERIC_ARCH_TOPOLOGY")
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 52e550b45692..bd22578859d0 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -38,6 +38,7 @@ config PARISC
>   	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>   	select GENERIC_SMP_IDLE_THREAD
>   	select GENERIC_ARCH_TOPOLOGY if SMP
> +	select GENERIC_CPU_DEVICES if !SMP
>   	select GENERIC_LIB_DEVMEM_IS_ALLOWED
>   	select SYSCTL_ARCH_UNALIGN_ALLOW
>   	select SYSCTL_EXCEPTION_TRACE

