Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B41538987
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243337AbiEaBXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiEaBXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:23:43 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B440A02
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:23:41 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220531012335epoutp04324f25b0576a152826a0eeddac659a08~0DA2eFgUZ0078100781epoutp04K
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:23:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220531012335epoutp04324f25b0576a152826a0eeddac659a08~0DA2eFgUZ0078100781epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653960215;
        bh=BIxyiwfJS8WC2lXfrfvvUTI+RGWMHUX5CSx4MIxIl4c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Tz7g8OGorxj2OAKYAKPpp1SgUO2yZd8DXdABmg+1BNuK6QbTzaD6DUnpZSBkca2g9
         s0j+2iBqPRz99vk8Aei72ItPC3JrG2VFMuGS1y5L6XRW8zBmA0pJtZELAUU3Zr+0QG
         qCTdgWDNYlcpL0iJgZibrRZ7W+90efKSx/h0b+b0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220531012335epcas5p1577a4b30fdac44ab4cec18065da4be29~0DA118a6e1430814308epcas5p1i;
        Tue, 31 May 2022 01:23:35 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LBvg75qYpz4x9Q1; Tue, 31 May
        2022 01:23:31 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.4B.10063.31E65926; Tue, 31 May 2022 10:23:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220531012331epcas5p23a835b3635e187ef04d4f28f0933f7c1~0DAySUxIY0088200882epcas5p2f;
        Tue, 31 May 2022 01:23:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220531012331epsmtrp2c37f4308b4e062edca4c16abdc12a384~0DAyRVdty2334523345epsmtrp2m;
        Tue, 31 May 2022 01:23:31 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-59-62956e13191c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.5F.11276.31E65926; Tue, 31 May 2022 10:23:31 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220531012329epsmtip27be3fcac4e87382ea714681e9e8fbcec~0DAwVKqOp0656506565epsmtip2A;
        Tue, 31 May 2022 01:23:29 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 0/6] Add support for UFS controller found in FSD SoC
Date:   Tue, 31 May 2022 06:52:14 +0530
Message-Id: <20220531012220.80563-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmhq5w3tQkg0mHdSwezNvGZvHy51U2
        i2kffjJbXN6vbTH/yDlWi74XD5ktNj2+xmpxedccNosJq76xWHRf38Fmsfz4PyaLRVu/sFu0
        7j3CbrHzzglmBz6Py1e8PTat6mTzuHNtD5vH5iX1Hh+f3mLx6NuyitHj8yY5j/YD3UwBHFHZ
        NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVysplCXm
        lAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjO2
        H9vEWrCZu2LZ1m7WBsbrHF2MnBwSAiYSZ9afYOti5OIQEtjNKLH1/SpGCOcTo8SXdx3MEM43
        Rol5Mw6zwbTsuLWSBSKxl1Hi07EjUC0tTBKNa3awglSxCWhL3J2+hQkkISLQzChxsGMXmMMs
        0MckseT2bbAqYQEXiYYjfewgNouAqsSmd42MIDavgI3EjT1z2SH2yUus3nAA7BAJga/sEic+
        XmGCSLhIXP6yCcoWlnh1fAtUg5TE53d7gY7lALI9JBb9kYIIZ0i8Xb6eEcK2lzhwZQ4LSAmz
        gKbE+l36IGFmAT6J3t9PmCA6eSU62oQgqlUlmt9dZYGwpSUmdnezQtgeEtM3LwNbKiQQK7H+
        7Cq2CYwysxCGLmBkXMUomVpQnJueWmxaYJiXWg6PneT83E2M4BSo5bmD8e6DD3qHGJk4GA8x
        SnAwK4nwWkVMTRLiTUmsrEotyo8vKs1JLT7EaAoMpYnMUqLJ+cAknFcSb2hiaWBiZmZmYmls
        ZqgkzivwvzFJSCA9sSQ1OzW1ILUIpo+Jg1OqgWl5G9PMRlfzjHAtRu786RKJ6yfq6Uxhf7l4
        j1nsqqsTlS4uY1zQMreVablfyITyt97fOL3DAidwRKVs5nCas3xvb8P0n1srA5uP/5Nf9ODO
        35sGcdkRZut5xS9dltboCuxTabz+XYLLUL5v+ukCj+zUMwx2Bx6su/rzvlGkZs/H/cxz9sQy
        1J09VFfUu2LuliO5V06dq/B0uXSS+fK2lcsnubLvL9l9ScqNveh5jlWl/3zfJ8v9+3Y9lMn1
        Z5n18d1zDnO2jceXrlpasuXGPL91IaG1339/DErYJxJ9z3rtkfMqHjnTGZ5peh5xbTb21X1+
        bOqEwnL3ZoVFbmue5Z53DVJuDjFJub6WKblYJlqJpTgj0VCLuag4EQDff+mOCgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWy7bCSvK5w3tQkg20LeS0ezNvGZvHy51U2
        i2kffjJbXN6vbTH/yDlWi74XD5ktNj2+xmpxedccNosJq76xWHRf38Fmsfz4PyaLRVu/sFu0
        7j3CbrHzzglmBz6Py1e8PTat6mTzuHNtD5vH5iX1Hh+f3mLx6NuyitHj8yY5j/YD3UwBHFFc
        NimpOZllqUX6dglcGduPbWIt2MxdsWxrN2sD43WOLkZODgkBE4kdt1aydDFycQgJ7GaUWDjx
        HgtEQlri+sYJ7BC2sMTKf8/BbCGBJiaJZ98tQWw2AW2Ju9O3MIHYIgLtjBL3t7OBDGIWmMUk
        8X7SE0aQhLCAi0TDkT6wZhYBVYlN7xrB4rwCNhI39syFWiAvsXrDAeYJjDwLGBlWMUqmFhTn
        pucWGxYY5qWW6xUn5haX5qXrJefnbmIEB6mW5g7G7as+6B1iZOJgPMQowcGsJMJrFTE1SYg3
        JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamKtn1i55/01jC
        XdXQVftx9oItkWVP5Tylfh72Ezglxdv454rU87+TW8UCp6k8V2uIKQz4HTiP7bmw5Bbmjza3
        Nggpci1Sm+zuH7GrY0W/6cqb0imVTZ/zY3RYppwqmn7smoxnaOPpSNNgvY135i71D9Z2Cu91
        jLaf1qlQ5em/h9Hy9I8Xl1L22M3bVbnxYsidyebnvxq/1l/yzi6jdGWUS0wGm35J4JzNkxK/
        y3z9lrbzY3a7wpM1+55sWNSnt4wn9NcMgYKTTkpHuA2fzapcnqh+ulU7/YRtl8Hc2NrtzJnK
        Ou5qa3q/lXfvqS7cd+6F5NJv267+2fi6xlpjQctee96Ugj3ZIdmFVwtXXNNXYinOSDTUYi4q
        TgQAf9c3PsECAAA=
X-CMS-MailID: 20220531012331epcas5p23a835b3635e187ef04d4f28f0933f7c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220531012331epcas5p23a835b3635e187ef04d4f28f0933f7c1
References: <CGME20220531012331epcas5p23a835b3635e187ef04d4f28f0933f7c1@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for UFS controller found in FSD SoC.
The HCI is almost same as found on other Exynos SoCs with minor
differences. This also adds the required UFS-PHY driver changes.

Patch 2/6: common change to handle different CDR offsets


Alim Akhtar (6):
  dt-bindings: phy: Add FSD UFS PHY bindings
  phy: samsung-ufs: move cdr offset to drvdata
  phy: samsung-ufs: add support for FSD ufs phy driver
  dt-bindings: ufs: exynos-ufs: add fsd compatible
  ufs: host: ufs-exynos: add support for fsd ufs hci
  arm64: dts: fsd: add ufs device node

 .../bindings/phy/samsung,ufs-phy.yaml         |   1 +
 .../bindings/ufs/samsung,exynos-ufs.yaml      |   1 +
 arch/arm64/boot/dts/tesla/fsd-evb.dts         |   4 +
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi    |  14 ++
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  29 ++++
 drivers/phy/samsung/Makefile                  |   1 +
 drivers/phy/samsung/phy-exynos7-ufs.c         |   3 +
 drivers/phy/samsung/phy-exynosautov9-ufs.c    |   2 +
 drivers/phy/samsung/phy-fsd-ufs.c             |  63 ++++++++
 drivers/phy/samsung/phy-samsung-ufs.c         |   6 +-
 drivers/phy/samsung/phy-samsung-ufs.h         |   3 +-
 drivers/ufs/host/ufs-exynos.c                 | 143 +++++++++++++++++-
 12 files changed, 267 insertions(+), 3 deletions(-)
 create mode 100644 drivers/phy/samsung/phy-fsd-ufs.c


base-commit: d3fde8ff50ab265749704bd7fbcf70d35235421f
-- 
2.25.1

