Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA1E49C611
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbiAZJRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:17:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:61831 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiAZJRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:17:16 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220126091715euoutp02c0fb4350f5a20401a7d6327842a7f994~Nx1u9hbWO2039720397euoutp02_
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:17:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220126091715euoutp02c0fb4350f5a20401a7d6327842a7f994~Nx1u9hbWO2039720397euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643188635;
        bh=C2cbH0hwtITNczT0FVZDrWtGw/ZO0qBeImRpUNHHHm0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=CGNt5ldHWIWOwwC5I3a5zXNdEn4e6CPDNMdvI/wdZ0CSAlrJIpuzP/i501FRhEyfF
         av13fM5k1uQLrY/njfrMXHSM7QhVm+v5435ccCC7BVi6bexPpGF4EeHg8RPoxiW02G
         xYSoUrzqcR/d/+JzWfyhfmg6Zy5KvI+OvB96zFfU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220126091715eucas1p1282af0b83cdc52e396420cfadf3c95d9~Nx1uaMrLT2854928549eucas1p1Z;
        Wed, 26 Jan 2022 09:17:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 92.1F.10009.A9111F16; Wed, 26
        Jan 2022 09:17:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220126091714eucas1p1d57849aee0c4a1b479ce8a68f04a93dd~Nx1t1Zxdn0621406214eucas1p1l;
        Wed, 26 Jan 2022 09:17:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220126091714eusmtrp21f2a458fa95806561de83df4a2135aac~Nx1t0IFPf3158531585eusmtrp2I;
        Wed, 26 Jan 2022 09:17:14 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-9c-61f1119ad950
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EB.43.09522.A9111F16; Wed, 26
        Jan 2022 09:17:14 +0000 (GMT)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220126091713eusmtip266948739c64d798c45756abf073df9b2~Nx1suM_hS2455224552eusmtip2-;
        Wed, 26 Jan 2022 09:17:13 +0000 (GMT)
Message-ID: <9208c599-ee3b-a6b6-6d71-3ed48fe9a4b8@samsung.com>
Date:   Wed, 26 Jan 2022 10:17:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v5 07/16] clk: samsung: fsd: Add cmu_fsys1 clock
 information
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        sboyd@kernel.org, linux-fsd@tesla.com,
        Ajay Kumar <ajaykumar.rs@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20220124141644.71052-8-alim.akhtar@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfVCTdRzv9zzbs2e7xj2bevsevXjt6rS6QASv50rtTW/PneWldXVNLR71
        CYiXcRsUdpbAyhQ2Xqa0NWCj2s2apm0YKEwiDmVirkJlvnCAbedyxa3FSBAcOR68+O/z8v38
        vi/3I3F5WJhK5hWVcNoitkBJSARtZ6b8TzXKYuyKbz9DdHf0JwE9amsj6DumMyI66jQg2t7r
        F9LusUmMPjhzCKM9wUEhHTMMC+nrkTfpCx1NBG35pQuj+wPjBP3VD3ER/empXhGdGHQL6GBg
        hnhexhyxHUHM9G0TYqzlRoLxuPYTzNCgl2BaHXuYi75KIVNz3IWYRGWziBn3PPyqRC1ZvZMr
        yHuf06avzZbk/th+lij242WdplFROarFq5CYBCoLrtiGhVVIQsqpbxA4LIPzJI6g0RuZJ+MI
        ug8kiHuRvfv+FPDGIQTBmX8xnsQQTHp7sGSVlFoLnRUXhEksoB6DKUuNkNdlcPaL0N00SS6h
        toPhk5eScBG1Ger0TLICpxRwNWSfe2UxpYGpxMm5XjgVxuBGba0gaRBUBhhP16AkFlNr4Fqg
        G+fDS6F9rAlPBoAaEIPvO4eIn3odXDLvRzxeBJG+4/P6gzB70o7xAT0CQ+c1EU/qEIz0tcwn
        noUh/20iOSpOPQ7HOtJ5+QW4c7hjTgYqBS6PyfghUsDUZsZ5WQr79sr56kdh2mXGeJwK1aFZ
        QR1SWhdcxbpgf+uCdaz/921BAhdScKW6whxOl1HEfZCmYwt1pUU5aTs0hR509y+eS/T9cwI1
        R2JpPQgjUQ8CElculs5uiLJy6U5214ecVvOOtrSA0/WgB0iBUiHdkfc9K6dy2BIun+OKOe09
        FyPFqeVYZte2sqP+ztmB3+MTNp/KFzgxgp/e2j709pCPVYergm9MrqZPHV0eHa7wv/i6cZVZ
        /fG63+x6U+/yptranO3X2caRfEv9Fc3AObu//+WJd6vN2caGMlAYWy3BA4onl4X13qUb76di
        j+z6S5XyUV16vnDlsYi34rXD8tC07PyXuy/Kly2Jl4Sai/ubFGq1Ntud5W/wOB0bu7JvSbZ+
        fvCh3D9uoG2vyFT1t+wryQlRzBbKUsslKc6f1zynv69YnEl+vf6Z0VbnzbJfNQF9FCrXb4At
        qunCVrfL6Ag/Xb877WrWpkTDisTNzNj5LcFGlZtcZYhfuvze+FvVzr9dFXtalAJdLpvxBK7V
        sf8BqLzRNPoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xe7qzBD8mGtw6L2Fx4P1BFosH87ax
        WfyddIzd4v2yHkaL+UfOsVpsfPuDyWLKn+VMFpseX2O1+Nhzj9Xi4atwi8u75rBZzDi/j8ni
        1PXPbBaLtn5ht2jde4Td4t+1jSwWj6//YXMQ9Fgzbw2jx+9fkxg9ZjX0snlsWtXJ5nHn2h42
        j81L6j2unGhi9ejbsorR41/TXHaPz5vkArii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1
        DI3NY62MTJX07WxSUnMyy1KL9O0S9DL2bz/JVnCOuWL3pAfsDYz9zF2MnBwSAiYSbR2vWUBs
        IYGljBInV1Z2MXIAxaUk5rcoQZQIS/y51sXWxcgFVPKeUeLeqRdgvbwCdhK7Gy+zgtgsAqoS
        P2f0sULEBSVOznwCNlNUIEmi4Vg3G8hMYYEgiQnNHiBhZgFxiVtP5jOB2CIC+RJ/+j+ygsxn
        FnjOJNFw8gczxLLDjBLHvp0FG8QmYCjRe7SPEcTmFLCVuH39ADPIUGYBdYn184QghspLbH87
        h3kCo9AsJGfMQrJvFkLHLCQdCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgQmgG3Hfm7e
        wTjv1Ue9Q4xMHIyHGCU4mJVEeP97v08U4k1JrKxKLcqPLyrNSS0+xGgKDIqJzFKiyfnAFJRX
        Em9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cDE+i1Axb/r+TaBl5pm
        hY72blmp+V+vHdzxXXz2mjult7qOHrB8aBl/dOXtiO9hUXekKkTcunPKlgrsuBH8QUO9/ubc
        UPfjTbKqC57+rljqW3Vu7n5Wu3D5u2m2r+ZncE6fN1cimvm0ssL1Rt7H03wt57zL+Hf615UO
        xz+515XFkie2+kyXfmeTdXVme8jKzlV5f5efLXV6omViGiE6ryTg3CLd6HVvmjr0GGxefvSu
        WaTxS8LSIctsT9/tI3GWma0ZVr+viLpPkYpPMHiuxSqrvLTx0OkCpZa7l/6kKH1M233GSUiq
        4oqv+wtPa4n9ieY/GtqEbrdaXfyaL65taGEXNkvoZlvty6nvVpkJJymxFGckGmoxFxUnAgAj
        AJVBiQMAAA==
X-CMS-MailID: 20220126091714eucas1p1d57849aee0c4a1b479ce8a68f04a93dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220124142923epcas5p17cffd89f734eda4c7e9515ac4ec79fb5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220124142923epcas5p17cffd89f734eda4c7e9515ac4ec79fb5
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142923epcas5p17cffd89f734eda4c7e9515ac4ec79fb5@epcas5p1.samsung.com>
        <20220124141644.71052-8-alim.akhtar@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.2022 15:16, Alim Akhtar wrote:
> Adds cmu_fsys1 block clock information which are needed
> for PCIe IPs in block FSYS1.
> 
> Cc: linux-fsd@tesla.com
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
