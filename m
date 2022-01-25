Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6098849AB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354397AbiAYElX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:41:23 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:16652 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1323478AbiAYD2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:28:44 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220125032830epoutp03b2729bab15141905756ae41a7d2b4390~NZb8ayJ010395603956epoutp03I
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 03:28:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220125032830epoutp03b2729bab15141905756ae41a7d2b4390~NZb8ayJ010395603956epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643081310;
        bh=8jc/TkSpVy2F73XV2j+KpEg9r/Rfk6qp7pVEcUzrKaA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=V+Jhp5sugSYuArTG/QUlMXWvKM8aaV4uxN79NGxor2eCvikI6/3TcoZNm9Pks4cDm
         gTwX5Ob+TDk2tZrq1uQIyXvSzC/QXPyGkzrQsE6kAzf8KZP5FaoaQNusl4INR8EOT3
         r3V4K5mCGI9qehcukqRzC783QkuSoYkpxdbqoul0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220125032829epcas5p2f78178e5980838c47e442c2d4703eea1~NZb75n1682291022910epcas5p2d;
        Tue, 25 Jan 2022 03:28:29 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JjXPK4GMsz4x9Px; Tue, 25 Jan
        2022 03:28:21 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.BC.05590.B4E6FE16; Tue, 25 Jan 2022 12:28:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220125032811epcas5p3ef7b2f4e4906c1da8ccb4a0b3ed9a591~NZbqpWidL2365923659epcas5p3e;
        Tue, 25 Jan 2022 03:28:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220125032811epsmtrp2fbe9a5626a3149f7d178bf5b04751927~NZbqoYhc22646626466epsmtrp2B;
        Tue, 25 Jan 2022 03:28:11 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-96-61ef6e4bf81f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.68.29871.B4E6FE16; Tue, 25 Jan 2022 12:28:11 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220125032809epsmtip1a40f9a502e2f1656ebd9201ec1539131~NZbo1RC0K0376703767epsmtip1x;
        Tue, 25 Jan 2022 03:28:09 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        broonie@kernel.org, andi@etezian.org, linux-spi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 0/3] Add FSD SPI support
Date:   Tue, 25 Jan 2022 08:46:01 +0530
Message-Id: <20220125031604.76009-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmhq533vtEg7PP9S0ezNvGZrH4x3Mm
        i6kPn7BZzD9yjtVi49sfTBZT/ixnstj0+BqrxeVdc9gsZpzfx2TR+PEmu8WirV/YLVr3HmF3
        4PGY1dDL5nF9ySdmj02rOtk87lzbw+axeUm9R9+WVYwenzfJBbBHZdtkpCampBYppOYl56dk
        5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAB2qpFCWmFMKFApILC5W0rezKcov
        LUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOeHXzCkvBOfaKRUuXMzYw
        fmLtYuTkkBAwkbi6dSFLFyMXh5DAbkaJpl+r2CGcT4wSvbvXQ2W+MUp8W7gBruVH91UmiMRe
        RolDK7+zgSSEBFqYJNrPVYDYbALaEnenb2ECsUUE3CRuNHaANTALzGGS2Lz6PXMXIweHMFDR
        3ieVIDUsAqoSx/ZdA1vAK2Aj8XzPO2aIZfISqzccYAbplRB4xC7xZsFDNoiEi8S3vSegioQl
        Xh3fwg5hS0l8freXDWS+hEC2RM8uY4hwjcTSecdYIGx7iQNX5rCAlDALaEqs36UPEmYW4JPo
        /f2ECaKTV6KjTQiiWlWi+d1VqE5piYnd3dBg8JDY1PeJHeLzWIlVn0+yTWCUmYUwdAEj4ypG
        ydSC4tz01GLTAuO81HJ41CTn525iBKc4Le8djI8efNA7xMjEwXiIUYKDWUmE97/3+0Qh3pTE
        yqrUovz4otKc1OJDjKbAUJrILCWanA9Msnkl8YYmlgYmZmZmJpbGZoZK4ryn0jckCgmkJ5ak
        ZqemFqQWwfQxcXBKNTDlVt+ebxj4N3zXT3PFjw9b+mQ3qJluudSctX2KlYFD/fx084L7icbx
        J9dkvxd/c7Zr8u0X34rYA0pLmONyHjNftGH2vSUmcTR7u3SaGvO9idselrksjGc9tEdCOvTa
        3jnbw6d17+SY7SKWvOR/rc+5ZMuPTLvyK6aJFzwRWOr4Km7fsaU3y+7ZCjRt8EpYvFC73a9I
        R0L6gpL6g85K8a0ap6t7F/473jThTkP/z7+TJE4uM7y43q/EeAdjwvu5Ze+KfnM8v73m0/aj
        PzUXXCkMtBW+08+3g0V5PTvHL89PSjHxzywPVwY77Pt0cvUuzs0aTZOPtcqc1PyttrjCdvLs
        BRuf3nuaeLDVRvuvliO3EktxRqKhFnNRcSIA34Q8o/oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSnK533vtEg89bBCwezNvGZrH4x3Mm
        i6kPn7BZzD9yjtVi49sfTBZT/ixnstj0+BqrxeVdc9gsZpzfx2TR+PEmu8WirV/YLVr3HmF3
        4PGY1dDL5nF9ySdmj02rOtk87lzbw+axeUm9R9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGW8
        unmFpeAce8WipcsZGxg/sXYxcnJICJhI/Oi+ytTFyMUhJLCbUWLB4ylsEAlpiesbJ7BD2MIS
        K/89Z4coamKS6F3zHKyITUBb4u70LUwgtoiAh0Tbv3vMIEXMAsuYJLbvO8HSxcjBIQxUtPdJ
        JUgNi4CqxLF918A28wrYSDzf844ZYoG8xOoNB5gnMPIsYGRYxSiZWlCcm55bbFhgmJdarlec
        mFtcmpeul5yfu4kRHIpamjsYt6/6oHeIkYmD8RCjBAezkgjvf+/3iUK8KYmVValF+fFFpTmp
        xYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwMTVnLjFbq1f7iVes77DLnOMHM9oa
        tdqfTliUekF8Rp7lBr+ID+cOTtv/u/vUlJsXfmTwOj7cM8O30/fC+azTHiufKDnLHI5Xuqq9
        ziG70OXizzWLclqLKs4wsj73+RPzxtfWbXrGiujXsR3p9TIXfDNqFudtnNnhXJWQPJG5y1n7
        8HuPD2sUvu1fp3Bxeu7/ixtL+4JCFNem3TEV2uFpVXX3sX3O9Q9/7Hp2LGmco/u5X96xNl5m
        wnQGId6rxxd1ft6tLL+Bhb80PFnU/J7D78Wz99T+WrFjfSLDDda3h//tZV/e/HTvH6HlR6KO
        zt9YLhBUmbri1tH0KRFJFZmVqfoCVl+9d/72Ygxo9br1U4mlOCPRUIu5qDgRABoaLWy0AgAA
X-CMS-MailID: 20220125032811epcas5p3ef7b2f4e4906c1da8ccb4a0b3ed9a591
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220125032811epcas5p3ef7b2f4e4906c1da8ccb4a0b3ed9a591
References: <CGME20220125032811epcas5p3ef7b2f4e4906c1da8ccb4a0b3ed9a591@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for SPI controller found in Tesla FSD SoC

- Changes since v2
* Addressed review comments of Andi
* rebased on Krzysztof's v6 spi schema changes
* Added tags

-Changes since v1
* Splited SPI changes from a larger inital patch set
* Rebased on Krzysztof's latest (v5) SPI schema changes
* Added tag

Note: This series is depended on [1] patches which adds
support of FSD SoC and on Krzysztof's v6 [2] of spi schema changes

[1] https://lkml.org/lkml/2022/1/24/583
[2] https://lkml.org/lkml/2022/1/24/120


Alim Akhtar (2):
  spi: dt-bindings: samsung: Add fsd spi compatible
  spi: s3c64xx: Add spi port configuration for Tesla FSD SoC

Aswani Reddy (1):
  arm64: dts: fsd: Add SPI device nodes

 .../devicetree/bindings/spi/samsung,spi.yaml  |  1 +
 arch/arm64/boot/dts/tesla/fsd.dtsi            | 57 +++++++++++++++++++
 drivers/spi/spi-s3c64xx.c                     | 13 +++++
 3 files changed, 71 insertions(+)

-- 
2.25.1

