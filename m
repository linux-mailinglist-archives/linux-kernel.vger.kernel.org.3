Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FB152B82E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiERK4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiERK4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:56:12 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD382220DD
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:56:08 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220518105603euoutp01155c37b4cc34259d41ad6a85388c6bc9~wLb9jfViP3160931609euoutp01A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:56:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220518105603euoutp01155c37b4cc34259d41ad6a85388c6bc9~wLb9jfViP3160931609euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652871363;
        bh=c6Iz5ZntNihwLjPXgBN2F9JFSBqZL/va7TdXprrNtfY=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=YdIBe9bzvzhLBUztUjlWPDIZhHf3XqfxrbheR7OmYKmP3mS8uavZJLGa+P2FwCz03
         GGY+ylqXsWCvv7jlDi94z3pz1zE97oULntAFmmvS6FGS9DoFr+wH+QCrN+mLdXQavg
         Ez4SWJV5r0xCPjlY6JPT31BBBpwzqB7ZgY/Ea0kk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220518105602eucas1p2d88d20b16ee6969279dc3ea931c9ed83~wLb8Z0YG01708717087eucas1p2K;
        Wed, 18 May 2022 10:56:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FA.E0.10009.1C0D4826; Wed, 18
        May 2022 11:56:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220518105601eucas1p2d236756bee50f4f48cbdd9833a04fd2a~wLb7t_fgB1708717087eucas1p2I;
        Wed, 18 May 2022 10:56:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220518105601eusmtrp28230a3b11608080cdb68ae7c963748ef~wLb7soGGQ0808108081eusmtrp2x;
        Wed, 18 May 2022 10:56:01 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-0a-6284d0c175a7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DE.5E.09404.1C0D4826; Wed, 18
        May 2022 11:56:01 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220518105600eusmtip127db6f6afca57c829c6e15ec5e064e1d~wLb7DE6PH0676606766eusmtip16;
        Wed, 18 May 2022 10:56:00 +0000 (GMT)
Message-ID: <59f53724-87fe-97b8-0660-dcb1a5b464fe@samsung.com>
Date:   Wed, 18 May 2022 12:56:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v5 0/4] PM / devfreq: Add cpu based scaling support to
 passive governor
Content-Language: en-US
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220517092108.31680-1-cw00.choi@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zk7OxuujrPaiw2LdbXwlkGnC5IhtKggiuiCaUc9TctbWyvL
        SKtlMTSjXOo0KrIyM11makKLpjbKaqZYYReqFY65KTalWsxyO1389/Bc3ud9Pz4Skxj5wWRa
        5j5WlcmkywkR3vTohzXsYZc2KdL+cQndXG/n069G+vn0mRPNGG15UCWgH3k20c+OOQV0T2sl
        QbuL2hHtNtoQ/eZoNUHrzF6CLivo4a8MUFTkv8AVlxo0Cu3jB7jidGMNUrgbQjbwt4tWpLDp
        aftZVUTMTlHq9+4nRHbr3Bx7h1eQjwpn6pCQBGoxVL8fEuiQiJRQ1Qhu3Rnl+QQJNYKgbyiI
        E9wILhd3YH8TPww2HidcR2Atr8C5xDACk2m3D4upGCgwnkc+jFNz4JjruoDjA+Fx+We/fyqV
        BE5nr39oELUDTM5+P8YoKfR9vujfYsq4p6Llrr8Mo2wIvlU5+T6BoKJA59IRPiyklsO3tisE
        F54Bza7KP5ueFILt3SwdIsdxHAwWL+XoIHBYGgUclsGve74unyULvGXRHJ0DLwdq/0xZDm+f
        ewifBaNCob41gqNj4f7YKM4lJ8FrVyDXPwnONpViHC2GUwUSzj0XDJa6f50Pu7qxM0humPAk
        hgmnGyZcYvjfewnhNUjKatQZSlYdlckeCFczGWpNpjI8OSujAY1/qs4xy9cWdMExHG5GPBKZ
        EZCYfIoYZWiTJOIU5uAhVpWVqNKks2ozmk7icqk4Oc3ISCgls4/dw7LZrOqvyiOFwfm8tagx
        NQJWY/a9MLv+xqC+u+BOe+BAAM/iUX1qu53WGmL15g3XesOgbywwumvo8PuFubJVh9tSS+L7
        RbKdg4xHu6Snpm7Vsq/z23qPy+bEecQxYQPWc7maEr2+8IhDaipcc81k1/betJ3SO2Pz1g+V
        /OycpWoeiVdOTXdRKdU5N27XmlMO6cOo9hObTZNbNi/Iv7gpd0u8sCGS/TK/LMH4pGNXccCG
        RZGrY7uilYWhye7OLYlrWuoSmY135Uz4umVFBz9ml4ujQiW6D2Te06PT+uLfssX1zptbZc8l
        80odlrHKSlfeRse2p7X4ixBpQoy1qar7/LWr+wXBJ99EL7XKcXUqE7UAU6mZ327U0xvDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7oHL7QkGSw7zmuxff0LVovrX56z
        Wkxo3c5scXz/EnaLY7+CLc42vWG3uLxrDpvF594jjBafNzxmtLjduILNouvQXzaLGW2XWR14
        PGY3XGTxWLCp1KPl5H4Wj74tqxg9Pm+SC2CN0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
        MzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mv4cekUW8EutYoXR/+yNzD2KHQxcnJICJhI/Jz1mKmL
        kYtDSGApo8S9O2fZIRIyEienNbBC2MISf651sUEUvWeUuLT+MTNIglfATqJtwzRGEJtFQFWi
        6e1ydoi4oMTJmU9Yuhg5OEQFkiSOHOYHCQsLxErse/McrJVZQFzi1pP5TCC2CFDJjilNzCDz
        mQUeM0pcnv+ABWJZH6PEvwuXWECq2AQMJbreglzBycEpYC3x/fBiNohJZhJdW7sYIWx5ie1v
        5zBPYBSaheSOWUgWzkLSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBUbrt2M8t
        OxhXvvqod4iRiYPxEKMEB7OSCC9jbkuSEG9KYmVValF+fFFpTmrxIUZTYGBMZJYSTc4Hpom8
        knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamfM1FRRH3C7Lttq/6
        tvdQcFv5j7NLHl4vv+rzrcf8jxnXFPulq3/diXW1ts15fmvWqXMb989Tdwh/KbTuw8ppa3hW
        re4rmi32ycFRW/ajVm5SdIlfspron0txt9Ik1y9U1WarNQhlTQoQZN257OihFwInDpy8kNSy
        c37Oo2fvs8uLJhny5YRa/JkWspFLm6dIdsWhpUXXxTv/XHi6/NqaKTvWG64Qdfhf3aP/aOed
        jcE3EjhOxcXE1bGdk2Baue3CQZfqiR5tR3g8i19w/2mx29vy+vECA8XYvfeKrfjmrj36fuXs
        gHO7903mM9q+zKktm7XjsqmnQNn3v0nP5+vzWX0v3rFKyXJZTIwR26QgEyWW4oxEQy3mouJE
        AFQAZ3tbAwAA
X-CMS-MailID: 20220518105601eucas1p2d236756bee50f4f48cbdd9833a04fd2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220517085446epcas1p4c07ab7d3b80d62c0093c3a45484eae97
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220517085446epcas1p4c07ab7d3b80d62c0093c3a45484eae97
References: <CGME20220517085446epcas1p4c07ab7d3b80d62c0093c3a45484eae97@epcas1p4.samsung.com>
        <20220517092108.31680-1-cw00.choi@samsung.com>
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17.05.2022 11:21, Chanwoo Choi wrote:
> The devfreq passive governor has already supported the devfreq parent device
> for coupling the frequency change if some hardware have the constraints
> such as power sharing and so on.
>
> Add cpu based scaling support to passive governor with required-opp property.
> It uses the cpufreq notifier to catch the frequency change timing of cpufreq
> and get the next frequency according to new cpu frequency by using required-opp
> property. It is based on patch[1] and then just code clean-up by myself.
>
> Make the common code for both passive_devfreq and passive_cpufreq
> parent type to remove the duplicate code.

I've just tested it on Exynos based boards and on all I see the 
following issues after system suspend/resume cycle:

# time rtcwake -s10 -mmem
rtcwake: wakeup from "mem" using /dev/rtc0 at Wed May 18 11:13:16 2022
PM: suspend entry (deep)
Filesystems sync: 0.001 seconds
Freezing user space processes ... (elapsed 0.002 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.

...

devfreq soc:bus-disp1-fimd: failed to suspend devfreq device
devfreq soc:bus-jpeg-apb: failed to suspend devfreq device
devfreq soc:bus-jpeg: failed to suspend devfreq device
devfreq soc:bus-g2d-acp: failed to suspend devfreq device
devfreq soc:bus-g2d: failed to suspend devfreq device
devfreq soc:bus-peri: failed to suspend devfreq device
devfreq soc:bus-gen: failed to suspend devfreq device
devfreq soc:bus-mfc: failed to suspend devfreq device
devfreq soc:bus-fsys2: failed to suspend devfreq device
devfreq soc:bus-fsys-apb: failed to suspend devfreq device
devfreq soc:bus-noc: failed to suspend devfreq device
...
Disabling non-boot CPUs ...
Enabling non-boot CPUs ...
...
devfreq soc:bus-mscl: failed to resume devfreq device
devfreq soc:bus-gscl-scaler: failed to resume devfreq device
devfreq soc:bus-disp1: failed to resume devfreq device
devfreq soc:bus-disp1-fimd: failed to resume devfreq device
devfreq soc:bus-jpeg-apb: failed to resume devfreq device
devfreq soc:bus-jpeg: failed to resume devfreq device
devfreq soc:bus-g2d-acp: failed to resume devfreq device
devfreq soc:bus-g2d: failed to resume devfreq device
devfreq soc:bus-peri: failed to resume devfreq device
devfreq soc:bus-gen: failed to resume devfreq device
devfreq soc:bus-mfc: failed to resume devfreq device
devfreq soc:bus-fsys2: failed to resume devfreq device
devfreq soc:bus-fsys-apb: failed to resume devfreq device
devfreq soc:bus-noc: failed to resume devfreq device

Some boards (like Trats2) after suspend/resume cycle reveals random crashes.

All those issues were not observed before applying this patchset.

> [1] [RFC,v2] PM / devfreq: Add cpu based scaling support to passive_governor
> - https://lore.kernel.org/patchwork/patch/1101049/
>
> Changes from v4:
> : https://patchwork.kernel.org/project/linux-pm/cover/20220511093554.17535-1-cw00.choi@samsung.com/
> - Fix issue[2] reported by Marek Szyprowski
> [2] https://patchwork.kernel.org/project/linux-pm/patch/20220511093554.17535-3-cw00.choi@samsung.com/
>
> Changes from v3:
> : ttps://patchwork.kernel.org/project/linux-pm/cover/20220509120337.92472-1-cw00.choi@samsung.com/
> - Add tested-by tag of both Chen-Yu Tsai and Johnson Wang
> - Fix some typo
>
> Changes from v2:
> : https://patchwork.kernel.org/project/linux-pm/cover/20220507150145.531864-1-cw00.choi@samsung.com/
> - Drop the following patch ("PM / devfreq: passive: Update frequency when start governor")
> - Move p_data->this initialization into cpufreq_passive_regiser_notifier()
>
> Changes from v1:
> : https://patchwork.kernel.org/project/linux-pm/cover/20210617060546.26933-1-cw00.choi@samsung.com/
> - Rename cpu_data variable to parent_cpu_data to avoid build fail
> - Use for_each_possible_cpu macro when register cpufreq transition notifier
> - Add missing exception handling when cpufreq_passive_register_notifier is failed
> - Keep cpufreq_policy for posible cpus instead of NR_CPU in order to avoid
>    the memory waste when NR_CPU is too high.
> - Add reviewed-by tag of Matthias Kaehlcke for patch1
>
> Chanwoo Choi (3):
>    PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
>    PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
>    PM / devfreq: passive: Keep cpufreq_policy for possible cpus
>
> Saravana Kannan (1):
>    PM / devfreq: Add cpu based scaling support to passive governor
>
>   drivers/devfreq/devfreq.c          |  20 +-
>   drivers/devfreq/governor.h         |  27 ++
>   drivers/devfreq/governor_passive.c | 403 ++++++++++++++++++++++++-----
>   include/linux/devfreq.h            |  17 +-
>   4 files changed, 389 insertions(+), 78 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

