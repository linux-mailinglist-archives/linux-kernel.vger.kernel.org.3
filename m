Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DBB49825F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbiAXOal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:30:41 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:42268 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbiAXO37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:29:59 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220124142957epoutp0261a2cf4044e6628cd0e18ce19ac78801~NO0L5fGcZ3229932299epoutp02k
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:29:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220124142957epoutp0261a2cf4044e6628cd0e18ce19ac78801~NO0L5fGcZ3229932299epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034597;
        bh=YgW3z7lJwg3J4ZCyoIc9l5itBRt/WiMPVpw0oj8secs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoYeOLglT4LQLNVfn7yofo6KlWqwZTMSNUi3bwv9c7Po0HAU2jF3AqQPVKZ45YJx8
         iSBz5kuUg9oMbUcLR2n/KJHpAIi/RMqSuh9d+E06cKNCta75EMWskH8CCDeG1TEv08
         ZgwMFb3y3I1oBsdKzHIsB27li2YVz1/PWfbusEYY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220124142956epcas5p13f8f378e6195f7b833834ac16fbe0d94~NO0Kmysh_3199131991epcas5p1d;
        Mon, 24 Jan 2022 14:29:56 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JjC734gFWz4x9Pv; Mon, 24 Jan
        2022 14:29:51 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.34.05590.FD7BEE16; Mon, 24 Jan 2022 23:29:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220124142951epcas5p255712c3a9e37b9542687587d8114bda3~NO0FgkVJt0974809748epcas5p2R;
        Mon, 24 Jan 2022 14:29:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220124142951epsmtrp2cdf004ff545797c11fa797684604776d~NO0Ffs9YI1656816568epsmtrp2Q;
        Mon, 24 Jan 2022 14:29:51 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-d9-61eeb7df3ed8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.EA.29871.ED7BEE16; Mon, 24 Jan 2022 23:29:50 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142947epsmtip10fef31641485ff0029b48b28d32a719c~NO0CTiTtM2189021890epsmtip1E;
        Mon, 24 Jan 2022 14:29:47 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v5 13/16] dt-bindings: arm: add Tesla FSD ARM SoC
Date:   Mon, 24 Jan 2022 19:46:41 +0530
Message-Id: <20220124141644.71052-14-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmhu797e8SDRbMU7B4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLQ6/aWe1+HdtI4vF4+t/2BwEPdbMW8Po8fvXJEaPWQ29bB6bVnWyedy5tofN
        Y/OSeo8rJ5pYPfq2rGL0+Nc0l93j8ya5AK6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMD
        Q11DSwtzJYW8xNxUWyUXnwBdt8wcoH+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUp
        OQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZq640sRf0clV86zjG1sA4l6OLkZNDQsBEYt2L
        6yxdjFwcQgK7GSV235jGDOF8YpSY+bGNEcL5xigxY9ofNpiW3Y+mgNlCAnsZJd7Py4coamGS
        uPboJDNIgk1AW+Lu9C1MILaIgJvEjcYOJpAiZoH/TBIbe5YBdXNwCAs4ShxaUwxSwyKgKvFo
        /10WEJtXwFZi8vsuVohl8hKrNxwAm8kJFJ+38BvYHAmBHRwSXeePMEIUuUi8u32NGcIWlnh1
        fAs7hC0l8fndXrBdEgLZEj27jCHCNRJL5x1jgbDtJQ5cmcMCUsIsoCmxfpc+SJhZgE+i9/cT
        JohOXomONiGIalWJ5ndXoTqlJSZ2d0Nd6SEx+eIpaMBNYJRo/DuDeQKj7CyEqQsYGVcxSqYW
        FOempxabFhjnpZbD4yk5P3cTIziVannvYHz04IPeIUYmDsZDjBIczEoivFUp7xKFeFMSK6tS
        i/Lji0pzUosPMZoCg2wis5Rocj4wmeeVxBuaWBqYmJmZmVgamxkqifOeSt+QKCSQnliSmp2a
        WpBaBNPHxMEp1cC0ODxHWNlL+mLug4vcIVqPz+46u/ybsvTMiwUSIkV+ltPDApesq3rInX5+
        88Utqm9T/h982PDx5bZPLqHeX1urWW57bO483HZj21Trn2ZBwb9mcq/9UJU5p+xSjItg77dS
        g8WPfvbHM1U+2HVJ/pXqqnTHvOf/C77qBM9Mj3a6mtZ99TlH0or2Bb9V/d/Irzgf/Jbp0jdf
        qbtv2Qp8Fj7qlzGX1buxfW8b99xzfAwrLpUztp7h2XGm8PoEJcZ/Rue8D0+cy6Fw74x7Iutu
        5d7NJXPc/xw7LDJ/7t70P29b814n7ll/xF+ixHD5o7IV0fMPT+CUWe/28mzaBf9N+uwXa67p
        vA2eInOoxDxr4x3uciWW4oxEQy3mouJEAB98laMuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnO697e8SDR6stbR4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLQ6/aWe1+HdtI4vF4+t/2BwEPdbMW8Po8fvXJEaPWQ29bB6bVnWyedy5tofN
        Y/OSeo8rJ5pYPfq2rGL0+Nc0l93j8ya5AK4oLpuU1JzMstQifbsEroxVV5rYC3q5Kr51HGNr
        YJzL0cXIySEhYCKx+9EUti5GLg4hgd2MEg9uNbBAJKQlrm+cwA5hC0us/PecHaKoiUniatsV
        VpAEm4C2xN3pW5hAbBEBD4m2f/eYQYqYBSYyS2zcexZoEgeHsICjxKE1xSA1LAKqEo/23wVb
        wCtgKzH5fRcrxAJ5idUbDjCD2JxA8XkLvzGBtAoJ2Eic+60ygZFvASPDKkbJ1ILi3PTcYsMC
        w7zUcr3ixNzi0rx0veT83E2M4DjQ0tzBuH3VB71DjEwcjIcYJTiYlUR4q1LeJQrxpiRWVqUW
        5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAJOWaKfLbov1ZMyvXzle+
        3foC6/c3vXPw+b+koTGpSl7w9pHohRMat5RcUntx49VJ7S7e3PwZvH6a1iEWfOotgdLqbS8i
        vSSPiah/dYm8/zdcgG9Cnvs8kx88s06fidsdkqoRUVEUWBNZvvnCNIlZTBVXTqzafeHigayj
        WQZptlG/9z8Tb98us+6NeruTNjt7cQvXiehVL9LuNQQaVM+SjLPd5mI6j3FbPcu5R7Uhglk3
        17BxVB/mm3M/9STPt3K3hVo/30WkHfY/kGuvbuu28f2MXW6+idpqT1as8XC+lRynzn/yx8Kr
        WnfWzlp1ZV/Yp/s9Yf47BK9b3QkzfrPiZPzXSxsDT2iLLIuSnGynxFKckWioxVxUnAgAWNXU
        MPICAAA=
X-CMS-MailID: 20220124142951epcas5p255712c3a9e37b9542687587d8114bda3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142951epcas5p255712c3a9e37b9542687587d8114bda3
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142951epcas5p255712c3a9e37b9542687587d8114bda3@epcas5p2.samsung.com>
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

