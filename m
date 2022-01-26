Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1F349C615
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiAZJR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:17:57 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38286 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbiAZJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:17:45 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220126091743euoutp01357dc8ac415a2562f039ee1dddde700b~Nx2JDITCu2971729717euoutp018
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:17:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220126091743euoutp01357dc8ac415a2562f039ee1dddde700b~Nx2JDITCu2971729717euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643188663;
        bh=OhSSZedRS/PFitH6RxXTb4C1krdWofpouvgxQhhkHQg=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=sRGUEav6D2aU5FkyDnvvUP+diP8A5acd4QVWvw1v6dwpAx7F9NbgoAqq77JRyvpTo
         mKVlPkAcnkhiPHfdyU1zw0i5YE2hVW3qtP8SzVsYefAqYAa9yoI60jgS7JFgkga9dL
         jiKnyyfqRlO1ayRGsyyJVl638ciIJAplk5u5cl40=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220126091742eucas1p1e745221a4e533aebae71c92132e2e139~Nx2HsENy10418604186eucas1p1Q;
        Wed, 26 Jan 2022 09:17:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 11.3F.10009.6B111F16; Wed, 26
        Jan 2022 09:17:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220126091741eucas1p2d10b5b053b2f21e388a7237bd1483822~Nx2HMww9c2603426034eucas1p2a;
        Wed, 26 Jan 2022 09:17:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220126091741eusmtrp26c91ae99d4fbdb0a48719f78d05e3976~Nx2HLycKB3158531585eusmtrp27;
        Wed, 26 Jan 2022 09:17:41 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-01-61f111b6fa98
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.63.09522.5B111F16; Wed, 26
        Jan 2022 09:17:41 +0000 (GMT)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220126091740eusmtip13bc4a1784eec8e2e9c83a84cf64e6bc7~Nx2GIMA6V2412824128eusmtip1c;
        Wed, 26 Jan 2022 09:17:40 +0000 (GMT)
Message-ID: <00f99dbb-c425-c838-f1ec-ff2e98f42eef@samsung.com>
Date:   Wed, 26 Jan 2022 10:17:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v5 08/16] clk: samsung: fsd: Add cmu_imem block clock
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
        Arjun K V <arjun.kv@samsung.com>,
        Tauseef Nomani <tauseef.n@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20220124141644.71052-9-alim.akhtar@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxjm3K/ellUvlYWTbhNT9Ica0ca5nYgiTgxXje7DqJlZtl3kSglQ
        SAs45hYRnYPykaagaIOUMCdacZPalVGFbAwEkQ9l2JLBHLbMHwV0FdRVCt3ayzL+Pe/zPs95
        3/fJoXHZOCmn09Q5vEbNZSgoCWG75etfY4vwcuvMXikarbFRqP6ynUCzhlsi9ORiKUCm9j4S
        NU7+jaFKfz2GLG4HibylD0j00HMA/WqvptDZ/lYMdTunKFT3w7QIfdXSLkJzjkYCuZ1+Cg3c
        riASZGxDTQNgZ14aAGssKKNYi7mYYkccNyn2+oVj7GBXIcmWW82AnSs8L2KnLEvfkxyUbErh
        M9LyeM3a+E8lqumxWiLbSnxW9mxjAXDhOkDTkHkTHp+N1AEJLWMuAdgwUogJxTSAp3qmgVBM
        Aeirv0fqgDjkCMy2zjfqAdR9MzFv8QLotJwIqaRMPDx5x0kEMcGsgOVdVzCBj4C3z40Rwdmv
        Msmw9OS2IL2EOQCvPvaHrDgTBX8bM4XkkUwW9M01E8H3cUaHw96uupCIYpSwrKMcBLGY2Qxt
        pztwwRwNmyar8aABMg4xfOC2iYS1E+FDcycu4CXQ02md51+HgWYTJhhOAFh6Y1gkFHoA/+is
        BYIqDo70vaSCa+PMSvi9fa1Ab4Vn7lcDIclFcGgyQlhiETTYquYDlsKiUzJBvRzOmKswActh
        yViA0AOFcUEsxgX3GxecY/x/bi0gzCCKz9VmpvJapZo/EqvlMrW56tTYQ1mZFvDvf7wz1/n0
        R3De441tAxgN2gCkcUWkNLDrCSeTpnD5n/OarE80uRm8tg28RhOKKOmhtGucjEnlcvh0ns/m
        Nf91MVosL8DOLSuKGRpYs2EGKFQ3KrpMYarkF38mLB7eecUQbf+gyL9jlbpl1KWXKNXDyanX
        p0wx2Jerdx68y1Q8y/9l9p1307Y8yrU+pmZ8cdtt2z66aq/sdZZsVclJpqr/2rrndzc+LWnc
        8ch1rFXxPO9+zdKhvKaUPT275R2Db5fvDT+crutpaQ+zhGX27+0biP944uhhH6f/63e3Mql7
        fNngC73n/U29E+FtrxRXVlRH5nTvWyFNyHnrQt23SWfeSGy2BlzZQwaxtaXYP0p/KCZvNg6k
        70tyx7VvH+e+K2o4ng5dLu/y1evzmzxo/U/kFz+HR+N10q8dR3a79nMXE8UB15ZBKxujILQq
        TrkK12i5fwCAB5Ff/gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xu7pbBT8mGuzt07Z4MG8bm8XylbtY
        LP5OOsZu8X5ZD6PF/CPnWC02vv3BZDHlz3Imi02Pr7FafOy5x2rx8FW4xeVdc9gsZpzfx2Rx
        6vpnNotFW7+wW7TuPcJu8e/aRhaLx9f/sFlcOjmZxUHIY828NYwev39NYvSY1dDL5rFpVSeb
        x51re9g8Ni+p97hyoonVo2/LKkaPf01z2T0+b5IL4IrSsynKLy1JVcjILy6xVYo2tDDSM7S0
        0DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/jyZAFLwRaWit6vVg2Mj5i7GDk5JARMJP7/
        3cfYxcjFISSwlFHi4v3XbF2MHEAJKYn5LUoQNcISf651sUHUvGeUuLV7HxNIglfATqLl9HUW
        EJtFQFWi78RqqLigxMmZT8DiogJJEg3HutlAbGGBcIm17/6wgtjMAuISt57MB6sXEciX+NP/
        kRVkAbNAF7PE2ss9UNsOM0q8aNkG1sEmYCjRe7SPEcTmFLCV2Db1KDPIpcwC6hLr5wlBDJWX
        2P52DvMERqFZSO6YhWTfLISOWUg6FjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAhMBtuO
        /dy8g3Heq496hxiZOBgPMUpwMCuJ8P73fp8oxJuSWFmVWpQfX1Sak1p8iNEUGBYTmaVEk/OB
        6SivJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoFp2SMmpsoMRmV5
        Xve3YoWnBda+fsSg07pp9n7rWdPiqmsd7qy/eCM/XfvwWfvDDwsd1M2nSu6z2WSfZq/55F9R
        Hlu05bktd7azWd0N5GR6uJNv7uUAQ526W+8fbDjOfS3C5P6GSb9Ea14G3OX8vCK567Bog7qR
        y9R//cvmm26U3VB38disNQ6lgjfD999rqxBeMu+UR4KV8ceUwk9edXWJ1b2Z5dGrPxbe3h72
        e9dMhXOfPr7Pnvg33dlY8F6SjXnpRyu2//dET3Oefck0f5VlU0Hijr3lud6N6TXH3Jn1DrrJ
        7L9VveCWKXv8XImNL7/XX/zweSGf/A79uFmn5rqmvzkxt/6q/dvQivBSBvc8JZbijERDLeai
        4kQAYbVhHI8DAAA=
X-CMS-MailID: 20220126091741eucas1p2d10b5b053b2f21e388a7237bd1483822
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220124142928epcas5p4cb956c77eac815ff4347e8e3b09bfb54
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220124142928epcas5p4cb956c77eac815ff4347e8e3b09bfb54
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142928epcas5p4cb956c77eac815ff4347e8e3b09bfb54@epcas5p4.samsung.com>
        <20220124141644.71052-9-alim.akhtar@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.2022 15:16, Alim Akhtar wrote:
> Adds cmu_imem clock related code, imem block contains IPs
> like WDT, DMA, TMU etc, these clocks are required for such
> IP function.
> 
> Cc: linux-fsd@tesla.com
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Arjun K V <arjun.kv@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Tauseef Nomani <tauseef.n@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

