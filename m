Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495D24D1D17
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348329AbiCHQYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245315AbiCHQYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:24:07 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824A12AE05
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:23:08 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220308162303epoutp03d122759e272330cd8671cb78903b3779~adGMswAfh2744327443epoutp03b
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:23:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220308162303epoutp03d122759e272330cd8671cb78903b3779~adGMswAfh2744327443epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646756583;
        bh=XA9PFkBnvV5A5EVpwpXjJ323YxbtoFLRTwokgoEduQU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=LBX8Ufqr907LsD9A0jIBYBXHJ1bQF1/49o26QrjKw1Bdr3zE0L8+uH5uPk1dPVgPD
         Ar3JP3lCl+R2JzG/3Wk+9IbGQCGZLyz2FxvmHaQyJRGBsaa/LbLIQGyzaib3MQr9F9
         MwMJREhjHse4Xz5h06njJP1Cs5JZruqHE7SayyQA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220308162301epcas5p387cde50108c6bfb4a3d64904939be772~adGLqZIt72042920429epcas5p3s;
        Tue,  8 Mar 2022 16:23:01 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KCgbg5Zphz4x9Pt; Tue,  8 Mar
        2022 16:22:55 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.49.46822.60087226; Wed,  9 Mar 2022 01:10:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220308162254epcas5p3f9514f6f15f93133342edd6485cddabc~adGEiVtbQ2531025310epcas5p3T;
        Tue,  8 Mar 2022 16:22:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220308162254epsmtrp13566aaf9c2d74b6cc8319b41d29f6772~adGEhgHLS3263232632epsmtrp1c;
        Tue,  8 Mar 2022 16:22:54 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-9f-62278006ab6f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.A2.29871.ED287226; Wed,  9 Mar 2022 01:22:54 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220308162252epsmtip195bfa22264ce1f8e2a0619f6074801ad~adGCnyILS1058610586epsmtip1j;
        Tue,  8 Mar 2022 16:22:52 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Lee Jones'" <lee.jones@linaro.org>,
        "'Mark Brown'" <broonie@kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <andi@etezian.org>, <linux-spi@vger.kernel.org>,
        <linux-fsd@tesla.com>, "'Adithya K V'" <adithya.kv@samsung.com>
In-Reply-To: <Yid31AK5BlZEgmoA@google.com>
Subject: RE: [RESEND PATCH v3 1/2] spi: dt-bindings: samsung: Add fsd spi
 compatible
Date:   Tue, 8 Mar 2022 21:52:51 +0530
Message-ID: <011e01d83308$c38dba70$4aa92f50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ0WBqQSnNME8An5DjgYUtJdqxg/AH0fdoJAkkbGC8BrsvLegHow/MEAfvAXIMCCpxwswE3JuwxqxTLBfA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmui5bg3qSwb4FchYHJrxitVj84zmT
        xdSHT9gs5h85x2qx8e0PJov7X48yWkz5s5zJYtPja6wWD1+FW1zeNYfNYsb5fUwWjR9vslss
        2vqF3aJ17xF2Bz6PWQ29bB7Xl3xi9ti0qpPN4861PWwem5fUe/RtWcXo8a9pLrvH501yARxR
        2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGcrKZQl
        5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz
        Gq5OZS94JFixdttFpgbGf3xdjJwcEgImEh9+bGEBsYUEdjNKLF7m18XIBWR/YpSYPeMJE4Tz
        jVFi0vsF7DAdG9f/YIVI7GWU+LB5JhuE85JRYuejnUwgVWwCuhI7FrexgdgiAv4SOzumMYMU
        MQv8YZJY3LAFLMEpoCVx5EI7WIOwQJjEzLNngYo4OFgEVCQ23XUFCfMKWEoce9fICmELSpyc
        +QTsVmYBbYllC18zQ1ykIPHz6TJWiF1JEl/e32WEqBGXeHn0CDvIXgmBBxwS+288Z4RocJGY
        9PQDC4QtLPHq+Bao16QkXva3sYPcICGQLdGzyxgiXCOxdN4xqHJ7iQNX5rCAlDALaEqs36UP
        sYpPovc3KLRAOnklOtqEIKpVJZrfXYXqlJaY2N3NCmF7SOzZu5lxAqPiLCSPzULy2CwkD8xC
        WLaAkWUVo2RqQXFuemqxaYFRXmo5PLqT83M3MYLTtJbXDsaHDz7oHWJk4mA8xCjBwawkwnv/
        vEqSEG9KYmVValF+fFFpTmrxIUZTYGBPZJYSTc4HZoq8knhDE0sDEzMzMxNLYzNDJXHe0+kb
        EoUE0hNLUrNTUwtSi2D6mDg4pRqY3NVrxSb1LJkbVveM54Av/919F7eWH150ujhlXc3T5N2b
        hKoYLD1eN22ZYLr/TY2aec7Mdw/m2xkrz7o1e9/ZEs6b8Udt+Dra3mVGdZi+/HhneqwFu/QD
        74cmZ5MXyJnNlrke/FTIdcequnT3DS+EP4p/nqDdKHNswy7l55suXw66flHlVlRnr87VepVz
        eb6cSXxftvB+eM/ed5qnNEs46cG35HIX7l83LttKmR/f+7PefuZSq3PfugpOyObqfFFZmNYg
        rSJ6JPfAE4bVqy5mHf9mvvt9ZMK6J4vyNKRctfQ4OVdF/5yp7P1bMqtOcFWhI1OAUk3mC5Hs
        uFIOufq3O68dYRNlaHl6/c2Hz3V1SizFGYmGWsxFxYkA1MdfR1wEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSnO69JvUkg5WPuC0OTHjFarH4x3Mm
        i6kPn7BZzD9yjtVi49sfTBb3vx5ltJjyZzmTxabH11gtHr4Kt7i8aw6bxYzz+5gsGj/eZLdY
        tPULu0Xr3iPsDnwesxp62TyuL/nE7LFpVSebx51re9g8Ni+p9+jbsorR41/TXHaPz5vkAjii
        uGxSUnMyy1KL9O0SuDJ+/FrMWvBFoKL51Q/mBsbfvF2MnBwSAiYSG9f/YO1i5OIQEtjNKPFv
        7SkWiIS0xPWNE9ghbGGJlf+es0MUPWeU+LrzCitIgk1AV2LH4jY2EFtEwF/iZfdHRpAiZoEO
        ZolfM14wQXTcZpLY8nsdWAengJbEkQvtTCC2sECIxM1Ny4DWcXCwCKhIbLrrChLmFbCUOPau
        kRXCFpQ4OfMJ2EXMAtoSvQ9bGWHsZQtfM0NcpyDx8+kyVogjkiS+vL8LVSMu8fLoEfYJjMKz
        kIyahWTULCSjZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhitTR3MG5f
        9UHvECMTB+MhRgkOZiUR3vvnVZKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKa
        nZpakFoEk2Xi4JRqYLJbcKVMuW7dcafHGfv66/u3XfqywT2jIO3akaa0jPf5JwU+zrDZq35v
        1UzDJRO11y1rUna1vLAnhFdV78NfP+XPvQEV6sLv/rpFWs3SrPRcNL3MvMXgqu/V9sImjh3V
        ObFXp5eWhjbumFX0/0hsq92nVyWzYm/MueT1aQPDr/DzknKM+qvu/T7NvMxpXtnkWS35bxSX
        lSrdX/+rcFNqsmLfnNLb8azXT9kZP81Ok9/V/5FjsrPXkZd609XDfbI7DqZwbPyd+dh1gZ3P
        9kfl3OF+R5MFLyref7Z05qNLT2bnH9r7JltfdN/NGRy79rBcnr1L+fJy3UpBXzZWFd2ji64f
        SZ2/xiL8h9iF1UvX2a5UYinOSDTUYi4qTgQAhIXiz0cDAAA=
X-CMS-MailID: 20220308162254epcas5p3f9514f6f15f93133342edd6485cddabc
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
        <Yidv5aGB3CljCEWg@sirena.org.uk> <Yid31AK5BlZEgmoA@google.com>
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
>From: Lee Jones =5Bmailto:lee.jones=40linaro.org=5D
>Sent: Tuesday, March 8, 2022 9:06 PM
>To: Mark Brown <broonie=40kernel.org>
>Cc: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org;
>devicetree=40vger.kernel.org; linus.walleij=40linaro.org; robh+dt=40kernel=
.org;
>krzysztof.kozlowski=40canonical.com; linux-samsung-soc=40vger.kernel.org;
>pankaj.dubey=40samsung.com; andi=40etezian.org; linux-spi=40vger.kernel.or=
g;
>linux-fsd=40tesla.com; 'Adithya K V' <adithya.kv=40samsung.com>
>Subject: Re: =5BRESEND PATCH v3 1/2=5D spi: dt-bindings: samsung: Add fsd =
spi
>compatible
>
>On Tue, 08 Mar 2022, Mark Brown wrote:
>
>> On Tue, Mar 08, 2022 at 08:15:15PM +0530, Alim Akhtar wrote:
>>
>> > >There were changes adding the FSD SoC as well as DT stuff IIRC.
>>
>> > FSD SoC DT changes are already in -next.
>> > I think this can go with MFD tree because of immutable branch
>> > between MFD, SPI and DT due for the v5.18 merge windows.
>> > I am not sure if there are better ways to handle this.
>>
>> I need the changes that are hard dependencies to actually be in my
>> tree so my tree is not broken, -next isn't good enough here.  If there
>> are dependencies for things you're posting you should explicitly say
>> what they are when you post (not just vauge statements that there are
>> dependencies), and when you post things that will be dependencies for
>> other trees it's good to mention this so that people can think about
>> putting them on a separate branch for easier cross merging.
>
>Right.
>
>Which patch(es) contain the dependencies please Alim?
>

Only dependency is on=20
  https://lore.kernel.org/all/YiYC7eYx2SpPILyl=40google.com/

  spi: dt-bindings: samsung: Convert to dtschema

for the subject patch.

>I tend to send out pull-requests for cross-subsystem changes I merge.
>
>Not sure I see anything relevant in my tree currently.
>
>--
>Lee Jones =5B=E6=9D=8E=E7=90=BC=E6=96=AF=5D=0D=0A>Principal=20Technical=20=
Lead=20-=20Developer=20Services=20Linaro.org=20=E2=94=82=20Open=20source=0D=
=0A>software=20for=20Arm=20SoCs=20Follow=20Linaro:=20Facebook=20=7C=20Twitt=
er=20=7C=20Blog=0D=0A=0D=0A
