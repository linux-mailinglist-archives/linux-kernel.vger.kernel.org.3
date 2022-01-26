Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C85449C5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbiAZJMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:12:30 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33526 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiAZJM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:12:26 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220126091225euoutp0113cef776c4c1fdfa62f2ff83db5a638b~NxxglF2vz2541025410euoutp01Z
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:12:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220126091225euoutp0113cef776c4c1fdfa62f2ff83db5a638b~NxxglF2vz2541025410euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643188345;
        bh=Wmd2XaxZDFx9UHAR7WkdclOzKCtHXnNC3BWOhn9SYWM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=G8iT98GdIzed/knvfJVHi/CbfVqXI6iUYskRgYFoGSY07oRkAX2fCxNxXDewfqTsk
         aKaZzrWHIMx+omb2gazRcnFjrQM825DTLlNcgT5BxGj8vdTGJjP9WISWQlYXbAQ/ok
         JlzNel3w0GeoG0OAW36PsrAUiA4umMJjpnE7Gxiw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220126091224eucas1p1f54c65ef5acc88279a5ab0c0db0bf6aa~NxxfR374Y1185511855eucas1p1m;
        Wed, 26 Jan 2022 09:12:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 07.54.09887.77011F16; Wed, 26
        Jan 2022 09:12:23 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220126091223eucas1p105b697bd2ba22ac4deb8f968a3a3c578~NxxemCOU71184311843eucas1p1i;
        Wed, 26 Jan 2022 09:12:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220126091223eusmtrp1c78bf7de704473a67be01c2d432a165d~NxxelBsk31208612086eusmtrp13;
        Wed, 26 Jan 2022 09:12:23 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-f8-61f11077139f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F3.A1.09404.77011F16; Wed, 26
        Jan 2022 09:12:23 +0000 (GMT)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220126091222eusmtip1098e70b6796fe0ca794b3ddf19cf54bf~Nxxdg4rVL1949319493eusmtip16;
        Wed, 26 Jan 2022 09:12:22 +0000 (GMT)
Message-ID: <0724f0f6-d72a-0e63-2791-d038b701b8f2@samsung.com>
Date:   Wed, 26 Jan 2022 10:12:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v5 02/16] dt-bindings: clock: Add bindings definitions
 for FSD CMU blocks
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        sboyd@kernel.org, linux-fsd@tesla.com
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20220124141644.71052-3-alim.akhtar@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djPc7rlAh8TDb79Nrd4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLf5d28hi8fj6HzYHAY8189Ywevz+NYnRY1ZDL5vHplWdbB53ru1h89i8pN7j
        yokmVo++LasYPf41zWX3+LxJLoArissmJTUnsyy1SN8ugStj6+WNrAV/WCpWT7vI3sA4m6WL
        kYNDQsBE4uJUqy5GLg4hgRWMEnN2T2GEcL4wSpze2MQC4XxmlHj9dRpzFyMnWMfWKRNZQWwh
        geWMEl83eULYHxklPn9LA7F5BewkDsy+AVbPIqAqcW39NVaIuKDEyZlPwDaLCiRJ9LQ4g4SF
        BeIlevftBithFhCXuPVkPhOILSKQL/Hz306wG5gF9jFJbL1wDCzBJmAo0Xu0jxHE5hSwlTi+
        +iIzRLO8xPa3c5hBGiQETnFKPD1wlgXiaBeJjVsvsUHYwhKvjm9hh7BlJE5P7mGBaGhmlOjZ
        fZsdwpnAKHH/+AJGiCpriTvnfrGBnM0soCmxfpc+RNhRYtuqKWyQcOSTuPFWEOIIPolJ26Yz
        Q4R5JTrahCCqVSR+r5rOBGFLSXQ/+c8ygVFpFlKwzELy/ywk78xC2LuAkWUVo3hqaXFuemqx
        UV5quV5xYm5xaV66XnJ+7iZGYCI8/e/4lx2My1991DvEyMTBeIhRgoNZSYT3v/f7RCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8yZkbEoUE0hNLUrNTUwtSi2CyTBycUg1ME/uE3nS/b5Geprg9
        O/xtSuia3HrPJcFHvp32FHt24mBhLdMRgZpco41m9W91FBYeX7/rohvj3tMMvhahCbx9L9cw
        e9+Qkt+zK2Svsm31xautkf+WX/aUMDTUcjwadsCptV6z/mHFCYFJKetC8o/6cYTNY7Ga8reh
        VPKnyxEhbxO15tkNpsJhHj1KL7beSnxne/+94vxfT26zHJgZmcBRFZEZ0BZnnZ8Xe6rd/Gp6
        B9u59Zl9SRvOCmX8yLy+T/iya//iA2cfrljQL9bGMfnZ02K+SNa9lfcuy5eeaFA/MO3nto6T
        b04KnuVfqz/n9+WECimPzt/Pz1YwaxQUbPilwGz+Jp75s95EtRVn+FOVWIozEg21mIuKEwEb
        EipB8wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xu7rlAh8TDX6c5bV4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLf5d28hi8fj6HzYHAY8189Ywevz+NYnRY1ZDL5vHplWdbB53ru1h89i8pN7j
        yokmVo++LasYPf41zWX3+LxJLoArSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbK
        yFRJ384mJTUnsyy1SN8uQS9j6+WNrAV/WCpWT7vI3sA4m6WLkZNDQsBEYuuUiaxdjFwcQgJL
        GSX+btoMlOAASkhJzG9RgqgRlvhzrYsNouY9o0T31BOMIAleATuJA7NvMIPYLAKqEtfWX2OF
        iAtKnJz5BGyBqECSRMOxbjYQW1ggXuLw+oVg9cwC4hK3nsxnArFFBPIl/vR/BDuCWWAfk8T+
        p5fYQRJCAocZJY5PUwOx2QQMJXqP9oEt5hSwlTi++iIzyKHMAuoS6+cJQcyUl9j+dg7zBEah
        WUjOmIVk3SyEjllIOhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjPxtx35u2cG48tVH
        vUOMTByMhxglOJiVRHj/e79PFOJNSaysSi3Kjy8qzUktPsRoCgyKicxSosn5wNSTVxJvaGZg
        amhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXA1HRCmTnCSyNm8dzr2VZCU3ua
        rBPseeVn8Bsbvp1+45zh5TeXHK8GWnGdvLgum+uX/2XvJAEfMZmdG9M4Y4TmKN/Q/BYv2FF8
        ceVyac7VzKmTT84T2jb93DXxletDnezPuVQ9vfzdYPWkpy5Ofitq15yedC2PJ9XS4GbAlHht
        JofDB4IlZvk4N0lOXqmVZm9c479o8pQ3ElL8P+ICTxV6XV0bwSvffd4iddn8fb2N8yycFhTN
        92t5d/Hv0nvcqonPJP7e3fLpkFYu/67tGrcYGgK2zT51q47j+BdPpr3mAZv2q1qcumLtPLOn
        QOvqCfnDtirbXleF8u79V5z3syp63mLXy44ef7xEr79nNZ9ZosRSnJFoqMVcVJwIADKrcDCF
        AwAA
X-CMS-MailID: 20220126091223eucas1p105b697bd2ba22ac4deb8f968a3a3c578
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220124142901epcas5p3776232af7911abfbf08d82358350f57c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220124142901epcas5p3776232af7911abfbf08d82358350f57c
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142901epcas5p3776232af7911abfbf08d82358350f57c@epcas5p3.samsung.com>
        <20220124141644.71052-3-alim.akhtar@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.2022 15:16, Alim Akhtar wrote:
> Clock controller driver of FSD platform is designed to have separate
> instances for each particular CMU. So clock IDs in this bindings header
> also start from 1 for each CMU block.
> 
> Cc: linux-fsd@tesla.com
> Reported-by: kernel test robot <lkp@intel.com>
> [robot: reported missing #endif]
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

