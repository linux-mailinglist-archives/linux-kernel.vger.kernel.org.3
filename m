Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351CF52C840
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 01:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiERX6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 19:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiERX6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 19:58:51 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67A2AEE2A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 16:58:48 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220518235846epoutp01923353ed97fcd35e0ee7a1645c19cdf6~wWHXUUtpr1085310853epoutp01X
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:58:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220518235846epoutp01923353ed97fcd35e0ee7a1645c19cdf6~wWHXUUtpr1085310853epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652918326;
        bh=+Qdz/eeKSfcMQcKFz4nw8AzxuUFPKC84yCVM3LQnZkc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iRHhIYn3rCjLJ+LZ8wX8WZ74IcETglt3iWhntGc7YnF3d9j/pmpHMXSNivFd186TU
         PcFNTfbPzeV3U2aAP19BcjZy/Sg75Q6+SX3+3I0HGBDSkre2A1ucXaAAaWf2Ahx1JZ
         47cp8wE1dsWRMfLQqGz5pXCvjjfIL1JcunIiHZY0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220518235845epcas1p43dbe42afbcc11248908e687339d6d7f9~wWHWqyYDU2399123991epcas1p4Z;
        Wed, 18 May 2022 23:58:45 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.145]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L3VLr4Ynyz4x9QK; Wed, 18 May
        2022 23:58:44 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.BE.10354.43885826; Thu, 19 May 2022 08:58:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220518235843epcas1p4185dcb6661b2c02ad4c540ddb2e7b8da~wWHUwzIXf2399123991epcas1p4U;
        Wed, 18 May 2022 23:58:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220518235843epsmtrp12bdaf65dc12d01b1b7f70e5cf1b52f12~wWHUv1IlC1052010520epsmtrp1Y;
        Wed, 18 May 2022 23:58:43 +0000 (GMT)
X-AuditID: b6c32a38-49fff70000002872-d4-628588342f3c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.73.11276.33885826; Thu, 19 May 2022 08:58:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220518235843epsmtip1b780fc054726eab38bc21528b5693c4d~wWHUT0vWY2084920849epsmtip12;
        Wed, 18 May 2022 23:58:43 +0000 (GMT)
Subject: Re: [PATCH v5 0/4] PM / devfreq: Add cpu based scaling support to
 passive governor
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6e6a20e4-d03b-9508-9fe3-75788076e0f4@samsung.com>
Date:   Thu, 19 May 2022 09:25:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <59f53724-87fe-97b8-0660-dcb1a5b464fe@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmvq5JR2uSwaklchbb179gtZjQup3Z
        4vj+JewWx34FW5xtesNucXnXHDaLz71HGC3WHrnLbvF5w2NGi9uNK9gsug79ZbOY0XaZ1YHH
        Y3bDRRaPBZtKPVpO7mfx6NuyitHj8ya5ANaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMD
        Q11DSwtzJYW8xNxUWyUXnwBdt8wcoOuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUp
        OQWmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZH29pFWzRqJj87AR7A+MWxS5GTg4JAROJU9d+
        sHUxcnEICexglDj7thfK+cQo0TJlL5TzjVHi7vltbDAtsyZOYoZI7GWUuNHxgxXCec8oseXO
        e0aQKmGBWIl9b54zg9giApkSR869AitiFnjMKPF9yRtWkASbgJbE/hc3wMbyCyhKXP3xGKyZ
        V8BO4sz0rewgNouAqsSPqcvA6kUFwiRObmuBqhGUODnzCUsXIwcHp4C9xOt7sSBhZgFxiVtP
        5jNB2PIS29/OAbtUQmAPh8SCqf/A6iUEXCRmbg2H+EZY4tXxLewQtpTEy/42doj6ZkaJhhe3
        GSGcHkaJo8/6WCCqjCX2L53MBDKIWUBTYv0ufYiwosTO33MZIRbzSbz72sMKsYtXoqNNCKJE
        WeLyg7tMELakxOL2TrYJjEqzkHwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBSbw2E7Oz93E
        CE65WhY7GOe+/aB3iJGJg/EQowQHs5IIL2NuS5IQb0piZVVqUX58UWlOavEhRlNg+E5klhJN
        zgcm/bySeEMTSwMTMyNjEwtDM0Mlcd7eqacThQTSE0tSs1NTC1KLYPqYODilGpgkq3cyfr4w
        SViyknXqyv5LMZ1nTPrOsgrVc249cq5tsXz2nONyS3QncLmlPEh5cWT6q5BbB/YvzaxMCrB8
        6jHjqLbrJM6dc+7yVYasv9Oy7FCS5HKV+oKDkR/WXr2ivD43eDHP5WOLmCzOKBplKhdeyjDc
        t7v8SVFm9JPJbBbrzrCpJ+5+GJe56f9PoapZB7eHd7jZl0bNe8G569tCY4WFV88Jt7sdnl7Y
        qXL0XOVeX8Mfh/N5WM7OkM7qyc1oKHQPYjK2+lO0YfqnLMnJJqzNYRV5n19lPzdjMfFSvNgh
        pdlyz7Y3asF7aYHtAf8li5VvtEwINOBcXTDvSr1WHvf2nawVRsmWxkeZXv71tFNiKc5INNRi
        LipOBABc/F2BQgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnK5xR2uSwYJZkhbb179gtZjQup3Z
        4vj+JewWx34FW5xtesNucXnXHDaLz71HGC3WHrnLbvF5w2NGi9uNK9gsug79ZbOY0XaZ1YHH
        Y3bDRRaPBZtKPVpO7mfx6NuyitHj8ya5ANYoLpuU1JzMstQifbsEroyPt7QKtmhUTH52gr2B
        cYtiFyMnh4SAicSsiZOYuxi5OIQEdjNKXJ77iBEiISkx7eJRoAQHkC0scfhwMUTNW0aJj6fv
        soLUCAvESux785wZxBYRyJTYsf8iE0gRs8BjoEHzH7BAdBxmlLhzoQ2sik1AS2L/ixtsIDa/
        gKLE1R+PwbbxCthJnJm+lR3EZhFQlfgxdRnYBlGBMImdSx4zQdQISpyc+YQF5CJOAXuJ1/di
        QcLMAuoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPwLCTds5C0zELSMgtJywJGllWMkqkFxbnp
        ucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMGxp6W5g3H7qg96hxiZOBgPMUpwMCuJ8DLmtiQJ8aYk
        VlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwGQkdjjRrbSv/sLB
        Z2pbF+xhfXVs14fdph/N+dMFtr1Yfv6V25c2G46Ub5MnCIafvreasfFzoL9tdtteFiWjSPl3
        /pMfnWsWUciymPbl70Rjs03agmqsn72fb+XMYYhxv5T3aVGAjvi7Ey/+s1SbibTx3a/sZrit
        2ifLzqZyUjVl7u6uyo+/0/SbY7n2r3gmw5f68+1vtQcu7fa6AfHF/HWRx6+G2EsYb5/q5s71
        bkpC3p/HzZZ79dg3Pf7vu0/071Ftjp8iXtdjLLWZby+WEbBljjTcYCXCp5hupsVuvXnR3Wud
        P5vvLpIwmL03W+Ky7YHYnRLJrOzxAdGOUd/YdjlM6n3caH455vP6p77TlViKMxINtZiLihMB
        IZnZZywDAAA=
X-CMS-MailID: 20220518235843epcas1p4185dcb6661b2c02ad4c540ddb2e7b8da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517085446epcas1p4c07ab7d3b80d62c0093c3a45484eae97
References: <CGME20220517085446epcas1p4c07ab7d3b80d62c0093c3a45484eae97@epcas1p4.samsung.com>
        <20220517092108.31680-1-cw00.choi@samsung.com>
        <59f53724-87fe-97b8-0660-dcb1a5b464fe@samsung.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

Thanks for the report.
It 


On 5/18/22 7:56 PM, Marek Szyprowski wrote:
> Hi,
> 
> On 17.05.2022 11:21, Chanwoo Choi wrote:
>> The devfreq passive governor has already supported the devfreq parent device
>> for coupling the frequency change if some hardware have the constraints
>> such as power sharing and so on.
>>
>> Add cpu based scaling support to passive governor with required-opp property.
>> It uses the cpufreq notifier to catch the frequency change timing of cpufreq
>> and get the next frequency according to new cpu frequency by using required-opp
>> property. It is based on patch[1] and then just code clean-up by myself.
>>
>> Make the common code for both passive_devfreq and passive_cpufreq
>> parent type to remove the duplicate code.
> 
> I've just tested it on Exynos based boards and on all I see the 
> following issues after system suspend/resume cycle:
> 
> # time rtcwake -s10 -mmem
> rtcwake: wakeup from "mem" using /dev/rtc0 at Wed May 18 11:13:16 2022
> PM: suspend entry (deep)
> Filesystems sync: 0.001 seconds
> Freezing user space processes ... (elapsed 0.002 seconds) done.
> OOM killer disabled.
> Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> 
> ...
> 
> devfreq soc:bus-disp1-fimd: failed to suspend devfreq device
> devfreq soc:bus-jpeg-apb: failed to suspend devfreq device
> devfreq soc:bus-jpeg: failed to suspend devfreq device
> devfreq soc:bus-g2d-acp: failed to suspend devfreq device
> devfreq soc:bus-g2d: failed to suspend devfreq device
> devfreq soc:bus-peri: failed to suspend devfreq device
> devfreq soc:bus-gen: failed to suspend devfreq device
> devfreq soc:bus-mfc: failed to suspend devfreq device
> devfreq soc:bus-fsys2: failed to suspend devfreq device
> devfreq soc:bus-fsys-apb: failed to suspend devfreq device
> devfreq soc:bus-noc: failed to suspend devfreq device
> ...
> Disabling non-boot CPUs ...
> Enabling non-boot CPUs ...
> ...
> devfreq soc:bus-mscl: failed to resume devfreq device
> devfreq soc:bus-gscl-scaler: failed to resume devfreq device
> devfreq soc:bus-disp1: failed to resume devfreq device
> devfreq soc:bus-disp1-fimd: failed to resume devfreq device
> devfreq soc:bus-jpeg-apb: failed to resume devfreq device
> devfreq soc:bus-jpeg: failed to resume devfreq device
> devfreq soc:bus-g2d-acp: failed to resume devfreq device
> devfreq soc:bus-g2d: failed to resume devfreq device
> devfreq soc:bus-peri: failed to resume devfreq device
> devfreq soc:bus-gen: failed to resume devfreq device
> devfreq soc:bus-mfc: failed to resume devfreq device
> devfreq soc:bus-fsys2: failed to resume devfreq device
> devfreq soc:bus-fsys-apb: failed to resume devfreq device
> devfreq soc:bus-noc: failed to resume devfreq device
> 
> Some boards (like Trats2) after suspend/resume cycle reveals random crashes.
> 
> All those issues were not observed before applying this patchset.
> 
>> [1] [RFC,v2] PM / devfreq: Add cpu based scaling support to passive_governor
>> - https://lore.kernel.org/patchwork/patch/1101049/
>>
>> Changes from v4:
>> : https://patchwork.kernel.org/project/linux-pm/cover/20220511093554.17535-1-cw00.choi@samsung.com/
>> - Fix issue[2] reported by Marek Szyprowski
>> [2] https://patchwork.kernel.org/project/linux-pm/patch/20220511093554.17535-3-cw00.choi@samsung.com/
>>
>> Changes from v3:
>> : ttps://patchwork.kernel.org/project/linux-pm/cover/20220509120337.92472-1-cw00.choi@samsung.com/
>> - Add tested-by tag of both Chen-Yu Tsai and Johnson Wang
>> - Fix some typo
>>
>> Changes from v2:
>> : https://patchwork.kernel.org/project/linux-pm/cover/20220507150145.531864-1-cw00.choi@samsung.com/
>> - Drop the following patch ("PM / devfreq: passive: Update frequency when start governor")
>> - Move p_data->this initialization into cpufreq_passive_regiser_notifier()
>>
>> Changes from v1:
>> : https://patchwork.kernel.org/project/linux-pm/cover/20210617060546.26933-1-cw00.choi@samsung.com/
>> - Rename cpu_data variable to parent_cpu_data to avoid build fail
>> - Use for_each_possible_cpu macro when register cpufreq transition notifier
>> - Add missing exception handling when cpufreq_passive_register_notifier is failed
>> - Keep cpufreq_policy for posible cpus instead of NR_CPU in order to avoid
>>    the memory waste when NR_CPU is too high.
>> - Add reviewed-by tag of Matthias Kaehlcke for patch1
>>
>> Chanwoo Choi (3):
>>    PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
>>    PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
>>    PM / devfreq: passive: Keep cpufreq_policy for possible cpus
>>
>> Saravana Kannan (1):
>>    PM / devfreq: Add cpu based scaling support to passive governor
>>
>>   drivers/devfreq/devfreq.c          |  20 +-
>>   drivers/devfreq/governor.h         |  27 ++
>>   drivers/devfreq/governor_passive.c | 403 ++++++++++++++++++++++++-----
>>   include/linux/devfreq.h            |  17 +-
>>   4 files changed, 389 insertions(+), 78 deletions(-)
>>
> Best regards
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
