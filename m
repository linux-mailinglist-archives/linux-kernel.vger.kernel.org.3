Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BC15372D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiE2WsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 18:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiE2Wr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 18:47:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B1A644E3
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 15:47:55 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.170]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MF2YC-1o20Bu1rMO-00FUaY; Mon, 30 May 2022 00:47:06 +0200
Message-ID: <bd8d4306-293e-6755-2f43-c027533d1ff2@i2se.com>
Date:   Mon, 30 May 2022 00:47:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: vchiq: Performance regression since 5.18-rc1
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <e0402350-687e-14b6-2e30-4b459afa9afb@i2se.com>
 <Yo5NQS470wTuDq/f@fuller.cnet>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <Yo5NQS470wTuDq/f@fuller.cnet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Q4/bnpQYeqTZyYV3rxCUCfh0mQig/0UfrYdXJ7wL/7l+YvbbS3Y
 57BojHvt+El4ipo4vGh+DT+flV0nRsZHN7p2etqR+eOlMtSq8lLZOO6HR2RC4WX6LvQ0h7g
 g82AdyonYlGam+YlgSPwHk9cay4moHXj01AOIIy+hb5lg2AFOCAyOlDaLzZdZLjg1J0ssFq
 G6SFcpG464ltDyCdw/XWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oOt7M8ZsNGA=:MVLExm6p1USWJejZUx5ppd
 Y3n8O/ac1PQFSa31Qq1/HPpVVjsh6SSXGH8e5hoaLTMJweIzKh8/Ac4EAG+Wsk5c+IR5phq3F
 B35r8/d5vI5K7D112JJ/WV5QEJckNCNGCna9DOdFxjhIOK6xiRyXbYuADsoNpSVNqAQDraBTM
 iLQYawGmYOGebrqmHCTiaTDqS+HIF6HTrNkLEYkSSiKDLvpsXr8urnv5ti6EPWHO59lj2OcwE
 Soa3eaLdzZwc7+xbWb7WSggzOovKn1Nxwda8lyQWJe/G7W7qlvL58rgKTyGGpSzKMgiAGlDJG
 hCOhXjWdjHPEHYQfvivo8hi/CXASyuqQBH6hjksCVpY69ejhJy9zDQeIsCrbQWxHmZGWuSx7A
 xyQP1utQ6MVflzQrUjYAEHwEL2lRv5mu7F7cEPMCODKW6V5tVEMgQY6A4sy0OSSSBxOUNMAZJ
 LzMo//TQWhvN0/ZfAgMmttBs1HMSS8e5nfIuV0wKwA9SctqKGlEqCufrNGG+OVuCbjPn4pL4V
 MDXRtDFYQrT5uhEpdNrsZjYNiGysGsglpe/Z+Yr3ishglRjeCA7FjLsBDsRycKxl/OZlmJ1zg
 GMkZZa1KNRGjkcfqZXapqgbvhp/t55zgckuYtkTKtAJOAnbPqbB4zW9Fe0TvWbKZ3McD11Xtr
 JpOuEKIvnk9GWAWeh4jrdQhQP/0j6tUBrLtP5MJ8xwyBg4tq/v8+ShZY/y0xKjoy+gp7Z0jqp
 /g9lEkJSDhkUoiPXxRNwrzpc3x7q1L+yZoOesT72BJoIOzX2s+TCypsZh5M=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.05.22 um 17:37 schrieb Marcelo Tosatti:
> On Wed, May 25, 2022 at 04:07:47PM +0200, Stefan Wahren wrote:
>> Hi Marcelo,
>>
>> Am 25.05.22 um 15:56 schrieb Marcelo Tosatti:
>>> On Mon, May 23, 2022 at 09:09:07AM +0200, Sebastian Andrzej Siewior wrote:
>>>> On 2022-05-22 01:22:00 [+0200], Stefan Wahren wrote:
>>>>> Hi,
>>>> Hi,
>>>>
>>>>> while testing the staging/vc04_services/interface/vchiq_arm driver with my
>>>>> Raspberry Pi 3 B+ (multi_v7_defconfig) i noticed a huge performance
>>>>> regression since [ff042f4a9b050895a42cae893cc01fa2ca81b95c] mm:
>>>>> lru_cache_disable: replace work queue synchronization with synchronize_rcu
>>>>>
>>>>> Usually i run "vchiq_test -f 1" to see the driver is still working [1].
>>>> What about
>>>> 	https://lore.kernel.org/all/YmrWK%2FKoU1zrAxPI@fuller.cnet/
>>>>
>>>> Sebastian
>>> Stefan,
>>>
>>> Can you please try the patch above ?
>> this was the same as Paul send. I think i need more time for investigation,
>> maybe there is an issue with the application.
> To clarify: they are not the same patches.
Thanks for pointing out. I will test it ASAP.
>
>> All i noticed so far is that in good case the CPU usage is around ~ 60 % and
>> higher, while in bad case the CPU is almost idle. Also the issue is not
>> reproducible with arm64/defconfig.
>>
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
