Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D45C4ABBFF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 12:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386546AbiBGLey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383958AbiBGLYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:24:14 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140B9C0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:24:11 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220207112409epoutp03b9f7e50d836215f7957d46276af7c73e~RfT81M3KG0044800448epoutp03X
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:24:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220207112409epoutp03b9f7e50d836215f7957d46276af7c73e~RfT81M3KG0044800448epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644233049;
        bh=Qc7M2hJk0w84pj/Vx2lKJZYzksTNJvfXj+/TpHNeYOc=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=eyrbLyvYRBWcwlJC2FH9h/UF+3jtXmEvels4S+dCgYsaHLDs5zeIZqPmSagR57dLE
         gfxePhCklDTIQIw5A2RCxPtmHeIGhbFh/4tNgpTDcR3aeCNn9OCTw1K/7nfb5spi8b
         ryrrbYJsVD1m4rCFWtPNccsSZ2LjAyZamPi/cfgg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220207112409epcas5p447fbce032297a2fb91017be3a967a383~RfT8ePRKO3033730337epcas5p4S;
        Mon,  7 Feb 2022 11:24:09 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JskLD20Ttz4x9Q0; Mon,  7 Feb
        2022 11:24:04 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.39.46822.DA001026; Mon,  7 Feb 2022 20:21:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220207112403epcas5p3b78dde3d8edc1b248c78760e3e07ad1e~RfT3nbVic3066030660epcas5p3W;
        Mon,  7 Feb 2022 11:24:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220207112403epsmtrp1b1dcc357ba19a07d04adfafe9758b209~RfT3moTCB0153701537epsmtrp13;
        Mon,  7 Feb 2022 11:24:03 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-16-620100adc570
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.0D.29871.35101026; Mon,  7 Feb 2022 20:24:03 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220207112402epsmtip2693cdfb285dd4cd34426ce0041429dc5~RfT2ORIe63124231242epsmtip2o;
        Mon,  7 Feb 2022 11:24:02 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Lukasz Luba'" <lukasz.luba@arm.com>,
        "'Dmitry Osipenko'" <digetx@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <4b18991e-1c93-077d-368f-a861e8c2b845@canonical.com>
Subject: RE: [PATCH v3 5/8] dt-bindings: memory: lpddr3: deprecate
 manufacturer ID
Date:   Mon, 7 Feb 2022 16:54:00 +0530
Message-ID: <0b5001d81c15$362142b0$a263c810$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGyHe1yAVlgrWkusZTYpz8Cv3vw/AK18OIBAhf1WX4Cc1+okgFeSRrFrI7fxeA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmhu5aBsYkg+W3OSzmHznHarH642NG
        i41vfzBZbHp8jdXi8q45bBafe48wWsw4v4/JYmFTC7tF694j7A6cHmvmrWH0mNXQy+axc9Zd
        do9NqzrZPDYvqff4vEkugC0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEv
        MTfVVsnFJ0DXLTMH6CglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5x
        aV66Xl5qiZWhgYGRKVBhQnbGuxc/mQr+yVTM3nicsYFxp0QXIyeHhICJxJ+Lhxi7GLk4hAR2
        M0qcvnKAHcL5xCjx6sNZVgjnG6PErat/GGFaft7shWrZyyhxZtoUKOclo8SUp6fZQKrYBHQl
        dixuYwNJiAg8ZpKYeH4rWDungKPE8qXNYLawQIjEnL9PgWwODhYBFYml/3xAwrwClhKv/sxk
        g7AFJU7OfMICYjMLaEssW/iaGeIKBYmfT5exgtgiAn4STx8/YoKoEZd4efQIO0TNXA6JTfdC
        IWwXibNbrjFB2MISr45vgaqRknjZ38YOcoKEQLZEzy5jiHCNxNJ5x1ggbHuJA1fmsICUMAto
        SqzfpQ+xiU+i9/cTJohOXomONiGIalWJ5ndXoTqlJSZ2d7NC2B4SrxfPhQbuASaJR7O2sU5g
        VJiF5MlZSJ6cheSZWQibFzCyrGKUTC0ozk1PLTYtMMpLLYfHd3J+7iZGcJLV8trB+PDBB71D
        jEwcjIcYJTiYlUR4Zbr/JwrxpiRWVqUW5ccXleakFh9iNAUG/ERmKdHkfGCazyuJNzSxNDAx
        MzMzsTQ2M1QS5z2dviFRSCA9sSQ1OzW1ILUIpo+Jg1Oqgakv8JTvcsUTAQxv0vmmHGEIY87b
        fGSF7yFPuY9ttlxM5gtXpL417Oh/LChwpV7NZ0Zy4dWnc/UuCE/eszu4ifeGd2dI+5df7Dd1
        d8ysqvbrifOfqvqyfPm8thPKFe/E78lmnrOp/PD2Gf9fjiqf/qT0zsx5jWbcp965n9H2DBS8
        d3wtU8sqn5jHf6doxzI3ikTI/QmSOfGtz3ivau+ntl7x2fXzyvSUfKc+yWaX+Nouc2vr1sQz
        j9a+E7FZP//sT4+Ta4W3VHN91+jZlRt6bZ8q16yqeeVlIccTd5kxXJePmDE/YP7a5aEJRlMk
        Xl36uf937h/bXxLWpnPvTTPwt14gpvloMsec/73dFmeuNCuxFGckGmoxFxUnAgCCEF42OwQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXjeYkTHJYGKblsX8I+dYLVZ/fMxo
        sfHtDyaLTY+vsVpc3jWHzeJz7xFGixnn9zFZLGxqYbdo3XuE3YHTY828NYwesxp62Tx2zrrL
        7rFpVSebx+Yl9R6fN8kFsEVx2aSk5mSWpRbp2yVwZfTdW8ZYsEem4u2hDrYGxvfiXYycHBIC
        JhI/b/YydjFycQgJ7GaUuLh+DjtEQlri+sYJULawxMp/z9khip4zSmw7vpEFJMEmoCuxY3Eb
        G0hCROA1k8SDpqUsEFU7mCR+/HnKBFLFKeAosXxpMyOILSwQJPHqSTfQKA4OFgEViaX/fEDC
        vAKWEq/+zGSDsAUlTs58AraAWUBb4unNp3D2soWvmSEuUpD4+XQZK4gtIuAn8fTxIyaIGnGJ
        l0ePsE9gFJqFZNQsJKNmIRk1C0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsY
        wVGlpbmDcfuqD3qHGJk4GA8xSnAwK4nwynT/TxTiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6Hr
        ZLyQQHpiSWp2ampBahFMlomDU6qBKbGWb8/2y3/LV/Tk7FP9VvVSPdp93kzppy9mhFvXMGw2
        ilZxCtdPt5ujsocrdp2Dzv4T5xYKOr379CimZM6iWhlhn9jX6YdWha6+9tfeTHJpWGVnzsvT
        pod2MFT5WnBIKYscsNzyPp6R099V0TR48p4lwVsO/fy4OL5iwbsAUZ8jRZcD+yq3rqn5aCZh
        0SLJ9ulIGcdkjX3H5v2zyHbPWroquaWTk1NIzGuNKnOF9Sf5n+Ll3KcjM2MM1104Xi73w2f6
        8y+lv4ujXu+72HTe70WUceXaz9lLpzqFK2poLAwvuP71m7So786s3mCmIr7PhRk/9X9/Sapp
        8HU26iqS+P5kn75C+JLl152Wb92nxFKckWioxVxUnAgABNlYXxkDAAA=
X-CMS-MailID: 20220207112403epcas5p3b78dde3d8edc1b248c78760e3e07ad1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220206135825epcas5p4c07136cf0a54eb4d6c8441cd6dbf14bc
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
        <CGME20220206135825epcas5p4c07136cf0a54eb4d6c8441cd6dbf14bc@epcas5p4.samsung.com>
        <20220206135807.211767-6-krzysztof.kozlowski@canonical.com>
        <0a7101d81bd9$33088840$991998c0$@samsung.com>
        <4b18991e-1c93-077d-368f-a861e8c2b845@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Monday, February 7, 2022 2:27 PM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; 'Rob Herring'
><robh+dt=40kernel.org>; 'Lukasz Luba' <lukasz.luba=40arm.com>; 'Dmitry
>Osipenko' <digetx=40gmail.com>; linux-kernel=40vger.kernel.org;
>devicetree=40vger.kernel.org; linux-pm=40vger.kernel.org; linux-samsung-
>soc=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org
>Subject: Re: =5BPATCH v3 5/8=5D dt-bindings: memory: lpddr3: deprecate
>manufacturer ID
>
>On 07/02/2022 05:14, Alim Akhtar wrote:
>> Hi Krzysztof
>>
>>> -----Original Message-----
>>> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=
=5D
>>> Sent: Sunday, February 6, 2022 7:28 PM
>>> To: Krzysztof Kozlowski <krzysztof.kozlowski=40canonical.com>; Rob
>>> Herring <robh+dt=40kernel.org>; Lukasz Luba <lukasz.luba=40arm.com>; Al=
im
>>> Akhtar <alim.akhtar=40samsung.com>; Dmitry Osipenko
><digetx=40gmail.com>;
>>> linux- kernel=40vger.kernel.org; devicetree=40vger.kernel.org; linux-
>>> pm=40vger.kernel.org; linux-samsung-soc=40vger.kernel.org; linux-arm-
>>> kernel=40lists.infradead.org
>>> Subject: =5BPATCH v3 5/8=5D dt-bindings: memory: lpddr3: deprecate
>>> manufacturer ID
>>>
>>> The memory manufacturer should be described in vendor part of
>>> compatible, so there is no need to duplicate it in a separate property.
>>> Similarly is done in LPDDR2 bindings.
>>>
>>> Signed-off-by: Krzysztof Kozlowski
>>> <krzysztof.kozlowski=40canonical.com>
>>> ---
>>> .../bindings/memory-controllers/ddr/jedec,lpddr3.yaml         =7C 4 +++=
-
>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-
>>> controllers/ddr/jedec,lpddr3.yaml
>>> b/Documentation/devicetree/bindings/memory-
>>> controllers/ddr/jedec,lpddr3.yaml
>>> index d6787b5190ee..3bcba15098ea 100644
>>> --- a/Documentation/devicetree/bindings/memory-
>>> controllers/ddr/jedec,lpddr3.yaml
>>> +++ b/Documentation/devicetree/bindings/memory-
>>> controllers/ddr/jedec,lpd
>>> +++ dr3.yaml
>>> =40=40 -40,7 +40,9 =40=40 properties:
>>>   manufacturer-id:
>>>     =24ref: /schemas/types.yaml=23/definitions/uint32
>>>     description: =7C
>>> -      Manufacturer ID value read from Mode Register 5.
>>> +      Manufacturer ID value read from Mode Register 5.  The property i=
s
>>> +      deprecated, manufacturer should be derived from the compatible.
>>> +    deprecated: true
>>>
>>
>> Shouldn't it be the other way? As DT describes hardware and MR5 does
>> contain the Manufacturer ID, so getting Manufacturer ID from MR5 makes
>> aligned to hardware description.
>
>The code/driver can read MR5 and report it to user-space in case for examp=
le
>we have a device compatible with different vendor and same compatible is
>used. So compatible is re-used but we want real manufacturer ID from the
>hardware.
>
>But storing a fixed MR5 value in DT does not fit here. If someone takes ef=
fort
>to encode manufacturer ID in the DTS, then he/she should take effort to
>actually document the compatible.
>
>Basically having MR5 in DT is equal to having a compatible in DTS. I prefe=
r the
>latter - simpler, less properties, using existing property from DT spec in=
stead
>of custom one.
>
Ok, so there are two part of it, first one to get the compatible and bind t=
he device=20
and second one to get the manufacturer ID from MR5 for say user application=
.
Second one can still be handled at driver side, so

Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>


>Best regards,
>Krzysztof

