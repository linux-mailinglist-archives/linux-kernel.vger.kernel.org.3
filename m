Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E658B49859E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244049AbiAXRBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:01:15 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:43865 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243970AbiAXRBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:01:13 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220124170110epoutp013ec38e27b0807269d9b434890609c31f~NQ4NFrQWJ1311613116epoutp013
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:01:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220124170110epoutp013ec38e27b0807269d9b434890609c31f~NQ4NFrQWJ1311613116epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643043670;
        bh=83VTFefNOOVIvD1TeUCpJROFSX+M5uWagKuPIDdCXIY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=QATqPK6lRANb3ZjC9t2p+W2KwZDZSwX2i2mM/CgRQBmVeJ6l4nFvCHd53HEOvsvyL
         h4fX86YhyopBg9rf4fJbyS2g452UGYD3ObrsZyz0r4UoICM3lR872rOLptoJ6jMQ8T
         P9jXBfFb6pjPcGe58w+clAAWOLObRBd43vAzHSYI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220124170108epcas5p4d637040355668959fb1daa10aaae4a17~NQ4L-Ptsb2304923049epcas5p44;
        Mon, 24 Jan 2022 17:01:08 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JjGTR1zMPz4x9Pv; Mon, 24 Jan
        2022 17:00:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.38.46822.9E9DEE16; Tue, 25 Jan 2022 01:55:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220124170058epcas5p4cba1540f63abdf832a74f690ad76f28a~NQ4CXbHSs2304923049epcas5p4v;
        Mon, 24 Jan 2022 17:00:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220124170058epsmtrp1df9335a206cbfd912786e0ae95434d0e~NQ4CWinAW2043120431epsmtrp18;
        Mon, 24 Jan 2022 17:00:58 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-aa-61eed9e97d13
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.00.08738.A4BDEE16; Tue, 25 Jan 2022 02:00:58 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220124170056epsmtip250cb478e3013d73c6c775011103dcdbf~NQ4APwByP1523815238epsmtip2X;
        Mon, 24 Jan 2022 17:00:56 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Andi Shyti'" <andi@etezian.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        "'Aswani Reddy'" <aswani.reddy@samsung.com>, <linux-fsd@tesla.com>
In-Reply-To: <YevfmeGwmwLml+6b@jack.zhora.eu>
Subject: RE: [PATCH v2 3/3] arm64: dts: fsd: Add SPI device nodes
Date:   Mon, 24 Jan 2022 22:30:54 +0530
Message-ID: <048801d81143$f5585ec0$e0091c40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIlRa7NAXyP9WKiX5aeFVThmKbe4gH4FQMDAd/j86ICC5i7Zquo37lA
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmlu7Lm+8SDa7fl7JY/OM5k8WhzVvZ
        LaY+fMJmMf/IOVaLjW9/MFlM+bOcyWLT42usFg9fhVtc3jWHzWLG+X1MFo0fb7JbLNr6hd2i
        de8Rdgdej1kNvWwe15d8YvbYtKqTzePOtT1sHpuX1Hv0bVnF6PGvaS67x+dNcgEcUdk2GamJ
        KalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAXKymUJeaUAoUC
        EouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyMx7/X8BW
        8IGn4sexV0wNjC3cXYycHBICJhJfLyxi7mLk4hAS2M0osffPPHYI5xOjxM2ti6Eynxkl/n9c
        wgjTsnDtFzaIxC5GiWtrnzFBOC8ZJV7OWc8KUsUmoCuxY3EbG4gtIqAqsfTxTLAOZoFGZomW
        3lvMIAlOoKKDqxYwgdjCAo4Sa9YuY+li5OBgAWpYecIDJMwrYCkx7dxrZghbUOLkzCcsIDaz
        gLzE9rdzmCEuUpD4+XQZK8QuN4nDx26xQtSIS7w8egTsHwmBGxwSm+aAvMAB5LhIbN9QBNEr
        LPHq+BZ2CFtK4mV/GztESbZEzy5jiHCNxNJ5x1ggbHuJA1fmgF3JLKApsX6XPsQmPone30+Y
        IDp5JTrahCCqVSWa312F6pSWmNjdzQphe0j8ujKJeQKj4iwkf81C8tcsJPfPQli2gJFlFaNk
        akFxbnpqsWmBUV5qOTy6k/NzNzGCk7OW1w7Ghw8+6B1iZOJgPMQowcGsJMJblfIuUYg3JbGy
        KrUoP76oNCe1+BCjKTCsJzJLiSbnA/NDXkm8oYmlgYmZmZmJpbGZoZI47+n0DYlCAumJJanZ
        qakFqUUwfUwcnFINTD6TlaufevXuUjlUJBCYOfPLpcXyPfZ3mFq5lj6dyu+6QWxu+jItgY3a
        ev8rmm5xRj+fInmFdfHOCdZLrohO9eorrZumveB081+B8M3/jGR+/10hwXGmZZVfe49l/NEz
        MXxa3dE5c4+IqB3PmaV5P65h0p/Wl6LPT81sjYu6s+JW94+FNYaHqwScQmesyJ3Y8ClOrjjK
        eP+Wnb6Fy5c+vGwkuunkfB696oKiwLijSgdunk7gcc+Yfvz3zy2VrnOULwuXhHwNntF1ZOvp
        c44Pmo49d+jeXO9RzK9xr6r0yq3EZwe3ObE1cJ8/9+XEfJvZjlxu+XzvdK2XaFvG1x/3ZAy7
        USR/isVwa+5lCe9ly5RYijMSDbWYi4oTASToz6RXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWy7bCSvK7X7XeJBhcWy1ss/vGcyeLQ5q3s
        FlMfPmGzmH/kHKvFxrc/mCym/FnOZLHp8TVWi4evwi0u75rDZjHj/D4mi8aPN9ktFm39wm7R
        uvcIuwOvx6yGXjaP60s+MXtsWtXJ5nHn2h42j81L6j36tqxi9PjXNJfd4/MmuQCOKC6blNSc
        zLLUIn27BK6Mx/8XsBV84Kn4cewVUwNjC3cXIyeHhICJxMK1X9i6GLk4hAR2MEocazvOCpGQ
        lri+cQI7hC0ssfLfc3aIoueMEjOO3GcGSbAJ6ErsWNzGBmKLCKhKLH08E2wSs0Avs8SENztY
        IToeMEp0/pgBNooTqOPgqgVMILawgKPEmrXLWLoYOThYgLpXnvAACfMKWEpMO/eaGcIWlDg5
        8wlYCbOAnkTbRkaQMLOAvMT2t3OYIY5TkPj5dBkrxA1uEoeP3WKFqBGXeHn0CPsERuFZSCbN
        Qpg0C8mkWUg6FjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI5RLa0djHtWfdA7
        xMjEwXiIUYKDWUmEtyrlXaIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1ML
        UotgskwcnFINTNNVMiKXFLSKRFixTVw0911wrqXl1OLTDHtjPF/FVWyoElf2ubo9+RbbK+6s
        hAMvpt7g2+Psmf3wtm5dw8NneicCjG/MeFTAFjvPc95UD1epMP4H+lMZvLq6E7cFBTZ9C1L1
        +6n6b+NyyxXes/53a2qqv50Y+D79dcTf1N+VN0zLrcX3qvCdEGBnO7RY4udcXknRYxKRjxji
        Hv8x9GjktLhSfMbsfKLv129/sqqWiByYOU/21TqOf9dEyo24OC3nFE9K1n3JXLNl9z8t/XKP
        5l/ajSUxZXsCjr26HmStX3f31krFQ9rHtFmyX7UE9+5zZFt2ZEL+pV8u6z+aR8wNvZC1T0wp
        3nN9Ro+FB2+3EktxRqKhFnNRcSIAqAil20ADAAA=
X-CMS-MailID: 20220124170058epcas5p4cba1540f63abdf832a74f690ad76f28a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220120193622epcas5p3a65c8424c6a01aed9a87f5ac2a89eb06
References: <20220120192438.25555-1-alim.akhtar@samsung.com>
        <CGME20220120193622epcas5p3a65c8424c6a01aed9a87f5ac2a89eb06@epcas5p3.samsung.com>
        <20220120192438.25555-4-alim.akhtar@samsung.com>
        <YevfmeGwmwLml+6b@jack.zhora.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andi for review

>-----Original Message-----
>From: Andi Shyti [mailto:andi@etezian.org]
>Sent: Saturday, January 22, 2022 4:13 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>
>Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>devicetree@vger.kernel.org; linus.walleij@linaro.org; robh+dt@kernel.org;
>krzysztof.kozlowski@canonical.com; linux-samsung-soc@vger.kernel.org;
>pankaj.dubey@samsung.com; broonie@kernel.org; andi@etezian.org; linux-
>spi@vger.kernel.org; Aswani Reddy <aswani.reddy@samsung.com>; linux-
>fsd@tesla.com
>Subject: Re: [PATCH v2 3/3] arm64: dts: fsd: Add SPI device nodes
>
>Hi Alim and Aswani,
>
>On Fri, Jan 21, 2022 at 12:54:38AM +0530, Alim Akhtar wrote:
>> From: Aswani Reddy <aswani.reddy@samsung.com>
>>
>> Adds device tree node for SPI IPs
>>
>> Cc: linux-fsd@tesla.com
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>
>Reviewed-by: Andi Shyti <andi@etezian.org>
>
>Please, also allow me another nit-commnent for the next patches:
>the tag section is in chronological order. I suppose that first Aswani
wrote the
>patch, then you sent it to the mailing list and at the end Krzysztof has
>reviewed it, this means that the right order is:
>
>  Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
>  Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>  Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
Sure, will update it in the next version of the patch set.

>Thank you,
>Andi

