Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1DD48950E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242762AbiAJJTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:19:31 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48053 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242684AbiAJJTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:19:23 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220110091922euoutp02e6fa4389dd2072df031cfe67cbb46d0d~I3jAGQ-UL0735707357euoutp02M
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:19:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220110091922euoutp02e6fa4389dd2072df031cfe67cbb46d0d~I3jAGQ-UL0735707357euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1641806362;
        bh=1Ob0MRqTdUDGQqyYorTO93GQ8lKlBOr85GNX1fAHRsE=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=ULrlRbpm6rY0SoDI/SOIGJmHZaGelCUzxMNT1smjxgVit+pVq5eCxx0DvDEy48crk
         VCT3QzUo/8NIAxgM3U2oPlh83k+I+kEqzS+Cz/TUBLNZXp821EtI5YYGp3RxV0t5FX
         2R90n+Y4KzniPN6AjMJZpSyymMcCuBoy9kuVERoc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220110091921eucas1p21f6cfe1ac7f6475b0cd39498ae57c256~I3i-vj74u0102001020eucas1p2b;
        Mon, 10 Jan 2022 09:19:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 10.E0.10009.91AFBD16; Mon, 10
        Jan 2022 09:19:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220110091921eucas1p1293fe6fae3b97a84f47ea9f1445aea65~I3i-Mt_8i1661216612eucas1p1a;
        Mon, 10 Jan 2022 09:19:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220110091921eusmtrp1ad09ff82720783e699b59427411a7e3b~I3i-MDBfw2557325573eusmtrp1a;
        Mon, 10 Jan 2022 09:19:21 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-a9-61dbfa198d58
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4D.1E.09404.81AFBD16; Mon, 10
        Jan 2022 09:19:20 +0000 (GMT)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220110091918eusmtip10480c563e643f65c6962751203d4ae55~I3i88Pd4v1874918749eusmtip1U;
        Mon, 10 Jan 2022 09:19:18 +0000 (GMT)
Message-ID: <66c64f86-abd3-76c1-661a-d9b1ab3a1aeb@samsung.com>
Date:   Mon, 10 Jan 2022 10:19:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] MAINTAINERS: add reviewer entry for Samsung/Exynos
 platform
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20220105164341.27479-1-alim.akhtar@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduznOV3JX7cTDT59kbN4MG8bm8XGtz+Y
        LC7vmsNmMeP8PiYHFo9ZDb1sHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJXxdMIutoKFPBV3
        n2xga2BcxdXFyMkhIWAisaRrN3sXIxeHkMAKRokfZ8+zQjhfGCWWvLzOBFIlJPCZUWLHLUmY
        jme3ZkB1LGeU2DR1A5TzkVHi47pOFpAqXgE7ie0v3rGC2CwCqhKX799hhIgLSpyc+QSsRlQg
        SeLhg19gtrBAkMTxy43sIDazgLjErSfzwTaLCLhLfO6byQwR95B4/WsNmM0mYCjRe7QPbCan
        gK3EtOUvoWrkJba/ncMMcpCEwB4OiesfZrBDnO0iMWXGEVYIW1ji1fEtUHEZidOTe1ggGpoZ
        JXp232aHcCYwStw/voARospa4s65X2xdjBxAKzQl1u/SBzElBBwlZk3OhDD5JG68FYS4gU9i
        0rbpzBBhXomONiGIGSoSv1dNZ4KwpSS6n/xnmcCoNAspVGYh+X4Wkm9mIaxdwMiyilE8tbQ4
        Nz212DAvtVyvODG3uDQvXS85P3cTIzChnP53/NMOxrmvPuodYmTiYDzEKMHBrCTCu/fCrUQh
        3pTEyqrUovz4otKc1OJDjNIcLErivMmZGxKFBNITS1KzU1MLUotgskwcnFINTPoRq0u9pq3T
        lSu96L+nrFRTuetV+fd1n6P5ZXfxOv0QLH/4KFv45lWujP1dM38+ruBc6sW+QzPF9lKm9MW5
        3yocWyQu3wjyu7jkyDx+v7niVSUPTgdpRLVZmj35c7U7ZX7JHKUIsTMzIl0OVxq1bunf7qsl
        ueSUhWJ5E9uV9GUWXb3//pdJait3ztYqVDNY63slU9Oj6nDhgq5XjMVbTqcJf7zT8nOiauvF
        lTJ3ur5Mvbvmj86dVbf8/3lP6jc8+uVTbhPrj3fc18I5vzyYYPd08WrXKUub9X711y3TmbMv
        s0SL7bPERIFihoxZMdJGL665GWTzSFdvfRTpM7H7RfSetqcdtst85M5XL8ksVWIpzkg01GIu
        Kk4EAKZxVV6XAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xu7oSv24nGmy+YGHxYN42NouNb38w
        WVzeNYfNYsb5fUwOLB6zGnrZPPq2rGL0+LxJLoA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
        yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j6YRdbAULeSruPtnA1sC4iquLkZNDQsBE4tmt
        GexdjFwcQgJLGSXmfeln7mLkAEpIScxvUYKoEZb4c62LDaLmPaPEshNtjCAJXgE7ie0v3rGC
        2CwCqhKX79+BigtKnJz5hAVkjqhAksSHLX4gYWGBIInjlxvZQWxmAXGJW0/mM4HYIgLuEp/7
        ZjJDxD0kXv9aA2YLCUxglLi4oQLEZhMwlOg92gc2nlPAVmLa8pdgZzILqEusnycE0Sovsf3t
        HOYJjEKzkBwxC8m2WQgds5B0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iREYO9uO/dyy
        g3Hlq496hxiZOBgPMUpwMCuJ8O69cCtRiDclsbIqtSg/vqg0J7X4EKMpMCAmMkuJJucDozev
        JN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoHJaL1ksW5Chug3T1a5
        VwnOp/mkjvblrlg83XnjBxvppjdfFnpPetdhvXzDP437DUfLNj1d4z95/d21e17+eNDM/Vuv
        +oLa1Nl3/kh+bzJk/GGiHaEk8mrJ8m/3xOyMYxanLj7e4zCf7aqMjdP1nUX8/3dnfqz2TpK8
        HctvaT9vi/uWF97iWSs72OaYHDPy412/YXdcG6dAUv0H3zWW+m+3q/2t9d9bryZgWPjt0ZU9
        +ey73yYmhr7uW61hPm/hhdfzbk/1sr3g51ki6DRz8ZR39T/PzC30MGaRn/XZabtp4MIzh/dy
        6Wwue50hcHfhpt4vrI8OVQadTni29LH5sePnrra9kt/b17JY/Q/j+n/GgUosxRmJhlrMRcWJ
        AFJ8FJsmAwAA
X-CMS-MailID: 20220110091921eucas1p1293fe6fae3b97a84f47ea9f1445aea65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220105165351epcas5p100b28a19d5a5e5614ea82adf5e0037b0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220105165351epcas5p100b28a19d5a5e5614ea82adf5e0037b0
References: <CGME20220105165351epcas5p100b28a19d5a5e5614ea82adf5e0037b0@epcas5p1.samsung.com>
        <20220105164341.27479-1-alim.akhtar@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.2022 17:43, Alim Akhtar wrote:
> Adds myself as reviewer for Samsung/Exynos platform to help
> in review of current and upcoming SoCs patches.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 13f9a84a617e..ddc8e8552e8b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2544,6 +2544,7 @@ N:	rockchip
>  
>  ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES
>  M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +R:	Alim Akhtar <alim.akhtar@samsung.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	linux-samsung-soc@vger.kernel.org
>  S:	Maintained
> @@ -15110,6 +15111,7 @@ PIN CONTROLLER - SAMSUNG
>  M:	Tomasz Figa <tomasz.figa@gmail.com>
>  M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>  M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
> +R:	Alim Akhtar <alim.akhtar@samsung.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	linux-samsung-soc@vger.kernel.org
>  S:	Maintained
> @@ -16868,6 +16870,7 @@ SAMSUNG SOC CLOCK DRIVERS
>  M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
>  M:	Tomasz Figa <tomasz.figa@gmail.com>
>  M:	Chanwoo Choi <cw00.choi@samsung.com>
> +R:	Alim Akhtar <alim.akhtar@samsung.com>
>  L:	linux-samsung-soc@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk.git
