Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D16D538C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244542AbiEaHhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiEaHh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:37:27 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E8926AD3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:37:26 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220531073720epoutp02e73a6ca59c1911c7a6f399eee381f182~0IHLGX9PO2074420744epoutp02G
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:37:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220531073720epoutp02e73a6ca59c1911c7a6f399eee381f182~0IHLGX9PO2074420744epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653982640;
        bh=mSG4SRps0dzzOXpIJuEmtx59pBt9ay4W1NpocBn3UAI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DxcFzAFAG0FqUY3/jjCK4ZnP2Q7n7C/WiUWnBKSgYAQqCN5NR7qygTBgMueY6Ei9G
         3bKZgoxfd/eI88MWyWSdtPCiHocSYUcG5IKKTBDkXE6ojjSzbJdp2dOUFlDKvo0goD
         wDpXVWUa2S7vtQYJiRj4vBMn1zjZZ9h/iCyroLQY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220531073719epcas2p218a08a6703c9f22ee285214f6470ac57~0IHKbYwzG2219922199epcas2p2c;
        Tue, 31 May 2022 07:37:19 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LC3yP1rkdz4x9QG; Tue, 31 May
        2022 07:37:17 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.09.10069.8A5C5926; Tue, 31 May 2022 16:37:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220531073711epcas2p31d3d49dd8db03e7ff9f48e16ccf112f8~0IHDGrJvw2250122501epcas2p3R;
        Tue, 31 May 2022 07:37:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220531073711epsmtrp25bdbbb1fef8971f793459d6525472ed2~0IHDFnO9w1812818128epsmtrp2U;
        Tue, 31 May 2022 07:37:11 +0000 (GMT)
X-AuditID: b6c32a45-2a50fa8000002755-2b-6295c5a81bec
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.D9.11276.7A5C5926; Tue, 31 May 2022 16:37:11 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220531073711epsmtip12e5ef4f762ee298b5bf3ec1110b9b11d~0IHC1bgEj1610816108epsmtip1h;
        Tue, 31 May 2022 07:37:11 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Cc:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <martin.petersen@oracle.com>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, "'Bharat Uppal'" <bharat.uppal@samsung.com>
In-Reply-To: <20220531012220.80563-6-alim.akhtar@samsung.com>
Subject: RE: [PATCH 5/6] ufs: host: ufs-exynos: add support for fsd ufs hci
Date:   Tue, 31 May 2022 16:37:11 +0900
Message-ID: <001101d874c1$3d850eb0$b88f2c10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEGJiXAXdobboEKZTBkhZkj5AOCHwHAGN/eAYoUDxmuwuGnsA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmhe6Ko1OTDP5PkrZ4MG8bm8XLn1fZ
        LK69vMBuMe3DT2aL+UfOsVr0vXjIbLHp8TVWi4evwi0u75rDZjFh1TcWi+7rO9gslh//x2Sx
        aOsXdovWvUfYLXbeOcHswO9x+Yq3x6ZVnWwed67tYfPYvKTe4+PTWywefVtWMXr8a5rL7vF5
        k5xH+4FupgDOqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58A
        XbfMHKD7lRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVW
        hgYGRqZAhQnZGUe+/mUq2OFS0dSykrWBcbZFFyMnh4SAicSna1dZuhi5OIQEdjBKnNi9kQnC
        +cQosXLjDGYI5xujRG/vARaYlrWvfrBDJPYySrT/ngHlvGCUWHGojw2kik1AX+JlxzZWkIQI
        yODPKz6BbWEWWMQk0XTpG1gVp4CtxNP7S1hBbGEBb4nuGV+ZQWwWAVWJ09P2gtm8ApYSF2aA
        rACxBSVOznwCdgezgLbEsoWvmSFuUpD4+XQZ2BwRASeJvqm7WSFqRCRmd7aBPSEh8IJD4szW
        p1BPuEg82jiBHcIWlnh1fAuULSXx+d1eNgi7WGLprE9MEM0NjBKXt/2CShhLzHrWztjFyAG0
        QVNi/S59EFNCQFniyC2o2/gkOg7/ZYcI80p0tAlBNKpLHNg+HeoCWYnuOZ9ZJzAqzULy2Swk
        n81C8sEshF0LGFlWMYqlFhTnpqcWGxUYwuM7OT93EyM4dWu57mCc/PaD3iFGJg7GQ4wSHMxK
        Irwlu6YmCfGmJFZWpRblxxeV5qQWH2I0BYb1RGYp0eR8YPbIK4k3NLE0MDEzMzQ3MjUwVxLn
        9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXAtCL26Kl/6WYV1wwNalNvZ2+IEml0ldVmqJz8LGDW
        C/aIAO0ftSJdup2vxU3veBRGqPvtncWvc/eo0Lcg49Rd6ivctrzVsHq86UhI5sKsDXK2pytP
        S5qzPr288/S8DZMPXpDYWL9oQ/CxqDOasdfaC8v3HVrjb6gicfWouVKqvW6OhPx/Vjsj3mdS
        HqoVa015qq6d7+Tv4XqkkLw4X1l37pE5C+oVa+adlnjuwbG+3/ON7PwrHxoL+Qo47Et4l602
        rLQ6rycW5zv9+9LIpCk7VvuU7em5m8M7S3G58OUbP30Sd6W+zDtsxfD/2tkpp5otTGqDU2cy
        Xbv99X7ypCvSV6sbPV41B73U/CZ4i9lDiaU4I9FQi7moOBEAyYPxZGYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSnO7yo1OTDA606Fo8mLeNzeLlz6ts
        FtdeXmC3mPbhJ7PF/CPnWC36Xjxkttj0+BqrxcNX4RaXd81hs5iw6huLRff1HWwWy4//Y7JY
        tPULu0Xr3iPsFjvvnGB24Pe4fMXbY9OqTjaPO9f2sHlsXlLv8fHpLRaPvi2rGD3+Nc1l9/i8
        Sc6j/UA3UwBnFJdNSmpOZllqkb5dAlfGqYMXmQteO1WsP3yPrYHxjFkXIyeHhICJxNpXP9i7
        GLk4hAR2M0qsmv+SGSIhK/Hs3Q52CFtY4n7LEVaIomeMEudfv2EFSbAJ6Eu87NgGlhAR2MMo
        0TbvFNgoZoE1TBI3J19lhmjZzyhxrb8BbBangK3E0/tLwNqFBbwlumd8BdvHIqAqcXraXjCb
        V8BS4sKMGewQtqDEyZlPWEBsZgFtid6HrYww9rKFr6FuVZD4+XQZ2EwRASeJvqm7WSFqRCRm
        d7YxT2AUnoVk1Cwko2YhGTULScsCRpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB
        cayluYNx+6oPeocYmTgYDzFKcDArifCW7JqaJMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJ
        eCGB9MSS1OzU1ILUIpgsEwenVAPTcv0OXVe3zidVb7k2T6tWq8y5mfv7OEeeTi3ne4UErVp3
        13V8e/ymPIl1LFlwp0xk9896raJJC51mtsy8zmkw1WZ2Z0mn6tm7E7/OSmiqqtuZphy6dFHi
        KRvfvJ3nN0/6Zr1A4NW8377BMZKBTcd8Hpo/FeuYZCC1wexSsV/HnSdmd/v3sxSKWVbNj5/u
        GnNP4KTgpNe9PaFLTGX/L5l9snD7K7+mj2vl1l1aEF6e0tpmZvP/MIuOmtmzF6Yi66N0NBun
        /LjaPNv6zuTa1onvTgX3rL+mIHPqWZF9e4le1cPbXs/Ppi9fU1p0ttPiis4Zuzurz2k/mfh/
        hr2l8mOtM7ua1frOz0+72aeePe+IEktxRqKhFnNRcSIAa2+VF1IDAAA=
X-CMS-MailID: 20220531073711epcas2p31d3d49dd8db03e7ff9f48e16ccf112f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220531012356epcas5p3cd6638d4d3eccb28a28d064c9f585a4f
References: <20220531012220.80563-1-alim.akhtar@samsung.com>
        <CGME20220531012356epcas5p3cd6638d4d3eccb28a28d064c9f585a4f@epcas5p3.samsung.com>
        <20220531012220.80563-6-alim.akhtar@samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Alim Akhtar <alim.akhtar=40samsung.com>
> Sent: Tuesday, May 31, 2022 10:22 AM
> To: linux-arm-kernel=40lists.infradead.org; linux-kernel=40vger.kernel.or=
g;
> linux-scsi=40vger.kernel.org; linux-phy=40lists.infradead.org
> Cc: devicetree=40vger.kernel.org; robh+dt=40kernel.org;
> krzysztof.kozlowski+dt=40linaro.org; vkoul=40kernel.org; avri.altman=40wd=
c.com;
> bvanassche=40acm.org; martin.petersen=40oracle.com; chanho61.park=40samsu=
ng.com;
> pankaj.dubey=40samsung.com; Alim Akhtar <alim.akhtar=40samsung.com>; linu=
x-
> fsd=40tesla.com; Bharat Uppal <bharat.uppal=40samsung.com>
> Subject: =5BPATCH 5/6=5D ufs: host: ufs-exynos: add support for fsd ufs h=
ci
>=20
> Adds support of UFS HCI which is found in Tesla FSD SoC. FSD also have an
> addition bit for MPHY APB clock which was not there (was reserved) for
> previous exynos SoC.
>=20
> Cc: linux-fsd=40tesla.com
> Signed-off-by: Bharat Uppal <bharat.uppal=40samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
> ---
>  drivers/ufs/host/ufs-exynos.c =7C 143 +++++++++++++++++++++++++++++++++-
>  1 file changed, 142 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.=
c
> index a81d8cbd542f..b3efdc4caca2 100644
> --- a/drivers/ufs/host/ufs-exynos.c
> +++ b/drivers/ufs/host/ufs-exynos.c
> =40=40 -52,11 +52,12 =40=40
>  =23define HCI_ERR_EN_DME_LAYER	0x88
>  =23define HCI_CLKSTOP_CTRL	0xB0
>  =23define REFCLKOUT_STOP		BIT(4)
> +=23define MPHY_APBCLK_STOP        BIT(3)
>  =23define REFCLK_STOP		BIT(2)
>  =23define UNIPRO_MCLK_STOP	BIT(1)
>  =23define UNIPRO_PCLK_STOP	BIT(0)
>  =23define CLK_STOP_MASK		(REFCLKOUT_STOP =7C REFCLK_STOP =7C=5C
> -				 UNIPRO_MCLK_STOP =7C=5C
> +				 UNIPRO_MCLK_STOP =7C MPHY_APBCLK_STOP=7C=5C

Please make this change into a separate patch of this series.

>  				 UNIPRO_PCLK_STOP)
>  =23define HCI_MISC		0xB4
>  =23define REFCLK_CTRL_EN		BIT(7)
> =40=40 -386,6 +387,104 =40=40 static int exynos7_ufs_post_pwr_change(stru=
ct
> exynos_ufs *ufs,
>  	return 0;
>  =7D
>=20
> +static inline int fsd_ufs_pre_link(struct exynos_ufs *ufs) =7B
> +	int i;
> +	struct ufs_hba *hba =3D ufs->hba;
> +
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9514), 1000000000L / ufs-
> >mclk_rate);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x201), 0x12);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x40);
> +
> +	for_each_ufs_tx_lane(ufs, i) =7B
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xAA, i), 1000000000L /
> ufs->mclk_rate);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8F, i), 0x3F);
> +	=7D
> +
> +	for_each_ufs_rx_lane(ufs, i) =7B
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x12, i), 1000000000L /
> ufs->mclk_rate);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x5C, i), 0x38);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x0F, i), 0x0);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x65, i), 0x1);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x69, i), 0x1);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x21, i), 0x0);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x22, i), 0x0);
> +	=7D
> +
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x0);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9536), 0x4E20);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9564), 0x2e820183);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x155E), 0x0);

Use PA_LOCAL_TX_LCC_ENABLE instead of 0x155E. I think you can find more val=
ues from unipro.h.
Please try to use as much as possible :)

> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x3000), 0x0);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x3001), 0x1);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x4021), 0x1);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x4020), 0x1);

They can be set from exynos_ufs_establish_connt.

> +
> +	return 0;
> +=7D
> +
> +static inline int fsd_ufs_post_link(struct exynos_ufs *ufs) =7B
> +	int i;
> +	struct ufs_hba *hba =3D ufs->hba;
> +	u32 hw_cap_min_tactivate;
> +	u32 peer_rx_min_actv_time_cap;
> +	u32 max_rx_hibern8_time_cap;
> +
> +	ufshcd_dme_get(hba, UIC_ARG_MIB_SEL(0x8F, 4),
> +			&hw_cap_min_tactivate); /* HW Capability of
> MIN_TACTIVATE */
> +	ufshcd_dme_get(hba, UIC_ARG_MIB(0x15A8),
> +			&peer_rx_min_actv_time_cap);    /* PA_TActivate */
> +	ufshcd_dme_get(hba, UIC_ARG_MIB(0x15A7),
> +			&max_rx_hibern8_time_cap);      /* PA_Hibern8Time */
> +
> +	if (peer_rx_min_actv_time_cap >=3D hw_cap_min_tactivate)
> +		ufshcd_dme_peer_set(hba, UIC_ARG_MIB(0x15A8),
> +					peer_rx_min_actv_time_cap + 1);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15A7), max_rx_hibern8_time_cap +
> 1);
> +
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9529), 0x01);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15A4), 0xFA);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9529), 0x00);
> +
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x40);
> +
> +	for_each_ufs_rx_lane(ufs, i) =7B
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x35, i), 0x05);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x73, i), 0x01);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x41, i), 0x02);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x42, i), 0xAC);
> +	=7D
> +
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x0);
> +
> +	return 0;
> +=7D
> +
> +static inline int fsd_ufs_pre_pwr_change(struct exynos_ufs *ufs,
> +					struct ufs_pa_layer_attr *pwr)
> +=7B
> +	struct ufs_hba *hba =3D ufs->hba;
> +
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x1569), 0x1);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x1584), 0x1);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x2041), 8064);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x2042), 28224);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x2043), 20160);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15B0), 12000);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15B1), 32000);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15B2), 16000);
> +
> +	unipro_writel(ufs, 8064, 0x7888);
> +	unipro_writel(ufs, 28224, 0x788C);
> +	unipro_writel(ufs, 20160, 0x7890);
> +	unipro_writel(ufs, 12000, 0x78B8);
> +	unipro_writel(ufs, 32000, 0x78BC);
> +	unipro_writel(ufs, 16000, 0x78C0);
> +
> +	return 0;
> +=7D
> +
>  /*
>   * exynos_ufs_auto_ctrl_hcc - HCI core clock control by h/w
>   * Control should be disabled in the below cases =40=40 -1595,6 +1694,46=
 =40=40
> static struct exynos_ufs_drv_data exynos_ufs_drvs =3D =7B
>  	.post_pwr_change	=3D exynos7_ufs_post_pwr_change,
>  =7D;
>=20
> +static struct exynos_ufs_uic_attr fsd_uic_attr =3D =7B
> +	.tx_trailingclks		=3D 0x10,
> +	.tx_dif_p_nsec			=3D 3000000,	/* unit: ns */
> +	.tx_dif_n_nsec			=3D 1000000,	/* unit: ns */
> +	.tx_high_z_cnt_nsec		=3D 20000,	/* unit: ns */
> +	.tx_base_unit_nsec		=3D 100000,	/* unit: ns */
> +	.tx_gran_unit_nsec		=3D 4000,		/* unit: ns */
> +	.tx_sleep_cnt			=3D 1000,		/* unit: ns */
> +	.tx_min_activatetime		=3D 0xa,
> +	.rx_filler_enable		=3D 0x2,
> +	.rx_dif_p_nsec			=3D 1000000,	/* unit: ns */
> +	.rx_hibern8_wait_nsec		=3D 4000000,	/* unit: ns */
> +	.rx_base_unit_nsec		=3D 100000,	/* unit: ns */
> +	.rx_gran_unit_nsec		=3D 4000,		/* unit: ns */
> +	.rx_sleep_cnt			=3D 1280,		/* unit: ns */
> +	.rx_stall_cnt			=3D 320,		/* unit: ns */
> +	.rx_hs_g1_sync_len_cap		=3D SYNC_LEN_COARSE(0xf),
> +	.rx_hs_g2_sync_len_cap		=3D SYNC_LEN_COARSE(0xf),
> +	.rx_hs_g3_sync_len_cap		=3D SYNC_LEN_COARSE(0xf),
> +	.rx_hs_g1_prep_sync_len_cap	=3D PREP_LEN(0xf),
> +	.rx_hs_g2_prep_sync_len_cap	=3D PREP_LEN(0xf),
> +	.rx_hs_g3_prep_sync_len_cap	=3D PREP_LEN(0xf),
> +	.pa_dbg_option_suite		=3D 0x2E820183,
> +=7D;
> +
> +struct exynos_ufs_drv_data fsd_ufs_drvs =3D =7B
> +	.uic_attr               =3D &fsd_uic_attr,
> +	.quirks                 =3D UFSHCD_QUIRK_PRDT_BYTE_GRAN =7C
> +				  UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR =7C
> +				  UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR =7C
> +				  UFSHCI_QUIRK_SKIP_RESET_INTR_AGGR,
> +	.opts                   =3D EXYNOS_UFS_OPT_HAS_APB_CLK_CTRL =7C
> +				  EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL =7C
> +				  EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR =7C
> +				  EXYNOS_UFS_OPT_BROKEN_RX_SEL_IDX,
> +	.pre_link               =3D fsd_ufs_pre_link,
> +	.post_link              =3D fsd_ufs_post_link,
> +	.pre_pwr_change         =3D fsd_ufs_pre_pwr_change,
> +=7D;
> +
>  static const struct of_device_id exynos_ufs_of_match=5B=5D =3D =7B
>  	=7B .compatible =3D =22samsung,exynos7-ufs=22,
>  	  .data	      =3D &exynos_ufs_drvs =7D,
> =40=40 -1602,6 +1741,8 =40=40 static const struct of_device_id
> exynos_ufs_of_match=5B=5D =3D =7B
>  	  .data	      =3D &exynosauto_ufs_drvs =7D,
>  	=7B .compatible =3D =22samsung,exynosautov9-ufs-vh=22,
>  	  .data	      =3D &exynosauto_ufs_vh_drvs =7D,
> +	=7B .compatible =3D =22tesla,fsd-ufs=22,
> +	  .data       =3D &fsd_ufs_drvs =7D,
>  	=7B=7D,
>  =7D;
>=20
> --
> 2.25.1


