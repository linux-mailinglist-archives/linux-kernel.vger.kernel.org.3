Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2705425C6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiFHFFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiFHFEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:04:16 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9B386CB7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:59:25 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220608014344epoutp0344daf8e7c83ac9535265488541bf7a93~2gct6DJPo3247732477epoutp03q
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:43:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220608014344epoutp0344daf8e7c83ac9535265488541bf7a93~2gct6DJPo3247732477epoutp03q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654652624;
        bh=KqfS/4/IeJ632hAg/V9fsBPAEPGRQopHMhfw27hpgJI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rpt1BGGS40YE0Wj64lt8WWv8e/GMQU7qZEDXfM1SlesREL6rdShKj+GAsgahDRIy0
         pG7+cbGZKD29GllzURwmkys4ecW6GUn9lyrPmVDYhzhqUxsSQROLgCJIPvYXYUTHRk
         GqxOzxZoJwCk7n6Hvqg12Hgs93MDeaHXerpsG3PU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220608014343epcas2p2eb6c94e6e0cd2251c3e450aa543bf2aa~2gctV1RUE0725707257epcas2p2A;
        Wed,  8 Jun 2022 01:43:43 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LHqkk5Dlfz4x9Q3; Wed,  8 Jun
        2022 01:43:42 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.F0.10028.ECEFF926; Wed,  8 Jun 2022 10:43:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220608014341epcas2p1bf184d852c59b35484b3c57189f1eadf~2gcr3jnZZ1607416074epcas2p12;
        Wed,  8 Jun 2022 01:43:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220608014341epsmtrp243b275605ade7fdc50c7105ac7efea41~2gcr2sFGv1948519485epsmtrp2E;
        Wed,  8 Jun 2022 01:43:41 +0000 (GMT)
X-AuditID: b6c32a47-589ff7000000272c-96-629ffece429f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.E3.11276.DCEFF926; Wed,  8 Jun 2022 10:43:41 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220608014341epsmtip1896b1c38c2d57e0c13addc19484891cc~2gcrpgRQc1248812488epsmtip1Q;
        Wed,  8 Jun 2022 01:43:41 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Cc:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <martin.petersen@oracle.com>, <pankaj.dubey@samsung.com>,
        "'Bharat Uppal'" <bharat.uppal@samsung.com>
In-Reply-To: <20220603154714.30532-4-alim.akhtar@samsung.com>
Subject: RE: [PATCH v2 3/7] phy: samsung-ufs: add support for FSD ufs phy
 driver
Date:   Wed, 8 Jun 2022 10:43:41 +0900
Message-ID: <002d01d87ad9$2ea92ac0$8bfb8040$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFSBQ9Zoh1+pG8sApsbls4ebot9jgKYKc3AAgKsrFGuLM/TEA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmme65f/OTDGZ95LZ4MG8bm8XLn1fZ
        LK69vMBuMe3DT2aL+UfOsVr0vXjIbLHp8TVWi8u75rBZTFj1jcWi+/oONovlx/8xWSza+oXd
        onXvEXaLnXdOMDvweVy+4u2xaVUnm8eda3vYPDYvqff4+PQWi0ffllWMHp83yXm0H+hmCuCI
        yrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpbSaEs
        MacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd
        0fT9KUvBRZaKK7+OMTUwfmHuYuTkkBAwkXh/5B1rFyMXh5DADkaJ/6vfMUI4nxglNl18ywLh
        fGOUuHi1iR2mpWneTjYQW0hgL6PEp6+8EEUvGCUm7bkBVsQmoC/xsmMb2FwRkLmfV3wCG8Us
        0Mkk0X3kAhNIFaeArcSmvnVgtrBAkMSkQ3/AxrIIqEic27GXBcTmFbCU2HSwix3CFpQ4OfMJ
        WJxZQFti2cLXUF8oSPx8uowVIi4iMbuzDSwuIuAksafvN9gVEgIPOCTuPfnNCtHgInFq92uo
        f4QlXh3fAmVLSXx+t5cNwi6WWDrrExNEcwOjxOVtv6ASxhKznrUDg4kDaJumxPpd+iCmhICy
        xJFbULfxSXQc/ssOEeaV6GgTgmhUlziwfToLhC0r0T3nM+sERqVZSD6bheSzWUi+mYWwawEj
        yypGsdSC4tz01GKjAmN4dCfn525iBKdpLfcdjDPeftA7xMjEwXiIUYKDWUmEVzJ8fpIQb0pi
        ZVVqUX58UWlOavEhRlNgWE9klhJNzgdmirySeEMTSwMTMzNDcyNTA3MlcV6vlA2JQgLpiSWp
        2ampBalFMH1MHJxSDUyM0wLSTZ+ecM2vCLmb4zPRzNfqfdOS7E6l+FAfeevwhJiYkA2sDc+E
        3p41sd8ybXdQbOKS0ttVWUl/Lt7ouaq3UcdaqWT/as+1h8sXrl3w4or59eRLfn8VPoUkGraJ
        rTxyz3Tfh9+aiaLG+g0M/63yeyfOnhzur2usVBomeHNxXeuKP+VKIl1Ctg+qHz5kUNkfbjRf
        bV8y/9e0FbVsuw4/KW0O3P/5d6vChNuTD7z8+X5lfXnjigdcTu94DX/H7J7RGq9cUfVjmvWP
        Pjtjr+pC+5cdb44c+v4w64TQ2ux1/tu/lP2qWVEhLjhb/17D4Tm3eeVW/WrlsI/M5na6NH1K
        a3J00LuAbbm3znu0X1ViKc5INNRiLipOBACrpkQtXAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSnO7Zf/OTDPZv0rV4MG8bm8XLn1fZ
        LK69vMBuMe3DT2aL+UfOsVr0vXjIbLHp8TVWi8u75rBZTFj1jcWi+/oONovlx/8xWSza+oXd
        onXvEXaLnXdOMDvweVy+4u2xaVUnm8eda3vYPDYvqff4+PQWi0ffllWMHp83yXm0H+hmCuCI
        4rJJSc3JLEst0rdL4MpY336JseAwS8WWI89YGhifMXcxcnJICJhINM3bydbFyMUhJLCbUWLm
        16VQCVmJZ+92sEPYwhL3W46wQhQ9Y5TYMuUvG0iCTUBf4mXHNrCEiMAeRom2eafYQRxmgclM
        EpMavrJAtOxnlPi9q50FpIVTwFZiU986JhBbWCBAouXwXVYQm0VAReLcjr1gNbwClhKbDnax
        Q9iCEidnPgGLMwtoS/Q+bGWEsZctfA11q4LEz6fLWCHiIhKzO9vA4iICThJ7+n6zTmAUnoVk
        1Cwko2YhGTULSfsCRpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBUauluYNx+6oP
        eocYmTgYDzFKcDArifBKhs9PEuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZq
        akFqEUyWiYNTqoFp8ox1QT2ex92EAt2VWs6xcf8489DBtlb4/J7ODdE3jnx4occhtbxq9jUX
        rjk5Oy6eWcv5xylBT82kX9KqqfPP8i27N8lLdbkvXvVCwfGx9MSXhUkvtqVkfc+btP338b21
        P7YKbFhX5vDh8QLtfJdc/iVzBeu3vO/nP19w9krBTd8/DsE7VOe8tfsWWbJxi9DBD1f68yxl
        GXLyFmulPO15O3HNf/8f4awPfae/9yhy+qt6OXL/13vbYr/a/V3EvF38ftzKqXGbJjMq7Hi6
        in+78rabzZzLX96tu3Gmy/rZ+nkudrymGwrvSG7VYf12btssnc3RET4mM1bGf5dwe/KyojHr
        c13pm4aGk5yzaha1n1BiKc5INNRiLipOBAD85gRBSQMAAA==
X-CMS-MailID: 20220608014341epcas2p1bf184d852c59b35484b3c57189f1eadf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603154857epcas5p4b4684d4400f4ff66f69ff5e288ef635c
References: <20220603154714.30532-1-alim.akhtar@samsung.com>
        <CGME20220603154857epcas5p4b4684d4400f4ff66f69ff5e288ef635c@epcas5p4.samsung.com>
        <20220603154714.30532-4-alim.akhtar@samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: =5BPATCH v2 3/7=5D phy: samsung-ufs: add support for FSD ufs phy
> driver
>=20
> Adds support for Tesla Full Self-Driving (FSD) ufs phy driver.
> This SoC has different cdr lock status offset.
>=20
> Signed-off-by: Bharat Uppal <bharat.uppal=40samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>

Reviewed-by: Chanho Park <chanho61.park=40samsung.com>

As you may know, it seems to be rebased if below patchset goes first.
https://lore.kernel.org/linux-phy/20220607072907.127000-1-chanho61.park=40s=
amsung.com/T/=23t

Best Regards,
Chanho Park

