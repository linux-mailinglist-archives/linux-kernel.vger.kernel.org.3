Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A284B566A36
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiGELwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiGELwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:52:03 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8141817A8A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:52:02 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220705115158epoutp0182b903caff3ff9cb8f61592d2d63652e~_7KfICVmb0478304783epoutp01Z
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:51:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220705115158epoutp0182b903caff3ff9cb8f61592d2d63652e~_7KfICVmb0478304783epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657021918;
        bh=vDzcBxHWz53bPIHiRMAyr4RNuM3rV3O1YqlY/2IckAk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=aT1r5GjjgdeQ8a0+WOtcfgO1OL/NdtXpU3R4MbRRGS33YfaifBirDXzzIkR/J7gmS
         eZMweBc61NW2R0Prj5P8OWI3jnC7WebWY1zCAJDIkkTPX1vbwTcSXO+FKc3Vg3P7sg
         HBgioUfa+9RwKNe29phQo6gs9aQ2+nvXdHC+F8Nw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220705115157epcas5p46767ccbae9cd82dbfbd8871f5265f721~_7KeiS89u0674006740epcas5p4v;
        Tue,  5 Jul 2022 11:51:57 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Lcgy225cZz4x9Q3; Tue,  5 Jul
        2022 11:51:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.EF.09566.9D524C26; Tue,  5 Jul 2022 20:51:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220705114614epcas5p4f7e418842857247e97ad46c044ad3834~_7FfYcgA30910309103epcas5p4-;
        Tue,  5 Jul 2022 11:46:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220705114614epsmtrp1224774ba873457155bf1305b78a21208~_7FfVk9ov2495724957epsmtrp1w;
        Tue,  5 Jul 2022 11:46:14 +0000 (GMT)
X-AuditID: b6c32a4a-ba3ff7000000255e-df-62c425d9c8a5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.12.08802.68424C26; Tue,  5 Jul 2022 20:46:14 +0900 (KST)
Received: from smithat07 (unknown [107.122.12.13]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220705114611epsmtip1bcc6368fedd74d104da0eb7d307302b1~_7FcWG7Hp0202302023epsmtip1M;
        Tue,  5 Jul 2022 11:46:11 +0000 (GMT)
From:   "Smitha T Murthy" <smitha.t@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>, <stanimir.varbanov@linaro.org>,
        <dillon.minfei@gmail.com>, <david.plowman@raspberrypi.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <andi@etezian.org>, <alim.akhtar@samsung.com>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>
In-Reply-To: <9606459e-7d9f-90af-1c5c-263e8ab1fae1@linaro.org>
Subject: RE: [PATCH 03/20] dt-bindings: media: s5p-mfc: Add mfcv12 variant
Date:   Tue, 5 Jul 2022 17:16:10 +0530
Message-ID: <01e701d89064$d4a2d480$7de87d80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJFyDoizuFNEw0PhIpG3eTqugJ4BwItOjYJAbXw+DECypnN6axfyrZg
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHd997fS0sxbeC48ImI28zmWTU1pXusQi6jOFLJ5GMmCXEBQq8
        AYH+SFvEuSzrQFABN5jiRkFQyi8ZMqjlh+AP2pUhsCkIyJhFqeAQFHV2TJ2MrfWVjf8+55zv
        Ofecc3N4qOAoN5CXrtQxGqU8k8S9sfYfNrweOrHeliRanniJmqpsxynj41mEumF0YpT1dBuX
        Mo+Wo1R9Xw+HqrJd4lAdlpsY1XrbFR0um8So2apmQM0ZruPUuTsusWn6KodyzH9IjXRV4FRR
        SxuHOmWb5FK148MIVWdaQqjqtj+4VN45G5fal29DtvrTTZVNgO6crAH0eM1DlD5jmOTSxrNz
        CG1qPIjT9qtncfp0zed0Xu9fGP2luRHQyznHuHSBbRynnaYgemDRyY31ic/YnMbIUxhNMKNM
        VqWkK1MjyPfjEt5NCJOKxKHicOotMlgpVzARZNT22NDo9EzXBsjg3fLMLJcrVq7VkhsjN2tU
        WTomOE2l1UWQjDolUy1RC7VyhTZLmSpUMrq3xSLRpjCXMDEjraVzEKhriT2/3behemDiFwAv
        HiQksKPQCgqAN09AdAN4t/9nhDUeAnhivB1jDSeAV+qbwErKdHMr6mYB0QVg/0gAK5oF8NSi
        hesO4IQQztuMHHfAj+gFcMrsQN0GSjxC4a0LM3gB4PG8iEhY0pDsTvAlZHBs6SniZox4DV7L
        289xM58Ih0d+70ZZfgH2l81gbkaJV2DHQgXKdhQMn9yq47B+fzjXa3vWhB8RDac6qhFWc8UL
        ljSFsBwFc6ccnlxfON9n5rIcCOe+yvdwKrzhzPVMrIbH9GZPnS2wZ7QCc7ePEhvg910bWfc6
        WDrQjLAt+MBDT2c8cj7srFxhElb/dNFTHsKxhTZOMSANqyYzrJrMsGoaw/+vHQdYIwhg1FpF
        KqMNU29SMtn/fXiySmECzw4kRNYJHFMPhFaA8IAVQB5K+vEbv7YkCfgp8k/2MhpVgiYrk9Fa
        QZhr3SVo4NpklevClLoEsSRcJJFKpZLwN6Vi0p8vGzMlCYhUuY7JYBg1o1nJQ3hegXpEY2oQ
        FTYc9tEXWWQF8+hy/KflezO22fGgWPuOzkf5OVX3FOTOueuHnPdLb0d9K1xj35MdceefGtng
        zN/+h836+pFrMb+oBoca+vrwi15dyqHzIQ7T2hOtGTefWITvLP5KHMUu1xeNSTjjH+Rs9x9w
        SEqHyrq56577Mab/TMBEtvHge/XwbtIX0Uawy8c71yErOfLRZ4MNxUqh/uSBk8WiN2qLR+XT
        hTbN1sRXa3pSdu/cNv18O6b/84Bg6V61ueUxPmxfL7br26IWdixHChPjyo2RrervvEXxL+8b
        MGEx0XUPYnK3xMUo9meNrnEuZlt2XZKev8z3/eZ4EP5xRKH1wotxJKZNk4tDUI1W/i/KBvN8
        qQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZdlhJTrdN5UiSwbJ/+hYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVns
        fQ1UvOnxNVaLh6/CLS7vmsNm0bNhK6vF2iN32S2WXr/IZLFs0x8mi0Vbv7BbtO49wm7R0naE
        yUHcY828NYweO+4uYfS4vuQTs8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n3aD36i8Wjb8sq
        Ro9/TXPZPbqOXGfz+LxJzuPU18/sAXxRXDYpqTmZZalF+nYJXBkbdpxmLFgqUPHs/RHmBsZN
        vF2MnBwSAiYSj9dtZO5i5OIQEtjBKHH/2TtmiISExMrfkxghbGGJlf+es0MUPWWUeLxpDwtI
        gk1AT+LVkcWsIAkRgZOMEv1nWsAcZoFuFonGV61MEC2vGSXuXtgCNJeDg1PATmLiimSQbmEB
        L4mrf34zgdgsAioSt1vbWUFsXgFLiSkfdzND2IISJ2c+AdvGLKAt0fuwlRHClpfY/nYO1KkK
        Ej+fLmOFiItLvDx6hB3EFhFwk3iwfRHTBEbhWUhGzUIyahaSUbOQtC9gZFnFKJlaUJybnlts
        WGCUl1quV5yYW1yal66XnJ+7iRGcSLS0djDuWfVB7xAjEwfjIUYJDmYlEd5Vkw4mCfGmJFZW
        pRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cCU9yM7UPnhFA1PDm/d
        6BMr3y1pqd0kuDjr/r1fJ8+p3tJn45rG32qoce1UWCXP9/M8rrXvY/P+1ceZty5SuqhY5nd/
        4+lJR/O649KKn4iaN+bE/dvE9Tr7SE1qhVWZVdqzN7cZ42YZ/mzonvtgtqy99Of3rsaL17hr
        hrr+LmN16HzW+//+CoaTS13+GF7S99n7l1fctkg7+8Lr8E7T/D89hXU8f7Ji2h5/3X98zeqr
        bq8P/zm3e5p7wiPt26YRhx/4X8n66iBhbnji+efmkqes8Vv1RZ4e7GB1qbnz0Ptx9h/NhYy9
        M5eeuPN99fn/qw54iEtGf7A/senrQSfB0CfPtnx9VKHbyPdjy+HJ14L9lViKMxINtZiLihMB
        CnIE2ZMDAAA=
X-CMS-MailID: 20220705114614epcas5p4f7e418842857247e97ad46c044ad3834
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125558epcas5p228cdf5f665468d3fd065d88a5d0ad157
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125558epcas5p228cdf5f665468d3fd065d88a5d0ad157@epcas5p2.samsung.com>
        <20220517125548.14746-4-smitha.t@samsung.com>
        <9606459e-7d9f-90af-1c5c-263e8ab1fae1@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: Tuesday, May 17, 2022 7:28 PM
> To: Smitha T Murthy <smitha.t@samsung.com>; linux-arm-
> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
> ezequiel@vanguardiasur.com.ar; jernej.skrabec@gmail.com;
> benjamin.gaignard@collabora.com; stanimir.varbanov@linaro.org;
> dillon.minfei@gmail.com; david.plowman@raspberrypi.com;
> mark.rutland@arm.com; robh+dt@kernel.org; krzk+dt@kernel.org;
> andi@etezian.org; alim.akhtar@samsung.com; aswani.reddy@samsung.com;
> pankaj.dubey@samsung.com; linux-fsd@tesla.com
> Subject: Re: [PATCH 03/20] dt-bindings: media: s5p-mfc: Add mfcv12 variant
> 
> On 17/05/2022 14:55, Smitha T Murthy wrote:
> > Adds DT schema for s5p-mfc with a new compatible string for mfcv12
> > variant.
> >
> > Cc: linux-fsd@tesla.com
> > Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> > ---
> >  Documentation/devicetree/bindings/media/s5p-mfc.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.yaml
> > b/Documentation/devicetree/bindings/media/s5p-mfc.yaml
> > index fff7c7e0d575..209da53f3582 100644
> > --- a/Documentation/devicetree/bindings/media/s5p-mfc.yaml
> > +++ b/Documentation/devicetree/bindings/media/s5p-mfc.yaml
> > @@ -21,6 +21,7 @@ properties:
> >        - samsung,mfc-v8                  # Exynos5800
> >        - samsung,exynos5433-mfc          # Exynos5433
> >        - samsung,mfc-v10                 # Exynos7880
> > +      - samsung,mfc-v12                 # Tesla FSD
> 
> No. We moved already to SoC specific comaptibles. You introduced back
> wrong pattern with MFCv10, but it should be rather fixed. Don't go back to
> it...
> 
> Best regards,
> Krzysztof

Sure, I will add SoC based compatible for MFCv12 in the next series.

Regards,
Smitha

