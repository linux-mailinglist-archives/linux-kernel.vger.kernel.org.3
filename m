Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14AB53C2B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242247AbiFCBVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242618AbiFCBUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:20:32 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFABB3B2B5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 18:20:28 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220603012026epoutp030df69c872dd7c243215c7494fe18dab5~09589ofz31347113471epoutp03f
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 01:20:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220603012026epoutp030df69c872dd7c243215c7494fe18dab5~09589ofz31347113471epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654219226;
        bh=OlGafxioBWPpmv2XvGx7UEtLeu872g/B/PGHZaTWFu4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=nhIhyzHFifLcdvjE5j0A6mgSz4MfJztf5LWCWOZUHh4d/hyvhsFIZQGQplqkR5Sf2
         LrrMpU3jd6SBB4xkl8qlythy0KVuE1z/v4IB7P1PIfhEZDTP4pBtWrNOmyOTeDktIi
         m7ooOntiyCGmYGWtxwjrTplgwW1bx/NIkbBE4ifU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220603012025epcas5p185f04a84e9e38e23f0966dfa9250461e~0958cfg4v1445014450epcas5p1p;
        Fri,  3 Jun 2022 01:20:25 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LDlS71HTrz4x9Q7; Fri,  3 Jun
        2022 01:20:23 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.66.10063.7D169926; Fri,  3 Jun 2022 10:20:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220603012022epcas5p1cb88b549bf569608b631f526730043df~0955ZWK7-1444914449epcas5p1f;
        Fri,  3 Jun 2022 01:20:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220603012022epsmtrp2c2ad1b7cb25b0f7bd9968ef0e0eb6859~0955X-ZPQ1215912159epsmtrp27;
        Fri,  3 Jun 2022 01:20:22 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-b8-629961d7c5b8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.7E.11276.6D169926; Fri,  3 Jun 2022 10:20:22 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220603012020epsmtip202e2263aa8523ad5f21a558e4c2eac31~0953SA6lZ0464904649epsmtip2C;
        Fri,  3 Jun 2022 01:20:20 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Bart Van Assche'" <bvanassche@acm.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Cc:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <avri.altman@wdc.com>, <martin.petersen@oracle.com>,
        <chanho61.park@samsung.com>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, "'Bharat Uppal'" <bharat.uppal@samsung.com>
In-Reply-To: <8be31be0-8766-061c-2544-25e296048528@acm.org>
Subject: RE: [PATCH 1/6] dt-bindings: phy: Add FSD UFS PHY bindings
Date:   Fri, 3 Jun 2022 06:50:18 +0530
Message-ID: <000001d876e8$18957d50$49c077f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEGJiXAXdobboEKZTBkhZkj5AOCHwEV9a8PAbDHaMoB6uoGq6679h+A
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmlu71xJlJBvs/s1q8/HmVzeLaywvs
        FtM+/GS2uLxf22L+kXOsFn0vHjJbbHp8jdXi4atwi8u75rBZTFj1jcWi+/oONovlx/8xWSza
        +oXdonXvEXaLnXdOMDvwe1y+4u2xaVUnm8eda3vYPDYvqff4+PQWi0ffllWMHv+a5rJ7fN4k
        59F+oJspgDMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DX
        LTMH6HwlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWh
        gYGRKVBhQnbG5pULGQvmsFe8/OnTwLiErYuRg0NCwESiaatEFyMXh5DAbkaJMysPMEM4nxgl
        ds3dw97FyAnkfGOU2P8gDcQGaVj5+CMjRNFeRok7hxazQzgvGSXWLvzPAlLFJqArsWNxGxuI
        LSKwnVGib38giM0ssJJJYt1UO5DVnALWErtv5YOEhQWcJd5emwi2jEVARWL9+mesIDavgKXE
        goeToWxBiZMzn7BAjJGX2P52DjPEQQoSP58uY4VY5Sax6fcnVogacYmXR4+A3SYh8IJD4tzP
        P4wQDS4SH+bMZoKwhSVeHd/CDmFLSXx+txcaLB4Si/5IQYQzJN4uXw/Vai9x4MocFpASZgFN
        ifW79CFW8Un0/n7CBNHJK9HRJgRRrSrR/O4qC4QtLTGxu5sVwvaQuPDuOvMERsVZSB6bheSx
        WUgemIWwbAEjyypGydSC4tz01GLTAsO81HJ4XCfn525iBCdsLc8djHcffNA7xMjEwXiIUYKD
        WUmEt2TX1CQh3pTEyqrUovz4otKc1OJDjKbA0J7ILCWanA/MGXkl8YYmlgYmZmZmJpbGZoZK
        4rwC/xuThATSE0tSs1NTC1KLYPqYODilGphWnZriqVh0bmP0gy/rzhQeb78ocsDAVmTVo8VB
        16dd3vvkwCZGv4ecYglF77vrrtnsMbSs5Xp+UW1r/RKhQ+Kyxz5vPexx7sCMfYeOnnquxnr5
        1H3WpNALe3r+/k88H2JQatukviK7dOEtSy8dlXLLDbN8/po7KfB+Z11n+yBd/9etHRLfP307
        +GqGzsOMRdmzrh7csuTj7ELZ7Wzik9a2ZooFHJBd993g4EbHSmaulyvDw/U2vzJwq9mW1h1w
        bwfXsbU8v+YtUDgt4/0z8tqLDqmgc4vFvJXfea3rto34d1qsouPqhokfyzcLuC1hMrHurnnp
        3yX234B9b/DGZ8nXN+offbnohsxsF+2pZgcmPlJiKc5INNRiLipOBACbD1g5YQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSvO61xJlJBj8nKVq8/HmVzeLaywvs
        FtM+/GS2uLxf22L+kXOsFn0vHjJbbHp8jdXi4atwi8u75rBZTFj1jcWi+/oONovlx/8xWSza
        +oXdonXvEXaLnXdOMDvwe1y+4u2xaVUnm8eda3vYPDYvqff4+PQWi0ffllWMHv+a5rJ7fN4k
        59F+oJspgDOKyyYlNSezLLVI3y6BK2PzyoWMBXPYK17+9GlgXMLWxcjJISFgIrHy8UfGLkYu
        DiGB3YwSqza+Y4dISEtc3zgByhaWWPnvOTtE0XNGiU393YwgCTYBXYkdi9vYQBIiIN0vz74E
        G8sssJlJYu8GZYiOd4wSD7ctY+pi5ODgFLCW2H0rH6RGWMBZ4u21iWAbWARUJNavf8YKYvMK
        WEoseDgZyhaUODnzCQvETG2JpzefQtnyEtvfzmGGuE5B4ufTZWD1IgJuEpt+f2KFqBGXeHn0
        CPsERuFZSEbNQjJqFpJRs5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERy/
        Wpo7GLev+qB3iJGJg/EQowQHs5IIb8muqUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwX
        EkhPLEnNTk0tSC2CyTJxcEo1ME1+2CSe3n2lnYX38XOVxMwd79edLrXOkAyeV7Z/S7eWYu6T
        J7qmE3YdnpeT9sQ7+V619rE7b//taqwv+pf3d5aP9dWa+ssfsvImLN1r4vFihSnb2+Mzpyr1
        an5+mf2bYcWnZcLPO95rTsnR+bPXPU224d59n0cWqX2zmUrqDbxObDdIyqhgjzrx3N0mMb1K
        p7NGrfUDW94z3a3d22wat5QV/MtLWbF82QPOc9Z81dfPxKxQN1uYG/1zqvjhYEXev0Ycaquk
        s59uN018FfBZTGYazzNn0Q0fEjyNJ+7VX3/luMca+4eX8u0lMn5/sP+z78KrXuVllvrl4ctn
        XDmyx2LfYqNFQjMr64Rcs5e17VBiKc5INNRiLipOBAA8pEppTgMAAA==
X-CMS-MailID: 20220603012022epcas5p1cb88b549bf569608b631f526730043df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220531012336epcas5p2fcafe14c90ad3e3a0901fccd62d15437
References: <20220531012220.80563-1-alim.akhtar@samsung.com>
        <CGME20220531012336epcas5p2fcafe14c90ad3e3a0901fccd62d15437@epcas5p2.samsung.com>
        <20220531012220.80563-2-alim.akhtar@samsung.com>
        <8be31be0-8766-061c-2544-25e296048528@acm.org>
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
>From: Bart Van Assche [mailto:bvanassche@acm.org]
>Sent: Tuesday, May 31, 2022 9:14 AM
>To: Alim Akhtar <alim.akhtar@samsung.com>; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
>scsi@vger.kernel.org; linux-phy@lists.infradead.org
>Cc: devicetree@vger.kernel.org; robh+dt@kernel.org;
>krzysztof.kozlowski+dt@linaro.org; vkoul@kernel.org; avri.altman@wdc.com;
>martin.petersen@oracle.com; chanho61.park@samsung.com;
>pankaj.dubey@samsung.com; linux-fsd@tesla.com; Bharat Uppal
><bharat.uppal@samsung.com>
>Subject: Re: [PATCH 1/6] dt-bindings: phy: Add FSD UFS PHY bindings
>
>On 5/30/22 18:22, Alim Akhtar wrote:
>> Adds tesla,fsd-ufs-phy compatible for Tesla FSD SoC
>
>What does FSD stand for? Please clarify this in the patch description.
>
Thanks Bart for review, I will update the commit message with about FSD SoC.

>Thanks,
>
>Bart.

