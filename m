Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA954E6EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358523AbiCYHRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358513AbiCYHRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:17:12 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30616C6EEC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:15:34 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220325071532epoutp04505142b59729b2c6607bc165710f4bf6~fjmAt6Djm2450524505epoutp04K
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 07:15:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220325071532epoutp04505142b59729b2c6607bc165710f4bf6~fjmAt6Djm2450524505epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648192532;
        bh=DrQ/XqfAqPKOeZP4otDlqik6Kn6HApn4g8RKqgPws2A=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=N9GUJ+LaDwneq/Okh83lbQkeZ4H1uF2yTTPyAVzic/aq1jkDVczdaA7Fdy/wzVbNR
         nAxWOPjrkeyseqbsGRxH9CI3mHlUxrs71PqhnZcHy3BvE3nDX8VVJJnSh+Ba++xhuz
         +hsRn+FXiBmgb5XuondPEUeiDlTLGSRWyT0CPQMM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220325071531epcas5p48b5ae3d2e9b423dc55ef63c1f61e4e8b~fjl-_ITuJ2667226672epcas5p40;
        Fri, 25 Mar 2022 07:15:31 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KPtf75g5qz4x9Q7; Fri, 25 Mar
        2022 07:15:27 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.7D.05590.D0C6D326; Fri, 25 Mar 2022 16:15:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220325071524epcas5p30470f46df0e678811efcddb0476ec6c1~fjl5NtlRW2668926689epcas5p3y;
        Fri, 25 Mar 2022 07:15:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220325071524epsmtrp12a2a3926db7fd279db2b5df40f55a1a7~fjl5MxPQw2367623676epsmtrp1B;
        Fri, 25 Mar 2022 07:15:24 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-57-623d6c0db7ab
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.AD.29871.C0C6D326; Fri, 25 Mar 2022 16:15:24 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220325071522epsmtip2b14063f84db13edb1813998459dd3c7d~fjl3E1rx91680916809epsmtip2i;
        Fri, 25 Mar 2022 07:15:21 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'SEO HOYOUNG'" <hy50.seo@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <avri.altman@wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <asutoshd@codeaurora.org>, <cang@codeaurora.org>,
        <bvanassche@acm.org>, <bhoon95.kim@samsung.com>,
        <kwmad.kim@samsung.com>
In-Reply-To: <20220324172113.192370-1-hy50.seo@samsung.com>
Subject: RE: [PATCH v1] scsi: ufs: unipro: add to define HS-Gear5 mode
Date:   Fri, 25 Mar 2022 12:45:20 +0530
Message-ID: <063f01d84018$1871e5e0$4955b1a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFnWDvKaMVANQKbUZJJE4NWseV9VgFQE2loAuwNqkqtj5108A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmli5vjm2SwZ6v0hZ7206wW7z8eZXN
        4uDDThaLr0ufsVpM+/CT2eLT+mWsFqsXP2CxWHRjG5PFzS1HWSwu75rDZtF9fQebxfLj/5gc
        eDwuX/H2uNzXy+QxYdEBRo/v6zvYPD4+vcXi0bdlFaPH501yHu0HupkCOKKybTJSE1NSixRS
        85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOArlVSKEvMKQUKBSQWFyvp
        29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGccWzOZreAYb0Xz
        n63MDYx/uLsYOTkkBEwkVtxYwtrFyMUhJLCbUaKzbTczhPOJUeLTzTlQzjdGiWcffzPDtOyf
        dgnMFhLYyyixsFENouglo8TLbR1MIAk2AV2JHYvb2EASIgJnmSRWT1zLDpLgFLCW6JvzgKWL
        kYNDWMBNYucdHZAwi4CqxOn/u8B6eQUsJR43tLJB2IISJ2c+YQGxmQW0JZYtfA11hILEz6fL
        WEFsEQEniW9zrkHViEu8PHqEHWSvhMABDon1v26wQDS4SJzZ/Y4dwhaWeHV8C5QtJfGyv40d
        5B4JAQ+JRX+kIMIZEm+Xr2eEsO0lDlyZA3Yys4CmxPpd+hCr+CR6fz9hgujklehoE4KoVpVo
        fncVaqm0xMTublYI20Ni651f0JBexijRdriXcQKjwiwkX85C8uUsJN/MQti8gJFlFaNkakFx
        bnpqsWmBcV5qOTy+k/NzNzGC07KW9w7GRw8+6B1iZOJgPMQowcGsJMJ7/7J1khBvSmJlVWpR
        fnxRaU5q8SFGU2DQT2SWEk3OB2aGvJJ4QxNLAxMzMzMTS2MzQyVx3lPpGxKFBNITS1KzU1ML
        Uotg+pg4OKUamDzXpZgYu53u8mmRXDIlNe7nNI26S07aZe/b1yUYcbzLVHo0b4l9tEDevNS0
        n3VpER8bTq8R2aCefthzfpm+39mTT7fFfz3JMJHj0EerqQ0/Xqmdy15QadC9027uxbfLF//q
        OG7Ff3LqIRFP183FhztaGdhnZsRFRvHnLAvPuffwaIK19xTHa7K5Ngb/3G/cuut36E5/1e1J
        /yeu2WHDlWl708GKdbvGuwL5kO9rJrxwS5A/s/KejMPaYH+RFTM/XZStXOnfwXjC8f7BnCqb
        efr/swoKTmXETs+7xviR+WPB5AzueM7WK/W1M3oElxyQZEpjexHEe+v1tMZ5x88I/fVfmCEq
        nd5o4BP3aDt3vxJLcUaioRZzUXEiAKhw+OtUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSvC5Pjm2SQe9KHou9bSfYLV7+vMpm
        cfBhJ4vF16XPWC2mffjJbPFp/TJWi9WLH7BYLLqxjcni5pajLBaXd81hs+i+voPNYvnxf0wO
        PB6Xr3h7XO7rZfKYsOgAo8f39R1sHh+f3mLx6NuyitHj8yY5j/YD3UwBHFFcNimpOZllqUX6
        dglcGV9Wf2AumM5TMW9pcQPjdK4uRk4OCQETif3TLjF3MXJxCAnsZpRo793FDpGQlri+cQKU
        LSyx8t9zdoii54wSTx/8YwFJsAnoSuxY3MYGYosI3GaSmHFOCMQWEljEKLHtWxCIzSlgLdE3
        5wFQPQeHsICbxM47OiBhFgFVidP/dzGB2LwClhKPG1rZIGxBiZMzn4CNZxbQlnh68ymcvWzh
        a2aIexQkfj5dxgqx1kni25xrUDXiEi+PHmGfwCg0C8moWUhGzUIyahaSlgWMLKsYJVMLinPT
        c4sNCwzzUsv1ihNzi0vz0vWS83M3MYIjUEtzB+P2VR/0DjEycTAeYpTgYFYS4b1/2TpJiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBiaLj3Grdgq2z/xa
        eufDs9wcrmq2xo35LfXWl0794f8d/+/XxqjZhV3pc3oNdVkCVvxeOCMs4rFBpXppn8EFkyP3
        mNx2Lb15uqut6YvmAv6S+cu0k2ykWU1lpgfNm9+i+D7+WfOLmx+9tuxsT8v9xdO2a8v8c/F9
        B948MP8Z3/Dcdk5U1uPfF/iCfj7Sm/1IOs0z/21LV1zihI+Fjpcqqqefd73yedZ2CavWbMnQ
        mFfL98cLtLY6rOmJvlBU8EK2QzrzTZNIb0Rl917eBcfYpIRZV2/7PulJcNje586yBV/Oc3Uu
        y5tz88mjDP8DQYd0OsOXH1zW8/9RQFfSIYEVZlfELJNqwrLe9tX/lObWPaDEUpyRaKjFXFSc
        CAC2QFRdLwMAAA==
X-CMS-MailID: 20220325071524epcas5p30470f46df0e678811efcddb0476ec6c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220325053615epcas2p25b140872340b4711d4fef4c5a4cb45f4
References: <sc.suh@samsung.com;>
        <CGME20220325053615epcas2p25b140872340b4711d4fef4c5a4cb45f4@epcas2p2.samsung.com>
        <20220324172113.192370-1-hy50.seo@samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: SEO HOYOUNG =5Bmailto:hy50.seo=40samsung.com=5D
>Sent: Thursday, March 24, 2022 10:51 PM
>To: linux-scsi=40vger.kernel.org; linux-kernel=40vger.kernel.org;
>alim.akhtar=40samsung.com; avri.altman=40wdc.com; jejb=40linux.ibm.com;
>martin.petersen=40oracle.com; beanhuo=40micron.com;
>asutoshd=40codeaurora.org; cang=40codeaurora.org; bvanassche=40acm.org;
>bhoon95.kim=40samsung.com; kwmad.kim=40samsung.com
>Cc: SEO HOYOUNG <hy50.seo=40samsung.com>
>Subject: =5BPATCH v1=5D scsi: ufs: unipro: add to define HS-Gear5 mode
>
>UFS devices support HS-Gear5 mode with UFS4.0 spec.
>However there is no definition of HS-Gear5.
>So added it in unipro header
>
>Change-Id: Id5475005000fe66b432ab76fa3364a8c12296f7c


Change-id should not be part of this, please run checkpatch to catch such t=
hings

>Signed-off-by: SEO HOYOUNG <hy50.seo=40samsung.com>
>---
> drivers/scsi/ufs/unipro.h =7C 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/scsi/ufs/unipro.h b/drivers/scsi/ufs/unipro.h index
>8e9e486a4f7b..0d2131e1f027 100644
>--- a/drivers/scsi/ufs/unipro.h
>+++ b/drivers/scsi/ufs/unipro.h
>=40=40 -231,6 +231,7 =40=40 enum ufs_hs_gear_tag =7B
> 	UFS_HS_G2,		/* HS Gear 2 */
> 	UFS_HS_G3,		/* HS Gear 3 */
> 	UFS_HS_G4,		/* HS Gear 4 */
>+	UFS_HS_G5,		/* HS Gear 5 */

I don=E2=80=99t=20have=20access=20to=20UFS4.0=20spec=20yet,=20so=20not=20su=
re=20if=20this=20is=20the=20only=20change=20required=20for=20UFS4.0=0D=0AWi=
thout=20having=20added=20support=20for=20UFS4.0,=20just=20updating=20HS=20g=
ear=20does=20not=20make=20much=20sense=0D=0A=0D=0A>=20=7D;=0D=0A=0D=0A>=0D=
=0A>=20enum=20ufs_unipro_ver=20=7B=0D=0A>--=0D=0A>2.26.0=0D=0A=0D=0A=0D=0A
