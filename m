Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF8D48D6B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiAMLcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:32:55 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:34607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiAMLcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:32:54 -0500
Received: from [192.168.100.1] ([82.142.23.158]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MJEpp-1mtSXK3YOB-00Kejs; Thu, 13 Jan 2022 12:32:50 +0100
Message-ID: <8c0b3146-35ee-b0b2-468b-1c8dcdaf64ee@vivier.eu>
Date:   Thu, 13 Jan 2022 12:32:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: fr
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
References: <20220113103559.2577216-1-laurent@vivier.eu>
 <20220113103559.2577216-4-laurent@vivier.eu>
 <CAK8P3a2_cJi9+SNi9gK6+5kpBo4wmVw4hz42Bq_jm1+s6AvENQ@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v5 3/3] m68k: virt: Remove LEGACY_TIMER_TICK
In-Reply-To: <CAK8P3a2_cJi9+SNi9gK6+5kpBo4wmVw4hz42Bq_jm1+s6AvENQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1O8HWVYOtm0BwmF8fl3T2Fy9HyLzYUbNdnAZHRpFnD6ajZM2W3t
 LrS3IEkeyuiNlM+KpXXW6SB8kteX4oImuLGbZc6nVhdltJqvBe5OqL8mkYepZGLnviCCCDo
 JV6s6a2qwIO+0pAkVbMFOtNI7rMyCe1n3GK+CjvJsFMETx8fYTdO/KL1H7XWaHbny+97TQT
 CzJ+Gvl5uZVd0nTz4l3KA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:anMqcWSxLB8=:msU7L4promUQEOp1APGkld
 4ezCj9WMXJIwAhnxg3qd/fbDy6Q0vx8prh0gViqML52fYtSvlLkWPb5c7bQpTxuF6rDsspede
 qp9yykoaCPhgxzm01N6Nr/hkkL9aiNsm8VrI/tFQ5sBoWLsAJE4ZuNo7lxqMRUlzfKbx+qh0A
 Z4vX80rVlTGKkxsNkRZLrv2oFbLwPVgo1L4G1+4fa1ZTOVIH9dJFdsp/by2rHSUGqVqPIERLn
 yGX1HxMQLm1wUXUNErrfikLTtV0zD1NtQm9+BDeSP75Df45v0N2nVK5yeDwmpJfWkWF4ulbA3
 Q4hQ4ePCTFrMYhFTS9n9aM8XgO2GOEvBZzrqjf/pO1DTIoNGqtiUaZAaBTAl8FaTGrtSbsFQE
 MXgsteKkltRxeKO66TH/hBK8fwR9CF4yYLbQpyZc4iDUwqYHXvIzKTQA/5dr69f/H8J9e/Pfz
 e5r+rr/L9e5Eu9JWL7Lsb5aQc+KMw+tuAL9GtrqK5HBYSZ+A15ko849NJK2Km+OUITggS+09J
 LFH2cYvkRlf2jRplk/KaofyErhxC6VL3hgatTD/BvJLSnPvjf1dqEv5WDaSlJdEWfvSSQlVQl
 vy6T8RkeoUbvl6h/lxYGPa2iQWPqvghq/24U/3GH4pCq9DE33MkpzTZSMJwkxfGQKh6//ZyjC
 BwmIp5oZBJGcAXCqpnfbLglxxTMi0QQreUm338ZlcjzMRXw/hD8KFo5ztONgOlv/yg3M=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/01/2022 à 12:20, Arnd Bergmann a écrit :
> On Thu, Jan 13, 2022 at 11:35 AM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Move virt machine to generic clockevents.
>>
>> cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> The change looks good, but it appears that you only just add the legacy code
> in the same series, and it would be easier to just add the correct version
> first.

In fact, I'd like to keep it separated for two reasons:
- it can be used as an example for people that want to move from legacy to clockevents,
- the machine with legacy timer tick is in use for more than one year by debian to propose a m68k 
buildd and dev machine, so it is really well tested and robust. If there is a bug in my clockevents 
use it will be easier to detect.

>> diff --git a/arch/m68k/virt/timer.c b/arch/m68k/virt/timer.c
>> index 843bf6ed7e1a..767b01f75abb 100644
>> --- a/arch/m68k/virt/timer.c
>> +++ b/arch/m68k/virt/timer.c
> 
> How about moving the entire file to drivers/clocksource/timer-goldfish.c?
> It shouldn't even be architecture specific any more at this point. It probably
> still is in practice, but that could be addressed when another architecture
> wants to share the implementation.

For the moment I'd like to have my m68k virt machine merged, and I think it will be easier if I hit 
only one subsystem/maintainer. Moreover I don't know if I use correctly the goldfish-rtc,  so for 
the moment I think it's better if I keep it hidden in arch/m68k/virt.

But I can propose to send a patch to move this code to drivers/clocksource/timer-goldfish.c once the 
machine is merged.

Thanks,
Laurent


