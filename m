Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB3254648B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348450AbiFJKsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343701AbiFJKry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:47:54 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FC4235109
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:44:00 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220610104358epoutp035517ce5658ad4c1c540558cbf662b60d~3PG_rMUW-0553405534epoutp03H
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:43:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220610104358epoutp035517ce5658ad4c1c540558cbf662b60d~3PG_rMUW-0553405534epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654857838;
        bh=0eZm7eKAbkf54yudyV9mqTFcBkeReT2Aou+UZwhcVN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7Dk1Dc1J/qYLFUhB7G000YTSjBxraclnalodDBwLPncFkCkiSl/a43f9D8WfvXr5
         SfOY0j7RBpUst72/e6bmfpIteqbX9ryDjby157nzyFgYnysbRivYU/UqnXtYIQpgYj
         MZmudCkhnayb2FKyzGbzVn/IRE6s/JM+L9cKvga8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220610104357epcas5p3d7babfb53baf09dd3905d9f04642f218~3PG9n9VnQ2015220152epcas5p3Y;
        Fri, 10 Jun 2022 10:43:57 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LKHd63Hrvz4x9Q2; Fri, 10 Jun
        2022 10:43:54 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.D8.09827.A6023A26; Fri, 10 Jun 2022 19:43:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220610104353epcas5p19324d8bb48a250d4788ce24f859a3ec3~3PG6JA7fH0223302233epcas5p11;
        Fri, 10 Jun 2022 10:43:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220610104353epsmtrp29476da6c45f574a923163172c0206c19~3PG6II0Ba2850228502epsmtrp2h;
        Fri, 10 Jun 2022 10:43:53 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-f4-62a3206ab2c9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.4D.08924.96023A26; Fri, 10 Jun 2022 19:43:53 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220610104351epsmtip174b321191032065c818da00d0089c787~3PG4GieCR1428814288epsmtip1I;
        Fri, 10 Jun 2022 10:43:51 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v4 4/6] dt-bindings: ufs: exynos-ufs: add fsd compatible
Date:   Fri, 10 Jun 2022 16:11:17 +0530
Message-Id: <20220610104119.66401-5-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610104119.66401-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTXTdLYXGSwfx/4hYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XlXXPYLCas+sZi0X19B5vF8uP/mCwW
        bf3CbtG69wi7xc47J5gd+D0uX/H22LSqk83jzrU9bB6bl9R7fHx6i8Wjb8sqRo/Pm+Q82g90
        MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzrh8ci5jwVW2ig8z+lkbGG+ydjFyckgImEgcOHWFCcQWEtjNKLH6tSuE/YlR4vmGsC5G
        LiD7M5D98w9cw+7Tj1kgErsYJY7/vsMG4bQwScw/8YoRpIpNQFvi7vQtTCAJEYFmRomDHbvA
        HGaBnUwSF39PZwapEhbwkHjT2AaU4OBgEVCVuHJQACTMK2AjcWrvRmaIdfISqzccALM5BWwl
        nq2/zAoyR0JgKofE1rlPGSGKXCTeXX3ADmELS7w6vgXKlpL4/G4vG8h8CaBdi/5IQYQzJN4u
        Xw/Vai9x4MocFpASZgFNifW79EHCzAJ8Er2/nzBBdPJKdLQJQVSrSjS/u8oCYUtLTOzuhgaK
        h8SmK83skHCYwCgx+/tU1gmMsrMQpi5gZFzFKJlaUJybnlpsWmCUl1oOj6fk/NxNjOAEqeW1
        g/Hhgw96hxiZOBgPMUpwMCuJ8AbcXpQkxJuSWFmVWpQfX1Sak1p8iNEUGGITmaVEk/OBKTqv
        JN7QxNLAxMzMzMTS2MxQSZxX4H9jkpBAemJJanZqakFqEUwfEwenVAOTrp0eW7B5hvGT5XGb
        bhUW9u+ZfldLWV36rqpZzpKVB6dlxr1wKJmdc/iddX+hYvftE7IhJTkxSxJdG+L+VpV8uXyw
        J4417fWqPP323+EzQ9vPXH5Qn79eeY+Cx1V9Hx6zKVlKpw21T2z8oD7nOv/E/aIV3vdvhD4Q
        36zeYhWWJrn15A7eX/0SHrfdZXRd/j1f/Tfrsfha8Tcnsjnf/vi3PaOHa98ug7Wsi1LiJiut
        NMzk2PWA/c3Wm5fOVrXF/AnS2H31P2/fg87l/mFdHVNLt0as4rH5fTz8W9mn8y/NZFvunvDZ
        lh90KueA5qtVjV6v9cpcpu/9cank9p4Vkul3Nqf1zNE2/3jS8ztL8U0+JZbijERDLeai4kQA
        oz/zhxkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnG6mwuIkg403xCwezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiOKySUnNySxLLdK3S+DKuHxyLmPBVbaKDzP6WRsYb7J2MXJySAiYSOw+/Zili5GLQ0hg
        B6PEzru32SAS0hLXN05gh7CFJVb+e84OUdTEJHHg1nGwBJuAtsTd6VuYQGwRgXZGifvb2UCK
        mAWOMkksP3WMGSQhLOAh8aaxDaiIg4NFQFXiykEBkDCvgI3Eqb0bmSEWyEus3nAAzOYUsJV4
        tv4y2HVCQDWLO84xT2DkW8DIsIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzi8tbR2
        MO5Z9UHvECMTB+MhRgkOZiUR3oDbi5KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCe
        WJKanZpakFoEk2Xi4JRqYFL9rVTSkX/X/qN/Ot9XOxnjiVcvGLHfOvUw3+W/6dTVUe5qPpcW
        ZPn91LjzIrtrgujK6zbujQ+T5wW7ZdYLPp5zPaQ387CywXzXphtTDq4V33Bk45dF5r0yJ7mF
        bh6Idd11Q32moYkyq0t4HXfOzGcs39d/1AxMSGLfn5C/OXJDyaH/+VH2yYuPKovJr7bskTFI
        P5rx6MXVSe3LTxkcyFi9jCuf561PrOeF2YEnFrfrT7PRO5gx7weT22KW9W++m1SXVZyWzEzJ
        /3ipcsV2z7WT3x3Xr/PNOJLlvsvfYoI3d7/9lXJxzUzmx5PbT50xfLtMdeaGyuJdKv5ZUxk2
        TJGI8kjKX7s7+LCUiCDTGiWW4oxEQy3mouJEALggItreAgAA
X-CMS-MailID: 20220610104353epcas5p19324d8bb48a250d4788ce24f859a3ec3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610104353epcas5p19324d8bb48a250d4788ce24f859a3ec3
References: <20220610104119.66401-1-alim.akhtar@samsung.com>
        <CGME20220610104353epcas5p19324d8bb48a250d4788ce24f859a3ec3@epcas5p1.samsung.com>
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

