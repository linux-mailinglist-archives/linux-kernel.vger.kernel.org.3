Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1FF48EED8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbiANQ6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:58:14 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:39045 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243655AbiANQ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:58:13 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220114165811epoutp016dad2664246f4d5475f9170fbc5770d6~KMYv2NUGp2812828128epoutp01L
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 16:58:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220114165811epoutp016dad2664246f4d5475f9170fbc5770d6~KMYv2NUGp2812828128epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642179491;
        bh=/Pa8V098NQHu/pPw1lg08g25sOvkKcLx8S/haikOGJc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=FBKPzJ+MWg9HBsT89vlRjPcRqqaoFnsHcbz/q6SwJWK7EmMjiNwe+mtcrc6MJItqR
         zl91OXk/y36RwI7pvBVR04w9zp+XNZHm0IhTqI2dXWsQIio9Vr2yuHQeyKo4zkpN1K
         nF3Bt06NNH1uHBCecQZnBrOstWV+NBwclLaKPQKo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220114165810epcas5p433d1e407446ec72676bc1b035a7a18fd~KMYvKH-Xc0805708057epcas5p49;
        Fri, 14 Jan 2022 16:58:10 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Jb6th5T7yz4x9Pw; Fri, 14 Jan
        2022 16:58:04 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.DA.46822.C9BA1E16; Sat, 15 Jan 2022 01:58:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220114165803epcas5p2d582017737d5522418b6f76b20ff4d8d~KMYoncM8c2354923549epcas5p2t;
        Fri, 14 Jan 2022 16:58:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220114165803epsmtrp13a7af53afbeec3f2e4c01ac9c288b54a~KMYomRI3Q2534425344epsmtrp19;
        Fri, 14 Jan 2022 16:58:03 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-65-61e1ab9cc7fe
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.34.29871.B9BA1E16; Sat, 15 Jan 2022 01:58:03 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220114165800epsmtip1080e53a6de0852ff8e2f634fb7a19751~KMYmNb15Y1965719657epsmtip1P;
        Fri, 14 Jan 2022 16:58:00 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>
In-Reply-To: <53c17ddc-a049-72ed-7237-de23db7889da@canonical.com>
Subject: RE: [PATCH 13/23] dt-bindings: arm: add Tesla FSD ARM SoC
Date:   Fri, 14 Jan 2022 22:27:59 +0530
Message-ID: <085801d80967$e4b8fe00$ae2afa00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgIR+KN8AmyCbh0CxU8U/6p8QXZQ
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAJsWRmVeSWpSXmKPExsWy7bCmuu6c1Q8TDS7eVrV4v6yH0WL+kXOs
        Fhvf/mCymPJnOZPFpsfXWC0+9txjtXj4Ktzi8q45bBYzzu9jsjh1/TObxaKtX9gtWvceYbc4
        /Kad1eLx9T9sDnwea+atYfSY1dDL5rFpVSebx51re9g8Ni+p97hyoonVo2/LKkaPf01z2T0+
        b5IL4IzKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB
        ul1JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBk
        ClSYkJ1xbsYTloJPwhXTjx1nbmBsEuxi5OSQEDCR+NK1ibWLkYtDSGA3o8TJn70sEM4nRonn
        L18yQzjfGCUWL1vPAtNy7sQ/qKq9jBKdrR3sIAkhgZeMEo3vwkBsNgFdiR2L29hAikQEOhkl
        Vn//yQTiMAusYJKYf+ou2ChOAUeJ2U2PmEBsYQEnib83z7GC2CwCqhIHvz8Aq+EVsJRY19XG
        DmELSpyc+QQsziygLbFs4WtmiJMUJH4+XQbWKyLgJtH/p4EVokZc4uXRI+wgiyUEXnBI3P3S
        yArR4CLx6N06JghbWOLV8S3sELaUxMt+kGUcQHa2RM8uY4hwjcTSeceg3reXOHBlDgtICbOA
        psT6XfoQq/gken8/YYLo5JXoaBOCqFaVaH53FapTWmJidzfUAR4Sr578Zp3AqDgLyWOzkDw2
        C8kDsxCWLWBkWcUomVpQnJueWmxaYJSXWg6P8OT83E2M4KSt5bWD8eGDD3qHGJk4GA8xSnAw
        K4nw9hfdTxTiTUmsrEotyo8vKs1JLT7EaAoM7YnMUqLJ+cC8kVcSb2hiaWBiZmZmYmlsZqgk
        zns6fUOikEB6YklqdmpqQWoRTB8TB6dUA9Ocx3pte7byrE6L913Ltl7noYD/4R8vr5xfuUFl
        3Te7lX11kgp225e8W1PCfsOnL+b2h5/yvn4T5B8kLomNKyxyDmVcMOdtKlPxnK3397o8WTCh
        e8VP1+Rn/x+VJArMLAyTKLH8l989jbe17o/yUeUpnhbdbsfY2+7/mOGpHc0tze+repDhh8lm
        Cb1N5zKvi33KeHLOsXzN/nCGZilZh4k3N79LcCiaFXpjh7KGG/+q4wVPnN5v51FqZ5ka7bQi
        95/o2ema4e/5yxojP319vLVp+XcXhZw/WtKL1Rr8jf7NkTqY8FxG+WtEctoLToNOCb6bDvuW
        XXdmn2ieV9223/NAspBExL5Dby45t6QE3lZiKc5INNRiLipOBACKGZ6iYwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSnO7s1Q8TDS7dl7Z4v6yH0WL+kXOs
        Fhvf/mCymPJnOZPFpsfXWC0+9txjtXj4Ktzi8q45bBYzzu9jsjh1/TObxaKtX9gtWvceYbc4
        /Kad1eLx9T9sDnwea+atYfSY1dDL5rFpVSebx51re9g8Ni+p97hyoonVo2/LKkaPf01z2T0+
        b5IL4IzisklJzcksSy3St0vgyng2M79gh3DFjt1rWRoYjwh0MXJySAiYSJw78Y+li5GLQ0hg
        N6PEjlO72SAS0hLXN05gh7CFJVb+e84OUfScUWLxqr1MIAk2AV2JHYvb2EASIgLdjBJXemYy
        gjjMAluYJDpfnGGGaPnKKPFgTzszSAungKPE7KZHYO3CAk4Sf2+eYwWxWQRUJQ5+f8ACYvMK
        WEqs62pjh7AFJU7OfAIWZxbQluh92MoIYy9b+JoZ4j4FiZ9Pl4HNERFwk+j/08AKUSMu8fLo
        EfYJjMKzkIyahWTULCSjZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzh6
        tTR3MG5f9UHvECMTB+MhRgkOZiUR3v6i+4lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwX
        EkhPLEnNTk0tSC2CyTJxcEo1MIX03lHlCrq61UVmmdzjy00b9vXt2hXaZLJoX8bs7IZF97nX
        q/0yDn7KtE/y8YrLHN9XLyi4En8wtXIau/T0I5JN8ZnJ3ftDFF/Pub9Kvn7Lqj1v3xZfNTc3
        Oei84tcRxr0L+lLfM8b2fNrAk6Z6TbTGqnLbVa8L2hs7zA9razrf8Jgxn/n5gmuMlxdmVq+/
        cf9WGMOlQwsZrLbMEy+4/0f/htVxFq4fwns2LxCZ33FTucvkXueBWXPn7ufvNIzkzpf8ar3h
        bF7X5Leccm/+2n56VJDpbbl1OYdLudX0mb/Ov/59V7bgVYfC3XV5/Cc9Py1olvLcnhGc91Zz
        YZG3guDjWRc2M8pfZPdkO6DMfO+QEktxRqKhFnNRcSIA/Gg1/E0DAAA=
X-CMS-MailID: 20220114165803epcas5p2d582017737d5522418b6f76b20ff4d8d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122408epcas5p45053d1bf0acf2d8233a98b6c1abab6eb
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122408epcas5p45053d1bf0acf2d8233a98b6c1abab6eb@epcas5p4.samsung.com>
        <20220113121143.22280-14-alim.akhtar@samsung.com>
        <53c17ddc-a049-72ed-7237-de23db7889da@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Thursday, January 13, 2022 6:03 PM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: soc=40kernel.org; linux-clk=40vger.kernel.org; devicetree=40vger.kerne=
l.org;
>olof=40lixom.net; linus.walleij=40linaro.org; catalin.marinas=40arm.com;
>robh+dt=40kernel.org; s.nawrocki=40samsung.com; linux-samsung-
>soc=40vger.kernel.org; pankaj.dubey=40samsung.com; linux-fsd=40tesla.com
>Subject: Re: =5BPATCH 13/23=5D dt-bindings: arm: add Tesla FSD ARM SoC
>
>On 13/01/2022 13:11, Alim Akhtar wrote:
>> Add device tree bindings for the Tesla FSD ARM SoC.
>>
>> Cc: linux-fsd=40tesla.com
>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>> ---
>>  .../devicetree/bindings/arm/tesla.yaml        =7C 25 ++++++++++++++++++=
+
>>  1 file changed, 25 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/tesla.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tesla.yaml
>> b/Documentation/devicetree/bindings/arm/tesla.yaml
>> new file mode 100644
>> index 000000000000..9f89cde76c85
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/tesla.yaml
>> =40=40 -0,0 +1,25 =40=40
>> +=23 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
>> +---
>> +=24id:
>> +https://protect2.fireeye.com/v1/url?k=3D2f0fac44-70949546-2f0e270b-0cc4
>> +7a312ab0-50c826f7b1999a5f&q=3D1&e=3Dbcbf277f-4e93-4705-8f6a-
>2beaa7eb31e2&
>> +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Farm%2Ftesla.yaml%23
>> +=24schema:
>> +https://protect2.fireeye.com/v1/url?k=3Dd8493fe2-87d206e0-d848b4ad-0cc4
>> +7a312ab0-f4e5046adc7da972&q=3D1&e=3Dbcbf277f-4e93-4705-8f6a-
>2beaa7eb31e2&
>> +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>> +
>> +title: Tesla Full Self Driving(FSD) platforms device tree bindings
>> +
>> +maintainers:
>> +  - Alim Akhtar <alim.akhtar=40samsung.com>
>> +  - linux-fsd=40tesla.com
>> +
>> +properties:
>> +  =24nodename:
>> +    const: '/'
>> +  compatible:
>> +    oneOf:
>> +
>> +      - description: FSD SoC board
>> +        items:
>> +          - const: tesla,fsd
>
>Either this is a SoC or a board compatible... Cannot be both.
>
Actually we call this as fsd board, so let me add accordingly compatible (f=
sd-baord) for board.
Thanks
>> +
>> +additionalProperties: true
>> +
>> +...
>>
>
>
>Best regards,
>Krzysztof

