Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BB952C7E2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 01:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiERXo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 19:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiERXow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 19:44:52 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A4ADF35
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 16:44:50 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220518234445epoutp0430bc6f5d21a6c992874c74fa6b7b9cc9~wV7IapGkT3164131641epoutp04k
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:44:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220518234445epoutp0430bc6f5d21a6c992874c74fa6b7b9cc9~wV7IapGkT3164131641epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652917485;
        bh=Ceuy/MSkqpsgmL0nQecF1cnw9KRXOOlAG/BIY4xy30E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MydHG5JD/Gz0cKI6DArv32Fn1kHrwtpH7W82x3VyxljUnTlKQrML6w7LeOdOhYj8w
         DISVXYyjxgzQ2w997r1nt/Zuau4Ojv+DmSsJ4RprTjVcBofAq0F2hE3UZnQnraTqPH
         Wb2ywaOGN8JM1b0uWc7+zqXDZO1CAktLqd1jxfCE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220518234445epcas1p27b1e899c71ef5e24c83e8bc852da35f2~wV7IBWahl2849828498epcas1p2L;
        Wed, 18 May 2022 23:44:45 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.145]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L3V2g5pCvz4x9Q8; Wed, 18 May
        2022 23:44:43 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.5F.10038.BE485826; Thu, 19 May 2022 08:44:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220518234443epcas1p1c9c9ec527fada20e3e253962da51eb51~wV7GUpXTM0109301093epcas1p1e;
        Wed, 18 May 2022 23:44:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220518234443epsmtrp1b79f3083289f96cd155174c6572a5d12~wV7GT4X470084100841epsmtrp1k;
        Wed, 18 May 2022 23:44:43 +0000 (GMT)
X-AuditID: b6c32a37-111ff70000002736-2d-628584eb439e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.52.11276.BE485826; Thu, 19 May 2022 08:44:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220518234443epsmtip2caedfb0e60dbf4a3b38a3d42c81a10bb~wV7GA4XnT0872508725epsmtip2D;
        Wed, 18 May 2022 23:44:43 +0000 (GMT)
Subject: Re: [GIT PULL] devfreq next for 5.19
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <91fd3735-4718-bef7-4b54-84a322552dd4@samsung.com>
Date:   Thu, 19 May 2022 09:11:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hRiWXrG1pMzLAqoRE9MidDPm21Mjpk7sjPsE=LA2oVuA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmnu7rltYkg9sn9Cwm3rjCYnG26Q27
        xeVdc9gsPvceYbS43biCzWLul6nMFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJyrbJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcW7L
        DZaCNu2KKVdPMTYwflPsYuTkkBAwkfi/6TN7FyMXh5DADkaJ7k8LmEASQgKfGCUeXhCASHxj
        lFiz9iczTMfupgOsEIm9jBKb9t+Gct4zSuxdfxasXVhAV2La43awDhEBbYkli64ygxQxC9xk
        kjj0fgJYgk1AS2L/ixtsIDa/gKLE1R+PGbsYOTh4Bewkrh9PAAmzCKhKNJ/rASsRFQiTOLmt
        hRHE5hUQlDg58wkLiM0pEChx8u1EsL3MAuISt57Mh7LlJba/nQO2V0JgKofE4uWN7CDzJQRc
        JOZc1Ib4Rlji1fEt7BC2lMTL/jZ2iPpmRomGF7cZIZweRomjz/pYIKqMJfYvncwEMohZQFNi
        /S59iLCixM7fcxkhFvNJvPvawwqxi1eio00IokRZ4vKDu0wQtqTE4vZOtgmMSrOQvDMLyQuz
        kLwwC2HZAkaWVYxiqQXFuempxYYFxvDYTs7P3cQITp1a5jsYp739oHeIkYmD8RCjBAezkggv
        Y25LkhBvSmJlVWpRfnxRaU5q8SFGU2AAT2SWEk3OBybvvJJ4QxNLAxMzI2MTC0MzQyVx3lXT
        TicKCaQnlqRmp6YWpBbB9DFxcEo1MG3X2vRcXcNW8PtaPbfLaSv/eU/K3di598vsDb+P3nkU
        vSJn0uRCk3m33jfeceJ+2Od8yj9h3vdz3ed+V9x+adrE8WbjWb6d2qE8Zs+57xrVZQhv9trn
        verli8Pi4qIzQ2ebzcvbOYNb8tqHNg7XtxwX23LfHV0YuSDpQ4Yb+36Op2b5J38ItC6KTzh5
        9yzPpB9PfY1Lft1642BXfPB8Sk1XLuO2YwlR1880dz1LiX+hvcH25WuGa7kBT5bf3iIvd8T9
        XHzjde39i94tu8ugnLHvRiz/vUlcNWf9lrOlF3dbmkRzv7k42fkp+89ZUeFPGZ+UG3PtU9sV
        xLvJxuf7TfYa87WdGWZcEabT61IWnfJRYinOSDTUYi4qTgQASQ1PSSYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSvO7rltYkg5sHhS0m3rjCYnG26Q27
        xeVdc9gsPvceYbS43biCzWLul6nMFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJ4rJJ
        Sc3JLEst0rdL4Mo4t+UGS0GbdsWUq6cYGxi/KXYxcnJICJhI7G46wNrFyMUhJLCbUeL48k4W
        iISkxLSLR5m7GDmAbGGJw4eLIWreMkp0vH3ICFIjLKArMe1xOzOILSKgLbFk0VVmkCJmgZtM
        EjuvHmaC6LjJKPH1wmewDjYBLYn9L26wgdj8AooSV388ZgTZwCtgJ3H9eAJImEVAVaL5XA9Y
        iahAmMTOJY+ZQGxeAUGJkzOfgB3HKRAocfLtRLA4s4C6xJ95l5ghbHGJW0/mQ8XlJba/ncM8
        gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOAo0tLc
        wbh91Qe9Q4xMHIyHGCU4mJVEeBlzW5KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCe
        WJKanZpakFoEk2Xi4JRqYCrzEtM/Z8q4btV65tQKjmWWPLnnNft99E11W3WUTngbOxWq6WX6
        GP3KDKrmXWPCvXQ540vtH25loTyR59Z+fbS/4MDjbV2PX3WvtmsUe9/MyV77KkaLjbGb4WNY
        jiC3SJFPdeFkfwvd3yEWYgl11wTNSgWP7KtJWOJaaZAgIPr7IAvn0an5WjMNWbrS3X7e45B6
        Z+X3V9c+caVLwt4zO24IrH1kVj7jrpq01u9tPcd1TcWf/jm+5Wdmi8QmqcP/oyqniDnm+d7x
        mRhxnje6T6pltfKmGQ8L5TuWVnWkylrs5iznPZy1Vd/fcP7DrE2LjqwQfq/x48G+0m+nEm+f
        K+kQ+NIuyXXw9oxCfyElluKMREMt5qLiRAAVDzWaEQMAAA==
X-CMS-MailID: 20220518234443epcas1p1c9c9ec527fada20e3e253962da51eb51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220518021539epcas1p3449c756c4aca3c12000e2350b288a197
References: <CGME20220518021539epcas1p3449c756c4aca3c12000e2350b288a197@epcas1p3.samsung.com>
        <3acd6c32-6e78-dfc2-3e45-84f69a7d5f36@samsung.com>
        <CAJZ5v0hRiWXrG1pMzLAqoRE9MidDPm21Mjpk7sjPsE=LA2oVuA@mail.gmail.com>
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

On 5/19/22 4:04 AM, Rafael J. Wysocki wrote:
> On Wed, May 18, 2022 at 4:16 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>
>> Dear Rafael,
>>
>> This is devfreq-next pull request for v5.19-rc1. I add detailed description of
>> this pull request on the following tag. Please pull devfreq with
>> following updates.
>> - tag name : devfreq-next-for-5.19
>>
>> Best Regards,
>> Chanwoo Choi
>>
>>
>> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
>>
>>   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.19
>>
>> for you to fetch changes up to 26984d9d581e5049bd75091d2e789b9cc3ea12e0:
>>
>>   PM / devfreq: passive: Keep cpufreq_policy for possible cpus (2022-05-17 18:24:39 +0900)
>>
>> ----------------------------------------------------------------
>> Update devfreq next for v5.19
>>
>> Detailed description for this pull request:
>> 1. Update devfreq core
>> - Add cpu based scaling support to passive governor. Some device like
>> cache might require the dynamic frequency scaling. But, it has very
>> tightly to cpu frequency. So that use passive governor to scale
>> the frequency according to current cpu frequency.
>>
>> To decide the frequency of the device, the governor does one of the following:
>> : Derives the optimal devfreq device opp from required-opps property of
>>   the parent cpu opp_table.
>>
>> : Scales the device frequency in proportion to the CPU frequency. So, if
>>   the CPUs are running at their max frequency, the device runs at its
>>   max frequency. If the CPUs are running at their min frequency, the
>>   device runs at its min frequency. It is interpolated for frequencies
>>   in between.
>>
>> 2. Update devfreq driver
>> - Update rk3399_dmc.c as following:
>> : Convert dt-binding document to YAML and deprecate unused properties.
>>
>> : Use Hz units for the device-tree properties of rk3399_dmc.
>>
>> : rk3399_dmc is able to set the idle time before changing the dmc clock.
>>   Specify idle time parameters by using nano-second unit on dt bidning.
>>
>> : Add new disable-freq properties to optimize the power-saving feature
>>   of rk3399_dmc.
>>
>> : Disable devfreq-event device on remove() to fix unbalanced
>>   enable-disable count.
>>
>> : Use devm_pm_opp_of_add_table()
>>
>> : Block PMU (Power-Management Unit) transitions when scaling frequency
>>   by ARM Trust Firmware in order to fix the conflict between PMU and DMC
>>   (Dynamic Memory Controller).
>> ----------------------------------------------------------------
>>
>> Brian Norris (15):
>>       dt-bindings: devfreq: rk3399_dmc: Convert to YAML
>>       dt-bindings: devfreq: rk3399_dmc: Deprecate unused/redundant properties
>>       dt-bindings: devfreq: rk3399_dmc: Fix Hz units
>>       dt-bindings: devfreq: rk3399_dmc: Specify idle params in nanoseconds
>>       dt-bindings: devfreq: rk3399_dmc: Add more disable-freq properties
>>       PM / devfreq: rk3399_dmc: Drop undocumented ondemand DT props
>>       PM / devfreq: rk3399_dmc: Drop excess timing properties
>>       PM / devfreq: rk3399_dmc: Use bitfield macro definitions for ODT_PD
>>       PM / devfreq: rk3399_dmc: Support new disable-freq properties
>>       PM / devfreq: rk3399_dmc: Support new *-ns properties
>>       PM / devfreq: rk3399_dmc: Disable edev on remove()
>>       PM / devfreq: rk3399_dmc: Use devm_pm_opp_of_add_table()
>>       PM / devfreq: rk3399_dmc: Avoid static (reused) profile
>>       soc: rockchip: power-domain: Manage resource conflicts with firmware
>>       PM / devfreq: rk3399_dmc: Block PMU during transitions
>>
>> Chanwoo Choi (3):
>>       PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
>>       PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
>>       PM / devfreq: passive: Keep cpufreq_policy for possible cpus
>>
>> Saravana Kannan (1):
>>       PM / devfreq: Add cpu based scaling support to passive governor
>>
>>  .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 212 -----------
>>  .../memory-controllers/rockchip,rk3399-dmc.yaml    | 384 ++++++++++++++++++++
>>  drivers/devfreq/devfreq.c                          |  20 +-
>>  drivers/devfreq/governor.h                         |  27 ++
>>  drivers/devfreq/governor_passive.c                 | 403 +++++++++++++++++----
>>  drivers/devfreq/rk3399_dmc.c                       | 312 ++++++++--------
>>  drivers/soc/rockchip/pm_domains.c                  | 118 ++++++
>>  include/linux/devfreq.h                            |  17 +-
>>  include/soc/rockchip/pm_domains.h                  |  25 ++
>>  9 files changed, 1063 insertions(+), 455 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
>>  create mode 100644 include/soc/rockchip/pm_domains.h
> 
> Pulled, thanks!
> 
> 

Dear Rafael,

The some changes on this pull request contains the not fixed issue
related to devfrq passive governor. After sending the pull request,
I got it. But, this issue don't cause the crash. Just failed to
change the frequency of device which using passive governor.

I'll send the separate fixup patch. Thanks.

Best Regards,
Chanwoo Choi
Samsung Electronics
