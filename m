Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81944494F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbiATNys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:54:48 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:18494 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241731AbiATNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:53:56 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220120135352epoutp04cda17695a5d36a88de41f4ec8be5165f~L-vh_kMFt0930909309epoutp04P
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:53:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220120135352epoutp04cda17695a5d36a88de41f4ec8be5165f~L-vh_kMFt0930909309epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642686832;
        bh=KcyGdBpSaKaQSjJ7fDTMhH5pkAuLFaMd8lCusKp395U=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=RdtCAT9LilWezt+DMDOBBU6Oqe6R6wFxO3gK79Ty1BTW8RmyzO/ttoqd21NODX3pn
         KnFGiopyk9WuGgiWX4TqVO3LVxJtSify/zmsEYkwysqjW9Yey9Exxpzfl+IUTES3EU
         UD0Wq+4ZYLCIdQtGBv/pS0nbGEz8sdJMRsKOXdFY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220120135351epcas5p462e91cb86b07474e96a2ad8a52a56699~L-vhSAwHb2046820468epcas5p4I;
        Thu, 20 Jan 2022 13:53:51 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JfkWD3YhMz4x9Q3; Thu, 20 Jan
        2022 13:53:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.19.06423.16969E16; Thu, 20 Jan 2022 22:53:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220120135336epcas5p21de42bca056514ee41e99a2e381be469~L-vThugtQ0641106411epcas5p2F;
        Thu, 20 Jan 2022 13:53:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220120135336epsmtrp26e656074511da4279d1b3ff0ad2cbdf3~L-vTguOai0495704957epsmtrp2E;
        Thu, 20 Jan 2022 13:53:36 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-17-61e96961f8cb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.CB.08738.06969E16; Thu, 20 Jan 2022 22:53:36 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220120135333epsmtip17a8e4ddd413a1619f009d90ce7bd0764~L-vQVb5dL2897428974epsmtip1W;
        Thu, 20 Jan 2022 13:53:33 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Stephen Boyd'" <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <s.nawrocki@samsung.com>, <linux-samsung-soc@vger.kernel.org>,
        <pankaj.dubey@samsung.com>, <linux-fsd@tesla.com>,
        "'Jayati Sahu'" <jayati.sahu@samsung.com>,
        "'Ajay Kumar'" <ajaykumar.rs@samsung.com>
In-Reply-To: <20220119201509.6220FC004E1@smtp.kernel.org>
Subject: RE: [PATCH v2 04/16] clk: samsung: fsd: Add initial clock support
Date:   Thu, 20 Jan 2022 19:23:31 +0530
Message-ID: <016c01d80e05$1ef9eab0$5cedc010$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJMmkM0C21BpYmk5XGVS3CIVixL0wHiE8L7AdsaVJIB7iMiVatVehWw
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmpm5i5stEgzevOCwOvD/IYvF30jF2
        i/fLehgt5h85x2px5NQSJouNb38wWUz5s5zJYtPja6wWH3vusVo8fBVucXnXHDaLGef3MVmc
        uv6ZzWLR1i/sFq17j7BbHH7Tzmrx79pGFovH1/+wOQh5rJm3htHj969JjB6zGnrZPDat6mTz
        uHNtD5vH5iX1HldONLF69G1Zxejxr2kuu8fnTXIBXFHZNhmpiSmpRQqpecn5KZl56bZK3sHx
        zvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlATykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otL
        bJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjPuXXjKWLCbr+LE3YusDYyLeLoYOTgk
        BEwk3q5X62Lk4hAS2M0osXbVNVYI5xOjxNmuPewQzmdGiUvvHrF1MXKCdfROvQlVtYtRomdh
        NwuE85JRYsX9FiaQKjYBXYkdi9vAOkQECiUOL/oBVsQssINZYuXzaYwgCU4BS4mmx1PBGoQF
        vCRaD20As1kEVCV6/21lAbF5gWpObfzNDGELSpyc+QQsziygLbFs4WtmiJMUJH4+XcYKscxN
        Yv2lP0wQNeISL48eAftBQqCZU2L5nQ4miAYXifl9PVDNwhKvjm9hh7ClJD6/28sGCZlsiZ5d
        xhDhGoml846xQNj2EgeuzGEBKWEW0JRYv0sfYhWfRO/vJ0wQnbwSHW1CENWqEs3vrkJ1SktM
        7O5mhbA9JFYdf84+gVFxFpLHZiF5bBaSB2YhLFvAyLKKUTK1oDg3PbXYtMAwL7UcHt/J+bmb
        GMFJXstzB+PdBx/0DjEycTAeYpTgYFYS4ZWqf5YoxJuSWFmVWpQfX1Sak1p8iNEUGNoTmaVE
        k/OBeSavJN7QxNLAxMzMzMTS2MxQSZz3dPqGRCGB9MSS1OzU1ILUIpg+Jg5OqQYmq4TYg87P
        nI3Kq0yWfP7k5RU7908S61ojU5Ywu0VeGfNKC7kFDn9axvYouN094v/U25WL1POm8cwz1RdX
        ntBcP3lXnN8v4WPT3SVKVT8tOBCncH+nVoPZZvbLsVc4VgWGheTN2DE9edIlZ95992bWLk+9
        N3faZjErjr6rMvYLLVVvLRVIXfZlXVNu/bZ1C7/oPDV9d0TBxnRFrYjw11M+UV4mDMvfndF/
        fvBQ+ulfJafKp2b7nJm2J2LTNe378cnFZT7BzrzWVzzfvRD7FaN703i1FOPLhxLLJeRvtL46
        vSPh4o1FFp3OqnFPxDff6Ep7/ok7SiAj8pC+2dkDC3S3zV+2cvp6Ts0JX7InnkvoUGIpzkg0
        1GIuKk4EAHtSQHt7BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCSnG5C5stEg8VHNC0OvD/IYvF30jF2
        i/fLehgt5h85x2px5NQSJouNb38wWUz5s5zJYtPja6wWH3vusVo8fBVucXnXHDaLGef3MVmc
        uv6ZzWLR1i/sFq17j7BbHH7Tzmrx79pGFovH1/+wOQh5rJm3htHj969JjB6zGnrZPDat6mTz
        uHNtD5vH5iX1HldONLF69G1Zxejxr2kuu8fnTXIBXFFcNimpOZllqUX6dglcGcuXzmEs+M5b
        ceXyMeYGxnvcXYycHBICJhK9U2+ydjFycQgJ7GCU2Nq/gwUiIS1xfeMEdghbWGLlv+fsEEXP
        GSU+LHjKBpJgE9CV2LG4DcwWESiWWNH2F6yIWeAEs8S8GZsYITreMEqsPnOJGaSKU8BSounx
        VCYQW1jAS6L10AYwm0VAVaL331aw1bxANac2/maGsAUlTs58AhZnFtCWeHrzKZy9bOFrZojz
        FCR+Pl3GCnGFm8T6S3+YIGrEJV4ePcI+gVF4FpJRs5CMmoVk1CwkLQsYWVYxSqYWFOem5xYb
        FhjlpZbrFSfmFpfmpesl5+duYgTHu5bWDsY9qz7oHWJk4mA8xCjBwawkwitV/yxRiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqbNvYxT7SZI+SeXrz3b
        JX/IP+5thDXfvzBB6QWxRXdTt77/e2jDdvPElpz3ASLR3mJPdB9ZKV5W1mecJGXVIMl7aovy
        Yc0SmciMDUoTXzDftNArvhMyvVRSac0FUZnbTjNy3mxZekRna4L0ocUimRdZU6UFWb9ZV/yR
        uXi2eWqzbJ575psNOzl3cGuvv1Vwx90t236/1R0LR8FVFrFt77OOlydV6JfMTn61ZfVG6SXX
        9P69vK5Z99V14r1Tl/r2uJ1s2fxNUle6QtzmoOnRCzpr5GM85vh4vRUomFNxzZGneHeX6e87
        Vp6JnFvn34jzvvv8obWf/0FfrRdS4s5S5omFCVYP7u+4cSi9jzfyrhJLcUaioRZzUXEiAEc8
        c/RmAwAA
X-CMS-MailID: 20220120135336epcas5p21de42bca056514ee41e99a2e381be469
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150028epcas5p282c05b78f28a9b11d46da94e78330f0c
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150028epcas5p282c05b78f28a9b11d46da94e78330f0c@epcas5p2.samsung.com>
        <20220118144851.69537-5-alim.akhtar@samsung.com>
        <20220119201509.6220FC004E1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen

>-----Original Message-----
>From: Stephen Boyd =5Bmailto:sboyd=40kernel.org=5D
>Sent: Thursday, January 20, 2022 1:45 AM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: soc=40kernel.org; linux-clk=40vger.kernel.org; devicetree=40vger.kerne=
l.org;
>olof=40lixom.net; arnd=40arndb.de; linus.walleij=40linaro.org;
>catalin.marinas=40arm.com; robh+dt=40kernel.org;
>krzysztof.kozlowski=40canonical.com; s.nawrocki=40samsung.com; linux-
>samsung-soc=40vger.kernel.org; pankaj.dubey=40samsung.com; Alim Akhtar
><alim.akhtar=40samsung.com>; linux-fsd=40tesla.com; Jayati Sahu
><jayati.sahu=40samsung.com>; Ajay Kumar <ajaykumar.rs=40samsung.com>
>Subject: Re: =5BPATCH v2 04/16=5D clk: samsung: fsd: Add initial clock sup=
port
>
>Quoting Alim Akhtar (2022-01-18 06:48:39)
>> diff --git a/drivers/clk/samsung/clk-fsd.c
>> b/drivers/clk/samsung/clk-fsd.c new file mode 100644 index
>> 000000000000..2669396d81b9
>> --- /dev/null
>> +++ b/drivers/clk/samsung/clk-fsd.c
>> =40=40 -0,0 +1,308 =40=40
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2017-2022 Samsung Electronics Co., Ltd.
>> + *             https://www.samsung.com
>> + * Copyright (c) 2017-2022 Tesla, Inc.
>> + *             https://www.tesla.com
>> + *
>> + * Common Clock Framework support for FSD SoC.
>> + */
>> +
>> +=23include <linux/clk-provider.h>
>> +=23include <linux/of.h>
>
>include init.h for __initconst and kernel.h for ARRAY_SIZE
>
I did not face any compilation error.
Do I need to explicitly add these header files in driver? I see clk.h impli=
citly includes kernel.h
Same is the case of other driver in this directory.

>> +
>> +=23include <dt-bindings/clock/fsd-clk.h>
>> +
>> +=23include =22clk.h=22
>> +

