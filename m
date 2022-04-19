Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AF65072CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354573AbiDSQTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354562AbiDSQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:19:42 -0400
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 09:16:59 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F69139BA5;
        Tue, 19 Apr 2022 09:16:58 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MOiLv-1nHAaj40lT-00Q8zV; Tue, 19 Apr 2022 18:11:23 +0200
Message-ID: <c57d6490-7439-d49f-369c-5356b6c4eeee@i2se.com>
Date:   Tue, 19 Apr 2022 18:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] clk: bcm2835: Round UART input clock up
Content-Language: en-US
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Phil Elwell <phil@raspberrypi.org>,
        kernel test robot <lkp@intel.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220404125113.80239-1-iivanov@suse.de>
 <20220414105656.qt52zmr5vjmjdcxc@suse>
 <0b3356c0-b4c8-91ed-dfde-9f50483ec36f@i2se.com>
 <20220418110516.s7jxsfa3jl7aagrf@suse>
 <2a46bd1c-600b-5bd9-1c19-20c809f63945@i2se.com>
 <20220418113801.uree7rvkzxpiwyni@suse>
 <6adc9c1c-ec75-b52c-9c44-00296eaa00f6@i2se.com>
 <20220419150555.igh6tdxgjb7meygx@suse>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220419150555.igh6tdxgjb7meygx@suse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:k3v/NjHx03Qa/XH+nWoErQY7BDb3NBOyLbmyf1V5wOpAQtoDudw
 4VXzBC+qhQ0H4BHTZqM4sxz+ESp0lpXES+WXAWbdyOtA7U28+GJeGna9MWoPxztgPny06Tg
 hS8Qau/S4iZikBn0umzGHi96HxBgKi+hSanLuFGIlLIGhH1JFD4oquk4WgoWfL+5rtteZtc
 WfE3saZE5EtoY+4A5Blrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T4Jiz90U13c=:whMxW1OBO7TIa3bDIsB8CF
 gl6HKv3l2vVNP/ZfATukcL5xLZh1HEMF5zmBJ19j2VGF2dN6ccMwBElJDU+D0fILlIEnyf6ZS
 ClkXjDby6EFZiehBxT2DCc7M5tg/2/cgqY4obd8VfDBNSQ6Yed4SA9LnhtGu0d3Z374xx67pK
 spIwa7Wcg/h+JJVrZbgCVnyaBwNVuZLSBbUB6XK2b8k9lM3bFlodcZFrhRi6tp9L66kCp7+Qe
 DzCM+AhRsceFR7u7Cj6XMRFsKTdyHhZWkriMGJs7LRobDjr3N+UWUZa8AXkrcvGYHzFBRTA2I
 ff2li5NmRGdYUNIN9i/c8gBQ2l4X1OBS2OUrqUEV1Vb0Mc/OcLkZwIpt16Pv/sF/bkMwSKfYT
 44RLj9c8kW0BDokS6rkHhL83/2WfrZocB7stPZw3pL0EIkzQ+E3mJ/C4sjk/ZZRBKLZp2bM4k
 36tZnATf4ALTSVrg9SVowq+cwsRPLPtVpFNLbtAnJCLwrDAlnfENRvtgBjau0F4kSvfueRODe
 xhVcfjihnOJuAtXnPbqfd79Rd/Q30gRI9VsAJnoXq3q3yQ2KEgIdI3ZsNiMbYb3b8Vch9prV9
 RuGK9Ie47vvBeyrJdAIAc3lLFgGLf8tyAuzS+gEZaL/L+5V7AcTGLLwT+33twGQdZRmHf4ESp
 e5CgLIW4BkCgF+bkn6O36UsRZXUisUFEPd0XedmBwdSK9tTQx79Qwh21zfWUQWqDl1VHlUkzS
 CflDzaTsmNVv/Yru
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

Am 19.04.22 um 17:05 schrieb Ivan T. Ivanov:
> On 04-18 18:01, Stefan Wahren wrote:
>>>> Do you use the mainline DTS or the vendor DTS to see this issue?
>>>>
>>> For (open)SUSE we use downstream DTS.
>> This is popular and bad at the same time. We as the mainline kernel
>> developer cannot guarantee that this works as expected. A lot of issues are
>> caused by mixing vendor DTS with mainline kernel, so in general (not for
>> this specific issue) you are on your own with this approach.
>>
> Yep, I am aware of that. I am still trying to recover after recent
> gpio-ranges fiasco, also still working on fixing non-exported firmware
> clocks, which break HDMI output on some of the devices.
I guess, these firmware clock issues are only reproducible with vendor DTS?
>
>> I know this is a little bit off topic but except from overlay support, can
>> you provide a list of most missing features of the mainline kernel / DTS?
> Well, 260+ overlays for free is not insignificant benefit. Beside few
> breakages from time to time using downstream device tree works fine.

I think the better approach is to add the missing steps for overlay 
support in mainline.

Best regards

>
> Regards,
> Ivan
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
