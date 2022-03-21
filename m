Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B044E2C86
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350428AbiCUPnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350507AbiCUPnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:43:10 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A4177094
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:41:43 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220321154141epoutp01a2f1ba9607fde7f6594792afca74ff03~eb6zJgcvo1140711407epoutp01p
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:41:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220321154141epoutp01a2f1ba9607fde7f6594792afca74ff03~eb6zJgcvo1140711407epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647877301;
        bh=O1HQT/885gkVXT9rzN+2h0d6pOqAcBP4cDszVi8TFxQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=lGrhB2K91eQLqlZS1TIUu29spH3q1kroHpBasOlD4OPra/EX8Ty2cbUjyB1R2Ue8F
         CiNwv70sZF8Fb8x7STwdzmkeRuqr5JVHWUru8o4gbakX5YURl8wMc+owxy1MHpvJPU
         /x65c963baM/MvoacplxKvPpFY47mM29cqDsiF2s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220321154140epcas5p3dbfc222f169b1b101042b407ee25f8f3~eb6x2TEbA1960819608epcas5p3Y;
        Mon, 21 Mar 2022 15:41:40 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KMf3z4D9Fz4x9Pr; Mon, 21 Mar
        2022 15:41:35 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.DA.12523.FAC98326; Tue, 22 Mar 2022 00:41:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220321154135epcas5p233cbad96d408145559a48ca0f5c9b0c8~eb6tKk6ge2171521715epcas5p2a;
        Mon, 21 Mar 2022 15:41:35 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220321154135epsmtrp1f6b47c8ad891baebce0b344d6f205e31~eb6tJo0PT1508015080epsmtrp1l;
        Mon, 21 Mar 2022 15:41:35 +0000 (GMT)
X-AuditID: b6c32a4a-5a1ff700000030eb-45-62389caf62ba
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.E0.03370.EAC98326; Tue, 22 Mar 2022 00:41:34 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220321154133epsmtip218668a6deeef3b4f4288c87e1d36c8fe~eb6rdOCBc3051430514epsmtip2W;
        Mon, 21 Mar 2022 15:41:33 +0000 (GMT)
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
In-Reply-To: <20220321133318.99406-2-luca.weiss@fairphone.com>
Subject: RE: [PATCH v2 1/6] scsi: ufs: dt-bindings: Add SM6350 compatible
 string
Date:   Mon, 21 Mar 2022 21:11:32 +0530
Message-ID: <004e01d83d3a$25313910$6f93ab30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDQr1gGFOqfu4YzJCL3IxFGIQ6RUQJHsVu4AXhMAmeuuxV/cA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmuu76ORZJBk2LFCzOPf7NYvHy51U2
        i9P737FYzD9yjtXi5ax7bBYT959lt7i8aw6bRff1HWwWD1cYWSz4Y2fRuvcIu8Xm738ZHXg8
        2ppesnpsWtXJ5nHn2h42j/931rJ7fN4k59F+oJspgC0q2yYjNTEltUghNS85PyUzL91WyTs4
        3jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6EQlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5x
        ia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnZG18szrAWdfBV7Dr1nb2Bcyt3FyMkh
        IWAise/QbNYuRi4OIYHdjBKrmtcxQzifGCVmTj4E5XxmlJg36Q8TTMvF+d+hWnYxSuw5spUF
        wnnJKPHszFSwKjYBXYkdi9vYQGwRgQCJU9uOgBUxCzQyS2x7f4MFJMEpYCdx4ukTIJuDQ1gg
        SOLyHjYQk0VAVaJ7QiJIBa+ApcT2GW/ZIWxBiZMzn4B1MgvIS2x/O4cZ4iAFiZ9Pl7FCrHKS
        uHztEjNEjbjEy6NH2CFqjnBInHouCWG7SEyfMBeqV1ji1fEtUDVSEi/729hBTpAQyJbo2WUM
        Ea6RWDrvGAuEbS9x4MocsIOZBTQl1u/Sh9jEJ9H7+wkTRCevREebEES1qkTzu6tQndISE7u7
        WSFsD4m3hyawTGBUnIXkr1lI/pqF5P5ZCMsWMLKsYpRMLSjOTU8tNi0wyksth8d2cn7uJkZw
        8tXy2sH48MEHvUOMTByMhxglOJiVRHgXfzBPEuJNSaysSi3Kjy8qzUktPsRoCgzricxSosn5
        wPSfVxJvaGJpYGJmZmZiaWxmqCTOezp9Q6KQQHpiSWp2ampBahFMHxMHp1QD07pX668z7+ZX
        ShEP/+k7IVu4edv1d6Y32KcZ54luUj0qsM/wTmj6bsmZO3LimSfzH9q9cmvGS7Hnn76ypPaI
        h6+5zbiZN4szR0lrj83MhHuinRusljhNTRG1M8xdGDH1Ko+R7VQ3jl+/jm1kyA/cESj8YGUY
        z5sHJfXJlpnPNjg9zb6+/cehBTJ6c06nFsz5tbg+Kfr+ayF2g2vR1cuv5q4M3fX7yesq5eTQ
        6XIKvf4xv54wrBEM/e+1dXIR2/0F+6692vIi6qdA1Dl+vv+hL+ct7rfnYvVQ9j8qs2/Z68c3
        e11CVjeHXfZ5V/7s8s+DoXdWFugxvF9uc2fbP5NdBo80nh0TDzq42qahYrbuvQwlluKMREMt
        5qLiRAAnHvS6RwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSvO76ORZJBv80LM49/s1i8fLnVTaL
        0/vfsVjMP3KO1eLlrHtsFhP3n2W3uLxrDptF9/UdbBYPVxhZLPhjZ9G69wi7xebvfxkdeDza
        ml6yemxa1cnmcefaHjaP/3fWsnt83iTn0X6gmymALYrLJiU1J7MstUjfLoEro+vlGdaCTr6K
        PYfeszcwLuXuYuTkkBAwkbg4/ztrFyMXh5DADkaJw20HGCES0hLXN05gh7CFJVb+e84OUfSc
        UaLnyTtWkASbgK7EjsVtbCC2iECAxKltR1hAipgFOpklpm1cDzX2IKPEhw8nwUZxCthJnHj6
        hAXEFgbqmPV7F3MXIwcHi4CqRPeERJAwr4ClxPYZb9khbEGJkzNByjmAhupJtG0EO45ZQF5i
        +9s5zBDHKUj8fLqMFeIGJ4nL1y4xQ9SIS7w8eoR9AqPwLCSTZiFMmoVk0iwkHQsYWVYxSqYW
        FOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHoJbWDsY9qz7oHWJk4mA8xCjBwawkwrv4g3mS
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzRP7KfvN3e
        KWhkFJs6r+ju1eoEq6lnnr66X/+xJ4D736yG9wxL69z7q/QXZPOnL7kXKpx75YCj5erZjMvj
        Vuimces0nJ7E53h5i02VFU9Tpe9R8WTREzq/d2/SEXjwRXfn2YAQ0ciKF1PL6vuEngeIPDBu
        2PykRSk2ffGtjbsL3i/0KnB9K+T478//P6dncu1/XcqoXnjdy/T39XXLZi3MlxHY/799XUCb
        fsFrz/3nA67mL9NMt3mXUZRZvfxUxNPJT0VleF4fvPE6JUNi4mqLzX4qnremHZf7cN0jQpbp
        3S2ZCbeFiv6IT8l+uvnrM504h5n+V3uOHAuuEJ+deVz83Bm+IOPFGc6/j62p4UpWYinOSDTU
        Yi4qTgQA8Za9QjADAAA=
X-CMS-MailID: 20220321154135epcas5p233cbad96d408145559a48ca0f5c9b0c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321133352epcas5p493c209ac3f6edbb820cbaba1b4265525
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
        <CGME20220321133352epcas5p493c209ac3f6edbb820cbaba1b4265525@epcas5p4.samsung.com>
        <20220321133318.99406-2-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Luca Weiss [mailto:luca.weiss@fairphone.com]
>Sent: Monday, March 21, 2022 7:03 PM
>To: linux-arm-msm@vger.kernel.org
>Cc: ~postmarketos/upstreaming@lists.sr.ht; phone-devel@vger.kernel.org;
>Luca Weiss <luca.weiss@fairphone.com>; Andy Gross <agross@kernel.org>;
>Bjorn Andersson <bjorn.andersson@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; Avri Altman <avri.altman@wdc.com>; Rob
>Herring <robh+dt@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
>linux-scsi@vger.kernel.org; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: [PATCH v2 1/6] scsi: ufs: dt-bindings: Add SM6350 compatible
string
>
>Document the compatible for the UFS found on SM6350.
>
>Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>Changes in v2:
>- add second hunk for clock validation
>
> Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>index 5b3a2157f7e5..dcd32c10205a 100644
>--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>@@ -27,6 +27,7 @@ properties:
>           - qcom,msm8996-ufshc
>           - qcom,msm8998-ufshc
>           - qcom,sdm845-ufshc
>+          - qcom,sm6350-ufshc
>           - qcom,sm8150-ufshc
>           - qcom,sm8250-ufshc
>           - qcom,sm8350-ufshc
>@@ -125,6 +126,7 @@ allOf:
>           contains:
>             enum:
>               - qcom,sdm845-ufshc
>+              - qcom,sm6350-ufshc
>               - qcom,sm8150-ufshc
>     then:
>       properties:
>--
>2.35.1


