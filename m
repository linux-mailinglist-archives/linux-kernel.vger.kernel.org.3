Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F43492945
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345907AbiARPCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:02:12 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:46253 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242440AbiARPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:01:12 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220118150110epoutp026e886c8bc37286d179c99a2ae52800c9~LZXug44Ho2334523345epoutp02a
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:01:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220118150110epoutp026e886c8bc37286d179c99a2ae52800c9~LZXug44Ho2334523345epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642518070;
        bh=PcTt3YGY6vlwG4bvYuXrG16kgcqDBN+pACJzHGsq8jA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igIKdxkVAIwNFzSFA34ERNbQOBVl8B5lcy7LbfBrx3VC8KK9grJnUpX+96iqswDvp
         X9uO4xLK4sI+il14LoU+JDCP+evNO4qryI4ZTdpqDR46pbc1BVLtAOhmanF3OmKuf5
         41b5wFlVL/DJCPUNejUhTQPU7MfWKPwM5/ykAm7Y=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220118150109epcas5p3b34fbe47c918c913db9362faffea6be1~LZXtuwGZd0440604406epcas5p3z;
        Tue, 18 Jan 2022 15:01:09 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JdX5r4HqMz4x9Pr; Tue, 18 Jan
        2022 15:01:04 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.BE.46822.6D5D6E16; Tue, 18 Jan 2022 23:59:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220118150104epcas5p4ac6fdc739d21c7d7eb2e53e469466487~LZXoYVAkG1990519905epcas5p4o;
        Tue, 18 Jan 2022 15:01:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220118150104epsmtrp16096523196d77ea9c9a284bb77f756fa~LZXoSxuew2079320793epsmtrp16;
        Tue, 18 Jan 2022 15:01:04 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-45-61e6d5d68a88
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.F0.08738.F26D6E16; Wed, 19 Jan 2022 00:01:03 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150101epsmtip118c18c0e2437615766410e9afc8bd305~LZXmEuoqH0520405204epsmtip1X;
        Tue, 18 Jan 2022 15:01:01 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com
Subject: [PATCH v2 13/16] dt-bindings: arm: add Tesla FSD ARM SoC
Date:   Tue, 18 Jan 2022 20:18:48 +0530
Message-Id: <20220118144851.69537-14-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118144851.69537-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmhu61q88SDX7t5rB4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLQ6/aWe1eHz9D5uDgMeaeWsYPX7/msToMauhl81j06pONo871/aweWxeUu9x
        5UQTq0ffllWMHv+a5rJ7fN4kF8AVlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA/SKkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECv
        ODG3uDQvXS8vtcTK0MDAyBSoMCE7Y+nqQ6wFxzkrbj+7yNrAeIe9i5GTQ0LAROJfywrmLkYu
        DiGB3YwS+34cZYJwPjFKvP91kwXC+cwosXzRPCaYlp2HtrJBJHYxSny8vYUNJCEk0MIkcXOD
        MYjNJqAtcXf6FrAGEQE3iRuNHWBjmQXeMklM3/cdrEFYwFGi9e0jFhCbRUBVYsqfZqAiDg5e
        AVuJvrtqEMvkJVZvOMAMYnMChac2TAVbLCGwlkNi/ur/LBBFLhIPfhxnhLCFJV4d3wL1nJTE
        y/42dpCZEgLZEj27jCHCNRJL5x2DarWXOHBlDgtICbOApsT6XfogYWYBPone30+YIDp5JTra
        hCCqVSWa312F6pSWmNjdzQphe0hc7O9ghwTJBEaJbwcXsE1glJ2FMHUBI+MqRsnUguLc9NRi
        0wKjvNRyeDwl5+duYgQnUC2vHYwPH3zQO8TIxMF4iFGCg1lJhFeq/lmiEG9KYmVValF+fFFp
        TmrxIUZTYIhNZJYSTc4HpvC8knhDE0sDEzMzMxNLYzNDJXHe0+kbEoUE0hNLUrNTUwtSi2D6
        mDg4pRqYvGpOmFUkTb0kkHp67cu5vNNjNri8sV8ZbPbOlFVmhcO7ni313VbqK7pZ5Iy+J0Z5
        Nl+NCNRYkP57lvgspk27rY8XhQvfa/p/NXRae9dLu/u7xfncDkQebN11JKdUOmy9ktm3VUEH
        HqVmlD0Nr1Hs+Xp4Yl1c1Pmtf5NzC8qlLxwVjVD7OX3SnQb5xMAPizOObdRtfjj9wanyWVXz
        gzT/quZ1tx7VF53y3JX/fZKF5Zf+pqkCZ9f9bLLYxssdm23WvTSf4cKnWf5sfUvZhB4eLu/0
        PB2i4Gr37EKg7OLeT0k2vzp2fHzA5NPfGJ/I/GorV/bNWI7/O/j6Njr8OtZ21W32af9Wu28e
        whIzN2kpsRRnJBpqMRcVJwIAkC+5kykEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnK7+tWeJBqeWWFs8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNaPL7+h81BwGPNvDWMHr9/TWL0mNXQy+axaVUnm8eda3vYPDYvqfe4
        cqKJ1aNvyypGj39Nc9k9Pm+SC+CK4rJJSc3JLEst0rdL4MpYuvoQa8Fxzorbzy6yNjDeYe9i
        5OSQEDCR2HloK1sXIxeHkMAORomTc09AJaQlrm+cAGULS6z895wdoqiJSWLjzz+MIAk2AW2J
        u9O3MIHYIgIeEm3/7jGDFDEL/GWS+Pr6IViRsICjROvbRywgNouAqsSUP81ADRwcvAK2En13
        1SAWyEus3nCAGcTmBApPbZjKBmILCdhIXFw5jXkCI98CRoZVjJKpBcW56bnFhgVGeanlesWJ
        ucWleel6yfm5mxjB4a+ltYNxz6oPeocYmTgYDzFKcDArifBK1T9LFOJNSaysSi3Kjy8qzUkt
        PsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoEp6kpfq3nphbTTn18473MO2WTTHdbG
        bvbGUp3v19IYjXRmbj7GtGf7nubbh/59NO+AxOMYlU0xF5dFTPHmUyi17OZan3pruXx2c1Ou
        Y3vi6TURq4U9Xu1/xTgp1flZwcn7nxJeqbpM1HK7vG/mqbCFYf+NH+1bXH2ssu4Vu9umZa+j
        6vZO2/m2quZlhFRBRFFoH0PEqtB5xw9ozFVP3nvgjXXEmhnvLvs03jPszfqx28NVYVFG1oeA
        FMY13Q5O23iaDvMLaj+99Fx6o7n3SmbVwz5bGTtEO9dWz7HLaHYVLTtwRtplj8yiqO45Jg7f
        Dt29Z7VOcvLFvYFJLc08W49JXq07m3LevFQs4vNLoS4lluKMREMt5qLiRACr6EO97gIAAA==
X-CMS-MailID: 20220118150104epcas5p4ac6fdc739d21c7d7eb2e53e469466487
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150104epcas5p4ac6fdc739d21c7d7eb2e53e469466487
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150104epcas5p4ac6fdc739d21c7d7eb2e53e469466487@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the Tesla FSD ARM SoC.

Cc: linux-fsd@tesla.com
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

