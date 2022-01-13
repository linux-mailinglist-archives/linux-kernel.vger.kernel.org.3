Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E46448D7AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiAMMYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:24:44 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:25216 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiAMMYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:24:19 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220113122418epoutp03f9827941058e997e63edb954e8222fbd~J1AU-6XGg1725217252epoutp03H
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:24:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220113122418epoutp03f9827941058e997e63edb954e8222fbd~J1AU-6XGg1725217252epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076658;
        bh=xx/UL9OJbt7ya8sTDa7lIOEg/JjQH1jBY1RPaq4EsOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=je93t3wWozylY5sbYdt1Of5Jmw5mjkly9qWjXMJNQlulsM/PWR3Dgp3RbyEFUI4BW
         eXtIG/0icc7bKsWaMGmqZkSz3IGUNX1QSGy4niNRj/fURkDlg/GI6C1XUZWvgp169x
         LP0JT3P6IcigFskFmpBlT3gRZdq6kB+20/cmKWI4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220113122417epcas5p215c74a80c684d8e52bcba305cb802a37~J1AUf3GsX0949509495epcas5p2E;
        Thu, 13 Jan 2022 12:24:17 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JZNs46Ydxz4x9Pv; Thu, 13 Jan
        2022 12:24:08 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.C6.06423.8E910E16; Thu, 13 Jan 2022 21:24:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220113122408epcas5p45053d1bf0acf2d8233a98b6c1abab6eb~J1ALvt6op1113011130epcas5p4L;
        Thu, 13 Jan 2022 12:24:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220113122408epsmtrp2111c8ed7d73927a28a5f274c318fef44~J1ALyFL3T3235332353epsmtrp2G;
        Thu, 13 Jan 2022 12:24:08 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-d0-61e019e8766a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.A9.08738.7E910E16; Thu, 13 Jan 2022 21:24:07 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122406epsmtip272720627aeb46c098502890f3fd7631e~J1AJrgq7T1246112461epsmtip2S;
        Thu, 13 Jan 2022 12:24:05 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com
Subject: [PATCH 13/23] dt-bindings: arm: add Tesla FSD ARM SoC
Date:   Thu, 13 Jan 2022 17:41:33 +0530
Message-Id: <20220113121143.22280-14-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTQ/eF5INEgz1LJC0ezNvGZvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdq8fBVuMXlXXPYLGac38dkcer6ZzaLRVu/sFu0
        7j3CbnH4TTurxePrf9gc+D3WzFvD6DGroZfNY9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/
        muaye3zeJBfAGZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIT
        oOuWmQP0gJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XE
        ytDAwMgUqDAhO2Px5bnMBb84Kk48P8/SwLiZvYuRk0NCwETi+t3pQDYXh5DAbkaJM7t3MIEk
        hAQ+MUp86GWBSHxmlFj4tJ21i5EDrOPcM6j4LkaJs8unMkM4LUwSE/a3sIB0swloS9ydvgVs
        koiAm8SNxg4mkCJmgXtMEj8ONzCDJIQF7CS+z34HdgeLgKrEjQOfwWxeAVuJZ6uXskLcJy+x
        esMBZpDNnEDxu6vyQOZICCzkkDi+ZTNUjYvEptM7GCFsYYlXx7dA/SYl8fndXjaIq7MlenYZ
        Q4RrJJbOO8YCYdtLHLgyhwWkhFlAU2L9Ln2QMLMAn0Tv7ydMEJ28Eh1tQhDVqhLN765CdUpL
        TOzuhjrAQ+LVk9+skHCbwChxYbXaBEbZWQhDFzAyrmKUTC0ozk1PLTYtMMxLLYfHUnJ+7iZG
        cKLU8tzBePfBB71DjEwcjIcYJTiYlUR4+4vuJwrxpiRWVqUW5ccXleakFh9iNAUG2ERmKdHk
        fGCqziuJNzSxNDAxMzMzsTQ2M1QS5z2dviFRSCA9sSQ1OzW1ILUIpo+Jg1OqgWnrdNUZfS49
        r5OUFl2LkVY/0fsuJbXMLGxiV/qs2Qs3ehh9s001NWhgUiuImJ9X5L1syxt5zltRx2MtxRcJ
        MLzzkl9x3CSu0kYjQNd8wYG7H70n3ZXL/180Z0Vo7cQLt9wuKBhqK8RtWiNUvP31Vn1d4YT7
        37LqjH7ePsB4+thTg4/fFZ6ZT+CQcnhU9N+vW+b3u74nh/hfJKw/vGPNpePFmZ9nd+0r+dXU
        xbak+bRLmMzJyB3xl3yn2ZzonCmXvdlevMn1iHzU411dhiZzN804L7TlwmKdml3nYrMeG35u
        C5ZIu/6I0cJZW+GQ7Krqfr4txrnRlg/nnLaelR6cbB479dPDKX63tfVdnV5NV1ZiKc5INNRi
        LipOBADrP3JsHQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvO5zyQeJBteW6Vo8mLeNzeL9sh5G
        i/lHzrFabHz7g8liyp/lTBabHl9jtfjYc4/V4uGrcIvLu+awWcw4v4/J4tT1z2wWi7Z+Ybdo
        3XuE3eLwm3ZWi8fX/7A58HusmbeG0WNWQy+bx6ZVnWwed67tYfPYvKTe48qJJlaPvi2rGD3+
        Nc1l9/i8SS6AM4rLJiU1J7MstUjfLoErY/HlucwFvzgqTjw/z9LAuJm9i5GDQ0LAROLcM5Yu
        Ri4OIYEdjBKPNq9i62LkBIpLS1zfOIEdwhaWWPnvOTtEUROTxMrr+5hAEmwC2hJ3p28Bs0UE
        PCTa/t1jBiliFnjDJPH//hwWkISwgJ3E99nvwCaxCKhK3DjwGczmFbCVeLZ6KSvEBnmJ1RsO
        MINcxAkUv7sqDyQsJGAjce7VerYJjHwLGBlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefn
        bmIEB7qW1g7GPas+6B1iZOJgPMQowcGsJMLbX3Q/UYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
        ha6T8UIC6YklqdmpqQWpRTBZJg5OqQami53SyQf5Um7WPXL5cu/4RccPL8v/bdpyXXrGD++V
        O+zuXSovmjFRUYRhZXsxW4T/oTn32O4t/veqyKTsf+xykcVSlw0Ffx9ljOTx+fJOIvQGZ+CD
        bznbZYt36bzf3yE3XTEpoGXphPeiWy1vPUjTbmDYvDs3/qr0Tpm5z6pyTn3bVhcQx2fNoFfb
        YXKu4MHv6NvMj5nmHOcOkdxlMS3yztHe5IMnWXIa2XrlKlh+tx5ruvR+57qieQ7aqkxTDgo1
        MFy2Em5ddVEgxTKv5vtEKxfxVYwpdwT6k3mdBdpUX1dLORq6bjpfuWEXt/jXb8sFHEK5ns2t
        mTihZ4Hy5XYG5wP2NQrO9qo5jfobjU4qsRRnJBpqMRcVJwIAhtq/CeMCAAA=
X-CMS-MailID: 20220113122408epcas5p45053d1bf0acf2d8233a98b6c1abab6eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122408epcas5p45053d1bf0acf2d8233a98b6c1abab6eb
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122408epcas5p45053d1bf0acf2d8233a98b6c1abab6eb@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the Tesla FSD ARM SoC.

Cc: linux-fsd@tesla.com
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 .../devicetree/bindings/arm/tesla.yaml        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tesla.yaml

diff --git a/Documentation/devicetree/bindings/arm/tesla.yaml b/Documentation/devicetree/bindings/arm/tesla.yaml
new file mode 100644
index 000000000000..9f89cde76c85
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tesla.yaml
@@ -0,0 +1,25 @@
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
+          - const: tesla,fsd
+
+additionalProperties: true
+
+...
-- 
2.17.1

