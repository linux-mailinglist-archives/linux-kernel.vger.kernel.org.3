Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33291533ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244692AbiEYOIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiEYOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:08:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02ADA76DB
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:08:32 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.139]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mgf4k-1nLspk43qO-00h8Jk; Wed, 25 May 2022 16:07:49 +0200
Message-ID: <e0402350-687e-14b6-2e30-4b459afa9afb@i2se.com>
Date:   Wed, 25 May 2022 16:07:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: vchiq: Performance regression since 5.18-rc1
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Phil Elwell <phil@raspberrypi.com>, regressions@lists.linux.dev
References: <77d6d498-7dd9-03eb-60f2-d7e682bb1b20@i2se.com>
 <YoszE8lQ9VcofLtX@linutronix.de> <Yo41ggMvkI1B9TeM@fuller.cnet>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <Yo41ggMvkI1B9TeM@fuller.cnet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:p2z5Oxmov4jctz2aZQ5+CFweQ9+ZNhzGKPD1mZA7B+QEblEEdaD
 tlvpMKuRiEtGObW2wGBheYFDje5vsZm5tBrRl2bgl4SpDQDPy8FY4RoGr14WGSFwdJ2JLwx
 A7J43bqplqke3y0uMcbn0qEjktj9Z4LEG4CVryOnQue3lviFw0hD44zqB6AYPVPAHG0sfpJ
 IageqzzK3P6j5syqUtVaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kNIYU9kHu2I=:LIg2vrOd5uFgdnHurX25Ir
 qwu1g5ExP0CzOALXneYaDKz7c9W5XYVgvx5Ggx1OF2WpyRE+Vcym1HIIyIkyXAS941MxtHknw
 zVWsXJELOA0gJnk/tCEGg/MVW1k9LB9i5sAwsbanBObp7Lmv7azPx+dbOg91+gC57pjTMxOSe
 QE/VOmR2aFnM0WcjPTtYI8bq3+PjoxtPwb4zv4H4USIDD+N9dU8rmPdOqEdOID5m67ue9zHnW
 aKSvEj/CQZhDE+DH8SAp1qWpqEH5CQsMdJ1ESp56YxPVBZTOsbyTe3gt55RAb31Tpg+/QyBON
 lgrUW+JYdkEebUZYa5ZZ7KpWUM8cZwtd1/RG7VD/1qxb8he0USHlz++ott8djTjeAeohY5zvL
 CmwTCi/iCmBo6vRQ44h+a7RXzC0U5XimyHY1fDh3e+zdqK+6vcZ6yZ2n7CmuV8ibQyjzD6LPg
 8kBiv2w2ZQgPX/NkfiiKrIoi9d6NuaO4dru2xT75rBjUblv1HBjC5PfcFJbk/AgV6zPjiyobJ
 uZLGfngTpXajbdX1cjcKuAwcHwWsPfitWq/UuRx3ZkBZdHLQCFPuoThqPZkhMDaM4NjGoOr5v
 sjf+boyI28MP+9U8PtdTYTboUzlu2zyGrp5MZWBaHHNfcgETP7LsgLGo/yYZOD9F/tngEVayt
 9YlBD+x3baMIjX5VJVosHvrGR2BqOgCxL5QkFYIr8PwKvE3PswD14HJljpKKqAi1a7MLvGnbT
 tYLXIjI1cIb+uogACIffw8pdlZG8APrAq4WvyXm27fVH40sxpvMGDoP/q2M=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Am 25.05.22 um 15:56 schrieb Marcelo Tosatti:
> On Mon, May 23, 2022 at 09:09:07AM +0200, Sebastian Andrzej Siewior wrote:
>> On 2022-05-22 01:22:00 [+0200], Stefan Wahren wrote:
>>> Hi,
>> Hi,
>>
>>> while testing the staging/vc04_services/interface/vchiq_arm driver with my
>>> Raspberry Pi 3 B+ (multi_v7_defconfig) i noticed a huge performance
>>> regression since [ff042f4a9b050895a42cae893cc01fa2ca81b95c] mm:
>>> lru_cache_disable: replace work queue synchronization with synchronize_rcu
>>>
>>> Usually i run "vchiq_test -f 1" to see the driver is still working [1].
>> What about
>> 	https://lore.kernel.org/all/YmrWK%2FKoU1zrAxPI@fuller.cnet/
>>
>> Sebastian
> Stefan,
>
> Can you please try the patch above ?

this was the same as Paul send. I think i need more time for 
investigation, maybe there is an issue with the application.

All i noticed so far is that in good case the CPU usage is around ~ 60 % 
and higher, while in bad case the CPU is almost idle. Also the issue is 
not reproducible with arm64/defconfig.

>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
