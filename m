Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDC24E3A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiCVIVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiCVIVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:21:04 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3D05BD3D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:19:35 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220322081931epoutp03762c28c4dfa08b7f9e2a52a82f5cc8d6~epiBO1EVT1446214462epoutp03R
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:19:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220322081931epoutp03762c28c4dfa08b7f9e2a52a82f5cc8d6~epiBO1EVT1446214462epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647937171;
        bh=HhEg8SeIzOQ+B0sMaC9D5JpzHmXS6nQ9Z/IoLLlUzo0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=UZwnrBJKH7n2qS4+spnZTA2KOb6E5ORtjJJh49fu7jmPac3GgSVvG1fMmFhMaCo4U
         1SVD9CZtedLwpzTDnbOxkG+uZDtmOgkXC6g/1oiYz4UA7g5L6XwqHRlbarLTqc2sLI
         /62xZB7cJmlcaHg/z9dWKpxwew/RGvq5IzQZQfpQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220322081930epcas2p290165808ac75eba01e3f09182d951db2~epiAgacJo1883518835epcas2p2a;
        Tue, 22 Mar 2022 08:19:30 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KN4CP2bHJz4x9Q2; Tue, 22 Mar
        2022 08:19:29 +0000 (GMT)
X-AuditID: b6c32a46-be9ff70000023ea8-c2-62398690f0c9
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.50.16040.09689326; Tue, 22 Mar 2022 17:19:28 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 1/2] dt-bindings: thermal: Add ARTPEC-8 compatible string
 for exynos-thermal
Reply-To: hypmean.kim@samsung.com
Sender: Sang Min Kim <hypmean.kim@samsung.com>
From:   Sang Min Kim <hypmean.kim@samsung.com>
To:     "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        ALIM AKHTAR <alim.akhtar@samsung.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220322075617.109855-1-hypmean.kim@samsung.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220322081928epcms2p5c426f8eebbc5251a294ab08ae869e487@epcms2p5>
Date:   Tue, 22 Mar 2022 17:19:28 +0900
X-CMS-MailID: 20220322081928epcms2p5c426f8eebbc5251a294ab08ae869e487
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmue6ENsskg3VnxSwezNvGZnF4foXF
        9y3XmSxeHtK0mPdZ1mL+kXOsFhvf/mCy2PT4GqvF5V1z2Cw+9x5htJhxfh+TxdwvU5ktWvce
        Ybd48rCPzYHPY1ZDL5vHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jbsorR4/MmuQCOqGyb
        jNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCjlRTKEnNK
        gUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGU++
        1RVcFqh4t28VUwPjbIEuRk4OCQETiaNTP7F3MXJxCAnsYJR4sfEYYxcjBwevgKDE3x3CIDXC
        AnESnefWsoPYQgKKEi93bGeGiOtJ3Nz4GSzOJqAj8bj1PhPIHBGBDmaJY53HWUEcZoGrTBLP
        589jh9jGKzGj/SkLhC0tsX35VrBlnAJ2Emv2hkCENSR+LOtlhrBFJW6ufssOY78/Np8RwhaR
        aL13FqpGUOLBz91QcUmJTYe3Q9VXS9zauBzsBgmBBkaJ1m9NzCC7JAT0JXZcNwap4RXwlVi4
        eh9YPYuAqsS9y7ugel0kLt9rAJvJLKAtsWzha7BWZgFNifW79CGmKEscucUC81TDxt/s6Gxm
        AT6JjsN/4eI75j1hgrBVJXZu6mafwKg8CxHQs5DsmoWwawEj8ypGsdSC4tz01GKjAiN41Cbn
        525iBKdeLbcdjFPeftA7xMjEwXiIUYKDWUmEd/EH8yQh3pTEyqrUovz4otKc1OJDjKZAX05k
        lhJNzgcm/7ySeEMTSwMTMzNDcyNTA3MlcV6vlA2JQgLpiSWp2ampBalFMH1MHJxSDUw7933c
        4eTrpHnkOC/P/Zuzrh/Q2r5ndWHpzBlrde264o2Dr7bdbHv8+UTR+vrrZ4o7YxbPv6/mtqtr
        XUHmpwev7rN4XFLz9BbQEuMK8zs0oaq39YMHB2v/g4Ji/5LzD95Nvbg9eWNbJ6+S4wzvx4k/
        onh7zhj1qHc4OR7tKrR9VmNT7X1iXmErvxzr0plOy+azLFP6e8Mmz0z99sFOk/ZPSZuPae6a
        F7rA2Pbkwr0ODeWiRa8C9q9p91EJyXYrVP5sd0ki8rSHaODXVd3zlheELtCIvzfvwgJl7wMb
        XRXiAtvV9/T1/l74o7CVV3vTyxNu/Wd97z6fsl6gcJtx18uU7pl9xecNpA9cqMv3MFZiKc5I
        NNRiLipOBACIUOEGRgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220322075557epcas2p26c9dcb578e9c5f68a23f7fe1bdf35f65
References: <20220322075617.109855-1-hypmean.kim@samsung.com>
        <CGME20220322075557epcas2p26c9dcb578e9c5f68a23f7fe1bdf35f65@epcms2p5>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend=C2=A0the=C2=A0exynos-thermal=C2=A0dt=C2=A0bindings=C2=A0document=C2=
=A0to=C2=A0include=C2=A0compatible=0D=0Astring=C2=A0supporting=C2=A0ARTPEC-=
8=C2=A0SoC=0D=0A=C2=A0=0D=0ASigned-off-by:=C2=A0sangmin=C2=A0kim=C2=A0<hypm=
ean.kim=40samsung.com>=0D=0A---=0D=0A=C2=A0Documentation/devicetree/binding=
s/thermal/samsung,exynos-thermal.yaml=C2=A0=7C=C2=A02=C2=A0++=0D=0A=C2=A01=
=C2=A0file=C2=A0changed,=C2=A02=C2=A0insertions(+)=0D=0A=C2=A0=0D=0Adiff=C2=
=A0--git=C2=A0a/Documentation/devicetree/bindings/thermal/samsung,exynos-th=
ermal.yaml=C2=A0b/Documentation/devicetree/bindings/thermal/samsung,exynos-=
thermal.yaml=0D=0Aindex=C2=A017129f7..c12bcff=C2=A0100644=0D=0A---=C2=A0a/D=
ocumentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml=0D=0A+=
++=C2=A0b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.=
yaml=0D=0A=40=40=C2=A0-16,6=C2=A0+16,7=C2=A0=40=40=C2=A0description:=C2=A0=
=7C=0D=0A=C2=A0properties:=0D=0A=C2=A0=C2=A0=C2=A0compatible:=0D=0A=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0enum:=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=
=C2=A0axis,artpec8-tmu=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=
=A0samsung,exynos3250-tmu=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=
=C2=A0samsung,exynos4412-tmu=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0-=C2=A0samsung,exynos4210-tmu=0D=0A=40=40=C2=A0-101,6=C2=A0+102,7=C2=A0=
=40=40=C2=A0allOf:=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0compatible:=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0contains:=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum:=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0axis,artpec8-tmu=
=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0-=C2=A0samsung,exynos5433-tmu=0D=0A=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=
=C2=A0samsung,exynos7-tmu=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0then:=0D=0A--=
=C2=A0=0D=0A2.9.5=0D=0A=C2=A0=0D=0A=C2=A0
