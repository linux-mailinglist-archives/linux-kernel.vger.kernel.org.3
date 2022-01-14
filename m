Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF348E403
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 06:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiANF57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 00:57:59 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:27536 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239119AbiANF56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 00:57:58 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220114055756epoutp0411f79ae30da2e6e0b170256a267bb99c~KDYRahKIV1483514835epoutp04g
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:57:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220114055756epoutp0411f79ae30da2e6e0b170256a267bb99c~KDYRahKIV1483514835epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642139876;
        bh=oXZI/5pHmSIV2rnVkqX/WYgr+6bWc30NCtFRJUIazl0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=OJLNsXR++SlHmzP1kzNzmugZ9JylVbdQMElnPkWSK9If/a23Fk1vJKvG/G+jo9neb
         6c6DemCmvCfMndOH59wifK4RsBzO3bCyHEmDQlliMTpcJc/VP+E4vUfu5vh0y3C01r
         Fcg9rKmq0GSJZ5wUfQh8lfLujJUg5vyWx0KA4Wlk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220114055755epcas2p4b205348d35d4207e815fc4c86e20c304~KDYQ7DEfi0272902729epcas2p4D;
        Fri, 14 Jan 2022 05:57:55 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZrDv6GG1z4x9Pv; Fri, 14 Jan
        2022 05:57:51 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.7E.10014.04011E16; Fri, 14 Jan 2022 14:55:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220114055749epcas2p45a47db370d61851761daf6103c7bcdb9~KDYLWL-dT2225622256epcas2p4S;
        Fri, 14 Jan 2022 05:57:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220114055749epsmtrp1a2efe03d0dd74a6658c6441bbcf0b074~KDYLVKm2H2498824988epsmtrp1d;
        Fri, 14 Jan 2022 05:57:49 +0000 (GMT)
X-AuditID: b6c32a47-489ff7000000271e-53-61e11040422d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.8C.08738.DD011E16; Fri, 14 Jan 2022 14:57:49 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220114055749epsmtip2b88ba33f957f8f72949f589f757f9189~KDYLD_lax3237232372epsmtip2g;
        Fri, 14 Jan 2022 05:57:49 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Andi Shyti'" <andi@etezian.org>,
        "'Mark Brown'" <broonie@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Pratyush Yadav'" <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Cc:     "'Sam Protsenko'" <semen.protsenko@linaro.org>,
        "'Rob Herring'" <robh@kernel.org>
In-Reply-To: <20220112100046.68068-5-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v3 4/4] spi: s3c64xx: allow controller-data to be
 optional
Date:   Fri, 14 Jan 2022 14:57:49 +0900
Message-ID: <00a601d8090b$a92da220$fb88e660$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLMnbI1WsUjdTWr/4z1tM/QIKR8oQM1ZV57AYRzuIOqUwzpEA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmha6DwMNEg/3PzS0W/3jOZDH14RM2
        i/lHzrFabHz7g8li0+NrrBaXd81hs5hxfh+TRePHm+wWd5//YLdo3XuE3eL/nh3sFs/79jE5
        8HjMauhl87i+5BOzx6ZVnWwed67tYfPYvKTe4/iN7UwenzfJBbBHZdtkpCampBYppOYl56dk
        5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAB2qpFCWmFMKFApILC5W0rezKcov
        LUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjO2PO6g7lgMkfF81lnmRsY
        O9i7GDk5JARMJJb9fsbaxcjFISSwg1GiZ9UeJgjnE6PEqbX/2CCcz4wS75YfYYRp2XLlAguI
        LSSwi1Fi8dNoiKIXjBJrfjewgSTYBPQlXnZsA5srItDCLPHiwwSwbmaBcIkd8/+A2ZwC7hJ/
        7r8HmyQsECDx7PgfZhCbRUBVYnHHf7AaXgFLidPH+tghbEGJkzOfsEDMkZfY/nYOM8RFChI/
        ny5jBbFFBJwkvnyGeI5ZQERidmcbM8gREgInOCS+nm5hhWhwkXh+eAkLhC0s8er4FmhoSEm8
        7G9jh2joZpSY9PIuVGIGMABu5kDYxhKznrUDXccBtEFTYv0ufRBTQkBZ4sgtqNv4JDoO/2WH
        CPNKdLQJQTSqSxzYPh1qq6xE95zPrBMYlWYh+WwWks9mIflgFsKuBYwsqxjFUguKc9NTi40K
        jOGxnZyfu4kRnIi13Hcwznj7Qe8QIxMH4yFGCQ5mJRHe/qL7iUK8KYmVValF+fFFpTmpxYcY
        TYFhPZFZSjQ5H5gL8kriDU0sDUzMzAzNjUwNzJXEeb1SNiQKCaQnlqRmp6YWpBbB9DFxcEo1
        MG05LOjNe6rBN5E5lWNPVgEzl8vMsxf2eWnWCr+OCmhg2/GR0XSmzsnKcCc7Fukz/G1+74re
        Ke6qXKXN4XJiyl6Dyoce8XHX3M7+YyxfdLr7v1bDLhWT5TPjuhcGpnaEpLNveHUvetbG+Yy7
        ztzwe5wS7Z3HyLBglnH9M8apN2snubqZOmyLKvqodPFq0Hu1c64ejPdS80w8X+eEPTy07PKx
        A1VHUudtOLf5ivj7i3+O+4aZrU+I/2rstSmlp1yz6kP5z+KtUUdjNzNfXrC1YdIPGZ7nX60L
        nnyZJPr9gtDed74JjPZX630lv/JUTL7nHpZVstHJt2dW9aHnS7JXnjyjon6TP0PrZoOS4AVW
        ayWW4oxEQy3mouJEAFTMdtxNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvO5dgYeJBk8OKlks/vGcyWLqwyds
        FvOPnGO12Pj2B5PFpsfXWC0u75rDZjHj/D4mi8aPN9kt7j7/wW7RuvcIu8X/PTvYLZ737WNy
        4PGY1dDL5nF9ySdmj02rOtk87lzbw+axeUm9x/Eb25k8Pm+SC2CP4rJJSc3JLEst0rdL4MrY
        87qDuWAyR8XzWWeZGxg72LsYOTkkBEwktly5wNLFyMUhJLCDUWLqo6OsEAlZiWfvdkAVCUvc
        bzkCFhcSeMYo8eS8N4jNJqAv8bJjGytIs4hAD7PE5OVbmUASzALhEh+e3YCaeplRYuLnTWDd
        nALuEn/uv2cBsYUF/CTuNGwBi7MIqEos7vjPCGLzClhKnD7Wxw5hC0qcnPmEBWKonsT69XMY
        IWx5ie1v5zBDXKcg8fPpMrA5IgJOEl8+Q7zGLCAiMbuzjXkCo/AsJKNmIRk1C8moWUhaFjCy
        rGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI5KLa0djHtWfdA7xMjEwXiIUYKDWUmE
        t7/ofqIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTKv2
        7zSxsbxzoFEmtWtBuqunyPN454tzjolHnbrywq33mYXBXJs4hfabV8/WfhJ92iU1je/QNnnu
        rGmWLarGzoVMejcfaRtGavt+8/miFqIQ3PPHf0vInPR+nwdHOZ9eTjnLYirFfrW0wi72fdX8
        O8VXq+669EhMm+ufXWj172n65w4d82xbc94PWUaZZjdd0j5GyHVxcZntPHGj3vlwi1rS3+wH
        Ux7ESzVwhSUufbDSh9vde+O03bJfY/9febNWY+NuRs5XqfH7PT+zPT+YayxXyq5ZayI9OVP2
        162O1StN7Z7PnLJ+feKcD/ozjM/ebkvVFDi0YYa699LKDAtX9aX6PEc0C20u3V6p0i6lxFKc
        kWioxVxUnAgAuK2ibDkDAAA=
X-CMS-MailID: 20220114055749epcas2p45a47db370d61851761daf6103c7bcdb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220112100121epcas2p1ba2f59e6fa405e10e9daa80403ec17e2
References: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
        <CGME20220112100121epcas2p1ba2f59e6fa405e10e9daa80403ec17e2@epcas2p1.samsung.com>
        <20220112100046.68068-5-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Sent: Wednesday, January 12, 2022 7:01 PM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Andi Shyti
> <andi@etezian.org>; Mark Brown <broonie@kernel.org>; Rob Herring
> <robh+dt@kernel.org>; Pratyush Yadav <p.yadav@ti.com>; linux-
> spi@vger.kernel.org; linux-samsung-soc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Cc: Sam Protsenko <semen.protsenko@linaro.org>; Rob Herring
> <robh@kernel.org>
> Subject: [PATCH v3 4/4] spi: s3c64xx: allow controller-data to be optional
> 
> The Samsung SoC SPI driver requires to provide controller-data node for
> each of SPI peripheral device nodes.  Make this controller-data node
> optional, so DTS could be simpler.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

