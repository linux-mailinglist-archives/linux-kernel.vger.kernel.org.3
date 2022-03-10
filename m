Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2105B4D3F10
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiCJB6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbiCJB6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:58:02 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215C7128652
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:57:02 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220310015700epoutp0497de64c2fe5a70b204a75f7ec35aeefe~a4knUU1Bf0302803028epoutp04T
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:57:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220310015700epoutp0497de64c2fe5a70b204a75f7ec35aeefe~a4knUU1Bf0302803028epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646877420;
        bh=n0nq2hT5YQjdXZiO2MklIr8nwN5ICedzqM/c2JbrBVY=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=fcf2bt7Jz/qm8EU4Mf0LkbYpSPPf9FkawafzM7g4APRqXP9l1I3X6I8rcQLzmcErX
         sguzHpto7eBPk8cG0TMGETQcAefjAxQEnA5wwuDVhCWDLGAaTsacqivZNrbC1AtPgA
         +RnY9ZdyhdteoaTIiJyL1l/4HmRzyQBR9EYXfBxQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220310015659epcas2p3a92a5b91e90412f864fdacce6fb63fa0~a4kmiXq9v1396213962epcas2p3S;
        Thu, 10 Mar 2022 01:56:59 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.70]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KDXHY4x29z4x9Q1; Thu, 10 Mar
        2022 01:56:57 +0000 (GMT)
X-AuditID: b6c32a48-4fbff7000000810c-82-62295ae8a407
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.CC.33036.8EA59226; Thu, 10 Mar 2022 10:56:56 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 1/3] dt-bindings: thermal: Add artpec8 compatible string for
 exynos-thermal
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
Message-ID: <20220310015655epcms2p843397a4c9e6707f1e862b2d00751d8f6@epcms2p8>
Date:   Thu, 10 Mar 2022 10:56:55 +0900
X-CMS-MailID: 20220310015655epcms2p843397a4c9e6707f1e862b2d00751d8f6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmhe6LKM0kg/5bfBaH51dYfN9yncni
        5SFNi3mfZS02vv3BZHF51xw2i8+9RxgtZpzfx2Qx98tUZosnD/vYHLg8ZjX0snnsnHWX3WPx
        npdMHptWdbJ53Lm2h82jb8sqRo/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
        dQ0tLcyVFPISc1NtlVx8AnTdMnOAjlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
        FJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGcsOHKEueC+QMXSC9+YGhiXC3QxcnJICJhITF++
        hRXEFhLYwSjxsyemi5GDg1dAUOLvDmEQU1ggVuL1dC+ICkWJlzu2M4PYwgJ6Ejc3fmYHsdkE
        dCQet95n6mLk4hAR2MIk8WPaVbCRzAJHGSWaZ6VCrOKVmNH+lAXClpbYvnwrI4StIfFjWS8z
        hC0qcXP1W3YY+/2x+VA1IhKt985C1QhKPPi5GyouKbHp8Hao+mqJWxuXs4IcISHQwCjR+q2J
        GeQBCQF9iR3XjUFqeAV8JR7++8cEYrMIqEr8+HaQDaLERaJ5Yx3EydoSyxa+ButkFtCUWL9L
        H6JCWeLILRaYRxo2/mZHZzML8El0HP4LF98x7wkThK0qsXNTNzvEGGmJr3OrJzAqzUKE8iwk
        a2chrF3AyLyKUSy1oDg3PbXYqMAEHq/J+bmbGMFJVMtjB+Pstx/0DjEycTAeYpTgYFYS4W0K
        1UgS4k1JrKxKLcqPLyrNSS0+xGgK9O9EZinR5HxgGs8riTc0sTQwMTMzNDcyNTBXEuf1StmQ
        KCSQnliSmp2aWpBaBNPHxMEp1cC081yw+u9y/02/Yy60mnI+iTjPuyzcdbtKi8Zq2Rfz873f
        BzYWXru+wThIZCaDLGvdhoqetS3SHZPuGjMHTyrY2V3Bpm6jsSR7qtbN4+G2jM9XzzxfviAi
        IFZgge5S1W2NbfYzOuIjP2gV7JWc7Lc39ugdf4dZwW3TQ0vCzNf2Jp0RuaGtL7Pi9eKGs/Nq
        7q/dxu7G1mFuLr13qkbOHv9UBhf/4M/rOwsYWmpebpp+ZHbNSZ7NVlqqkfemH5VfU+Dhy7SI
        3ebB58zORde2tydvbd726Uuq2a/b9+P7jso0NvFlPDDtSkt/NFtxWZ/Knnlu834vnaaV1K22
        JOeowtpFcm86fU4e803Y6BDF/VSJpTgj0VCLuag4EQBq1k8aKwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220310013129epcas3p1110cbdfbd3d72ade45b8d98433ca0aac
References: <CGME20220310013129epcas3p1110cbdfbd3d72ade45b8d98433ca0aac@epcms2p8>
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

=C2=A0=0D=0AExtend=C2=A0the=C2=A0exynos-thermal=C2=A0dt=C2=A0bindings=C2=A0=
document=C2=A0to=C2=A0include=C2=A0compatible=0D=0Astring=C2=A0supporting=
=C2=A0artpec8=C2=A0SoC.=0D=0A=C2=A0=0D=0ASigned-off-by:=C2=A0sangmin=C2=A0k=
im=C2=A0<hypmean.kim=40samsung.com>=0D=0A---=0D=0A=C2=A0Documentation/devic=
etree/bindings/thermal/samsung,exynos-thermal.yaml=C2=A0=7C=C2=A02=C2=A0++=
=0D=0A=C2=A01=C2=A0file=C2=A0changed,=C2=A02=C2=A0insertions(+)=0D=0A=C2=A0=
=0D=0Adiff=C2=A0--git=C2=A0a/Documentation/devicetree/bindings/thermal/sams=
ung,exynos-thermal.yaml=C2=A0b/Documentation/devicetree/bindings/thermal/sa=
msung,exynos-thermal.yaml=0D=0Aindex=C2=A017129f7..c12bcff=C2=A0100644=0D=
=0A---=C2=A0a/Documentation/devicetree/bindings/thermal/samsung,exynos-ther=
mal.yaml=0D=0A+++=C2=A0b/Documentation/devicetree/bindings/thermal/samsung,=
exynos-thermal.yaml=0D=0A=40=40=C2=A0-16,6=C2=A0+16,7=C2=A0=40=40=C2=A0desc=
ription:=C2=A0=7C=0D=0A=C2=A0properties:=0D=0A=C2=A0=C2=A0=C2=A0compatible:=
=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum:=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0-=C2=A0axis,artpec8-tmu=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0-=C2=A0samsung,exynos3250-tmu=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0-=C2=A0samsung,exynos4412-tmu=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0-=C2=A0samsung,exynos4210-tmu=0D=0A=40=40=C2=A0-101,6=C2=A0+102=
,7=C2=A0=40=40=C2=A0allOf:=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0compatible:=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0contains:=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum:=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0axis,art=
pec8-tmu=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0samsung,exynos5433-tmu=0D=0A=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0-=C2=A0samsung,exynos7-tmu=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0then:=
=0D=0A--=C2=A0=0D=0A2.9.5=0D=0A=C2=A0=0D=0A=C2=A0
