Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6420C48FC6A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 12:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiAPLym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 06:54:42 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:52965 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiAPLyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 06:54:40 -0500
Received: from [192.168.100.1] ([82.142.13.186]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MF45G-1n6vRv3Iro-00FQij; Sun, 16 Jan 2022 12:54:07 +0100
Message-ID: <77e747de-c7d6-314d-e0b0-58852d463326@vivier.eu>
Date:   Sun, 16 Jan 2022 12:54:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v8 3/4] clocksource/drivers: Add a goldfish-timer
 clocksource
Content-Language: fr
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20220115193245.3777833-1-laurent@vivier.eu>
 <20220115193245.3777833-4-laurent@vivier.eu>
 <CAK8P3a13g_o4mTsOO-4b=WU6TGRHubY7HCt1x1FdXpVmjy6-Sg@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <CAK8P3a13g_o4mTsOO-4b=WU6TGRHubY7HCt1x1FdXpVmjy6-Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X3raeUWjLbG4Qv47KMacOpNsSNYi+XeJ1v535mvSQI9q5vKvWK/
 ohgGS/PrmpSvQ1hbNTCXKp5KzkldAxzyDGdxxyQ/uxXI4u5qObM5/ccaVIlt5kf8jd6Yrxl
 plPsDC+2JxuR4Cmzh6Y6DPUzDvBckDbAGpi7a3p+2DjbqnSCZKGs8GYyKOCFR8ejkh4nVql
 640D6HnWL1HzY/pH7iyuA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qm+OVm7QkMQ=:9cX7LUVzh36XwM6BDed5Ov
 sgCqq5kOQzBRNjEA3OK4nBO+t6x4Mk7JKnJlF+I6buSaBxVSRtoo3HJymPf1U5eOoYWiUuKHt
 DFWwizsC0RS+x1Ra14ajoulm+QG1Bsj/VoCu8UiD6Rg/JD/Rqd/VLfGpygScxtzLIDPyluVAq
 rxl3+Jd+NHJQRfkVkceLaXIiJ2fkP9JB1vZ8F9l58KUsQEeIN+dE6JUI9N6Av1fH8WTc5PGw1
 NoyLO0tjWzVCmtPaSQKOTTBuAg+u20EXFfZnwcf0i+en/lkYw14qEyUpi7rVK0VFxUHjS4jW1
 Qhm1Mahrg+CYWnpXuvc5Ba+0EwmMxAka49i+yhgeMjDYf8mHgC3Ak6Ywr/14mWQtbi3gZQydY
 P/k8VgtF1bdZ5udOsYqye5bfFdADSELtH8nrtiQm2ivNTXAyFc8mAuyrr36FqLmpzVdq33cVf
 ai1G4LGtpXV62jjProRKWREd2GbLQnC9rlpxXLGWo2f/uSVAI3JoNoC+p6R0nUB3iw2Nyiy13
 NiS5zqqA9ZUtcxZwTUMnTX3AwDh4T1FxRzizCAK6hTtdAaPGeyb3OVF8hWWgnspIcAnqG7E6G
 ww+QZ2uWm0kJV78yK+KOiGNSSg3ofxUnPH/PBPAdnwr+gXEv06Tn9N6umGQOOCQajomom3fpz
 /dfOT/SDZTpp6tIHmdsl8APCJFfcCkaDRHW8AMs5Vb3DpVKQ9oAM65fh35AeTsTrvbRQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/01/2022 à 11:44, Arnd Bergmann a écrit :
> On Sat, Jan 15, 2022 at 8:32 PM Laurent Vivier <laurent@vivier.eu> wrote:
> 
>> +
>> +/* goldfish endianness depends on CPU endianness */
>> +#ifdef CONFIG_CPU_BIG_ENDIAN
>> +#define goldfish_ioread32 ioread32be
>> +#define goldfish_iowrite32 iowrite32be
>> +#else
>> +#define goldfish_ioread32 ioread32
>> +#define goldfish_iowrite32 iowrite32
>> +#endif
> 
> This is not what I meant here, as you are breaking big-endian support
> for all other
> architectures in the process.
> 
> On architectures that support both big-endian and little-endian kernels, devices
> (including emulated ones) can't know which type of kernel you are running, so
> this has to be fixed by architecture. Ideally this macro should be in
> an architecture
> specific header file, but you can also just make this a check for m68k and  hope
> that qemu doesn't duplicate this bug on architectures that gain support for this
> driver in the future.

Virtio has exactly the same problem in the past (prio to v1.0), and it uses __LITTLE_ENDIAN in 
virtio_legacy_is_little_endian() to know the endianness of the device.

So the code can become:

#ifdef __LITTLE_ENDIAN
#define goldfish_ioread32 ioread32
#define goldfish_iowrite32 iowrite32
#else
#define goldfish_ioread32 ioread32be
#define goldfish_iowrite32 iowrite32be
#endif

What do you prefer: CONFIG_M68K or __LITTLE_ENDIAN?

Thanks,
Laurent
