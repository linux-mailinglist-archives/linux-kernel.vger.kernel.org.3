Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4B496441
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381913AbiAURnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:43:00 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:16404 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381915AbiAURlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:41:25 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220121174119epoutp02dcf912e73aa2488ec3036bcebbad3d63~MWfahKQK30803608036epoutp02T
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:41:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220121174119epoutp02dcf912e73aa2488ec3036bcebbad3d63~MWfahKQK30803608036epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786879;
        bh=YgW3z7lJwg3J4ZCyoIc9l5itBRt/WiMPVpw0oj8secs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+XkLyAPBLSJ+/dmtrbHTz12tURrtnRkcJivvJ39hZ6/jGi9eAyaR4/28fvRQBg6O
         PbuxitOGyeepizQNrHzMOdCxDQtJUvN1h/y80nCYe2W4gWSTfjk6hD8Q+VTAHH8q9I
         jJk5pMGBAelAWAqtxtAU4tB6NMq5tp9SRBB3vv/g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220121174119epcas5p21e304270a5cc2addb3eba3976dc41eea~MWfZ5v-3s0949909499epcas5p2j;
        Fri, 21 Jan 2022 17:41:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JgRWG06Khz4x9Pq; Fri, 21 Jan
        2022 17:41:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.30.06423.930FAE16; Sat, 22 Jan 2022 02:41:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220121174113epcas5p1e0ef0c9244eb08628b73d1477444be69~MWfUH0RYb1336113361epcas5p1U;
        Fri, 21 Jan 2022 17:41:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220121174113epsmtrp124c29d9739ae2af37a083a46c9ce820f~MWfUG_Zt42608726087epsmtrp1g;
        Fri, 21 Jan 2022 17:41:13 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-e8-61eaf0399325
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.96.29871.830FAE16; Sat, 22 Jan 2022 02:41:12 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174110epsmtip240bd5fa07b613b88dee8e20fa908d9b9~MWfRxEVNH1230012300epsmtip2Z;
        Fri, 21 Jan 2022 17:41:10 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v3 13/16] dt-bindings: arm: add Tesla FSD ARM SoC
Date:   Fri, 21 Jan 2022 22:58:37 +0530
Message-Id: <20220121172840.12121-14-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmhq7lh1eJBss7zS0ezNvGZvF30jF2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lkt/l3byGLx+PofNgdBjzXz1jB6/P41idFjVkMvm8emVZ1sHneu7WHz
        2Lyk3uPKiSZWj74tqxg9/jXNZff4vEkugCsq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzA
        UNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6B8lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFK
        ToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGqitN7AW9XBXfOo6xNTDO5ehi5OSQEDCRaFr3
        g7GLkYtDSGA3o8Tbx79YQRJCAp8YJSZMgrK/MUrsaBaBaehY8Z4ZomEvo8SueZvZIJwWJolj
        X16AdbAJaEvcnb6FCcQWEXCTuNHYwQRSxCzwn0liY88yNpCEsICjxLt3R8GKWARUJd7unsUI
        YvMK2Eq83POOEWKdvMTqDQeYQWxOoPjrs/PAVksIbOGQuD5jHztEkYvE/hUnWSBsYYlXx7dA
        xaUkXva3AdkcQHa2RM8uY4hwjcTSecegyu0lDlyZwwJSwiygKbF+lz5ImFmAT6L39xMmiE5e
        iY42IYhqVYnmd1ehOqUlJnZ3s0LYHhJNS19DQ3ECMBQ/fWSZwCg7C2HqAkbGVYySqQXFuemp
        xaYFhnmp5fB4Ss7P3cQITqVanjsY7z74oHeIkYmD8RCjBAezkghvQf6rRCHelMTKqtSi/Pii
        0pzU4kOMpsAgm8gsJZqcD0zmeSXxhiaWBiZmZmYmlsZmhkrivKfTNyQKCaQnlqRmp6YWpBbB
        9DFxcEo1MDG1hRXVvOV1WW+w/KT6m2++vpqKS0X9tIsf6Dpu2fq8w4GNcRqLdf/VUwmMR/pm
        TGeaXJjDu7Ykr/z31NhPGXIbvd5LSh3KbLgZHVuuv3vSLD5ml0t5U1zlTj1tS6n/elrVa6v4
        ht8Mb9jvZsx7sb3AanGKRMS/G6vu3Puh0idfUnbnly/7LhmLsxMqDDbwTHizflnKa95qr4JM
        m4fG2w49736uN12gf05qA5+GrAd7wcQtB74ueWaxNTTo/rMuRpW0idtX8npkVr30SH1byB7p
        Wvhvtdbm8/YTIt73bTj28drXN3lh/QI59SHq/saXrBP7Z3o+OfxV9spZbp/7G1o1z3Z7VP7y
        sTS9+NRDVYmlOCPRUIu5qDgRAMzUEmUuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSvK7Fh1eJBrP7zCwezNvGZvF30jF2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lkt/l3byGLx+PofNgdBjzXz1jB6/P41idFjVkMvm8emVZ1sHneu7WHz
        2Lyk3uPKiSZWj74tqxg9/jXNZff4vEkugCuKyyYlNSezLLVI3y6BK2PVlSb2gl6uim8dx9ga
        GOdydDFyckgImEh0rHjP3MXIxSEksJtR4vabuewQCWmJ6xsnQNnCEiv/PWeHKGpikph/dxEb
        SIJNQFvi7vQtTCC2iICHRNu/e2CTmAUmMkts3HuWBSQhLOAo8e7dUbAiFgFVibe7ZzGC2LwC
        thIv97xjhNggL7F6wwFmEJsTKP767DwwW0jARqJ51lamCYx8CxgZVjFKphYU56bnFhsWGOal
        lusVJ+YWl+al6yXn525iBMeCluYOxu2rPugdYmTiYDzEKMHBrCTCW5D/KlGINyWxsiq1KD++
        qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJhEX53V/VD5wcUuqfPu251uc
        20rf1U1nnPS8zKaGfVFNb1PXqpNaxHrYZalpT/rzR44MJVX1C9Z9k1h5xfhvVsKJGRJRKiZF
        BdHb/ILKvweGPG1Z8zRYXGOybpgne/0aRy+1a/VzHVSORWTKLZmbHBBRd5XnwAP1yKXx827v
        M/x+0Ox2oxKbvjh7GI/r2reSnMt07t997ihbF9rj35MevsF1j1wKx8rOmT6W232n3FHbt2iZ
        wsV9Nn/j+lkLJzsn7s7tfvSTi20xo+PDZycMmrR0jbblPg0ud6iev2Rpye+eKRvVb50xt5s8
        /8eVBeJfVkXlPk7PrLTuSl1cc8LAo2bLpeBdgmabThw0rAxQYinOSDTUYi4qTgQAms3JEPQC
        AAA=
X-CMS-MailID: 20220121174113epcas5p1e0ef0c9244eb08628b73d1477444be69
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174113epcas5p1e0ef0c9244eb08628b73d1477444be69
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174113epcas5p1e0ef0c9244eb08628b73d1477444be69@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the Tesla FSD ARM SoC.

Cc: linux-fsd@tesla.com
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 .../devicetree/bindings/arm/tesla.yaml        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tesla.yaml

diff --git a/Documentation/devicetree/bindings/arm/tesla.yaml b/Documentation/devicetree/bindings/arm/tesla.yaml
new file mode 100644
index 000000000000..09856da657dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tesla.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/tesla.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tesla Full Self Driving(FSD) platforms device tree bindings
+
+maintainers:
+  - Alim Akhtar <alim.akhtar@samsung.com>
+  - linux-fsd@tesla.com
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: FSD SoC board
+        items:
+          - enum:
+              - tesla,fsd-evb   # Tesla FSD Evaluation
+          - const: tesla,fsd
+
+additionalProperties: true
+
+...
-- 
2.25.1

