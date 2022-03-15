Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE10A4DA0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350429AbiCORGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350430AbiCORGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:06:37 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32B22019E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:05:24 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220315170523epoutp03dbb3a0c246e0df2892f73701c1c0498a~cnMKODidn2036920369epoutp03k
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:05:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220315170523epoutp03dbb3a0c246e0df2892f73701c1c0498a~cnMKODidn2036920369epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647363923;
        bh=yAd7+p8TVkfM7cei9FnECH3TEaPIde/ZlDqBS4Ms/Rs=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=mo+5sBM1NpNErZvCrvhGv18kTdQu7yrj90BYE48vtvGuPlgl4M8AIthABufxP1t0/
         K/RnGwESxzngt8fV8sNrP/aky7iQads4A04aw8oT8YCtZSTng5o7fY2TJ8RV/wX8zJ
         S38DsipDSJkuOUtmg6n87uay7L3pQd4CAP/KcQ4w=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220315170522epcas5p1bc6d11fde161a0b62fb32d36583c12b5~cnMJeuDDB0543305433epcas5p1h;
        Tue, 15 Mar 2022 17:05:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KJ0CK6N7Nz4x9Pw; Tue, 15 Mar
        2022 17:05:17 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.F5.05590.D47C0326; Wed, 16 Mar 2022 02:05:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220315170517epcas5p27937265cf204d8335a9e3b0cac52ee74~cnME4kfur1098610986epcas5p2O;
        Tue, 15 Mar 2022 17:05:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220315170517epsmtrp2f40d19b58ef0efaf666534dad1b6dae5~cnME303MD0550705507epsmtrp2Y;
        Tue, 15 Mar 2022 17:05:17 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-2d-6230c74d04a0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.C5.29871.D47C0326; Wed, 16 Mar 2022 02:05:17 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220315170515epsmtip2d4d9011370f6e1926e3f2ffbf2356548~cnMDhozpf2016520165epsmtip22;
        Tue, 15 Mar 2022 17:05:15 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzk+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220314181948.246434-4-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH 4/5] dt-bindings: usb: samsung,exynos-usb2: add missing
 required reg
Date:   Tue, 15 Mar 2022 22:35:14 +0530
Message-ID: <063701d8388e$d83f53d0$88bdfb70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQB7dPZKCRCsS+x0KxttMJEPHi23NwKr4VcRAehR/+qvVZH/AA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmhq7vcYMkgy/79C3mHznHatG8eD2b
        xctZ99gsNr79wWSx6fE1VovLu+awWcw4v4/JYtGyVmaL1r1H2B04PWY19LJ5bFrVyeaxf+4a
        do/NS+o9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
        8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeX
        WmJlaGBgZApUmJCd8bHlA2vBVZ6KzYtXMjcwNnN3MXJySAiYSOy5v5+ti5GLQ0hgN6PEhZNN
        rBDOJ0aJ1ceuMkM43xglpq1bAuRwgLX0vReAiO9llFhycQkjhPOSUWLKthZWkLlsAroSOxa3
        gc0VEfjFJLG24QYrSDengIfEpk8VIDXCAlESZx80MILYLAKqEsvevgbr5RWwlPh9+QcThC0o
        cXLmExYQm1lAXmL72znMEHcrSPx8ugysXkTASeLzwf9MEDXiEi+PHmEH2SshMJND4tOlLjaI
        q10k+u5HQPQKS7w6voUdwpaS+PxuL1RJtkTPLmOIcI3E0nnHWCBse4kDV+awgJQwC2hKrN+l
        D7GJT6L39xMmiE5eiY42IYhqVYnmd1ehOqUlJnZ3s0LYQH+3L4KG1E1GiTXf97JNYFSYheTJ
        WUienIXkmVkImxcwsqxilEwtKM5NTy02LTDOSy2HR3dyfu4mRnBi1fLewfjowQe9Q4xMHIyH
        GCU4mJVEeM+80E8S4k1JrKxKLcqPLyrNSS0+xGgKDPmJzFKiyfnA1J5XEm9oYmlgYmZmZmJp
        bGaoJM57Kn1DopBAemJJanZqakFqEUwfEwenVAPTnPXZBnlrcm7dvKTL1C3HNf+w0faNFs+f
        /g5hfGd5x6GhuUdd8NCWhmPbxK7rxb8MWsRtvYjh8Or2l8ad3Cu8bF+JGO/47KVhKtVp3nwj
        iEOkfPv+P29vKR3p8rwvv/XqvgfFdt4mam6f/J99YVPdJvh/7hbZZZFHVPQTvUp0fq849Y35
        aNWCOWZ13YkSr3RFj22+KeDAfspW9yzfrG5+UQbH9M+WYX7c17qvpP5O15gQZ/BSTLj6jxhX
        kZhUdkaSZZDZkyX+CzxNzqjcfqJx1rhw5Z54iSSeLl2Gf2dynuu9S7lzYH6z0u4vd7mYlSe/
        nhZ2UVzy+qvtt6Q/WUcEWWx67y91ZW7pe/auV8+UWIozEg21mIuKEwE5yigVNQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSvK7vcYMkg47zQhbzj5xjtWhevJ7N
        4uWse2wWG9/+YLLY9Pgaq8XlXXPYLGac38dksWhZK7NF694j7A6cHrMaetk8Nq3qZPPYP3cN
        u8fmJfUenzfJBbBGcdmkpOZklqUW6dslcGV8bPnAWnCVp2Lz4pXMDYzN3F2MHBwSAiYSfe8F
        uhg5OYQEdjNKvOiOBbElBKQlrm+cwA5hC0us/PccyOYCqnnOKPH9wVZmkASbgK7EjsVtbCC2
        iEADs8SVxwIQRVcZJV5NbmQFWcAp4CGx6VMFSI2wQITEvKZZTCA2i4CqxLK3r1lBbF4BS4nf
        l38wQdiCEidnPmEBaWUW0JNo28gIEmYWkJfY/nYOM8Q9ChI/ny5jhVjrJPH54H8miBpxiZdH
        j7BPYBSahWTSLIRJs5BMmoWkYwEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOAI
        0tLcwbh91Qe9Q4xMHIyHGCU4mJVEeM+80E8S4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8
        kEB6YklqdmpqQWoRTJaJg1OqgenEnofHDDp4HU7M2pd2/a1gcXCATIw/021/zjnyT7hqeZdX
        uj1RW/P5lrlKk1ceB1/0LlW1RmX1+f0Sn1KCG9wuvXzjxDn91Vkti/UKT8/M22Eo8/pujfSK
        v3mynDOM9gge+8rwZXtxen34Ks0PhQuEwldn9LqUlQRZr+Crndd3++Nl1oepGVKV9pvbrsdr
        VFT06pQmLf886ZhtJn/D3vlb3vF4aYmKZ0yexSpy5/eSvzFPpuVe/2j3YYXwFzeFp/Xra78X
        vXty88ODIPnWC761CeuMzs96wKKrJck6v/RE69ytvxynPOP6Hxkd5jnX9ANX518NoWpLnc6C
        BY9Yk5qsDj5axfuRJW1C4YWGTUosxRmJhlrMRcWJAN3+iMcPAwAA
X-CMS-MailID: 20220315170517epcas5p27937265cf204d8335a9e3b0cac52ee74
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220314182018epcas5p47d847a6c2d2e054961f52460df00c2fd
References: <20220314181948.246434-1-krzysztof.kozlowski@canonical.com>
        <CGME20220314182018epcas5p47d847a6c2d2e054961f52460df00c2fd@epcas5p4.samsung.com>
        <20220314181948.246434-4-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Monday, March 14, 2022 11:50 PM
>To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
><robh+dt@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Alim
>Akhtar <alim.akhtar@samsung.com>; linux-usb@vger.kernel.org;
>devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>Subject: [PATCH 4/5] dt-bindings: usb: samsung,exynos-usb2: add missing
>required reg
>
>"reg" property is required on Samsung S5PV210/Exynos EHCI/OHCI
>controllers.
>
>Fixes: 4bf2283cb208 ("dt-bindings: usb: samsung,exynos-usb2: convert to
>dtschema")
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


>---
>
>Fixed commit in current next. If this should go as fix, I can split it from
the
>second commit.
>---
> Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-
>usb2.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-
>usb2.yaml
>index fbf07d6e707a..ef42c6fce73c 100644
>--- a/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
>+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
>@@ -62,6 +62,7 @@ required:
>   - interrupts
>   - phys
>   - phy-names
>+  - reg
>
> allOf:
>   - if:
>--
>2.32.0


