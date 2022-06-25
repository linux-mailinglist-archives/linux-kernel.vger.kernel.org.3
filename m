Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9C55AB91
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiFYQYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 12:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiFYQY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 12:24:29 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8FA3886;
        Sat, 25 Jun 2022 09:24:23 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N33V5-1nfjzw2EiT-013QrJ; Sat, 25 Jun 2022 18:24:17 +0200
Message-ID: <fa4f2fba-ad77-e5a9-a78a-680ed5137157@vivier.eu>
Date:   Sat, 25 Jun 2022 18:24:16 +0200
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
From:   Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <CAHmME9qKkL8r7QSwq+2DA54mpMHzqpnq=pi5f0DhKOcB-qezoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fstY23GWpWBXVsievXkgzQyzVCyqfeGInSYRvX7xBZs9sulG7AC
 DyhWEVvaCiaYJ0U7Qp3OcDZnXu4S9ELWbPZBlfd5duSKb5kIn68FmmA5kGBLOraFnyaYOXX
 0ACVci/en8j7esQyYl5U+NCO7FpG1R0eFTa5pwa0GbTBnfFoqk4g/lix32PtIXySeJvHi7L
 8Y2I0dewHAp4GSvV9yGqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KU/oVou+EAY=:aX7Q8WeHq7CkzTvPt2lMC7
 FRSyjSFJoZVrUB7T2VSTmLVLwJJygw7Ef/kl5i1vXt9S/nAE0Kqv/glSI80GF6U7y5a3OuL8C
 ul03yL2ERynn5qITMkJfK73wmtVxqNUvXswmMNBy2Tc6CHFI60ThdpN/l0Y0SsUDIbGUpFGme
 /z5ELmvejd8Io3kcwUC894n2zcfpPtStlMdJpWVFav09+vKtV+NncwDalIDg4LT7APuDkYxLp
 1fjDbFMlIbpC7//W7YArmq9lOSTgol1eim5ydbV2d9Jpo+LdJKvRdltwq+1DierAWYPH6s5zL
 4efsC4ELUwqxGaIqOiZXswB9hahmKk5pDXWkcEf6wNaqFE5oZhBKQpInroAymrrXxfg5I7sWa
 wd4T76QswTnTTszrsEpSWIJwHtPhCF7i6aHhn9PX1YK3B2oh9uzzL8d+uZlxAe1nD0/fZSE8r
 j2jALk1Mg5p+P46KMmlW/eGKi8s3aBsygG//c5ab7EKxrRI1MhwSEP9Uur+Svn8JTBa+9ftZW
 p4J2WRW9FJjQAITRXNz4QbFh1cC9XBw0fz7Uv8X3O9jFc38VOcV/Gih24A2iwGN1KMIqbZ48h
 JolPDDRJWmsj+fs3A1Ma6XWNNEAu5b/SZIzyXXntiVRWP5DV6VfKScU4cNZgmzvdaFPz0NaYr
 6KC+pBktA5ME8SwjfoiaHaXTWZmaa+tAoCMhW5BJmTrSx/1of7+xnrexUE/roILF8oW2OjM4i
 kfQeB2hWdYKSkWqE3oL8IxmsnE+BWMePH7AbRA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/06/2022 à 18:19, Jason A. Donenfeld a écrit :
> On Sat, Jun 25, 2022 at 6:08 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 25/06/2022 à 17:38, Jason A. Donenfeld a écrit :
>>> Other virt VMs can pass RNG seeds via the "rng-seed" device tree
>>> property or via UEFI, but m68k doesn't have either. Instead it has its
>>> own bootinfo protocol. So this commit adds support for receiving a RNG
>>> seed from it, which will be used at the earliest possible time in boot,
>>> just like device tree.
>>>
>>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>>> ---
>>>    arch/m68k/include/uapi/asm/bootinfo-virt.h | 1 +
>>>    arch/m68k/virt/config.c                    | 4 ++++
>>>    2 files changed, 5 insertions(+)
>>>
>>> diff --git a/arch/m68k/include/uapi/asm/bootinfo-virt.h b/arch/m68k/include/uapi/asm/bootinfo-virt.h
>>> index e4db7e2213ab..7c3044acdf4a 100644
>>> --- a/arch/m68k/include/uapi/asm/bootinfo-virt.h
>>> +++ b/arch/m68k/include/uapi/asm/bootinfo-virt.h
>>> @@ -12,6 +12,7 @@
>>>    #define BI_VIRT_GF_TTY_BASE 0x8003
>>>    #define BI_VIRT_VIRTIO_BASE 0x8004
>>>    #define BI_VIRT_CTRL_BASE   0x8005
>>> +#define BI_VIRT_RNG_SEED     0x8006
>>>
>>>    #define VIRT_BOOTI_VERSION  MK_BI_VERSION(2, 0)
>>>
>>> diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
>>> index 632ba200ad42..ad71af8273ec 100644
>>> --- a/arch/m68k/virt/config.c
>>> +++ b/arch/m68k/virt/config.c
>>> @@ -2,6 +2,7 @@
>>>
>>>    #include <linux/reboot.h>
>>>    #include <linux/serial_core.h>
>>> +#include <linux/random.h>
>>>    #include <clocksource/timer-goldfish.h>
>>>
>>>    #include <asm/bootinfo.h>
>>> @@ -92,6 +93,9 @@ int __init virt_parse_bootinfo(const struct bi_record *record)
>>>                data += 4;
>>>                virt_bi_data.virtio.irq = be32_to_cpup(data);
>>>                break;
>>> +     case BI_VIRT_RNG_SEED:
>>> +             add_bootloader_randomness(data + 4, be32_to_cpup(data));
>>
>> In fact, why don't you use the record->size to get the size of the buffer?
>>
>> It seems useless to encode twice the length of the buffer, the second time on a 32bit while the
>> length cannot exceed a 16bit value.
> 
> Doesn't that make the length ambiguous because of required alignment?

I agree, it's why I understand reviewing the QEMU part of your patch.

> Would rather keep this general. As is, it's also much more like the
> others and more uniform to keep it that way. You were able to review
> it and see that it was right after glancing for a second. That seems
> superior to any imaginary gains we'd get by overloading the record
> size.

And what about using a 16bit field rather than a 32bit field as the encoded length cannot be greater 
than the record length?

Thanks,
Laurent

