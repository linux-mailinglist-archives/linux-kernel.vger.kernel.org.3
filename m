Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AEC48FC3D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 11:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiAPK4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 05:56:24 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:38259 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiAPK4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 05:56:23 -0500
Received: from [192.168.100.1] ([82.142.13.186]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M4JeB-1n8m5I1jM1-000H4F; Sun, 16 Jan 2022 11:55:53 +0100
Message-ID: <a3308bbb-dcd1-9869-7df2-79d33dc75cd0@vivier.eu>
Date:   Sun, 16 Jan 2022 11:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
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
Subject: Re: [PATCH v8 3/4] clocksource/drivers: Add a goldfish-timer
 clocksource
In-Reply-To: <CAK8P3a13g_o4mTsOO-4b=WU6TGRHubY7HCt1x1FdXpVmjy6-Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yAYh0kBjspao1FPwwjQFzrwNjusPh/NSMML6K9oI88CPco9mgv5
 /c8hmxM+3/XybS+hh03Ui/WlejayL6CdpHYzvpCKfRB9BxeoSYxVU4d41QVwqqjO40oIWMX
 LGXKZfyN+s7/DnfuMHJTiwphZjQhqhivF5X6/ZBJLhkPycOrqeIKThXMI/4d6rZVZDh3IZi
 Pa1QcqOawYI+vk/hNl2Xg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EHN11PVMIiQ=:NgaScoTv6k50lOY3vSUuKE
 2SDTBwmugBTj1+vfwjT4agENBu+zhw6njZ13A12VeJkrJo+Nhrv/uU1lG+Fd74kRDif08WhRL
 PDpWTQ/S779u7VSpF8GzqKoycSt9jodI4dbSzWZhyZIf4L6elDPcZQ31VKS0sq1Dvc3ujsrsC
 lqdGQLB1/gdZRdpQCSgyEIfdYrb6mY+SrgIaEQ2AdsqCBHZXpmUb/lnpGqT+sdaHBPLQz7vIr
 2HCJG6KsSWkdR/D9wxoIqPXlMHQ+2vpHXdLp9WO+of4UQOj8Wtyr/It2jMcczZCYtcc5wOniQ
 2ECziwxaXkg+deAJcqBdVa78EvKOeD7i9Lnv5MF0YjbLCo9lVx4sCwfStV1xgurGkv/GXqbA+
 YlH9hUitG05TfBqyBBIYfSS2bMGG4UcTGB7leofpk1ZhhAaLzm5V5Nrh5THMgaxvX169K/noP
 v55JrmFImKf/AMwGXJkmr+YOTPtjU8kBT7sWpDqtJFpqlqFrgCLDzSlRp+/lD+LBbhAGXooLd
 YWSdgFE4hTdWym1PUl7UpFjRzPPV2VYyiCWuE4EiRMCRB52ozEax/6jHFrhDharRE2x11DkBY
 DilHdwTxvVdmGMPnl8w9Xhy5BaQeXoGWF96T+qOtskO09E8fGd0ptb0A7B0/qtMM8mu8g9aZE
 s6yQG2AbtQeeH4v5t+m50DEMnedvLpLpDypZDXuekkyEXxaLrwYmZL6lQ0zYQdwfl4Sc=
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
> 

Is it OK if I replace "CONFIG_CPU_BIG_ENDIAN" by "CONFIG_M68K" as M68K is the only big-endian 
architecture using goldfish?

Thanks,
Laurent
