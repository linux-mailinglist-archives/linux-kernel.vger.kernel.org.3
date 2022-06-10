Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BEF545E53
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347219AbiFJIPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346746AbiFJIP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:15:28 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7138D20C6D6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:15:26 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220610081524epoutp0455e1e63b2a16f38ec43c5dcb4aa47e0e~3NFQ2ViBd0286502865epoutp044
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:15:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220610081524epoutp0455e1e63b2a16f38ec43c5dcb4aa47e0e~3NFQ2ViBd0286502865epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654848924;
        bh=bMeQj0WB3feMcKPWBDNinj0jpYwg44qY0abSStpfGFw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=D/KQM85/40GSvpCjNi9id8qfEmR5VrgOmHydQU3VF7LIm1AfsZPHISQtw6EMNBACF
         NHB5nbhqZucXNGSZXZ6PsgupMGOk7HmG34KadC+qmkPr+sDRBT4jFjEsjV9o5P4Bvx
         QbZcniBGLkgiOO2wfQvrW8Vg0oSHgoXf8RaS1/qE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220610081524epcas2p281a106d878387fbc07419ca43ed5aedf~3NFQhaoin1840018400epcas2p2r;
        Fri, 10 Jun 2022 08:15:24 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LKDKl46jHz4x9Q5; Fri, 10 Jun
        2022 08:15:23 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.FE.09694.A9DF2A26; Fri, 10 Jun 2022 17:15:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220610081522epcas2p1bff7fcad5bf93d5b05b8d01dad6793e0~3NFOs4Yvo2888328883epcas2p1b;
        Fri, 10 Jun 2022 08:15:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220610081522epsmtrp10a39c80c05c8b09afb5992538534afd0~3NFOsMhvI2304823048epsmtrp1I;
        Fri, 10 Jun 2022 08:15:22 +0000 (GMT)
X-AuditID: b6c32a48-47fff700000025de-16-62a2fd9a96cd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.02.08924.99DF2A26; Fri, 10 Jun 2022 17:15:21 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220610081521epsmtip19abbe1a8fc44efa89ea6b41340797757~3NFOjD_x52561225612epsmtip1o;
        Fri, 10 Jun 2022 08:15:21 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Cc:     <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <pankaj.dubey@samsung.com>
In-Reply-To: <20220610070547.71193-1-alim.akhtar@samsung.com>
Subject: RE: [PATCH -next] phy: samsung-ufs: fix NULL pointer dereference
Date:   Fri, 10 Jun 2022 17:15:21 +0900
Message-ID: <000001d87ca2$3ac0f520$b042df60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJNUr2mveM3EJGNpu0kIdNV5dOukgIPmyx5rE4hWXA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdljTQnfW30VJBof+K1g8mLeNzaLvxUNm
        i8u75rBZTFj1jcVi0dYv7BY775xgdmDz2LSqk83jzrU9bB6bl9R79G1ZxejxeZNcAGtUtk1G
        amJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0AFKCmWJOaVA
        oYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMaTdX
        MBe8Zq84fWs6ewPjIbYuRk4OCQETiX07n7N3MXJxCAnsYJRoX3WXEcL5xCjx/d1RJgjnM6PE
        xwOfWGBaDk9oYoNI7GKUePv/ClT/C0aJz2v7wQazCehLvOzYxgpiiwgUSDQe/cwEYjMLREo0
        Pt8ANolTwFbiRucndhBbWMBTYsW7e0A2BweLgKrEx8OlICavgKXEh7e1IBW8AoISJ2c+YYGY
        oi2xbOFrZoh7FCR+Pl0GtclKYsKeFqgaEYnZnW1QNa0cEp+nC0PYLhJzvu2CigtLvDq+hR3C
        lpJ42d8GZRdLLJ31Cex5CYEGRonL235Bw8tYYtazdkaQ25gFNCXW79IHMSUElCWO3IJayyfR
        cfgvO0SYV6KjTQiiUV3iwPbp0BCUleie85l1AqPSLCSPzULy2CwkD8xC2LWAkWUVo1hqQXFu
        emqxUYEJPKqT83M3MYJTppbHDsbZbz/oHWJk4mA8xCjBwawkwhtwe1GSEG9KYmVValF+fFFp
        TmrxIUZTYEBPZJYSTc4HJu28knhDE0sDEzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9
        TBycUg1Mrbu/Fi9mjXCzClRu3xGmLmMhlyaVV5kysSvuB2NwtoezncKXmrsLM04UvVQSC630
        C5neZpfCmigQIbDzzY2o024bpzWu7Xgs/i5kxuxHpd3745ROynqtDs7q2cNh889C7554L/8N
        /7bNO+o05La7dW02OZC7UuNY5fqjK2/XPvnCmT83Pjx5dTZT4XzVwJbAjp9HS5dzGy79dKF0
        r5CY67Y/mRkRDzn7buleDp976YGF4IPNVhwu/+YdK7ZatnJRieziDwdbdG6HPb9jItfMoiZn
        4/9XNeKmd8WvmvRNQZtl8l+Zr+nJeuxhce7b5kbRvxG+pl8WqdeflXZdMSXBLdShZ1VBkXmV
        ayVTqRJLcUaioRZzUXEiANxOSl0iBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnO6sv4uSDB4KWDyYt43Nou/FQ2aL
        y7vmsFlMWPWNxWLR1i/sFjvvnGB2YPPYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAaxSXTUpq
        TmZZapG+XQJXxoYNpxgLrrFXrP3Xx9LAuJqti5GTQ0LAROLwhCYgm4tDSGAHo8TpMy9YIBKy
        Es/e7WCHsIUl7rccYYUoesYocfXkQrAiNgF9iZcd21hBbBGBIok368+CTWUWiJZY9HsLWI2Q
        QB+jxJOTZSA2p4CtxI3OT2BDhQU8JVa8uwdkc3CwCKhKfDxcCmLyClhKfHhbC1LBKyAocXLm
        ExaIidoST28+hbOXLXzNDHGagsTPp8ugLrCSmLCnBapGRGJ2ZxvzBEbhWUhGzUIyahaSUbOQ
        tCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcPVpaOxj3rPqgd4iRiYPxEKME
        B7OSCG/A7UVJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBK
        NTBNYQzbevVD/Q7h3bb2Ovu165br3w89u5r7JHeUjuQygaAFZx/9nrNU6NoHwaIFDId2dUSc
        cI1J3nUrxi121wUu/pY679TsxTwPd6nH8eY8e7fn6O2L+9YK1D0KDKp6fd9++lG24AUSwi5b
        0zv36J5zXKbUb1Z+ONDkfO3CS2Wr197/MGH1fClnT7uZCtazLvZ/SfBOMp3i8uWdQGn1irNl
        Znr6Z5Zf7nbQEt5nHtR35ly83kV9Lfk3FtYqe44yOrCvVV6348n7p9P0+hQ9lRI5YuVf5Cz5
        9Ttqpqla0vNbcrnc3R/Ftc9OnrQp6czmFL7XqyPf7AmoLRZzuPDvW8S+xmWPpxdId89uXi10
        bnapEktxRqKhFnNRcSIA9f25YA0DAAA=
X-CMS-MailID: 20220610081522epcas2p1bff7fcad5bf93d5b05b8d01dad6793e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610070811epcas5p3c62ef9ad9c82092deac59ff9be896677
References: <CGME20220610070811epcas5p3c62ef9ad9c82092deac59ff9be896677@epcas5p3.samsung.com>
        <20220610070547.71193-1-alim.akhtar@samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: =5BPATCH -next=5D phy: samsung-ufs: fix NULL pointer dereference
>=20
> commit f86c1d0a58b1f63a (=22phy: samsung: ufs: remove drvdata from struct
> samsung_ufs_phy=22)
>=20
> removes _drvdata_ initialization which resulting in NULL pointer
> dereferencing in samsung_ufs_phy_wait_for_lock_acq(). Fix this by
> initializing drvdata.
>=20
> The said commit also duplicate =22has_symbol_clk=22 both in drvdata struc=
t and
> in samsung_ufs_phy struct, let's go back and use only one =22has_symbol_c=
lk=22.
>=20
> Fixes: f86c1d0a58b1 phy: samsung: ufs: remove drvdata from struct
> samsung_ufs_phy

This might be conflicted when you apply your patch.
https://lore.kernel.org/linux-phy/20220610072924.12362-3-alim.akhtar=40sams=
ung.com/T/=23u

When I created my patch, it was not existing so my previous patch make sens=
e.
If you get back drvdata for your patch, please drop this =22fixes tag + pat=
ch=22 and put this in your patchset.

Best Regards,
Chanho Park

