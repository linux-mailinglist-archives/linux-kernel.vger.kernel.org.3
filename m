Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE0A49752E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbiAWTU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:20:58 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:45639 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239910AbiAWTUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:20:35 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220123192034epoutp04fcab87b72751c43e598966738cc6e883~M-Ionia_h0640506405epoutp04m
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:20:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220123192034epoutp04fcab87b72751c43e598966738cc6e883~M-Ionia_h0640506405epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965634;
        bh=YgW3z7lJwg3J4ZCyoIc9l5itBRt/WiMPVpw0oj8secs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lef4rlqvRYDT+1bUMyvlU/XMdWdY0t1rBDqV6Bu3PlofvMrtl83FNUHEqqSzscWg2
         6JmefOCoq5V5APItf+zp0LqZsKwEpffWPdG/Q6/0N60hYuu1u6jtp6gfsiKhDyjj/q
         7wcwGh0yOSeZqADPEdyaoymWGUz677AhcElx5KVg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220123192033epcas5p1fc6998015e44cdd40aec90fb4d53adba~M-In-5o720430304303epcas5p1G;
        Sun, 23 Jan 2022 19:20:33 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Jhjcr3dmfz4x9Pp; Sun, 23 Jan
        2022 19:20:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.47.06423.C7AADE16; Mon, 24 Jan 2022 04:20:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220123192027epcas5p155d6d7c5146a090962bc655bf3557629~M-Ih2pmZr0431504315epcas5p1v;
        Sun, 23 Jan 2022 19:20:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220123192027epsmtrp2f5cfbfbbd49940f18e9d21e2f1290409~M-Ih1s1Kt2018820188epsmtrp2m;
        Sun, 23 Jan 2022 19:20:27 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-a0-61edaa7ccb0e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.F7.29871.A7AADE16; Mon, 24 Jan 2022 04:20:27 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123192024epsmtip1e8cadfb9cc771be88f76dee2cd01b041~M-IfoJWR80551905519epsmtip1Z;
        Sun, 23 Jan 2022 19:20:24 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v4 13/16] dt-bindings: arm: add Tesla FSD ARM SoC
Date:   Mon, 24 Jan 2022 00:37:26 +0530
Message-Id: <20220123190729.1852-14-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmhm7NqreJBkv/iFk8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMVVea2At6uSq+dRxja2Ccy9HFyMkhIWAi0TOx
        ma2LkYtDSGA3o8SE5UfZIZxPjBJH9n5mhHC+ATnrZ7DBtPx82c4CkdjLKDGnZy5UfwuTxNZL
        H5hBqtgEtCXuTt/CBGKLCLhJ3GjsYAIpYhb4zySxsWcZ2ChhAUeJgzs2gDWwCKhKdPd+ZAex
        eQVsJBad6WOEWCcvsXrDAbAaTqB476sPrCCDJAS2cEhc/LgN6iYXiVWfe1ghbGGJV8e3sEPY
        UhKf3+0FquEAsrMlenYZQ4RrJJbOO8YCYdtLHLgyhwWkhFlAU2L9Ln2QMLMAn0Tv7ydMEJ28
        Eh1tQhDVqhLN765CdUpLTOzuhlrqIXFoTRM06PoZJZ7+eso6gVF2FsLUBYyMqxglUwuKc9NT
        i00LDPNSy+ExlZyfu4kRnE61PHcw3n3wQe8QIxMH4yFGCQ5mJRHegvxXiUK8KYmVValF+fFF
        pTmpxYcYTYFBNpFZSjQ5H5jQ80riDU0sDUzMzMxMLI3NDJXEeU+nb0gUEkhPLEnNTk0tSC2C
        6WPi4JRqYJpydv7bSqeHV9PXHUoNujqxoGriWosbVdm7pSfL83hx7FnvemnWw63PBWt/bZyb
        NGNClvHDo7mGC5hNHz+SXRv7faYLi97kS++8I5+xxq8TWM7UvlPN1jRFpU1X22ONerbO5xKX
        y8KNKcuWXWjvtdyf18NkpHvqvWvfD/XJb41fzPa/nFxRIjBv+t29xo9E3uqun/B5qUlsbWBM
        gvq9GRWxliWeDttXnXd7veXd06CdOyPPXvl86ZRkXbx4cGbWrJKS88lr7X/Ocnqg+naO10Gt
        m/pXD114JF7DLcOz38P+cco/678C8+d8Mp78ObA/1OxhpkB3+/GX9jvbX3En62+e0Wm2ptV3
        jf8cjy4WSTElluKMREMt5qLiRACjWVwlMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnG71qreJBltbmSwezNvGZvF30jF2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lkt/l3byGLx+PofNgdBjzXz1jB6/P41idFjVkMvm8emVZ1sHneu7WHz
        2Lyk3uPKiSZWj74tqxg9/jXNZff4vEkugCuKyyYlNSezLLVI3y6BK2PVlSb2gl6uim8dx9ga
        GOdydDFyckgImEj8fNnO0sXIxSEksJtRYvb0V8wQCWmJ6xsnsEPYwhIr/z1nhyhqYpKY/HIG
        WBGbgLbE3elbmEBsEQEPibZ/95hBipgFJjJLbNx7lgUkISzgKHFwxwawBhYBVYnu3o9gU3kF
        bCQWneljhNggL7F6wwGwGk6geO+rD6xdjBxA26wlJhyVm8DIt4CRYRWjZGpBcW56brFhgWFe
        arlecWJucWleul5yfu4mRnAkaGnuYNy+6oPeIUYmDsZDjBIczEoivAX5rxKFeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYMqPvj5BUK7g0/qeGqmFjYph
        e0Wqp56VPtPvvPflweeSByMfR65wU9QpatnKUryf2+Ttgf55FgnzP7c4Cgf9LzM/KrXpZLyT
        hMSu7XtnKL2752+0PME/uak1zXY126kHu+59/cHuW3bI0bC6qVbKUco1XIdvsXph6Zvsz4Ff
        HjsKP2FWuuDLc2212GOBcyenPN/6bm0X35kI3Zyv2VyS6xLYH4mbWyX6LdZZcMj2gvwiwbPP
        JmuU2Av1XBM0/bpb8GlpzeL/OvPste64b+G53CqzerFgQm9k3yvGicn7TlwIt9Hcw5A623bn
        7Ly7emdVP2/8fIOVPXZl69ELdU7mUfbzBAz8vbdcl955p/4CnxJLcUaioRZzUXEiABXpj/Dz
        AgAA
X-CMS-MailID: 20220123192027epcas5p155d6d7c5146a090962bc655bf3557629
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123192027epcas5p155d6d7c5146a090962bc655bf3557629
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123192027epcas5p155d6d7c5146a090962bc655bf3557629@epcas5p1.samsung.com>
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

