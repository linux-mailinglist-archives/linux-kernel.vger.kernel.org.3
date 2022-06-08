Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46A854243B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiFHE34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiFHEZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:25:28 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C95E368917
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:51:29 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220608015116epoutp02b565915c330817bad383f01d54586efc~2gjS_tl6a0580105801epoutp02H
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:51:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220608015116epoutp02b565915c330817bad383f01d54586efc~2gjS_tl6a0580105801epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654653076;
        bh=eqVZTWJikI4gYPv3bln85g86ovAiigWULV7IEgDDaj4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=fpfFl96wb6AAbf21EKNDg2zyIZc04ihhdvsCg+1uG2+U6+vj15Tue9cdkvO1R/Whp
         2r4OlRoCuGFW6jeZL5zMoGT+b94a09HuTygncKVqvDOXeXnQ1rl7DtRF2R1sjv2cPl
         +kwpXx/v0fnkuLdqVOWpfwuvP3+CtD9LGFhrH0bM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220608015115epcas2p469ca3c7f538ce71f93fd09d5821241c2~2gjSYUHOH1745117451epcas2p4G;
        Wed,  8 Jun 2022 01:51:15 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LHqvQ4tKsz4x9QC; Wed,  8 Jun
        2022 01:51:14 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.B0.09694.29000A26; Wed,  8 Jun 2022 10:51:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220608015114epcas2p1d0083ce0c3163c230092aeefd95d4d9e~2gjRCB8eD1873318733epcas2p1Y;
        Wed,  8 Jun 2022 01:51:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220608015114epsmtrp22f428656ec91664e445a95dc55dd1d58~2gjRBLo2r2437124371epsmtrp2U;
        Wed,  8 Jun 2022 01:51:14 +0000 (GMT)
X-AuditID: b6c32a48-495ff700000025de-a6-62a00092a365
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.E4.11276.19000A26; Wed,  8 Jun 2022 10:51:13 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220608015113epsmtip237805aa8c2e8e25efd5271e852be0acc~2gjQ25ma40673506735epsmtip2n;
        Wed,  8 Jun 2022 01:51:13 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Cc:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <martin.petersen@oracle.com>, <pankaj.dubey@samsung.com>
In-Reply-To: <20220603154714.30532-6-alim.akhtar@samsung.com>
Subject: RE: [PATCH v2 5/7] ufs: ufs-exynos:  add mphy apb clock mask
Date:   Wed, 8 Jun 2022 10:51:13 +0900
Message-ID: <002e01d87ada$3c3b0630$b4b11290$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFSBQ9Zoh1+pG8sApsbls4ebot9jgLM1fJbAg0k7wKuKtiDAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmhe4khgVJBiffKFk8mLeNzeLlz6ts
        FtM+/GS2mH/kHKtF34uHzBabHl9jtbi8aw6bxYRV31gsuq/vYLNYfvwfk8WirV/YLVr3HmG3
        2HnnBLMDr8flK94em1Z1snncubaHzWPzknqPj09vsXj0bVnF6PF5k5xH+4FupgCOqGybjNTE
        lNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCLlRTKEnNKgUIB
        icXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGd3HbjIX
        fGeu6Fzcw9LAOJe5i5GTQ0LAROLb23bWLkYuDiGBHYwSEzoOsEM4nxgl9p74wQhSJSTwjVHi
        UwMPTMf8uQ0sEEV7GSU+LnzKDOG8AGrfspoFpIpNQF/iZcc2sLkiIHM/r/gElmAWuMMosX2H
        IIjNKWAr8WnLISYQW1jAVaLv7iGwGhYBFYmDb46AHcgrYCnx8MxnKFtQ4uTMJ1Bz5CW2v50D
        9YSCxM+ny1gh4iISszvbwOIiAk4Sa6ceg6q5wiHx4KkIhO0icWoxyJ8gtrDEq+NboGwpic/v
        9rJB2MUSS2d9YgJ5QEKggVHi8rZfUAljiVnP2oHhwgG0TFNi/S59EFNCQFniyC2o0/gkOg7/
        ZYcI80p0tAlBNKpLHNg+nQXClpXonvOZdQKj0iwkj81C8tgsJM/MQti1gJFlFaNYakFxbnpq
        sVGBCTyyk/NzNzGCE7OWxw7G2W8/6B1iZOJgPMQowcGsJMIrGT4/SYg3JbGyKrUoP76oNCe1
        +BCjKTCoJzJLiSbnA3NDXkm8oYmlgYmZmaG5kamBuZI4r1fKhkQhgfTEktTs1NSC1CKYPiYO
        TqkGpkl13E+XeJ6YMutr8MyMlhK1f4fudkmnsJRwp3dO05ujkahZH/+1pfaYflPD6gVOT2al
        Vn6dUj99y83G4+ff/pM5Wn7k5WGGee8UBQTEbr48pvdqmoTRRIe/t+LNzzzSWXjPZy3rgpad
        /42PB9WejeXw/v/xAbPaAnFPLr1rE5WYfZN0mdomMb8O/vf37Yv0nofnNt/hkhVJVuGuXxp1
        WPj9dLP/+/N8i/cxGOpcvu2wwjmi7mhz4BtDvh1M35rj6xPuvGfaYOWsKL7PS5zP8/O0L1fm
        idmFBDziE+syXcbRvuzL+sTtJud1zsxZNSd8n+WfSS1cZW9nHDfiOj7XlTEv2PBJM7tT07qZ
        MpK8MUosxRmJhlrMRcWJAB6x5C5VBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSvO4khgVJBld4LB7M28Zm8fLnVTaL
        aR9+MlvMP3KO1aLvxUNmi02Pr7FaXN41h81iwqpvLBbd13ewWSw//o/JYtHWL+wWrXuPsFvs
        vHOC2YHX4/IVb49NqzrZPO5c28PmsXlJvcfHp7dYPPq2rGL0+LxJzqP9QDdTAEcUl01Kak5m
        WWqRvl0CV0b3sZvMBd+ZKzoX97A0MM5l7mLk5JAQMJGYP7eBpYuRi0NIYDejxIavn9ghErIS
        z97tgLKFJe63HGEFsYUEnjFKnGnVBbHZBPQlXnZsYwVpFhHYwyjRNu8UO4jDLPCEUeJcTzMr
        xNj9jBL/bl0E28cpYCvxacshJhBbWMBVou/uIRYQm0VAReLgmyNgNbwClhIPz3yGsgUlTs58
        AlbDLKAt0fuwlRHClpfY/nYO1A8KEj+fLmOFiItIzO5sA4uLCDhJrJ16jHkCo/AsJKNmIRk1
        C8moWUjaFzCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI5TLc0djNtXfdA7xMjE
        wXiIUYKDWUmEVzJ8fpIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotg
        skwcnFINTAx/uOXvlHH/tFF69e1H+aN1yu7xNlf8GtNP7dgmfuV7ikH1ovatRs/aJ75gtj7R
        GtuxmK1wsiZ3dNB7V541yy7+snbWnzZ7n6y3leP9T2k705TdDT97zug9IH6PNzUqbq2WAc/8
        C6zWcS9EXDR1P4d+KvlytLzdRLi7tHKyrP6Ed4vrApMObrNYsOWQCvOC6Xt3OXdr/Lc9O/VL
        w6J7l+53FZX/F41kUDxxbvEilo6Syqpnqxd+V8+zUdq7JZdvzuxnGeofW1Xma7w981MipXhL
        bKKvVcQhjcD0lbeOxJur1Ww1u3LpMSuryJG/V7dHfy94viK0lzdlpZMIn/OG02zqc+OcCzKe
        n6pv3TTLSomlOCPRUIu5qDgRANzBRMNCAwAA
X-CMS-MailID: 20220608015114epcas2p1d0083ce0c3163c230092aeefd95d4d9e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603154904epcas5p21615dfab6f57f563889230c81a717835
References: <20220603154714.30532-1-alim.akhtar@samsung.com>
        <CGME20220603154904epcas5p21615dfab6f57f563889230c81a717835@epcas5p2.samsung.com>
        <20220603154714.30532-6-alim.akhtar@samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2 5/7] ufs: ufs-exynos: add mphy apb clock mask
> 
> Bit[3] of HCI_CLKSTOP_CTRL register is for enabling/disabling MPHY APB
> clock. Lets add it to CLK_STOP_MASK, so that the same can be controlled
> during clock masking/unmasking.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

And tested on my ExynosAutov9 SADK board.

Tested-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

