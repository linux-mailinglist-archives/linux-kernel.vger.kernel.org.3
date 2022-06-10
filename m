Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC85461AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348909AbiFJJTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348802AbiFJJQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:16:52 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D512941FC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:15:42 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220610091539epoutp03aa383cfe617f8116357a951e9fcb2155~3N54JfGzl2993429934epoutp039
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:15:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220610091539epoutp03aa383cfe617f8116357a951e9fcb2155~3N54JfGzl2993429934epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654852540;
        bh=2FdCcOvk+HdVpSxZ0InqM+kcA8EdmyNbz9rzupjd/j4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=QTeS+9O87Pn0VpZ1B5EIJDAKq6A7fhppHqAC+cMIVm502KsJ64RYPSwWhfJBhCa8o
         50Abx+ENO1GW1eAuKJa3VqlZLN+SXrEPyBru+mkqIybj4Wzr5e1BLRww2T22jSc/Vc
         hv8vvDl60aw1zCQEpYKvK9S7NZGe5m9FCq6abpa8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220610091539epcas5p13bfafd80673265b52898150b83584bde~3N53hfFHH0358803588epcas5p1R;
        Fri, 10 Jun 2022 09:15:39 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LKFgD3ZFJz4x9Q5; Fri, 10 Jun
        2022 09:15:36 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.62.09827.7BB03A26; Fri, 10 Jun 2022 18:15:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220610091534epcas5p133ae385d5ffd1222818b749fc8126800~3N5zLocul0358803588epcas5p1J;
        Fri, 10 Jun 2022 09:15:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220610091534epsmtrp19fcfa0c190b89665b064e7c08592e67e~3N5zK8Q_P2520525205epsmtrp1J;
        Fri, 10 Jun 2022 09:15:34 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-b8-62a30bb7d326
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.1B.11276.6BB03A26; Fri, 10 Jun 2022 18:15:34 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220610091533epsmtip197f2e6e8d505e19a25c9791956b356b6~3N5yHwPwz2970429704epsmtip1w;
        Fri, 10 Jun 2022 09:15:33 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Cc:     <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <chanho61.park@samsung.com>, <pankaj.dubey@samsung.com>
In-Reply-To: <20220610070547.71193-1-alim.akhtar@samsung.com>
Subject: RE: [PATCH -next] phy: samsung-ufs: fix NULL pointer dereference
Date:   Fri, 10 Jun 2022 14:45:32 +0530
Message-ID: <000501d87caa$a3ebe520$ebc3af60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJNUr2mveM3EJGNpu0kIdNV5dOukgIPmyx5rE4yYKA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmpu527sVJBivX8Fpc3q9t0ffiIbPF
        5V1z2CwmrPrGYrFo6xd2i513TjA7sHlsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6ANSrbJiM1
        MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdov5JCWWJOKVAo
        ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2Pe/h72
        glWSFRevPmVrYGwU62Lk5JAQMJFYuGkKcxcjF4eQwG5Gid0v+qGcT4wSz2/2skA43xglWpd3
        MMO03N5ylB0isZdR4v+7M1BVLxkl/n58xgJSxSagK7FjcRsbiC0i4Czx7flMIJuDg1mgTOLO
        5XqQMKeArcSNzk/sILawgKfEinf3wGwWAVWJ/5f+MYHYvAKWEheuPmWBsAUlTs58AmYzC2hL
        LFv4GuogBYmfT5exQqyykniydBU7RI24xMujR8AOlRBo5ZBYOhemwUVi8sXtbBC2sMSr41vY
        IWwpiZf9bewgd0oIeEgs+iMFEc6QeLt8PSOEbS9x4MocFohXNCXW79KHWMUn0fv7CRNEJ69E
        R5sQRLWqRPO7qywQtrTExO5uVpjht+ZGTmBUnIXkr1lI/pqF5P5ZCLsWMLKsYpRMLSjOTU8t
        Ni0wyksth8d2cn7uJkZw2tTy2sH48MEHvUOMTByMhxglOJiVRHgDbi9KEuJNSaysSi3Kjy8q
        zUktPsRoCgzsicxSosn5wMSdVxJvaGJpYGJmZmZiaWxmqCTOK/C/MUlIID2xJDU7NbUgtQim
        j4mDU6qBaf72xU8tvQzWZG0N3JfUH/as+970f3rf3705X/LMoL2e5/mziKxbrRMrz659lC/C
        ukQo0tt18q5b9xOv7UsUaHovOD/yVplPveyVRN0b0TVM2Tbd76KW802e/XvltRMvPr/lZp21
        aWbJhRSTynXT8q8ev5l606VpRdnzCXbZWZvmtkja3fzPrF5oFPrP6yrTDZ/pU9dtjuU5cMdA
        mK9N/7aceYsdz+y67+/fvWbfbSE0/b+NUmKcUK/l1ajpppfuzI6p7lLgLJp0vjvuAE++V1SC
        zmkn1W/a3NX7Ko/eeui5+0zKMXUH4Zt7Dd8H7Nvpkf+tOzJl9g2V8w5bsudMciwqbTsxaU8/
        A4vSNKnt35VYijMSDbWYi4oTAby76PYkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnO427sVJBo9+Kllc3q9t0ffiIbPF
        5V1z2CwmrPrGYrFo6xd2i513TjA7sHlsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6ANYrLJiU1
        J7MstUjfLoEr4+GEbraC4xIVC1Y9YWtgXCDaxcjJISFgInF7y1H2LkYuDiGB3YwSb6+9YIJI
        SEtc3ziBHcIWllj57zlU0XNGie8n7jGCJNgEdCV2LG5jA7FFBFwllky9DRZnFqiSeDCrB6xZ
        SKCPUeLJyTIQm1PAVuJG5yewuLCAp8SKd/fAbBYBVYn/l/6BLeYVsJS4cPUpC4QtKHFy5hMW
        iJnaEr0PWxlh7GULXzNDHKcg8fPpMlaIG6wknixdxQ5RIy7x8ugR9gmMwrOQjJqFZNQsJKNm
        IWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOIK0NHcwbl/1Qe8QIxMH4yFG
        CQ5mJRHegNuLkoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLg
        lGpg6ilbsLQkNs6See7HHx/aTkhYXqnJ3lyiHtr9ZMJXBSMDk7aG2FhW0+vnF4Xfr7q7579y
        bue/Tc4rtr5h+qFrUO/0T+K2hCnbZu/eOIX9h0sPWbkU/udiPPFx1++TJfVL3UTOTz4VM+vn
        IueQyb7pn7mcZtavtu2ucHV3PTohpTLKiru5ee2JpZPOvF8iz3MntP6i8zZ9A9ZNLTev7HuV
        4ivwYf2UTivfE3m2S6u90vK+vU3K7t1psMul8GzvJy92xzUcAUUFb5+7W6X5MbEWOKxdma70
        +t1zBzcNnvBnK9bNyFSdo2KfI+V08nLVoxkFJtGOUa+5lOa8117t9PyuZe6GO7nurVsda1m2
        Mr1SYinOSDTUYi4qTgQA4GqBUA8DAAA=
X-CMS-MailID: 20220610091534epcas5p133ae385d5ffd1222818b749fc8126800
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610070811epcas5p3c62ef9ad9c82092deac59ff9be896677
References: <CGME20220610070811epcas5p3c62ef9ad9c82092deac59ff9be896677@epcas5p3.samsung.com>
        <20220610070547.71193-1-alim.akhtar@samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the noise.

Please ignore this patch

>-----Original Message-----
>From: Alim Akhtar =5Bmailto:alim.akhtar=40samsung.com=5D
>Sent: Friday, June 10, 2022 12:36 PM
>To: linux-kernel=40vger.kernel.org; linux-phy=40lists.infradead.org
>Cc: krzysztof.kozlowski+dt=40linaro.org; vkoul=40kernel.org;
>chanho61.park=40samsung.com; pankaj.dubey=40samsung.com; Alim Akhtar
><alim.akhtar=40samsung.com>
>Subject: =5BPATCH -next=5D phy: samsung-ufs: fix NULL pointer dereference
>
>commit f86c1d0a58b1f63a (=22phy: samsung: ufs: remove drvdata from struct
>samsung_ufs_phy=22)
>
>removes _drvdata_ initialization which resulting in NULL pointer
>dereferencing in samsung_ufs_phy_wait_for_lock_acq(). Fix this by initiali=
zing
>drvdata.
>
>The said commit also duplicate =22has_symbol_clk=22 both in drvdata struct=
 and in
>samsung_ufs_phy struct, let's go back and use only one =22has_symbol_clk=
=22.
>
>Fixes: f86c1d0a58b1 phy: samsung: ufs: remove drvdata from struct
>samsung_ufs_phy
>Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>---
> drivers/phy/samsung/phy-samsung-ufs.c =7C 6 +++---
>drivers/phy/samsung/phy-samsung-ufs.h =7C 1 -
> 2 files changed, 3 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/phy/samsung/phy-samsung-ufs.c
>b/drivers/phy/samsung/phy-samsung-ufs.c
>index 206a79c69a6c..6708877b20d7 100644
>--- a/drivers/phy/samsung/phy-samsung-ufs.c
>+++ b/drivers/phy/samsung/phy-samsung-ufs.c
>=40=40 -207,7 +207,7 =40=40 static int samsung_ufs_phy_init(struct phy *ph=
y)
> 	ss_phy->lane_cnt =3D phy->attrs.bus_width;
> 	ss_phy->ufs_phy_state =3D CFG_PRE_INIT;
>
>-	if (ss_phy->has_symbol_clk) =7B
>+	if (ss_phy->drvdata->has_symbol_clk) =7B
> 		ret =3D samsung_ufs_phy_symbol_clk_init(ss_phy);
> 		if (ret)
> 			dev_err(ss_phy->dev, =22failed to set ufs phy symbol
>clocks=5Cn=22); =40=40 -259,7 +259,7 =40=40 static int samsung_ufs_phy_exi=
t(struct phy
>*phy)
>
> 	clk_disable_unprepare(ss_phy->ref_clk);
>
>-	if (ss_phy->has_symbol_clk) =7B
>+	if (ss_phy->drvdata->has_symbol_clk) =7B
> 		clk_disable_unprepare(ss_phy->tx0_symbol_clk);
> 		clk_disable_unprepare(ss_phy->rx0_symbol_clk);
> 		clk_disable_unprepare(ss_phy->rx1_symbol_clk);
>=40=40 -327,8 +327,8 =40=40 static int samsung_ufs_phy_probe(struct
>platform_device *pdev)
>
> 	drvdata =3D match->data;
> 	phy->dev =3D dev;
>+	phy->drvdata =3D drvdata;
> 	phy->cfgs =3D drvdata->cfgs;
>-	phy->has_symbol_clk =3D drvdata->has_symbol_clk;
> 	memcpy(&phy->isol, &drvdata->isol, sizeof(phy->isol));
>
> 	if (=21of_property_read_u32_index(dev->of_node, =22samsung,pmu-
>syscon=22, 1, diff --git a/drivers/phy/samsung/phy-samsung-ufs.h
>b/drivers/phy/samsung/phy-samsung-ufs.h
>index 854b53bdf347..b9144586daf5 100644
>--- a/drivers/phy/samsung/phy-samsung-ufs.h
>+++ b/drivers/phy/samsung/phy-samsung-ufs.h
>=40=40 -125,7 +125,6 =40=40 struct samsung_ufs_phy =7B
> 	const struct samsung_ufs_phy_drvdata *drvdata;
> 	const struct samsung_ufs_phy_cfg * const *cfgs;
> 	struct samsung_ufs_phy_pmu_isol isol;
>-	bool has_symbol_clk;
> 	u8 lane_cnt;
> 	int ufs_phy_state;
> 	enum phy_mode mode;
>
>base-commit: ff539ac73ea559a8c146d99ab14bfcaddd30547a
>--
>2.25.1


