Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF05448D7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbiAMMYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:24:19 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:25058 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbiAMMYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:24:02 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220113122401epoutp0390f4630db62f093ea387477809618bf9~J1AFi7X8D1725217252epoutp03B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:24:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220113122401epoutp0390f4630db62f093ea387477809618bf9~J1AFi7X8D1725217252epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076641;
        bh=rp/+5Bru2KjQ5pHBitHpawEve8XdTr5ABZ3v/hh4wT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhstM27bvueoKXP+IYM3edeHxf4ow8j7AWv8x1DT1N4M/Z9RKXMKROZaqtFQDMGNN
         NXLxm2XeGPMpYewyjOo8n9YAjVion6yeK+ZXSI0Axuc0EmRe+GjnqLu2QXCHeVR7Uc
         5V7mcS1paBx/J4Xy2cqfBGVsB3AknzsDX/EqUYmc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220113122400epcas5p11c1d247c739a5fe0d59ccca5a4e3e2f6~J1AEwW4qI1610816108epcas5p1M;
        Thu, 13 Jan 2022 12:24:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JZNrq4Nz4z4x9Q0; Thu, 13 Jan
        2022 12:23:55 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.51.05590.BD910E16; Thu, 13 Jan 2022 21:23:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220113122354epcas5p19e5cebe9e85e9ba1758fa0b9d7d1ef75~J0--NlPcG1969919699epcas5p1J;
        Thu, 13 Jan 2022 12:23:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220113122354epsmtrp2726a14cb6d3ebe32ca4d98515dec9ed7~J0--Mz2fj3027830278epsmtrp2d;
        Thu, 13 Jan 2022 12:23:54 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-d2-61e019dbe6bb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.A9.08738.AD910E16; Thu, 13 Jan 2022 21:23:54 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122352epsmtip2a4388db5d0a06d9505fca78827532767~J0-9HEeD-1246412464epsmtip2n;
        Thu, 13 Jan 2022 12:23:52 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com
Subject: [PATCH 10/23] dt-bindings: pinctrl: samsung: Add compatible for
 Tesla FSD SoC
Date:   Thu, 13 Jan 2022 17:41:30 +0530
Message-Id: <20220113121143.22280-11-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTS/e25INEg8mLuC0ezNvGZvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdq8fBVuMXlXXPYLGac38dkcer6ZzaLRVu/sFu0
        7j3CbnH4TTurxePrf9gc+D3WzFvD6DGroZfNY9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/
        muaye3zeJBfAGZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIT
        oOuWmQP0gJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XE
        ytDAwMgUqDAhO+P77E9MBTM5KxYv38XYwPidvYuRk0NCwESi4eAK5i5GLg4hgd2MEnc3HIBy
        PjFKTDl8iRHC+cwo0fzlJRtMy9S9+8DahQR2MUqsfMsNUdTCJPF75lWwIjYBbYm707cwgdgi
        Am4SNxo7mECKmAXuMUn8ONzADJIQFoiQ2Hi6A6yBRUBV4veN+SxdjBwcvAK2EjenJkEsk5dY
        DXYSBwcnUPjuqjyQMRICczkkOl4cYYKocZG4+OkqK4QtLPHq+Bao36QkPr/bywbSKyGQLdGz
        yxgiXCOxdN4xFgjbXuLAlTlgW5kFNCXW79IHCTML8En0/n7CBNHJK9HRJgRRrSrR/O4qVKe0
        xMTubqilHhJHbzSzQUJhAqPEqps7mCYwys5CmLqAkXEVo2RqQXFuemqxaYFxXmo5PJqS83M3
        MYJTpZb3DsZHDz7oHWJk4mA8xCjBwawkwttfdD9RiDclsbIqtSg/vqg0J7X4EKMpMMAmMkuJ
        JucDk3VeSbyhiaWBiZmZmYmlsZmhkjjvqfQNiUIC6YklqdmpqQWpRTB9TBycUg1M1zeYPcn+
        qPnWQ9PdYFXvuaM14Y943k/4suNXesfrBX0hNxLPtuzO4d3StCmo+Ujz41zW+2XHokLXCp8L
        EJynxa5l45C8NJHX2PGQ+gTBTSKe+u/NJwXfPym136++usLRaSLj/7Vzp2hV9W9eyi7+UI71
        QkTBBMO2K0uTqg42pCxgtdhxMeiu1O6vfyNj/R6dObjig/9T7ltxgtG3bc4anFhXtFKmcY48
        d0remRdti3+xB1+SUWmWW68mN/fSJcfQL2ZaonbO8Ser8g5aXnjcwyktpPW1dMNf0aywjQfn
        lhRO432+c/u+L+xSfS4q7WxHv+rsF6yNVBeYutxm/YTjOoJWzBdjZQzTOZ0msq9QYinOSDTU
        Yi4qTgQAu82AIh4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvO4tyQeJBuc+8Fg8mLeNzeL9sh5G
        i/lHzrFabHz7g8liyp/lTBabHl9jtfjYc4/V4uGrcIvLu+awWcw4v4/J4tT1z2wWi7Z+Ybdo
        3XuE3eLwm3ZWi8fX/7A58HusmbeG0WNWQy+bx6ZVnWwed67tYfPYvKTe48qJJlaPvi2rGD3+
        Nc1l9/i8SS6AM4rLJiU1J7MstUjfLoEr4/vsT0wFMzkrFi/fxdjA+J29i5GTQ0LARGLq3n1A
        NheHkMAORommtkMsEAlpiesbJ0AVCUus/PccqqiJSeLsmi3MIAk2AW2Ju9O3MIHYIgIeEm3/
        7jGDFDELvGGS+H9/DtgkYYEwiWuNz8GKWARUJX7fmA8U5+DgFbCVuDk1CWKBvMTqDQeYQcKc
        QOG7q/JAwkICNhLnXq1nm8DIt4CRYRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnCg
        a2ntYNyz6oPeIUYmDsZDjBIczEoivP1F9xOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkv
        JJCeWJKanZpakFoEk2Xi4JRqYHKpC9hgH7/2n+NVO37nMOUN11cE3N7+2F+2bXlG6h1l5Q8f
        /B9VLdRY3LfMgSF9F4s0Z1m4xYd3Hxet3TCZUcLaXb3ktCHPtCm/HnCa/f76KMxCbPdU4aeC
        a1d79jZX96y/da6xqvD2/yi7LWl6U+ddmlvYrq7Brme7YF8l9841eqtYpp/6v/SdGLeT1nf7
        +X3NEfoGqc9fqAvvZ3RfFMG+fdLxhUv/xf5PKrrjNZXBUXdb4avcT7d7OY12hwZPV/l3LeXB
        Vc29VziXcVauD+TVUZ23tvhAS+BG9sO+d09Lq13rf2e6ImD78lLDRQ/VgzfJzpwqESkssuDR
        uYOXp86dwzGbcULJJH5B76z47UpKLMUZiYZazEXFiQB+xuyu4wIAAA==
X-CMS-MailID: 20220113122354epcas5p19e5cebe9e85e9ba1758fa0b9d7d1ef75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122354epcas5p19e5cebe9e85e9ba1758fa0b9d7d1ef75
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122354epcas5p19e5cebe9e85e9ba1758fa0b9d7d1ef75@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for Tesla Full Self-Driving SoC. The
pinctrl hardware IP is similar to what found on most of the
exynos series of SoC, so this new compatible is added in
samsung pinctrl binding.

Cc: linux-fsd@tesla.com
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index b8b475967ff9..ba972998a0e4 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -24,6 +24,7 @@ Required Properties:
   - "samsung,exynos7-pinctrl": for Exynos7 compatible pin-controller.
   - "samsung,exynos850-pinctrl": for Exynos850 compatible pin-controller.
   - "samsung,exynosautov9-pinctrl": for ExynosAutov9 compatible pin-controller.
+  - "tesla,fsd-pinctrl": for Tesla FSD SoC compatible pin-controller.
 
 - reg: Base address of the pin controller hardware module and length of
   the address space it occupies.
-- 
2.17.1

