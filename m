Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB50352E29E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344819AbiETCqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344799AbiETCqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:46:13 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A6953E23
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:46:08 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220520024603epoutp04320a17b29585f235cb835a009a2efaaf~wsCtC1_cj2994529945epoutp04I
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:46:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220520024603epoutp04320a17b29585f235cb835a009a2efaaf~wsCtC1_cj2994529945epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653014763;
        bh=pNwd+tG5/5Th2TaXiJdgPU0+4OREyHFZPZACOtCzGwo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mL95xUAwWAKdOD8Rxo1Sgi9jsDBgq8jf9eDdje4Om9iBkn6F4A9n4nePxUOdINJZn
         Qmxi8NP7EMryGlzP20kAFcb8/hrqHaWWaRIa3//5x6qpJA5jq/U2/S8l4c21QcVDsg
         uL8bllJdxea6o0IjBR1pJJ8iztcc+oKiroyEc8Ao=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220520024602epcas1p101fd352055afd50ab10860434a668044~wsCsRq4ps1499814998epcas1p1g;
        Fri, 20 May 2022 02:46:02 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.134]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L4B1N5w7zz4x9Pp; Fri, 20 May
        2022 02:46:00 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.1E.10038.8E007826; Fri, 20 May 2022 11:46:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220520024600epcas1p340ac0aa2dcf54e4b69180e8d4483bd18~wsCqkBSnO0345903459epcas1p3W;
        Fri, 20 May 2022 02:46:00 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220520024600epsmtrp2d94a309fb79df1a06022261361dd966e~wsCqiuVGy2863728637epsmtrp2-;
        Fri, 20 May 2022 02:46:00 +0000 (GMT)
X-AuditID: b6c32a37-127ff70000002736-50-628700e88ece
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.76.08924.8E007826; Fri, 20 May 2022 11:46:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220520024559epsmtip1aa1b59a3005b8fe5f752d9712e6eb50c~wsCqG38ll1417514175epsmtip1W;
        Fri, 20 May 2022 02:45:59 +0000 (GMT)
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
Message-ID: <7beea208-7d40-1c7d-9c70-6437440d22da@samsung.com>
Date:   Fri, 20 May 2022 12:12:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAGXv+5EsgiXCpe-8H0cQ=qm_Nq+yfM_a4b1L=hOFP6mcwfZymw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1RTZRjHfe8ud8NaXRHYG5wMr9YRarABm9ccHk8g53b0BJ2OFpw64wL3
        AALb2t3K7A+n/JwhipxAFwYKFE5O4TBwOyEKJL/EohUgRD8YIhoosAhOO0gbF4v/vs/zfr7v
        837f97wCnk8OP0CQodIxWhWdRWDr0ab2YLF4cl1BsuTTATG5cLSaT86fMaBkZcdtL9I+PM8j
        f3BdxMi/f3EhZGdrDZ+82+hASItjwL1qq8BIe04/IJ0nOgA5fv4WQtYO9iPksdwIcmqxDyFH
        f+1CybmvClHyWm85j8xr6eCTdsdljHw8cBklz+TbvXaLqPrP6wH1maEfpaymUT5VZdFTFrMR
        oxprjlC53a0odXJJQlkXDHyqc6gZoZyWTfFPJWYq0hk6ldEGMaoUdWqGKi2K2PuWMlopk0uk
        YukOcjsRpKKzmSgiZl+8ODYjyx2YCPqAztK7W/E0yxJhuxRatV7HBKWrWV0UwWhSszQyTShL
        Z7N6VVqoitG9KpVIwmVuMCkzfdY8w9MUSw5NVpXyDaB823HgLYB4JLxYdxocB+sFPvhVAK+V
        XcK4Yg7AkesLCFc4ASw+3+H1xNLcf3eVsgH4R0EPyhWPAPypdATzUBvx1+BI6z23Fgh88Reh
        7dtAD8PDHRgcnW9CPQyGh8DWyaEV/ll8M/x50QE8WojvguaeKsTjRd3eBrPM0/bDD8DuptxV
        ZAPsPju+so03/ib87c49vkfzcBEcHq9EOP0CbJ6u4HnmQrzRGy73VSNcghj4xXLeapqN8EHn
        FT6nA6DzYQvGGXIANEyOAK4oAvC7iWKUoyJga23pyul4eDD82hbGtTdDq+sc4CY/Ax/OF3l5
        EIgLYWG+D4dsgfbfR1fP8BysLjBipwBhWpPHtCaDaU0G0//DqgBqBv6Mhs1OY1ipJuK/505R
        Z1vAym8I2X4VlE3PhLYBRADaABTwCF8hyM5N9hGm0h8dZrRqpVafxbBtQOa+4BJegF+K2v2d
        VDqlNHKHJFIeHhFJSuVSQiQ0l/XSPngarWMyGUbDaJ/4EIF3gAE5ESoyvkv7TW+6IJ8VxaXM
        Hba73tAWn1UcBG/71rQ3vt77o/8+bbW+9qQxvoGoq1B2P7p/ejDQ4WdahDXXxyaU/KEyy7pj
        STH79++RLe/dWtTyYIPr+5rAPsVMXcLMuYNxRnrx/aUrRy7djNPfCovOyZtKxpYSopIEW9vT
        Ev1dATcc792OVcu9dpbvPjR4YeyovDAxXmH6UB2d65wd679vtimsSMKdp0c+uRFiH63XKybK
        gu02dvivl8ZU+YioYYrqvWks2TYxbm3z6/lm+s+6qY+/dO7ssmlaQPiDxQOTryT75iUTz4eX
        iF9+p8O0pT7P2lHJxo4ljsucfGHX43/2oATKptPSEJ6Wpf8FAoiXi5YEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURSFfTPjdChpHAqEZ9WqVcRUrYBgntEQIxrHBI3EuOCGo4y40Iod
        cE2gAlZsgpgYt4qlIkatuFDEAlaRTUTRUOuK4jZFMIJBtEIUF0pjwr8v95zv/LoULu0gZNRm
        TQqn1bBJClJM3KhRyKe0DzmwPtSZG4h69p0VIfcJHYHyax8NRc5mN46afl0k0Y/XvzBUX1ko
        Qq0lAoaswrP+tCKPRM5MB0DfcmoBcp1pxNC55w4MZWRNQx29DzHU8uYegbqvZBPo9oPjONp/
        q1aEnEIxif48KybQCb1z6OwgpshUBJhTOgfBlBtbRIzZmspYLQdJpqQwnclqqCSY3N+hTHmP
        TsTUv7BhzDerfLHvSvGsBC5p8w5OOzVqnXjTV0sXnnwodFe7+YhIB45PNAAfCtIR0OZoJQ1A
        TEnpMgArhCeYNxgOjznqcAOg+tkf1tTw3k4ngMU/9SJPx5+eA19VtpGeTgAdDCvsIzwdnG4l
        4dPuO4RX+IHD264LAwJJK2Fl+wvSw8PosfBprwA8LKGjoOW+GfMMEf1D1yyRnnMgvQyWFwqY
        t+IHG066CA/70LHw7cu2gUmcDoF9pse4l4Ngsysf8/JoaOvMww8Df+Mg3ThIMQ5SjIMUMyAs
        YDiXzKsT1XxYcriG26niWTWfqklUbdimtoKBh1Aqy4Dd0qWqBhgFqgGkcEWABKiz1kslCezu
        PZx2W7w2NYnjq8EIilAESZoMDfFSOpFN4bZyXDKn/Z9ilI9Mh8UAP/ndyOjGdnytJrb2/crl
        SlWWTtv2HYTHpObO/ZIm7LDPl+VOvCwb93OF/vX5z9bl4vOUQqqJ2Vu1MKp+yUx7xrvre90R
        O/uitcVv4B0Vz1NzDOOzLzpLJ42OKHA7PrHbhUNKkX5Yk//IlISiq9Hh7rp96pyt+owtMr9M
        x9GlrYtY6x+TfN5sU+xGfHIVOX0GON2hf1twy+4KUcROW5oz4Wz5GXSvNCA9e5Rk/6WCtGZj
        Xs8jPC2uwRy8pa93QkvnFHP6qpZGP4uLPRoXFumbWdddiAd+SPhbkb+6pm+BfLcQ9vLBGFP8
        muCbVTZ9wPiukT20bwlSfTyWYvt+X0Hwm9gwJa7l2X+Ix37+fwMAAA==
X-CMS-MailID: 20220520024600epcas1p340ac0aa2dcf54e4b69180e8d4483bd18
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

OK. I'll use dev_warn() instead of WARN_ON.

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
>>
>>
>> --
>> Best Regards,
>> Chanwoo Choi
>> Samsung Electronics
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
