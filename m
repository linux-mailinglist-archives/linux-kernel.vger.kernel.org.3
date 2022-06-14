Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369FB54A98F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiFNGfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbiFNGfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:35:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FD637A25;
        Mon, 13 Jun 2022 23:35:10 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.155]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMWgb-1oKap12dmR-00JeZt; Tue, 14 Jun 2022 08:34:52 +0200
Message-ID: <ed07ffc9-a6a9-7f7e-a34a-51c1a94ffe88@i2se.com>
Date:   Tue, 14 Jun 2022 08:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ARM: dts: bcm2711-rpi-4-b: Use aliases to set custom MMC
 device index
Content-Language: en-US
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Peter Robinson <pbrobinson@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        gkrzysztof.kozlowski+dt@linaro.org, gnsaenz@kernel.org,
        grobh+dt@kernel.org, nsaenz@kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20220608123233.13439-1-ariel.dalessandro@collabora.com>
 <CALeDE9PR80qS63wwAKB-hENWbEj1xNHj+k81tyWkPPfZ0TS8Pw@mail.gmail.com>
 <f83690bb-5513-db87-2d97-7cbd981aa0f7@collabora.com>
 <d18e93a0-f2d7-81c6-56e8-9dfbc6f14383@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <d18e93a0-f2d7-81c6-56e8-9dfbc6f14383@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UbHWjvDAnm4TlXK+jOtZlK+fEY96IEagfLHq8aiDgCaKUUnrdsG
 ruElF8BE8itRPHeu8eERO/tRmj+/moSlFcH0/35aqVgxV4lm0mjUqK+YMO16q2K1UHxGr2M
 EO4MrDkMSI4yXLX3EQLns1cQpqqjxJ/9laiws/SA5IjcDQ9bvYqHCuHVlFj0/p7mSo+m0JS
 XZDzcLoR38ruvYmStsn/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UlzaYFfiUz8=:UJS1QEZbIzY5mFOaoNaB2C
 Wo0Cmr9BNrT//vROqS86bhD9rFHA72tUEzXLLDgX3LjEx9nRX3VOQjNOpyO7om/DPDW66VQ9s
 T3LARFxFQP4Q9bI+zH8U+ywHHOf6QVCPqFv1oHnFe42VBAp0c7PzH6EPcVins72gepA2PtSs1
 4YOcw2iPrK2gotQVX0doxE/3my3AIkP2nhzmefIN65C3rylFKdkaUf/oEQDMIgUfHHC4BromX
 Hv9IIG2tmLAMrbAx298oy2BhLLCchPw32S/LjRKXw+t/d8xjz0MyCHxOozNF1rVZvwxHsAisW
 G311OHfEQJAn3qKdxV7SWVqoP6f0jU4icOhdRg96IpJIGnph+lhwTM4ylMmqjvMG0Vp+W++AB
 JTyMvXhWy9vS6t92L9usls5X2iBol0LqOuQpwEL6vMIxEL2TY9qGwLxAPTs/zWPzTr2miF8KT
 6mwHPsqT9N3+wnfgl6o0pmKiBVpqg+22DOSj9Zcl63tat910v3MN170EVay/wKQyDMu9jcqxl
 5RKKl8Ifd94Mycb0GLfh3VGQUYEMTewjvFE/Ah+D7HoGTwb/HPH67UQPCfSyFmJLjSzLnyKil
 G90tlCm6+2i51XdNj8fpzbu2z9aTo5zEUh802QEb+Z3SYXFZmUzLjE5GQ6IQU2IS9+q71ffwX
 7aDlxN+Yd4qPhcEBX1Cq3shxJjaf6W9yFYLRpO9P88Z3b8VtU7EUlT0vACpvkrx08ByURgZ2b
 +RADuItKzWlgo0NVkSs9nsPS5PQHnGdJRtgLlWbFN0co8te38QomTbe/OI0=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.06.22 um 01:34 schrieb Florian Fainelli:
> On 6/13/22 05:46, Ariel D'Alessandro wrote:
>> Hi Peter,
>>
>> On 6/12/22 17:38, Peter Robinson wrote:
>>> On Wed, Jun 8, 2022 at 1:35 PM Ariel D'Alessandro
>>> <ariel.dalessandro@collabora.com> wrote:
>>>>
>>>> Add MMC aliases to ensure that the /dev/mmcblk ID for SD card won't
>>>> change depending on the probe order of the MMC drivers.
>>>
>>> Is  the bcm2711-rpi.dtsi a better place for it given there's other
>>> aliases there and it will be consistent across variations?
>>
>> Yes, indeed, it makes sense moving it to bcm2711-rpi.dtsi
>>
>> The other board what will be affected by this alias is the Raspberry Pi
>> Compute Module 4 IO Board, on which emmc2 is the eMMC. However, the
>> alias makes sense, to have that as the first mmc device.
>>
>> Maybe we can add the alias as follows?
>>
>>      mmc0 = &emmc2;  /* mmcblk0 for eMMC/SD */
>
> You have made a typo on the bcm-kernel-feedback-list meaning that this 
> won't reach the patchwork instance I use to manage and apply patches, 
> can you please fix that up for your v2? Thanks!
Not just the bcm-kernel-feedback-list is affected, also the address of 
Krzysztof, Rob and Nicolas has a g prepended.
