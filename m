Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1B250ED1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbiDZAEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbiDZAE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:04:27 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649C61AD9F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:01:22 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220426000117epoutp0106fb0bd8d82e31c883796cd167e81507~pSUARMs6P2906129061epoutp019
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:01:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220426000117epoutp0106fb0bd8d82e31c883796cd167e81507~pSUARMs6P2906129061epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650931277;
        bh=GimoD6qGuWLJyeFWIK9IujzH6NUZ3CprhxDcFFz7JrA=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=Xmd00C43bnnrnbuSpsjHkUB/cdM2UipiVjliRPkI/RV0KGBum6fpHu2DrLFaLSrMo
         6t6C7Hvx2a1KkhlD0EueeDiAQcvqsltBwCZS6h8iY4jSFIMXSLv9TRbKp5QoVo8FDf
         t9usr28+SyhCvalsYh5ajOChJbcAY1ZFPLkBifTs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220426000117epcas5p1de755392332312d63a63e5bbac820cf2~pST-2ZGja2176221762epcas5p1C;
        Tue, 26 Apr 2022 00:01:17 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KnMVK6hHjz4x9Q8; Tue, 26 Apr
        2022 00:01:13 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.C5.09827.84637626; Tue, 26 Apr 2022 09:01:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220426000112epcas5p22e51ad928e52d68787d569e06a3d9805~pST690NbA3019630196epcas5p2H;
        Tue, 26 Apr 2022 00:01:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220426000112epsmtrp22b2c4eb59870aada7df96468acd8d186~pST68rhAy0547005470epsmtrp2V;
        Tue, 26 Apr 2022 00:01:12 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-ae-62673648f289
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.64.08853.84637626; Tue, 26 Apr 2022 09:01:12 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220426000110epsmtip2bc6c895499dd43e18b6ff54613b5b60a~pST5cyMkr1450014500epsmtip2p;
        Tue, 26 Apr 2022 00:01:10 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Michal Simek'" <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20220424150333.75172-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/3] dt-bindings: timer: cdns,ttc: drop unneeded
 minItems
Date:   Tue, 26 Apr 2022 05:31:09 +0530
Message-ID: <000201d85900$bd63dc60$382b9520$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQII0WGKzXEWbxLvIkIx05f6+2SGHgHaU87srJGLx7A=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmpq6HWXqSwclpKhbzPstazD9yjtWi
        78VDZou9r7eyW2x6fI3V4vKuOWwWM87vY7J49zLConXvEXaLzZumMjtweWxa1cnmcefaHjaP
        d+fOsXtsXlLv8XmTnMfez79ZAtiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3M
        lRTyEnNTbZVcfAJ03TJzgO5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgV
        J+YWl+al6+WlllgZGhgYmQIVJmRnrO49yVRwibviwaeFrA2MXVxdjJwcEgImEp/uvWLtYuTi
        EBLYzShx8MRnRgjnE6PEz1MnmUGqhAS+MUqsW2YD03GtZyE7RNFeRonFE6YxQTgvGSXmzn/D
        DlLFJqArsWNxGxtIQkRgD7PE93WrmEASnAIuErvbPoKNFRbwl9i75QhYA4uAqsT5xouMIDav
        gKXE9WdnmSFsQYmTM5+wgNjMAvIS29/OYYY4Q0Hi59NlrCC2iICVxMSeZcwQNeISL48eATtP
        QmAph8TR1odAV3AAOS4SJ195QfQKS7w6voUdwpaS+PxuL1SJh8SiP1IQ4QyJt8vXM0LY9hIH
        rsxhASlhFtCUWL9LH2ITn0Tv7ydMEJ28Eh1tQhDVqhLN766yQNjSEhO7u1khbA+Jbyd2sUGC
        ajqjxPc/P9gnMCrMQvLkLCRPzkLyzCyEzQsYWVYxSqYWFOempxabFhjlpZbD4zs5P3cTIzjV
        anntYHz44IPeIUYmDsZDjBIczEoivFNV05KEeFMSK6tSi/Lji0pzUosPMZoCQ34is5Rocj4w
        2eeVxBuaWBqYmJmZmVgamxkqifOeTt+QKCSQnliSmp2aWpBaBNPHxMEp1cDUE7buf9iDNwVv
        zJxZuHP5oqdldT99FDC7cQPjmTnrlyjwbJwWZ+p7qfRbYoXEl47Nzcsziypf2q0pvxwxa9r0
        ouApWs9u91S83Rc0P5TTduWCjRnrN5R8/lPpEVWc8C7rWuNJyxv/rz/eqJVcmvDwwflVX24o
        CCW/M9VfZfXu3Po9hVJ7bkod/aWheifo+6md6y8/itC+7lei/trkxdvyFx3l+2PUntrNXqZ+
        at733zoNdxnqTuww0airz/F9zvLp37uyT3ec4jvcW2Xk/NkPM19+oSrBud3o5x/WY6sv7I7l
        b+gSjly5btbc3CVHV/59/Tg94qnMP3muZ680st7ufrxHa768YqhU5QSf76lx2kosxRmJhlrM
        RcWJAHJTu/I+BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXtfDLD3J4G0zm8W8z7IW84+cY7Xo
        e/GQ2WLv663sFpseX2O1uLxrDpvFjPP7mCzevYywaN17hN1i86apzA5cHptWdbJ53Lm2h83j
        3blz7B6bl9R7fN4k57H382+WALYoLpuU1JzMstQifbsErozVvSeZCi5xVzz4tJC1gbGLq4uR
        k0NCwETiWs9C9i5GLg4hgd2MEnf7jrFCJKQlrm+cwA5hC0us/PcczBYSeM4o8eRTIIjNJqAr
        sWNxGxtIs4jAIWaJxh+TmCEmTWWUuNm/lxGkilPARWJ320dmEFtYwFdi9fy/LCA2i4CqxPnG
        i2A1vAKWEtefnWWGsAUlTs58AlTDwcEsoCfRthGshFlAXmL72znMEAcpSPx8ugzsUBEBK4mJ
        PcuYIWrEJV4ePcI+gVFoFpJJsxAmzUIyaRaSjgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz
        0vWS83M3MYLjSktzB+P2VR/0DjEycTAeYpTgYFYS4Z2qmpYkxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA5NZ04QrJhbSfSYsftMS9uVMkQi74fXT52Rm
        2JH/brtr9zecnpUoq+efZLQ9RTL5T4/g5Gpr+4P/nBJjTB6G9UrfX6+ZGNGkZ/L1Ucjl/0o3
        hEOaGhdV6TDKOLJXPzVZknWYcc3ptmbZPXYlmhscsiWZrt2eUZ7Y/63eeBXPZJun8YdzL2WX
        R9y5FTHRxEgh8fe2TYf3xC4/3rq0TqHnIevbMtX3KxUVQoM+rFodGW548MU5BektL55fmar7
        M6ri2r44GVvzWq/acKcGnlPpz+Kkeo4usxM5835iyQS51YwHJZ0q62oz9y29ec3Ss/8HmyTP
        o3lxXTc1VKfrn3dJSRf95Gf35tYO/erQNuMjSizFGYmGWsxFxYkAfv6MbxoDAAA=
X-CMS-MailID: 20220426000112epcas5p22e51ad928e52d68787d569e06a3d9805
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220424150341epcas5p2869805d428b629165f3b272fde50317c
References: <CGME20220424150341epcas5p2869805d428b629165f3b272fde50317c@epcas5p2.samsung.com>
        <20220424150333.75172-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Sunday, April 24, 2022 8:34 PM
>To: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
><tglx@linutronix.de>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; Michal Simek <michal.simek@xilinx.com>;
>linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>Subject: [PATCH 1/3] dt-bindings: timer: cdns,ttc: drop unneeded minItems
>
>There is no need to add minItems when it is equal to maxItems.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> Documentation/devicetree/bindings/timer/cdns,ttc.yaml | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
>b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
>index c3386076a98c..7d821fd480f6 100644
>--- a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
>+++ b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
>@@ -17,7 +17,6 @@ properties:
>     maxItems: 1
>
>   interrupts:
>-    minItems: 3
>     maxItems: 3
>     description: |
>       A list of 3 interrupts; one per timer channel.
>--
>2.32.0


