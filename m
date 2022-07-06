Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9C85686A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiGFLVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiGFLVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:21:35 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E1D27CED
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:21:34 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220706112133epoutp032d8ce055c68bcc091d64575a52ea5acb~-OZNggVWn1341113411epoutp039
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:21:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220706112133epoutp032d8ce055c68bcc091d64575a52ea5acb~-OZNggVWn1341113411epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657106493;
        bh=o/QYmRdMwiUqFnRC2XBOpfzCUNnu0wBeI++zfvEnm4Q=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=XAXKDn+HFAKjHE4rEjUMGDp6g+aWRnUkrsB+t/C7nS/VrC6MV5zll7N6i+XsyAJG2
         QP5kDv69QOlp10JJjMQzr2iTyxcd4AcoR1YGAct7oXwg4uLlgutPA3ZyGNxxx3EEPl
         WKC9sTwQMAlQ87JM7KcplN1iDJqz2sd6AAB/Rmtc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220706112132epcas5p278b7d90a7fcf3b019aec8d75d1619724~-OZMvaU8-1152811528epcas5p22;
        Wed,  6 Jul 2022 11:21:32 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LdHDT0Wd6z4x9Q2; Wed,  6 Jul
        2022 11:21:29 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.02.09662.33075C26; Wed,  6 Jul 2022 20:21:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220706112123epcas5p206d4f5b19416ba32e6d5866cd120e881~-OZEWdGaA2965729657epcas5p2U;
        Wed,  6 Jul 2022 11:21:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220706112123epsmtrp1ba346a5a21dac5121e5656dbe2431d5e~-OZEVrph81902619026epsmtrp1o;
        Wed,  6 Jul 2022 11:21:23 +0000 (GMT)
X-AuditID: b6c32a49-86fff700000025be-54-62c570339881
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.CA.08905.33075C26; Wed,  6 Jul 2022 20:21:23 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220706112121epsmtip1791e2145d9156e4d23e57ada32a8d8b2~-OZDAkJkf1563715637epsmtip1Q;
        Wed,  6 Jul 2022 11:21:21 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Chanho Park'" <chanho61.park@samsung.com>
In-Reply-To: <20220706095037.78542-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/3] dt-bindings: soc: samsung: exynos-pmu: cleanup
 assigned clocks
Date:   Wed, 6 Jul 2022 16:51:19 +0530
Message-ID: <02d401d8912a$85e10440$91a30cc0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGzAqFCMuJdwGU7SRaoUkZ/n4vDtwGv0xjura7QrYA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmhq5xwdEkg8lvTSwu79e2mH/kHKtF
        34uHzBZ7X29lt9j0+BqrxeVdc9gsZpzfx2TRuvcIuwOHx6ZVnWwed67tYfPYvKTeo2/LKkaP
        z5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
        gC5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgY
        mQIVJmRnLF+sVnCfu+L9oyWsDYxzuboYOTkkBEwkZl9dxN7FyMUhJLCbUWLHvPMsIAkhgU+M
        El/e80EkvjFKzOp+yQbTcX/hd2aIxF5GiTUHd0I5Lxkl+qbNZgWpYhPQldixuI0NJCEisIlJ
        4sv+vewgCWYBfYmFna8Yuxg5ODgFXCR+Pk4DCQsLREosf3SGCcRmEVCRaN+yFaycV8BS4kvn
        DyhbUOLkzCcsEGPkJba/ncMMcZGCxM+ny8D2ighYSXx4eh+qRlzi5dEjYL9JCMzlkHg/+yI7
        RIOLxI2XTSwQtrDEq+NboOJSEi/729hBbpMQ8JBY9EcKIpwh8Xb5ekYI217iwJU5LCAlzAKa
        Eut36UOs4pPo/f2ECaKTV6KjTQiiWlWi+d1VqEXSEhO7u1khbA+JBfc3sE9gVJyF5LFZSB6b
        heSBWQjLFjCyrGKUTC0ozk1PLTYtMMxLLYfHdnJ+7iZGcCrV8tzBePfBB71DjEwcjIcYJTiY
        lUR4V006mCTEm5JYWZValB9fVJqTWnyI0RQY2hOZpUST84HJPK8k3tDE0sDEzMzMxNLYzFBJ
        nNfr6qYkIYH0xJLU7NTUgtQimD4mDk6pBqbaniUhmX+c7gmudf4xY4PwlVQ5+YP+aT/fircp
        8DIx9j0uM3ZS15SPia13X7Kj+sgTxv5rH/axBm422BcZPvPAkmmxxu3Os9QPrzNh67nh0eA5
        89X10ndNG36/eXmw8+eEpRP1GfKSF4vNcMiW2T5fo22qetWx07cW3/wT+OTGMg5+g/VGbhct
        5kopLlWTPXjs78SVwuaFu9m3W22deZHH9YN7uOWskKCwg7/99kt9VrGK5XW/m9P1viHHkTUj
        7MOiw3MiJXvSL/hpfBc0+7kv0E7j79PElbN6d+9aqq0m+Kr8nmxgkO/pY0Kul70qVtVGLVtV
        fbT4R+r34q4qyTwuZp5bKjuZjkioF/d6PVNiKc5INNRiLipOBABOrks9LgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTte44GiSwZUvzBaX92tbzD9yjtWi
        78VDZou9r7eyW2x6fI3V4vKuOWwWM87vY7Jo3XuE3YHDY9OqTjaPO9f2sHlsXlLv0bdlFaPH
        501yAaxRXDYpqTmZZalF+nYJXBnLF6sV3OeueP9oCWsD41yuLkZODgkBE4n7C78zdzFycQgJ
        7GaUuLb+NiNEQlri+sYJ7BC2sMTKf8/ZIYqeM0rM3NjMBpJgE9CV2LG4jQ0kISKwjUliVfMf
        sASzgL7Ews5XjBAdUxklOv79B3I4ODgFXCR+Pk4DqREWCJeYc2IrE4jNIqAi0b5lK9g2XgFL
        iS+dP6BsQYmTM5+wgLQyC+hJtG1khBgvL7H97RxmiOMUJH4+XcYKYosIWEl8eHqfBaJGXOLl
        0SPsExiFZyGZNAth0iwkk2Yh6VjAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4
        orQ0dzBuX/VB7xAjEwfjIUYJDmYlEd5Vkw4mCfGmJFZWpRblxxeV5qQWH2KU5mBREue90HUy
        XkggPbEkNTs1tSC1CCbLxMEp1cA0p4P/Sh7H5PxzVjyGXc/cQv5ucRQq+G+8c5qewYMAqVWT
        NLO+PtdyWCx7RGl6fJOqXNjt7y8+8tkdlUuf7DpNRvR1sIyYscB0awP/3fuPrZt/+Bjv+r3n
        AuK+Hc45XhImflj66eXdX+Ye+eEqHj55nfKMmbuTE49OuDX9kumGdLHqL2J+6+znaHw74ygQ
        teZ8uePUU89nlSmf1uFawzn9/VrPT7tM17pb/Jy4TmqynIloactGm0Wr0h/8VSjbrHHvR9b6
        hiO6qw8XRn/d2G0RvttE9Xqb7+z3zdpXy23fbjPdNXtfIZvLsxT3I41f71b+Xv33e2QJ0xym
        co8yIyYu1psNR08H/MlcMtve2qFFWImlOCPRUIu5qDgRAC/zV0gXAwAA
X-CMS-MailID: 20220706112123epcas5p206d4f5b19416ba32e6d5866cd120e881
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220706095044epcas5p36a3f3a15e71dc95d11053e9a5343b8fa
References: <CGME20220706095044epcas5p36a3f3a15e71dc95d11053e9a5343b8fa@epcas5p3.samsung.com>
        <20220706095037.78542-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Wednesday, July 6, 2022 3:21 PM
>To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar <alim.akhtar@samsung.com>;
>devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
>Cc: Chanho Park <chanho61.park@samsung.com>; Krzysztof Kozlowski
><krzysztof.kozlowski@linaro.org>
>Subject: [PATCH 1/3] dt-bindings: soc: samsung: exynos-pmu: cleanup
assigned
>clocks
>
>"assigned-clocks" are not needed in the schema as they come from DT schema.
>
Sorry, I didn't get this, you mean "assigned-clocks" comes from DT so it is
not required to be mentioned in schema?

>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---
> Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 3 ---
> 1 file changed, 3 deletions(-)
>
>diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
>b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
>index c30a6437030d..a5d489acfdca 100644
>--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
>+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
>@@ -49,9 +49,6 @@ properties:
>   reg:
>     maxItems: 1
>
>-  assigned-clock-parents: true
>-  assigned-clocks: true
>-
>   '#clock-cells':
>     const: 1
>
>--
>2.34.1


