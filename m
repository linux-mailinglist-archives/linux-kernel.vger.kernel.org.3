Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5A349C3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbiAZGw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:52:58 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:57223 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiAZGw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:52:57 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220126065255epoutp02fefc9bb2d690e61a57745dbc17d58767~Nv3tqjJdb1183311833epoutp02T
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:52:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220126065255epoutp02fefc9bb2d690e61a57745dbc17d58767~Nv3tqjJdb1183311833epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643179975;
        bh=QWH/NkJCNfJAFJDonlSrKoCYccE2y7+C5FG9WEPYhi4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rRRR4KlQ/lONF8OnrVgMAax+dFI4y3MM9WS47lCF7xVQ0nxybPo3c4WTqtGD4VTaj
         BWkAtV+n+M9HDc8ElP9JR1ej+/2Tt5c+LbxycB4ClU0YDV72a+GKAcAXZFhtWHTxWI
         IaD6He3vt1CuQyEmekwcuuZxOdOqkrqjHh3zvhoY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220126065255epcas5p4e66efed2ce71e269f3a1d19afaefe123~Nv3tq8VrB2511925119epcas5p45;
        Wed, 26 Jan 2022 06:52:55 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JkDtn4zYDz4x9Q6; Wed, 26 Jan
        2022 06:52:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.6F.06423.1CFE0F16; Wed, 26 Jan 2022 15:52:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220126065249epcas5p1242065fd936bf55c4725d5dbbdd6bbbb~Nv3np7NF00355403554epcas5p1X;
        Wed, 26 Jan 2022 06:52:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220126065249epsmtrp1dc79c7dfd62cd0d766cfba92aa836f7f~Nv3nrQoxR0577805778epsmtrp1X;
        Wed, 26 Jan 2022 06:52:49 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-93-61f0efc1c65f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.F1.08738.1CFE0F16; Wed, 26 Jan 2022 15:52:49 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220126065247epsmtip266ee4668c443e4a770c54ea115c407d6~Nv3lj2Bh00375703757epsmtip2S;
        Wed, 26 Jan 2022 06:52:47 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <sboyd@kernel.org>
In-Reply-To: <d9682f16-13b7-b6dc-5afd-b2d319143de5@canonical.com>
Subject: RE: [PATCH v5 00/16] Add support for Tesla Full Self-Driving (FSD)
 SoC
Date:   Wed, 26 Jan 2022 12:22:44 +0530
Message-ID: <063601d81281$5492d620$fdb88260$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH3x/DHpHRz6vxyIYATeg+eWAbDkwGsWw0jAU7CzZCsHZlzIA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmuu7B9x8SDVo3y1v8nXSM3eL9sh5G
        i/lHzrFabHz7g8liyp/lTBabHl9jtfjYc4/V4vKuOWwWM87vY7I4df0zm8WirV/YLVr3HmG3
        OPymndXi37WNLBaPr/9hc+D3WDNvDaPH71+TGD1mNfSyeWxa1cnmcefaHjaPzUvqPa6caGL1
        6NuyitHj8ya5AM6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmp
        JVaGBgZGpkCFCdkZbc1PWQqeCVU8XXCStYHxGn8XIyeHhICJxNQ5XUxdjFwcQgK7GSVePn3P
        AuF8YpRY0vYAKvOZUeLAhx4WmJaTyw6xQiR2MUo82P6LHcJ5ySjxbckfdpAqNgFdiR2L29hA
        EiICnYwSq7//ZAJJMAtsY5LYPVG7i5GDg1PAEcgEO0RYIFDixqW7rCA2i4CqxOGT08Hm8ApY
        Snz5/pIJwhaUODnzCQvEGG2JZQtfM0NcpCDx8+kysF4RASeJJzPeM0LUiEu8PHoE7DgJgQ8c
        Eg9+/mKFaHCR+LNvK5QtLPHq+BZ2CFtK4mV/GzvIbRIC2RI9u4whwjUSS+cdg/reXuLAlTks
        ICXMApoS63fpQ6zik+j9/YQJopNXoqNNCKJaVaL53VWoTmmJid3drBAlHhLftrNMYFScheSv
        WUj+moXk/lkIuxYwsqxilEwtKM5NTy02LTDMSy2HR3dyfu4mRnDy1vLcwXj3wQe9Q4xMHIyH
        GCU4mJVEeP97v08U4k1JrKxKLcqPLyrNSS0+xGgKDOyJzFKiyfnA/JFXEm9oYmlgYmZmZmJp
        bGaoJM57On1DopBAemJJanZqakFqEUwfEwenVANTwNOeX/MVz+5z2v02WVrrvXqcmsBKo+oV
        bb1TMg+uY5+ra/LfiHvNuTarCKbMn4/S4vaslF244p7d7NwJn+6cm3BhdjZj49voyKwr3ucS
        Y4zyjMw3f21XCW9NdJL3zg6N5dip6Wy4dor8Jgfdo1938yyLf7djY9qexOadabdc2Rd7Jdoz
        7VyrVPbynfbn8seBHhd7di3c4HUnMmu6zZ/4rVMj9f0MpwtyFchNPO3s/1tkm7pY4Z66DP5L
        s0ytmBk6t0YlT7vYW/ja+sYS33XRHzVOP8mNymB5Wehw+XeA49qdy25vn5v9r9HBeqFP6CHm
        n0e331B7vJbpi/MXT8ZrT4LE3v57Lnr7wi93d38xJZbijERDLeai4kQAWHoKo2cEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSvO7B9x8SDZ59kLH4O+kYu8X7ZT2M
        FvOPnGO12Pj2B5PFlD/LmSw2Pb7GavGx5x6rxeVdc9gsZpzfx2Rx6vpnNotFW7+wW7TuPcJu
        cfhNO6vFv2sbWSweX//D5sDvsWbeGkaP378mMXrMauhl89i0qpPN4861PWwem5fUe1w50cTq
        0bdlFaPH501yAZxRXDYpqTmZZalF+nYJXBnPDy5iLtghVHH+1Rb2BsYl/F2MnBwSAiYSJ5cd
        Yu1i5OIQEtjBKDH/61wWiIS0xPWNE9ghbGGJlf+es0MUPWeU+PfnPRtIgk1AV2LH4jY2kISI
        QDejxJWemYwgDrPAESaJn/s3MUO0HGaU2L1kJVAZBwengKPE7olgu4UF/CXWPngPto5FQFXi
        8MnpYOt4BSwlvnx/yQRhC0qcnPkErIZZQFvi6c2ncPayha+ZIc5TkPj5dBkriC0i4CTxZMZ7
        RogacYmXR4+wT2AUnoVk1Cwko2YhGTULScsCRpZVjJKpBcW56bnFhgVGeanlesWJucWleel6
        yfm5mxjBkayltYNxz6oPeocYmTgYDzFKcDArifD+936fKMSbklhZlVqUH19UmpNafIhRmoNF
        SZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPTiY6zPOvP3zHpORMZlfE6Yadg5a3pU94GH5Rz
        2TmnyOP5YdvP/DsWlLiKsDufLd4f+k3m2AkVZo4u5ZB5ptsy103SeDdrwsqpZ2My1JZ9mvq6
        5GFui46H9Kd4ydSPc49oyj56ovmwfr2d6YPNb85dsZN0q5xYdcpwdYD9No+euZW3A2aoOb6N
        sOSRWpkiyvW+prDOYwafeYHNNCuOWtsYk9Wt81lWeNdM2SH+6wGnrKD+o6UlxatKD0oWmeSa
        XlB/Mnv/xXVfbAJ+rum8ds3k8ZJLurIxfNP4blrfUFhUc1W/xFrs5sNj8zueXSv89ybYe++Z
        ufbXskJC7h6ceG/lkiiusw7WOmfvx1xbKbhzqRJLcUaioRZzUXEiAGGEY59TAwAA
X-CMS-MailID: 20220126065249epcas5p1242065fd936bf55c4725d5dbbdd6bbbb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b
References: <CGME20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b@epcas5p2.samsung.com>
        <20220124141644.71052-1-alim.akhtar@samsung.com>
        <d9682f16-13b7-b6dc-5afd-b2d319143de5@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Tuesday, January 25, 2022 10:42 PM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: soc=40kernel.org; linux-clk=40vger.kernel.org; devicetree=40vger.kerne=
l.org;
>olof=40lixom.net; arnd=40arndb.de; linus.walleij=40linaro.org;
>catalin.marinas=40arm.com; robh+dt=40kernel.org; s.nawrocki=40samsung.com;
>linux-samsung-soc=40vger.kernel.org; pankaj.dubey=40samsung.com;
>sboyd=40kernel.org
>Subject: Re: =5BPATCH v5 00/16=5D Add support for Tesla Full Self-Driving =
(FSD) SoC
>
>On 24/01/2022 15:16, Alim Akhtar wrote:
>> Adds basic support for the Tesla Full Self-Driving (FSD) SoC. This SoC
>> contains three clusters of four Cortex-A72 CPUs, as well as several
>> IPs.
>>
>> Patches 1 to 9 provide support for the clock controller (which is
>> designed similarly to Exynos SoCs).
>>
>> The remaining changes provide pinmux support, initial device tree suppor=
t.
>>
>> - Changes since v4
>> * fixed 'make dtbs_check' warnings on patch 14/16
>>
>> - Changes since v3
>> * Addressed Stefen's review comments on patch 14/16
>> * Fixed kernel test robot warning on patch 04/16
>> * rebsaed this series on Krzysztof's pinmux new binding schema work
>> =5B1=5D
>>
>> - Changes since v2
>> * Addressed Krzysztof's and Stephen's review comments
>> * Added Reviewed-by and Acked-by tags
>> * Rebased on next-20220120
>>
>> - Changes since v1
>> * fixed make dt_binding_check error as pointed by Rob
>> * Addressed Krzysztof's and Rob's review comments
>> * Added Reviewed-by and Acked-by tags
>> * Dropped SPI, MCT and ADC from this series (to be posted in small
>> sets)
>>
>> NOTE: These patches are based on Krzysztof's pinmux for-next branch
>> commit 832ae134ccc1 (=22pinctrl: samsung: add support for Exynos850 and
>> ExynosAutov9 wake-ups=22) =5B1=5D
>> https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git/lo
>> g/?h=3Dfor-next
>>
>>
>
>Thanks, applied DTS/soc and pinctrl patches.
>
Thanks Krzysztof

>I expect Sylwester will pick up the clock ones. Otherwise please let me kn=
ow
>to pick it up as well.
>
Hi Sylwester, hope you will be taking clock changes, or let Krzysztof know =
otherwise.
Thanks

>
>Best regards,
>Krzysztof

