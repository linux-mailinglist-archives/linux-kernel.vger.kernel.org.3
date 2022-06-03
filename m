Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F1653CC8F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245686AbiFCPtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244403AbiFCPs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:48:57 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277A650B03
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:48:56 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220603154854epoutp02eccbeb39312aa5b8aecaef4df84cdd0c~1JwOd8uEM1283712837epoutp02f
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:48:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220603154854epoutp02eccbeb39312aa5b8aecaef4df84cdd0c~1JwOd8uEM1283712837epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654271334;
        bh=OqQ1enUTxvICV7W6/WibB2vsnt6W8FW67Y/2GxvFhQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SOcLYtuyfliDkrov+3zj04x2my4/63v8fQHyk0K4WLcmfnPLHUJE7mSM6urhXrsv0
         gr7QwEjJi7JYNa3hyzNpln3JBqY4BqIvwnvX7z05p/9uvg6eZistYeexEtqITGfXT0
         2r8VceBcMHsKIBl5BHFDsg0uqCzArkGK4ApNK5JI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220603154854epcas5p4a73040e0de0ee59a89430ac4f5a9eeb8~1JwN_Of6s1859418594epcas5p4L;
        Fri,  3 Jun 2022 15:48:54 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LF6kB6n0Cz4x9Pp; Fri,  3 Jun
        2022 15:48:50 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.28.09762.26D2A926; Sat,  4 Jun 2022 00:48:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220603154850epcas5p220116911e746aaf59f948509efd190e5~1JwKYe0P71442914429epcas5p2M;
        Fri,  3 Jun 2022 15:48:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220603154850epsmtrp2eb94580b25a69377321baed78210cb78~1JwKXVg0w0407504075epsmtrp2o;
        Fri,  3 Jun 2022 15:48:50 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-89-629a2d629738
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.6C.11276.26D2A926; Sat,  4 Jun 2022 00:48:50 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220603154847epsmtip1deb6f027ee1b1ca0df67bf14ab7b5ff5~1JwHihDyk1990619906epsmtip1i;
        Fri,  3 Jun 2022 15:48:47 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v2 1/7] dt-bindings: phy: Add FSD UFS PHY bindings
Date:   Fri,  3 Jun 2022 21:17:08 +0530
Message-Id: <20220603154714.30532-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603154714.30532-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTXTdJd1aSwZYvBhYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XlXXPYLCas+sZi0X19B5vF8uP/mCwW
        bf3CbtG69wi7xc47J5gd+D0uX/H22LSqk83jzrU9bB6bl9R7fHx6i8Wjb8sqRo/Pm+Q82g90
        MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzji7di5zwRW2iuvr57I1MN5g7WLk5JAQMJH49HczcxcjF4eQwG5GiVnnL7FDOJ8YJa5u
        uA3lfGOUWNl1ixGmZe23f0wQib2MEs/7XkI5LUwSk26BZDg52AS0Je5O3wKWEBFoZpQ42LEL
        zGEW2MkkcfH3dGaQKmEBJ4nv26eDncIioCrxuuEMkM3BwStgI9G/sQJinbzE6g0HmEHCnAK2
        ElNP84GMkRCYySHxcs0ndogaF4nrR7YyQ9jCEq+Ob4GKS0l8freXDaRXQsBDYtEfKYhwhsTb
        5euhvrGXOHBlDgtICbOApsT6XfogYWYBPone30+YIDp5JTrahCCqVSWa311lgbClJSZ2d7PC
        DO+eVgAJhQmMEp++NjFNYJSdhTB0ASPjKkbJ1ILi3PTUYtMC47zUcng8JefnbmIEJ0gt7x2M
        jx580DvEyMTBeIhRgoNZSYS3bN7MJCHelMTKqtSi/Pii0pzU4kOMpsDwmsgsJZqcD0zReSXx
        hiaWBiZmZmYmlsZmhkrivAL/G5OEBNITS1KzU1MLUotg+pg4OKUamJ5zvNOz3VQcY/DrXv6f
        j2df7tvR3DnDwF6qX8C3Ozi78QY/t5qx8+a997P7FrJc0PztqL7Le1p3w58swf1vhY1FL2mx
        f/7yZL6x7l9utqjuy2f3bZqYJjvh3Y3kC1cOyCcwOT6/olqyZiv/V13mL4WVX0/4pJz4M9dc
        gSfFzWwn17+TbeF1GQnTeLsneTgGR1lI6VSG/Q2b2HfR9bfiE8kuJ/e4o/PvhdlLb3TmfsIZ
        5S2uszavzzd7y8wk3WWhv2suqX09Nftqwh6JcyqylS+4lkXeEQvb3/z37VOPa8YiMj+fJCiu
        WN9rcikwvnj/4YNV0S6TL/wRrN9wzXR9B1+k6neF5kpFD12Oe9KZSizFGYmGWsxFxYkAC8SG
        XBkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnG6S7qwkg/Z3nBYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XlXXPYLCas+sZi0X19B5vF8uP/mCwW
        bf3CbtG69wi7xc47J5gd+D0uX/H22LSqk83jzrU9bB6bl9R7fHx6i8Wjb8sqRo/Pm+Q82g90
        MwVwRHHZpKTmZJalFunbJXBlnF07l7ngClvF9fVz2RoYb7B2MXJySAiYSKz99o+pi5GLQ0hg
        N6NE76ZXTBAJaYnrGyewQ9jCEiv/PWeHKGpikth+ZQojSIJNQFvi7vQtYA0iAu2MEve3s4EU
        MQscZZJYfuoYM0hCWMBJ4vv26WDrWARUJV43nAGyOTh4BWwk+jdWQCyQl1i94QAzSJhTwFZi
        6mk+kLAQUMX38/dZJzDyLWBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERzcWpo7
        GLev+qB3iJGJg/EQowQHs5IIb9m8mUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhP
        LEnNTk0tSC2CyTJxcEo1MO3/+KNgp+7RHxHvbp1IN7+1pt1hnlqezbFa1dslVRPX5U5k0Kyu
        VEpbsHcZ96m+M3ZTJsUyn1/K1Gfv5OTwaL9Gmm4zR/AxpWt73zxPyJRcqHzQJXnyRctWzp9K
        08yuty9iV1iWs3TW9uV5muvX+2SeePiweZ00h3PMWu7r8S8MOcTLPOwvHmM8N3GrWu7ml5pn
        Tu/PC4/icuZd1stRGcg356+Ee7L4lQ//JZqqQvvWMfW/eXL+SX3Tvop3c++rRPx6NOlU2GS5
        XtEJabyKzOsmaa+MDRBPXhay60BDQnGS85cXTkf2PLpse3+1dse715Oaj5Yy5TXevB0qYP1j
        NktXEnNJ/LwLS5wuPiiPfKzEUpyRaKjFXFScCADrKe0Y3QIAAA==
X-CMS-MailID: 20220603154850epcas5p220116911e746aaf59f948509efd190e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603154850epcas5p220116911e746aaf59f948509efd190e5
References: <20220603154714.30532-1-alim.akhtar@samsung.com>
        <CGME20220603154850epcas5p220116911e746aaf59f948509efd190e5@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index f6ed1a005e7a..ee354bf37c64 100644
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

