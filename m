Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4240D52E962
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244586AbiETJxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbiETJxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:53:33 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898FFD343
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:53:31 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220520095328epoutp03afa3c33a695344b683f6bbccea71685a~wx343HMcF0441204412epoutp03C
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:53:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220520095328epoutp03afa3c33a695344b683f6bbccea71685a~wx343HMcF0441204412epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653040408;
        bh=nbJ7UWW7ivT1HIaQuG8XTTy89+C6/yNHA4oAaEHtNqs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=V3JzrirJotMovsJofUdAh95aoFGDv3Kvn5zXNx7JDz+7J43qyRV2YJU2gRNboMSfC
         JOKcO1SfBzpXldnGoD8kTdh6NfJR/nBpNwd39r9qILovB01stwutnnAPQNj31Enkf9
         gv36hxnWgZvNuImeIoYZMJwinbHnWKine5qhLKgg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220520095327epcas1p351ae2febf4395766a8d314ee8534e14e~wx34RoyZu3084430844epcas1p3T;
        Fri, 20 May 2022 09:53:27 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.136]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L4MVZ1NhVz4x9Q0; Fri, 20 May
        2022 09:53:26 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.23.10063.51567826; Fri, 20 May 2022 18:53:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220520095325epcas1p4ad7d5c5e4cff944f6f67a5bd0ba9af87~wx32YnA131083610836epcas1p47;
        Fri, 20 May 2022 09:53:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220520095325epsmtrp2eb3f663933e317e81df6ef23884b9aa4~wx32WOKXk2199021990epsmtrp2Q;
        Fri, 20 May 2022 09:53:25 +0000 (GMT)
X-AuditID: b6c32a35-1f1ff7000000274f-55-628765154624
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.46.11276.51567826; Fri, 20 May 2022 18:53:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220520095324epsmtip27687a67ded3390f89917c98115a2612e~wx31xvksN0376803768epsmtip2g;
        Fri, 20 May 2022 09:53:24 +0000 (GMT)
Subject: Re: [PATCH v25 0/7] soc: mediatek: SVS: introduce MTK SVS
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fan Chen <fan.chen@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        =?UTF-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <rex-bc.chen@mediatek.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <eacf7a67-bc64-a764-e23d-c733a4666b8a@samsung.com>
Date:   Fri, 20 May 2022 19:20:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAGXv+5EsgiXCpe-8H0cQ=qm_Nq+yfM_a4b1L=hOFP6mcwfZymw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1BUVRTHu28f+wNm9bXy47JqwlNrpIBd2aXLAmbpyHOsicbqD2cMH/Bg
        d9hf7Y8mf1RbECyGCjEEgiEKGpEhrMSvYBkJW4jQcBUVWrRZDIEQExcRstplsfjve+75nHvO
        9945XJYgkyPkKtQGRqemlSTbF2/8YUNkeCCTkyxquIehhx9XcpCrxISj410XfZB90MVCv8x/
        zUYzv85jyNZRxUG3zzkxZHEOuLOtx9jIntkP0PShLoBGTvyMoVPX+jH0SVYU+mO2D0OO4W4c
        3a8148jaW8xCn7Z3cZDdWc9Gfw/U46gk2+6zOYg6U34GUGWmfpxqKXVwqAqLkbLU5LKpc1Uf
        UVk9HTh15LGIanlo4lC2600YNW15JtFvV0acnKFTGV0Io07RpCrU6fHkjp1JW5Kk0SJxuDgG
        vUiGqGkVE09ufTUxfJtC6TZMhrxHK43uo0RarycjN8XpNEYDEyLX6A3xJKNNVWql2gg9rdIb
        1ekRasYgE4tEG6VucE+GvG/4Aa4tlLxf9VuVjwl0P38Q8LiQkMDvy0+Ag8CXKyCaASyrb8G9
        wX0Ac1y1i5kZAMfqRjlPSj6vdrI9WkC0A3ijguuFpgAcsOYvJFYQr8ChjlG35nL9ifWwtW2l
        h2ERTjZ0uBpxD8MmwmDHnesL/HIiFF6ddQKP5hOb4Mz4aR+Pxt21RQ7bAhNAvA17GrMWmadh
        z9GRhXt4xBvw5g3vcCwiCA6OHMe8eg1smjzG8jSGRBMPftNdj3kdbIVjjiOLblbAcVvDohbC
        6bvtbG9BJoCmO0PAG+QBeOH3w7iXioIdpwoxjzUWsQGebY30HofClvkvgbfzMnjXlefjQSDB
        h+ZsgRdZC+23HIszBMPKnFx2PiBLl/gpXeKhdImH0v+bVQC8BgQyWr0qndGLteL/vjtFo7KA
        hW0IkzaDgsl7EZ0A44JOALks0p8PVFnJAn4qvXcfo9Mk6YxKRt8JpO4XLmAJA1I07nVSG5LE
        khiRJHpjlASJo8VkEL/mi15aQKTTBiaDYbSM7kkdxuUJTRhD15kTRMIPFRPpia2vxc6NzTVs
        W5ZA7/7rhVV1Mrbv/urpbwvXxV147JpYK/hn7Cr1YGi1ZM2W2uL8tFnZ4YwDlyb+7F3nGqwp
        j5nIV2Szz4cro3ekJXzl985N3+jtO+tsac9dCjqbrH4rvSCsrUHRV9C564OiXL7xO2vfnK16
        dHPsT8+e16mQ+U1EBBeVBfvfqtt+bVA2+bJs97tiILHe9ivMazOHvq7jXUyLuHK6uUTZH9eO
        hTqNllj71KNHJ1f+iPZM4nq1YIalKM6RFq+SZ/UIzcvrM6OeCjR1W0asq6+s/0w63Ht5/5T1
        pQOu4TX79soukwFHx08ylXNBvvJA3gSJ6+W0OIyl09P/Aj40N/eWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7bCSvK5oanuSwfKvghbfGxezW3yd0cBi
        Mf/IOVaLy7e+Mltc+L2SzeLbnd9MFsf3L2G3eLr5MZPFpsfXgLK75rBZXG6+yGjxufcIo8WT
        hWeYLJZev8hk0dRibPHmx1kmi7v3TrBYfFrXwWKx7/R0ZovWvUfYLS4/3shm8e/aRhaLGW2X
        WR3EPdbMW8PoMbvhIovHzll32T0WbCr12LSqk81j85J6j5aT+1k8+v8aeOz83sDucfzGdiaP
        z5vkArijuGxSUnMyy1KL9O0SuDLO3vvCUjDZpGLJwyWsDYwntLsYOTkkBEwkJq14zNbFyMUh
        JLCbUeLbvgWsEAlJiWkXjzJ3MXIA2cIShw8XQ9S8ZZSYOOELC0iNsICTxO39z9lAakQEVCV2
        7ZEGqWEWeMomcfXTARaIhm/MEvuerGAHaWAT0JLY/+IGG4jNL6AocfXHY0YQm1fATuLbq2Vg
        i1mABk29exysRlQgTGLnksdMEDWCEidnPgFbzCkQKHH/5nOwmcwC6hJ/5l1ihrDFJW49mc8E
        YctLbH87h3kCo/AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5
        uZsYwSlCS3MH4/ZVH/QOMTJxMB5ilOBgVhLhZcxtSRLiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        e6HrZLyQQHpiSWp2ampBahFMlomDU6qBKfSI4fM6my61S51vP8jOkus+Z+iXWtfuuDLOYZ0z
        w4z0px2qnOcsMn9rzrs6Z0P3YU3XIHuZTznT96qcK0tmlNuw1Wfro9dtzdPYZA73feWPadVN
        WDvxnLq5U6iU66/0vb7zgtPqpyQlF61Mm1jHXc2hYvtZ2S+5bWqo0I5wdYb8me/PHU0v4wnb
        6Oqn4Ox9udtq2+4t/doBEet7fUpP5nmdqT2aLa82ralnRqzdh1VzlghdWsCcKqV74fubLxGe
        XwIrWydxWkUePrDnvCuvh3yQyotre79YvTqfNmFzYvQUC6YFwWneotxp5l2f+R277ed9uufX
        ncvvzHOyMWz29IfZtxJyhVZNEL4XGKLEUpyRaKjFXFScCABX1kywgAMAAA==
X-CMS-MailID: 20220520095325epcas1p4ad7d5c5e4cff944f6f67a5bd0ba9af87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220519182512epcas1p3020bd4713580c9244f759971b8bd2c3a
References: <20220516004311.18358-1-roger.lu@mediatek.com>
        <CAGXv+5GSdWPZe3fNpBJ_WW0zCL8Skg6fHx9ATxaKU1hyMEt2Ww@mail.gmail.com>
        <7h4k1ndaui.fsf@baylibre.com> <7hy1yzbtb7.fsf@baylibre.com>
        <CAGXv+5GT=3m=pVPwUOWR42BR=emCpBXvvoAiRV7YKt2kEKWdAQ@mail.gmail.com>
        <CGME20220519182512epcas1p3020bd4713580c9244f759971b8bd2c3a@epcas1p3.samsung.com>
        <7hmtfdbcsc.fsf@baylibre.com>
        <5a1767dc-ba2d-4de5-d8fe-2f308d3318a9@samsung.com>
        <CAGXv+5EsgiXCpe-8H0cQ=qm_Nq+yfM_a4b1L=hOFP6mcwfZymw@mail.gmail.com>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 5/20/22 11:42 AM, Chen-Yu Tsai wrote:
> On Fri, May 20, 2022 at 9:28 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>
>> Hi Kevin, Chen-Yu,
>>
>> On 5/20/22 3:25 AM, Kevin Hilman wrote:
>>> Chen-Yu Tsai <wenst@chromium.org> writes:
>>>
>>>> n Wed, May 18, 2022 at 8:03 AM Kevin Hilman <khilman@kernel.org> wrote:
>>>>>
>>>>> Kevin Hilman <khilman@kernel.org> writes:
>>>>>
>>>>>> Chen-Yu Tsai <wenst@chromium.org> writes:
>>>>>>
>>>>>>> On Mon, May 16, 2022 at 8:43 AM Roger Lu <roger.lu@mediatek.com> wrote:
>>>>>>>>
>>>>>>>> The Smart Voltage Scaling(SVS) engine is a piece of hardware
>>>>>>>> which calculates suitable SVS bank voltages to OPP voltage table.
>>>>>>>> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
>>>>>>>> when receiving OPP_EVENT_ADJUST_VOLTAGE.
>>>>>>>>
>>>>>>>> 1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
>>>>>>>> 2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by get_cpu_device().
>>>>>>>> After retrieving subsys device, SVS driver calls device_link_add() to make sure probe/suspend callback priority.
>>>>>>>>
>>>>>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=25cb20a212a1f989385dfe23230817e69c62bee5
>>>>>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=b325ce39785b1408040d90365a6ab1aa36e94f87
>>>>>>>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.16-next/dts64&id=a8168cebf1bca1b5269e8a7eb2626fb76814d6e2
>>>>>>>>
>>>>>>>> Change since v24:
>>>>>>>> - Rebase to Linux 5.18-rc6
>>>>>>>> - Show specific fail log in svs_platform_probe() to help catch which step fails quickly
>>>>>>>> - Remove struct svs_bank member "pd_dev" because all subsys device's power domain has been merged into one node like above [3]
>>>>>>>>
>>>>>>>> Test in below environment:
>>>>>>>> SW: Integration Tree [4] + Thermal patch [5] + SVS v25 (this patchset)
>>>>>>>> HW: mt8183-Krane
>>>>>>>>
>>>>>>>> [4] https://protect2.fireeye.com/v1/url?k=847bae75-e5f0bb43-847a253a-000babff9b5d-0b6f42041b9dea1d&q=1&e=37a26c43-8564-4808-9701-dc76d1ebbb27&u=https%3A%2F%2Fgithub.com%2Fwens%2Flinux%2Fcommits%2Fmt8183-cpufreq-cci-svs-test
>>>>>>>
>>>>>>> I've updated my branch to include all the latest versions of the relevant
>>>>>>> patch series:
>>>>>>>
>>>>>>> - anx7625 DPI bus type series v2 (so the display works)
>>>>>>> - MT8183 thermal series v9 (this seems to have been overlooked by the
>>>>>>> maintainer)
>>>>>>> - MTK SVS driver series v25
>>>>>>> - devfreq: cpu based scaling support to passive governor series v5
>>>>>>> - MTK CCI devfreq series v4
>>>>>>> - MT8183 cpufreq series v7
>>>>>>> - Additional WIP patches for panfrost MTK devfreq
>>>>>>
>>>>>> Thanks for preparing an integration branch Chen-Yu.
>>>>>>
>>>>>> I'm testing this on mt8183-pumpkin with one patch to add the CCI
>>>>>> regulator[1], and the defconfig you posted in a previous rev of this
>>>>>> series, but the CCI driver still causes a fault on boot[2] on my
>>>>>> platform.
>>>>>>
>>>>>> I mentioned in earlier reviews that I think there's potentially a race
>>>>>> between CCI and SVS loading since they are co-dependent.  My hunch is
>>>>>> that this is still not being handled properly.
>>>>>
>>>>> Ah, actually it's crashing when I try to boot the platform with
>>>>> `maxcpus=4` on the cmdline (which I have to do because mt8183-pumpkin is
>>>>> unstable upstream with the 2nd cluster enabled.)
>>
>> This warning message is printed by 'WARN_ON(cpufreq_passive_unregister_notifier(devfreq))'
>> on devfreq passive governor.
>>
>> If the cpufreq drivers are not probed before of probing cci devfreq driver
>> with passive governor, passive governor shows this warning message.
>> Because passive governor with CPUFREQ_PARENT_DEV depends on the cpufreq driver
>> in order to get 'struct cpufreq_policy'[2].
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/tree/drivers/devfreq/governor_passive.c?h=devfreq-testing#n339
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/tree/drivers/devfreq/governor_passive.c?h=devfreq-testing#n282
>>
>> But, as I knew, this message might not stop the kernel. Just show the warning
>> message and then return -EPROBE_DEFER error. It means that maybe try to
>> probe the cci devfreq driver on late time of kernel booting
>> and then will be working. But, I need the full kernel booting log
>> and the booting sequence of between cpufreq and cci devfreq driver.
> 
> Maybe just use a standard dev_warn() instead? WARN_ON causes all sorts
> of panicking in developers' minds. :p
> 
>> In order to fix your issue, could you share the full booting log?
>> And if possible, please explain the more detailed something about this.
> 
> The shortened version is that on an 8 core system, with maxcpus=4,
> only the first four cores are booted and have cpufreq associated.
> I've not actually used this mechanism, so I don't really know what
> happens if the other cores are brought up later with hotplug. Is
> cpufreq expected to attach to them?
> 
> Maybe Kevin can add some more details.
> 
> 
> ChenYu
> 
> 
>>>>>
>>>>> The CCI driver should be a bit more robust about detecting
>>>>> available/online CPUs
>>>>
>>>> This all seems to be handled in the devfreq passive governor.
>>>
>>> Well, that's the initial crash.  But the SVS driver will also go through
>>> its svs_mt8183_banks[] array (including both big & little clusters) and
>>> try to init SVS, so presumably that will have some problems also if only
>>> one cluster is enabled.
>>>
>>>> And presumably we'd like to have CCI devfreq running even if just one
>>>> core was booted.
>>>
>>> Yes, I assume so also.
>>>
>>>> Added Chanwoo for more ideas.
>>>
>>> OK, thanks.
>>>
>>> Kevin


I tested the passive governor with my temporary test code
on odroid-xu3 which contains the big.LITTLE cluster (Octa-core).


[Sequence of cpufreq/devfreq driver]
1. Turn on all cpus
2. Probed cpufreq driver
3. Probed devfreq driver using passive governor with CPUFREQ_PARENT_DEV

In my test case, there are no warning message during kernel booting.
Also when scaling the cpu frequency of cpus of big.LITTLE clusters,
temporary devfreq driver receives the notfication and then
calculate the target frequency of devfreq device by iterating online cpu.

If there are any h/w constraints on your case, please let me know.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
