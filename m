Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491504E2572
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346853AbiCULuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344272AbiCULuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:50:20 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E4151302
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:48:52 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220321114851epoutp01f275b7a91c1f02de362841b769fe579c~eYvgE67Ex1553315533epoutp01N
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:48:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220321114851epoutp01f275b7a91c1f02de362841b769fe579c~eYvgE67Ex1553315533epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647863331;
        bh=cVmbILAOErI1/Ntsxmq2/4Qe7dFI/4RFsr+Bznbjtw8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=pcFxUeREUOsvZdn8AEOy0RCSKTnVLZg9SLyQUXVuKrk/GBN2MTXNSLimAeJeA0y86
         2MUS/5k3opwH1t79bltOLravq2dQHYdxVk9teDhEXPYQi7tPWCIlV2AgRuJdMVUrqV
         NhwJ7Tckc+mZ0S1x3U3hMxA1JAuLvbO34WqQjWWk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220321114850epcas5p3cc7ef564bef30093d8c9e293a2309268~eYvfHHhAE1354413544epcas5p3G;
        Mon, 21 Mar 2022 11:48:50 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KMXvJ0FVVz4x9Q7; Mon, 21 Mar
        2022 11:48:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.B0.12523.B1668326; Mon, 21 Mar 2022 20:48:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220321114843epcas5p2d8ed09bcc95965e899ec9bf9f2e538a3~eYvY5nEdP0791907919epcas5p2x;
        Mon, 21 Mar 2022 11:48:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220321114843epsmtrp1446a9dd71c1fe67c0a621fc60828fa9c~eYvY4xl033127731277epsmtrp1Q;
        Mon, 21 Mar 2022 11:48:43 +0000 (GMT)
X-AuditID: b6c32a4a-5b7ff700000030eb-16-6238661be9e5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.A8.03370.B1668326; Mon, 21 Mar 2022 20:48:43 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220321114839epsmtip2303f733938f43f5bc9ee880d74948e4f~eYvVei-_J1710117101epsmtip2U;
        Mon, 21 Mar 2022 11:48:38 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Luca Weiss'" <luca.weiss@fairphone.com>,
        <linux-arm-msm@vger.kernel.org>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Avri Altman'" <avri.altman@wdc.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzk+dt@kernel.org>,
        <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20220318183004.858707-2-luca.weiss@fairphone.com>
Subject: RE: [PATCH 1/6] scsi: ufs: dt-bindings: Add SM6350 compatible
 string
Date:   Mon, 21 Mar 2022 17:18:37 +0530
Message-ID: <002001d83d19$9d596d70$d80c4850$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDZaQauO888J59Marq/WZ4JfNFAKQH2rYCJAgAjn6Sup6oXsA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmuq50mkWSwfMmK4tzj3+zWLz8eZXN
        4vT+dywW84+cY7V4Oesem8XE/WfZLS7vmsNm0X19B5vFwxVGFgv+2Fm07j3CbrH5+19GBx6P
        tqaXrB6bVnWyedy5tofN4/+dtewenzfJebQf6GYKYIvKtslITUxJLVJIzUvOT8nMS7dV8g6O
        d443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlFJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9c
        YquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ0xZ9EBpoLZPBXn3jeyNTDO5+pi5OSQ
        EDCR6Pq8mh3EFhLYzSjx5b8ehP0JyO5JgLA/M0pMOWcNU/9nyWtmiPguRolJDeZdjFxA9ktG
        iQs3PzOBJNgEdCV2LG5jA7FFBAIkTm07wgJSxCzQyCyx7f0NFpAEp4C9xNz+TrBJwgL+Ekum
        LQGLswioSvya9RnsIl4BS4mrf2dC2YISJ2c+AathFpCX2P52DjPERQoSP58uY4VY5iTxbvMi
        qBpxiZdHj7CDLJYQOMAh8erTW0aIBheJIyvuskDYwhKvjm9hh7ClJF72twHZHEB2tkTPLmOI
        cI3E0nnHoMrtJQ5cmcMCUsIsoCmxfpc+xCo+id7fT5ggOnklOtqEIKpVJZrfXYXqlJaY2N3N
        CmF7SDTtP8g8gVFxFpLHZiF5bBaSB2YhLFvAyLKKUTK1oDg3PbXYtMAoL7UcHtnJ+bmbGMGp
        V8trB+PDBx/0DjEycTAeYpTgYFYS4V38wTxJiDclsbIqtSg/vqg0J7X4EKMpMLQnMkuJJucD
        k39eSbyhiaWBiZmZmYmlsZmhkjjv6fQNiUIC6YklqdmpqQWpRTB9TBycUg1MRva3q9u4fybf
        lCp72bN1tZ2z7Kd5Zp895y5N4ni681/N0ZxtURPkL8td8Et+HHZ/UlyDYcS3XZKqV6b5zM/j
        f7Qtu0Ku4HSrtEtf058TgkKR7xTX7xCYy2m56OnTwowrCWZF158sSRFU2Cvg6PjsDe/S5Zvc
        tq/81VEw8fNhkd+HJ92taY9qU4jwl9rRvDHIYuVSHce9jZ69EvkFezu6OPbGbjZ8//95qOTt
        5bPepLT75N4+u/9/7h4dy27TwnrhY1eP6mSt2vvnG4d0aI+C4cuzd/6lb3l9SOPny8C1FXIL
        tVvvT/BRfXKfqT+wuCvfNHVd6bQZaw/3qDsfuvLM+vvk3xt6VL7zMq68fjC7VImlOCPRUIu5
        qDgRAKWQDDNGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSvK50mkWSwdNH3BbnHv9msXj58yqb
        xen971gs5h85x2rxctY9NouJ+8+yW1zeNYfNovv6DjaLhyuMLBb8sbNo3XuE3WLz97+MDjwe
        bU0vWT02repk87hzbQ+bx/87a9k9Pm+S82g/0M0UwBbFZZOSmpNZllqkb5fAlTFn0QGmgtk8
        FefeN7I1MM7n6mLk5JAQMJH4s+Q1M4gtJLCDUeLkXHmIuLTE9Y0T2CFsYYmV/54D2VxANc8Z
        JVbv2scCkmAT0JXYsbiNDcQWEQiQOLXtCAtIEbNAJ7PEtI3rWSGmHmaUWLVAC8TmFLCXmNvf
        CbZNWMBXYvIFiEEsAqoSv2Z9BtvGK2ApcfXvTChbUOLkzCdANRxAQ/Uk2jYygoSZBeQltr+d
        wwxxnILEz6fLWCFucJJ4t3kRC0SNuMTLo0fYJzAKz0IyaRbCpFlIJs1C0rGAkWUVo2RqQXFu
        em6xYYFRXmq5XnFibnFpXrpecn7uJkZwDGpp7WDcs+qD3iFGJg7GQ4wSHMxKIryLP5gnCfGm
        JFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cA0v1LzmITT6rle
        LEf0/CPvZXBHcbfali9/Xr3rg/ebM1e2GPFx7U5knxSSzfuswzNx6q5gyUNHLqWc58j948y0
        zX5fgc7z+gW/+R/clk17bTZhtVzTV2Uutb3dSTdWnf5Sy36/tOpb9Pa4a/p63xJkeM2kc47e
        LpyXO3PGrp4/u6V3v9zp+fTTOsttDUu1D8dd1WLMZ7l8Ycph013OK0I/52zX8Nry4vcO/Yda
        cfL2rgaVWTFSVr1vHyrxPGJY25+yIblcZ/7xh18fbGtL5BRgO/9e7+y6WPtLvFZOk/UVfryf
        5VJR/VTpidvjTIX234vSF8Uc3RNeqHNp+tTlEl68s6IDNvZqfv8/O8j587E/SizFGYmGWsxF
        xYkAwgxR7TADAAA=
X-CMS-MailID: 20220321114843epcas5p2d8ed09bcc95965e899ec9bf9f2e538a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220318183030epcas5p46eab9485e0e7d19a249759ef44e29928
References: <20220318183004.858707-1-luca.weiss@fairphone.com>
        <CGME20220318183030epcas5p46eab9485e0e7d19a249759ef44e29928@epcas5p4.samsung.com>
        <20220318183004.858707-2-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
>From: Luca Weiss [mailto:luca.weiss@fairphone.com]
>Sent: Saturday, March 19, 2022 12:00 AM
>To: linux-arm-msm@vger.kernel.org
>Cc: ~postmarketos/upstreaming@lists.sr.ht; phone-devel@vger.kernel.org;
>Luca Weiss <luca.weiss@fairphone.com>; Andy Gross <agross@kernel.org>;
>Bjorn Andersson <bjorn.andersson@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; Avri Altman <avri.altman@wdc.com>; Rob
>Herring <robh+dt@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
>linux-scsi@vger.kernel.org; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: [PATCH 1/6] scsi: ufs: dt-bindings: Add SM6350 compatible string
>
>Document the compatible for the UFS found on SM6350.
>
>Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>---
> Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>index 5b3a2157f7e5..d17db2cdf3c2 100644
>--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>@@ -27,6 +27,7 @@ properties:
>           - qcom,msm8996-ufshc
>           - qcom,msm8998-ufshc
>           - qcom,sdm845-ufshc
>+          - qcom,sm6350-ufshc

You need to update "if:then" below as well, as this SoC is different than
other in the series

>           - qcom,sm8150-ufshc
>           - qcom,sm8250-ufshc
>           - qcom,sm8350-ufshc
>--
>2.35.1


