Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DF15318A6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiEWUK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiEWUKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:10:51 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A44985B3;
        Mon, 23 May 2022 13:10:50 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1McGp2-1nInAW3hzo-00cgOT; Mon, 23 May 2022 22:10:37 +0200
Message-ID: <5caac943-5435-8603-9e84-a4da3792df1b@vivier.eu>
Date:   Mon, 23 May 2022 22:10:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH next] m68k: virt: Switch to new sys-off handler API
Content-Language: fr
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        noreply@ellerman.id.au
References: <20220523175520.949681-1-geert@linux-m68k.org>
From:   Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20220523175520.949681-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vn8NH23Al85GwMr6Orne2SQ3M7HJm/sUBeSE1AA3PXgBPLDBX+z
 lXy44bkYTekDYTqhi1KFHzjdUoNH3rZF1O619QP1qbhLnloVV9HdTcfXGqtWOfsGEc8zWWy
 v8hcImjvtyU+ohKFTO9m6TclEdIRy1iAw4PY+mqFF7cubJ68bKYtg+/im/kaC+RQKXoUDhi
 +ibXUVxkpmTbOGWRpOUKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AZ3WBmima6M=:Yv9KISoh5uRE5Qe7VoRdff
 LBYWvxWz07+au4lExyKwj4l2H21xF4iB/toMXmhElxfg3BJc2VEZRB2d84DttKX1Z0ouwn025
 qdnYbkmYnb8nRoL4OUHBJwUMRnfcnU2arkmWes3IxHs5+5ldUPmufCqzf1085wvpd7Khiyl7p
 irEOvD/wU3SyNH5/MmWsjvOubsCxidSDZKmU70hWxkyYlOqrZpoFz4NMAHyPjsEvzG4+f67Y9
 7Kimju9mtc4xK4xodOLmSUCHoAYZvpy3H9v0mz24C3gZc8zGy2bnn4h/pF6+ergzG/SSui85X
 zsyfftoL/aw4Yto1kaDbeY7TUo6WpfHi9CppiRjJYSJlkNvFSUmTRa0CSD4G2M09izaKivI0B
 zZ3vARxb0sAOPquZiAuEFh5EMhe+zaSirq0o0pnELcRo7LRjuCURfaPgoQgIIM0cF4DASMwwu
 8gY2mvBg5E19e9X5W5y6bSCf1Yhqr5sr/RLbio6g40iCgQOTfXIWmKgycWRSXM0n2zQf+6Nfg
 /r40fDBXNELdSzrEbVJEHaktkYX3aKRCqE/L3W34h2iAkny3CSo/2qPqkX7Z7eovb0iPATalk
 9I+L/7U4Nl/tsG0fkUKP4aSwoaH3Zwxqlw2Qdl7fDPYpylp9Kqw2kzK3GoXkFf2QquZHYtllM
 mD3iVFeHLsRspcK8frQXbLvB+idL6zQQD/vzHDq5BxsXzDoiU1785Djm+exIyylJr0pZ3TXM5
 V+XkITzbA1byz7JwwGi/K54aP59IcbCMlKJF5Q==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/05/2022 à 19:55, Geert Uytterhoeven a écrit :
> On m68k with CONFIG_VIRT=y (e.g. virt_defconfig or allmodconfig):
> 
>      arch/m68k/virt/config.c: In function ‘config_virt’:
>      arch/m68k/virt/config.c:129:2: error: ‘mach_power_off’ undeclared (first use in this function); did you mean ‘pm_power_off’?
>        129 |  mach_power_off = virt_halt;
> 	  |  ^~~~~~~~~~~~~~
> 	  |  pm_power_off
> 
> Commit 05d51e42df06f021 ("m68k: Introduce a virtual m68k machine")
> introduced a new user of mach_power_off.
> Convert it to the new sys-off handler API, too.
> 
> Reported-by: noreply@ellerman.id.au
> Fixes: f0f7e5265b3b37b0 ("m68k: Switch to new sys-off handler API")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   arch/m68k/virt/config.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
> index 68d29c8b87e18840..632ba200ad425245 100644
> --- a/arch/m68k/virt/config.c
> +++ b/arch/m68k/virt/config.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> +#include <linux/reboot.h>
>   #include <linux/serial_core.h>
>   #include <clocksource/timer-goldfish.h>
>   
> @@ -126,5 +127,6 @@ void __init config_virt(void)
>   	mach_get_model = virt_get_model;
>   	mach_reset = virt_reset;
>   	mach_halt = virt_halt;
> -	mach_power_off = virt_halt;
> +
> +	register_platform_power_off(virt_halt);
>   }


Reviewed-by: Laurent Vivier <laurent@vivier.eu>
