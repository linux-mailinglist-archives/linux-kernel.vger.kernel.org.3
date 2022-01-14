Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4531048E6DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbiANIuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:50:16 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:36899 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiANIuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:50:14 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220114085013epoutp0271f10e41192f8f836b49b5619cef070b~KFusiVJ071994119941epoutp02R
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:50:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220114085013epoutp0271f10e41192f8f836b49b5619cef070b~KFusiVJ071994119941epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642150213;
        bh=cy8zy+zRC9CSauQB+gyuj8mDd6lwENP470hMCrj2wHY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=cAwrQ/kqKGjPSumFT9qI+yqXzA3VFyy2S+gSEh1Pj+apwZXKOfFYhO3PD76Q4gjMG
         UX6sc/nz6gx4mdIBfJqtH4Jk9xwVr/BvxtJ5d0nrwsaTMZTFBvS8hwySltKJpWylJc
         nEne23bBq9E2R5Udf7yEKRjbUd9WkDCRPYhk4/2c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220114085012epcas2p2894b47e805df7cfacda92a4d4d95fcac~KFusPUHdv1409014090epcas2p2H;
        Fri, 14 Jan 2022 08:50:12 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JZw3l3MkKz4x9Q9; Fri, 14 Jan
        2022 08:50:11 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.61.51767.14931E16; Fri, 14 Jan 2022 17:50:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220114085009epcas2p18c9b5e8514613848cea23a3a26125648~KFuo3f5_D1538515385epcas2p1E;
        Fri, 14 Jan 2022 08:50:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220114085009epsmtrp11a66860e9e32cd24c0671d81209066f1~KFuo24dEN2976029760epsmtrp1O;
        Fri, 14 Jan 2022 08:50:09 +0000 (GMT)
X-AuditID: b6c32a45-45dff7000000ca37-59-61e1394106c7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.2D.08738.14931E16; Fri, 14 Jan 2022 17:50:09 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220114085009epsmtip25fe808fce205c253735dfd764c61f2ed~KFuotStMj0345103451epsmtip2W;
        Fri, 14 Jan 2022 08:50:09 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Sam Protsenko'" <semen.protsenko@linaro.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220113203754.23197-1-semen.protsenko@linaro.org>
Subject: RE: [PATCH] soc: samsung: Fix typo in CONFIG_EXYNOS_USI description
Date:   Fri, 14 Jan 2022 17:50:09 +0900
Message-ID: <016301d80923$bc172b50$344581f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG2vnIcDJdMDWrNbM7c4eeVZtlwpwFycvl1rJk2qhA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdljTVNfR8mGiwbZ+NYuNb38wWWx6fI3V
        4vKuOWwWM87vY7J43rePyYHVY1ZDL5vHnWt72Dw2L6n3+LxJLoAlKtsmIzUxJbVIITUvOT8l
        My/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2itkkJZYk4pUCggsbhYSd/Opii/
        tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE74+jabcwFjawVyw+eYGxg
        XMjSxcjJISFgIvFm9j72LkYuDiGBHYwSVx9fYAJJCAl8YpS48l8Awv7MKDFxQRJMw6WZV6Ea
        djFK/Jr5gAXCecEoMXfjITaQKjYBfYmXHdtYQWwRgUKJA0c3M4LYzED2lkWfgGwODk4BB4ml
        d/1BwsICPhI/t20EW8wioCpx5d8hdhCbV8BSYt/kE1C2oMTJmU9YIMbIS2x/O4cZ4iAFiZ9P
        l0GtspKYefs01CoRidmdbcwgt0kI/GWXOL77GBtEg4vEgguPoZqFJV4d38IOYUtJvOxvY4do
        6GaUmPTyLlRiBqPEu5s5ELaxxKxn7WAPMAtoSqzfpQ9iSggoSxy5BXUbn0TH4b/sEGFeiY42
        IYhGdYkD26dDA11WonvOZ9YJjEqzkHw2C8lns5B8MAth1wJGllWMYqkFxbnpqcVGBYbwqE7O
        z93ECE6PWq47GCe//aB3iJGJg/EQowQHs5IIb3/R/UQh3pTEyqrUovz4otKc1OJDjKbAsJ7I
        LCWanA9M0Hkl8YYmlgYmZmaG5kamBuZK4rxeKRsShQTSE0tSs1NTC1KLYPqYODilGph4zk94
        rbEp37p024+DBpYlgstvTNI8HGdSsMdFqbwsXXlFru3UyV+n525a8iD0zWzzpqlyqsurf6QC
        U/T3pDsuXzJ+qN7xnRjPMsO652FdWFL+qvmffu/bFcUUFcR3+6mNVU+d4anzT1Yf3yR0b+PE
        +/Zhn10va7DIn9Gfdado0/5Nn/cmtsgFbtjmI/xTvKV91Yl4p9Ki/jsMHcZ2M282TUgJjrO3
        2Pso+YSo/wL1nZ7GIdu9WxfP3JlexRXINmXnzWWzjJmNpjszVVdXihk78TJP1bST64vL4Dr3
        LlN/6bYz7t7JAcd/Leh+mjzn9aywukPzQs5NWXXV/d/aww80ZMuXdG8QZGJdyf5uzjolluKM
        REMt5qLiRABYC8E9GAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvK6j5cNEg7OPeCw2vv3BZLHp8TVW
        i8u75rBZzDi/j8nied8+JgdWj1kNvWwed67tYfPYvKTe4/MmuQCWKC6blNSczLLUIn27BK6M
        o2u3MRc0slYsP3iCsYFxIUsXIyeHhICJxKWZV9m7GLk4hAR2MEp8ODeBDSIhK/Hs3Q52CFtY
        4n7LEVaIomeMEn+3vATrZhPQl3jZsY0VxBYRKJToXb4MrJlZoFhi0+MWsLiQwERGiZOXRbsY
        OTg4BRwklt71BwkLC/hI/Ny2kQnEZhFQlbjy7xDYLl4BS4l9k09A2YISJ2c+YYEYqSexfv0c
        RghbXmL72znMELcpSPx8ugzqBCuJmbdPQ9WISMzubGOewCg8C8moWUhGzUIyahaSlgWMLKsY
        JVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKjRUtrB+OeVR/0DjEycTAeYpTgYFYS4e0v
        up8oxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA5PLV5Hr
        aq5bVq5dqWjyPnnf49xJk8ri5/x8/fsq88GLPBwnAx/OOKLsMzFqrkbSf3atJGkZu8rjW2+H
        fP4wNb/5X1fZ1JrmOy+kZON+521Vifxz+WDR05VbEiRaVu2doN2wuFEksTjtd4qtwIODXvv/
        d/GVyZfvXXXp2YsTKm/nxpSu+C1oKntI2vcDz7n4Hy+uXts3v1zy9ruljRv77ykJrY/wttQ+
        p7r8lmHaCW5leSclCdGF3Efip1m51bu1zbkRZSkdJ2sx88mSi+qbq5NbDpktWaXaqfjksh27
        NjdL05YNJnsmSepFh1VdnuL7z0/02deP0X+ZLLZzXrq+KO5V95VaTbEL26as3qvxSv6MEktx
        RqKhFnNRcSIAfmAdDQUDAAA=
X-CMS-MailID: 20220114085009epcas2p18c9b5e8514613848cea23a3a26125648
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113203800epcas2p193b3961d55da5296cf7dd5fffacb87c0
References: <CGME20220113203800epcas2p193b3961d55da5296cf7dd5fffacb87c0@epcas2p1.samsung.com>
        <20220113203754.23197-1-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sam Protsenko <semen.protsenko@linaro.org>
> Sent: Friday, January 14, 2022 5:38 AM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-samsung-
> soc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] soc: samsung: Fix typo in CONFIG_EXYNOS_USI description
> 
> The proper name is Exynos Auto V9, not V0. It was the typo slipped in
> unnoticed, fix it.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Required "Fixes:" tag? Otherwise, LGTM.

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

