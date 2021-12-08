Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4646C9AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbhLHA7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:59:04 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:27462 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhLHA7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:59:00 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211208005527epoutp04613481bcd2f35490ff8d9f8a54a4dfae~_oYmqtTlU1016910169epoutp04M
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:55:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211208005527epoutp04613481bcd2f35490ff8d9f8a54a4dfae~_oYmqtTlU1016910169epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1638924927;
        bh=wQuQ44/o7M02aQ0FTR12+5aryFsCLHs176cin4ynVrM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=CV/1hzAXGDLNWFCIXEOUX4AoE6IaYq1RKgkd3nraMS9eAR6oUNFQxW5M1VmVYn0RB
         AaJm6ZFQvxSm2i2K8h1t6PTEP/yRSwP+sLpTYnBGr/3hXvVdbnS1nZfEVPya38inZ8
         /a1zeEx6q2V27LAZr9dMTrwrCCsTqw5i9Ey7Efrc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20211208005526epcas2p339707d15c5a262310b102237258d269b~_oYmKkJmI2385223852epcas2p3Z;
        Wed,  8 Dec 2021 00:55:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4J7zGy6VbVz4x9QH; Wed,  8 Dec
        2021 00:55:22 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.0A.51767.77200B16; Wed,  8 Dec 2021 09:55:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20211208005519epcas2p4aec9d5e05c223be8038528bab1eba223~_oYfYpO9Y0202402024epcas2p41;
        Wed,  8 Dec 2021 00:55:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211208005519epsmtrp22d186b84e70734404264684188d82cbc~_oYfXQfiC1200912009epsmtrp2F;
        Wed,  8 Dec 2021 00:55:19 +0000 (GMT)
X-AuditID: b6c32a45-447ff7000000ca37-a9-61b00277f8ba
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.26.08738.76200B16; Wed,  8 Dec 2021 09:55:03 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20211208005519epsmtip20d2e89373e9d732dc81dc41739c46afa~_oYfL5zu92559825598epsmtip2N;
        Wed,  8 Dec 2021 00:55:19 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'David Virag'" <virag.david003@gmail.com>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>
Cc:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        "'Michael Turquette'" <mturquette@baylibre.com>,
        "'Stephen Boyd'" <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
In-Reply-To: <916c297dc20acdbebd29cd2b36c6286380c7c318.camel@gmail.com>
Subject: RE: [PATCH v4 7/7] arm64: dts: exynos: Add initial device tree
 support for Exynos7885 SoC
Date:   Wed, 8 Dec 2021 09:55:19 +0900
Message-ID: <006701d7ebce$4567a650$d036f2f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFtSJ5guifxMDnJAP7qBkgnfWzaigGTL4zKAVvvS7cBc9QxbAHKqA5mrMudyWA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmmW4504ZEg5XvdCyuf3nOajH/yDlW
        i41vfzBZbHp8jdXiY889VovLu+awWcw4v4/J4uIpV4vWvUfYLQ6/aWe1+HdtI4vF8z6g+Kpd
        fxgtjr9/zOjA5/H+Riu7x6yGXjaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6AIyrb
        JiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfobCWFssSc
        UqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbE
        5p+sBfOZK65c6GVvYLzB1MXIySEhYCJxdOlhIJuLQ0hgB6PEjFVdjBDOJ0aJE08nskM4nxkl
        Ni7ayQLTcvr5FlYQW0hgF6PEntVmEEUvGCWmXz/ABpJgE9CXeNmxDaxIRCBB4mrHTLBJzAJf
        mSXuL97ADJLgFHCXOPlmFthUYYEUiU9nl7GD2CwCKhKnlz8Ga+YVsJT4c3AaG4QtKHFy5hOw
        emYBbYllC18zQ1ykIPHz6TKoZX4SV2/eZYaoEZGY3dnGDLJYQuAKh8S8PVOgXnCR6Ju9GRoC
        whKvjm9hh7ClJD6/28sG0dDNKNH66D9UYjWjRGejD4RtL/FrOsj/HEAbNCXW79IHMSUElCWO
        3IK6jU+i4/Bfdogwr0RHmxBEo7rEge3ToS6Qleie85l1AqPSLCSfzULy2SwkH8xC2LWAkWUV
        o1hqQXFuemqxUYEhPLaT83M3MYKTtJbrDsbJbz/oHWJk4mA8xCjBwawkwqv2cG2iEG9KYmVV
        alF+fFFpTmrxIUZTYFhPZJYSTc4H5om8knhDE0sDEzMzQ3MjUwNzJXHeD/7TE4UE0hNLUrNT
        UwtSi2D6mDg4pRqYtuxY7jJV9hn3TJYP3fGi+x2eFa2YFpD0eHlkyt2u227rVgT6J869uMn0
        z+Qp01WfOTR99r7KssnkI3/6vIuPFbWutpv3P2dZ+V7olboKk/aBn92y+69NazDsylsc8iRI
        USOu0a7bX1955n7b1UfP8kgmsC1XrA38nGN0LiMhtvOylN32dP9us/hrSfP1z7T8nHLuht6O
        E1P4LfeZPdDWny7813T/bc3kTSn3Yv1L075ej2H9FLb5bevcmbd9uIwemtSLf7vHXLaMq+n0
        KYG2i680HVPvLJi26H9j9NeecI7M7SWfNllNKz2q8mdCfeAJ0+TUzY51qzm/PRaaOKtt49/J
        HZujj01fImM74eqpUCWW4oxEQy3mouJEAIH+JTVbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSvG4604ZEg4/TuC2uf3nOajH/yDlW
        i41vfzBZbHp8jdXiY889VovLu+awWcw4v4/J4uIpV4vWvUfYLQ6/aWe1+HdtI4vF8z6g+Kpd
        fxgtjr9/zOjA5/H+Riu7x6yGXjaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6AI4rL
        JiU1J7MstUjfLoEr48zpsywFc5krdt7azd7AeI2pi5GTQ0LAROL08y2sXYxcHEICOxglepdf
        ZIRIyEo8e7eDHcIWlrjfcgSq6BmjRNuDbawgCTYBfYmXHRC2iECCxLL729hAipgF/jJL/Dq3
        jhmi4zCTxIudB8D2cQq4S5x8M4sFxBYWSJL4sXs/mM0ioCJxevljsEm8ApYSfw5OY4OwBSVO
        znwCVsMsoC3x9OZTOHvZwtfMEOcpSPx8ugzqCj+JqzfvMkPUiEjM7mxjnsAoPAvJqFlIRs1C
        MmoWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCY1ZLawfjnlUf9A4xMnEw
        HmKU4GBWEuFVe7g2UYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZ
        Jg5OqQameL5Q5a1vX9mavd1n0BYc+Wy+hEDLuVn3FZ7/TxM7uqA3vPn9oY2KEpecN+ik3Wp8
        Kvwz1Hqusvu6OSdZyvxXuDiIn2u5kl4xa7Puxthlm2buCWW6lFbmGHv39p79f34n2t36k1Gd
        X3pXeZ6acrVz4dOsM4n3N4qu0hIMs/1hv/mMiGBz/obMCdVi3CeZa7L8PX7c/3515YM6tf4T
        /11SH+/SCrHc78GQzfuAxeP96fAX10KNd64Na7Hb8C7nu2Lf+YX9l8LqPkdq2P6MZV9lLFE6
        Z8vNjmdOvw5bOG7/sne51nO1uKwrEWe0Ji5XUVNiUFwx51XR56M7y350FvN2G5mfOnjlr/iv
        ojt1qaxzlViKMxINtZiLihMB6pvDRUgDAAA=
X-CMS-MailID: 20211208005519epcas2p4aec9d5e05c223be8038528bab1eba223
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211207223050epcas2p186da08bcece9605e97573a230db88308
References: <20211206153124.427102-1-virag.david003@gmail.com>
        <20211206153124.427102-8-virag.david003@gmail.com>
        <CAPLW+4k3Vmg0W0jVsTChHTG8+eeg=5QF+actz1Tk0vNV9w-y-A@mail.gmail.com>
        <CGME20211207223050epcas2p186da08bcece9605e97573a230db88308@epcas2p1.samsung.com>
        <916c297dc20acdbebd29cd2b36c6286380c7c318.camel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Shouldn't SoC and board files be sent as two separate patches? For
> > example, I've checked exynos5433 and exynos7, SoC support
>=20
> For some reason I remembered ExynosAutoV9 sending them together but I
> was wrong, will seperate in the future.

I posted it separately.
https://lore.kernel.org/linux-samsung-soc/20211010032246.146939-1-chanho61.=
park=40samsung.com/

Best Regards,
Chanho Park

