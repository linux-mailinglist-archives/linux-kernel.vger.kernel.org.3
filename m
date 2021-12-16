Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D09476A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhLPGlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:41:01 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:26402 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhLPGk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:40:59 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211216064057epoutp04d4e242518c83dbe8c55065754e259611~BKQj_PHpx0708007080epoutp04Q
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 06:40:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211216064057epoutp04d4e242518c83dbe8c55065754e259611~BKQj_PHpx0708007080epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639636857;
        bh=nAHGqscdFUMOEW0iIXOUAUSvjOgus9DqNRapTfxaXbk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rQ6cmJwGwKExg0bkJyWwl+JEKfKAFbtUr6486JJBcBOdi0pbJs6Bx7bfz/UdbBZN2
         5Mu5oIPwNaPGZP5GlkWTmZjlgd/3bZ3UixepftVeyyi1/Dpp4GAAnv0nEL1Zv2SZSi
         M6EUUbY+Qs7zBLdXZHTu9JseDmyirCE3LyV5n6SY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211216064057epcas1p4ecca1ba50bc92eed8ae8cfa9c78fcea0~BKQjfpPLL1716217162epcas1p4d;
        Thu, 16 Dec 2021 06:40:57 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.231]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JF2Yt64sCz4x9QG; Thu, 16 Dec
        2021 06:40:50 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.94.21932.D1FDAB16; Thu, 16 Dec 2021 15:39:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211216064041epcas1p160472ab8a4b8a64ca074db85844bb1c3~BKQVGDeCY2043620436epcas1p1s;
        Thu, 16 Dec 2021 06:40:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211216064041epsmtrp263fdc7108d08ee6489234973cce136ac~BKQVEATVL1529315293epsmtrp2y;
        Thu, 16 Dec 2021 06:40:41 +0000 (GMT)
X-AuditID: b6c32a38-93fff700000255ac-7a-61badf1db537
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.ED.29871.96FDAB16; Thu, 16 Dec 2021 15:40:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211216064041epsmtip236a8879ff754e1914b69e5ecb20dea91~BKQUw1W9Y3224732247epsmtip2b;
        Thu, 16 Dec 2021 06:40:41 +0000 (GMT)
Subject: Re: [PATCH 1/7] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c9e6210b-3eda-c05c-abfb-e4432cf3b83d@samsung.com>
Date:   Thu, 16 Dec 2021 16:03:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211215160906.17451-2-semen.protsenko@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH/d3bF4xu147Jjy4IXINxLGUtK+yHg4UpuLKhkhin0yC70JuC
        9GVv63BxjkURynhayLYKQekeplEZhTGoIhtDGcwMCErIBIqDBRmv8VqIq2jbO5X/Puf8vuec
        3/f87hXgors8sSBHa6QNWkpN8vw5LTd2SCQhLiclrarfiwY7dqK2y9V8VNd1m4ta87u4qHFu
        DUNV7ksYckwMcdFiyRgXDTpreOhs3w8YGuhNRgXtXXx0Y7aQi9aHGjloqsyTtzvdAHUvTABk
        u7bETxQp1pocuGJhuICvsOaX8hRt1lG+wmE38xQjQ9/zFE3nTyrKmu1Asex4Os3vrdz4bJpS
        0oYwWpulU+ZoVQnkodcyXsyIiZXKJLI4tIcM01IaOoFMSk2TvJSj9tghw96n1CZPKo1iGHLX
        vniDzmSkw7J1jDGBpPVKtT5GH8VQGsakVUVpaePzMqk0OsYjPJqbfbmnnK+f35y30lTGyQdl
        AcXATwAJOey1uPBi4C8QEa0AOpxfYWywBOCthW4uGzwEsKdkyXMi8JX0LVJsvh3Ajtom3NtK
        RCwAWFv9kZe3EplwpqHO1zaQcALY3vmZL8CJUg60XJnnelU8IhJ2/DHM8/IWIhz+ujYBvCwk
        9sFOV52vK4eIgG3lN328jTgMe1o+eax5Evacm+R42Y9IhH9fWOd7GSeC4J3JOozlUHh1rsY3
        GBKFfnC6+B7Guk6CDyrNHJa3wvvdzXyWxXB5vp3HFlwE8E+LGWODBgCnrWacVe2GHRcsvmXg
        xA7Y4NzFpsNh26NawE7eDOdXS7jsvoSw6FMRK3kGDo6PPr5DMLQVmnkVgLRu8GPd4MG6wYP1
        /2FfAI4dPEXrGY2KZmR6+X/vnaXTOIDvY49EraB27kFUJ8AEoBNAAU4GCiffdFIioZL64Dht
        0GUYTGqa6QQxng1X4uJtWTrP36I1ZsjkcVJ5bPRuOZLFysgg4dSrZygRoaKMdC5N62nDv3WY
        wE+cjwkj2sK3tygnUkYEoV3X76uIOCCe1l4cM2yxr+w9lvLctwdPDleTyDryLLym5k7V1PbN
        uW//XsKvfjkx4Mh7g0clpwLumPVJr8w88bbkVPmmm7KHX28K+tjUbFstCj+xemZMzLiKks9T
        4R/a3ojrTy3+8bT8p/0RV4H7mFvjP5psvlLKTz+neCf/F2W9qyov95svZ2eq3h0Q9t8Kqaig
        j6SsnT2oChwPkVhmD4vg1PX6zzUH9h8XB3f3x0evD4CfkzOVXenCF9Ljgr+TyjLn91xqPHTi
        0WJAqMncEGhy9y1X5TWvvF5xWjsELTOVd90HuncW/Nb7F+Yat90jZyQ9qfXbm0kOk03JInED
        Q/0D9sYm9HUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSvG7m/V2JBhdXallc3q9tsXPDVHaL
        +UfOsVrsaDjCarHx7Q8miyl/ljNZbHp8jdXiY889VovLu+awWcw4v4/J4uIpV4vWvUfYLQ6/
        aWe1+HdtI4vF8z6g+Kpdfxgtjr9/zGix+MAndgchjx+bNzF7vL/Ryu4xq6GXzWPnrLvsHptW
        dbJ53Lm2h81j85J6j74tqxg9Pm+SC+CM4rJJSc3JLEst0rdL4MrYcLKfveAdX8WXzX0sDYx9
        PF2MHBwSAiYS5z8mdjFycQgJ7GaUmLHkIUsXIydQXFJi2sWjzBA1whKHDxdD1LxllFi75S4j
        SI2wQJLE6/XzmUESIgK7GCVOv/vPDuIwC/SzSBxd/48VouUko8TvxiXsIC1sAloS+1/cYAOx
        +QUUJa7+eAw2ilfATuLQfZBRnBwsAqoSO/tPgNmiAmESO5c8ZoKoEZQ4OfMJ2HmcAg4S/5f+
        A5vJLKAu8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJyb
        nltsWGCYl1quV5yYW1yal66XnJ+7iREc4VqaOxi3r/qgd4iRiYPxEKMEB7OSCO+TiF2JQrwp
        iZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTBtyZ5/S9jyq3P+
        uVN+TwI9T6Z28JQtS1INzRSam/HUQCZ1Q7RtyVftWVnaBhz8J5pS1fK+Tnp51WqLmfSBxUzO
        L7vivWb476hjDJ/vk6DwlKX/vs7+Is7PBZMbw6dbrWaY/VNzUXr7L0OGHqGCP1Z5F/qPnJC/
        /2C9j3ryldvl2xgXXdELZPs5NVZYxfHoN1sLnrrfc7bxrpBkYi44zykjfe37/esb78ZfvX/2
        qPIXSde/HdNqXlyTabneEbDfVN27/XC/vlakv1jPL+4pZuvXVdklVF8+zd7WVjGDz3PavgqR
        nOT5N2/aHRXZULFwiXqxXcKyy0pFH9XsZZxXuCU4frdQ7f3Wyr5318eUp0osxRmJhlrMRcWJ
        AB7DPkpfAwAA
X-CMS-MailID: 20211216064041epcas1p160472ab8a4b8a64ca074db85844bb1c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211215160912epcas1p25e6c9a95aee33d6de8c73c892e524220
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
        <CGME20211215160912epcas1p25e6c9a95aee33d6de8c73c892e524220@epcas1p2.samsung.com>
        <20211215160906.17451-2-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 1:09 AM, Sam Protsenko wrote:
> System Register is used to configure system behavior, like USI protocol,
> etc. SYSREG clocks should be provided to corresponding syscon nodes, to
> make it possible to modify SYSREG registers.
> 
> While at it, add also missing PMU and GPIO clocks, which looks necessary
> and might be needed for corresponding Exynos850 features soon.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/dt-bindings/clock/exynos850.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
> index 8aa5e82af0d3..0b6a3c6a7c90 100644
> --- a/include/dt-bindings/clock/exynos850.h
> +++ b/include/dt-bindings/clock/exynos850.h
> @@ -82,7 +82,10 @@
>  #define CLK_GOUT_I3C_PCLK		19
>  #define CLK_GOUT_I3C_SCLK		20
>  #define CLK_GOUT_SPEEDY_PCLK		21
> -#define APM_NR_CLK			22
> +#define CLK_GOUT_GPIO_ALIVE_PCLK	22
> +#define CLK_GOUT_PMU_ALIVE_PCLK		23
> +#define CLK_GOUT_SYSREG_APM_PCLK	24
> +#define APM_NR_CLK			25
>  
>  /* CMU_CMGP */
>  #define CLK_RCO_CMGP			1
> @@ -99,7 +102,8 @@
>  #define CLK_GOUT_CMGP_USI0_PCLK		12
>  #define CLK_GOUT_CMGP_USI1_IPCLK	13
>  #define CLK_GOUT_CMGP_USI1_PCLK		14
> -#define CMGP_NR_CLK			15
> +#define CLK_GOUT_SYSREG_CMGP_PCLK	15
> +#define CMGP_NR_CLK			16
>  
>  /* CMU_HSI */
>  #define CLK_MOUT_HSI_BUS_USER		1
> @@ -167,7 +171,9 @@
>  #define CLK_GOUT_MMC_EMBD_SDCLKIN	10
>  #define CLK_GOUT_SSS_ACLK		11
>  #define CLK_GOUT_SSS_PCLK		12
> -#define CORE_NR_CLK			13
> +#define CLK_GOUT_GPIO_CORE_PCLK		13
> +#define CLK_GOUT_SYSREG_CORE_PCLK	14
> +#define CORE_NR_CLK			15
>  
>  /* CMU_DPU */
>  #define CLK_MOUT_DPU_USER		1
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
