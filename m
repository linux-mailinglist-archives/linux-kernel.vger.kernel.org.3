Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238625421E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiFHEn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiFHEhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:37:34 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404903E1C57
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:24:44 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220608021709epoutp032aaf92c72955ad5ffe20110775444b2a~2g55SaGEj3201432014epoutp03P
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:17:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220608021709epoutp032aaf92c72955ad5ffe20110775444b2a~2g55SaGEj3201432014epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654654629;
        bh=YsxxJh3jyxEwSbPFZB5N8FabmeSNHiS+F1nRFzSyN/c=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=fW9UXTlLsOx8CUmrvk68VjC0AF/JfQQtNLvLmmmNw4QGf4m4IED4ZK83gSY5lzJYf
         3yaen4gvSIXMgJKLfjRfB8EN0yYKhoUl0CXLhZYYEDeFRU0vObEwOxac4orM3WBwkW
         lW1ptHW6DO5cbByYjkt574+02gWD9mLMY5pb0ogw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220608021708epcas2p4a9366159637c54a705583cda2af6cffe~2g54xtGW61290612906epcas2p4G;
        Wed,  8 Jun 2022 02:17:08 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LHrTH6b1lz4x9Pp; Wed,  8 Jun
        2022 02:17:07 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.C7.10028.3A600A26; Wed,  8 Jun 2022 11:17:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220608021707epcas2p12c3217dca29441c5c03c2c9cd102ae21~2g53yzDon1805318053epcas2p1K;
        Wed,  8 Jun 2022 02:17:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220608021707epsmtrp12f25343d6c7c6e284c7c4bc0a37a60dd~2g53x5xIK2303123031epsmtrp1T;
        Wed,  8 Jun 2022 02:17:07 +0000 (GMT)
X-AuditID: b6c32a47-589ff7000000272c-b8-62a006a30124
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.08.11276.3A600A26; Wed,  8 Jun 2022 11:17:07 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220608021707epsmtip29fd738ec30b73ae952cb7c97c35b3e37~2g53fysAP2450424504epsmtip2b;
        Wed,  8 Jun 2022 02:17:07 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Cc:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <martin.petersen@oracle.com>, <pankaj.dubey@samsung.com>,
        "'Bharat Uppal'" <bharat.uppal@samsung.com>
In-Reply-To: <20220603154714.30532-7-alim.akhtar@samsung.com>
Subject: RE: [PATCH v2 6/7] ufs: host: ufs-exynos: add support for fsd ufs
 hci
Date:   Wed, 8 Jun 2022 11:17:07 +0900
Message-ID: <003501d87add$da15c310$8e414930$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFSBQ9Zoh1+pG8sApsbls4ebot9jgJEDvu0Ahy3giCuLqahsA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmhe5itgVJBtNOm1g8mLeNzeLlz6ts
        FtdeXmC3mPbhJ7PF/CPnWC36Xjxkttj0+BqrxeVdc9gsJqz6xmLRfX0Hm8Xy4/+YLBZt/cJu
        0br3CLvFzjsnmB34PC5f8fbYtKqTzePOtT1sHpuX1Ht8fHqLxaNvyypGj8+b5DzaD3QzBXBE
        ZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2tpFCW
        mFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjO
        +DnhPFNBj1rFkU+XWBsYJyt0MXJySAiYSLSdOsEIYgsJ7GCUOPSIs4uRC8j+xChxcfUOVgjn
        G6PEkXULmboYOcA6DuxRhYjvZZRYPec0O4TzAqj79WE2kFFsAvoSLzu2gXWLgIz9vOITC4jD
        LNDJJNF95AITSBWngK3E2tU32UFsYYEAiW+nWsC6WQRUJPadbgCL8wpYSmw/dpARwhaUODnz
        CQuIzSygLbFs4WtmiCcUJH4+XcYKEReRmN3ZxgxyqoiAk8SBLwogeyUE7nBIXJs8lRWi3kXi
        69d9LBC2sMSr41vYIWwpiZf9bVB2scTSWZ+YIJobGCUub/vFBpEwlpj1rJ0RZAGzgKbE+l36
        kGBRljhyC+o0PomOw3/ZIcK8Eh1tQhCN6hIHtk+H2ior0T3nM+sERqVZSB6bheSxWUiemYWw
        awEjyypGsdSC4tz01GKjAmN4ZCfn525iBKdoLfcdjDPeftA7xMjEwXiIUYKDWUmEVzJ8fpIQ
        b0piZVVqUX58UWlOavEhRlNgUE9klhJNzgdmibySeEMTSwMTMzNDcyNTA3MlcV6vlA2JQgLp
        iSWp2ampBalFMH1MHJxSDUz7JZcWBe99/KpoTuDzKfeSObftDT1x+rLx6zBTCyl36W36M3J3
        THNz3BroLDWrwVXJ8PR/js4zJdt3v56wbb96uKNJanxLusbVFr8QtoiMEMNtbKFFn09d2MSz
        Ok9wRn7xg6qc8seG7+S/Tr23sPnUjnfRs9YcOGTuZibJ1bX90vONGg8TVB49lzr85PreZGY3
        n/t3fE+dCJqdt8Cl5keVxX7PydUMXr3h167NXT0/0URKO72ma79pbca3w0c/sXyZuEn4w8sN
        3U5mCl02HC5uZ3haekvWZVXkhF3YZpcVKX1LTu/n1ZV3Yy+0r05kds0zidBK5/Z7/Zwt/4xb
        0F97+3dben8YvNz4a9X3gCNKLMUZiYZazEXFiQDkc+yWWgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSvO5itgVJBuvmilg8mLeNzeLlz6ts
        FtdeXmC3mPbhJ7PF/CPnWC36Xjxkttj0+BqrxeVdc9gsJqz6xmLRfX0Hm8Xy4/+YLBZt/cJu
        0br3CLvFzjsnmB34PC5f8fbYtKqTzePOtT1sHpuX1Ht8fHqLxaNvyypGj8+b5DzaD3QzBXBE
        cdmkpOZklqUW6dslcGV8+LOdreCFasXZdxdYGhhfy3cxcnBICJhIHNij2sXIxSEksJtRYvK8
        y8xdjJxAcVmJZ+92sEPYwhL3W46wQhQ9Y5Q4/OoHC0iCTUBf4mXHNrCEiMAeRom2eafYQRxm
        gclMEpMavrJAtOxnlJi/aw8rSAungK3E2tU3weYKC/hJbP+1nQ3EZhFQkdh3ugEszitgKbH9
        2EFGCFtQ4uTMJ2DrmAW0JXoftjLC2MsWvoa6VUHi59NlrBBxEYnZnW3MIL+JCDhJHPiiMIFR
        eBaSSbOQTJqFZNIsJN0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER6yW5g7G
        7as+6B1iZOJgPMQowcGsJMIrGT4/SYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6Ykl
        qdmpqQWpRTBZJg5OqQamOYXVMcy27sw3L3/flzVL/qUUd8OG7pSow5bTwmwj9zyZorzyJ5Pd
        hA1ZrLXqNXfPlKmkLpKdq3i+1Ek+LGlHN29kvu7xXp8t/mv83rIFy88SjNhqdjb2x75IMf8f
        tQ5+F5kYQgJX/wpYHJPttfit560l/3m8LP0sqxeUCa3l+HnGbB7vhL27osvaW1jkrj+pWd5c
        5vFAf375RQbJsgg9v8snDc20FWtMem/4JITty3Iorb572yaM91Zru92H6QuPhLDNNRD2Or5z
        75yrgscCAw8cPtouu6Xl0LqPWn+uup7qdg+ztep/HbeSUfSKcUBuFccFEdVS9sdF3psuJGpo
        TFm/ODz9mco/O7ayV0osxRmJhlrMRcWJAOzqsylHAwAA
X-CMS-MailID: 20220608021707epcas2p12c3217dca29441c5c03c2c9cd102ae21
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603154907epcas5p40d236cecf8d4a574d44d9a2b66f2caf0
References: <20220603154714.30532-1-alim.akhtar@samsung.com>
        <CGME20220603154907epcas5p40d236cecf8d4a574d44d9a2b66f2caf0@epcas5p4.samsung.com>
        <20220603154714.30532-7-alim.akhtar@samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: =5BPATCH v2 6/7=5D ufs: host: ufs-exynos: add support for fsd uf=
s hci
>=20
> Adds support of UFS HCI which is found in Tesla Full Self-Driving (FSD)
> SoC.
>=20
> Signed-off-by: Bharat Uppal <bharat.uppal=40samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
> ---
>  drivers/ufs/host/ufs-exynos.c =7C 138 ++++++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>=20
> diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.=
c
> index cc128aff8871..7e0ab8a8662e 100644
> --- a/drivers/ufs/host/ufs-exynos.c
> +++ b/drivers/ufs/host/ufs-exynos.c
> =40=40 -1474,6 +1474,102 =40=40 static int exynosauto_ufs_vh_init(struct =
ufs_hba
> *hba)
>  	return 0;
>  =7D
>=20
> +static int fsd_ufs_pre_link(struct exynos_ufs *ufs) =7B
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

Use NSEC_PER_SEC and DIV_ROUND_UP as well.

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
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_LOCAL_TX_LCC_ENABLE), 0x0);
> +
> +	exynos_ufs_establish_connt(ufs);
> +
> +	return 0;
> +=7D
> +
> +static int fsd_ufs_post_link(struct exynos_ufs *ufs) =7B
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
> +static int fsd_ufs_pre_pwr_change(struct exynos_ufs *ufs,
> +					struct ufs_pa_layer_attr *pwr)
> +=7B
> +	struct ufs_hba *hba =3D ufs->hba;
> +
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TXTERMINATION), 0x1);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_RXTERMINATION), 0x1);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(DL_FC0PROTTIMEOUTVAL), 8064);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(DL_TC0REPLAYTIMEOUTVAL), 28224);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(DL_AFC0REQTIMEOUTVAL), 20160);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA0), 12000);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA1), 32000);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA2), 16000);

If you set custom pwrmode setting, you'll need to set UFSHCD_QUIRK_SKIP_DEF=
_UNIPRO_TIMEOUT_SETTING.

> +
> +	unipro_writel(ufs, 8064, 0x7888);
> +	unipro_writel(ufs, 28224, 0x788C);
> +	unipro_writel(ufs, 20160, 0x7890);

Duplicated setting with above dme_set calls. (DL_FC0PROTTIMEOUTVAL / DL_TC0=
REPLAYTIMEOUTVAL / DL_AFC0REQTIMEOUTVAL)
Unipro registers are mirrored and you can use unipro_* APIs but need to cho=
ose one of them.

> +	unipro_writel(ufs, 12000, 0x78B8);
> +	unipro_writel(ufs, 32000, 0x78BC);
> +	unipro_writel(ufs, 16000, 0x78C0);

Put some documents the register as DME_POWERMODE_REQ_REMOTEL2TIMER0/1/2 or =
use macro for them.

Best Regards,
Chanho Park

