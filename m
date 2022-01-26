Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7EC49C603
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiAZJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:15:41 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36402 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbiAZJPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:15:35 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220126091534euoutp01f6d1796ec219e6ac39218ddb9a73d7d7~Nx0Q92-EC2541025410euoutp01i
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:15:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220126091534euoutp01f6d1796ec219e6ac39218ddb9a73d7d7~Nx0Q92-EC2541025410euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643188535;
        bh=XgsHgl1oVwfYUxIRBZLbSXWa7mXCyCz7MnL7p0e0ixI=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=KcCIoNFQgpNehL+93hgJBxloIVKKoioJkldqmWatL+uMHOT3EZoa2971MZP+k7BpQ
         1TmfsQ3rpLYmPrbmNuvsDCpCshhZNc0zGggDLPvzIBksrzh0YBR7jVewhxnIHJ6dtK
         1PKNlbAmNT2fse0Wah8vR6yhzTY/QRbLB+rMsg8w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220126091534eucas1p10a3ca19cbb7c9a94b9331be8524245d9~Nx0QoQoup2115721157eucas1p1Y;
        Wed, 26 Jan 2022 09:15:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EF.4D.10260.63111F16; Wed, 26
        Jan 2022 09:15:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220126091533eucas1p269b6b3ab771a2a523a755473c899944a~Nx0P7dd2_2783227832eucas1p2e;
        Wed, 26 Jan 2022 09:15:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220126091533eusmtrp14ee1d27471c2b4f73d4cc6ba4fd0ed30~Nx0P57v5B1411414114eusmtrp1y;
        Wed, 26 Jan 2022 09:15:33 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-2a-61f11136e530
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 32.42.09404.53111F16; Wed, 26
        Jan 2022 09:15:33 +0000 (GMT)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220126091532eusmtip26d2793bebd53b8bfafb11bc1e4e2905c~Nx0Ob-Nn52455224552eusmtip2a;
        Wed, 26 Jan 2022 09:15:32 +0000 (GMT)
Message-ID: <c5e523c9-b9e6-c90d-0e94-8410948e43a1@samsung.com>
Date:   Wed, 26 Jan 2022 10:15:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v5 05/16] clk: samsung: fsd: Add cmu_peric block clock
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
        Aswani Reddy <aswani.reddy@samsung.com>,
        Niyas Ahmed S T <niyas.ahmed@samsung.com>,
        Chandrasekar R <rcsekar@samsung.com>,
        Jayati Sahu <jayati.sahu@samsung.com>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20220124141644.71052-6-alim.akhtar@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SeUyTZxjP234XXWq+Vra+1oXFeiybsdqwmdfglM0t+xJdxMXFI4uuyCcw
        oZhWOmBZYN0mrFTETlasTDxgZQ3CKJec1trZcVjJQLBKQEbJEEQGpQgeZZYPM/57nt/xXHko
        vngOl1LxqmOsWqVMkBECrObGrHvdRtGEcsPYY4js49cwdP9cDYGeG2+QyFFZTaLxXw0AFTrd
        OHK2FvFQxdgMD51+ZuEh22A3jiYMfTgaGNmDOusLCJR/q5mHvKf/xlFrj49AF6unSGTuuIKj
        H5qcJAp0V2BosOcZge49LMMjX2NKz5UC5ukTI2DMGScIxmb9kWB6uxsJprIonen6U4czOVVW
        wAR0v5CMzxYWJdgv2BzDJsRrWfX6LV8I4mYKMvGj03hKTv99LAPk4XoQQkH6HfjcZHgRCygx
        XQKgv7cL45IpALPcZQSX+AA82fKQ99Ji+WuAxxEWAB/pShf8EwC6qizzKiG9BXoeXAN6QFEY
        vRoev7qXg0Ww5YwXC8Kv0tHQ8P22ILyU3gvdjZdBMObTEnjXWzhfJZROgrOBuvmJ+HQtBvP9
        TiJIELQCnvgjZ94QQr8HPZ06nDO/AWvHCvhBA6QnQ6CtbBoPNoP0h7C4OpRbYCkccVWRXPw6
        bPvJgHH67wA0NNwjuSQXwH7XecCpImCv+wkRLMSn34Ll9es5+H3Ybm/mc/WXwDtjIm6GJdBY
        Y1qAhTDruJhTr4JPraaFG0phtncOywUy86KrmBetb160jfn/vucBZgUSNlmTGMtqwlXsV3KN
        MlGTrIqVH0pKtIEXP9oWcPmvgJKRCbkD8CjgAJDiy0KFc9vHlWJhjDI1jVUnHVQnJ7AaB1hO
        YTKJ8FD870oxHas8xh5h2aOs+iXLo0KkGTxR7OVXPlN4Nq2I842Kum7Th/X7jHcq5FFhDpf1
        0uQu6e7w4uHyDxK+3SHPl2UKpr5UHHnTtCfckzJKCs+kGiS3rtu8npaPAv6sNavIsI4VJbI6
        kSy9M02bNGMyYe9+7tz/m/5Bbo+x/99Na37erFOo9K3rljVHXETRqY2ivutszuDOhquJX09W
        DJ268Mmj/l3auzFpuga7fXj3hfaC9g1D27bnRTaV1vrbVvYZY1TZHYXdudIDlvCPHaPpWn1l
        0amZk4K+WdG+1I0DvqbsEkl+ynCkIOWbPHTz8U1B/dniT6uGlk8zUQfnIspp+9bbjWu3nr1U
        d5ivrYnO7Fj2T89KabwM08QpFW/z1Rrlf33P0MgSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsVy+t/xe7qmgh8TDe7vU7E48P4gi8WDedvY
        LP5OOsZucWjzVnaL98t6GC3mHznHanHk1BImi41vfzBZTPmznMli0+NrrBYfe+6xWjx8FW5x
        edccNosZ5/cxWTyZ8ojV4tT1z2wWi7Z+YbeYdWEHq0Xr3iPsFv+ubWSxeHz9D5vF7TfrWB3E
        PNbMW8Po8fvXJEaPWQ29bB6bVnWyedy5tofNY/OSeo8rJ5pYPfq2rGL0+Nc0l93j8ya5AK4o
        PZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwfc9pZ
        C76xVvTdf8DSwDiVtYuRk0NCwERi+aWHTF2MXBxCAksZJS6vnwOU4ABKSEnMb1GCqBGW+HOt
        iw2i5j2jxKWHl8CaeQXsJG6+PMgIUs8ioCrRtj8CIiwocXLmExYQW1QgSaLhWDcbiC0sECFx
        bs9aRhCbWUBc4taT+UwgtohAvsSf/o+sIPOZBXaySDQdegG17DCjROfBTWDL2AQMJXqP9oF1
        cwrYSty83AR2KLOAusT6eUIQQ+Ultr+dwzyBUWgWkjtmIdk3C6FjFpKOBYwsqxhFUkuLc9Nz
        i430ihNzi0vz0vWS83M3MQKTxrZjP7fsYFz56qPeIUYmDsZDjBIczEoivP+93ycK8aYkVlal
        FuXHF5XmpBYfYjQFBsVEZinR5Hxg2soriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5N
        LUgtgulj4uCUamCSSKxd/MfMsfcpd1xuviHDxOUHZnvbzHvJcEz7TK+Cw+QNf4Wlsju1PuZ0
        rdGsO5v1Yapq/XSdXWenVK6ZnzjltHr20+O/RS+cNoipe6a3P+H8pn2+NSeNDfTYeHevDrv3
        fJ4iu5bnm1ixh9wBEzuE73p/8Nz//I3ZleO5qw9c/OD0mDVx1SbrJY0Tvlb2z1DZJfbj8rZ7
        um1r/ko1MP/c7MKtxfn2ZYnai2yNKrMvuh1CTOci5/BzytQJqr26nMRddmzKHZEb0oVdLIe+
        OR3Q2T/fM2tfyOeVSmE/t94y3tRezX+Id8tvpW1s4h8ao43iNf5tPJLzNzVoJ4+LnKTPWuc3
        vHZ1PNp5HK+3rwxTYinOSDTUYi4qTgQAgTRmWKMDAAA=
X-CMS-MailID: 20220126091533eucas1p269b6b3ab771a2a523a755473c899944a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220124142915epcas5p2c112efe9f08ffa2a53122f4e2b8042e1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220124142915epcas5p2c112efe9f08ffa2a53122f4e2b8042e1
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142915epcas5p2c112efe9f08ffa2a53122f4e2b8042e1@epcas5p2.samsung.com>
        <20220124141644.71052-6-alim.akhtar@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.2022 15:16, Alim Akhtar wrote:
> Add CMU_PERIC block clock information needed for various IPs
> functions found in this block.
> 
> Cc: linux-fsd@tesla.com
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

