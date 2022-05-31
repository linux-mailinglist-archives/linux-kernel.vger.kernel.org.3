Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A1A538B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbiEaFzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244103AbiEaFze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:55:34 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6091025E8B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:55:30 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220531055528epoutp018dbca1f9e6fd7e0ba5eeb98fb47fcc39~0GuOqNAp90280002800epoutp01Q
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:55:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220531055528epoutp018dbca1f9e6fd7e0ba5eeb98fb47fcc39~0GuOqNAp90280002800epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653976528;
        bh=+fhUkxAgy2sT3rHcXWF238VihMUwOD8JIdQQUmzZYmE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lsiwjype6DQJVk3fqNvd5J/KMImbFO5t4GmTkZbXibUaNWj3fcKD7wj2E80kqeZOL
         91qrCASp+9W2xk7tQJcAeNgqFTpSxuaBBYsfLBCDXkdCfl6pzsNU7DGd5aoNQX9cP3
         wtwJDtI0qQ+dz7eGQffPEAEn5ZveeRjZYeZNq2r0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220531055527epcas1p4fd8c72cdc3ac436a495c3cd2c8a8b4ba~0GuN-EWFM1081610816epcas1p4O;
        Tue, 31 May 2022 05:55:27 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.234]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LC1ht0rVvz4x9Pt; Tue, 31 May
        2022 05:55:26 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.D2.10063.DCDA5926; Tue, 31 May 2022 14:55:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220531055525epcas1p2cde9ae85fb61b4c7982074f5bfd0a3e4~0GuMOGM4Q2398923989epcas1p2a;
        Tue, 31 May 2022 05:55:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220531055525epsmtrp1f0f3f5c59d1021ada0365be3ff79ab72~0GuMLiyit1304513045epsmtrp1_;
        Tue, 31 May 2022 05:55:25 +0000 (GMT)
X-AuditID: b6c32a35-1f1ff7000000274f-dd-6295adcd49bb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.3D.11276.DCDA5926; Tue, 31 May 2022 14:55:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220531055525epsmtip105fe4eb4930eca1e328ddd72daaeca23~0GuLsmp6T1708217082epsmtip10;
        Tue, 31 May 2022 05:55:25 +0000 (GMT)
Subject: Re: [PATCH v25 0/7] soc: mediatek: SVS: introduce MTK SVS
To:     Kevin Hilman <khilman@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Roger Lu <roger.lu@mediatek.com>,
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
Message-ID: <83b10ab5-147a-dec7-66d9-9e23f67a5777@samsung.com>
Date:   Tue, 31 May 2022 14:55:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <7hleup9sh8.fsf@baylibre.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1ATVxjt3Ww2QSZ2G0Cu2NKwHeyIAok8vDBg1VJmi04L1akO/sAAO0AJ
        SUyC01o6BAQEig8ERSItzwxNqm0hlDekQ0HEBxWjlIGidkABi8Xq8CoVm2Sx5d/5vu+c78z5
        7lw+R5jFc+MnyTWMSi6VUcQavPHnTWLvG5fOxopfTIag+YxqHpo9r8VReXc/F1mGZzno5pKB
        QHO/LWGo11zDQw9MYxiqHxu0TlvLCGQ5NgDQsxPdAI1XXseQ/tcBDGVm+aHphRsYGr17BUdP
        v8vFUee1Eg7K7ujmIctYHYGWB+twdD7Hwt3hSl/8+iKgL2gHcLpFN8qjK+pT6XpjHkGbatLp
        rD4zTp96LqZb5rU8uneoCaOf1btHOkYnhyQy0nhGJWLkcYr4JHlCKLV7b8y7MQGBYom3JAht
        o0RyaQoTSoXtifQOT5JZA1OiI1JZqrUVKVWrKd/tISpFqoYRJSrUmlCKUcbLlAFKH7U0RZ0q
        T/CRM5pgiVi8NcBKPJSc2FI6w1Ne2PWpacQAtKBvWz5w4EPSH07l1nLzwRq+kGwG0FKYgbPF
        UwBz2opWJnMAXh7pwF9KTmYPrrA6AOyfMfBsAyE5A+B0WbgNO5G74Ih5grBhZ5KGlxvPEDYB
        h+wkYG11l30TQXpB8+SQnfQq6QHvLIwBGxaQ22HmAivGSU/4fLrZ3nchP4Z9jVkrnNdgX+m4
        fY+Ddc/tUrMdc0hXODxejrH4Tdj0uIxjM4akyQGa+q9z2Qhh8NFVLY/FTvBRb8MKdoNTp3J4
        rOAYgNrJEcAWBQD2PDy5cgA/aNYXWS34VotN8PtWX7btAVuWvgKs81r452wB10aBpADm5ghZ
        ylvQcn8UY/F6WH08jzgNKN2qPLpVGXSrMuj+N6sAuBGsY5TqlARGLVFK/nvvOEVKPbB/B6+A
        ZlD4+IlPF8D4oAtAPodyFgQfOBsrFMRLPzvKqBQxqlQZo+4CAdYLF3LcXOIU1v8k18RI/IPE
        /oFb/fyRJFBCuQqM565JhWSCVMMkM4ySUb3UYXwHNy2WJcfGsYiZVtEtk/L2HSzN2PhLRFRa
        dLjT0oSJaRK0r18Mn9rf6fiiiHldpq3yqwkbOlfwt/zLP97+KO4075b5oPG4fsf7VzS++0vQ
        j2kbqnz9R70iYpeL+vFL/cGLtcNH0vf03dTmG7t9zrjVGdZ98cA5P/RJ3trMcHGs71xe0D+t
        uy33wvT6tkOjDZ/fW9xXkqzr2avY/PvEKx8WtzngFdyf3Mu7v4nxikpXUu2F9zd+cvjhzrid
        PzRodSKXo9+2ZecTCwX7PLOjPyDaY3s2zhreifQUHCiev4sxc9kDB5WbW1N0f2VUNeiXHZsr
        J7ZcfU8zNH846g3SvbjSRe+hMmAbtlC4OlEq8eKo1NJ/AbXx44SXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7bCSnO7ZtVOTDNqa5C2+Ny5mt/g6o4HF
        Yv6Rc6wWl299Zba48Hslm8W3O7+ZLI7vX8Ju8XTzYyaLTY+vAWV3zWGzuNx8kdHic+8RRosn
        C88wWSy9fpHJoqnF2OLNj7NMFnfvnWCx+LSug8Vi3+npzBate4+wW1x+vJHN4t+1jSwWM9ou
        szqIe6yZt4bRY3bDRRaPnbPusnss2FTqsWlVJ5vH5iX1Hi0n97N49P818Nj5vYHd4/iN7Uwe
        nzfJBXBHcdmkpOZklqUW6dslcGXsnPmevWC2U8Xm2ysZGxhPmncxcnJICJhI9LVeY+li5OIQ
        EtjNKHGhtYMZIiEpMe3iUSCbA8gWljh8uBii5i2jxO53zUwgNcICThK39z9nA7FFBDwkjm2b
        xAZSxCxwiE1i+q4bUFMnsUpsXXOaHaSKTUBLYv+LG2Ad/AKKEld/PGYEsXkF7CSafkBMYhFQ
        lfj7ZgdYXFQgTGLnksdMEDWCEidnPmEBsTmB5lyZuR/MZhZQl/gz7xIzhC0ucevJfCYIW15i
        +9s5zBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQI
        ThJamjsYt6/6oHeIkYmD8RCjBAezkgivVcTUJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pO
        xgsJpCeWpGanphakFsFkmTg4pRqY9rsur7NeZu7/r+NlqP1SW3Yvm8X+T+SuyhysWRz61zUp
        YM+Ow0d8tZq2L3u6Nste6e3NFRM+i//3F8+s+y1dr7Tz1tMFMrsvbL4kFlFcUJ95XfUo4/G2
        u69W2IjUsfQUzv28LU8rofDyla59LMqBr1PnLVDTyy7WKqsOfDi3Mrq1tVjBq8nU+fnttdpF
        vkrz/DKq25dURfy+lZKQI18ep9zIJ3fY9YVK9c2vlXNCCh8sfKcfH131uPZoGz93a8Fyrrnx
        mpIF06KF36WGp84TlOGbuGZJ8RsHwxvnhK5du1Ny7KXCV767/5e9OR2j+sf640ozQe0TXJxq
        +ls2d32eHbLp89G7DK+n5nAa2C1UYinOSDTUYi4qTgQALTUegoEDAAA=
X-CMS-MailID: 20220531055525epcas1p2cde9ae85fb61b4c7982074f5bfd0a3e4
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
        <eacf7a67-bc64-a764-e23d-c733a4666b8a@samsung.com>
        <CAGXv+5HEG1VJ89LDHJmMvPqafcdb2cuJj2wxv44ozPxDeHj8ig@mail.gmail.com>
        <7hleup9sh8.fsf@baylibre.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 7:07 AM, Kevin Hilman wrote:
> Chen-Yu Tsai <wenst@chromium.org> writes:
> 
>> On Fri, May 20, 2022 at 5:53 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>
>>> Hi Kevin,
>>>
>>> On 5/20/22 11:42 AM, Chen-Yu Tsai wrote:
>>>> On Fri, May 20, 2022 at 9:28 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>>>
>>>>> Hi Kevin, Chen-Yu,
>>>>>
>>>>> On 5/20/22 3:25 AM, Kevin Hilman wrote:
>>>>>> Chen-Yu Tsai <wenst@chromium.org> writes:
>>>>>>
>>>>>>> n Wed, May 18, 2022 at 8:03 AM Kevin Hilman <khilman@kernel.org> wrote:
>>>>>>>>
>>>>>>>> Kevin Hilman <khilman@kernel.org> writes:
>>>>>>>>
>>>>>>>>> Chen-Yu Tsai <wenst@chromium.org> writes:
>>>>>>>>>
>>>>>>>>>> On Mon, May 16, 2022 at 8:43 AM Roger Lu <roger.lu@mediatek.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> The Smart Voltage Scaling(SVS) engine is a piece of hardware
>>>>>>>>>>> which calculates suitable SVS bank voltages to OPP voltage table.
>>>>>>>>>>> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
>>>>>>>>>>> when receiving OPP_EVENT_ADJUST_VOLTAGE.
>>>>>>>>>>>
>>>>>>>>>>> 1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
>>>>>>>>>>> 2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by get_cpu_device().
>>>>>>>>>>> After retrieving subsys device, SVS driver calls device_link_add() to make sure probe/suspend callback priority.
>>>>>>>>>>>
>>>>>>>>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=25cb20a212a1f989385dfe23230817e69c62bee5
>>>>>>>>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=b325ce39785b1408040d90365a6ab1aa36e94f87
>>>>>>>>>>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.16-next/dts64&id=a8168cebf1bca1b5269e8a7eb2626fb76814d6e2
>>>>>>>>>>>
>>>>>>>>>>> Change since v24:
>>>>>>>>>>> - Rebase to Linux 5.18-rc6
>>>>>>>>>>> - Show specific fail log in svs_platform_probe() to help catch which step fails quickly
>>>>>>>>>>> - Remove struct svs_bank member "pd_dev" because all subsys device's power domain has been merged into one node like above [3]
>>>>>>>>>>>
>>>>>>>>>>> Test in below environment:
>>>>>>>>>>> SW: Integration Tree [4] + Thermal patch [5] + SVS v25 (this patchset)
>>>>>>>>>>> HW: mt8183-Krane
>>>>>>>>>>>
>>>>>>>>>>> [4] https://protect2.fireeye.com/v1/url?k=847bae75-e5f0bb43-847a253a-000babff9b5d-0b6f42041b9dea1d&q=1&e=37a26c43-8564-4808-9701-dc76d1ebbb27&u=https%3A%2F%2Fgithub.com%2Fwens%2Flinux%2Fcommits%2Fmt8183-cpufreq-cci-svs-test
>>>>>>>>>>
>>>>>>>>>> I've updated my branch to include all the latest versions of the relevant
>>>>>>>>>> patch series:
>>>>>>>>>>
>>>>>>>>>> - anx7625 DPI bus type series v2 (so the display works)
>>>>>>>>>> - MT8183 thermal series v9 (this seems to have been overlooked by the
>>>>>>>>>> maintainer)
>>>>>>>>>> - MTK SVS driver series v25
>>>>>>>>>> - devfreq: cpu based scaling support to passive governor series v5
>>>>>>>>>> - MTK CCI devfreq series v4
>>>>>>>>>> - MT8183 cpufreq series v7
>>>>>>>>>> - Additional WIP patches for panfrost MTK devfreq
>>>>>>>>>
>>>>>>>>> Thanks for preparing an integration branch Chen-Yu.
>>>>>>>>>
>>>>>>>>> I'm testing this on mt8183-pumpkin with one patch to add the CCI
>>>>>>>>> regulator[1], and the defconfig you posted in a previous rev of this
>>>>>>>>> series, but the CCI driver still causes a fault on boot[2] on my
>>>>>>>>> platform.
>>>>>>>>>
>>>>>>>>> I mentioned in earlier reviews that I think there's potentially a race
>>>>>>>>> between CCI and SVS loading since they are co-dependent.  My hunch is
>>>>>>>>> that this is still not being handled properly.
>>>>>>>>
>>>>>>>> Ah, actually it's crashing when I try to boot the platform with
>>>>>>>> `maxcpus=4` on the cmdline (which I have to do because mt8183-pumpkin is
>>>>>>>> unstable upstream with the 2nd cluster enabled.)
>>>>>
>>>>> This warning message is printed by 'WARN_ON(cpufreq_passive_unregister_notifier(devfreq))'
>>>>> on devfreq passive governor.
>>>>>
>>>>> If the cpufreq drivers are not probed before of probing cci devfreq driver
>>>>> with passive governor, passive governor shows this warning message.
>>>>> Because passive governor with CPUFREQ_PARENT_DEV depends on the cpufreq driver
>>>>> in order to get 'struct cpufreq_policy'[2].
>>>>>
>>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/tree/drivers/devfreq/governor_passive.c?h=devfreq-testing#n339
>>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/tree/drivers/devfreq/governor_passive.c?h=devfreq-testing#n282
>>>>>
>>>>> But, as I knew, this message might not stop the kernel. Just show the warning
>>>>> message and then return -EPROBE_DEFER error. It means that maybe try to
>>>>> probe the cci devfreq driver on late time of kernel booting
>>>>> and then will be working. But, I need the full kernel booting log
>>>>> and the booting sequence of between cpufreq and cci devfreq driver.
>>>>
>>>> Maybe just use a standard dev_warn() instead? WARN_ON causes all sorts
>>>> of panicking in developers' minds. :p
>>>>
>>>>> In order to fix your issue, could you share the full booting log?
>>>>> And if possible, please explain the more detailed something about this.
>>>>
>>>> The shortened version is that on an 8 core system, with maxcpus=4,
>>>> only the first four cores are booted and have cpufreq associated.
>>>> I've not actually used this mechanism, so I don't really know what
>>>> happens if the other cores are brought up later with hotplug. Is
>>>> cpufreq expected to attach to them?
>>>>
>>>> Maybe Kevin can add some more details.
>>>>
>>>>
>>>> ChenYu
>>>>
>>>>
>>>>>>>>
>>>>>>>> The CCI driver should be a bit more robust about detecting
>>>>>>>> available/online CPUs
>>>>>>>
>>>>>>> This all seems to be handled in the devfreq passive governor.
>>>>>>
>>>>>> Well, that's the initial crash.  But the SVS driver will also go through
>>>>>> its svs_mt8183_banks[] array (including both big & little clusters) and
>>>>>> try to init SVS, so presumably that will have some problems also if only
>>>>>> one cluster is enabled.
>>>>>>
>>>>>>> And presumably we'd like to have CCI devfreq running even if just one
>>>>>>> core was booted.
>>>>>>
>>>>>> Yes, I assume so also.
>>>>>>
>>>>>>> Added Chanwoo for more ideas.
>>>>>>
>>>>>> OK, thanks.
>>>>>>
>>>>>> Kevin
>>>
>>>
>>> I tested the passive governor with my temporary test code
>>> on odroid-xu3 which contains the big.LITTLE cluster (Octa-core).
>>>
>>>
>>> [Sequence of cpufreq/devfreq driver]
>>> 1. Turn on all cpus
>>> 2. Probed cpufreq driver
>>> 3. Probed devfreq driver using passive governor with CPUFREQ_PARENT_DEV
>>>
>>> In my test case, there are no warning message during kernel booting.
>>> Also when scaling the cpu frequency of cpus of big.LITTLE clusters,
>>> temporary devfreq driver receives the notfication and then
>>> calculate the target frequency of devfreq device by iterating online cpu.
>>>
>>> If there are any h/w constraints on your case, please let me know.
>>
>> Could you run your system with maxcpus=4 added to your cmdline?
>> This is what Kevin was running.
>>
>> The current result is that the latter four cores aren't booted, so no
>> cpufreq tied to them, and the passive governor will fail to get their
>> cpufreq_policy. As mentioned before, the code path used to have a
>> WARN_ON(). Now it's a dev_warn(). It will still fail initialization
>> though.
>>
>> We're wondering if devfreq passive governor should be made to work
>> even if not all cpu cores are available when it probes.
> 
> For info, here is a boot log[1] from mt8183-pumpkin board where I'm
> testing Chen-Yu's lastest integration branch.  
> 
> As Chen-Yu said, the part that makes it trigger the warn is disabling
> some of the CPUs *at boot time*.  In this case, I'm passing `maxcpus=4`
> on the kernel command line.
> 
> Kevin
> 
> [1] https://protect2.fireeye.com/v1/url?k=05bb8eea-64309bc5-05ba05a5-74fe485cbfe7-9281bdbd13e5cf90&q=1&e=8ab47ff1-daee-4db3-a26d-6fc652568a44&u=https%3A%2F%2Ftermbin.com%2Fzidi
> 
> 

When using 'maxcpus=' on my test board, I got the warning message.
I'm fixing it and then send the patch. Thanks for the test.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
