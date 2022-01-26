Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F41B49C5F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbiAZJNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:13:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34416 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiAZJNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:13:14 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220126091313euoutp019d8de05bc2a3a78af1d810d1fdf0ab4d~NxyM1XGxN2358523585euoutp01c
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:13:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220126091313euoutp019d8de05bc2a3a78af1d810d1fdf0ab4d~NxyM1XGxN2358523585euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643188393;
        bh=N6EjNpd4RS6otX4ZoriNjspVYcOA9fzQSMu12oRThKU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=nv5wq2ZRJRxPwK6ZENFoTx4g/YhP/rVSQqdUVMGM81f3xOsjllNcHZ7tXE/l1JFz9
         SnDBpLE6bThyd6I4qMHd6fB9TLz4FjpYhZ6QWqVmOWmkwuuI9l627Fpn5r1HpDVLwL
         dWNObpaHIj8x3B2cNJ4sD3A2feGGwbIyIVbbbuj0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220126091312eucas1p15e35bb5d6abfd636b99cc68b1109823b~NxyMThcZM1184711847eucas1p1b;
        Wed, 26 Jan 2022 09:13:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 28.CC.10260.8A011F16; Wed, 26
        Jan 2022 09:13:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220126091311eucas1p230005f8755b49f0bdd49fae823e7940d~NxyLxh1962838328383eucas1p27;
        Wed, 26 Jan 2022 09:13:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220126091311eusmtrp294c00826d20a2ed8b68a3314816d21ce~NxyLwh9Wu2904829048eusmtrp2Y;
        Wed, 26 Jan 2022 09:13:11 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-1d-61f110a8d0ea
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AE.C1.09404.7A011F16; Wed, 26
        Jan 2022 09:13:11 +0000 (GMT)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220126091310eusmtip246bdf4a8a04880344e958fabe39d74df~NxyKxj_GW2005120051eusmtip2i;
        Wed, 26 Jan 2022 09:13:10 +0000 (GMT)
Message-ID: <a611a070-4932-1691-1f20-7cfa8bb96cc1@samsung.com>
Date:   Wed, 26 Jan 2022 10:13:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v5 03/16] dt-bindings: clock: Document FSD CMU bindings
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
In-Reply-To: <20220124141644.71052-4-alim.akhtar@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djP87orBD4mGuz6LWjxYN42Nou/k46x
        W7xf1sNoMf/IOVaLjW9/MFlM+bOcyWLT42usFh977rFaPHwVbnF51xw2ixnn9zFZnLr+mc1i
        0dYv7Bate4+wW/y7tpHF4vH1P2wOAh5r5q1h9Pj9axKjx6yGXjaPTas62TzuXNvD5rF5Sb3H
        lRNNrB59W1Yxevxrmsvu8XmTXABXFJdNSmpOZllqkb5dAlfGiRf72Qo+MlXc3viYvYFxP1MX
        IweHhICJxOF7nl2MXBxCAisYJfad62aDcL4wSjztecIE4XxmlFj2bhZjFyMnWMfWw12sEInl
        jBKLLlxmgXA+MkocvryOBaSKV8BO4tbifnYQm0VAVeLft1vMEHFBiZMzn7CA7BYVSJLoaXEG
        CQsLeEvs/9jOBGIzC4hL3HoyH8wWEciX+PlvJ9h8ZoF9TBJbLxwDS7AJGEr0Hu0Du4hTwFZi
        6s9tbBDN8hLb385hBmmQEDjMKbHi8kRmiEddJNY+roP4QFji1fEt7BC2jMT/nfOZIOqbGSV6
        dt9mh3AmMErcP74A6mdriTvnfrGBDGIW0JRYv0sfIuwo8aHhGwvEfD6JG28FIW7gk5i0bTrU
        Wl6JjjYhiGoVid+rpjNB2FIS3U/+s0xgVJqFFCqzkLw/C8k3sxD2LmBkWcUonlpanJueWmyc
        l1quV5yYW1yal66XnJ+7iRGYCk//O/51B+OKVx/1DjEycTAeYpTgYFYS4f3v/T5RiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA5Ouqb3ugbvHpiTVJbly
        cVyvEHrNcON7/e64s2dYxSqSD/AZtE1aynlI82Y+dx5XjEi+8dV1Vgt/eJpuuh4oXKJvOG/h
        G0Gt9Z8WxzKUabDcWauXpCnVrmlllOhwjPWh6sx9ma+kjoWtuf9UOGsaY+txSRGRZ2XhLbMP
        Mv+ca9pwSYX5cEOrUtp0fkm9bfLtJf1sMUdKjUOaz51NWCtW0qvMvexAEeu9sHm/P333UcoO
        VTe5x3VD/OT1CJUss5lJj/9vXdd33lp3+T6xnO4IvnN3r4Vc/X4xVzm96Xj+QT1bqSDbavHO
        lexRqnPDnhlMOz09Iv28vPcHnRPtD6vj3O4d4uURqZK6rKG0qmeeEktxRqKhFnNRcSIAYPn1
        0PQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xe7rLBT4mGvz4pWXxYN42Nou/k46x
        W7xf1sNoMf/IOVaLjW9/MFlM+bOcyWLT42usFh977rFaPHwVbnF51xw2ixnn9zFZnLr+mc1i
        0dYv7Bate4+wW/y7tpHF4vH1P2wOAh5r5q1h9Pj9axKjx6yGXjaPTas62TzuXNvD5rF5Sb3H
        lRNNrB59W1Yxevxrmsvu8XmTXABXlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayV
        kamSvp1NSmpOZllqkb5dgl7GiRf72Qo+MlXc3viYvYFxP1MXIyeHhICJxNbDXaxdjFwcQgJL
        GSVWHjzC1sXIAZSQkpjfogRRIyzx51oXG0TNe0aJN/Nus4AkeAXsJG4t7mcHsVkEVCX+fbvF
        DBEXlDg58wlYjahAkkTDsW42EFtYwFti/8d2sMXMAuISt57MB7NFBPIl/vR/BDuCWWAfk8T+
        p5fAhgoJHGaUeDsRzGYTMJToPdrHCGJzCthKTP25DexQZgF1ifXzhCBmyktsfzuHeQKj0Cwk
        Z8xCsm4WQscsJB0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEb+tmM/t+xgXPnqo94h
        RiYOxkOMEhzMSiK8/73fJwrxpiRWVqUW5ccXleakFh9iNAUGxURmKdHkfGDqySuJNzQzMDU0
        MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYNo8WaGCsyo5guuO/M3puwNV406w
        rUxV9DHw5uzc9zpK4NZ8sz/iHAI+8sbcU659l3/i8qyWi4V937LpUZ2WyvLfoq8tF9p38dHf
        jjsW77ec/Ltg488a4TTjCOPfPB6vBVffLHWxLmFWmP8wPd27ernXE99q69sc6w+XO8z6b/eW
        Le3SB53SmGUmHe3XvxS/+2p7NdTk2juD1UdVY9ccaTseMP+y2UFBldpHVWs/ZP/bsFzLQIyp
        1i+27rtJaHJ0y1/3mBMm35enfrbxbVSf+nN+mEPdmZllMw6sENqXJySwIKB+2aRg91qH+kQR
        gw4d/QVa52cIer0tMXRRLSth/jnRi+lAhlqj9X4RptapSizFGYmGWsxFxYkA3HQ9WoUDAAA=
X-CMS-MailID: 20220126091311eucas1p230005f8755b49f0bdd49fae823e7940d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220124142905epcas5p33a863799819fb904932d2e88c682940a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220124142905epcas5p33a863799819fb904932d2e88c682940a
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142905epcas5p33a863799819fb904932d2e88c682940a@epcas5p3.samsung.com>
        <20220124141644.71052-4-alim.akhtar@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.2022 15:16, Alim Akhtar wrote:
> Add dt-schema documentation for Tesla FSD SoC clock controller.
> 
> Cc: linux-fsd@tesla.com
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
