Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4947A55AB82
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 18:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiFYQIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 12:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiFYQIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 12:08:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F3A11C13;
        Sat, 25 Jun 2022 09:08:42 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MDykM-1nvCiY21HI-009u7Q; Sat, 25 Jun 2022 18:08:38 +0200
Message-ID: <512bdf97-5468-e2d2-75bd-24107aaf8a34@vivier.eu>
Date:   Sat, 25 Jun 2022 18:08:37 +0200
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
X-Provags-ID: V03:K1:KNWZiu1ukqEzAce7MwcSCmmFI0pnOOc8l+k87+T6c9xfCBk/Orz
 USKTSf35nfLUSjST2Ynfi7p10EEmAjVdLi5bk9+MDluRHjrpMLUATrLNlQ2OnnClL9anCo0
 5gPpqQng+fWB9lPYblQDI3mIHl9lXRp+V5WQGbxf+4YS2CjNl3RynSJSJt/OsDcV4KnfLTm
 HH0uPCtF8UDmNvVrf05+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dqbI77Xgor4=:2PeAc6SwiCBNLL2uasPH0x
 pg5+F9TkN3WZRKFs+DUMXfWb7/4e0Sz4nnp7QDBNUEPaS5fGiWQT5a2KrYo6MWgGLJ1xMgDoJ
 TjKPqaK6hzIr9gBi26kGkgoHB3wQaF3vmfz99HyUkf2J21oD7ep9/66IOA4SI8sk6Mlg5np7b
 1KhxG1C4pBKpOz27aL05c+oZqKp56eijJw1IO/UBKPt8lFUexKKhW4c7I3pO4zFCjshU3VSPe
 oAFj7LAgtEgwjRrhI1UdYXxkAjt0uTN1BZPc6CdAcg52CP6g/39q+pmWhSxs2y2cwSYXMU+iQ
 RS5T4Dal+HQQ4joSgVIjKxuA+G8IMuG+P427xeITig3X+syXaQWFb4AD4Z8oq8okNoeJr8xMX
 rx+U3i1yAdt0HiPhhVOeDaG29RSzN3sFgr4QJ3a6KflFd0OW05wVNVn7Rapb/YoqtXTRJHt/e
 /Qa4XJn0P55J3wtS3eP71Nk3+FPEu7pQ5gfgKjLCQcZ4S2tkqM2IbJZjhKKYMK0qr+Z4IwAI0
 YzoP948e9heOxg6Ij9zrNHJBNO9WYhhhJ5XhL/YrXXDYomc0ZioCvmjypogEajPOaSmFEe4BF
 qxcuJXjRFUj89mdmaGX5PATx3Tsigk4CEnqGcx5i8gKbOfxT9TDH5VoOEIHOve0WcYULemzEL
 OpRkyVUcX4UxzrcydauRhTrqIguxoanRyrjJA6VpDCmjuHYV6aDOQnMZmVZb1EDa/7egVuaBy
 320PN51PveN7RMU1zwuDCJzUkF3vua0s1shLBQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

In fact, why don't you use the record->size to get the size of the buffer?

It seems useless to encode twice the length of the buffer, the second time on a 32bit while the 
length cannot exceed a 16bit value.

Thanks,
Laurent
