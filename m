Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770CC4952E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377240AbiATRJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:09:55 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:54389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377242AbiATRJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:09:34 -0500
Received: from [192.168.100.1] ([82.142.13.186]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MatZr-1mZLAn3xiF-00cUYe; Thu, 20 Jan 2022 18:09:07 +0100
Message-ID: <cb884368-0226-e913-80d2-62d2b7b2e761@vivier.eu>
Date:   Thu, 20 Jan 2022 18:09:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220120080347.1595379-1-laurent@vivier.eu>
 <20220120080347.1595379-3-laurent@vivier.eu>
 <CAK8P3a1oN8NrUjkh2X8jHQbyz42Xo6GSa=5n0gD6vQcXRjmq1Q@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v11 2/5] tty: goldfish: introduce
 gf_ioread32()/gf_iowrite32()
In-Reply-To: <CAK8P3a1oN8NrUjkh2X8jHQbyz42Xo6GSa=5n0gD6vQcXRjmq1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dddbphkpSIF6p9YP9xYcw9vEmF+op0Ndo1F40uOawLCcXjeMmby
 bzCBkRZkM916Hemr2XwL4CE+QGkvN9gPsdnDZSoBwFeEEF1+P71tAnSEekxfLcnseozmQIZ
 BFedbjRVjUqTrfdGkbfmRKXX3eHaVOMuukaBkOkfkMxV736K6p9Vw1SPkFrsNFT2UjO+T0c
 kA55JRy6V+N/CaihCUAVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dy7v5wb7I0k=:yylvJx+860sEkjPyrIC1H8
 gVm97KvhlrbB7LDmCyziiAT8iq/NfLr2vvH5lp3V5l8hQiyEbH2DoO0Re2ofm8pId0JZ/EiBN
 B2cu949M9qo/mqWwSEipoGgH7fNy1b8Vx4RAxLGz4k+9det3NYOz4YMSN13/agp5gcQaIBlcp
 fVlJ8rIQbiJmiTKXvjRe0g0F9IOdz4xDES+FGeeqS6UI8/PmQicu9sKGIB5TwqkNl05RhcoRm
 nqXRkgjBTILY9TuOplO0v3dw8QubtGKug/O0EB/o34hmLo5n6QT6Vhc/jIgvM4aNEFOV/YoMb
 IW6RfezQCCe7HzGreO+6KpRXuz4We17N6wlr8rKpBPgjE0W0jJZPZs7jVl8YiPPvLVjNxbeNt
 +CDACzRdD4WODjEBfVRE0xYbZUpUoi/OZFL4lbiA8KrnRhGe86CW36Mbfs95Tuxq+up/HN0zy
 BRnVF4DbBpNW/Pgj6qM1XPdSZIRZ5FP1cixDGWpud2Ine6WpIQrH9cPiA0jaftWv4cZqK/xRV
 hTv0N3mIjhKbIXR+W88kvpJVkbjpy+XCd19S2i7IgUsvOcm2UurA9fWHxqFTdih3JvOscxZ4G
 olAP2EPrLZtUcgK9ZZNc3pNjiU1CgiA2OhzxMHAXtInR2BzoUIALDTbEdhDFMadAWI88Nm3FU
 mALgZhB2l9/KRGEMhZIlRPb7Lgfxj0m4Plz4hwBIujqUjQBKiTeRpa8UTmxmW4s58YfE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20/01/2022 à 09:50, Arnd Bergmann a écrit :
> On Thu, Jan 20, 2022 at 9:03 AM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Revert
>> commit da31de35cd2f ("tty: goldfish: use __raw_writel()/__raw_readl()")
>>
>> to use accessors defined by the architecture.
>>
>> Define by default the accessor to be little-endian as we
>> have only little-endian architectures using goldfish devices.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> The patch looks good, but the description seems wrong to me:
> 
> Talking about "little-endian architectures" makes no sense here, the
> point is that the device was clearly defined as having little-endian
> registers, and your earlier patch broke this driver when running
> on big-endian kernels (if anyone ever tried this).
To explain why I did that:

The reference document[1] doesn't define the endianness of goldfish.

In QEMU, goldfish devices are defined with the DEVICE_NATIVE_ENDIAN flag [2], that means all the 
target architectures defined in QEMU with TARGET_WORDS_BIGENDIAN will present them as big-endian 
devices, the others as little-endian devices.

According to TARGET_WORDS_BIGENDIAN definition:

On the following QEMU target architectures (qemu-system-XXX), goldfish devices must be accessed with 
big-endian read/write:

mips, mips64, s390x, sparc, sparc64, or1k, m68k, ppc, ppc64, xtensaeb, hppa, sh4eb, microblaze

On the following QEMU target architectures, goldfish devices must be accessed with little-endian 
read/write:

arm, aarch64, alpha, avr, cris, i386, x86_64, microblazeel, mipsel, mips64el, nios2, riscv32, 
riscv64, rx, sh4, tricore, xtensa

Thanks,
Laurent

[1] https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
[2] 
https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/char/goldfish_tty.c#222
