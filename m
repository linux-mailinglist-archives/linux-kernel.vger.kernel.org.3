Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59686530237
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 11:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbiEVJyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 05:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243303AbiEVJyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 05:54:25 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898813B3E1
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 02:54:24 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220522095421epoutp01f38bc09a829f22d37c90502f740e828c~xZLPNvkhv0946009460epoutp01P
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 09:54:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220522095421epoutp01f38bc09a829f22d37c90502f740e828c~xZLPNvkhv0946009460epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653213261;
        bh=3CYOlliTIM4sXaXe4CgeEj+R6puxqxZfAFM7+aBC378=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLe6ySga7oEzo4KqEB/s6kJsf2Ji53c5y4bG/2U8brh3gEWzOeL0bRhIMFg6t6yP3
         Rb0aWtBteHD0e0I8uf2v6lEGPc9XygvLhrv0wiAKdw6zE42XotahyhtjUSFVIDluXk
         Nhn5WIn+eRn4eOk3O2J/ysBIuIariO1YScdAymh4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220522095420epcas5p30a5b3ba76b423b8d848955faf4b47b0b~xZLN8lMhV2325123251epcas5p3V;
        Sun, 22 May 2022 09:54:20 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L5bQc1J6dz4x9Pt; Sun, 22 May
        2022 09:54:16 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.EF.09762.7480A826; Sun, 22 May 2022 18:54:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220520145759epcas5p240de0ce6d1a1bfea6c8a6bfb61c5d27d~w2BxwdmHu0952609526epcas5p2m;
        Fri, 20 May 2022 14:57:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220520145759epsmtrp2cf4f9401785fabc474304b22962937df~w2Bxvk4J80678806788epsmtrp2E;
        Fri, 20 May 2022 14:57:59 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-31-628a08478b8b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.E2.11276.77CA7826; Fri, 20 May 2022 23:57:59 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220520145757epsmtip194fa68a9921fb863787649a7fbb27c93~w2BvycQ1t3190831908epsmtip1D;
        Fri, 20 May 2022 14:57:57 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     geert@linux-m68k.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, alim.akhtar@samsung.com,
        paul@crapouillou.net, linux-fsd@tesla.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v2 1/3] dt-bindings: iio: adc: Add FSD-HW variant
Date:   Fri, 20 May 2022 20:28:18 +0530
Message-Id: <20220520145820.67667-2-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220520145820.67667-1-m.shams@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTXdeDoyvJ4GIfk8WDedvYLOYfOcdq
        8ezWXiC3aRWTxctZ99gslkyez2qx6fE1VouHr8It5h15x2JxedccNosZ5/cxWdxtXcxu0b/4
        EotF694j7A58HqsvtbN5bFrVyeZx6HAHo8fmJfUeS94cYvXo27KK0eNf01x2j8+b5AI4orJt
        MlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DOVlIoS8wp
        BQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ1yf
        toqxYBdHxalz71gaGN+ydTFycEgImEg0N7h1MXJxCAnsZpS4un0JC4TziVHi28bn7BDON6BM
        4wzGLkZOsI7/fw8xQST2MkqsX/yZFSQhJNDCJLG2MQ5kLJuApsTx89wgpoiAv0TnXxeQcmaB
        5UwSp9dNYwMpFxZwlLjZeoUZxGYRUJW43NwFFucVsJD4sXAWO8QueYnVGw6A1XAKWEp8/dkE
        dcNEDol/21IhbBeJNd+bmCBsYYlXx7dA9UpJfH63lw3CTpeY+7AXqqZAYtmu71A19hIHrsxh
        AbmTGejk9bv0IcKyElNPrQMrZxbgk+j9/QSqlVdixzwYW1Hi/+5+qDHiEu9WTGGFsD0k+u/D
        ArGHUeLxsznMExjlZiGsWMDIuIpRMrWgODc9tdi0wDgvtRweZcn5uZsYwelSy3sH46MHH/QO
        MTJxMB5ilOBgVhLh3Z7YkSTEm5JYWZValB9fVJqTWnyI0RQYfhOZpUST84EJO68k3tDE0sDE
        zMzMxNLYzFBJnFfgf2OSkEB6YklqdmpqQWoRTB8TB6dUA9MOq0/TJ/BVGVxY1jq39oGuBEdw
        qNFyMxVzOeZbl1TKhbt8lcSr/lytSxBelXVf235veo2whcHk+JWTv0lEt+27+9yis3lhZ4Hm
        UZlQIeNVbE8n9LBZp+3dtcMh1PXt6muhop/ObPrF9PcRw96lCz0uH8gu1NxRc1aCc+EWlul5
        bPUpU9m8vzy6deqm6Zr55r957SbJrGo0+iZdLBDN2XBj3csXTILf1x+U0UgIvPrnyJ4nzGXF
        qda5U/ZJTpB5yjuT0zjK5ejUGxvnZ+hNtt/R28Vi9uKlcKX653dVF+Ve3t+vLDG/06Kic4/O
        xx2+9zKYFPMKGg7/PLyjzZGnU+aFgsAHtxOiCeaOvy4VH1BiKc5INNRiLipOBABCbxGeIAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSnG75mvYkg7ZjhhYP5m1js5h/5Byr
        xbNbe5ksHjStYrJ4Oesem8WSyfNZLTY9vsZq8fBVuMW8I+9YLC7vmsNmMeP8PiaLu62L2S36
        F19isWjde4Tdgc9j9aV2No9NqzrZPA4d7mD02Lyk3mPJm0OsHn1bVjF6/Guay+7xeZNcAEcU
        l01Kak5mWWqRvl0CV8b1aasYC3ZxVJw6946lgfEtWxcjJ4eEgInE/7+HmLoYuTiEBHYzSrx/
        tJUJIiEuMe3XfkYIW1hi5b/n7BBFTUwSW7suAiU4ONgENCWOn+cGqRERCJZYfOgwM0gNs8BG
        Jon/u7tYQRLCAo4SN1uvMIPYLAKqEpebu8A28wpYSPxYOIsdYoG8xOoNB8BqOAUsJb7+bAJb
        LARUs6LxG/MERr4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCw1pLcwfj9lUf
        9A4xMnEwHmKU4GBWEuFlzG1JEuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZq
        akFqEUyWiYNTqoHpKM/us9P6crc/Z3+nmTjrx3NeidjAr1aWD44+ZDyb7OgW8NLS4dZUl7qL
        /14/+FssfOG0UdjmrZ6zr1oo7N1SHCL4RSJT5dWC9f8qzikcP9nGN9dUSMRw5zbX5UYrBV4d
        ONyfN3vL+UbulA2JHi7vFyvXC72cvTZvu59PZsS5ZX/aDpvN2391JnegkukS1XXVzJEyiw5P
        veUzWTGU8/VTFYbJ6kuvqjzXnMZanO0tVGTT+DG7kOHVJsGUdQrTvx0ovjU1fUuk2q57CX4b
        J9/pfOj4YPqW22VnO9wN0hvXTNNdLjCpZlqcuZz8W/XUtKorsVEKLv0PLy4N3HFlgv0n17zn
        IbsNC0o7p2vMZNn2VImlOCPRUIu5qDgRANk6jFDaAgAA
X-CMS-MailID: 20220520145759epcas5p240de0ce6d1a1bfea6c8a6bfb61c5d27d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520145759epcas5p240de0ce6d1a1bfea6c8a6bfb61c5d27d
References: <20220520145820.67667-1-m.shams@samsung.com>
        <CGME20220520145759epcas5p240de0ce6d1a1bfea6c8a6bfb61c5d27d@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alim Akhtar <alim.akhtar@samsung.com>

This patch adds a new compatible string for FSD-HW's
ADC variant

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
- Changes since v1
* Addressed Krzysztof's comment to use soc-specific compatible

 .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index 81c87295912c..ded0e3f85991 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - samsung,exynos-adc-v1                 # Exynos5250
       - samsung,exynos-adc-v2
+      - samsung,exynos-adc-fsd-hw
       - samsung,exynos3250-adc
       - samsung,exynos4212-adc                # Exynos4212 and Exynos4412
       - samsung,exynos7-adc
-- 
2.17.1

