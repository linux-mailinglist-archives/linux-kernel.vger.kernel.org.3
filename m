Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E5538D39
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244994AbiEaIur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244980AbiEaIug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:50:36 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367FA8CB3C
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:50:34 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220531085032epoutp01d5e45c155761f49bf8ba3bf1c4dab87c~0JHFZLAXJ0745407454epoutp01S
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:50:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220531085032epoutp01d5e45c155761f49bf8ba3bf1c4dab87c~0JHFZLAXJ0745407454epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653987032;
        bh=dENUkwJ77dOA6ob44lujk89EMrbDv9HEHz2yXDGcu0c=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=sb36yii/w3Wz0HBc0gBvbi19qtZsYHhfoxExh8noOJdmsfBOwnH620cvuIZach6CO
         +EZz/RJsu6KfahEUZAv+TJ1E7u2Dy+WuHYBbp1lUoHXTsCnR4VeVIwoRoQJDvchHcn
         Hx6ClAQKg38SB/2qftDbYakAq3TLTsBfJvdv36hs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220531085031epcas5p26a9a5127313a599b684f492103ac1af9~0JHEveFbG0834008340epcas5p2i;
        Tue, 31 May 2022 08:50:31 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LC5Zp66rZz4x9QH; Tue, 31 May
        2022 08:50:26 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.2B.09762.FC6D5926; Tue, 31 May 2022 17:50:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220531083221epcas5p2d9b86199751abcd01b7a5a3ddca72f22~0I3NXKf5u1512515125epcas5p2a;
        Tue, 31 May 2022 08:32:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220531083221epsmtrp2a15074ee4a65891c7a5135680dbe6f44~0I3NVTDNn1834018340epsmtrp2f;
        Tue, 31 May 2022 08:32:21 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-80-6295d6cf72f7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.78.08924.592D5926; Tue, 31 May 2022 17:32:21 +0900 (KST)
Received: from mshams02 (unknown [107.122.12.94]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220531083219epsmtip20a5a1b23b18708aae5ab4a3b1a184bc3~0I3LXCtH81041910419epsmtip2O;
        Tue, 31 May 2022 08:32:19 +0000 (GMT)
From:   "m.shams" <m.shams@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
Cc:     <geert@linux-m68k.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <paul@crapouillou.net>,
        <linux-fsd@tesla.com>
In-Reply-To: <d04b6d8c-0117-b5a6-dcb5-aa328ad5d1f5@linaro.org>
Subject: RE: [PATCH v2 3/3] arm64: dts: fsd: Add ADC device tree node
Date:   Tue, 31 May 2022 14:02:16 +0530
Message-ID: <015a01d874c8$f22cc090$d68641b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQIGNN21wa2G9ryxTCo9HfAX0Xxs4AK9h8+rAhaCLPACmk9UrKyhtLKw
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmpu75a1OTDKa38ls8mLeNzWL+kXOs
        Fs9u7WWyeNC0isni5ax7bBZ7X29lt1gyeT6rxabH11gtHr4Kt5h35B2LxeVdc9gsZpzfx2TR
        v/gSi0Xr3iPsDnweqy+1s3lsWtXJ5nHn2h42j0OHOxg9Ni+p91jy5hCrR9+WVYwe/5rmsnt8
        3iQXwBmVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD
        dLuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDI
        FKgwITtjTdt/9oIHnBUHzjazNDC2c3QxcnJICJhI3JrWy9jFyMUhJLCbUWJtxxtWCOcTo0TD
        i51sEM5nRon/H2czwbQcnnGfCSKxi1Gi/8dMqP5nQFXTdrJ3MXJwsAmoSuy4KQISFxGYzCix
        89t1FhCHWWASk8T6YxvAijgF7CR6T3iCTBUWcJVYfe8sI4jNAtT7avUPZhCbV8BSoqt9LRuE
        LShxcuYTFhCbWUBbYtnC18wQFylI/Hy6jBUiLi5x9GcPWFxEwE1i/tZz7CB7JQSecEjsnfGM
        DaLBReLs7GtQtrDEq+Nb2CFsKYnP7/ZCxdMl5j7shXq5QGLZru9QNfYSB67MYQG5n1lAU2L9
        Ln2IsKzE1FPrmCBu4JPo/f0EqpVXYsc8GFtR4v/ufqgx4hLvVkxhncCoNAvJa7OQvDYLyTuz
        ELYtYGRZxSiZWlCcm55abFpgnJdaDo/x5PzcTYzgtK3lvYPx0YMPeocYmTgYDzFKcDArifCW
        7JqaJMSbklhZlVqUH19UmpNafIjRFBjeE5mlRJPzgZkjryTe0MTSwMTMzMzE0tjMUEmcV+B/
        Y5KQQHpiSWp2ampBahFMHxMHp1QDk2Tg3TuR27OLv9uvM98y86f2BEXZTTHmrPfOeYQEt7VW
        6R541x8Z4re/mbOnTGt1fcyKpGcrTm3XCq9iYD8z+fzCUyuTpBMq55v/Dd/0ZeJpHiZHoZKE
        2BX34h/FOOlbt62xijN2dLq/da9Zq/O+IwFCD/dzx+ZsWC5Sd5tlTdfGxwL/P1i9zauadmfX
        6b0X9247ePuxVfbUM8+uvlbaJbunOOWHYfMj6QMSEpdvPrppcejCWot9C83dGlgU4l82H/bf
        9PT/iQe1SRlJGvEfpj7ydMyti//qFhyjx3ggfPOcPUyZvn/2VwYXHn0pcMHsg2+z8e0Pjn85
        rRfnCjWLs3dosWl8+iDXNvn2F/lth5VYijMSDbWYi4oTAShfbKRkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSvO7US1OTDD5uFbF4MG8bm8X8I+dY
        LZ7d2stk8aBpFZPFy1n32Cz2vt7KbrFk8nxWi02Pr7FaPHwVbjHvyDsWi8u75rBZzDi/j8mi
        f/ElFovWvUfYHfg8Vl9qZ/PYtKqTzePOtT1sHocOdzB6bF5S77HkzSFWj74tqxg9/jXNZff4
        vEkugDOKyyYlNSezLLVI3y6BK2P1jCuMBfs4K542v2RuYHzK3sXIySEhYCJxeMZ9pi5GLg4h
        gR2MEnefrmGFSIhLTPu1nxHCFpZY+e85O0TRE0aJcxd/AnVwcLAJqErsuCkCEhcRmM4o8Wv7
        IRYQh1lgDpPE6ZuPmCE6XjJKvH+2ihWkg1PATqL3hCfIVGEBV4nV986CbWABGvRq9Q9mEJtX
        wFKiq30tG4QtKHFy5hMWEJtZQFui92ErI4y9bOFrZojrFCR+Pl3GChEXlzj6swcsLiLgJjF/
        6zn2CYzCs5CMmoVk1Cwko2YhaV/AyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4
        drW0djDuWfVB7xAjEwfjIUYJDmYlEd6SXVOThHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZ
        LySQnliSmp2aWpBaBJNl4uCUamDqnOVYduZo9Xu5BVzVVvWab530vm/zO7DMvkX33qlKNeet
        56s/G9hP2XE4linvMMuXUuYA8VwNN+7qbZ2v395hl+mUcNDmWGPeytzF+23Hpfjw7dNqzeyK
        mQsKu8Ru9S9ete2F62mvp2LNT53ZQ6Z2yVz82r9r9h25PX7PdK5crNvS/tre6X4yE89/9sJk
        zSyHjOqQv1GKZya8rjmkeaVqTqPugp7Ch9pTo2RuNLVZVv5Jcb/waLOcdLjWKheWF/rh5TWP
        tJpFBXsUq7Q2aoevmLH/z51rn4Itqtzn+AdvzdCI95W5KH36+p9s3zaFt4np7+bPaf66VtVu
        T4jFY467aZENFyqXCLmH27l5KbEUZyQaajEXFScCAJOU+CZMAwAA
X-CMS-MailID: 20220531083221epcas5p2d9b86199751abcd01b7a5a3ddca72f22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520145804epcas5p2925e66d30b18378fc62c92999ec269f7
References: <20220520145820.67667-1-m.shams@samsung.com>
        <CGME20220520145804epcas5p2925e66d30b18378fc62c92999ec269f7@epcas5p2.samsung.com>
        <20220520145820.67667-4-m.shams@samsung.com>
        <d04b6d8c-0117-b5a6-dcb5-aa328ad5d1f5@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 20/05/2022 16:58, Tamseel Shams wrote:
>> From: Alim Akhtar <alim.akhtar=40samsung.com>
>>=20
>> This patch adds ADC device tree node and enables the same on fsd=20
>> platform.
>>=20
>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>> Signed-off-by: Tamseel Shams <m.shams=40samsung.com>
>> ---
>> - Changes since v1
>> * Addressed Krzysztof's comment for corrections in dt files
>>=20
>>  arch/arm64/boot/dts/tesla/fsd-evb.dts =7C  4 ++++
>>  arch/arm64/boot/dts/tesla/fsd.dtsi    =7C 11 +++++++++++
>>  2 files changed, 15 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts=20
>> b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>> index 5af560c1b5e6..63f26a85053a 100644
>> --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
>> +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>> =40=40 -34,6 +34,10 =40=40
>>  	clock-frequency =3D <24000000>;
>>  =7D;
>> =20
>> +&adc =7B
>> +	status =3D =22okay=22;
>
> Please test your bindings (=60make dtbs_check=60). There is no way it pas=
ses since you miss at least supply (maybe more?).

Will add the =22supply=22 field in dtsi file. Also will run dtbs check to s=
ee for any other missing field.


Thanks & Regards,
Tamseel Shams

