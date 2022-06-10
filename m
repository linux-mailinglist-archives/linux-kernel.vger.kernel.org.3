Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D469D5461B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349027AbiFJJUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349091AbiFJJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:18:44 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E286C2DCB02
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:16:51 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220610091650epoutp0375522ef017f34032284c35716a86b049~3N65rSlns3156031560epoutp03M
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:16:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220610091650epoutp0375522ef017f34032284c35716a86b049~3N65rSlns3156031560epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654852610;
        bh=k5tMkeelZLPyfaRW8bgapAtgua4v9voINWLUnLSj8pI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Far8LaYRTECRv7YEJkvcCtWENrgGFVQifBCjW2WDu+ZDHTZNnO6MR36zrYKc2zkDf
         qNqgSkHrgbgnKkFswBIy5WZlBJ23SmkFmlveO18riI8falVTX++/btC56Ws5VOrqeV
         IjDaRhTBJJo/6mbI5zDCF8wIGH5YBTpOSpBJZwLw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220610091650epcas5p1a0dfbf63a82d9ca8f1e982e27cd3a4bd~3N65W5mO31464714647epcas5p1c;
        Fri, 10 Jun 2022 09:16:50 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LKFhb1yrsz4x9Q2; Fri, 10 Jun
        2022 09:16:47 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.35.09762.EFB03A26; Fri, 10 Jun 2022 18:16:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220610091646epcas5p13276bf00cd849952e20eb5d3c71fe6c5~3N62KBSod1464714647epcas5p1W;
        Fri, 10 Jun 2022 09:16:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220610091646epsmtrp1ded6d360314519bf08d317e83f5dd260~3N62JXitp2671126711epsmtrp15;
        Fri, 10 Jun 2022 09:16:46 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-3e-62a30bfe725b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.77.08924.EFB03A26; Fri, 10 Jun 2022 18:16:46 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220610091645epsmtip2835d0058ec8a4924e61adf02e8466122~3N61OUrZH2685626856epsmtip2Z;
        Fri, 10 Jun 2022 09:16:45 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Chanho Park'" <chanho61.park@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Cc:     <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <pankaj.dubey@samsung.com>
In-Reply-To: <000001d87ca2$3ac0f520$b042df60$@samsung.com>
Subject: RE: [PATCH -next] phy: samsung-ufs: fix NULL pointer dereference
Date:   Fri, 10 Jun 2022 14:46:44 +0530
Message-ID: <000601d87caa$cede0150$6c9a03f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJNUr2mveM3EJGNpu0kIdNV5dOukgIPmyx5AVPcAqqsQ5QiIA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTQ/cf9+Ikg3nTjSwu79e26HvxkNni
        8q45bBYTVn1jsVi09Qu7xc47J5gd2Dw2repk87hzbQ+bx+Yl9R59W1YxenzeJBfAGpVtk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
        kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnbH85gr2
        gr/cFZv3vGJvYOzj6mLk5JAQMJF4fPgAUxcjF4eQwG5GiRmXrzFDOJ8YJU7Ovg/lfGaUuHb6
        OxtMy8uvX6ASuxgltuxtZwVJCAm8ZJS4fLQGxGYT0JXYsbgNrEFEoEhi2ZaVYDazQKRE4/MN
        LCA2p4CVxPfTzewgtrCAp8SKd/fAbBYBVYmed3/AZvIKWEpManzGBmELSpyc+YQFYo62xLKF
        r5khDlKQ+Pl0GSvELieJ5kM7oGrEJV4ePcIOUdPKITH7PG8XIweQ7SLxv8cFIiws8er4FqgS
        KYmX/W3sECUeEov+SEGEMyTeLl/PCGHbSxy4MocFpIRZQFNi/S59iEV8Er2/nzBBdPJKdLQJ
        QVSrSjS/u8oCYUtLTOzuZoUZfmtu5ARGxVlIvpqF5KtZSK6fhbBrASPLKkbJ1ILi3PTUYtMC
        47zUcnhcJ+fnbmIEp0wt7x2Mjx580DvEyMTBeIhRgoNZSYQ34PaiJCHelMTKqtSi/Pii0pzU
        4kOMpsCgnsgsJZqcD0zaeSXxhiaWBiZmZmYmlsZmhkrivAL/G5OEBNITS1KzU1MLUotg+pg4
        OKUamKQNQn/v+JX8IO7NxO0ZbSt8jAo2cpXeYX/2MOj1mzWWhdzJR/5MYbjg8/LZYbP94def
        nmDjW1cenfJ9rUHo7HfP245HF7VVKWmfYrZSeXh7pvtG8eqJjRq8Rz8I6ldlTV2sFfnTrMbR
        JEP62RKlNY63J3xiD3t9X/P13LYjTpGu3sZz25N5HxmyRR6a5JD4z8mjrVA37HS0WvbTz8on
        LgjzPjgV8fztj3zTniucZi8KVrH3bLET2t14aOvBvri3akuEDP3Yg85eWVD/zeezeh2j0KG+
        /o6DtmvSVZNXp8RUBf31S859bxMr9dXiQF/nxiuC824z/VvcvL2fPafUUuv57ukGh+uevRBu
        fdRXrsRSnJFoqMVcVJwIAL0aGNoiBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvO4/7sVJBhePyFlc3q9t0ffiIbPF
        5V1z2CwmrPrGYrFo6xd2i513TjA7sHlsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6ANYrLJiU1
        J7MstUjfLoErY+GcuUwFZ7gr+i8/Ym9gvM/ZxcjJISFgIvHy6xfmLkYuDiGBHYwS71p2MUEk
        pCWub5zADmELS6z895wdoug5o0TLnb+sIAk2AV2JHYvb2EBsEYESif9rf4E1MAtESyz6vYUF
        omEPo0TDid1gCU4BK4nvp5vBbGEBT4kV7+6B2SwCqhI97/6ADeUVsJSY1PiMDcIWlDg58wkL
        xFBtid6HrYww9rKFr5khrlOQ+Pl0GSvEEU4SzYd2QNWLS7w8eoR9AqPwLCSjZiEZNQvJqFlI
        WhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOIS2tHYx7Vn3QO8TIxMF4iFGC
        g1lJhDfg9qIkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODil
        Gpg2MKbG/22ZUFjydmbVLJbn0Zctz9443K119MO0F6+8/HqOPv2zKythfcP8J+oCZguW+CSc
        VJNcL/Al4A1Xy/+dr2SPmdYkX7imXHq+XT08+N//HkHxf9P9fQ0/JS7/cT757cxpmy7tnPs1
        Iu624OZXB8w/H2qeVeNuxmO9a9n/J++cKj9q1sdy9fytaVNeVOsQeC5FwvtPUW+M/GS959Pv
        hX+7ui2wdPfDHdOMzp47zOXeEh6v8t9rk+LnENXmAqvn4YUpGjbiidU9bn7XtU+s2jT9vPSS
        7PeX35kc5r0W8Iypaf485VnZ5woOblieXHe44/gnwUn1PCs6Ylr/XZzDsdBMaXf2G/19F5/d
        Wjz7rxJLcUaioRZzUXEiACtGk3IQAwAA
X-CMS-MailID: 20220610091646epcas5p13276bf00cd849952e20eb5d3c71fe6c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610070811epcas5p3c62ef9ad9c82092deac59ff9be896677
References: <CGME20220610070811epcas5p3c62ef9ad9c82092deac59ff9be896677@epcas5p3.samsung.com>
        <20220610070547.71193-1-alim.akhtar@samsung.com>
        <000001d87ca2$3ac0f520$b042df60$@samsung.com>
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



>-----Original Message-----
>From: Chanho Park =5Bmailto:chanho61.park=40samsung.com=5D
>Sent: Friday, June 10, 2022 1:45 PM
>To: 'Alim Akhtar' <alim.akhtar=40samsung.com>; linux-kernel=40vger.kernel.=
org;
>linux-phy=40lists.infradead.org
>Cc: krzysztof.kozlowski+dt=40linaro.org; vkoul=40kernel.org;
>pankaj.dubey=40samsung.com
>Subject: RE: =5BPATCH -next=5D phy: samsung-ufs: fix NULL pointer derefere=
nce
>
>> Subject: =5BPATCH -next=5D phy: samsung-ufs: fix NULL pointer dereferenc=
e
>>
>> commit f86c1d0a58b1f63a (=22phy: samsung: ufs: remove drvdata from
>> struct
>> samsung_ufs_phy=22)
>>
>> removes _drvdata_ initialization which resulting in NULL pointer
>> dereferencing in samsung_ufs_phy_wait_for_lock_acq(). Fix this by
>> initializing drvdata.
>>
>> The said commit also duplicate =22has_symbol_clk=22 both in drvdata stru=
ct
>> and in samsung_ufs_phy struct, let's go back and use only one
>=22has_symbol_clk=22.
>>
>> Fixes: f86c1d0a58b1 phy: samsung: ufs: remove drvdata from struct
>> samsung_ufs_phy
>
>This might be conflicted when you apply your patch.
>https://lore.kernel.org/linux-phy/20220610072924.12362-3-
>alim.akhtar=40samsung.com/T/=23u
>
>When I created my patch, it was not existing so my previous patch make
>sense.
>If you get back drvdata for your patch, please drop this =22fixes tag + pa=
tch=22 and
>put this in your patchset.
>
Thanks Chanho
Because of the merged conflict this got messed up. Will correct it.

>Best Regards,
>Chanho Park


