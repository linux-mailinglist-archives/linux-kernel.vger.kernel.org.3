Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851AE55AB92
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 18:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiFYQ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiFYQ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 12:27:48 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E3113F48;
        Sat, 25 Jun 2022 09:27:47 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M58OQ-1o42Ad3OFQ-001DqP; Sat, 25 Jun 2022 18:27:43 +0200
Message-ID: <4b0eb04d-564e-3111-a460-27934976084e@vivier.eu>
Date:   Sat, 25 Jun 2022 18:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] m68k: virt: pass RNG seed via bootinfo block
Content-Language: fr
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220625153841.143928-1-Jason@zx2c4.com>
 <512bdf97-5468-e2d2-75bd-24107aaf8a34@vivier.eu>
 <CAHmME9qKkL8r7QSwq+2DA54mpMHzqpnq=pi5f0DhKOcB-qezoQ@mail.gmail.com>
 <fa4f2fba-ad77-e5a9-a78a-680ed5137157@vivier.eu>
 <CAHmME9oGOduYbw_-=0QeKzW6Lj07S6tevssvUpyWLgutuxE+UA@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <CAHmME9oGOduYbw_-=0QeKzW6Lj07S6tevssvUpyWLgutuxE+UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nfqBjMzmXFtTPd3gPKZG71NthEx9WLAcXw1BVmjES4dX0Let/sF
 GodTz2ULpJCa1UnX/6eH7c+061e7kGrax8rZ0RgEmO6rRKkzCZYv9p7Bd7H4fTv36GxUdyv
 /87s2DzbmtO1huIfLAN5Sv7TzFhNXFZVvJBqy2guCJcridA3BPNpUS0J/8QYYbbIhivydQV
 RLch8lgLayVEoSZ6FT1TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QQZVMIufM30=:9mbWBF8rAABdASCRbK2+H4
 QkTc/LgWY+x8Ur4aolIpmAN7j5sg+28PATgErX75TEN+c1pFwS6aEkfDGJ5f0QuEZmvCmu/Xv
 fRsywJ3lm9Rh/jy81cGuRyOLzVZ2yTv8wOA71WqQxvZgympKNX4nvyUd2kQM3xr2dmvNWA2nB
 bipWglQ5d8Rtvbf9CjK7YEWJ9uqDAJ6ncocISnlmpEdiczddhqC6yUns89vgkOpnTuFxF6bc+
 xmZ+8XCFJwWHWa9Oj+B3IpmxCNoH8K5TCg7bvs77pggofQvNAF4YA3iyOjXTxGvNrJNLVKuNs
 9JdIVQGIaLVgU6q41CAGLX7X6IgmNnWlx8yiWTlZCNsdyeWgtnzWbo4tnv2AxQVM54P6pzodR
 c1TZkXnJQe6r6m8U5cTpV3xjM63uaOx/uM43+YCKDi5efvRnhlg75jFLk4zyPxZLEGYO8SOeP
 9GEeKyslyVcfqxVnDA+DjeYIFleyKuMuV9TP4atFs4mddoVS33guTcU5vW9GhmGJ6BIVRQzSu
 DBWvwPCVPJ+8qbx2dfC6LCe8Bo5sz4RVMvHH5CZoHkDh7HM05RaSOcwP7Ui+BKZo5J6CT8bL/
 hhRSGUyAEyqhWjc5f/7W3z0RW8r/XBxDROtacccFDpCqkysBunAHzsrZ0I7XXcpx5DJom1GiA
 VX41+bn5oL5J2NjGh7a5JSievQo3Xjyv1ZnlSYL45bPNonkjrpcJKrzh7pSPtfPBf3E1VfAMq
 gV92MxBv8R8Wq3EfgX130AYEu98hqMaF8+A3XjpHn0OLeUaky2MBfAvUnMK1ULb09RNUlw9+1
 WF0Y1bzhyMUhtMPscVB8YmMIivLNgM1xc/np01SOa1nsbiPYyK3ChDBeNlMLjr+zYbAWBmD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/06/2022 à 18:26, Jason A. Donenfeld a écrit :
> On Sat, Jun 25, 2022 at 6:24 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 25/06/2022 à 18:19, Jason A. Donenfeld a écrit :
>>> On Sat, Jun 25, 2022 at 6:08 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>>>
>>>> Le 25/06/2022 à 17:38, Jason A. Donenfeld a écrit :
>>>>> Other virt VMs can pass RNG seeds via the "rng-seed" device tree
>>>>> property or via UEFI, but m68k doesn't have either. Instead it has its
>>>>> own bootinfo protocol. So this commit adds support for receiving a RNG
>>>>> seed from it, which will be used at the earliest possible time in boot,
>>>>> just like device tree.
>>>>>
>>>>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>>>>> ---
>>>>>     arch/m68k/include/uapi/asm/bootinfo-virt.h | 1 +
>>>>>     arch/m68k/virt/config.c                    | 4 ++++
>>>>>     2 files changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/arch/m68k/include/uapi/asm/bootinfo-virt.h b/arch/m68k/include/uapi/asm/bootinfo-virt.h
>>>>> index e4db7e2213ab..7c3044acdf4a 100644
>>>>> --- a/arch/m68k/include/uapi/asm/bootinfo-virt.h
>>>>> +++ b/arch/m68k/include/uapi/asm/bootinfo-virt.h
>>>>> @@ -12,6 +12,7 @@
>>>>>     #define BI_VIRT_GF_TTY_BASE 0x8003
>>>>>     #define BI_VIRT_VIRTIO_BASE 0x8004
>>>>>     #define BI_VIRT_CTRL_BASE   0x8005
>>>>> +#define BI_VIRT_RNG_SEED     0x8006
>>>>>
>>>>>     #define VIRT_BOOTI_VERSION  MK_BI_VERSION(2, 0)
>>>>>
>>>>> diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
>>>>> index 632ba200ad42..ad71af8273ec 100644
>>>>> --- a/arch/m68k/virt/config.c
>>>>> +++ b/arch/m68k/virt/config.c
>>>>> @@ -2,6 +2,7 @@
>>>>>
>>>>>     #include <linux/reboot.h>
>>>>>     #include <linux/serial_core.h>
>>>>> +#include <linux/random.h>
>>>>>     #include <clocksource/timer-goldfish.h>
>>>>>
>>>>>     #include <asm/bootinfo.h>
>>>>> @@ -92,6 +93,9 @@ int __init virt_parse_bootinfo(const struct bi_record *record)
>>>>>                 data += 4;
>>>>>                 virt_bi_data.virtio.irq = be32_to_cpup(data);
>>>>>                 break;
>>>>> +     case BI_VIRT_RNG_SEED:
>>>>> +             add_bootloader_randomness(data + 4, be32_to_cpup(data));
>>>>
>>>> In fact, why don't you use the record->size to get the size of the buffer?
>>>>
>>>> It seems useless to encode twice the length of the buffer, the second time on a 32bit while the
>>>> length cannot exceed a 16bit value.
>>>
>>> Doesn't that make the length ambiguous because of required alignment?
>>
>> I agree, it's why I understand reviewing the QEMU part of your patch.
>>
>>> Would rather keep this general. As is, it's also much more like the
>>> others and more uniform to keep it that way. You were able to review
>>> it and see that it was right after glancing for a second. That seems
>>> superior to any imaginary gains we'd get by overloading the record
>>> size.
>>
>> And what about using a 16bit field rather than a 32bit field as the encoded length cannot be greater
>> than the record length?
> 
> I guess but that's different from all other length fields, and means
> we can't expand past 65k if somebody wants to use this for something
> more interesting later. Again I wonder what stinginess here gets us.
> This is just a boot parameter... No need to go crazy optimizing it.

I agree too.

Thanks,
Laurent

