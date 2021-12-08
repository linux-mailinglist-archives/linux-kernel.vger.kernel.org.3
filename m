Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AC046CFE4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhLHJTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:19:39 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:64518 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhLHJTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:19:37 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211208091604epoutp0136a4c40f6ab35ba8abf47ab6798112b8~_vNtCl_aj3208032080epoutp01q
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 09:16:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211208091604epoutp0136a4c40f6ab35ba8abf47ab6798112b8~_vNtCl_aj3208032080epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1638954964;
        bh=L3mEF7+6yV+KF0WYa6qMuoeggjqB5AvGNo4NWjRpFMQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=gMNmrp6UOk+SQXtCY0n9wimcjXHatJwOCj73wRnxrjmp2csqCcF8nACSQvFRMusN3
         u6xThc75Ds/ALEu0XYVBdXNE4z2860oLzoQAtdiMyyEF1XNY8rW8lIGUttfrGDJQP/
         X64WOuJIWYgHXrjDXW9IGloQNK5vJeKPY77QRUWk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20211208091603epcas2p25370c4945595a153b1786cf9691dc65b~_vNsCsIW-1489114891epcas2p2R;
        Wed,  8 Dec 2021 09:16:03 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.102]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4J8BNb1WpHz4x9Pp; Wed,  8 Dec
        2021 09:15:59 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.07.12141.EC770B16; Wed,  8 Dec 2021 18:15:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20211208091557epcas2p244a77e72c91615b34d8858b22028f8cc~_vNnCbska3164431644epcas2p2B;
        Wed,  8 Dec 2021 09:15:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211208091557epsmtrp2749423c11ba8806113bdd048b9797bef~_vNnBkzoA1588515885epsmtrp22;
        Wed,  8 Dec 2021 09:15:57 +0000 (GMT)
X-AuditID: b6c32a48-d73ff70000002f6d-8a-61b077ce47d3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.31.29871.DC770B16; Wed,  8 Dec 2021 18:15:57 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20211208091557epsmtip1e53e5639ade92d055329c00af3879eb5~_vNm1ti9o0050600506epsmtip18;
        Wed,  8 Dec 2021 09:15:57 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Sam Protsenko'" <semen.protsenko@linaro.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Jaewon Kim'" <jaewon02.kim@samsung.com>,
        "'David Virag'" <virag.david003@gmail.com>,
        "'Youngmin Nam'" <youngmin.nam@samsung.com>,
        <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20211204195757.8600-1-semen.protsenko@linaro.org>
Subject: RE: [PATCH v3 0/5] soc: samsung: Add USI driver
Date:   Wed, 8 Dec 2021 18:15:57 +0900
Message-ID: <02b301d7ec14$35d65920$a1830b60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHvNr3EVTo+lBGPAlUO2Lnnk5XtrwJqUxbhq+Zn1cA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmue658g2JBtNnSFjMP3KO1aJ58Xo2
        ix0NR1gtNr79wWSx6fE1VovLu+awWcw4v4/J4sziXnaL1r1H2C2e9wG5x98/ZrRYfOATuwOP
        x6yGXjaPnbPusntsWtXJ5nHn2h42j/1z17B7bF5S79G3ZRWjx+dNcgEcUdk2GamJKalFCql5
        yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDXKimUJeaUAoUCEouLlfTt
        bIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyMxY8nsFYcE++Yv+c
        o2wNjBsluxg5OSQETCTevbzC0sXIxSEksINR4svpKVDOJ0aJ2/svMEE43xglWuZeZ4JpufGk
        gRkisReo6n8/G4TzglHi7o+NLCBVbAL6Ei87trGC2CIC5xglDi50AyliFtjJJPH1/HY2kASn
        gL3ElaU/mUFsYQELiXnN08FsFgEViS2rp4IN4hWwlPixpZMJwhaUODnzCVicWUBeYvvbOcwQ
        JylI/Hy6DGgZB9AyK4nDx40hSkQkZne2QZVc4ZBo7LMCKZEQcJFY/tsbIiws8er4FnYIW0ri
        87u9YL9ICHQzSrQ++g+VWM0o0dnoA2HbS/yavgVsFbOApsT6XfoQI5UljtyCOoxPouPwX3aI
        MK9ER5sQRKO6xIHt01kgbFmJ7jmfWScwKs1C8tYsJG/NQnL/LIRdCxhZVjGKpRYU56anFhsV
        mMDjOjk/dxMjOB1reexgnP32g94hRiYOxkOMEhzMSiK8ag/XJgrxpiRWVqUW5ccXleakFh9i
        NAUG9ERmKdHkfGBGyCuJNzSxNDAxMzM0NzI1MFcS5/VK2ZAoJJCeWJKanZpakFoE08fEwSnV
        wLRgA4eymHblhAcBrs1Tvnz/0BBxdUu1C+8KGTtNmQfeeuvWX0ufOt949rSKGq+g1UdVXTmF
        X80M3HgtKunJZR/vT3wRvgFCb6R79nRW+b0uMnfnE6kV3x/mxbJk7hvhK6KN31Q/XEkR499z
        7kaf1rWdOhwetTZ+Oqvqjx3eZ84g1x4mYDxxe7QYW2V39nx+25mqmbvfvbtpPSPHa57uZJOL
        OySedX69O7/Ii6exK11UtEZy1sTNQfdyNzGtv/a05WdA/XSD1XLn/uiXSFl++nTiy2QHfsnr
        WRFWE7aVH39k/beqJzGTT9ZQL3/pnANKTQzhEQmtpYUW0g66gjy7wgqWiN4XUXd4JJZZzGej
        xFKckWioxVxUnAgADQVpq1AEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSnO7Z8g2JBpt7DC3mHznHatG8eD2b
        xY6GI6wWG9/+YLLY9Pgaq8XlXXPYLGac38dkcWZxL7tF694j7BbP+4Dc4+8fM1osPvCJ3YHH
        Y1ZDL5vHzll32T02repk87hzbQ+bx/65a9g9Ni+p9+jbsorR4/MmuQCOKC6blNSczLLUIn27
        BK6MBY9nMBbck6/YP+coWwPjRskuRk4OCQETiRtPGpi7GLk4hAR2M0pc2XKQCSIhK/Hs3Q52
        CFtY4n7LEVaIomeMEi0n14Ml2AT0JV52bANLiAhcYJR4d3EaG4jDLLCfSeJi6yOouRMYJR6v
        vsMI0sIpYC9xZelPZhBbWMBCYl7zdDCbRUBFYsvqqSwgNq+ApcSPLZ1MELagxMmZT4DiHEBT
        9STaNoKNYRaQl9j+dg4zxHkKEj+fLmMFKRERsJI4fNwYokREYnZnG/MERuFZSAbNQhg0C8mg
        WUg6FjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI5OLc0djNtXfdA7xMjEwXiI
        UYKDWUmEV+3h2kQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4
        OKUamOzPqK6Zy9Y116MxPmvpifPmzjtKTsS/3hvasoP57ursmYcmbv9R0rS9rHNK6fdD5QsV
        T8aVq/8TviAbeHPhwo9z2bVFNRd8yv3/QdnvCRfnwjktHPddm26s2hcRW3L08ZYTZ9uSpxbb
        pK7NCv3Mvt7UZOFqx4BL8upMF0X2Sah+8VuwLW33jcXpuaXPL07gDDf7Pf2t+KeMm/t3tZ3g
        VBY4JenS/2/S00aB41c3vHJYmNrRdflmSMUfcekz9+pONXYsNgn99f5vV6Dh1NnCLLPnMagX
        vbrxruaYSFih65aZGvq6UyUlb8/OS+B/+TAjdYmk2/e30uKfzkyaL8bRu++M2T57iXVHRK3a
        22xyrbSUWIozEg21mIuKEwHa5hqqPQMAAA==
X-CMS-MailID: 20211208091557epcas2p244a77e72c91615b34d8858b22028f8cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211204195806epcas2p15410815b695603ef2429fc55730ddb21
References: <CGME20211204195806epcas2p15410815b695603ef2429fc55730ddb21@epcas2p1.samsung.com>
        <20211204195757.8600-1-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Sam Protsenko <semen.protsenko@linaro.org>
> Sent: Sunday, December 5, 2021 4:58 AM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Rob Herring
> <robh+dt@kernel.org>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jaewon Kim <jaewon02.kim@samsung.com>; Chanho Park
> <chanho61.park@samsung.com>; David Virag <virag.david003@gmail.com>;
> Youngmin Nam <youngmin.nam@samsung.com>; devicetree@vger.kernel.org;
> linux-serial@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org
> Subject: [PATCH v3 0/5] soc: samsung: Add USI driver
> 
> USIv2 IP-core provides selectable serial protocol (UART, SPI or High-Speed
> I2C); only one can be chosen at a time. This series implements USIv2
> driver, which allows one to select particular USI function in device tree,
> and also performs USI block initialization.
> 
> With that driver implemented, it's not needed to do USI initialization in
> protocol drivers anymore, so that code is removed from the serial driver.
> 
> Because USI driver is tristate (can be built as a module), serial driver
> was reworked so it's possible to use its console part as a module too.
> This way we can load serial driver module from user space and still have
> serial console functional.
> 
> Design features:
>   - "reg" property contains USI registers start address (0xc0 offset);
>     it's used in the driver to access USI_CON and USI_OPTION registers.
>     This way all USI initialization (reset, HWACG, etc) can be done in
>     USIv2 driver separately, rather than duplicating that code over
>     UART/SPI/I2C drivers
>   - System Register (system controller node) and its SW_CONF register
>     offset are provided in "samsung,sysreg" property; it's used to
>     select USI function (protocol to be used)
>   - USI function is specified in "samsung,mode" property; integer value
>     is used to simplify parsing
>   - there is "samsung,clkreq-on" bool property, which makes driver
>     disable HWACG control (needed for UART to work properly)
>   - PCLK and IPCLK clocks are both provided to USI node; apparently both
>     need to be enabled to access USI registers
>   - protocol nodes are embedded (as a child nodes) in USI node; it
>     allows correct init order, and reflects HW properly
>   - USI driver is a tristate: can be also useful from Android GKI
>     requirements point of view
>   - driver functions are implemented with further development in mind:
>     - we might want to add some DebugFs interface later
>     - some functions might need to be revealed to serial drivers with
>       EXPORT_SYMBOL(), and provide somehow pointer to needed USI driver
>       instance
>     - another USI revisions could be added (like USIv1)
> 
> Changes in v3:
>   - Renamed compatible from samsung,exynos-usi-v2 to samsung,exynos850-usi
>   - Used clk_bulk API instead of handling each clock separately
>   - Spell check fixes and coding style fixes
>   - Improved dt-bindings doc
> 
> Changes in v2:
>   - Renamed all 'usi_v2' wording to just 'usi' everywhere
>   - Removed patches adding dependency on EXYNOS_USI for UART/I2C/SPI
>     drivers
>   - Added patch: "tty: serial: samsung: Fix console registration from
>     module"
>   - Combined dt-bindings doc and dt-bindings header patches
>   - Reworked USI driver to be ready for USIv1 addition
>   - Improved dt-bindings
>   - Added USI_V2_NONE mode value
> 
> Sam Protsenko (5):
>   dt-bindings: soc: samsung: Add Exynos USI bindings
>   soc: samsung: Add USI driver
>   tty: serial: samsung: Remove USI initialization
>   tty: serial: samsung: Enable console as module
>   tty: serial: samsung: Fix console registration from module

Tested-by: Chanho Park <chanho61.park@samsung.com> with below patch.
https://lore.kernel.org/linux-samsung-soc/20211208003946.139423-1-chanho61.p
ark@samsung.com/T/#u

Thanks.

Best Regards,
Chanho Park

