Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D41B580A22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 05:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbiGZDz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 23:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiGZDzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:55:54 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215837674
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 20:55:52 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220726035550epoutp01e5ebec9f6c6d6cc301fb6138696c1226~FRNwtiUnK2579225792epoutp01X
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:55:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220726035550epoutp01e5ebec9f6c6d6cc301fb6138696c1226~FRNwtiUnK2579225792epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658807750;
        bh=fbcLM874Vz+W4WSi9y5XBWvhudbB9qUC0fnLm9sOjTg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=mDUIqTcKQ4p9gY96ARyLc81vML3F60LykcQfMTV1wI9nUyYpp/LzAiaoJ11iwJ2aE
         6EGuRw3WdSuRDKiC8iqYVbWZStB/enMjV/6xCHW0on4S2t5LEcJukV33K1++BGKN9w
         BuGR9jbxb2VGxxRinHO8Fbdqnry/JIj697A+UQek=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220726035549epcas5p31e2872f38aadcf0a99c6cefbcb81689a~FRNv1yBv30765407654epcas5p3H;
        Tue, 26 Jul 2022 03:55:49 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LsNNy1zYxz4x9Q0; Tue, 26 Jul
        2022 03:55:46 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.EA.09639.BB56FD26; Tue, 26 Jul 2022 12:55:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220726035538epcas5p4135e63f642ef49535ff12d25c5846e4d~FRNl6b2do0887508875epcas5p4K;
        Tue, 26 Jul 2022 03:55:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220726035538epsmtrp2c8c3317535a72cb2990c979f4f47e800~FRNl5j9vJ0718607186epsmtrp2z;
        Tue, 26 Jul 2022 03:55:38 +0000 (GMT)
X-AuditID: b6c32a4b-e6dff700000025a7-11-62df65bb1675
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.6B.08905.AB56FD26; Tue, 26 Jul 2022 12:55:38 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220726035536epsmtip15e06a5b0baf4bea3dd788359ca92263c~FRNkMRmxr2640726407epsmtip1Y;
        Tue, 26 Jul 2022 03:55:36 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Johan Hovold'" <johan+linaro@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>
Cc:     "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Avri Altman'" <avri.altman@wdc.com>,
        "'Bart Van Assche'" <bvanassche@acm.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220711101441.4896-1-johan+linaro@kernel.org>
Subject: RE: [PATCH] dt-bindings: ufs: qcom,ufs: add SC8280XP binding
Date:   Tue, 26 Jul 2022 09:25:35 +0530
Message-ID: <000001d8a0a3$913c2120$b3b46360$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGXKANTK7IsGceyoQ2tYQ03261akwKSTS7Prf5j5AA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmpu7u1PtJBrfXCFmce/ybxeLlz6ts
        Fqf3v2OxmPbhJ7PF/CPnWC1WVFr0vXjIbDFx/1l2i8u75rBZdF/fwWax/Pg/JovWvUfYHXg8
        Ll/x9ti0qpPN4861PWweH5/eYvH4vEnOo/1AN1MAW1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8
        c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QhUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OIS
        W6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IzPDwoKpvJVbP8wmbmBcSZ3FyMnh4SA
        icSr2c9Yuxi5OIQEdjNK7PjUzQiSEBL4xCjx5r0ZROIbo8SC6fuYYTq6m99CdexllJh8uYUZ
        wnnJKPHv/2mwKjYBXYkdi9vYQBIiAmcYJbZ9PAOWYBZYxyTx7qIgiM0pYCOx//hsFhBbWMBV
        4sfvGUC7OThYBFQlTr3SBwnzClhK/Nh2hh3CFpQ4OfMJC8QYeYntb+dAXaQg8fPpMlYQW0TA
        SuJ01y82iBpxiZdHj7CD3CAhcIRDoqN3IjtEg4vE1p1LWCFsYYlXx7dAxaUkPr/bywZyg4SA
        h8SiP1IQ4QyJt8vXM0LY9hIHrsxhASlhFtCUWL9LH2IVn0Tv7ydMEJ28Eh1tQhDVqhLN766y
        QNjSEhO7u6GWekicOnaNcQKj4iwkj81C8tgsJA/MQli2gJFlFaNkakFxbnpqsWmBcV5qOTy2
        k/NzNzGCU6+W9w7GRw8+6B1iZOJgPMQowcGsJMKbEH0/SYg3JbGyKrUoP76oNCe1+BCjKTCw
        JzJLiSbnA5N/Xkm8oYmlgYmZmZmJpbGZoZI4r9fVTUlCAumJJanZqakFqUUwfUwcnFINTCfr
        3EyfOU7sC9PsCuXb9L2xrn39U8ZLaWteb5w1NWryklWn61VM6207pCa2Twk1v5i0nZ3/kanf
        m+sH/3/y0uAucvWqbD1kJ90U0cWxMDJXpq7y0oRl5laSW354q1xg+loUWHCV0Tp2XZankL2k
        XMnCNTmcM5+WaOqHpnDnrdXgOcyYyFmaF65a0jgzpVfok6N78UU9y8D/E/YXZjtZH45P2Lfg
        565sToHMVS/fG6/Jm/+3Ut7WZbbe9kr9i3e+e2kwzGPz9mlbeaxom0N8VrvWLAXmyXfnT3j1
        NqCt6/EpG2vrjSlvHl4Mv9zGWlov4JjoMnH/y6QPh0tjpy2z4vY7GCt6+92hDR6/0oyUWIoz
        Eg21mIuKEwFqoCUERgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSnO6u1PtJBvfmy1qce/ybxeLlz6ts
        Fqf3v2OxmPbhJ7PF/CPnWC1WVFr0vXjIbDFx/1l2i8u75rBZdF/fwWax/Pg/JovWvUfYHXg8
        Ll/x9ti0qpPN4861PWweH5/eYvH4vEnOo/1AN1MAWxSXTUpqTmZZapG+XQJXxucHBQVT+Sq2
        f5jM3MA4k7uLkZNDQsBEorv5LWsXIxeHkMBuRommrc9ZIBLSEtc3TmCHsIUlVv57zg5R9JxR
        YtX72WBFbAK6EjsWt7GBJEQEzjBK3H7cwgLiMAtsYZJoPbaTEaKll1Hi6ME9zCAtnAI2EvuP
        Q7QLC7hK/Pg9A6iIg4NFQFXi1Ct9kDCvgKXEj21n2CFsQYmTM5+wgJQwC+hJtG1kBAkzC8hL
        bH87hxniOgWJn0+XsYLYIgJWEqe7frFB1IhLvDx6hH0Co/AsJJNmIUyahWTSLCQdCxhZVjFK
        phYU56bnFhsWGOallusVJ+YWl+al6yXn525iBMegluYOxu2rPugdYmTiYDzEKMHBrCTCmxB9
        P0mINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpsie9l9y
        K5wE/BjmP2dRWHLM3fHSusmbzzoGG83I6herfqeRmy0SMjv2FxP/0V/37nJ2ptssffemZdF2
        y6SQ9lZRo0eKApZhafePKpUUsi2Zzb/ibtLiDWvqqo4ttTq2fguv9jOd63NvJ0lM3G7zv/t3
        jGqv0cLtlTGM6VrSfLaVJ3P/y4vZXLpX0mOW7XL/cb6Uyru3Ka/frzXP75z7YtHt2Qn7Sjgs
        DQzX2dhUq5c+2dO9fbn2/ZY+P2GNG4qm7IFZ5u/SFv7Zde2Ay5nQ8ycUXqsEn1LVFpd51n5R
        QVS77yrH4+JPoZNk9kgG/TxYXb7N1zxh5T7p2Rc31cvtOx3sc69SOqWmZeHmqbXzlViKMxIN
        tZiLihMBzC3QSjADAAA=
X-CMS-MailID: 20220726035538epcas5p4135e63f642ef49535ff12d25c5846e4d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220711101520epcas5p421bdaef157484ed146577e5deea04e09
References: <CGME20220711101520epcas5p421bdaef157484ed146577e5deea04e09@epcas5p4.samsung.com>
        <20220711101441.4896-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Martin K

>-----Original Message-----
>From: Johan Hovold [mailto:johan+linaro@kernel.org]
>Sent: Monday, July 11, 2022 3:45 PM
>To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>
>Cc: Andy Gross <agross@kernel.org>; Bjorn Andersson
><bjorn.andersson@linaro.org>; Alim Akhtar <alim.akhtar@samsung.com>;
>Avri Altman <avri.altman@wdc.com>; Bart Van Assche
><bvanassche@acm.org>; linux-arm-msm@vger.kernel.org; linux-
>scsi@vger.kernel.org; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org; Johan Hovold <johan+linaro@kernel.org>
>Subject: [PATCH] dt-bindings: ufs: qcom,ufs: add SC8280XP binding
>
>Add SC8280XP to the DT schema.
>
>Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

@ Martin, 
Is this something you can take via your tree?

> Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>index dcd32c10205a..f2d6298d926c 100644
>--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>@@ -26,6 +26,7 @@ properties:
>           - qcom,msm8994-ufshc
>           - qcom,msm8996-ufshc
>           - qcom,msm8998-ufshc
>+          - qcom,sc8280xp-ufshc
>           - qcom,sdm845-ufshc
>           - qcom,sm6350-ufshc
>           - qcom,sm8150-ufshc
>@@ -98,6 +99,7 @@ allOf:
>           contains:
>             enum:
>               - qcom,msm8998-ufshc
>+              - qcom,sc8280xp-ufshc
>               - qcom,sm8250-ufshc
>               - qcom,sm8350-ufshc
>               - qcom,sm8450-ufshc
>--
>2.35.1


