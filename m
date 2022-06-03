Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5583353C31F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbiFCBc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiFCBcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:32:10 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71D93B57F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 18:31:17 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220603013116epoutp01a9ee953b761c53da4ea43babfaf09c7e~0_DaFCDPs1978619786epoutp01Z
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 01:31:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220603013116epoutp01a9ee953b761c53da4ea43babfaf09c7e~0_DaFCDPs1978619786epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654219876;
        bh=t5IuCCi9iX8N/w6cn5YeEppR7RVRvs2ts9SZ99V9yH0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Eql7neFuzwkjHPH44MBRAyC/qM731KQtyLbDzwJerJ4eYX4HBqF7dq6fXgmUMw2UJ
         soUBu4wQ/DF8ZmS384HYeBd/MA2RSbR3z1KYV2rf7tfp8b++Ho3pD+WsF5MmZci0jP
         O4khlTnLRc5bDasNdW6feNJAoL2ztBV01P9C+S7w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220603013115epcas5p41f437187f1f078814c6ec6c963aca1b5~0_DZeJ8-H1745617456epcas5p4E;
        Fri,  3 Jun 2022 01:31:15 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LDlhc60vxz4x9Q2; Fri,  3 Jun
        2022 01:31:12 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.3A.09762.06469926; Fri,  3 Jun 2022 10:31:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220603013112epcas5p425a5044bbb08c2ea9ea97cf0afca7ded~0_DWd9Mou3118831188epcas5p4e;
        Fri,  3 Jun 2022 01:31:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220603013112epsmtrp1351712f2599aca8eaaabb52812d8ca30~0_DWcDH242663326633epsmtrp10;
        Fri,  3 Jun 2022 01:31:12 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-7c-629964603aa5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.B1.11276.06469926; Fri,  3 Jun 2022 10:31:12 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220603013109epsmtip2ad6f570469ae077fa4692ef8ea0267a0~0_DTw6iuD1079110791epsmtip2B;
        Fri,  3 Jun 2022 01:31:09 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Cc:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <martin.petersen@oracle.com>, <chanho61.park@samsung.com>,
        <pankaj.dubey@samsung.com>, <linux-fsd@tesla.com>,
        "'Bharat Uppal'" <bharat.uppal@samsung.com>
In-Reply-To: <e92618c0-056c-5854-9bb3-5fba90a82d96@linaro.org>
Subject: RE: [PATCH 2/6] phy: samsung-ufs: move cdr offset to drvdata
Date:   Fri, 3 Jun 2022 07:01:08 +0530
Message-ID: <000b01d876e9$9bd36690$d37a33b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEGJiXAXdobboEKZTBkhZkj5AOCHwHY2vLkAdBvZpoC7O2Ypa6s1ROQ
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKJsWRmVeSWpSXmKPExsWy7bCmpm5CyswkgyundS1e/rzKZnHt5QV2
        i2kffjJbXN6vbTH/yDlWi74XD5kt9r7eym6x6fE1VouHr8ItLu+aw2YxYdU3Fovu6zvYLJYf
        /8dksWjrF3aL1r1H2C123jnB7CDgcfmKt8emVZ1sHneu7WHz2Lyk3uPj01ssHn1bVjF6/Gua
        y+7xeZOcR/uBbqYAzqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRb
        JRefAF23zBygH5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6
        eaklVoYGBkamQIUJ2Rnt3w6xF7ziq+j8vJelgfEFTxcjJ4eEgInEnyW32UFsIYHdjBLT1jB1
        MXIB2Z8YJVbtnArlfGOUWDy3kxGmY3vTOVaIxF5GiYMfj0NVvWSU2Nuzlhmkik1AV2LH4jY2
        kISIwHFGif3N+1lBEswC+5kk2t4YgNicAnYSj5bNBRsrLOAq8fneLbAaFgEViZWLz4EN4hWw
        lFh49BsrhC0ocXLmExaIOfIS29/OYYY4SUHi59NlYDUiAm4S8+efZoeoEZd4efQIO0TNBw6J
        vheqELaLxLbb06HeEZZ4dXwLVI2UxMv+NiCbA8j2kFj0RwoinCHxdvl6qHJ7iQNX5rCAlDAL
        aEqs36UPsYlPovf3EyaITl6JjjYhiGpVieZ3V1kgbGmJid3drDDDb/0Xm8CoOAvJW7OQvDUL
        yfmzEHYtYGRZxSiZWlCcm55abFpgnJdaDo/t5PzcTYzg9K3lvYPx0YMPeocYmTgYDzFKcDAr
        ifCW7JqaJMSbklhZlVqUH19UmpNafIjRFBjWE5mlRJPzgRkkryTe0MTSwMTMzMzE0tjMUEmc
        V+B/Y5KQQHpiSWp2ampBahFMHxMHp1QD05PNf3h3x4iwZ0sLFe6xDl/RKWd2U8lU/PGeA4WT
        WXZdYj5255Ve3XPvft8tTNYLk78pnFD8eN8594P4igtzp6uVFJalHKzOW7K5IzKK60H1VKEU
        4YSKjHfTL3xtur//hOkXU4vE2N3Z9rfS2VvPa//suzJHXXaLi9pyBw7dnlVH0nqm/6upW5Ow
        3qqtkntTbuBpqzm7ChLDGOatPv30bkd6z7SyD8eLH8iLXFt1vvLl8196KnNTJ396Pl2tkOPp
        ulP73nBrL9p64PTBJxYmB52Eqxv/6QnOOXFn7qNjQn9ae0T8H29PatJcr89vYa/NdZI/gr9r
        zd9Qpglsdcs64zKXV13h09zTXyHs+y19uhJLcUaioRZzUXEiAHBTDuJoBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSvG5Cyswkg741vBYvf15ls7j28gK7
        xbQPP5ktLu/Xtph/5ByrRd+Lh8wWe19vZbfY9Pgaq8XDV+EWl3fNYbOYsOobi0X39R1sFsuP
        /2OyWLT1C7tF694j7BY775xgdhDwuHzF22PTqk42jzvX9rB5bF5S7/Hx6S0Wj74tqxg9/jXN
        Zff4vEnOo/1AN1MAZxSXTUpqTmZZapG+XQJXRvu3Q+wFr/gqOj/vZWlgfMHTxcjJISFgIrG9
        6RwriC0ksJtRYtKEWoi4tMT1jRPYIWxhiZX/ngPZXEA1zxklzu55yQaSYBPQldixuI0NJCEi
        cJpRYtOee0wgDrPAaSaJD0dfMUO0fGSUmPj1LtgOTgE7iUfL5jKC2MICrhKf790Ci7MIqEis
        XHyOGcTmFbCUWHj0GyuELShxcuYTFhCbWUBb4unNp1C2vMT2t3OYIe5TkPj5dBlYvYiAm8T8
        +afZIWrEJV4ePcI+gVF4FpJRs5CMmoVk1CwkLQsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfm
        pesl5+duYgRHs5bmDsbtqz7oHWJk4mA8xCjBwawkwluya2qSEG9KYmVValF+fFFpTmrxIUZp
        DhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzmHA+33T7jfGLq49X3mrTUV7i+KOL8N/Vg
        08zt2vXuYfn2E3jXh5qIr2VhYisxUPu40581LTLZOtmtcc1kQ50U6a3LdFfU2fZl1d3Ul6hR
        Zpi+l1uvi2ey8mXH2wLLdcR7OlhfsK+fVTHzTkKU+eVNNZbL3gi/5DOcmK3RnGkYY9BZNdOM
        X32N5vIE39efZe5JHgrbZ+49L6VQpWx9qeVUwXChesPLLf5bd/xau/iZ/mT/Lye2VLcJXPM1
        7yjP/K++XOB/TQXrBDanFyXed2SlrHXKXm1SfVBt0ZamwcTSZFz0fyHT5qmcWr1Gq2YvzOt2
        bjk20f3Y5vhZATaf+ayPdk/jshB+tUv08JzzSizFGYmGWsxFxYkAoR0TJFUDAAA=
X-CMS-MailID: 20220603013112epcas5p425a5044bbb08c2ea9ea97cf0afca7ded
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220531012341epcas5p19b15b4916b210687ab6b46d6da0b2273
References: <20220531012220.80563-1-alim.akhtar@samsung.com>
        <CGME20220531012341epcas5p19b15b4916b210687ab6b46d6da0b2273@epcas5p1.samsung.com>
        <20220531012220.80563-3-alim.akhtar@samsung.com>
        <e92618c0-056c-5854-9bb3-5fba90a82d96@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Tuesday, May 31, 2022 3:26 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
>scsi@vger.kernel.org; linux-phy@lists.infradead.org
>Cc: devicetree@vger.kernel.org; robh+dt@kernel.org;
>krzysztof.kozlowski+dt@linaro.org; vkoul@kernel.org; avri.altman@wdc.com;
>bvanassche@acm.org; martin.petersen@oracle.com;
>chanho61.park@samsung.com; pankaj.dubey@samsung.com; linux-
>fsd@tesla.com; Bharat Uppal <bharat.uppal@samsung.com>
>Subject: Re: [PATCH 2/6] phy: samsung-ufs: move cdr offset to drvdata
>
>On 31/05/2022 03:22, Alim Akhtar wrote:
>> Move CDR lock offset to drv data so that it can be extended for other
>> SoCs which are having CDR lock at different register offset.
>>
>> Cc: linux-fsd@tesla.com
>> Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>  drivers/phy/samsung/phy-exynos7-ufs.c      | 3 +++
>>  drivers/phy/samsung/phy-exynosautov9-ufs.c | 2 ++
>>  drivers/phy/samsung/phy-samsung-ufs.c      | 3 ++-
>>  drivers/phy/samsung/phy-samsung-ufs.h      | 2 +-
>>  4 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/samsung/phy-exynos7-ufs.c
>> b/drivers/phy/samsung/phy-exynos7-ufs.c
>> index 7c9008e163db..d1a37273cb1f 100644
>> --- a/drivers/phy/samsung/phy-exynos7-ufs.c
>> +++ b/drivers/phy/samsung/phy-exynos7-ufs.c
>> @@ -11,6 +11,8 @@
>>  #define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_MASK	0x1
>>  #define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_EN	BIT(0)
>>
>> +#define PHY_CDR_LOCK_STATUS    0x5e
>
>This should be now renamed to match other defines here, so
>EXYNOS7_EMBEDDED_COMBO_PHY_CDR_LOCK_STATUS
>
Sure, will update in next version
>
>Best regards,
>Krzysztof

