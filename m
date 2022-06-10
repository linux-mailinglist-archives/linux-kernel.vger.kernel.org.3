Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A1A545D96
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbiFJHcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244746AbiFJHcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:32:21 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ECC2F64B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:32:20 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220610073218epoutp037fc9955df125d73bfd213990b3c68721~3MfoYve2L3044430444epoutp03a
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:32:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220610073218epoutp037fc9955df125d73bfd213990b3c68721~3MfoYve2L3044430444epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654846338;
        bh=0eZm7eKAbkf54yudyV9mqTFcBkeReT2Aou+UZwhcVN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvtWHws9Y/30TrrP6ch+EaLBD86zvyZPmqkyD783fhhlznsm3ejz4fsgTWhmcssI1
         jtNOu5X8btsaHBLli3vQzEunm/M4CRhyHNdsDeR0VdCsZzKd6Lo0f+JE+OpwV4k617
         bjDzwD/RuOuws/ga18bl/AT7aaThw5cOU1nUw4Dg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220610073217epcas5p4960bf818281fce69ff6ca2893012c949~3MfnpcyC-0317103171epcas5p4d;
        Fri, 10 Jun 2022 07:32:17 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LKCMx6T0Cz4x9Q6; Fri, 10 Jun
        2022 07:32:13 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.E4.09762.C73F2A26; Fri, 10 Jun 2022 16:32:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220610073211epcas5p3b3df5d8ca0175a70a63200d1b14dff70~3MfiLIOIv1801318013epcas5p3V;
        Fri, 10 Jun 2022 07:32:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220610073211epsmtrp20ba5d2165e5eec863a483dd2253e8ff2~3MfiEfQW71530715307epsmtrp2D;
        Fri, 10 Jun 2022 07:32:11 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-0f-62a2f37cd6a7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.4E.08924.B73F2A26; Fri, 10 Jun 2022 16:32:11 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220610073209epsmtip11ac57bdb908fd1581f5a9fc7a4aeef30~3MfgD7ufq3167831678epsmtip1e;
        Fri, 10 Jun 2022 07:32:09 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v3 4/6] dt-bindings: ufs: exynos-ufs: add fsd compatible
Date:   Fri, 10 Jun 2022 12:59:22 +0530
Message-Id: <20220610072924.12362-5-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610072924.12362-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTU7fm86Ikg0n/eCwezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6
        XUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQK
        VJiQnXH55FzGgqtsFR9m9LM2MN5k7WLk4JAQMJGYti6ii5GLQ0hgN6PE1+VTmLoYOYGcT4wS
        y9ptIBKfGSU2n9zFCpIAabj4fgELRGIXo0TXlKvMEE4Lk8TOD99ZQKrYBLQl7k7fwgSSEBFo
        ZpQ42LELzGEW2MkkcfH3dGaQKmEBD4mPc7vBOlgEVCWuXJkHdhSvgI3ErzY1iHXyEqs3HAAr
        5xSwlTj7fwPYNgmBqRwSP18fZIQocpFomXaSDcIWlnh1fAs7hC0l8fndXjaIRz0kFv2Rgghn
        SLxdvh6q1V7iwJU5LCAlzAKaEut36YOEmQX4JHp/P2GC6OSV6GgTgqhWlWh+d5UFwpaWmNjd
        DQ0UD4k7TyAmCglMYJTYt05zAqPsLIShCxgZVzFKphYU56anFpsWGOellsOjKTk/dxMjOD1q
        ee9gfPTgg94hRiYOxkOMEhzMSiK8AbcXJQnxpiRWVqUW5ccXleakFh9iNAUG2ERmKdHkfGCC
        ziuJNzSxNDAxMzMzsTQ2M1QS5xX435gkJJCeWJKanZpakFoE08fEwSnVwDRne3pMm/OPrZ3N
        y8957pt55mvDulsr5ktOY4xf/tr2ft7B5eenTH0tPP+iZlZ3jNzKIzOqSn9PP+v2rM6bZe/K
        5YUVevx2UkmyE5lfbhDd/Vh9Xeg8Ru/Cl5+uX5urumnaC/k7W/nyAo4o39z5b0p85FytQOVV
        y7ewih1/1/t8ykaXa2sfvrhj/rDq+qdl859tVE022vvb9vivzczdO26VMz5i2+mT0G6U5C/r
        fWGDfViTuOQJ7dc9BwND1P5+W50jmnb35oKubbYRT1IiRDYvXrB+mtRkkfnmBiKZi3XSisND
        l12c0xbTIl5yNHXCjccGYYv3t89x638pXJTRVlZnPS35o+vPGZFfRG5NjHX/r8RSnJFoqMVc
        VJwIALWhvvMYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnG7150VJBstbpC0ezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiOKySUnNySxLLdK3S+DKuHxyLmPBVbaKDzP6WRsYb7J2MXJySAiYSFx8v4Cli5GLQ0hg
        B6PEy9d32SAS0hLXN05gh7CFJVb+e84OUdTEJDH15TwmkASbgLbE3elbwGwRgXZGifvb2UCK
        mAWOMkksP3WMGSQhLOAh8XFuNwuIzSKgKnHlyjyg1RwcvAI2Er/a1CAWyEus3nAArJxTwFbi
        7P8NzCAlQkAlr//mTWDkW8DIsIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzi4tbR2
        MO5Z9UHvECMTB+MhRgkOZiUR3oDbi5KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCe
        WJKanZpakFoEk2Xi4JRqYGqp5Er8ZSQl9HK3x34TdqM/N3ZsEmSZ9rbjRIro2/mu3RaN6xvK
        TjNHN+otn/WHOTa52e/AdQFZwehjgjOFPy9nCuHfeG7dEvljkrNnSk604Zr/peMwa2eXUMeC
        VzZnNXuux53cbpdbad22YN+Hn6wTpx94+ukjh5rFLuZ9V+ccU7/XfEtCYuXfpa90dzx+rBSb
        mXROeMYngfvv1VR++m+U6knQU+wJmmjtnHzfc664U/09l7gERcYt+Sv27M53Tzyxbrmi+qXn
        xt6Fn9fY9czd+ap3i9H9x5POm/m9536byhQy3bJfZUPny3O8JSeSvyU1OF6UV3iTr/wn0e1x
        zeQ+xulZnB7hcj7SO4yaHZVYijMSDbWYi4oTAap40HrdAgAA
X-CMS-MailID: 20220610073211epcas5p3b3df5d8ca0175a70a63200d1b14dff70
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610073211epcas5p3b3df5d8ca0175a70a63200d1b14dff70
References: <20220610072924.12362-1-alim.akhtar@samsung.com>
        <CGME20220610073211epcas5p3b3df5d8ca0175a70a63200d1b14dff70@epcas5p3.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds tesla,fsd-ufs compatible for Tesla FSD SoC.

Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
index c949eb617313..2c715eec48b8 100644
--- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
@@ -21,6 +21,7 @@ properties:
       - samsung,exynos7-ufs
       - samsung,exynosautov9-ufs
       - samsung,exynosautov9-ufs-vh
+      - tesla,fsd-ufs
 
   reg:
     items:
-- 
2.25.1

