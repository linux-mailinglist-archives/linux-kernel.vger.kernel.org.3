Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935284856E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 17:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242045AbiAEQyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 11:54:02 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:34776 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiAEQx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 11:53:58 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220105165356epoutp04de453f327c3872a0cde5afb6dd7958b1~Hbhd_a38N0727307273epoutp04T
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 16:53:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220105165356epoutp04de453f327c3872a0cde5afb6dd7958b1~Hbhd_a38N0727307273epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1641401636;
        bh=RQ99m1jJPhIHUCeFdUy2vwQ1cn9LOk9p3qwSLPtVGdE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=RYJy7DsERlxDCT0pjOyu+lSfM92rTg3U0vqAFkiL3lIcd9HpRcSV70lBXmyG9bfDY
         LR4qkHS1TCjeWKIsYhoFipI4jcNF8OAU/fl0G3V7Y6Js0xv3Tncig0vCPzIXqlilaB
         bEW3WOiHftauWoJ3PMZ2NV3SiV2YUpfpUShWlGsM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220105165355epcas5p4ff4619c163ce7dc7a3074e6d9446f9e7~HbhdU1EDm0428504285epcas5p4E;
        Wed,  5 Jan 2022 16:53:55 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JTbD03RXnz4x9Pv; Wed,  5 Jan
        2022 16:53:52 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.F9.06423.02DC5D16; Thu,  6 Jan 2022 01:53:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220105165351epcas5p100b28a19d5a5e5614ea82adf5e0037b0~HbhZiT5pX3051430514epcas5p1L;
        Wed,  5 Jan 2022 16:53:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220105165351epsmtrp25a3646999e445649587770840215a756~HbhZhut9j0460604606epsmtrp2T;
        Wed,  5 Jan 2022 16:53:51 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-aa-61d5cd2008ee
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.02.08738.F1DC5D16; Thu,  6 Jan 2022 01:53:51 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220105165350epsmtip194c9172598c1fd71327517cd6fadeafb~HbhYp2gnZ0640706407epsmtip1J;
        Wed,  5 Jan 2022 16:53:50 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski@canonical.com, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH] MAINTAINERS: add reviewer entry for Samsung/Exynos platform
Date:   Wed,  5 Jan 2022 22:13:41 +0530
Message-Id: <20220105164341.27479-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7bCmuq7C2auJBn3PVCwezNvGZrHx7Q8m
        i8u75rBZzDi/j8ni8Jt2VgdWj1kNvWwefVtWMXp83iQXwByVbZORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
        kV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ2x4e801oK93BVXNpxiamB8x9nF
        yMkhIWAiseX9DpYuRi4OIYHdjBIPWv6yQzifGCV6Ws8zQzifGSUm/Z7PAtPyrG0ZG0RiF6PE
        w9YjUE4Lk8SOnrlsIFVsAtoSd6dvYQKxRQQUJDb3PmMFKWIW6GSU2HrgDDNIQljAR2Jbxw4w
        m0VAVWLZo3tgNq+AjUTTzC1sEOvkJVZvOAB2h4RAP7vE708L2SESLhJPVy5ggrCFJV4d3wIV
        l5L4/G4vUDMHkJ0t0bPLGCJcI7F03jGoF+wlDlyZwwJSwiygKbF+lz5ImFmAT6L39xMmiE5e
        iY42IYhqVYnmd1ehOqUlJnZ3s0LYHhI/r50Bu1JIIFai+30b4wRGmVkIQxcwMq5ilEwtKM5N
        Ty02LTDMSy2HR05yfu4mRnDq0fLcwXj3wQe9Q4xMHIyHGCU4mJVEeP9KX0oU4k1JrKxKLcqP
        LyrNSS0+xGgKDKWJzFKiyfnA5JdXEm9oYmlgYmZmZmJpbGaoJM57On1DopBAemJJanZqakFq
        EUwfEwenVANTaRuzV1rN3rDZ3BP1K/eYJTZoOItlT1VfVdt/rr3UqGeT8Op3873zmGdpBzdU
        H82wO9umzNC+OmtBw5KglKvW7A8YI6Ol/VgeR3Gq2Nv1KJY7dJz3idriNKnttbWfas3GiZoz
        VqqpvtwTMyHGQzpQs+5C9SHnLclOCsJ7k1c5Xej+tWNeBnPnXo86OQOzqx2nNuUIP5EsTftu
        amN3pMtg/qYZf37c9Lste6JUmOt5kolBWcRCnauH5QzEF0W63djWsGTOqrPzT0s9f+l57p+j
        yr57a/SKfq9bWFh568HLpJNZSw5k3DVg2RsRcMfz6MpNgU82nFttz62wtPris/3cnr15deFz
        FLvyt69LLVZiKc5INNRiLipOBABzFMxUxgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNJMWRmVeSWpSXmKPExsWy7bCSnK782auJBi2vVC0ezNvGZrHx7Q8m
        i8u75rBZzDi/j8ni8Jt2VgdWj1kNvWwefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlbHh7zTW
        gr3cFVc2nGJqYHzH2cXIySEhYCLxrG0ZWxcjF4eQwA5GiSn3z7BCJKQlrm+cwA5hC0us/Pcc
        zBYSaGKS6FrmC2KzCWhL3J2+hQnEFhFQkNjc+4wVZBCzQC+jREvzFxaQhLCAj8S2jh3MIDaL
        gKrEskf3wGxeARuJpplb2CAWyEus3nCAeQIjzwJGhlWMkqkFxbnpucWGBUZ5qeV6xYm5xaV5
        6XrJ+bmbGMHhoaW1g3HPqg96hxiZOBgPMUpwMCuJ8P6VvpQoxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA1PBesXYfIVVqTzl6ff8mOwyBJfbNZ1yZi7P
        DF5Z29S6wuSNyFLtlksR+7Z03vLrn2Uz61ecDYtfsHrtQ8sS1XYFx2/q2YJMMed+Pn/rv2Zh
        8Cv9j2ZcvaFzFs3qDj758uARRo3CVScjzn/fvl965vv1EWUsPf/dZh8vfOvwReXG+87jXXvc
        p50u2aolF67GEuiygyOmvXdu0pO3m1Se6OvMPK7pcUP4WbrLBi0jsSudUdxrVebfW68cGMmY
        s2XBxSfa134eU05nri7X+iQnaLZ1yYaL/m61a0P4OU990Lkt/FaSp/FwbpOY7F19Abl3uydt
        +K94X+7vtOBtfeE7dds6Zi//bvfrxcVlHKpfQpVYijMSDbWYi4oTAUwi7BZ+AgAA
X-CMS-MailID: 20220105165351epcas5p100b28a19d5a5e5614ea82adf5e0037b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220105165351epcas5p100b28a19d5a5e5614ea82adf5e0037b0
References: <CGME20220105165351epcas5p100b28a19d5a5e5614ea82adf5e0037b0@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds myself as reviewer for Samsung/Exynos platform to help
in review of current and upcoming SoCs patches.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 13f9a84a617e..ddc8e8552e8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2544,6 +2544,7 @@ N:	rockchip
 
 ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+R:	Alim Akhtar <alim.akhtar@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
@@ -15110,6 +15111,7 @@ PIN CONTROLLER - SAMSUNG
 M:	Tomasz Figa <tomasz.figa@gmail.com>
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
+R:	Alim Akhtar <alim.akhtar@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
@@ -16868,6 +16870,7 @@ SAMSUNG SOC CLOCK DRIVERS
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 M:	Tomasz Figa <tomasz.figa@gmail.com>
 M:	Chanwoo Choi <cw00.choi@samsung.com>
+R:	Alim Akhtar <alim.akhtar@samsung.com>
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk.git

base-commit: 2585cf9dfaaddf00b069673f27bb3f8530e2039c
-- 
2.17.1

