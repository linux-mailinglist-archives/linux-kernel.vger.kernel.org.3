Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F08575962
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 04:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241218AbiGOCCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 22:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbiGOCCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 22:02:13 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C7973902
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 19:02:11 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220715020208epoutp025543a6fc4fb166285f4f18dc0084f61b~B3kWzaAGH1989819898epoutp02a
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:02:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220715020208epoutp025543a6fc4fb166285f4f18dc0084f61b~B3kWzaAGH1989819898epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657850528;
        bh=wyxcBunwFkuku59dj613W+/U6vWm11KQddqiSNeGaiA=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=junLhXk3myh7KF9cKKqnwVAyDxL1ybBsvWQrJXAou70qRbEXCm3zR50WIqRrgepUD
         sPvmRoiGDawU2EhJb7qhqgIl7yd9WOjB+Zh4OSLGtmoWl2fG8vDPgfXwJBtyZ1AieA
         lQENr+tH6INkybRMHy8eRNHAQmGHMdiOmISJ1JUw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220715020208epcas1p28302417daadc2e071a2ab40cb85234a0~B3kWOf1Bf2222322223epcas1p2-;
        Fri, 15 Jul 2022 02:02:08 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LkZNv65G4z4x9Pw; Fri, 15 Jul
        2022 02:02:07 +0000 (GMT)
X-AuditID: b6c32a36-05fff700000025a1-e2-62d0ca9f4e51
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.2F.09633.F9AC0D26; Fri, 15 Jul 2022 11:02:07 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 2/4] firmware: Samsung: Add secure monitor driver
Reply-To: dj76.yang@samsung.com
Sender: Dongjin Yang <dj76.yang@samsung.com>
From:   Dongjin Yang <dj76.yang@samsung.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <f4585789-cec9-0787-cd80-57afed424ee4@infradead.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220715020207epcms1p43819fd2dd937e567fc540af7b62c59a5@epcms1p4>
Date:   Fri, 15 Jul 2022 11:02:07 +0900
X-CMS-MailID: 20220715020207epcms1p43819fd2dd937e567fc540af7b62c59a5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmvu78UxeSDKa+0rc4vf8di8XLQ5oW
        84+cY7WYOfUMs8XCacsZLZ4fmsVs8XLWPTaLI28+Mlvc/3qU0WL/8ZVMFpd3zWGzOLc40+Lt
        neksFq17j7Bb3Dl8lsWB3+P6ugCPzSu0PDat6mTzuHNtD5vH+31X2Tz6tqxi9Pi8SS6APSrb
        JiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoaCWFssSc
        UqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsb0
        pn1MBW3CFWcOPGNtYDwm1MXIySEhYCKxqGszYxcjF4eQwA5Gieft59m7GDk4eAUEJf7uEAap
        ERZwlThx6zpYWEhAXuLzxEqIsI5Ex9unLCBhNgEtidn9iSBTRARmMkm8u/SDHcRhFpjDLLFq
        zis2iF28EjPaQRpAbGmJ7cu3MoLYnAKOErN77kDFNSR+LOtlhrBFJW6ufssOY78/Np8RwhaR
        aL13FqpGUOLBz91QcSmJR80HoOxqiXPtvWBHSAg0MEoc/LyRDeRSCQF9iR3XjUFqeAV8JQ4+
        PQJ2G4uAqsSkiVeYIHpdJGa+W8wKYjMLaEssW/iaGaSVWUBTYv0ufYgpyhJHbrHAfNWw8Tc7
        OptZgE/i3dceVpj4jnlPoKYrS3xufs0ygVF5FiKcZyHZNQth1wJG5lWMYqkFxbnpqcWGBUbw
        qE3Oz93ECE69WmY7GCe9/aB3iJGJg/EQowQHs5IIb/ehc0lCvCmJlVWpRfnxRaU5qcWHGE2B
        vpzILCWanA9M/nkl8YYmlgYmZkampoYGFiZK4ryrpp1OFBJITyxJzU5NLUgtgulj4uCUamCa
        67X6hbqmyKTth9NfmFrK8x1gWJK8tk7hvoeVw8mwyb0tOXsdtDRMk1qfcPXps9t7v7h1XiQq
        Mcqg/tH01/fq6ivl1dm0PvS3Lq3yqTxqe0lf8Y/XyS3TJqX5O1/7+mCpcdSzFzeOeSmnPO02
        uWb3uGrVPumOrHV3zir9DykpWt698dTR+kQL27wp4j9zYptv8tXP8WWdErcrpip8W/sCTauw
        FpGMRTqOHd/+W5vm3WFnumb+4ekC61ztwlsbLOt989Tr5s1c3q29/JnnQS6bNcp9E5bFPQ7n
        Ds/j3KD480SavURT1zLRD+eTi79Hp+lfbra84DepTcG5w9BnWWviirtVykcWOkxRufzjtxJL
        cUaioRZzUXEiAKhAHJFGBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713045516epcms1p86b3f6a8795d767faac65eb947405f911
References: <f4585789-cec9-0787-cd80-57afed424ee4@infradead.org>
        <20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p8>
        <CGME20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p4>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On=C2=A07/13/22=C2=A004:58,=C2=A0Randy=20Dunlap=C2=A0wrote:=0D=0A>=20Hi--=
=0D=0A>=20=0D=0A>=20On=C2=A07/12/22=C2=A021:55,=C2=A0Dongjin=C2=A0Yang=C2=
=A0wrote:=0D=0A>=20>=C2=A0diff=C2=A0--git=C2=A0a/drivers/firmware/Kconfig=
=C2=A0b/drivers/firmware/Kconfig=0D=0A>=20>=C2=A0index=C2=A0e5cfb01353d8..4=
b0f2d033f58=C2=A0100644=0D=0A>=20>=C2=A0---=C2=A0a/drivers/firmware/Kconfig=
=0D=0A>=20>=C2=A0+++=C2=A0b/drivers/firmware/Kconfig=0D=0A>=20>=C2=A0=40=40=
=C2=A0-217,6=C2=A0+217,17=C2=A0=40=40=C2=A0config=C2=A0QCOM_SCM_DOWNLOAD_MO=
DE_DEFAULT=0D=0A>=20>=C2=A0=C2=A0=0D=0A>=20>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Say=C2=A0Y=C2=A0here=C2=A0to=C2=
=A0enable=C2=A0=22download=C2=A0mode=22=C2=A0by=C2=A0default.=0D=0A>=20>=C2=
=A0=C2=A0=0D=0A>=20>=C2=A0+config=C2=A0SAMSUNG_SECURE_SERVICE=0D=0A>=20>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0=22Samsung=C2=
=A0Foundry=C2=A0Secure=C2=A0Service=C2=A0Layer=22=0D=0A>=20>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends=C2=A0on=C2=A0HAVE_ARM_SMC=
CC=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default=
=C2=A0n=0D=0A>=20=0D=0A>=20Drop=C2=A0that=C2=A0line,=C2=A0it's=C2=A0the=C2=
=A0default=C2=A0anyway.=0D=0A=0D=0ASure=20thanks.=0D=0A=0D=0A>=20=0D=0A>=20=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help=0D=0A>=20>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Support=C2=
=A0secure=C2=A0service=C2=A0layer=C2=A0for=C2=A0SoCs=C2=A0which=C2=A0is=C2=
=A0manufactured=C2=A0by=0D=0A>=20=0D=0A>=20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0which=C2=A0are=0D=0A=0D=0AThanks=20for=20c=
orrecting.=0D=0A=0D=0A>=20=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Samsung=C2=A0Foundry.=0D=0A>=20>=C2=A0+=0D=0A=
>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Thi=
s=C2=A0option=C2=A0provide=C2=A0support=C2=A0of=C2=A0secure=C2=A0monitor=C2=
=A0service=C2=A0call=C2=A0using=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Trusted=C2=A0Foundations.=0D=0A>=20=0D=
=0A>=20--=C2=A0=0D=0A>=20=7ERandy=0D=0A
