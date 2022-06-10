Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7CF546497
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349220AbiFJKuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiFJKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:49:57 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1002F1F12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:46:15 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220610104613epoutp014be713d3629a17ff3d560978befedb36~3PI8z6HCC1532515325epoutp01i
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:46:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220610104613epoutp014be713d3629a17ff3d560978befedb36~3PI8z6HCC1532515325epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654857973;
        bh=JjjDoYLGWbu8TaEoBgHU4AXeYiA6gWqvTYFFiQAcED4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=VToqJY2FO8N06r7stmijYZKdNOpsRwHPslvk0dAH3uVBFRuX8WSJoFXdzsntvQXLR
         Fbsbb4EtZWPKkGQqW18m5Nt4Q0NUB7S7dz5y1vV4Mk81Lx5haQ541t1PjOk8RX2mgK
         oslK3/CuJ0rC0X/jot6bn6CrdrfXC9uUYA8zpanI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220610104613epcas5p40c0d10370a9c6548be4f0e8ee695e5ab~3PI8RmMub2603826038epcas5p4S;
        Fri, 10 Jun 2022 10:46:13 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LKHgk10l4z4x9Pt; Fri, 10 Jun
        2022 10:46:10 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.29.09827.1F023A26; Fri, 10 Jun 2022 19:46:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220610104609epcas5p2f39e6bf8473ead4122fd129eccc421fb~3PI4lfeiV1646416464epcas5p2w;
        Fri, 10 Jun 2022 10:46:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220610104609epsmtrp1185c380fc0f764e07dcffeae4cd74bc3~3PI4kezwE1449814498epsmtrp1c;
        Fri, 10 Jun 2022 10:46:09 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-43-62a320f186b1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.D0.11276.1F023A26; Fri, 10 Jun 2022 19:46:09 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220610104607epsmtip2fec9f076d771feaa91a2dd8cce9a6a4c~3PI2r0LIM1544115441epsmtip2J;
        Fri, 10 Jun 2022 10:46:07 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Chanho Park'" <chanho61.park@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Cc:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <martin.petersen@oracle.com>, <pankaj.dubey@samsung.com>,
        "'Bharat Uppal'" <bharat.uppal@samsung.com>
In-Reply-To: <004301d87ca5$296850e0$7c38f2a0$@samsung.com>
Subject: RE: [PATCH v3 6/6] ufs: host: ufs-exynos: add support for fsd ufs
 hci
Date:   Fri, 10 Jun 2022 16:16:06 +0530
Message-ID: <002c01d87cb7$4b443410$e1cc9c30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFtFf96RVHhaZQrIgSilU6FuDAtQI8yMISAWhEIA4CClCQEavAirhA
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmhu5HhcVJBp09NhYvf15ls7j28gK7
        xbQPP5ktLu/Xtph/5ByrRd+Lh8wWmx5fY7W4vGsOm8WEVd9YLLqv72CzWH78H5PFoq1f2C1a
        9x5ht9h55wSzA5/H5SveHptWdbJ53Lm2h81j85J6j49Pb7F49G1ZxejxeZOcR/uBbqYAjqhs
        m4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygq5UUyhJz
        SoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ2Rlf
        5/AV/OKr+Pp8LWMD4y+eLkZODgkBE4lDrxYydTFycQgJ7GaU2Lz2CxuE84lR4teVx1DON0aJ
        xUdnMcO03Dh8nB0isZdR4sjxfkYI5yWjxPlNMxhBqtgEdCV2LG4DaxcR2MUoMfttGzOIwyzQ
        ySTRfeQCE0gVp4CVxN8nIFWcHMICARLnv25j7WLk4GARUJVYezIFJMwrYCnxdN55dghbUOLk
        zCcsIDazgLbEsoWvoU5SkPj5dBkriC0i4CbxceJyqBpxiZdHj4CdKiHwhEPi2s4bUA0uEs+2
        /WGEsIUlXh3fwg5hS0m87G9jB7lBQsBDYtEfKYhwhsTb5euhyu0lDlyZwwJSwiygKbF+lz7E
        Kj6J3t9PmCA6eSU62oQgqlUlmt9dZYGwpSUmdnezwgw/cS5uAqPiLCR/zULy1ywk989C2LWA
        kWUVo2RqQXFuemqxaYFRXmo5PLqT83M3MYKTtJbXDsaHDz7oHWJk4mA8xCjBwawkwhtwe1GS
        EG9KYmVValF+fFFpTmrxIUZTYFhPZJYSTc4H5om8knhDE0sDEzMzMxNLYzNDJXFegf+NSUIC
        6YklqdmpqQWpRTB9TBycUg1MQlVPr637+Hu1aktQSJjmg+3fogqDo97JvtmacU/NoMmMYen+
        tdc74ie/ap46oXNWw9k78Vv9fV95PN3ymvvKjEkLWwsFuw7d3VsR2G9e4Gexzc5D8KtzgVFO
        SssKjh7v3T8UevU95t2YqXLx2YIHGg6q/M5nM/riPZaZ7jXs/5eTL75Q4vilT1osgY9WFspO
        6FjyMck/qyXRfN3ekCP6dyc+zr+19KqU5uu/xYct3c/W+ai+OjDr9b4lHJPun07duOjn75nm
        QsmLV4rd9Xy4Papf8s1U9Qee260XPg7t7Ljgt3dyJ3MBu+9ts5sHchs+Be9bfuXO4VltoeLS
        Gy9p2Hjs+/fxq4lOXmFhgHiOrRJLcUaioRZzUXEiAM25lHFbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSvO5HhcVJBuebeSxe/rzKZnHt5QV2
        i2kffjJbXN6vbTH/yDlWi74XD5ktNj2+xmpxedccNosJq76xWHRf38Fmsfz4PyaLRVu/sFu0
        7j3CbrHzzglmBz6Py1e8PTat6mTzuHNtD5vH5iX1Hh+f3mLx6NuyitHj8yY5j/YD3UwBHFFc
        NimpOZllqUX6dglcGd33bzIVbOGruND/lb2BcQtPFyMnh4SAicSNw8fZuxi5OIQEdjNKfDrw
        iwUiIS1xfeMEdghbWGLlv+dgtpDAc0aJbZP8QGw2AV2JHYvb2ECaRQT2MUqcfnGNBcRhFpjM
        JDGp4SsLxNi3jBL33l4EG8spYCXx9wlICyeHsICfxKn5LYxdjBwcLAKqEmtPpoCEeQUsJZ7O
        O88OYQtKnJz5BKyVWUBbovdhKyOMvWzha2aI6xQkfj5dxgpiiwi4SXycuByqXlzi5dEj7BMY
        hWchGTULyahZSEbNQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcLxqae5g
        3L7qg94hRiYOxkOMEhzMSiK8AbcXJQnxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2x
        JDU7NbUgtQgmy8TBKdXAFP+FJ0jf56z9WdmzR3Vf7O7bM18yaKZc3f7P/CUS7TMnBq34w250
        jOvOb+1lZunxs0O5aviUn8+YbPHTZanzkac/mI7xWlxKLZaYmR/9esbWcwfkDyvsWWhQLS67
        QZ31q6r/x5OnvpfqHn59eON2k6dvpwofOZYg+8K6W9zb83l3o7Uk39ZnmYm3uX7JNK99Y+T1
        7OHGFVtTfz9d9mbZWUPPqfcW6RfXOmoHRlwT/fh9l2XqxLmHXa1/RjwVduqeFrXpMBfXAw/r
        ixdvF7OYTOievO+Km1eXs+PaqRd0HVK/KT/2eDhTcr/oyklM1za/VwjZsOSMfPJhn69uBt++
        KOosZeMzV7QQFOPJudTSOlmJpTgj0VCLuag4EQDZq8w9RgMAAA==
X-CMS-MailID: 20220610104609epcas5p2f39e6bf8473ead4122fd129eccc421fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610073221epcas5p2307590d637c53e2a94b65b45a6fcb950
References: <20220610072924.12362-1-alim.akhtar@samsung.com>
        <CGME20220610073221epcas5p2307590d637c53e2a94b65b45a6fcb950@epcas5p2.samsung.com>
        <20220610072924.12362-7-alim.akhtar@samsung.com>
        <004301d87ca5$296850e0$7c38f2a0$@samsung.com>
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
>Sent: Friday, June 10, 2022 2:06 PM
>To: 'Alim Akhtar' <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org; linux-
>scsi=40vger.kernel.org; linux-phy=40lists.infradead.org
>Cc: devicetree=40vger.kernel.org; robh+dt=40kernel.org;
>krzysztof.kozlowski+dt=40linaro.org; vkoul=40kernel.org; avri.altman=40wdc=
.com;
>bvanassche=40acm.org; martin.petersen=40oracle.com;
>pankaj.dubey=40samsung.com; 'Bharat Uppal' <bharat.uppal=40samsung.com>
>Subject: RE: =5BPATCH v3 6/6=5D ufs: host: ufs-exynos: add support for fsd=
 ufs hci
>
>> Subject: =5BPATCH v3 6/6=5D ufs: host: ufs-exynos: add support for fsd u=
fs
>> hci
>>
>> Adds support of UFS HCI which is found in Tesla Full Self-Driving
>> (FSD) SoC.
>>
>> Signed-off-by: Bharat Uppal <bharat.uppal=40samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>> ---
>>  drivers/ufs/host/ufs-exynos.c =7C 140
>++++++++++++++++++++++++++++++++++
>>  drivers/ufs/host/ufs-exynos.h =7C   1 +
>>  2 files changed, 141 insertions(+)
>>
>> diff --git a/drivers/ufs/host/ufs-exynos.c
>> b/drivers/ufs/host/ufs-exynos.c index cc128aff8871..19068605d9fe
>> 100644
>> --- a/drivers/ufs/host/ufs-exynos.c
>> +++ b/drivers/ufs/host/ufs-exynos.c
>> =40=40 -146,6 +146,10 =40=40 enum =7B
>>  =23define UNIPRO_DME_PWR_REQ_REMOTEL2TIMER1	0x0A8
>>  =23define UNIPRO_DME_PWR_REQ_REMOTEL2TIMER2	0x0AC
>>
>> +=23define DME_POWERMODE_REQ_REMOTEL2TIMER0	0x78B8
>> +=23define DME_POWERMODE_REQ_REMOTEL2TIMER1	0x78BC
>> +=23define DME_POWERMODE_REQ_REMOTEL2TIMER2	0x78C0
>
>They look mismatch naming with previous definitions.
>UNIPRO_DME_POWERMODE_*
>
Ok noted.
Also previous definitions are not used, so I will send a separate patch to =
clean them up.

>Best Regards,
>Chanho Park


