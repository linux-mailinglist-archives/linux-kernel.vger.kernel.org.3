Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E137755AB62
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 17:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbiFYPve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 11:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiFYPvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 11:51:31 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAD016597;
        Sat, 25 Jun 2022 08:51:27 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Ma1sQ-1o8TYO2sJI-00VzSn; Sat, 25 Jun 2022 17:51:24 +0200
Message-ID: <2ef8eb4f-5ef6-5de1-9f42-3430ad3f1b7c@vivier.eu>
Date:   Sat, 25 Jun 2022 17:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] m68k: virt: pass RNG seed via bootinfo block
Content-Language: fr
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, geert@linux-m68k.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20220625153841.143928-1-Jason@zx2c4.com>
From:   Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20220625153841.143928-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4r1yxypdNmR+o3p9w42sYOpK5rc0j4YdOC+Q2h8qGKpBzjOQ6WC
 uh6zVeN9+GHsLkoOtJGy1KFOwLk7HpRMPkkfHC/Mdt7bmYJZU8s/Rsi9M8vLQGTfUhEUGH/
 dUmEIK2ikIAmUoej0xMSNijJkpnEcRehHk6NLMbR3l+J4wRPpiEFmlNaDa0oFfi2gquXqgz
 ItXtcVfF0s5Bknj1xBayw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z2x8sN76nes=:aTdghihhRuySMM1AjQQwyd
 2RmSkuYi1hbgfLYzs5acTyyXawtJ/efw0vPJ7WPo4LrfK5OJFyfQG4A6CD0EPpyzSRc+e4xlC
 wb36o14yvJplYixzFJgeX0Dhs5v8DXX7RUEv92VqCODqfPYpVjTN7+o0LLAPNOKkl8ezUSAqH
 lsjkksQ/6RsSw67IgsXAt0pqUcrmsVpSE/0Ha4oJJuPOImbz/6GcqJmsYHM/Llh0XkenRP1Dd
 JLhQZeZEpfK71Zu3qogk/fC6zHaFQpVtr6NbrUmeETSLYYucsWsnXISwkyigTYAOc/ag0erzi
 1gPP1Ow6N4dxMQUHrzpr1pPBA76I8e/fkTEChROshKLYFCTzLVeS46hNdpZANTSKUn9D2Otag
 UQGAf6v9ydXKLdwhzbbdkZgGpVCld1NCMRAFVFTwBT9Q4DUkYsnYImEi+6jCs60TbhGQXCaoy
 +5g2eRqQNm7HLoi7pyyew0EQCwMK5cMv/e4jzpPKXSzETsQxPJB9Yu+95LuaE/y+o+dje1At+
 YqVjJjwJW0xZSXZ/NYz+lYyBv7q0YZfkGlVBrJp0AhRUlk937WzWGmiHUrrR0bVAK4KFU+rVC
 cX8ZiBhdOSdCThOGd857LHV7gOS63QoPPbpJqF/9nfMV8iVDX0B8phBnEvAN8bG/LfO0rWsiY
 fD2umc5z2LMgmVoMp6yZWR8rQ09cNAr95KKEVz5M5eRh5oGU6cbTche4ioGHOTw1xW72m6ZcH
 2rSGOxp/HiN5jRIycm/omapaSXpTfBJoWlwIvw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/06/2022 à 17:38, Jason A. Donenfeld a écrit :
> Other virt VMs can pass RNG seeds via the "rng-seed" device tree
> property or via UEFI, but m68k doesn't have either. Instead it has its
> own bootinfo protocol. So this commit adds support for receiving a RNG
> seed from it, which will be used at the earliest possible time in boot,
> just like device tree.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   arch/m68k/include/uapi/asm/bootinfo-virt.h | 1 +
>   arch/m68k/virt/config.c                    | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/arch/m68k/include/uapi/asm/bootinfo-virt.h b/arch/m68k/include/uapi/asm/bootinfo-virt.h
> index e4db7e2213ab..7c3044acdf4a 100644
> --- a/arch/m68k/include/uapi/asm/bootinfo-virt.h
> +++ b/arch/m68k/include/uapi/asm/bootinfo-virt.h
> @@ -12,6 +12,7 @@
>   #define BI_VIRT_GF_TTY_BASE	0x8003
>   #define BI_VIRT_VIRTIO_BASE	0x8004
>   #define BI_VIRT_CTRL_BASE	0x8005
> +#define BI_VIRT_RNG_SEED	0x8006
>   
>   #define VIRT_BOOTI_VERSION	MK_BI_VERSION(2, 0)
>   
> diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
> index 632ba200ad42..ad71af8273ec 100644
> --- a/arch/m68k/virt/config.c
> +++ b/arch/m68k/virt/config.c
> @@ -2,6 +2,7 @@
>   
>   #include <linux/reboot.h>
>   #include <linux/serial_core.h>
> +#include <linux/random.h>
>   #include <clocksource/timer-goldfish.h>
>   
>   #include <asm/bootinfo.h>
> @@ -92,6 +93,9 @@ int __init virt_parse_bootinfo(const struct bi_record *record)
>   		data += 4;
>   		virt_bi_data.virtio.irq = be32_to_cpup(data);
>   		break;
> +	case BI_VIRT_RNG_SEED:
> +		add_bootloader_randomness(data + 4, be32_to_cpup(data));
> +		break;
>   	default:
>   		unknown = 1;
>   		break;

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
