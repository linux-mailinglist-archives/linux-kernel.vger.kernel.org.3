Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EFD4A34F1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 08:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354338AbiA3HhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 02:37:05 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:23349 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354336AbiA3HhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 02:37:03 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220130073703epoutp028328083e4233d3375ae10deff78502e4~O-DYTszOZ0438904389epoutp02w
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 07:37:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220130073703epoutp028328083e4233d3375ae10deff78502e4~O-DYTszOZ0438904389epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643528223;
        bh=pH5rf+DfMv29URj8t7deVxpdP/j3Emx0ajXP8qbjm7U=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=VGyXN9QuQA++P8OAnIl8osvoO9xBjEWzglrJ/m7NGm7TGgT4bNhnnVHzXBi/FDX6M
         TJ42BjQRiajmbX2GH5P1hfnhkekAnhURx5IOL7U5C2XGoa7HLHh8SBKZsogjAWSErN
         tz/IQDHDQlkffysPIFCI2tyg9Mjf+W4PH+mHERH0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220130073701epcas5p4948509be27fa9237511fdec1fa7cbf94~O-DXI0moB2749227492epcas5p4l;
        Sun, 30 Jan 2022 07:37:01 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jmjgt6j3fz4x9Pt; Sun, 30 Jan
        2022 07:36:58 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.94.06423.91046F16; Sun, 30 Jan 2022 16:36:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220130073658epcas5p31df52a9acb78b0bc80666846940940e3~O-DTt_sFS1418914189epcas5p39;
        Sun, 30 Jan 2022 07:36:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220130073658epsmtrp24a5bb6902d8072259c0fdbdcc28c950b~O-DTsS_-i0531405314epsmtrp2H;
        Sun, 30 Jan 2022 07:36:58 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-39-61f640194a38
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.F0.29871.91046F16; Sun, 30 Jan 2022 16:36:57 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220130073656epsmtip151d896e074b816bc513798e7fc345e89~O-DSIJx9o1600216002epsmtip1R;
        Sun, 30 Jan 2022 07:36:56 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Lee Jones'" <lee.jones@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
In-Reply-To: <20220129175332.298666-3-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH 3/5] mfd: exynos-lpass: Drop unneeded syscon.h include
Date:   Sun, 30 Jan 2022 13:06:54 +0530
Message-ID: <00da01d815ac$28e89900$7ab9cb00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFgtqenDY7K+SNveA8HtgWqOAMTMQGBJbvGAjHHReGtTFNJwA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmpq6Uw7dEg3NnGS3mHznHatG8eD2b
        xca3P5gs7n89ymix6fE1VovLu+awWcw4v4/J4sziXnaLtUfuslu07j3CbnH4TTurA7fHrIZe
        No9NqzrZPO5c28PmsX/uGnaPzUvqPfq2rGL0+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7
        ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hGJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+
        cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xp/TJ5kL/nJX3DzWzNjAeJKri5GT
        Q0LARGL54bXMXYxcHEICuxklHh3/xQrhfGKU2LHuGxOE841R4v3tW2xdjBxgLT96iyHiexkl
        5u3dBlX0klGip6eTEWQum4CuxI7FbWwgCRGBm8wSq7a0sIAkOAU8JNY8bmECsYUFvCRmTd7A
        DGKzCKhKfPnbDBbnFbCU+LL9JzuELShxcuYTsF5mAXmJ7W/nMEMcriDx8+kyVhBbRMBJYvqL
        VjaIGnGJl0ePsIMslhDYwyGxYcJOVogGF4mjJ9ugmoUlXh3fwg5hS0l8frcX6rVsiZ5dxhDh
        Goml846xQNj2EgeuzGEBKWEW0JRYv0sfYhWfRO/vJ0wQnbwSHW1CENWqEs3vrkJ1SktM7O6G
        OsBD4mrXfUZIWN1klFi3/AfLBEaFWUi+nIXky1lIvpmFsHkBI8sqRsnUguLc9NRi0wLDvNRy
        eIQn5+duYgQnYS3PHYx3H3zQO8TIxMF4iFGCg1lJhHfGpk+JQrwpiZVVqUX58UWlOanFhxhN
        gUE/kVlKNDkfmAfySuINTSwNTMzMzEwsjc0MlcR5T6dvSBQSSE8sSc1OTS1ILYLpY+LglGpg
        8lwu8IHFesoXsb/9+ofPfBTIdagVeDz5tOJ/hkXapsmLbtgX+U75/+/70dkyF0OaDthed7nj
        l8nBEdZkJL5iS47H7B/vZD8rxq7vUNAIn1m5ciu7Zk7I/3T1G1fufzsdPL01Y2F8l6OXtjeD
        04F6wUC3Sx/z71ed+J60h/HgBrH7E6NCY68Z3KhqjS777+sbVVqYndSww1s07eEGnqchW2da
        96zoYRF8JZmx6X/mj8mZG19/EDmn2B5RWzTVZG7IxOo9q2xy3Mo7cpK5J63+/CUitNcyr/Tp
        Vbb5dYcO6ewUPfky6O/vybG2U5sFtk+5PqkrQT/7Y6m1Ze0PnYKjO/LrXPTEpzRk5l9qFT6s
        xFKckWioxVxUnAgAkPcjE0sEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnK6kw7dEgzcXxSzmHznHatG8eD2b
        xca3P5gs7n89ymix6fE1VovLu+awWcw4v4/J4sziXnaLtUfuslu07j3CbnH4TTurA7fHrIZe
        No9NqzrZPO5c28PmsX/uGnaPzUvqPfq2rGL0+LxJLoA9issmJTUnsyy1SN8ugSvjz+mTzAV/
        uStuHmtmbGA8ydXFyMEhIWAi8aO3uIuRi0NIYDejxNI379m6GDmB4tIS1zdOYIewhSVW/nvO
        DlH0nFHiS9cEVpAEm4CuxI7FbWwgCRGBh8wSu35MYoWousoo8WDCTiaQKk4BD4k1j1vAbGEB
        L4lZkzcwg9gsAqoSX/42g8V5BSwlvmz/yQ5hC0qcnPmEBeQ8ZgE9ibaNjCBhZgF5ie1v5zBD
        XKQg8fPpMrAjRAScJKa/aGWDqBGXeHn0CPsERqFZSCbNQpg0C8mkWUg6FjCyrGKUTC0ozk3P
        LTYsMMxLLdcrTswtLs1L10vOz93ECI43Lc0djNtXfdA7xMjEwXiIUYKDWUmEd8amT4lCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MHnMNwgIWWsg8Vha
        Q39DRsHqVR8XBjfU9Or6qzTnl+311rTtevxKaLfzdom0M3+vyCuutl9oXznZ7Olc88O3dt8M
        ULnauTzsOP+BKbVLeyKPimr7TvmneSxrYS2znFtBLl/xVh3LVfwpQpZfL+ouFbRl2VvTcvol
        02N29taNP899mmldpCV3XvS7z0ZnCcX5e1aca3hV/HjGUY4oURcfjodcl0wN+5+KMNY6Mq7m
        PKtbMI0j+KBR3ucT7xhLlpTFXTgf9YPr0PXt7Ur+xyrKtcU6Vz/5p1u4Ms73c6L63Oj/zVdb
        5/iqLVDQztkb7DGtfK95fP+rH6fjtOZ+zNOQf1Z8L3NJ9swnjuVpeTs/KbEUZyQaajEXFScC
        APegU6gmAwAA
X-CMS-MailID: 20220130073658epcas5p31df52a9acb78b0bc80666846940940e3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220129175342epcas5p19f205a37734553a9f5ddf0d5c4b186f4
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
        <CGME20220129175342epcas5p19f205a37734553a9f5ddf0d5c4b186f4@epcas5p1.samsung.com>
        <20220129175332.298666-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Saturday, January 29, 2022 11:24 PM
>To: Lee Jones <lee.jones@linaro.org>; Rob Herring <robh+dt@kernel.org>;
>Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Sylwester Nawrocki
><s.nawrocki@samsung.com>; Marek Szyprowski
><m.szyprowski@samsung.com>; devicetree@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-serial@vger.kernel.org
>Subject: [PATCH 3/5] mfd: exynos-lpass: Drop unneeded syscon.h include
>
>syscon regmap is not used since commit addebf1588ab ("mfd: exynos-lpass:
>Remove pad retention control").
>
>Fixes: addebf1588ab ("mfd: exynos-lpass: Remove pad retention control")
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> drivers/mfd/exynos-lpass.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c index
>99bd0e73c19c..166cd21088cd 100644
>--- a/drivers/mfd/exynos-lpass.c
>+++ b/drivers/mfd/exynos-lpass.c
>@@ -15,7 +15,6 @@
> #include <linux/delay.h>
> #include <linux/io.h>
> #include <linux/module.h>
>-#include <linux/mfd/syscon.h>
> #include <linux/of.h>
> #include <linux/of_platform.h>
> #include <linux/platform_device.h>
>--
>2.32.0


