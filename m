Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D21530A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiEWHhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiEWHgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:36:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E8964D3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:36:36 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.139]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MlbPO-1nSArI0Q0w-00iluk; Mon, 23 May 2022 08:19:46 +0200
Message-ID: <e0503433-615d-3834-4392-d0868caf47cf@i2se.com>
Date:   Mon, 23 May 2022 08:19:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: vchiq: Performance regression since 5.18-rc1
Content-Language: en-US
To:     paulmck@kernel.org, Phil Elwell <phil@raspberrypi.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        regressions@lists.linux.dev, riel@surriel.com,
        viro@zeniv.linux.org.uk
References: <77d6d498-7dd9-03eb-60f2-d7e682bb1b20@i2se.com>
 <20220521234616.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <bfad3d08-3268-5528-17c1-c17ef3949d96@i2se.com>
 <20220523044818.GS1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220523044818.GS1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TSDqooD2qpB0H55oseeE5i/UKDv81lLRHUSkMpF+f6pSH2efkxU
 EU1yOKtb2vv2XBeZV3Z7rj2N+rYHqjAVfDIQZINjoMrt2oFSMCeDKZzYpZMzO4+eh1XlMCL
 EbgZilH5dplMtxW9j4NPfAfbUvgy9HZiKPFs3sP5lpcGKSJ266604KhH7wxBK4GbrFDJNpd
 zOc/AR8e3w/D9hnZ80PLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DOH6rhxMbGg=:SbR34AbzDQsY1Vt0oPmlko
 e1LAFIMgaQ4gVDMsppuotOnUCHQPZP8a0U0HzpCzAtwmrBJe9+FpLRYz6MrnojkxlsDgHYn4M
 lUYmJ7XBKnC+kBIfdXsqNHNn3XBBIsVCESAtMi0djj/+cTY77P3tgyEcGXRlMJDXu7toRHqy8
 8BxlDClEEFVRgMt+KHRClfIEnEEMK2rsC9WSjEgKFyoAgxZvaUHxGsAEZf2ZU8P8sTKOJGmqA
 7VGgRmXqlBCXYVaUabVpg0Nc4Pp4HijUZOsScZiXwDLdoUWZsUUkVOwqUp+dLDYoy4yNJlgvT
 y5+XadRMHQhA0Jwg2MX5PufTa3mnDYNZ8E5bgW3sSrEg4GXpZSbL9osVR16nesvW3xzdUw6z5
 lrjoUPDMq+nkzScVusJgtPuvhYQN8uG19vJBH6se7CONc+L0h/tYPm8uuaeRE7rPDqDfb0TTR
 oENGc8pWqr8J3Vk98S4+LjNZj8ylLF/Y6Wi/4wMXsBmXyGoiMn2GKpcRygnVop2+xveh3+ThB
 dFrhw9ii3bQKQ5Zntbd8mUEADrREj3hsiV3eIpmWmkF6HVAHTkX/8VzcSPuKwZd2PaSVKJK3/
 o8OHN40F3dqAJSD6RyqaNMk3m3OwlRuxjgHbCoP07+pTodtiTRfe+miAkH1GlzFAHviUu8vug
 UFgjL8bQcSKeLhcFy07WCwvqh5xhKL+M7HXSr29U62F6q8FzHO3wuGeRpj83YkB/Ut/BQcCkM
 s9Ef0yOBs3Rhzg6R1aD4FIvIz+eCcXMOjjWnnYd2XzPLkAllP2P8PVO1OXc=
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Am 23.05.22 um 06:48 schrieb Paul E. McKenney:
> On Sun, May 22, 2022 at 05:11:36PM +0200, Stefan Wahren wrote:
>> Hi Paul,
>>
>> Am 22.05.22 um 01:46 schrieb Paul E. McKenney:
>>> On Sun, May 22, 2022 at 01:22:00AM +0200, Stefan Wahren wrote:
>>>> Hi,
>>>>
>>>> while testing the staging/vc04_services/interface/vchiq_arm driver with my
>>>> Raspberry Pi 3 B+ (multi_v7_defconfig) i noticed a huge performance
>>>> regression since [ff042f4a9b050895a42cae893cc01fa2ca81b95c] mm:
>>>> lru_cache_disable: replace work queue synchronization with synchronize_rcu
>>>>
>>>> Usually i run "vchiq_test -f 1" to see the driver is still working [1].
>>>>
>>>> Before commit:
>>>>
>>>> real    0m1,500s
>>>> user    0m0,068s
>>>> sys    0m0,846s
>>>>
>>>> After commit:
>>>>
>>>> real    7m11,449s
>>>> user    0m2,049s
>>>> sys    0m0,023s
>>>>
>>>> Best regards
>>>>
>>>> [1] - https://github.com/raspberrypi/userland
>>> Please feel free to try the patch shown below.  Or the pair of patches
>>> from Rik here:
>>>
>>> https://lore.kernel.org/lkml/20220218183114.2867528-2-riel@surriel.com/
>>> https://lore.kernel.org/lkml/20220218183114.2867528-3-riel@surriel.com/
>> I tried your patch and Rik's patches but in both cases vchiq_test runs 7
>> minutes instead of ~ 1 second.
> That is surprising.  Do you boot with rcupdate.rcu_normal=1?
No, not explicit.
>    That would
> nullify my patch, but I would expect that Rik's patch would still provide
> increased performance even in that case.
I will retest with a fresh SD card image.
>
> Could you please characterize where the slowdown is occurring?

Unfortunately i don't have a deep insight into driver and vchiq_test 
tool. Just a user view.

Do you think an strace would be a good starting point?

@Phil Any advices to analyse this issue?

>
> 							Thanx, Paul
>
>> Best regards
>>
>>> There is work ongoing to produce something better, but ongoing slowly.
>>> Especially my part of that work.
>>>
>>> 							Thanx, Paul
>>>
>>> ------------------------------------------------------------------------
>>>
>>>   From paulmck@kernel.org Mon Feb 14 11:05:49 2022
>>> Date: Mon, 14 Feb 2022 11:05:49 -0800
>>> From: "Paul E. McKenney" <paulmck@kernel.org>
>>> To: clm@fb.com
>>> Cc: riel@surriel.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
>>> 	linux-fsdevel@vger.kernel.org, kernel-team@fb.com
>>> Subject: [PATCH RFC fs/namespace] Make kern_unmount() use
>>>    synchronize_rcu_expedited()
>>> Message-ID: <20220214190549.GA2815154@paulmck-ThinkPad-P17-Gen-1>
>>> Reply-To: paulmck@kernel.org
>>> MIME-Version: 1.0
>>> Content-Type: text/plain; charset=us-ascii
>>> Content-Disposition: inline
>>> Status: RO
>>> Content-Length: 1036
>>> Lines: 32
>>>
>>> Experimental.  Not for inclusion.  Yet, anyway.
>>>
>>> Freeing large numbers of namespaces in quick succession can result in
>>> a bottleneck on the synchronize_rcu() invoked from kern_unmount().
>>> This patch applies the synchronize_rcu_expedited() hammer to allow
>>> further testing and fault isolation.
>>>
>>> Hey, at least there was no need to change the comment!  ;-)
>>>
>>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>>> Cc: <linux-fsdevel@vger.kernel.org>
>>> Cc: <linux-kernel@vger.kernel.org>
>>> Not-yet-signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>
>>> ---
>>>
>>>    namespace.c |    2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/namespace.c b/fs/namespace.c
>>> index 40b994a29e90d..79c50ad0ade5b 100644
>>> --- a/fs/namespace.c
>>> +++ b/fs/namespace.c
>>> @@ -4389,7 +4389,7 @@ void kern_unmount(struct vfsmount *mnt)
>>>    	/* release long term mount so mount point can be released */
>>>    	if (!IS_ERR_OR_NULL(mnt)) {
>>>    		real_mount(mnt)->mnt_ns = NULL;
>>> -		synchronize_rcu();	/* yecchhh... */
>>> +		synchronize_rcu_expedited();	/* yecchhh... */
>>>    		mntput(mnt);
>>>    	}
>>>    }
>>>
