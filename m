Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0524846EA7D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbhLIPEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:04:04 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33799 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239090AbhLIPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:04:03 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20211209150028euoutp029d1df6fabd2999c81b5e601a70a391a3~-HjsdQo0o0460904609euoutp02w
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:00:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20211209150028euoutp029d1df6fabd2999c81b5e601a70a391a3~-HjsdQo0o0460904609euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639062028;
        bh=CpQ6wI01stUHPWuOvsR2/RW01A0t73IkrDkwxchiTbo=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=RAPLuvP8qTI0j0fl1LB91BEFkdOWlM3XGQw35gc03SgtLYv9jfQKhvVDUP4ngxhVH
         QsFYWBJcupsdPjXDGyQZFa2YMuQctTZ/qKZbzJOIPruGb0hrV+d6caQIVRRqK7Tkni
         OxhHzh0tFZXFEL/VQt2HvoSD1fsTOM0XuXPkBxl4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211209150028eucas1p1539f8cb3c29c1078720984fe7328d53a~-HjsLcCG52762027620eucas1p1W;
        Thu,  9 Dec 2021 15:00:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 87.60.10009.C0A12B16; Thu,  9
        Dec 2021 15:00:28 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211209150028eucas1p219b6230e580770a6e93d828b467d3da3~-Hjr4gUK10123501235eucas1p2h;
        Thu,  9 Dec 2021 15:00:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211209150028eusmtrp15df38e2da81968635a1c631c128e7783~-Hjr3148h1310713107eusmtrp1q;
        Thu,  9 Dec 2021 15:00:28 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-f8-61b21a0cf6a9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.61.09404.C0A12B16; Thu,  9
        Dec 2021 15:00:28 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211209150027eusmtip13b50f66c7e16cb561e3e98a456d9b02c~-HjrlQi9y2665826658eusmtip1A;
        Thu,  9 Dec 2021 15:00:27 +0000 (GMT)
Message-ID: <4cc4c0f6-b3ff-1759-93be-04af47a0f4be@samsung.com>
Date:   Thu, 9 Dec 2021 16:00:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.3.2
Subject: Re: linux-next: Tree for Dec 8
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <YbH3lT7fh+YCCwjx@sirena.org.uk>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduznOV0eqU2JBtOvClpMffiEzeLyrjls
        FgcXtjFabN17ld2BxaPxxg02j02rOtk8Pm+SC2CO4rJJSc3JLEst0rdL4Mpo/baRteAVS8XF
        3YkNjD+Zuxg5OSQETCQu3N/M0sXIxSEksIJR4tOUG2wgCSGBL4wSD7s9IRKfGSVmb+pmgumY
        PGUDE0RiOaPEkbXHWSGcj4wS9/8uZAGp4hWwk1h96yEjiM0ioCKxYs4jJoi4oMTJmU/AakQF
        kiQmnNgNFhcWUJc49ms/2GpmAXGJW0/mA8U5OEQEfCQufi2DCJdIfFq9mxXEZhMwlOh62wVW
        zimgK/FkfwNUq7zE9rdzoF5byyGx+5UjhO0iMfvnX6i4sMSr41vYIWwZidOTe8DelxBoBvr4
        3Fp2CKeHUeJy0wxGiCpriTvnfrGBHMQsoCmxfpc+RNhRYveba2BhCQE+iRtvBSFu4JOYtG06
        M0SYV6KjTQiiWk1i1vF1cGsPXrjEPIFRaRZSoMxC8vwsJN/MQti7gJFlFaN4amlxbnpqsWFe
        arlecWJucWleul5yfu4mRmAyOf3v+KcdjHNffdQ7xMjEwXiIUYKDWUmE98bVjYlCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUamIpnCE7foxm2utqjYIWG
        h+Wx9nk/93evsJm9SKb524ulM3+xyR0LVd1jaLz1pvRVm4Xs+hGKVYcnpN6+yiv6WGzRzIfl
        y1fX6W7d0Fh8LzGkVGybufZRHfP+yq7VnbcWGd2+fXev4vz9DzaqKu01v5Ajlek88WDmgVvL
        9rrVmPbF3b4hW5x5+8dcrXU1515+DP0xx9j20641b4Xiu0rkIg+Utv1Urd+bU3lPonCHjqqg
        +IkpB/v23jGdL6ecW2vYEna+ze7007CVFQ1mS45nHDf30vS7XyLBJCTzev22R9eFd9QLBDjG
        6y96lbL5Zarvq9imuRXswgm31e803FjefWrvrTeh+/pakrVXhz89v0qJpTgj0VCLuag4EQBV
        NgZ0lQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7o8UpsSDXbOZrGY+vAJm8XlXXPY
        LA4ubGO02Lr3KrsDi0fjjRtsHptWdbJ5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfR+m0ja8ErloqLuxMbGH8ydzFyckgImEhMnrKB
        qYuRi0NIYCmjxI3581khEjISJ6c1QNnCEn+udbGB2EIC7xklFtypALF5BewkVt96yAhiswio
        SKyY84gJIi4ocXLmExYQW1QgSeLpgU6wXmEBdYljv/aD2cwC4hK3nswHqufgEBHwkbj4tQwi
        XCIxbcZOVohVkRLTNywDK2cTMJToegtxAqeArsST/Q1QY8wkurZ2MULY8hLb385hnsAoNAvJ
        FbOQbJuFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAqNn27GfW3Ywrnz1Ue8Q
        IxMH4yFGCQ5mJRHeG1c3JgrxpiRWVqUW5ccXleakFh9iNAUGxURmKdHkfGD85pXEG5oZmBqa
        mFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MM0p67/2Xi/Ou6unIOiG1dxos5Pr
        ws+8iWrzTpKJrLk8p/ubfm53xNedOaLlCTNSnNvd/T3LS8wWrf1wKtevO+D4O5vn7zw/zfi0
        qmj5eoZo6Ssae/O3OoS5XS7eXrzr+fNz6TdlfEJ5tuQd+J4r3xcsvkd4zZSe2wVuxYr7i9k5
        3x6zj3sWu1yf/c/OjBvhaw6bTJ2ss6d2SdpU7bcql+4ETJy85lTj+9kN0aZLPlwNnH7hgoKv
        7t5SbqHrs+r/B3KePH1shkNBXebRw/fN2fy1I2s92R1r3nz8mKf1VX5mc+CaS+9cP8k8dmRx
        7kk3WKduaa/hcuOZdgaHYJP1zH2XeqZELp98Yn7hT7m4mUosxRmJhlrMRcWJAIph7o4nAwAA
X-CMS-MailID: 20211209150028eucas1p219b6230e580770a6e93d828b467d3da3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211209150028eucas1p219b6230e580770a6e93d828b467d3da3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211209150028eucas1p219b6230e580770a6e93d828b467d3da3
References: <20211208183814.71b0c51e@canb.auug.org.au>
        <YbH3lT7fh+YCCwjx@sirena.org.uk>
        <CGME20211209150028eucas1p219b6230e580770a6e93d828b467d3da3@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 09.12.2021 13:33, Mark Brown wrote:
> On Wed, Dec 08, 2021 at 06:38:14PM +1100, Stephen Rothwell wrote:
>
>> News: I will (probably) do no linux-next releases between Dec 9 and Dec
>> 19, inclusive.
> I'll try to start provide some cover for this, probably starting
> tomorrow unless a build for today runs *very* well.

Well, next-20211208 is broken on ARM64 and probably some other 
architectures using common dma-mapping helpers, see 
https://lore.kernel.org/all/4e0eafe8-075d-c249-0298-d2612faa5704@samsung.com/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

