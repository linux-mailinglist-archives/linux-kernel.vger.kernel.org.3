Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CB450ECFB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbiDYX5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiDYX5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:57:06 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99E08BE25
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:53:50 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220425235345epoutp028909471fe94f5fd94c02880ea7a17b1b~pSNat70oR0747307473epoutp02S
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:53:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220425235345epoutp028909471fe94f5fd94c02880ea7a17b1b~pSNat70oR0747307473epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650930825;
        bh=8DmheWAHiJOOBMIZdXyd/ayLZdS5Y+v68RlmlHShfDM=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=fyhL6p7Y+q43DRvLhWztzMWGG5N6Ho4L0sTJJyvFjzenMocv1q3iKoPNOWm0xqqE0
         +p24h1YA0b9wc37sRCEDWiMFa72gARYlME8dIJVj9n4gD2a5eFZOH2jV/3vshTDWW4
         nu6VLLtHV31d18KjWPGQyaMT4QBKNG01QRrRW4ts=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220425235344epcas5p4ba010c818708d47c2bc97d73dc6e2e93~pSNaT6DRX1935019350epcas5p4J;
        Mon, 25 Apr 2022 23:53:44 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KnMKd22wgz4x9Ps; Mon, 25 Apr
        2022 23:53:41 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.04.09827.58437626; Tue, 26 Apr 2022 08:53:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220425235340epcas5p4d42c97211ed8adb2306e6e080f5aed7b~pSNWr55mN1934619346epcas5p4N;
        Mon, 25 Apr 2022 23:53:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220425235340epsmtrp16f5aebcfaa717dce55a02fb9504889c4~pSNWrGsZ70882508825epsmtrp1R;
        Mon, 25 Apr 2022 23:53:40 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-ed-626734850e37
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.33.08924.48437626; Tue, 26 Apr 2022 08:53:40 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220425235339epsmtip1149328d15e7609af0df63573ef10e74d~pSNVKPnHm2202522025epsmtip1q;
        Mon, 25 Apr 2022 23:53:39 +0000 (GMT)
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
In-Reply-To: <20220424150333.75172-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 2/3] dt-bindings: timer: samsung,exynos4210-mct: drop
 unneeded minItems
Date:   Tue, 26 Apr 2022 05:23:37 +0530
Message-ID: <000001d858ff$b06a4950$113edbf0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHaU87sAxE9nZdTqWTdS25GH65v5wE8VlalAnNF3y2s39qqgA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmum6rSXqSweNZPBbzPstazD9yjtWi
        78VDZou9r7eyW2x6fI3V4vKuOWwWM87vY7J49zLConXvEXaLzZumMjtweWxa1cnmcefaHjaP
        d+fOsXtsXlLv8XmTnMfez79ZAtiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3M
        lRTyEnNTbZVcfAJ03TJzgO5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgV
        J+YWl+al6+WlllgZGhgYmQIVJmRnzJj/iamgh6diy63tTA2M+7m6GDk4JARMJH70VXcxcnEI
        CexmlGhZ8YsFwvnEKHHs2T92COczo8Tlb0eYuxg5wTrWt32DSuxilDi77BcbSEJI4CWjRNvE
        YhCbTUBXYsfiNjaQIhGBPcwS39etYgJJcAq4SNz9fZAdxBYWiJXYs60BrJlFQFXi6uZpYDW8
        ApYSfeemskLYghInZz5hAbGZBeQltr+dA3WFgsTPp8vAakQEnCTezfrBBlEjLvHy6BGw6yQE
        VnJIXJq1A6rBRWJW7ydGCFtY4tXxLewQtpTEy/42dkhgeEgs+iMFEc6QeLt8PVS5vcSBK3NY
        QEqYBTQl1u/Sh1jFJ9H7+wkTRCevREebEES1qkTzu6ssELa0xMTublYI20Ni4+VdzJBwu8go
        8bptHfMERoVZSL6cheTLWUi+mYWweQEjyypGydSC4tz01GLTAqO81HJ4fCfn525iBKdaLa8d
        jA8ffNA7xMjEwXiIUYKDWUmEd6pqWpIQb0piZVVqUX58UWlOavEhRlNg0E9klhJNzgcm+7yS
        eEMTSwMTMzMzE0tjM0Mlcd7T6RsShQTSE0tSs1NTC1KLYPqYODilGph2c7JsOWz149zL8/f+
        h2gdmaGfvUST51fF5l3CDBfjpxe+CHzxXXJOHd/5SLVZ2zz97cWsHj50mzTN+un/ANZswWs7
        y70Mz/Xw1bzlvRm0uG77i+YvP6p62Z3/JXNOOvL+oczbZ+uE76tf3qDylGnBSv8dQu9rL65i
        j57tVvNUj5HBNf+Ed62p9pey/NeL9T2PvCgSmRe81Htl4aeF+ufaJCtNpOULb5vO2Ht6d8fj
        TMNjb15afp/ZGXJbpV4t/b7hxBq1yvTEql91UlcfCl/Zp3DeIu/VUaOts6SLr+epLjJNeFcw
        +4VhkUyBVVt3VodH0Im12gz7V2zdmjz3gJDatSca59VC9X6Fhctf+HVaiaU4I9FQi7moOBEA
        rnouzD4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTrfFJD3JYNVjI4t5n2Ut5h85x2rR
        9+Ihs8Xe11vZLTY9vsZqcXnXHDaLGef3MVm8exlh0br3CLvF5k1TmR24PDat6mTzuHNtD5vH
        u3Pn2D02L6n3+LxJzmPv598sAWxRXDYpqTmZZalF+nYJXBkz5n9iKujhqdhyaztTA+N+ri5G
        Tg4JAROJ9W3f2LsYuTiEBHYwSrzYfpMJIiEtcX3jBHYIW1hi5b/nUEXPGSW2LDvJCpJgE9CV
        2LG4jQ0kISJwiFmi8cckZpCEkMBZRomex3YgNqeAi8Td3wfBJgkLREv0zF/EBmKzCKhKXN08
        DWwbr4ClRN+5qawQtqDEyZlPWLoYOTiYBfQk2jYygoSZBeQltr+dwwxxkILEz6fLwMpFBJwk
        3s36wQZRIy7x8ugR9gmMQrOQTJqFMGkWkkmzkHQsYGRZxSiZWlCcm55bbFhglJdarlecmFtc
        mpeul5yfu4kRHFdaWjsY96z6oHeIkYmD8RCjBAezkgjvVNW0JCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqY6sIcNn1JMr+cv0S93nRRePkeRcuUVu9p
        ffoc189drCt/+ffHHPNl3gv+LNa0SJttNGvf4/l5KZdkLzJ+3MQWn1TFx3Zuc7zX6dXfK2fM
        c1l1RTSpq1Xz4YMLtXKhf2cdb7wmxsf6Mnyy+oyvR9Nvcf3NnnT24KqZMRUXn799kPfDLWFP
        +1Wd+4F1xTpfl3Op7Nlu23L0Xei04zvOm2d8sIzulLeIMl7k/FvAXtRr/9Jk732X+q0ZFKKs
        447lx/BddPXpXmYguDl/ff8UXiHhDVOW7rF+sCP2bkLmzkjmz8EXS3z1Dy6/+bBU/stiCak3
        rZ7X8ixnmi7/9aCf/0760bM2bnFeO64snrEuhyWxX4mlOCPRUIu5qDgRAPtJUOYaAwAA
X-CMS-MailID: 20220425235340epcas5p4d42c97211ed8adb2306e6e080f5aed7b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220424150342epcas5p15d091f5063db79464c9e1e8ca3b55ef9
References: <20220424150333.75172-1-krzysztof.kozlowski@linaro.org>
        <CGME20220424150342epcas5p15d091f5063db79464c9e1e8ca3b55ef9@epcas5p1.samsung.com>
        <20220424150333.75172-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof

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
>Subject: [PATCH 2/3] dt-bindings: timer: samsung,exynos4210-mct: drop
>unneeded minItems
>
>There is no need to add minItems when it is equal to maxItems.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> .../devicetree/bindings/timer/samsung,exynos4210-mct.yaml        | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-
>mct.yaml
>b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
>index 1584944c7ac4..0e28d9bdb8cb 100644
>--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-
>mct.yaml
>+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-
>mct.yaml
>@@ -35,7 +35,6 @@ properties:
>           - const: samsung,exynos4210-mct
>
>   clocks:
>-    minItems: 2
>     maxItems: 2
>
>   clock-names:
>--
>2.32.0


