Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98A24D16D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346671AbiCHMIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346731AbiCHMIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:08:10 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BF52DD7D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:07:13 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220308120707epoutp01f3868ae01cd5ba20f69117e09f9364ec~aZmv-4iI-3064630646epoutp01k
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:07:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220308120707epoutp01f3868ae01cd5ba20f69117e09f9364ec~aZmv-4iI-3064630646epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646741227;
        bh=TWgcRtZ9BCWDi9BjQnRMZAArKHgdfX2otVHNY9T5ztY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=OHbSfDw4JynHwbrJdFo/ZKgZ+nJxStMQB8fANQC9Vuvj4xpcimLv9GWCf/k/6ETrf
         /YXitmtEFDSTDtosp3NypKXJdf3sgUJ3cyLwYQ54BLkdpnamYYR8LxhatrySTFEJFB
         km4FEtsuhjkJDpl+si2htzLkgcArhY37NpAC9zXw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220308120706epcas5p22b0b343c0370c7521d05a9e9fbbf65bd~aZmvJVhCg2571125711epcas5p2N;
        Tue,  8 Mar 2022 12:07:06 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KCYwQ0hdfz4x9Pw; Tue,  8 Mar
        2022 12:07:02 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.D0.46822.41447226; Tue,  8 Mar 2022 20:55:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681~aZmqK9Rvi0868908689epcas5p3A;
        Tue,  8 Mar 2022 12:07:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220308120701epsmtrp1aa0f27a4a0e205d9b8d2a2555c9cbcc6~aZmqGnD8e0604606046epsmtrp1P;
        Tue,  8 Mar 2022 12:07:01 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-f0-622744145dd6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.8B.29871.5E647226; Tue,  8 Mar 2022 21:07:01 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220308120659epsmtip1beef1923f221bcff768e793abd4ad142~aZmoFWCjX0869608696epsmtip1M;
        Tue,  8 Mar 2022 12:06:59 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        broonie@kernel.org, andi@etezian.org, linux-spi@vger.kernel.org,
        lee.jones@linaro.org, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Adithya K V <adithya.kv@samsung.com>
Subject: [RESEND PATCH v3 1/2] spi: dt-bindings: samsung: Add fsd spi
 compatible
Date:   Tue,  8 Mar 2022 17:46:39 +0530
Message-Id: <20220308121640.27344-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmhq6Ii3qSwYVJChYHJrxitXgwbxub
        xeIfz5kspj58wmYx/8g5VouNb38wWdz/epTRYsqf5UwWmx5fY7V4+Crc4vKuOWwWM87vY7Jo
        /HiT3WLR1i/sFq17j7A78HvMauhl87i+5BOzx6ZVnWwed67tYfPYvKTeo2/LKkaPf01z2T0+
        b5IL4IjKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB
        ul1JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBk
        ClSYkJ1x7sZJ5oJLnBVfzq9gbGD8w97FyMEhIWAicWFiWBcjF4eQwG5Giff/G1ggnE+MEqcP
        tQAVcQI53xglvjxzB7FBGj5NbmeGKNrLKHFq3jZGCKeFSWLHmU5WkCo2AW2Ju9O3MIHYIgJu
        EjcaO8BsZoH3TBLtTzNBbGGBIIkfS8+A1bMIqErsfNXLCGLzCthI3OzdxQaxTV5i9YYDYNsk
        BP6ySzS8msACkXCReNF1jB3CFpZ4dXwLlC0l8bK/Deq3bImeXcYQ4RqJpfOOQbXaSxy4MocF
        pIRZQFNi/S59iNP4JHp/P2GC6OSV6GgTgqhWlWh+dxWqU1piYnc3K4TtIbFn72ZGSPjESkz4
        28M0gVFmFsLQBYyMqxglUwuKc9NTi00LjPJSy+Exk5yfu4kRnAa1vHYwPnzwQe8QIxMH4yFG
        CQ5mJRHe++dVkoR4UxIrq1KL8uOLSnNSiw8xmgJDaSKzlGhyPjAR55XEG5pYGpiYmZmZWBqb
        GSqJ855O35AoJJCeWJKanZpakFoE08fEwSnVwFT15EH7/yJfW8XzuQbbFJ7aXw1I/JqfqWSx
        Vzvg1tRTS0UVWJxXFmX8O1+ev79HVY3nQ/XJ/Es2/NdZXBfMs5+2c+Ppo2+9OS3P/Ny5LHTa
        odef80s6nF7w3I9e9jpua8q1GzrBE2vzTGqmC2v2rrw+7SWj2z8hjbB9DJtYgjapLEyaf/fr
        Lb4y+8Jr+3jeL+PNv3TehGWP2+0tdvUODO8sajddP7VsaZLeYYbtnZuenN98JTFtv8I9lzzF
        Yjtz1oK9K3d5F/xPynFfvWudnfOdyFs+lo07jzSxnDx0mP+wh3Ra1HwNKw7erT9XdPJwWr/V
        S4qcemRXxMqLjzd9DXzpvNr4wu7lP7hi0z0aOHcpsRRnJBpqMRcVJwIATu1sOQwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnO5TN/Ukg1uN4hYHJrxitXgwbxub
        xeIfz5kspj58wmYx/8g5VouNb38wWdz/epTRYsqf5UwWmx5fY7V4+Crc4vKuOWwWM87vY7Jo
        /HiT3WLR1i/sFq17j7A78HvMauhl87i+5BOzx6ZVnWwed67tYfPYvKTeo2/LKkaPf01z2T0+
        b5IL4IjisklJzcksSy3St0vgyjh34yRzwSXOii/nVzA2MP5h72Lk5JAQMJH4NLmduYuRi0NI
        YDejxKklx5ghEtIS1zdOgCoSllj57zk7RFETk8TKLatYQRJsAtoSd6dvYQKxRQQ8JNr+3QOb
        xCzwl0li8Y79YEXCAgESJw+3gU1lEVCV2PmqlxHE5hWwkbjZu4sNYoO8xOoNB5gnMPIsYGRY
        xSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHLJamjsYt6/6oHeIkYmD8RCjBAezkgjv
        /fMqSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwVcr2
        7bKJ/b2e48GeN22h6TLs99/NP9204JG9yVOLRet9gr0m8qpcTwudwHdeo6HcLO4pm8RCxZz1
        H0JOsjRyPdrtFyb3YUepZNXCtd2Xw7Z7R+71r6z3knCReJdVZMr37U6Kpq5B3tlf54on3rS8
        cOacueq+eSahlcapqdeX9/7lblubXRbRsUtp6uEVrK8Clc9l8PyKc/imzmRSlxS7jl+iwuHQ
        /16eDdMVJ1VcvNa+Xq/o8+TbU9Yc9Mr6Vx/8l3fpx/TkM823uZS/ffEo3yxxJXHy0XtOnELS
        jm9Z730/L3GKxzHX99/Ee3+mLz8xJ3mt1UvONdcnsyQ/5V7v9tBSuiSIpzX7wvEJktYmSizF
        GYmGWsxFxYkAILjsD8gCAAA=
X-CMS-MailID: 20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681
References: <CGME20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds spi controller dt-binding compatible information for
Tesla Full Self-Driving (FSD) SoC.

Cc: linux-fsd@tesla.com
Signed-off-by: Adithya K V <adithya.kv@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Andi Shyti <andi@etezian.org>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

- Resend of FSD SPI support patches as the dependencies has landed in MFD
  tree, hope this will go via MFD tree (as there are dependency between
MFD, SPI and DT)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index 61c77088e8ee..bf9a76d931d2 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -21,6 +21,7 @@ properties:
           - samsung,s3c6410-spi
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
           - samsung,exynos5433-spi
+          - tesla,fsd-spi
       - const: samsung,exynos7-spi
         deprecated: true
 

base-commit: 172e611b54e813c49a35b6b74bccaa99f27bf566
-- 
2.25.1

