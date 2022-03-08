Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2134D16F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346709AbiCHMM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346716AbiCHMMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:12:52 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326343ED22
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:11:55 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220308121153epoutp025fe373dd41aa5e14133884938e56123c~aZq6O3LQJ2134821348epoutp02X
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:11:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220308121153epoutp025fe373dd41aa5e14133884938e56123c~aZq6O3LQJ2134821348epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646741513;
        bh=nbpUiPJb6DAB35cqz3m0Iso2I5r9whjfQKQ36UphvM4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ODn8ESy4BhkAsgJkLxX5udXfbAbpRvkiadUQX0XPtd1qg1dyfgZ0wlmAan/nDc1Of
         kQAiZD9B2iD2cyiUyqUJhBhzEGihj47540JHCuom7NJkuqjZTyswmtQ4Pd/5OTb80h
         a9rCrXxEFdPIQJUuVCBifUDFsZxmcvdSWX75JnHQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220308121152epcas5p382b2493083563f7570bdf116c457fa2c~aZq5T9r6P2162121621epcas5p3p;
        Tue,  8 Mar 2022 12:11:52 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KCZ1v5gJpz4x9Q1; Tue,  8 Mar
        2022 12:11:47 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.92.06423.1F747226; Tue,  8 Mar 2022 21:11:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220308121129epcas5p3d75125bb41b8a1dff64aaf3a5e39233c~aZqjuVJ-A1148011480epcas5p3y;
        Tue,  8 Mar 2022 12:11:29 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220308121129epsmtrp172f5ed8d3668975f9cfaf3c7bf8ac186~aZqjthJwS0976509765epsmtrp13;
        Tue,  8 Mar 2022 12:11:29 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-64-622747f17b1d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.F0.03370.1F747226; Tue,  8 Mar 2022 21:11:29 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220308121127epsmtip1e9e971685fe88f2fbdad4bc95a12be13~aZqiCxuKO1793517935epsmtip1N;
        Tue,  8 Mar 2022 12:11:27 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Mark Brown'" <broonie@kernel.org>,
        "'Lee Jones'" <lee.jones@linaro.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <andi@etezian.org>, <linux-spi@vger.kernel.org>
In-Reply-To: <YfABHDjdTgxytcUY@sirena.org.uk>
Subject: RE: [PATCH v3 0/3] Add FSD SPI support
Date:   Tue, 8 Mar 2022 17:41:26 +0530
Message-ID: <00ec01d832e5$a44f7540$ecee5fc0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJV3yAl5ku9A9ijKFdi1q5JHbSM/QF8HCEnAbm4M2OroF1WYA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmlu5Hd/Ukg59zzSwW/3jOZDH14RM2
        i/lHzrFabHz7g8ni/tejjBZT/ixnstj0+BqrxeVdc9gsZpzfx2TR+PEmu8WirV/YLVr3HmF3
        4PGY1dDL5nF9ySdmj02rOtk87lzbw+axeUm9R9+WVYwenzfJBbBHZdtkpCampBYppOYl56dk
        5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAB2qpFCWmFMKFApILC5W0rezKcov
        LUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOWLJnM2vBYt6K9x9mMTYw
        bubuYuTkkBAwkdh2+ykbiC0ksJtR4u8agy5GLiD7E6PEzT1/WSGcz4wSu/vOscB0HPuwmR0i
        sYtR4vvsc1BVLxklzt37zwpSxSagK7FjcRvYXBEBf4mDuyeygBQxC+xkkti17QY7SIITqOj0
        tgdgtrCAvsSKN5vBGlgEVCQ2dJ9gArF5BSwlTjTcY4OwBSVOznwCdgazgLzE9rdzmCFOUpD4
        +XQZK8QyJ4mt755B1YhLvDx6BOxUCYEzHBIbDm5kg2hwkVi76RpUs7DEq+Nb2CFsKYmX/W1A
        NgeQnS3Rs8sYIlwjsXTeMaj37SUOXJnDAlLCLKApsX6XPsQqPone30+YIDp5JTrahCCqVSWa
        312F6pSWmNjdzQphe0hs6vvEPoFRcRaSx2YheWwWkgdmISxbwMiyilEytaA4Nz212LTAMC+1
        HB7fyfm5mxjByVjLcwfj3Qcf9A4xMnEwHmKU4GBWEuG9f14lSYg3JbGyKrUoP76oNCe1+BCj
        KTC0JzJLiSbnA/NBXkm8oYmlgYmZmZmJpbGZoZI47+n0DYlCAumJJanZqakFqUUwfUwcnFIN
        TLMCTzgE+uWEBJdpM2o0WT4R33fKj33eD0GXkns1f89v6laIO2biXvr2zDffLT9O3Uq8ffOx
        f/P6rSmbCuvvimkd1KjrOdLJc51lXm3UpYPfPPyUWxbHcD3cs9BwduYXc8vM/8kGybta2iW2
        zmfexMZzxKlHYoJJcRlzxTTX5ulCv4pOcG3Uye2t4v6qlLVg56r4r6c2rPT8vuv9+2nnZyea
        ab/cw34pYkNTnrCC7aygR00Jp2NOzoy12e9zlDvx48odH1vWSwv+fC+UH7h42tppLOu4l7pP
        FONIb34/79WGP7s5F8fsUOhfeXrRH++Ncn4NAlf7VJi8I9deK/J0N5NNn7ekfXa8RmGUg7hj
        oRJLcUaioRZzUXEiADlKaWlPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSnO5Hd/Ukg/UPJCwW/3jOZDH14RM2
        i/lHzrFabHz7g8ni/tejjBZT/ixnstj0+BqrxeVdc9gsZpzfx2TR+PEmu8WirV/YLVr3HmF3
        4PGY1dDL5nF9ySdmj02rOtk87lzbw+axeUm9R9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGUs
        2bOZtWAxb8X7D7MYGxg3c3cxcnJICJhIHPuwmb2LkYtDSGAHo8S8bfvYIRLSEtc3ToCyhSVW
        /nsOVfScUeL2/6NMIAk2AV2JHYvb2EBsEQF/ia//u1lBipgFDjNJ7GjbwgKSEBJYzyix6b8u
        iM0J1HB62wOwqcIC+hIr3mwGa2YRUJHY0H0CbCivgKXEiYZ7bBC2oMTJmU+A5nAADdWTaNvI
        CBJmFpCX2P52DjPEcQoSP58uY4W4wUli67tnLBA14hIvjx5hn8AoPAvJpFkIk2YhmTQLSccC
        RpZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBEamltYNxz6oPeocYmTgYDzFKcDAr
        ifDeP6+SJMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOT
        P0uo0eKPXRL7JXds2dxRU3aosn/LGSOxgL1n7M5GMGX/2rBD8AV3a2Fz56vsmoX8t+R3qb+y
        W7pi1gLHZV91jUWXs3hNVexcG8+lsCIj9Fezt9YEp/i4KyYreBaW/2/z+dfP+l6nNmPrHKnm
        J5utFNm35M+ZPKmhSvqp4GZWS/7bdS49bTYbmibG8ds7cVw8MWXexOON05MLyr09bpUaHFky
        X0GtOJSV0XY5n6Oz0o2vq5yl3z6f6LM3dWbWjGRp02LObZvvzyhV1t4svlLqVMnpqUvErBT/
        V566XPjkjsdzpY5ZCTkqctPDXA6kbT2TeWdKT87J3O2xnPpud1bw7hd9MnF618qDzvsDvCYq
        sRRnJBpqMRcVJwIAJYYXkjcDAAA=
X-CMS-MailID: 20220308121129epcas5p3d75125bb41b8a1dff64aaf3a5e39233c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220125032811epcas5p3ef7b2f4e4906c1da8ccb4a0b3ed9a591
References: <CGME20220125032811epcas5p3ef7b2f4e4906c1da8ccb4a0b3ed9a591@epcas5p3.samsung.com>
        <20220125031604.76009-1-alim.akhtar@samsung.com>
        <YfABHDjdTgxytcUY@sirena.org.uk>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark and Lee Jones

>-----Original Message-----
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Tuesday, January 25, 2022 7:25 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>
>Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>devicetree@vger.kernel.org; linus.walleij@linaro.org; robh+dt@kernel.org;
>krzysztof.kozlowski@canonical.com; linux-samsung-soc@vger.kernel.org;
>pankaj.dubey@samsung.com; andi@etezian.org; linux-spi@vger.kernel.org
>Subject: Re: [PATCH v3 0/3] Add FSD SPI support
>
>On Tue, Jan 25, 2022 at 08:46:01AM +0530, Alim Akhtar wrote:
>
>> Note: This series is depended on [1] patches which adds support of FSD
>> SoC and on Krzysztof's v6 [2] of spi schema changes
>>
>> [1]
>> https://protect2.fireeye.com/v1/url?k=43e76061-1c7c5970-43e6eb2e-0cc47
>> a31cdbc-d2d9ba5a4358198f&q=1&e=9e61db9b-cfb7-4110-a13c-
>a1cb0d92a251&u=
>> https%3A%2F%2Flkml.org%2Flkml%2F2022%2F1%2F24%2F583
>> [2]
>> https://protect2.fireeye.com/v1/url?k=e2ddfc2b-bd46c53a-e2dc7764-0cc47
>> a31cdbc-0d6dbb90b0110bab&q=1&e=9e61db9b-cfb7-4110-a13c-
>a1cb0d92a251&u=
>> https%3A%2F%2Flkml.org%2Flkml%2F2022%2F1%2F24%2F120
>
>Please resend this when it can be applied, either wait until the
dependencies
>are in place or rebase on top of current code.  In general only build time
>dependencies matter here, the SoC support being merged shouldn't be an
>issue one way or another.

I re-send these patches (couple of them) as I see the dependencies has
landed into MFD tree.
Because of the immutable branch between MFD, SPI and DT due to the current
merge window, I assume this will go via MFD tree. Let me know if any
concerns. 
Thanks!


