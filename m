Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929FF4D3F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbiCJB6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239163AbiCJB6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:58:46 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86D2C643
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:57:45 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220310015743epoutp0286d036b852ad76a1f4640702f93a0d32~a4lPgaVdZ1921919219epoutp02P
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:57:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220310015743epoutp0286d036b852ad76a1f4640702f93a0d32~a4lPgaVdZ1921919219epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646877463;
        bh=5r8Zg/zS4DB8Mv0tU3jraWcXrgqJydLtj9j0Wc7geKM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=DnVN6IVVCDqfBEP2dNHErzaXbFRJXvV8TgHEFSxsV+alkSR4Q+p0aLokXVbBVsFVf
         R7N2CliRCx1A1uJW4npps8fhLW+LQGafMiVH6/Bhd2AcQHc233pHWTOd2cgFMUJDp1
         Uyi3RfoaXAf8rVho/73OU6xrRk4wEbYHE0mvdtI8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220310015743epcas2p46a6dda3c8d452af6a65c6cab48fc1a2e~a4lPAceJI0792907929epcas2p4T;
        Thu, 10 Mar 2022 01:57:43 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KDXJN2K4Fz4x9Pr; Thu, 10 Mar
        2022 01:57:40 +0000 (GMT)
X-AuditID: b6c32a47-81bff700000063c4-f3-62295b149435
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.64.25540.41B59226; Thu, 10 Mar 2022 10:57:40 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 3/3] thermal: samsung: Update makefile for artpec8
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
In-Reply-To: <20220310013140.127026-4-hypmean.kim@samsung.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220310015740epcms2p2cdbcbb6ee6065293c2d6064de1b8d87a@epcms2p2>
Date:   Thu, 10 Mar 2022 10:57:40 +0900
X-CMS-MailID: 20220310015740epcms2p2cdbcbb6ee6065293c2d6064de1b8d87a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmha5ItGaSwfpTfBaH51dYfN9yncni
        5SFNi3mfZS02vv3BZHF51xw2i8+9RxgtZpzfx2Qx98tUZosnD/vYHLg8ZjX0snnsnHWX3WPx
        npdMHptWdbJ53Lm2h82jb8sqRo/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
        dQ0tLcyVFPISc1NtlVx8AnTdMnOAjlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
        FJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfc2HadveA/d8XhO1vZGhivc3cxcnJICJhILFm/
        g7WLkYtDSGAHo8T2tuNMXYwcHLwCghJ/dwiD1AgLOEn86ljBBmILCShKvNyxnRkiridxc+Nn
        dhCbTUBH4nHrfSaQOSICW5gkfky7ygqSYBY4yijRPCsVYhmvxIz2pywQtrTE9uVbGUFsTgE7
        iZv/+tkh4hoSP5b1MkPYohI3V79lh7HfH5vPCGGLSLTeOwtVIyjx4OduqLikxKbD26HqqyVu
        bVwO9piEQAOjROu3JmaQxyQE9CV2XDcGqeEV8JX4ee0f2D0sAqoSk3YtgOp1kZjWcp4R4n5t
        iWULX4O1MgtoSqzfpQ8xRVniyC0WmK8aNv5mR2czC/BJdBz+CxffMe8JE4StKrFzUzf7BEbl
        WYiAnoVk1yyEXQsYmVcxiqUWFOempxYbFRjD4zY5P3cTIziZarnvYJzx9oPeIUYmDsZDjBIc
        zEoivE2hGklCvCmJlVWpRfnxRaU5qcWHGE2BvpzILCWanA9M53kl8YYmlgYmZmaG5kamBuZK
        4rxeKRsShQTSE0tSs1NTC1KLYPqYODilGpjEbr7zvbgwWiXsa/ie9/33juX2zs7fc+7pv5/b
        jFfPb/hQ6ul250bVNedZC3v9tF0iehT72EK2hD0pmJO8hcNeaEat54Q1T80v7bvE+cnv7YWV
        5yLzWy+W6Mo8jI1w2b5OLvU9Y+GT+mSro9fXrL4zIyMj12PnwyOpcWV32W+l8fy6+Wrm6rcd
        14P81/ium/5RXHw6W6ZVr4dPvohHuNoPW5P1W23dw71iLhmV8f72bUmfUKf7ncniFudlmYWC
        vL09DilnnrR8yp0W3c0aKZPewVv5YFtpM2/NxCNfZN8JKlnvkpun9PDVpIfmkq9lWeYejOnI
        mdi4NUHY5gib4aOkyWk7t8UIuYr8EvrTdV+JpTgj0VCLuag4EQDkCaC/LwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220310013131epcas3p15a109ec7208b1442676e3c50d5b4b936
References: <20220310013140.127026-4-hypmean.kim@samsung.com>
        <20220310013140.127026-1-hypmean.kim@samsung.com>
        <CGME20220310013131epcas3p15a109ec7208b1442676e3c50d5b4b936@epcms2p2>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C2=A0=0D=0AAdd=C2=A0makefile=C2=A0changes=C2=A0for=C2=A0axis=C2=A0artpec8=
=C2=A0driver.=0D=0A=C2=A0=0D=0ASigned-off-by:=C2=A0sangmin=C2=A0kim=C2=A0<h=
ypmean.kim=40samsung.com>=0D=0A---=0D=0A=C2=A0drivers/thermal/samsung/Makef=
ile=C2=A0=7C=C2=A02=C2=A0+-=0D=0A=C2=A01=C2=A0file=C2=A0changed,=C2=A01=C2=
=A0insertion(+),=C2=A01=C2=A0deletion(-)=0D=0A=C2=A0=0D=0Adiff=C2=A0--git=
=C2=A0a/drivers/thermal/samsung/Makefile=C2=A0b/drivers/thermal/samsung/Mak=
efile=0D=0Aindex=C2=A0f139407..c9e9a33=C2=A0100644=0D=0A---=C2=A0a/drivers/=
thermal/samsung/Makefile=0D=0A+++=C2=A0b/drivers/thermal/samsung/Makefile=
=0D=0A=40=40=C2=A0-3,4=C2=A0+3,4=C2=A0=40=40=0D=0A=C2=A0=23=C2=A0Samsung=C2=
=A0thermal=C2=A0specific=C2=A0Makefile=0D=0A=C2=A0=23=0D=0A=C2=A0obj-=24(CO=
NFIG_EXYNOS_THERMAL)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0+=3D=C2=A0exynos_thermal.o=0D=0A-exynos_thermal-y=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0:=3D=C2=A0exynos_tmu.o=0D=0A+exynos_therma=
l-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0:=3D=C2=A0artpec8_tmu.o=C2=A0e=
xynos_tmu.o=0D=0A--=C2=A0=0D=0A2.9.5=0D=0A=C2=A0=0D=0A=C2=A0
