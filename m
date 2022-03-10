Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC5D4D3F13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbiCJB5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiCJB5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:57:40 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DEF128644
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:56:39 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220310015636epoutp01e41c03d08b93b8aada4d609839ce9076~a4kQwm9i90231402314epoutp01R
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:56:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220310015636epoutp01e41c03d08b93b8aada4d609839ce9076~a4kQwm9i90231402314epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646877396;
        bh=1l6g1NyDp1pP7XH1bkrUc4TGt99XEBsOc7UHlVjSO8I=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=qGCMGVFVYtf5bIbIfvSUG/qPsRDvYCN1PESx3u0luYXzWwokEJSb6VBIoyXd1O4a8
         hGiAl1egYuWcAQBOviUEN2ELh9L0YZPkfCWpDD12Wlsg34dtKdT/apZDFVkg720m5i
         /jL1MkyGNXNsi9RPOAhzUFrykt4KMxdRv6TT1cC0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220310015635epcas2p164930aec7b732f83ba8eb33fccfffe3d~a4kQVex5j0377803778epcas2p1N;
        Thu, 10 Mar 2022 01:56:35 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.97]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KDXH42ntqz4x9Q5; Thu, 10 Mar
        2022 01:56:32 +0000 (GMT)
X-AuditID: b6c32a46-be9ff70000023ea8-34-62295acede70
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.4D.16040.ECA59226; Thu, 10 Mar 2022 10:56:30 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 0/3] Add support for artpec8 to samsung tmu
Reply-To: hypmean.kim@samsung.com
Sender: Sang Min Kim <hypmean.kim@samsung.com>
From:   Sang Min Kim <hypmean.kim@samsung.com>
To:     "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220310015629epcms2p8c0b7b218d49bacb453d8fde2c1584600@epcms2p8>
Date:   Thu, 10 Mar 2022 10:56:29 +0900
X-CMS-MailID: 20220310015629epcms2p8c0b7b218d49bacb453d8fde2c1584600
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmue65KM0kg2v7pS0Oz6+w+L7lOpPF
        y0OaFvM+y1psfPuDyeLyrjlsFp97jzBazDi/j8li7pepzBZPHvaxOXB5zGroZfPYOesuu8fi
        PS+ZPDat6mTzuHNtD5tH35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
        6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
        KTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM44+e43W8E//ooT5xezNjCe4O9i5OSQEDCR6P99
        kbWLkYtDSGAHo8Tj5pPsXYwcHLwCghJ/dwiD1AgLWEvs397FDmILCShKvNyxnRkiridxc+Nn
        sDibgI7E49b7TCBzRAS2MEn8mHaVFSTBLHCUUaJ5VirEMl6JGe1PWSBsaYnty7cyQtgaEj+W
        9TJD2KISN1e/ZYex3x+bD1UjItF67yxUjaDEg5+7oeKSEpsOb4eqr5a4tXE52DMSAg2MEq3f
        mphBnpEQ0JfYcd0Y4i9fiRfvCkDKWQRUJdrbnkC1ukhMal7JBHGytsSyha/BOpkFNCXW79KH
        GKIsceQWC8wjDRt/s6OzmQX4JDoO/4WL75j3hAnCVpXYuambHWKMtMTXudUTGJVmIYJ5FpK1
        sxDWLmBkXsUollpQnJueWmxUYASP2eT83E2M4ESq5baDccrbD3qHGJk4GA8xSnAwK4nwNoVq
        JAnxpiRWVqUW5ccXleakFh9iNAV6eCKzlGhyPjCV55XEG5pYGpiYmRmaG5kamCuJ83qlbEgU
        EkhPLEnNTk0tSC2C6WPi4JRqYIoT6p35IcixoPD+P46sb3n1TeLCdYqWDxPvFvstfrrqtHfh
        jqrEF77d0ZZsO19qyyVm3Xp/q3CGveGUSZrNc8U5o/vsjxpU1YRYX4uxmuy+PPjlTS0T9sbm
        ykVSYUXfOtjeHe5W/tNlf/F91bJ5D3tvzZs+8+g6CZbHRcdXJCTUGloYrou3jF5v43mucoHT
        l93Vze9vruI5k9c3k+ftKucDrto2XXM1tLXKHAV2vBU9ab33Uf8HJouDhhHa+r2b1H/MX7Cl
        JE5KN/D074Xmcyq31ca0+nT1H2lfc/1Hyp7Ea7npDRs4mvoFpaZuMalsuByhc/PqSp9ps/ks
        pZjqnP9vPNmZ+KpL17WuuzlHiaU4I9FQi7moOBEATvLoqS0EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220310013127epcas3p3f1b7ab9549b1d6d9da65c73adda5c514
References: <CGME20220310013127epcas3p3f1b7ab9549b1d6d9da65c73adda5c514@epcms2p8>
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

These=C2=A0patches=C2=A0are=C2=A0to=C2=A0add=C2=A0thermal=C2=A0management=
=C2=A0uint=C2=A0to=C2=A0artpec8=C2=A0SoC.=0D=0AThe=C2=A0tmu=C2=A0of=C2=A0ar=
tpec8=C2=A0is=C2=A0derived=C2=A0from=C2=A0the=C2=A0tmu=C2=A0of=C2=A0exynos,=
=C2=A0but=C2=A0it=C2=A0includes=C2=A0settings=0D=0Aspecialized=C2=A0for=C2=
=A0artpec8=C2=A0SoC,=C2=A0such=C2=A0as=C2=A0supporting=C2=A0multiple=C2=A0r=
emote=C2=A0sensors.=0D=0A=C2=A0=0D=0AThe=C2=A0contents=C2=A0of=C2=A0each=C2=
=A0patch=C2=A0are=C2=A0as=C2=A0follows.=0D=0A0001:=C2=A0Compatible=C2=A0for=
=C2=A0artpec8=C2=A0has=C2=A0been=C2=A0added.=0D=0A0002:=C2=A0It=C2=A0contai=
ns=C2=A0tmu=C2=A0driver=C2=A0code=C2=A0for=C2=A0artpec8.=0D=0A0003:=C2=A0Th=
is=C2=A0is=C2=A0a=C2=A0modified=C2=A0version=C2=A0of=C2=A0Makefile=C2=A0to=
=C2=A0build=C2=A0artpec8=C2=A0tmu.=0D=0A=C2=A0=0D=0AThe=C2=A0driver=C2=A0wa=
s=C2=A0tested=C2=A0on=C2=A0a=C2=A0board=C2=A0that=C2=A0supports=C2=A0artpec=
8=C2=A0SoC.=0D=0A=C2=A0=0D=0Asangmin=C2=A0kim=C2=A0(3):=0D=0A=C2=A0=C2=A0dt=
-bindings:=C2=A0thermal:=C2=A0Add=C2=A0artpec8=C2=A0compatible=C2=A0string=
=C2=A0for=C2=A0exynos-thermal=0D=0A=C2=A0=C2=A0thermal:=C2=A0artpec8-tmu:=
=C2=A0Add=C2=A0tmu=C2=A0driver=C2=A0for=C2=A0artpec8=0D=0A=C2=A0=C2=A0therm=
al:=C2=A0samsung:=C2=A0Update=C2=A0makefile=C2=A0for=C2=A0artpec8=0D=0A=C2=
=A0=0D=0A=C2=A0.../bindings/thermal/samsung,exynos-thermal.yaml=C2=A0=C2=A0=
=C2=A0=7C=C2=A0=C2=A0=C2=A02=C2=A0+=0D=0A=C2=A0drivers/thermal/samsung/Make=
file=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0=C2=A0=C2=A02=C2=A0+-=
=0D=0A=C2=A0drivers/thermal/samsung/artpec8_tmu.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0754=C2=
=A0+++++++++++++++++++++=0D=0A=C2=A03=C2=A0files=C2=A0changed,=C2=A0757=C2=
=A0insertions(+),=C2=A01=C2=A0deletion(-)=0D=0A=C2=A0create=C2=A0mode=C2=A0=
100644=C2=A0drivers/thermal/samsung/artpec8_tmu.c=0D=0A=C2=A0=0D=0A--=0D=0A=
2.9.5=0D=0A=C2=A0=0D=0A=C2=A0
