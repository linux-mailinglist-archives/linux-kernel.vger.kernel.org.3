Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0803153C2E5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbiFCBml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbiFCBmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:42:38 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EB5140E1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 18:42:34 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220603014229epoutp01b92401cfe299af595bac856ebc44147f~0_NNX3v-02717027170epoutp01X
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 01:42:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220603014229epoutp01b92401cfe299af595bac856ebc44147f~0_NNX3v-02717027170epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654220549;
        bh=C5f90iQPxreQFb3rJwYB0hebCijSGat0HWAwpPZWzbY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JPjBJXtYkj5a1Q+ZgLyMdU8wMKVHSZ27AeJMKXMFvewTguKNhXy+ICBgwpDDBY+C2
         VCS9m/ApfZIW29EoVXaQMwAab6QnsQkuPBg+ozTCgLvyAjVPBzoy82yo/KsJn/vqpG
         9Cohh4ux0B00WlLgQeQDvZ+x89WGL/T5Rp5vIfdM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220603014228epcas5p2f87aadda9eba4db0af079d0466d248ae~0_NL2ur0E0119401194epcas5p2T;
        Fri,  3 Jun 2022 01:42:28 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LDlxY2d7rz4x9QF; Fri,  3 Jun
        2022 01:42:25 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.7C.09762.10769926; Fri,  3 Jun 2022 10:42:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220603014224epcas5p2dc829bd2dae04ccdd63760016e6f50db~0_NIfAepJ0119401194epcas5p2P;
        Fri,  3 Jun 2022 01:42:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220603014224epsmtrp15c5fc56bd3acc816fd2c974b12ff1b6b~0_NId4wd43242932429epsmtrp1R;
        Fri,  3 Jun 2022 01:42:24 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-bf-629967011cba
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.0E.08924.00769926; Fri,  3 Jun 2022 10:42:24 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220603014222epsmtip1beb92de67f726ea04b7db406b88b3c3b~0_NGTmF-l1256312563epsmtip1h;
        Fri,  3 Jun 2022 01:42:22 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Chanho Park'" <chanho61.park@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Cc:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <martin.petersen@oracle.com>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, "'Bharat Uppal'" <bharat.uppal@samsung.com>
In-Reply-To: <001101d874c1$3d850eb0$b88f2c10$@samsung.com>
Subject: RE: [PATCH 5/6] ufs: host: ufs-exynos: add support for fsd ufs hci
Date:   Fri, 3 Jun 2022 07:12:20 +0530
Message-ID: <000c01d876eb$2c6f6680$854e3380$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEGJiXAXdobboEKZTBkhZkj5AOCHwHAGN/eAYoUDxkAo1aMY67CHYCw
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmpi5j+swkg2vTBSxe/rzKZnHt5QV2
        i2kffjJbXN6vbTH/yDlWi74XD5ktNj2+xmrx8FW4xeVdc9gsJqz6xmLRfX0Hm8Xy4/+YLBZt
        /cJu0br3CLvFzjsnmB34PS5f8fbYtKqTzePOtT1sHpuX1Ht8fHqLxaNvyypGj39Nc9k9Pm+S
        82g/0M0UwBmVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
        lpkDdL6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQ
        wMDIFKgwITvj0K5V7AWHPSt2rj3F2sB4yaaLkZNDQsBEYmbnMZYuRi4OIYHdjBKPH51mhnA+
        MUr8eP4DKvOZUeLAv3csMC2PXx9mhEjsYpS4ums+E4TzklHi4szt7CBVbAK6EjsWt7GBJERA
        qma/bQMbzCywiEmi6dI3oAwHB6eAlcSz9SYgDcIC3hLdM74yg4RZBFQknm62BzF5BSwlfkz1
        AqngFRCUODnzCdgRzALyEtvfzmGGOEhB4ufTZawgtoiAm8SlLz2sEDXiEi+PHmEH2Soh8IFD
        Ytqk54wQDS4STcveQDULS7w6voUdwpaSeNnfxg6yV0LAQ2LRHymIcIbE2+XroVrtJQ5cmcMC
        UsIsoCmxfpc+xCo+id7fT5ggOnklOtqEIKpVJZrfXYUGm7TExO5uVgjbQ+Lmq+NsExgVZyF5
        bBaSx2YheWAWwrIFjCyrGCVTC4pz01OLTQuM81LL4dGdnJ+7iRGctrW8dzA+evBB7xAjEwfj
        IUYJDmYlEd6SXVOThHhTEiurUovy44tKc1KLDzGaAsN6IrOUaHI+MHPklcQbmlgamJiZmZlY
        GpsZKonzCvxvTBISSE8sSc1OTS1ILYLpY+LglGpgMj0UcchDWLqGd5lR/PJZSdXZAdHyPPWz
        tFeFxlwsOOVcL3mhyCMhULbKYsG1oKMXefxOqeW2zpVz+cGmpnPzefKemrrAJ+LTv7rbBHX7
        hy1jC6n5+loyrVG4haF1drAHq4C28umb7ieXfj/jZPhwYrjEdV1hGZkOSQ6586tzWN2vhxYd
        9D/BsGryyUNaf97XK9uEZR+fefSl+bHDviXyjO/nHH/lfKL4ycFPoneP/T/769aqsBje1ZZR
        HKe3XPN/2/n3V+ZMUXeDbb/cOjtmvGTp97C6uK/bUd2zTeXFzWvday8tD7xuuNCidHGZquOe
        XWfab7VWpT4TO9qT08zww/zXtzzWz5zTj6y1utWmxFKckWioxVxUnAgAGefwkGQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSnC5D+swkg/6/IhYvf15ls7j28gK7
        xbQPP5ktLu/Xtph/5ByrRd+Lh8wWmx5fY7V4+Crc4vKuOWwWE1Z9Y7Hovr6DzWL58X9MFou2
        fmG3aN17hN1i550TzA78HpeveHtsWtXJ5nHn2h42j81L6j0+Pr3F4tG3ZRWjx7+muewenzfJ
        ebQf6GYK4IzisklJzcksSy3St0vgyji0axV7wWHPip1rT7E2MF6y6WLk5JAQMJF4/PowI4gt
        JLCDUWJTbxxEXFri+sYJ7BC2sMTKf8+BbC6gmueMEkv637CBJNgEdCV2LG5jA0mICOxjlDj9
        4hoLiMMssIZJ4ubkq8wQLW8ZJa6dvwZUxsHBKWAl8Wy9CUi3sIC3RPeMr8wgYRYBFYmnm+1B
        TF4BS4kfU71AKngFBCVOznzCAmIzC2hLPL35FMqWl9j+dg4zxHEKEj+fLmMFsUUE3CQufelh
        hagRl3h59Aj7BEbhWUhGzUIyahaSUbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66X
        nJ+7iREcvVpaOxj3rPqgd4iRiYPxEKMEB7OSCG/JrqlJQrwpiZVVqUX58UWlOanFhxilOViU
        xHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTD5Wu2b03J62r1TtVUiPBMjmMXyf99/fbz29T+r
        Jwv/XWYOzD6RdnnR9TjFlUoNH3XXOXSc7JUXcDL/+ezGLckOa8YchlevPj5qS2/r+X4nyE4x
        1Lt2OcdRpcOmuZ8q/8nefBdvsz+EUdTN79XUR4/Dy9/cfL5h/iQP1ZRVfK8n5yn+zOjyd/Zd
        7LDT977kjBU/BA/t/PnMcvn2g0FxNyazT/hU3d920NxmotjTH1I2dwylOXlae7au+6R3Nb9C
        +drur5JuET35wp9l9LefTSyRP9e5++fLo+afuL6ueX7YI/dQzUPLjowfnDvuyP4LTr/FbF12
        NnV7T01U9OmHGUeuXSyxyeC8tn1OyO4TthzuSizFGYmGWsxFxYkARb/9NE0DAAA=
X-CMS-MailID: 20220603014224epcas5p2dc829bd2dae04ccdd63760016e6f50db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220531012356epcas5p3cd6638d4d3eccb28a28d064c9f585a4f
References: <20220531012220.80563-1-alim.akhtar@samsung.com>
        <CGME20220531012356epcas5p3cd6638d4d3eccb28a28d064c9f585a4f@epcas5p3.samsung.com>
        <20220531012220.80563-6-alim.akhtar@samsung.com>
        <001101d874c1$3d850eb0$b88f2c10$@samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanho
Thanks for the review.

>-----Original Message-----
>From: Chanho Park [mailto:chanho61.park@samsung.com]
>Sent: Tuesday, May 31, 2022 1:07 PM
>To: 'Alim Akhtar' <alim.akhtar@samsung.com>; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
>scsi@vger.kernel.org; linux-phy@lists.infradead.org
>Cc: devicetree@vger.kernel.org; robh+dt@kernel.org;
>krzysztof.kozlowski+dt@linaro.org; vkoul@kernel.org; avri.altman@wdc.com;
>bvanassche@acm.org; martin.petersen@oracle.com;
>pankaj.dubey@samsung.com; linux-fsd@tesla.com; 'Bharat Uppal'
><bharat.uppal@samsung.com>
>Subject: RE: [PATCH 5/6] ufs: host: ufs-exynos: add support for fsd ufs hci
>
>Hi,
>
>> -----Original Message-----
>> From: Alim Akhtar <alim.akhtar@samsung.com>
>> Sent: Tuesday, May 31, 2022 10:22 AM
>> To: linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org;
>> linux-phy@lists.infradead.org
>> Cc: devicetree@vger.kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; vkoul@kernel.org;
>> avri.altman@wdc.com; bvanassche@acm.org;
>martin.petersen@oracle.com;
>> chanho61.park@samsung.com; pankaj.dubey@samsung.com; Alim Akhtar
>> <alim.akhtar@samsung.com>; linux- fsd@tesla.com; Bharat Uppal
>> <bharat.uppal@samsung.com>
>> Subject: [PATCH 5/6] ufs: host: ufs-exynos: add support for fsd ufs
>> hci
>>
>> Adds support of UFS HCI which is found in Tesla FSD SoC. FSD also have
>> an addition bit for MPHY APB clock which was not there (was reserved)
>> for previous exynos SoC.
>>
>> Cc: linux-fsd@tesla.com
>> Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>  drivers/ufs/host/ufs-exynos.c | 143
>> +++++++++++++++++++++++++++++++++-
>>  1 file changed, 142 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ufs/host/ufs-exynos.c
>> b/drivers/ufs/host/ufs-exynos.c index a81d8cbd542f..b3efdc4caca2
>> 100644
>> --- a/drivers/ufs/host/ufs-exynos.c
>> +++ b/drivers/ufs/host/ufs-exynos.c
>> @@ -52,11 +52,12 @@
>>  #define HCI_ERR_EN_DME_LAYER	0x88
>>  #define HCI_CLKSTOP_CTRL	0xB0
>>  #define REFCLKOUT_STOP		BIT(4)
>> +#define MPHY_APBCLK_STOP        BIT(3)
>>  #define REFCLK_STOP		BIT(2)
>>  #define UNIPRO_MCLK_STOP	BIT(1)
>>  #define UNIPRO_PCLK_STOP	BIT(0)
>>  #define CLK_STOP_MASK		(REFCLKOUT_STOP | REFCLK_STOP |\
>> -				 UNIPRO_MCLK_STOP |\
>> +				 UNIPRO_MCLK_STOP |
>MPHY_APBCLK_STOP|\
>
>Please make this change into a separate patch of this series.
>
Sure, will separate it out.

>>  				 UNIPRO_PCLK_STOP)
>>  #define HCI_MISC		0xB4
>>  #define REFCLK_CTRL_EN		BIT(7)
>> @@ -386,6 +387,104 @@ static int exynos7_ufs_post_pwr_change(struct
>> exynos_ufs *ufs,
>>  	return 0;
>>  }
>>
>> +static inline int fsd_ufs_pre_link(struct exynos_ufs *ufs) {
>> +	int i;
>> +	struct ufs_hba *hba = ufs->hba;
>> +
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9514), 1000000000L / ufs-
>> >mclk_rate);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x201), 0x12);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x40);
>> +
>> +	for_each_ufs_tx_lane(ufs, i) {
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xAA, i),
>1000000000L /
>> ufs->mclk_rate);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8F, i), 0x3F);
>> +	}
>> +
>> +	for_each_ufs_rx_lane(ufs, i) {
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x12, i),
>1000000000L /
>> ufs->mclk_rate);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x5C, i), 0x38);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x0F, i), 0x0);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x65, i), 0x1);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x69, i), 0x1);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x21, i), 0x0);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x22, i), 0x0);
>> +	}
>> +
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x0);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9536), 0x4E20);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9564), 0x2e820183);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x155E), 0x0);
>
>Use PA_LOCAL_TX_LCC_ENABLE instead of 0x155E. I think you can find more
>values from unipro.h.
>Please try to use as much as possible :)
>
Noted

>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x3000), 0x0);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x3001), 0x1);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x4021), 0x1);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x4020), 0x1);
>
>They can be set from exynos_ufs_establish_connt.
>
Ok, 

>> +
>> +	return 0;
>> +}
>> +
>> +static inline int fsd_ufs_post_link(struct exynos_ufs *ufs) {
>> +	int i;
>> +	struct ufs_hba *hba = ufs->hba;
>> +	u32 hw_cap_min_tactivate;
>> +	u32 peer_rx_min_actv_time_cap;
>> +	u32 max_rx_hibern8_time_cap;
>> +
>> +	ufshcd_dme_get(hba, UIC_ARG_MIB_SEL(0x8F, 4),
>> +			&hw_cap_min_tactivate); /* HW Capability of
>> MIN_TACTIVATE */
>> +	ufshcd_dme_get(hba, UIC_ARG_MIB(0x15A8),
>> +			&peer_rx_min_actv_time_cap);    /* PA_TActivate */
>> +	ufshcd_dme_get(hba, UIC_ARG_MIB(0x15A7),
>> +			&max_rx_hibern8_time_cap);      /* PA_Hibern8Time
>*/
>> +
>> +	if (peer_rx_min_actv_time_cap >= hw_cap_min_tactivate)
>> +		ufshcd_dme_peer_set(hba, UIC_ARG_MIB(0x15A8),
>> +					peer_rx_min_actv_time_cap + 1);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15A7),
>max_rx_hibern8_time_cap +
>> 1);
>> +
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9529), 0x01);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15A4), 0xFA);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9529), 0x00);
>> +
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x40);
>> +
>> +	for_each_ufs_rx_lane(ufs, i) {
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x35, i), 0x05);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x73, i), 0x01);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x41, i), 0x02);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x42, i), 0xAC);
>> +	}
>> +
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x0);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int fsd_ufs_pre_pwr_change(struct exynos_ufs *ufs,
>> +					struct ufs_pa_layer_attr *pwr)
>> +{
>> +	struct ufs_hba *hba = ufs->hba;
>> +
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x1569), 0x1);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x1584), 0x1);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x2041), 8064);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x2042), 28224);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x2043), 20160);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15B0), 12000);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15B1), 32000);
>> +	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15B2), 16000);
>> +
>> +	unipro_writel(ufs, 8064, 0x7888);
>> +	unipro_writel(ufs, 28224, 0x788C);
>> +	unipro_writel(ufs, 20160, 0x7890);
>> +	unipro_writel(ufs, 12000, 0x78B8);
>> +	unipro_writel(ufs, 32000, 0x78BC);
>> +	unipro_writel(ufs, 16000, 0x78C0);
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * exynos_ufs_auto_ctrl_hcc - HCI core clock control by h/w
>>   * Control should be disabled in the below cases @@ -1595,6 +1694,46
>> @@ static struct exynos_ufs_drv_data exynos_ufs_drvs = {
>>  	.post_pwr_change	= exynos7_ufs_post_pwr_change,
>>  };
>>
>> +static struct exynos_ufs_uic_attr fsd_uic_attr = {
>> +	.tx_trailingclks		= 0x10,
>> +	.tx_dif_p_nsec			= 3000000,	/* unit: ns */
>> +	.tx_dif_n_nsec			= 1000000,	/* unit: ns */
>> +	.tx_high_z_cnt_nsec		= 20000,	/* unit: ns */
>> +	.tx_base_unit_nsec		= 100000,	/* unit: ns */
>> +	.tx_gran_unit_nsec		= 4000,		/* unit: ns */
>> +	.tx_sleep_cnt			= 1000,		/* unit: ns */
>> +	.tx_min_activatetime		= 0xa,
>> +	.rx_filler_enable		= 0x2,
>> +	.rx_dif_p_nsec			= 1000000,	/* unit: ns */
>> +	.rx_hibern8_wait_nsec		= 4000000,	/* unit: ns */
>> +	.rx_base_unit_nsec		= 100000,	/* unit: ns */
>> +	.rx_gran_unit_nsec		= 4000,		/* unit: ns */
>> +	.rx_sleep_cnt			= 1280,		/* unit: ns */
>> +	.rx_stall_cnt			= 320,		/* unit: ns */
>> +	.rx_hs_g1_sync_len_cap		= SYNC_LEN_COARSE(0xf),
>> +	.rx_hs_g2_sync_len_cap		= SYNC_LEN_COARSE(0xf),
>> +	.rx_hs_g3_sync_len_cap		= SYNC_LEN_COARSE(0xf),
>> +	.rx_hs_g1_prep_sync_len_cap	= PREP_LEN(0xf),
>> +	.rx_hs_g2_prep_sync_len_cap	= PREP_LEN(0xf),
>> +	.rx_hs_g3_prep_sync_len_cap	= PREP_LEN(0xf),
>> +	.pa_dbg_option_suite		= 0x2E820183,
>> +};
>> +
>> +struct exynos_ufs_drv_data fsd_ufs_drvs = {
>> +	.uic_attr               = &fsd_uic_attr,
>> +	.quirks                 = UFSHCD_QUIRK_PRDT_BYTE_GRAN |
>> +				  UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR |
>> +
>UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR |
>> +				  UFSHCI_QUIRK_SKIP_RESET_INTR_AGGR,
>> +	.opts                   = EXYNOS_UFS_OPT_HAS_APB_CLK_CTRL |
>> +
>EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL |
>> +				  EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR
>|
>> +				  EXYNOS_UFS_OPT_BROKEN_RX_SEL_IDX,
>> +	.pre_link               = fsd_ufs_pre_link,
>> +	.post_link              = fsd_ufs_post_link,
>> +	.pre_pwr_change         = fsd_ufs_pre_pwr_change,
>> +};
>> +
>>  static const struct of_device_id exynos_ufs_of_match[] = {
>>  	{ .compatible = "samsung,exynos7-ufs",
>>  	  .data	      = &exynos_ufs_drvs },
>> @@ -1602,6 +1741,8 @@ static const struct of_device_id
>> exynos_ufs_of_match[] = {
>>  	  .data	      = &exynosauto_ufs_drvs },
>>  	{ .compatible = "samsung,exynosautov9-ufs-vh",
>>  	  .data	      = &exynosauto_ufs_vh_drvs },
>> +	{ .compatible = "tesla,fsd-ufs",
>> +	  .data       = &fsd_ufs_drvs },
>>  	{},
>>  };
>>
>> --
>> 2.25.1
>


