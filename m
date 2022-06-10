Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A022545D88
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346872AbiFJHc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346802AbiFJHcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:32:14 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C209F11468A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:32:07 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220610073206epoutp04954b540670adf2a98d70528bad70377f~3MfdLFc-o2579025790epoutp044
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:32:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220610073206epoutp04954b540670adf2a98d70528bad70377f~3MfdLFc-o2579025790epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654846326;
        bh=FC5Zvuqj+9I9IJqzAfeb16koBccPnJdOCKiB9rYr+kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCsbXfhUKFnExaL863iwIyT5zWskUi3uCbkQIWSkz/7Pw1OdWsJ59BitWKgqJMEBG
         dY7dpLERtAlKkdmJrQRdGXVjaWFQ3hifuKMTombZbyD1dLRgbR/ie3WtCNi8wMfdtQ
         H08Ndz9b9SfH8LH3L5ziBWMf5/7NjT57TIgosnZE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220610073205epcas5p3f9b118f113d9fc75e3a783a69d32f5af~3Mfco9GrY2841128411epcas5p3A;
        Fri, 10 Jun 2022 07:32:05 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LKCMk3p1Kz4x9Q2; Fri, 10 Jun
        2022 07:32:02 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.C4.09762.073F2A26; Fri, 10 Jun 2022 16:32:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220610073159epcas5p249da726759c834756ef6b17cb94e391c~3MfXH6c4J2709327093epcas5p2M;
        Fri, 10 Jun 2022 07:31:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220610073159epsmtrp192bb33db05e223a41a40d7ce2e762ff7~3MfXG6e3R3013430134epsmtrp1I;
        Fri, 10 Jun 2022 07:31:59 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-d1-62a2f370273e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.3E.08924.F63F2A26; Fri, 10 Jun 2022 16:31:59 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220610073157epsmtip1578bef4b9aa7e6ef9e9c92dd423cab30~3MfU6AR2x2477624776epsmtip1b;
        Fri, 10 Jun 2022 07:31:57 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v3 1/6] dt-bindings: phy: Add FSD UFS PHY bindings
Date:   Fri, 10 Jun 2022 12:59:19 +0530
Message-Id: <20220610072924.12362-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610072924.12362-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTS7fg86Ikg+dvBCwezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6
        XUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQK
        VJiQnfF/RgtrwRW2iqmvfBsYb7B2MXJySAiYSCx5/5u5i5GLQ0hgN6PE7iUbGCGcT4wSt1/0
        sUI4nxklpk26wQTTcvXFVjBbSGAXo8TsPd4QRS1MEr3PephBEmwC2hJ3p29hAkmICDQzShzs
        2AXmMAvsZJK4+Hs6WJWwgJPE1xvX2EFsFgFViV2fV4DZvAI2EuuW3GSGWCcvsXrDATCbU8BW
        4uz/DVDxqRwS/5oVIWwXibk3VrND2MISr45vgbKlJF72twHZHEC2h8SiP1IQ4QyJt8vXM0LY
        9hIHrsxhASlhFtCUWL9LHyTMLMAn0fv7CRNEJ69ER5sQRLWqRPO7qywQtrTExO5uaDB6SHxZ
        BAvGCYwSm3v+sE5glJ2FMHUBI+MqRsnUguLc9NRi0wLjvNRyeDwl5+duYgQnSC3vHYyPHnzQ
        O8TIxMF4iFGCg1lJhDfg9qIkId6UxMqq1KL8+KLSnNTiQ4ymwBCbyCwlmpwPTNF5JfGGJpYG
        JmZmZiaWxmaGSuK8Av8bk4QE0hNLUrNTUwtSi2D6mDg4pRqYGrdJnvBaOnnTbf9nclGHBAr6
        hJ+1JDz/ybrENET0112+Y60p9T0uJ5jUGBZ6ttyusJz8Lu7uvx3dvizr51odvmL4LmCycImj
        7nyNoxbid+6Uh1Q8O7KL/XTVc9PkyfUXNv0RWX1c+tbrR12Z+4WOeEUm1wgJGVz4mvlc/eEM
        xuWhhqcz373ulDzx5yKPYtnubCedLrtNB0NTSx5/PpUgY/fs2I6rfbNPJXZ7P3PJC1py1OWT
        WOTbFoHyT/KNnAJxflpHXTaqevm0rZbQiNBv3qs7hUtSrcT/nki0WSZ/uNmBn0d7o29vfylU
        lt7puKLowNkjm18pcbf5Fr6fmDPh851LX+VmKlhsd3Nqzr6rxFKckWioxVxUnAgA1H8y2hkE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnG7+50VJBj0ntSwezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiOKySUnNySxLLdK3S+DK+D+jhbXgClvF1Fe+DYw3WLsYOTkkBEwkrr7YytTFyMUhJLCD
        UeLZ4Q4WiIS0xPWNE9ghbGGJlf+es0MUNTFJfNrWD5ZgE9CWuDt9CxOILSLQzihxfzsbSBGz
        wFEmieWnjjGDJIQFnCS+3rgG1sAioCqx6/MKMJtXwEZi3ZKbzBAb5CVWbzgAZnMK2Eqc/b8B
        yOYA2mYj8fpv3gRGvgWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKDW0trB+Oe
        VR/0DjEycTAeYpTgYFYS4Q24vShJiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp
        2ampBalFMFkmDk6pBqbir7UHVTk9Lp9/dOZYeFz7idmHat6uPWa95YuU8VOpA/f/CtzI6b79
        5tFX7uYs932+T3iXPLPkChb+oShaofpjlVpaV8bj+lkLLO8oVMoHRa1y+Gay4FvLj8pJWuuc
        zszbIbu35+gn1rSmP6v1eV5435zr2uf8wlHwjO/GgztjJKdVOu97dyKqyKCkOPLIEZFcA8mj
        cRtf3TLe8HGK7C/TFGaftl+/Mnr6k1bl7X17UTUrPf74wWdzZD+2mN/+erw1a7dmKv+ZGbmR
        Qv7dhbpREh+WyFRl2Qew9gp2h6qoy38o8WjiMV+u1/N5dnzpxT1bT8brnTlS+vHqdD7vBcpb
        d82cFFY25cTPDUxGTjFKLMUZiYZazEXFiQAvXuCp3QIAAA==
X-CMS-MailID: 20220610073159epcas5p249da726759c834756ef6b17cb94e391c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610073159epcas5p249da726759c834756ef6b17cb94e391c
References: <20220610072924.12362-1-alim.akhtar@samsung.com>
        <CGME20220610073159epcas5p249da726759c834756ef6b17cb94e391c@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tesla,fsd-ufs-phy compatible for Tesla Full Self-Driving (FSD) SoC.

Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
index 17897a3b5c9e..8da99461e817 100644
--- a/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - samsung,exynos7-ufs-phy
       - samsung,exynosautov9-ufs-phy
+      - tesla,fsd-ufs-phy
 
   reg:
     maxItems: 1
-- 
2.25.1

