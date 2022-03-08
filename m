Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FBE4D1D0C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348304AbiCHQUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348293AbiCHQUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:20:40 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D345007A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:19:41 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220308161939epoutp012e59ef9819ba78d6e8c8433ddab404d0~adDPhBYN00844108441epoutp01v
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:19:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220308161939epoutp012e59ef9819ba78d6e8c8433ddab404d0~adDPhBYN00844108441epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646756379;
        bh=ZmeFY8CtGvdDkt1Lq+xwl0sfm1GGATKvFH1o7svPeTw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=k+YwDP2WD7ybw8k08aPu1DuUOayns/FEoVTytyESIv+3EA0qOhdIyAjEgESGXDifS
         lTB1DXaH69seXnrpWAB/YrmAUpbXayHqpdJTNkXKafdfihPydVW68T2qAyJimZ3mRM
         QBDB8iBCS0hBVjOjPFuyPFw2vnSpy8hrNp+tW0xE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220308161938epcas5p2fbad95c3ec4c6cf329f48496920eb04c~adDOI9V6L0300903009epcas5p2e;
        Tue,  8 Mar 2022 16:19:38 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KCgWn41S8z4x9Q0; Tue,  8 Mar
        2022 16:19:33 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.09.46822.C3F77226; Wed,  9 Mar 2022 01:07:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220308161933epcas5p411ed361a7587a27e14a032fe3d1c307c~adDJObcg41702717027epcas5p4o;
        Tue,  8 Mar 2022 16:19:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220308161933epsmtrp2e8e6053c1a282ca15911d6f4ae86be1f~adDJNo7FC2599025990epsmtrp2X;
        Tue,  8 Mar 2022 16:19:33 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-87-62277f3c8f6e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.D7.03370.41287226; Wed,  9 Mar 2022 01:19:33 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220308161931epsmtip29e45cdb9a285ab50e629a750af51f590~adDHTJ8PE1201012010epsmtip2C;
        Tue,  8 Mar 2022 16:19:30 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Mark Brown'" <broonie@kernel.org>
Cc:     "'Lee Jones'" <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <andi@etezian.org>, <linux-spi@vger.kernel.org>,
        <linux-fsd@tesla.com>, "'Adithya K V'" <adithya.kv@samsung.com>
In-Reply-To: <Yidv5aGB3CljCEWg@sirena.org.uk>
Subject: RE: [RESEND PATCH v3 1/2] spi: dt-bindings: samsung: Add fsd spi
 compatible
Date:   Tue, 8 Mar 2022 21:49:29 +0530
Message-ID: <011d01d83308$4baaa860$e2fff920$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ0WBqQSnNME8An5DjgYUtJdqxg/AH0fdoJAkkbGC8BrsvLegHow/MEAfvAXIMCCpxws6segwNg
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmpq5NvXqSwdJT4hYHJrxitVj84zmT
        xdSHT9gs5h85x2qx8e0PJov7X48yWkz5s5zJYtPja6wWD1+FW1zeNYfNYsb5fUwWjR9vslss
        2vqF3aJ17xF2Bz6PWQ29bB7Xl3xi9ti0qpPN4861PWwem5fUe/RtWcXo8a9pLrvH501yARxR
        2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGcrKZQl
        5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz
        enZfYCvYyFdx+cY1lgbGn9xdjJwcEgImEo1rzrN2MXJxCAnsZpR4d6SJDcL5xChxsqWPCcL5
        zCjRO/kaM0zLzV3zWCASuxgl1i6aC5YQEnjJKHHpmyaIzSagK7FjcRsbiC0ioC5xdNNGVhCb
        WWAJs8TUWQ4gNidQzYT3E8B6hQXCJGaePQtmswioSNxqn8MIYvMKWErcPX2cDcIWlDg58wkL
        xBx5ie1v50AdpCDx8+kyoPkcQLuiJO4dDoIoEZd4efQIO8idEgIvOCTWbH0IViMh4CIx9acx
        RKuwxKvjW9ghbCmJz+/2skGUZEv07IIqqZFYOu8YC4RtL3HgyhwWkBJmAU2J9bv0ITbxSfT+
        fsIE0ckr0dEmBFGtKtH87ipUp7TExO5uVgjbQ2LP3s2MExgVZyF5axaSt2YhuX8WwrIFjCyr
        GCVTC4pz01OLTQuM8lLL4ZGdnJ+7iRGcorW8djA+fPBB7xAjEwfjIUYJDmYlEd7751WShHhT
        EiurUovy44tKc1KLDzGaAsN6IrOUaHI+MEvklcQbmlgamJiZmZlYGpsZKonznk7fkCgkkJ5Y
        kpqdmlqQWgTTx8TBKdXAtPnOfrWOBbtEmzUvxkz++9rL2rOu+aHvRYGS2pcznzKwy/4tmLQk
        ber6t80/lvn4z7a87Bx93ThvroyOkHTiVoM1M/ne7Dx4NEN77ty+LcnZiz3jWELU+K60+ao+
        OJH2J0ZucbfymiUK+3+F9qvetd56dSr7ZM7OeLmKN/tUgtUl1kYET8+5b7rpvpXcgYXNE5j2
        HV6fJJekattYn+m+WEnzibAqY970eWsMYyyELq1dfi/y7nvfsjSzM1I8ewReLLqk+GWKjLpd
        Rb7AnXVcmVWHlStMFsT3/pxxbe5lefZCp8sznZmV9RQrq/sthVitH3Cv4PDKSQhlc+/re5py
        LoTB232GyuolHtliy7cpsRRnJBpqMRcVJwIAWpwLg1oEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSvK5ok3qSwc2JzBYHJrxitVj84zmT
        xdSHT9gs5h85x2qx8e0PJov7X48yWkz5s5zJYtPja6wWD1+FW1zeNYfNYsb5fUwWjR9vslss
        2vqF3aJ17xF2Bz6PWQ29bB7Xl3xi9ti0qpPN4861PWwem5fUe/RtWcXo8a9pLrvH501yARxR
        XDYpqTmZZalF+nYJXBk9uy+wFWzkq7h84xpLA+NP7i5GTg4JAROJm7vmsXQxcnEICexglFiw
        YxMbREJa4vrGCewQtrDEyn/P2SGKnjNKvHg3hwkkwSagK7FjcRtYg4iAusTRTRtZQYqYBTYw
        S+z4PIERomMvk8TsJ9sYQao4gTomvJ/ADGILC4RI3Ny0jAXEZhFQkbjVPgeshlfAUuLu6eNs
        ELagxMmZT4BqOICm6km0bQQrYRaQl9j+dg4zxHUKEj+fLmMFKRERiJK4dzgIokRc4uXRI+wT
        GIVnIRk0C2HQLCSDZiHpWMDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzhatbR2
        MO5Z9UHvECMTB+MhRgkOZiUR3vvnVZKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCe
        WJKanZpakFoEk2Xi4JRqYNpzfLG1Wu79bzON9RcafJ0k/eVOttcr9iN1dzfP82AxvPtU5M8F
        zT2ZpmnL32d9eS076atXy6Xjl/eo5nffmHqshNH9yIMTPcZZcz/8fnHo204R28Zz31PLp82d
        5OaxYF38N7+zNR8f3breu+ir5L1VoYt/v/9b0rzisfGl6Fxh04OLmS8fyPXLuHO6f4f7kqrN
        iU1nFT9or3TYI8rgNWXlimZ7Ff+AtUuNwprqSid+kTaR0L0z89Sc1HuzazcauPr94+OOm3hO
        dtmqsJjJwb8WTD8cOK9g6d2ZT1kMPjJrzLnW8y+qx118+9btC5bNiji15HY9//xT3+XnXprd
        uWjeOckfZe+9V12IejMrnEX40WolluKMREMt5qLiRAC2kOKjRQMAAA==
X-CMS-MailID: 20220308161933epcas5p411ed361a7587a27e14a032fe3d1c307c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681
References: <CGME20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681@epcas5p3.samsung.com>
        <20220308121640.27344-1-alim.akhtar@samsung.com>
        <YidY+ncMVhp7bBvh@sirena.org.uk> <Yidg64QGGzIbduQ2@google.com>
        <YidosChLIwIAKDmG@sirena.org.uk>
        <010901d832fb$212124f0$63636ed0$@samsung.com>
        <Yidv5aGB3CljCEWg@sirena.org.uk>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Tuesday, March 8, 2022 8:32 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>
>Cc: 'Lee Jones' <lee.jones@linaro.org>;
linux-arm-kernel@lists.infradead.org;
>linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
>linus.walleij@linaro.org; robh+dt@kernel.org;
>krzysztof.kozlowski@canonical.com; linux-samsung-soc@vger.kernel.org;
>pankaj.dubey@samsung.com; andi@etezian.org; linux-spi@vger.kernel.org;
>linux-fsd@tesla.com; 'Adithya K V' <adithya.kv@samsung.com>
>Subject: Re: [RESEND PATCH v3 1/2] spi: dt-bindings: samsung: Add fsd spi
>compatible
>
>On Tue, Mar 08, 2022 at 08:15:15PM +0530, Alim Akhtar wrote:
>
>> >There were changes adding the FSD SoC as well as DT stuff IIRC.
>
>> FSD SoC DT changes are already in -next.
>> I think this can go with MFD tree because of immutable branch between
>> MFD, SPI and DT due for the v5.18 merge windows.
>> I am not sure if there are better ways to handle this.
>
>I need the changes that are hard dependencies to actually be in my tree so
my
>tree is not broken, -next isn't good enough here.  If there are
dependencies
>for things you're posting you should explicitly say what they are when you
>post (not just vauge statements that there are dependencies), and when you
>post things that will be dependencies for other trees it's good to mention
this
>so that people can think about putting them on a separate branch for easier
>cross merging.
Sorry Mark for the noise. I should have clearly mentioned the dependencies. 
Surly I will keep this in mind for the future patches.

Only dependency these two patches have on 

  https://lore.kernel.org/all/YiYC7eYx2SpPILyl@google.com/

  spi: dt-bindings: samsung: Convert to dtschema

which is now in MFD tree.



