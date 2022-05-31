Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E45538B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244171AbiEaGFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbiEaGFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:05:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7513915BB;
        Mon, 30 May 2022 23:05:42 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MOzfO-1oAHYT2AcG-00PPL4; Tue, 31 May 2022 08:05:05 +0200
Message-ID: <64ce78bf-b81b-1eec-74f3-650a72f2874b@vivier.eu>
Date:   Tue, 31 May 2022 08:05:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: fr
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alessandro Zummo <a.zummo@towertech.it>
References: <20220406201523.243733-1-laurent@vivier.eu>
 <20220406201523.243733-5-laurent@vivier.eu>
 <3b783435-e734-5391-e758-d709e0462839@infradead.org>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v16 4/4] m68k: introduce a virtual m68k machine
In-Reply-To: <3b783435-e734-5391-e758-d709e0462839@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2M69cKCgAGhvU4Z/bGcKhkLwEhWFsUmCE+MqAJdvr4dlqoONtTU
 RQJBHeLTTXHZA94FtxY0BElJEHXoWFuWGF7AmwZeiT25mssQi3qwVl/Mc/E+oDDtaqZB0yU
 XMLrr6zRhptT4gnGp4SrefTG/+GiovC4VAvB3ox0Us0OUswiObaSU86t1A7+IDhEUtDA9X8
 6LPvQaAmK28DZIKRpkxTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MBqzMUNXwxg=:rU6kous+bRw+MQsAtRJA8m
 nguTb1stmOwoWhTdm9ZIogkdZI9TAbqfP+/caTcVZ0f/gnGCFTciomaSvjbTtPKdsGboL939E
 5LEcgT2Ri7qDpMrLt+NoIYz1nqQmwRZLWRrnoG0vJKFWzq4b3nF71SJDbPTswQcKZFoQ4i7Rf
 WZoy1BSfVD8qoj3LKxFxEjazY51pN7RC/dxRj0kxvg9w6Be8FQdq35IqRiSSqTvTqdlLK99N3
 Hn/UAgQUW+wQuqWpEmc8DL8qQ3ARL5Ylj291NxAmUO57RG+LlzqPQ5gVhIgGt8vkq6QWcvVzF
 bpvvWx4aPxPpe/eYA/8YSLs3cZKX18jZArsNpHb7XtY8MMOMaBBt7fi5gXRVjV/OGp9ttX2Bb
 Nz8Z8+kghshRk+4Tfe91Rj5xyM16qAm3k1r0/mC4uEuGMlFpPH5i/xpuSkczImfWqOau/dwhC
 drDZdNj500mFuoAaaH6xHsbDuOv8ZjotL/80jfpAUEzCfoqAq1xqrHTg4SXok8jk2wzUz8IEz
 X86ZiVPLBaKE+IRfPyv+3i1n1fhu/7SZGRVGf7qHwiPT2kg3PjcCZFrBtoxxfGOM329lXb4jf
 IywZ+9kYGexGheEdCl1OoZdLUEF2mTT0dKQAsyFKZYHkNZlhUh47qqcYETKstteYJvDrw/5FA
 3h5Wox2FY4uBhYq9z1Fmwfe6dUIBXDdU1ylf497DcWhootrFeWfPz56wI0+oD5RxC2s9CP3Xo
 Zd4eTBiO60ZnJSPn30PBWhKMYdfi6DhUdUIBzA==
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 31/05/2022 à 03:14, Randy Dunlap a écrit :
> Hi--

Hi,

> On 4/6/22 13:15, Laurent Vivier wrote:
>> diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
>> index eeab4f3e6c19..188a8f8a0104 100644
>> --- a/arch/m68k/Kconfig.machine
>> +++ b/arch/m68k/Kconfig.machine
>> @@ -149,6 +149,23 @@ config SUN3
>>   
>>   	  If you don't want to compile a kernel exclusively for a Sun 3, say N.
>>   
>> +config VIRT
>> +	bool "Virtual M68k Machine support"
>> +	depends on MMU
>> +	select GENERIC_CLOCKEVENTS
>> +	select GOLDFISH
>> +	select GOLDFISH_TIMER
>> +	select GOLDFISH_TTY
>> +	select M68040
>> +	select MMU_MOTOROLA if MMU
>> +	select RTC_CLASS
>> +	select RTC_DRV_GOLDFISH
>> +	select TTY
>> +	select VIRTIO_MMIO
> 
> This select VIRTIO_MMIO can cause a kconfig warning:
> 
> WARNING: unmet direct dependencies detected for VIRTIO_MMIO
>    Depends on [n]: VIRTIO_MENU [=n] && HAS_IOMEM [=y] && HAS_DMA [=y]

In my repo, VIRTIO_MMIO has no dependency on VIRTIO_MENU:

./drivers/virtio/Kconfig
config VIRTIO_MMIO
         tristate "Platform bus driver for memory mapped virtio devices"
         depends on HAS_IOMEM && HAS_DMA

>    Selected by [y]:
>    - VIRT [=y] && M68KCLASSIC [=y] && MMU [=y]

How do you generate this warning?

The first version of my patch added the VIRTIO_MENU but Geert said it's not necessary because 
VIRTIO_MENU defaults to y.

https://lore.kernel.org/lkml/CAMuHMdUFh2W-bY5Ez1aOTZQjq0=THvmOf22JdxWoNNtFLskSzw@mail.gmail.com/

> 
>> +	help
>> +	  This options enable a pure virtual machine based on m68k,
>> +	  VIRTIO MMIO devices and GOLDFISH interfaces (TTY, RTC, PIC)
> 
> The sentence above needs an ending period ('.').
> 

I agree.

Thanks,
Laurent

