Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E4654B5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbiFNQOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357049AbiFNQNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:13:32 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521CB37A9E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:13:31 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220614161328epoutp03515235a453eefa782d67b1ac213c2f62~4iLz7H75B0194801948epoutp03I
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:13:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220614161328epoutp03515235a453eefa782d67b1ac213c2f62~4iLz7H75B0194801948epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655223208;
        bh=/E2y2QIl7hooCGcl99PvQlTV2UQaMHrzp2xlErPJ2Ak=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=fxsSu9BFy1GeQ7fmRhd83B8wyrIIOyHj9hF7KwKKpRUdnBfw+7lOcpPYz4lNPYQ6C
         C2qAqc3CWMDCqEnUu0rskdm6iuKsbTuxKo6Ub3urmw2X724RG2LUgwTD4J5MTU7LrV
         ovqBEAdSTtjbQ9SR2oxweu6dEA9qXmoHnABTIpG0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220614161326epcas5p169be98a6e3a82517467840054fcd7c9a~4iLyZoPqY1049110491epcas5p16;
        Tue, 14 Jun 2022 16:13:26 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LMtlR4x85z4x9Pr; Tue, 14 Jun
        2022 16:13:23 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.79.10063.3A3B8A26; Wed, 15 Jun 2022 01:13:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220614161323epcas5p469e5d499764dbe18ad96a7ede156d346~4iLvLDoZi3008830088epcas5p4S;
        Tue, 14 Jun 2022 16:13:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220614161323epsmtrp13f6697dd2e418292ccfa6247e53e7c61~4iLvGrtSz3260132601epsmtrp1O;
        Tue, 14 Jun 2022 16:13:23 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-e7-62a8b3a3007d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.D6.08924.2A3B8A26; Wed, 15 Jun 2022 01:13:22 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220614161321epsmtip20b8d61e04d315ffe7d4b5bb0ebbed5d3~4iLtS1RIK1769317693epsmtip2T;
        Tue, 14 Jun 2022 16:13:21 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <vkoul@kernel.org>
Cc:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <martin.petersen@oracle.com>,
        <chanho61.park@samsung.com>, <pankaj.dubey@samsung.com>
In-Reply-To: <20220610104119.66401-1-alim.akhtar@samsung.com>
Subject: RE: [PATCH v4 0/6] Add support for UFS controller found in FSD SoC
Date:   Tue, 14 Jun 2022 21:43:19 +0530
Message-ID: <003301d88009$ab90e390$02b2aab0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIu/OPxqgZFceAsQzYNdQjDR0m3fgEGezFsrJnkvnA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmpu7izSuSDK79VrR4+fMqm8W0Dz+Z
        LS7v17aYf+Qcq0Xfi4fMFpseX2O1uLxrDpvFhFXfWCy6r+9gs1h+/B+TxaKtX9gtWvceYbfY
        eecEswOvx+Ur3h6bVnWyedy5tofNY/OSeo+PT2+xePRtWcXo8XmTnEf7gW6mAI6obJuM1MSU
        1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoIOVFMoSc0qBQgGJ
        xcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZG2/+ZC/o
        Eqk40f+esYFxikAXIyeHhICJxLn5G5hAbCGB3YwSsy+YdzFyAdmfGCWWf/3LAuF8ZpT4O+ks
        I0zH/deHoRK7GCX+r73DDOG8ZJRYP2c22Cw2AV2JHYvb2EASIgILGSXe/V/KBOIwCzxllFh5
        ei0zSBWngK3Es/WXWUFsYQFviSfrv7OD2CwCqhKrT79iAbF5BSwlNp/8zwZhC0qcnPkELM4s
        oC2xbOFrZoibFCR+Pl0GNkdEwEpi9/dTTBA14hIvjx5hB1ksIXCFQ2Lj4YNQDS4Sv3duYIOw
        hSVeHd/CDmFLSbzsbwOyOYBsD4lFf6QgwhkSb5evh/rfXuLAlTksICXMApoS63fpQ6zik+j9
        /YQJopNXoqNNCKJaVaL53VUWCFtaYmJ3NyuE7SHx8+tyxgmMirOQPDYLyWOzkDwwC2HZAkaW
        VYySqQXFuempxaYFhnmp5fAIT87P3cQITs9anjsY7z74oHeIkYmD8RCjBAezkgjv5IvLkoR4
        UxIrq1KL8uOLSnNSiw8xmgJDeyKzlGhyPjBD5JXEG5pYGpiYmZmZWBqbGSqJ8wr8b0wSEkhP
        LEnNTk0tSC2C6WPi4JRqYGr6P2MCZ94fgdOFKWkVIToJ23aaWqQpqEx6dvRWl69EzsnNd7ik
        d1574xhnNZ9V+Zd/veKpV6KfaiIc/7XOeyW5xXfC2v/zJ2yQ9knIntFlWfn6a2S2y7bU2CcT
        D/SrBG58fuVF9JMdXvYuT1YcOW1yq7RW672NxhKz9XHTTzJNdHLapfNosrao1Pyvq3fbCope
        bHjwNalp+XSDLfwZS+3LootMz65a49c1N+Hr9PmTdr2PVt1zpOuagvKc+Y63ul3qCsU/7tt8
        xFBt9jnrwpfRLppfozYtE28+M3v+BDZ7/7UfjV5rXDqwWtpV61SrX3pTfNlbTU9xb685YoL5
        hhsUNI6IRLdXK3IlmLcvDVZiKc5INNRiLipOBADLJWfyWAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSvO7izSuSDF5yW7z8eZXNYtqHn8wW
        l/drW8w/co7Vou/FQ2aLTY+vsVpc3jWHzWLCqm8sFt3Xd7BZLD/+j8li0dYv7Bate4+wW+y8
        c4LZgdfj8hVvj02rOtk87lzbw+axeUm9x8ent1g8+rasYvT4vEnOo/1AN1MARxSXTUpqTmZZ
        apG+XQJXxtlXPcwFZ4QrLjRPZmpgvMbfxcjJISFgInH/9WGWLkYuDiGBHYwS927fYYRISEtc
        3ziBHcIWllj57zk7RNFzRonJJxvZQBJsAroSOxa3sYEkRASWMkr8XvYVbBSzwFtGiVUfbzBC
        tPQxSnRP/coK0sIpYCvxbP1lMFtYwFviyfrvYDtYBFQlVp9+xQJi8wpYSmw++Z8NwhaUODnz
        CVicWUBb4unNp3D2soWvmSHuU5D4+XQZ2EwRASuJ3d9PMUHUiEu8PHqEfQKj8Cwko2YhGTUL
        yahZSFoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjlMtrR2Me1Z90DvEyMTB
        eIhRgoNZSYR38sVlSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJ
        MnFwSjUwcZRPWiP4ckI2v+XtlWWz9v7n/Jul+8NsvsThQ4z//N6ybS2+aMx0uNblsvQBce/0
        xuor/QVlAQq9kkuldW7ryMUYCnx8JB7dqPlKeJbBjKlqRTtzArcp6Qe9a1RYkpjgmxNtWzTn
        bIfVkp/dD2v2JB6c8uBTHHf6i38Wrv5XNl1o9vzxYM4lpYWbpi6f6WaTzmRzTPz/Wz3vif3M
        mQfUfmTcWSQz3W7L/i9LdCZ/VrV47ZQ767f984mnVrhIXLjZlL361Me1t69NuOgzWch2/37D
        tx5xi3LNY9u/eS+5emarYJt70ZPg+QunVLxdVMe74JCSYNQteambZmvTlaTFK68HeGudnRLr
        7aUStqHyshJLcUaioRZzUXEiAMJpVwpCAwAA
X-CMS-MailID: 20220614161323epcas5p469e5d499764dbe18ad96a7ede156d346
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610104340epcas5p1d6cee31aba4dc2952ef09003c9e67863
References: <CGME20220610104340epcas5p1d6cee31aba4dc2952ef09003c9e67863@epcas5p1.samsung.com>
        <20220610104119.66401-1-alim.akhtar@samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod

>-----Original Message-----
>From: Alim Akhtar =5Bmailto:alim.akhtar=40samsung.com=5D
>Sent: Friday, June 10, 2022 4:11 PM
>To: linux-arm-kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org=
; linux-
>scsi=40vger.kernel.org; linux-phy=40lists.infradead.org
>Cc: devicetree=40vger.kernel.org; robh+dt=40kernel.org;
>krzysztof.kozlowski+dt=40linaro.org; vkoul=40kernel.org; avri.altman=40wdc=
.com;
>bvanassche=40acm.org; martin.petersen=40oracle.com;
>chanho61.park=40samsung.com; pankaj.dubey=40samsung.com; Alim Akhtar
><alim.akhtar=40samsung.com>
>Subject: =5BPATCH v4 0/6=5D Add support for UFS controller found in FSD So=
C
>
>
>This series adds support for UFS controller found in FSD SoC.
>The HCI is almost same as found on other Exynos SoCs with minor difference=
s.
>This also adds the required UFS-PHY driver changes.
>
>Patch 2/6: common change to handle different CDR offsets
>
>*Changes since v3:
>- Addressed review comments on patch 6/6 from Chanho
>
>*Changes since v2:
>- Addressed review comments from Chanho
>- collected reviewed-by, tested-by tags
>- rebased on next-20220609
>
>*Changes since v1:
>- Addressed review comments from Bart, Krzysztof, Chanho
>- collected Ack-by tags
>- rebased on next-20220602
>
>
>Alim Akhtar (6):
>  dt-bindings: phy: Add FSD UFS PHY bindings
>  phy: samsung-ufs: move cdr offset to drvdata
>  phy: samsung-ufs: add support for FSD ufs phy driver

Can you please take patch-=7B1/6, 2/6 and 3/6=7D via phy tree?

The UFS patches has been picked by Martin via SCSI tree.

Thanks.

>  dt-bindings: ufs: exynos-ufs: add fsd compatible
>  ufs: host: ufs-exynos: add mphy apb clock mask
>  ufs: host: ufs-exynos: add support for fsd ufs hci
>
> .../bindings/phy/samsung,ufs-phy.yaml         =7C   1 +
> .../bindings/ufs/samsung,exynos-ufs.yaml      =7C   1 +
> drivers/phy/samsung/Makefile                  =7C   1 +
> drivers/phy/samsung/phy-exynos7-ufs.c         =7C   3 +
> drivers/phy/samsung/phy-exynosautov9-ufs.c    =7C   2 +
> drivers/phy/samsung/phy-fsd-ufs.c             =7C  58 +++++++
> drivers/phy/samsung/phy-samsung-ufs.c         =7C   7 +-
> drivers/phy/samsung/phy-samsung-ufs.h         =7C   3 +-
> drivers/ufs/host/ufs-exynos.c                 =7C 143 +++++++++++++++++-
> drivers/ufs/host/ufs-exynos.h                 =7C   1 +
> 10 files changed, 217 insertions(+), 3 deletions(-)  create mode 100644
>drivers/phy/samsung/phy-fsd-ufs.c
>
>
>base-commit: ff539ac73ea559a8c146d99ab14bfcaddd30547a
>--
>2.25.1


