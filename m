Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BCD4901C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiAQFue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:50:34 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:48953 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiAQFud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:50:33 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220117055027epoutp032409e37ea8aad193bc7844e85386987b~K_NmMOQ4A0524905249epoutp03Z
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 05:50:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220117055027epoutp032409e37ea8aad193bc7844e85386987b~K_NmMOQ4A0524905249epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642398627;
        bh=OzJYV5gOP+WABFx6a1RfmNLwW2IYIAyFhAR0Zif3KlM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=R9QC48MJo9BgdzGgRsxK9zjn0PofnCxyfiRNza/Ue373idl07A5pyPYPTtTHvPati
         sAaVOmLwE2B0YOZp8xoPs5plLs6jJOB2tiUn3NzWwCJ4HHka9oZWkVZVNbPFtkYA5V
         I1vYMeECFObmAMmwlEennYmXWAK+diaNoGrOyYio=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220117055026epcas5p32976903e6cdac57468435fbd12bd3ca5~K_NloiCsU2704227042epcas5p3K;
        Mon, 17 Jan 2022 05:50:26 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jcgwm5tQWz4x9Qb; Mon, 17 Jan
        2022 05:50:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.4B.46822.87305E16; Mon, 17 Jan 2022 14:49:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220117055014epcas5p11103f5a411f695664ebf05134dc23531~K_NaMgjH01465614656epcas5p1w;
        Mon, 17 Jan 2022 05:50:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220117055014epsmtrp2dd4492e1e00c3bbcbc8c34d632177faa~K_NaLm3w21339913399epsmtrp2g;
        Mon, 17 Jan 2022 05:50:14 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-00-61e503783bc3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.55.08738.69305E16; Mon, 17 Jan 2022 14:50:14 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220117055010epsmtip2f9ae8aeec2c5743db7b44ec2b4ddb3d4~K_NWmo92k2333123331epsmtip2j;
        Mon, 17 Jan 2022 05:50:09 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Henrik Grimler'" <henrik@grimler.se>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>
Cc:     <semen.protsenko@linaro.org>, <virag.david003@gmail.com>,
        <martin.juecker@gmail.com>, <cw00.choi@samsung.com>,
        <m.szyprowski@samsung.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
In-Reply-To: <YeSHNCywXhp8gHC7@L14.lan>
Subject: RE: [PATCH v3 3/3] ARM: dts: Add support for Samsung Chagall WiFi
Date:   Mon, 17 Jan 2022 11:20:08 +0530
Message-ID: <001301d80b66$190901a0$4b1b04e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKTrlzLhJbN5e22s0Ks3rGJhMIi0gCNReXFAo1zs98Cp4BzmQGZbeD4qrSO3zA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmhm4F89NEgzurJC2uf3nOajH/yDlW
        i7dLdjFabHz7g8li0+NrrBaXd81hs5hxfh+Txdojd9ktzvybymLRuvcIu8XzPqDY8fePGS02
        f//L6MDrMauhl81j56y77B5Hr9xj9di0qpPN4861PWwem5fUe/y/s5bdo2/LKkaPz5vkAjij
        sm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgO5WUihL
        zCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRn
        7F50j7mgRbhi3YtlzA2M1/m7GDk5JARMJPY++8PWxcjFISSwm1FiyqFNrBDOJ0aJuzu3skM4
        nxklFnxaxATTMvHGcWaIxC5Gia7Hs6BaXjJKHJmxjhWkik1AV2LH4jY2EFtEIFPi+asesA5m
        gYdMErd+dYGN4hRQl/iydzUziC0s4CXx8+5vsGYWAVWJvi8/2UFsXgFLiVt/LrFC2IISJ2c+
        YQGxmQXkJba/ncMMcZKCxM+ny1ghlvlJnPo+lwmiRlzi5dEjYD9ICDzgkFh55TcLRIOLxM7b
        H6BsYYlXx7ewQ9hSEp/f7QW6mgPIzpbo2WUMEa6RWDrvGFS5vcSBK3NYQEqYBTQl1u/Sh1jF
        J9H7+wkTRCevREebEES1qkTzu6tQndISE7u7WSFsD4mXLTtZJjAqzkLy2Cwkj81C8sAshGUL
        GFlWMUqmFhTnpqcWmxYY5aWWwyM8OT93EyM4WWt57WB8+OCD3iFGJg7GQ4wSHMxKIrzHuJ8k
        CvGmJFZWpRblxxeV5qQWH2I0BYb2RGYp0eR8YL7IK4k3NLE0MDEzMzOxNDYzVBLnPZ2+IVFI
        ID2xJDU7NbUgtQimj4mDU6qBKS9rI4sCU7dVw36hmQk7W8JWGP5zrHp8S+x0bvfR7Pdiqpy3
        Xyyd8M/B9l7sNgWHItPn4vaLpH7fLC3wncyiNuEUu4zotKtHq6YqZOtvUlE5+H6j4Dr/+LXz
        8t0f/H70pFMxsvHNhIpZq9gOR0Wdrzk69a/ylFUdC4SKZprPDLhps6f4lsL1WO6u5zNLNBSa
        58guNXGZHCG2WOPxjlsuzRVGeQFHTf3fOzx+9ENc1eaqTt6c2KUTtvjbbY6f4Sux3LBdePu5
        Wdvsv/++2H3n/pLgeYviY3lL9ayCYpZv0jJbbrV0//QNyT+uKRS35sW90Kt5v1XN8cbEvT4n
        Wnae1zN79+MSf/tvES7Hj1elI5VYijMSDbWYi4oTAVkJ4DZfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSvO405qeJBiuviltc//Kc1WL+kXOs
        Fm+X7GK02Pj2B5PFpsfXWC0u75rDZjHj/D4mi7VH7rJbnPk3lcWide8RdovnfUCx4+8fM1ps
        /v6X0YHXY1ZDL5vHzll32T2OXrnH6rFpVSebx51re9g8Ni+p9/h/Zy27R9+WVYwenzfJBXBG
        cdmkpOZklqUW6dslcGXsXnSPuaBFuGLdi2XMDYzX+bsYOTkkBEwkJt44ztzFyMUhJLCDUWLr
        lz8sEAlpiesbJ7BD2MISK/89Z4coes4oceLfTEaQBJuArsSOxW1sILaIQKbE9bntrCA2s8Br
        Jok3jX4QDa1MEk+WHGACSXAKqEt82buaGcQWFvCS+Hn3N1gDi4CqRN+Xn2DbeAUsJW79ucQK
        YQtKnJz5BOgiDqChehJtGxkh5stLbH87hxniOAWJn0+XsULc4Cdx6vtcJogacYmXR4+wT2AU
        noVk0iyESbOQTJqFpGMBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgeNXS2sG4
        Z9UHvUOMTByMhxglOJiVRHiPcT9JFOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJ
        anZqakFqEUyWiYNTqoFJb6ZRvdU25lXxnXb3J9ZNFlq56rfKB+ejuRqlUXs+1FxofVymsizI
        ryTgOctTV48Ai+x/S1bWq8zdu4XB4NiV/TdMgpgZJi552tjrOSWq8AzPpj+HZz9rjon69elw
        zJHo7WXCIVGCxRmKOey9H1n27rp5/qx5o9ukFcdnCR3miIpcoJ2bsGvfr8SN9fPOOH88uG9W
        2SnP8C0tFko8Bi8Wltlt9o4XTjwWrHryRQfjdQ4ZngcTPLfopa+d+NUv95DY95SeNvbNy3j3
        McUV5tjLqBmFudW//nLZNHvGBkFGmzfPf07zlX2hmJnQOSNIT5OjeUZflah+fut5uZNhgQHv
        Z03b6JwslvNenyN1er0SS3FGoqEWc1FxIgDtCF7/RgMAAA==
X-CMS-MailID: 20220117055014epcas5p11103f5a411f695664ebf05134dc23531
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220116205940epcas5p3dbab01fb6bb7a4af76169231e6d94469
References: <20220116165035.437274-1-henrik@grimler.se>
        <20220116165035.437274-4-henrik@grimler.se>
        <ca8c4613-a058-6cde-f9e6-8530f142a821@canonical.com>
        <CGME20220116205940epcas5p3dbab01fb6bb7a4af76169231e6d94469@epcas5p3.samsung.com>
        <YeSHNCywXhp8gHC7@L14.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henrik,

>-----Original Message-----
>From: Henrik Grimler [mailto:henrik@grimler.se]
>Sent: Monday, January 17, 2022 2:30 AM
>To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>Cc: semen.protsenko@linaro.org; virag.david003@gmail.com;
>martin.juecker@gmail.com; cw00.choi@samsung.com;
>m.szyprowski@samsung.com; alim.akhtar@samsung.com;
>robh+dt@kernel.org; devicetree@vger.kernel.org; linux-samsung-
>soc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>kernel@vger.kernel.org; ~postmarketos/upstreaming@lists.sr.ht
>Subject: Re: [PATCH v3 3/3] ARM: dts: Add support for Samsung Chagall WiFi
>
>Hi Krzysztof,
>
>> > +/* External sdcard */
>> > +&mmc_2 {
>> > +	status = "okay";
>> > +	bus-width = <4>;
>> > +	cap-sd-highspeed;
>> > +	card-detect-delay = <200>;
>> > +	pinctrl-0 = <&sd2_clk &sd2_cmd &mmc2_cd &sd2_bus1 &sd2_bus4>;
>> > +	pinctrl-names = "default";
>> > +	samsung,dw-mshc-ciu-div = <3>;
>> > +	samsung,dw-mshc-ddr-timing = <0 2>;
>> > +	samsung,dw-mshc-sdr-timing = <0 4>;
>> > +	sd-uhs-sdr50;
>> > +	vmmc-supply = <&ldo19_reg>;
>> > +	vqmmc-supply = <&ldo13_reg>;
>> > +};
>> > +
>> > +&pinctrl_0 {
>> > +	mmc2_cd: sd2-cd-pins {
>> > +		samsung,pins = "gpx2-4";
>>
>> Interesting... I looked at vendor sources to board-chagall and
>> standard pin gpc2-2 is mentioned as PULL down and not-connected
>comment.
>>
>> gpx2-4 seems not mentioned at all, unless other board files are
>> actually used.
>
>Gpio seems to be spread out. GPIO_T_FLASH_DETECT is defined as gpx2-4 in
>board-universal5420-mmc.c, and then used for card detection.
>(Looking at it now again I see that write protection through sd2_wp should
>also be supported for mmc_2, can add that in next patch set.)
>
Card detect pin is generally a special function (dedicated pin) pin,
directly connected from SoC to card external slot.
And for exynos5420 it is gpc2-2 as pointed by Krzysztof.
Also PIN_FUNC_2 for gpx2-4 indicate that it is wakeup_int2 function.
Do you get a card detect interrupt when removing and inserting the card to
the card slot?
Also to avoid confusion, probably you can change the node name as "mmc2_cd:
mmc2-cd-pins" 
(as sd2-cd-pins is gpc2-2 for this SoC)


>> Anyway, if it works for you, it's good.
>>
>> Rest looks ok, I'll apply after the merge window.
>
>Thanks!
>
>> Best regards,
>> Krzysztof
>
>Best regards,
>Henrik Grimler

