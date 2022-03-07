Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1074D06BA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbiCGSlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241217AbiCGSlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:41:04 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2EC74848
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:40:09 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220307184007epoutp02b547532c67d58767a862c3376beac517~aLUmPqaz81277812778epoutp02m
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:40:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220307184007epoutp02b547532c67d58767a862c3376beac517~aLUmPqaz81277812778epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646678407;
        bh=eiDqlXkyLxJk7tUavFB6NBVRulB8atwBogOljjBUCeI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=kcmFqyEZA54asLw4qnDChdVqZpyesCNpmNLlS/xHvKGPW85ozW5rcE+tfjxnb1z9A
         prj+oYY/QFIbzW+atb1MmzTYBGJ9w1cW8MERDDQkGGcWdyyLrXQsGida08ZvbvbmYv
         ZU3aHon++MMr94JO31p0z68ivW/T0ejf4gdsAWq0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220307184006epcas5p435cd41207507bc414337f86a13ef33ac~aLUlYqroB1486114861epcas5p4C;
        Mon,  7 Mar 2022 18:40:06 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KC6hK2Kycz4x9Pt; Mon,  7 Mar
        2022 18:40:01 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.DD.46822.FCE46226; Tue,  8 Mar 2022 03:28:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220307184000epcas5p4e57a7bc3e82124d1018167e63c3960d0~aLUfI-jfF2748727487epcas5p43;
        Mon,  7 Mar 2022 18:40:00 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220307184000epsmtrp2f4368f8a7c713a60fdf675c9c3c5d4cc~aLUfIEoRQ1421214212epsmtrp2d;
        Mon,  7 Mar 2022 18:40:00 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-a9-62264ecf32c0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.17.03370.F7156226; Tue,  8 Mar 2022 03:39:59 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220307183957epsmtip1d83677fad9d10a49385889fb09c9081f~aLUck0svH1520315203epsmtip1U;
        Mon,  7 Mar 2022 18:39:57 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Avri Altman'" <avri.altman@wdc.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Wei Xu'" <xuwei5@hisilicon.com>,
        "'Matthias Brugger'" <matthias.bgg@gmail.com>,
        "'Jan Kotas'" <jank@cadence.com>, "'Li Wei'" <liwei213@huawei.com>,
        "'Stanley Chu'" <stanley.chu@mediatek.com>,
        "'Vignesh Raghavendra'" <vigneshr@ti.com>,
        <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Cc:     "'Rob Herring'" <robh@kernel.org>
In-Reply-To: <20220306111125.116455-3-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v3 02/12] dt-bindings: ufs: samsung,exynos-ufs: use
 common bindings
Date:   Tue, 8 Mar 2022 00:09:56 +0530
Message-ID: <000501d83252$c0094650$401bd2f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHMSLK+HcMgkjgstDaV74uAa2rDeQFlagdDAil/trGsr5wPEA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCJsWRmVeSWpSXmKPExsWy7bCmuu55P7Ukg2e3uCzOPf7NYvHy51U2
        i9P737FYzD9yjtWi+3imxca3P5gsNj2+xmoxcf9ZdovLu+awWVxuvshoMeP8PiaL7us72Cz+
        zjnCaNHUYmzRuvcIu8X/PTvYLZZuvclo8f/sB3aLJ0enMDsIe6zpfM3kMauhl81j56y77B6P
        525k92g58pbVY9OqTjaPO9f2sHlsXlLv0XJyP4vH8RvbmTw+b5LzaD/QzRTAE5Vtk5GamJJa
        pJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0opJCWWJOKVAoILG4
        WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2PRxn1sBdNE
        Km7NZ21g7BbsYuTkkBAwkbi4rY+pi5GLQ0hgN6PEr90X2CCcT4wSSx7eZ4FwPjNKHLj0jx2m
        ZeeOecwgtpDALkaJL5OjIIpeMko8mPGBESTBJqArsWNxGxuILSJwkVXi3kl9EJtZQFVizp9f
        YM2cAh4Sl85+B6sXFoiUOP1pMlg9i4CKxORVs1hAbF4BS4lVm/6wQ9iCEidnPmGBmCMvsf3t
        HGaIgxQkfj5dxgqxy0liRdMiNogacYmXR4+wgxwnITCfU2LvmqOsEA0uEpvfHWKBsIUlXh3f
        AvWZlMTnd3uBmjmA7GyJnl3GEOEaiaXzjkGV20scuDKHBaSEWUBTYv0uqLf4JHp/P2GC6OSV
        6GgTgqhWlWh+dxWqU1piYnc31AEeEkcnr2aewKg4C8ljs5A8NgvJA7MQli1gZFnFKJlaUJyb
        nlpsWmCUl1oOj+3k/NxNjODkr+W1g/Hhgw96hxiZOBgPMUpwMCuJ8N4/r5IkxJuSWFmVWpQf
        X1Sak1p8iNEUGNoTmaVEk/OB+SevJN7QxNLAxMzMzMTS2MxQSZz3dPqGRCGB9MSS1OzU1ILU
        Ipg+Jg5OqQamHQZ/2WeUf018EBpzwFrt/ZeqJa8OHHVfbP2Ae2Fmp/C0huP1RqkMsUEzFz4/
        vs7gnt7UZU6LH9xQPJietO/tdkfmYr6F+oFOkpf67s07L3clKOxXbZOu/MSw2THHwxMSbzMs
        XRzAEMbg9XWeCmtDBLtqQRqLX0nI06eLy3Wvf7wi8K7O0vvnA+/WQ4++LVouw/h4g9AUY40a
        DYePa1Qyolr8XPhXdqZM2BPPf27zijsWe77Z9V8Oa1seX6UVGVW8Yh73K1VBg8d2X4v9TkQu
        PbV5ysvStdM2zV+fZf74fIjb9/PcaiY1/gtKTh073DyN9zirCE/TjmknJz1tr9h0P93l7MaY
        w8kscQe2Xo3yU2Ipzkg01GIuKk4EAC0hLGCHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCSnG59oFqSwaltVhbnHv9msXj58yqb
        xen971gs5h85x2rRfTzTYuPbH0wWmx5fY7WYuP8su8XlXXPYLC43X2S0mHF+H5NF9/UdbBZ/
        5xxhtGhqMbZo3XuE3eL/nh3sFku33mS0+H/2A7vFk6NTmB2EPdZ0vmbymNXQy+axc9Zddo/H
        czeye7QcecvqsWlVJ5vHnWt72Dw2L6n3aDm5n8Xj+I3tTB6fN8l5tB/oZgrgieKySUnNySxL
        LdK3S+DKWLRxH1vBNJGKW/NZGxi7BbsYOTkkBEwkdu6Yx9zFyMUhJLCDUWL2ybWMEAlpiesb
        J7BD2MISK/89B7OFBJ4zSpw7UwliswnoSuxY3MYG0iwi8JBVYuXVWSwgCWYBVYk5f35BTb3K
        KPFm/0Kwbk4BD4lLZ7+DbRAWCJfY+XYNK4jNIqAiMXkVRDOvgKXEqk1/2CFsQYmTM58AxTmA
        hupJtG1khJgvL7H97RxmiOMUJH4+XQY2RkTASWJF0yI2iBpxiZdHj7BPYBSehWTSLIRJs5BM
        moWkYwEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOAUoKW1g3HPqg96hxiZOBgP
        MUpwMCuJ8N4/r5IkxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwT
        B6dUA1PWJ5VXPpnbLvT1uzLtVz4Vdvu5jsen2xuCXQwYoiufPJhgXav59+FDrcOdL/WiZnKx
        yWQtPSboWvvYTqnJSYNRfoIYk9BfzcfvNrQ3qlxdXzIxkpf9gMqvmpl8zGentGxgu1Ly4HBA
        9c3ghadu9G2U+V8nxPzQSfjHlilbdzI9qHt11itm9s5zP9IENP7HGbf7nXK58CBLXkW08fzz
        orTwibYXkt+Zb9tY8i3gTqb7eenF98MLu6vOGj7/z+X5e23SnqhzbipZR0O/tvI470//tWTV
        w6Nljz6m8bW92ctif3zvi3Op+lsDP5s/CZv2a0dPyKqVByKCuLtZOU/HnzZksM7XqetvWHyn
        75xPcKwSS3FGoqEWc1FxIgCA8KoHcAMAAA==
X-CMS-MailID: 20220307184000epcas5p4e57a7bc3e82124d1018167e63c3960d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220306111139epcas5p17c8aa66853ef371e7486aa64ea89b484
References: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com>
        <CGME20220306111139epcas5p17c8aa66853ef371e7486aa64ea89b484@epcas5p1.samsung.com>
        <20220306111125.116455-3-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Sunday, March 6, 2022 4:41 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>; Avri Altman
><avri.altman@wdc.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>Kozlowski <krzysztof.kozlowski@canonical.com>; Andy Gross
><agross@kernel.org>; Bjorn Andersson <bjorn.andersson@linaro.org>; Wei
>Xu <xuwei5@hisilicon.com>; Matthias Brugger <matthias.bgg@gmail.com>;
>Jan Kotas <jank@cadence.com>; Li Wei <liwei213@huawei.com>; Stanley Chu
><stanley.chu@mediatek.com>; Vignesh Raghavendra <vigneshr@ti.com>;
>linux-scsi@vger.kernel.org; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>mediatek@lists.infradead.org
>Cc: Rob Herring <robh@kernel.org>
>Subject: [PATCH v3 02/12] dt-bindings: ufs: samsung,exynos-ufs: use common
>bindings
>
>Use common UFS bindings in Samsung Exynos UFS to cover generic/common
>properties in DTS.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>Reviewed-by: Rob Herring <robh@kernel.org>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> .../devicetree/bindings/ufs/samsung,exynos-ufs.yaml | 13 ++++---------
> 1 file changed, 4 insertions(+), 9 deletions(-)
>
>diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-
>ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-
>ufs.yaml
>index 95ac1c18334d..c949eb617313 100644
>--- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
>+++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
>@@ -11,12 +11,11 @@ maintainers:
>
> description: |
>   Each Samsung UFS host controller instance should have its own node.
>-  This binding define Samsung specific binding other then what is used
>-  in the common ufshcd bindings
>-  [1] Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>
>-properties:
>+allOf:
>+  - $ref: ufs-common.yaml
>
>+properties:
>   compatible:
>     enum:
>       - samsung,exynos7-ufs
>@@ -47,9 +46,6 @@ properties:
>       - const: core_clk
>       - const: sclk_unipro_main
>
>-  interrupts:
>-    maxItems: 1
>-
>   phys:
>     maxItems: 1
>
>@@ -67,13 +63,12 @@ properties:
> required:
>   - compatible
>   - reg
>-  - interrupts
>   - phys
>   - phy-names
>   - clocks
>   - clock-names
>
>-additionalProperties: false
>+unevaluatedProperties: false
>
> examples:
>   - |
>--
>2.32.0


