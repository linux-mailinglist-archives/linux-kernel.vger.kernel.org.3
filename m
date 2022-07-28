Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE83583E29
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbiG1L6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiG1L6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:58:11 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB5F691D0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:58:06 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220728115801euoutp02cf5463a13bfd4af2e8361413c0c85c72~F-FVTttTo0414304143euoutp02x
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:58:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220728115801euoutp02cf5463a13bfd4af2e8361413c0c85c72~F-FVTttTo0414304143euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659009481;
        bh=3wL6UYWnFyL5s9rW2QWUADaEzHZmXHPlLMYsmZLcFyg=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=U5fgsxibB97qsa0zcKisscq9gJy0zeal5WvDGG4q83Lc/iXS51s3RUn8PEniDv1hi
         TCuSSwF93AeQ6dXmflnxsqu84eB6XkROP/rkQC0fJQSCIPqmInRMlo55358eZAhAmH
         rZ3g1+Auk0jtIV02OhOYPgFH/i3UblRuxCsvhI54=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220728115800eucas1p1cfc0536b8810df81ea18e3f25a846771~F-FU-7W-02681226812eucas1p1O;
        Thu, 28 Jul 2022 11:58:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 28.E3.10067.8C972E26; Thu, 28
        Jul 2022 12:58:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220728115800eucas1p1ef291627fc0b897e1a8b9eec57c6f561~F-FUlA6Ay1218012180eucas1p15;
        Thu, 28 Jul 2022 11:58:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220728115800eusmtrp2a03c0e871dd6ae6be0ac755217f4daa5~F-FUkG1QQ1863418634eusmtrp2T;
        Thu, 28 Jul 2022 11:58:00 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-b5-62e279c8453c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4A.82.09038.8C972E26; Thu, 28
        Jul 2022 12:58:00 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220728115800eusmtip2a18e1ce7d66d68ae6bb638c7ef0e7597~F-FUVbZpZ1315713157eusmtip2a;
        Thu, 28 Jul 2022 11:58:00 +0000 (GMT)
Received: from [106.110.32.100] (106.110.32.100) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 28 Jul 2022 12:57:58 +0100
Message-ID: <e0606903-c007-43f1-538f-b70ee607be0a@samsung.com>
Date:   Thu, 28 Jul 2022 13:57:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/11] support non power of 2 zoned device
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        <damien.lemoal@opensource.wdc.com>, <hch@lst.de>,
        <axboe@kernel.dk>, <snitzer@kernel.org>,
        <Johannes.Thumshirn@wdc.com>
CC:     <matias.bjorling@wdc.com>, <gost.dev@samsung.com>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>,
        <linux-block@vger.kernel.org>, <pankydev8@gmail.com>,
        <jaegeuk@kernel.org>, <dm-devel@redhat.com>,
        <linux-nvme@lists.infradead.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.100]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djPc7onKh8lGfQf17ZYfbefzWLah5/M
        Fr/Pnme22PtuNqvFnkWTmCxWrj7KZPFk/Sxmi79d95gs9t7Stri8aw6bxfxlT9ktJrR9ZbZY
        c/Mpi8WJW9IOfB6Xr3h77Jx1l93j8tlSj02rOtk8Ni+p99h9s4HNY2frfVaP9/uuAoVOV3t8
        3iTn0X6gmymAO4rLJiU1J7MstUjfLoEr4/m8FtaCY+wVk/fdYmtg7GLrYuTkkBAwkZi1exU7
        iC0ksIJRYs21+C5GLiD7C6PE7WkfmCCcz4wS+2+cBergAOuYd6kMomE5o8SXD8FwNQtP3oFq
        2M0osfvTElaQKl4BO4kFO+cwgtgsAqoS07+sYoKIC0qcnPmEBcQWFYiUWLP7LNgZwgKOEh+f
        fQOrZxYQl7j1ZD7YUBGBpYwS/25fZANxmAU+MEpcau9gBTmJTUBLorETrJlTwFpi+owtzBDN
        mhKt23+zQ9jyEs1bZzND/KwkMWHefaj/ayXWHjvDDjJTQuAWp0TPtmNQRS4ST/+/hCoSlnh1
        fAs7hC0j8X/nfCYIu1ri6Y3fzBDNLYwS/TvXQ8PIWqLvTA5EjaPE9i3nWCDCfBI33gpC3MMn
        MWnbdOYJjKqzkMJiFpKfZyF5YRaSFxYwsqxiFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQI
        TH6n/x3/soNx+auPeocYmTgYDzFKcDArifAmRN9PEuJNSaysSi3Kjy8qzUktPsQozcGiJM6b
        nLkhUUggPbEkNTs1tSC1CCbLxMEp1cDEJlu6N3etXV2+6POepSv6GMxr1cS9tUymybrrzu3X
        XJDRbHHIRuzVY8MLF1wbdH8Y1EdwnxIUexp0gK/yJ8fBRdt+tp7kmlNcFHSskzljrUbDuZwp
        6wVn7swNOdGUsU2ymYPrmLyroGXFzv5yrZ82NV1TFPZ/rH7G/3PGse9l+nl7rk9YH2UYuvDf
        uwxWJh27eXar1uzO47uiOuHv71uzDjirqbqFrn1msGseg3DgdbeexV2vPtcIa58uDVcwvF7y
        QmorBx/7p5vf9yzlXW44/06ak7z7TB2tr9cWb8lff05+haGi6JFlywRXzGO6PlPWOOuzcfPl
        b9UfLfdqld/0reM0PZO1flEsV63i+rVKLMUZiYZazEXFiQD0Zw0g7QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsVy+t/xe7onKh8lGczcxGux+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLPYsmMVmsXH2UyeLJ+lnMFn+77jFZ7L2lbXF51xw2i/nLnrJbTGj7ymyx
        5uZTFosTt6Qd+DwuX/H22DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we7/ddBQqdrvb4
        vEnOo/1AN1MAd5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJexvN5LawFx9grJu+7xdbA2MXWxcjBISFgIjHvUlkXIxeHkMBSRonem0tYuhg5geIy
        Ep+ufGSHsIUl/lwDqecEKvrIKHFwvz1Ew25GieUX3jKCJHgF7CQW7JwDZrMIqEpM/7KKCSIu
        KHFy5hOwoaICkRIPlzWBxYUFHCU+PvsGVs8sIC5x68l8JpChIiBXzJn5hBHEYRb4wChxqb2D
        FWLdfkaJM+u3M4PczSagJdHYCXYep4C1xPQZW5ghJmlKtG7/zQ5hy0s0b53NDPGCksSEeffZ
        IOxaiVf3dzNOYBSdheTAWUgOmYVk1CwkoxYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQI
        TBrbjv3csoNx5auPeocYmTgYDzFKcDArifAmRN9PEuJNSaysSi3Kjy8qzUktPsRoCgylicxS
        osn5wLSVVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXApPM/xdil
        7GibE+++LP7Aw10fZ2QyLpj1sCf51faKgz+VE8omPNXQqZnLdZdtkqiAQUPa4uocgfdWG81z
        f3F6fnWNnCj+UnPlxkX99ZdOxCRzHnp6OHbJ7y7+9LaFlVfNJsm3np7M9/LfkdVZdvxFitov
        F4a7TFmsNXP5xi2zX6nGM/jyv0p+tFN5mX/AQ9+t3yrF5kftau/SZ/2got5VPb91q3fTgjc7
        X0yIu6Txxoar7uYh8eXfS3peVVQulBA18vbn7pH7djTj9eOELd3HN1fu2e/Xdba6lk8v7V2k
        YepnqcS8s6ev/Jna4MGs3Bxj9TTZ7aFwyrXfSguV2D/cmfglWzzzkvPqk70bAlmuKLEUZyQa
        ajEXFScCAFkXhv6jAwAA
X-CMS-MailID: 20220728115800eucas1p1ef291627fc0b897e1a8b9eec57c6f561
X-Msg-Generator: CA
X-RootMTR: 20220727162246eucas1p1a758799f13d36ba99d30bf92cc5e2754
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162246eucas1p1a758799f13d36ba99d30bf92cc5e2754
References: <CGME20220727162246eucas1p1a758799f13d36ba99d30bf92cc5e2754@eucas1p1.samsung.com>
        <20220727162245.209794-1-p.raghav@samsung.com>
        <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 2022-07-28 01:19, Bart Van Assche wrote:
> On 7/27/22 09:22, Pankaj Raghav wrote:
>> This series adds support to npo2 zoned devices in the block and nvme
>> layer and a new **dm target** is added: dm-po2z-target. This new
>> target will be initially used for filesystems such as btrfs and
>> f2fs that does not have native npo2 zone support.
> 
> Should any SCSI changes be included in this patch series? From sd_zbc.c:
> 
>     if (!is_power_of_2(zone_blocks)) {
>         sd_printk(KERN_ERR, sdkp,
>               "Zone size %llu is not a power of two.\n",
>               zone_blocks);
>         return -EINVAL;
>     }
> 
I would keep these changes out of the current patch series because it
will also increase the test scope. I think once the block layer
constraint is removed as a part of this series, we can work on the SCSI
changes in the next cycle.
> Thanks,
> 
> Bart.
