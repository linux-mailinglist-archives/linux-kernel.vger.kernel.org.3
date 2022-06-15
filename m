Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382F954D55C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350070AbiFOXaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350030AbiFOXaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:30:16 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7402613E93
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:30:13 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220615233007epoutp02b16da822434e7cf7958b81a0e71ed902~47yVpqp9S0781607816epoutp02W
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:30:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220615233007epoutp02b16da822434e7cf7958b81a0e71ed902~47yVpqp9S0781607816epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655335807;
        bh=VfdnilvGwyw2Gtx+bvH89i6cp4sH16STcDvEivtCMVc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=gv6eFKYZZv0tI65dJo6QkuRgD90WYV68qaNOnkHVy4hYbDArx5szucRDjeRx2ejVN
         0+4aIcj9d3Cy+9ehaGggr0ayZAsVes4rMh6b+yvWZwrC97r3NS1wzsEALqS/PMyt+e
         8ZML9us/LbWt9VdkxtOu245keTOWetVdmD2RafNI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220615233006epcas2p4cb9c4fedf20ad07307af300d10435105~47yVDiesa2820628206epcas2p4z;
        Wed, 15 Jun 2022 23:30:06 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LNhNs6grYz4x9Py; Wed, 15 Jun
        2022 23:30:05 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.EA.10028.D7B6AA26; Thu, 16 Jun 2022 08:30:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220615233005epcas2p4d5ea0e441c1b2e8ddeea093f425b233d~47yUSpYqz2820628206epcas2p4q;
        Wed, 15 Jun 2022 23:30:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220615233005epsmtrp1d709cdca229d9aaffc2686fc98054809~47yURjsFJ0872308723epsmtrp1X;
        Wed, 15 Jun 2022 23:30:05 +0000 (GMT)
X-AuditID: b6c32a47-589ff7000000272c-d9-62aa6b7d364c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.86.08924.D7B6AA26; Thu, 16 Jun 2022 08:30:05 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220615233005epsmtip21dd13d0c8bd664fdec537d25e1ab39b1~47yUA9mgp2583125831epsmtip2G;
        Wed, 15 Jun 2022 23:30:05 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Cc:     <beanhuo@micron.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <martin.petersen@oracle.com>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20220615121204.16642-1-alim.akhtar@samsung.com>
Subject: RE: [PATCH 1/3] ufs: host: ufs-exynos: remove unused defines
Date:   Thu, 16 Jun 2022 08:30:05 +0900
Message-ID: <000001d8810f$d7d913d0$878b3b70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHFEeTTG4xV+/czXfbyAHavs5YYnAHvmU5DrWh+5UA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmmW5t9qokg97vphYP5m1js3j58yqb
        xcGHnSwW0z78ZLboe/GQ2WLT42usFpd3zWGzmLDqG4vFjPP7mCy6r+9gs1h+/B+TA7fH5Sve
        Hneu7WHz2Lyk3uP7+g42j49Pb7F49G1ZxejxeZOcR/uBbqYAjqhsm4zUxJTUIoXUvOT8lMy8
        dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygO5UUyhJzSoFCAYnFxUr6djZF+aUl
        qQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2RnNr46wFbxirLgzfzdrA+Mu
        xi5GTg4JAROJ/a/3AdlcHEICOxglTnU1sUM4nxglHv5pYoZwPjNK/Lu3iw2mZdaliawQiV2M
        Ep9uXwRLCAm8YJQ4s4wHxGYT0Jd42bENrEgEZO7nFZ9YQBxmgY2MEr2NW4EcDg5OAVuJMw8t
        QBqEBVwl1s9/yA5iswioSlzuXAg2lFfAUuLCg1vMELagxMmZT1hAbGYBeYntb+cwQ1ykIPHz
        6TJWEFtEwErixqSn7BA1IhKzO9vAXpAQOMMhceX/K6gGF4mFMw9AvSMs8er4FnYIW0riZX8b
        lF0ssXTWJyaI5gZGicvbfkE1GEvMetbOCPIAs4CmxPpd+iCmhICyxJFbULfxSXQc/ssOEeaV
        6GgTgmhUlziwfToLhC0r0T3nM+sERqVZSD6bheSzWUg+mIWwawEjyypGsdSC4tz01GKjAmN4
        bCfn525iBKdhLfcdjDPeftA7xMjEwXiIUYKDWUmE1yx4ZZIQb0piZVVqUX58UWlOavEhRlNg
        WE9klhJNzgdmgrySeEMTSwMTMzNDcyNTA3MlcV6vlA2JQgLpiSWp2ampBalFMH1MHJxSDUzl
        15o5zvKEHWHY0+vYGbmVyTtUXas2a5G/ttaZGv2N3w5yCBhnpfAu/JHg3LWx9MJTvr08r+7N
        E/x0yGzewj317s6C4o7d/Wk2S/I2BiVNPj/RPGhWdfdUX/d0g6prlsZsjb61udltK1luFv/c
        1FSXIXpUw5tRNHRWTPPvG1aS853txT9Lh675HbLvU4Ov9nk2K9flL5dezpAuFZQpfWz3a1eD
        osGZgrxzpTw3JiodDLk3W23zRN7dDsvaX33d5Gk9QffDIcWqCbl9R3aUZb4+ql3yP+HyZhGT
        +Zp7BZaU77wkt5Ur4+rLvTvZK4qmSbi+14i+6Dh7PSPj2s1uTPLFWSfeOs17sWmBhgRTiBJL
        cUaioRZzUXEiAOYICoVMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvG5t9qokg552KYsH87axWbz8eZXN
        4uDDThaLaR9+Mlv0vXjIbLHp8TVWi8u75rBZTFj1jcVixvl9TBbd13ewWSw//o/Jgdvj8hVv
        jzvX9rB5bF5S7/F9fQebx8ent1g8+rasYvT4vEnOo/1AN1MARxSXTUpqTmZZapG+XQJXRvOr
        I2wFrxgr7szfzdrAuIuxi5GTQ0LARGLWpYmsXYxcHEICOxglpj37ywSRkJV49m4HO4QtLHG/
        5QhU0TNGiZ73z1lBEmwC+hIvO7aBJUQE9jBKtM07xQ7iMAtsZ5TYuPgCC0RLH6PE9lNbmbsY
        OTg4BWwlzjy0AOkWFnCVWD//IdgKFgFVicudC9lAbF4BS4kLD24xQ9iCEidnPmEBsZkFtCWe
        3nwKZctLbH87hxniPAWJn0+XgV0kImAlcWPSU3aIGhGJ2Z1tzBMYhWchGTULyahZSEbNQtKy
        gJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcFRqae1g3LPqg94hRiYOxkOMEhzM
        SiK8ZsErk4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg
        kj48T3j+4nyOYt6044zTnyX2XD3v4fhm64EvuTvD0uuP5bM/2qO+5+58IdP3NrwOlZJuDIrr
        TR/wCDR3bJ//2cngxvGQRPfJqbKxyTdP6+bf3Wgi8Ovw5jMvvIV+sN24+8i24u3pt1ukf1So
        zf7PE8fFx7maI7h+S4zKux1PL36LVc55UuJ39b8dh6+nrJ32lNl67W+XfXh0bNnenifXSl7p
        +a/7LlH6vr/j1VZRnltOS4VXFXJ0upcuvqJ0gWWKezV3+xupVU6eL7OOP5QuZK8zn9CjtSaT
        yT8wd0IM+/RJJasY5TxlN8pmXzlmvXJe+PH/2xPOtM+PujvjzwwJZy7W1mYOteKMkKzP8uvO
        K7EUZyQaajEXFScCAJebwtM5AwAA
X-CMS-MailID: 20220615233005epcas2p4d5ea0e441c1b2e8ddeea093f425b233d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220615121508epcas5p3a42f8503bb6c6120cb4c0606109fe9c4
References: <CGME20220615121508epcas5p3a42f8503bb6c6120cb4c0606109fe9c4@epcas5p3.samsung.com>
        <20220615121204.16642-1-alim.akhtar@samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 1/3] ufs: host: ufs-exynos: remove unused defines
> 
> Remove #defines as those are not used anywhere in the driver file
> 

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

