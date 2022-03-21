Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD64E255F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346821AbiCULm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346855AbiCULmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:42:55 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F23DAFE9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:41:28 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220321114123epoutp03da0b78b6d1854d370bf3fd32efbbcb6f~eYo-Eb0kO2129721297epoutp03Y
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:41:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220321114123epoutp03da0b78b6d1854d370bf3fd32efbbcb6f~eYo-Eb0kO2129721297epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647862883;
        bh=NQxPqI4znNnC+6KXkYSr2Woa8tZHGbyP3/LXHmOxx6g=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=icQe6ifHX0v+yA3lTPGvljzMV5F05HOBN22LqltajdhhYymxlXjAlwGaSDNCJjMYe
         BleLH+QJQVDiRfid6/oS0WO6Dy/pEWlofDAI/K2pdp85MRupanI+niVqmpZml4I79H
         RuCzmNXnv2CVvyMGxrRDsYkOuLLJIAtGkMr+ifvU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220321114122epcas5p4e025f91683f41381e843a361849e5fa5~eYo_fkMZV1202712027epcas5p4I;
        Mon, 21 Mar 2022 11:41:22 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KMXkk5Fg7z4x9Pv; Mon, 21 Mar
        2022 11:41:18 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.BF.06423.85468326; Mon, 21 Mar 2022 20:41:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220321114111epcas5p246b51a7d2563e8e455a211a74e50e094~eYo0gOGwc2711227112epcas5p2r;
        Mon, 21 Mar 2022 11:41:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220321114111epsmtrp12647567c9e886669af03a4b933e59126~eYo0fNEyD2776827768epsmtrp1j;
        Mon, 21 Mar 2022 11:41:11 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-0d-62386458a0bd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.48.03370.75468326; Mon, 21 Mar 2022 20:41:11 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220321114110epsmtip258ea940cbaf09a6470ed94c471d0a993~eYozD92FO2161421614epsmtip2D;
        Mon, 21 Mar 2022 11:41:10 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Avri Altman'" <avri.altman@wdc.com>,
        "'James E.J. Bottomley'" <jejb@linux.ibm.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Luca Weiss'" <luca.weiss@fairphone.com>
In-Reply-To: <20220320110616.18355-1-krzk@kernel.org>
Subject: RE: [RFT] ufs: qcom: drop custom Android boot parameters
Date:   Mon, 21 Mar 2022 17:11:08 +0530
Message-ID: <000001d83d18$90552c00$b0ff8400$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI06NSZ3OommDLncQEXIR6oA1rfPgHhUmL2rAFUf+A=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmlm5EikWSweV3AhbnHv9msXj58yqb
        xen971gsFt3YxmRx/vwGdouJ+8+yW1zeNYfNovv6DjaLhyuMLJYf/8fkwOXR1vSS1WPTqk42
        jzvX9rB5TFh0gNHj49NbLB6fN8l5tB/oZgpgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1
        MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6T0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5Ra
        kJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnXHn7jKWgpkiFXs2X2JuYJwu2MXIySEhYCKx
        9+4zxi5GLg4hgd2MErfvnGaDcD4xSpz5c4gJwvnMKHHy6UcmmJatPWugErsYJRZvmMEC4bxk
        lDj9oYEdpIpNQFdix+I2sFkiAt+ZJOb2tLCCJJiBEu3nX4AVcQqYSmy7t5YNxBYWcJTYtvg9
        2AoWAVWJrtn7geo5OHgFLCVavwiAhHkFBCVOznzCAjFGXmL72znMEBcpSPx8ugxsvIiAlcSF
        v5vYIWrEJV4ePcIOUXOAQ2LRZS4I20Wibc4VFghbWOLV8S1QNVISL/vb2EHWSghkS/TsMoYI
        10gsnXcMqtxe4sCVOSwgJcwCmhLrd+lDbOKT6P39hAmik1eio00IolpVovndVahOaYmJ3d2s
        ELaHxMm5N9kmMCrOQvLXLCR/zUJy/yyEZQsYWVYxSqYWFOempxabFhjmpZbDozs5P3cTIzjt
        annuYLz74IPeIUYmDsZDjBIczEoivIs/mCcJ8aYkVlalFuXHF5XmpBYfYjQFhvVEZinR5Hxg
        4s8riTc0sTQwMTMzM7E0NjNUEuc9nb4hUUggPbEkNTs1tSC1CKaPiYNTqoFpNpeexU6+eRVx
        4Sw5Txec/LVZdJF7/CHViUILC57civ6gffOH3qLQC58a/z7LD5KvkjOXmN1rVS7y1TC38s6n
        n5ZtuS9MLt+ateqtw1st3VNn3wf7i07ytPla8v9GTmTJEdZDiXPlb+5sMTqwWn+xPtNLd4bw
        rqR42wk3Lq2Ujtxi9zpMLHdjfZW085rtAh8vdKhzcrp4hJtL7K393ZbEczmSc2kXy644zzMf
        7yda/BBtX76jdiN/12bH7SIaR/JmXHyeJO55ZdfUuld3PO7FO5yumK1vWFJrWdkld+4fd0qO
        pEVMvGPedM5csa+veyeGVzWINJ/e2L9ELjlkbbJc4Od74aZx2kvzjv9zeKbEUpyRaKjFXFSc
        CABivz/6RAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvG54ikWSwcHvJhbnHv9msXj58yqb
        xen971gsFt3YxmRx/vwGdouJ+8+yW1zeNYfNovv6DjaLhyuMLJYf/8fkwOXR1vSS1WPTqk42
        jzvX9rB5TFh0gNHj49NbLB6fN8l5tB/oZgpgj+KySUnNySxLLdK3S+DKuHN3GUvBTJGKPZsv
        MTcwThfsYuTkkBAwkdjas4api5GLQ0hgB6PEpH3nWSAS0hLXN05gh7CFJVb+e84OUfScUaL1
        63dWkASbgK7EjsVtbCAJEYG/TBLfL3eAdTADJdrPv4DqaGOUOH1yPhtIglPAVGLbvbVgtrCA
        o8S2xe+ZQGwWAVWJrtn7gaZycPAKWEq0fhEACfMKCEqcnPmEBSTMLKAn0baREWK8vMT2t3OY
        IY5TkPj5dBnYPSICVhIX/m6COkFc4uXRI+wTGIVnIZk0C2HSLCSTZiHpWMDIsopRMrWgODc9
        t9iwwCgvtVyvODG3uDQvXS85P3cTIzj6tLR2MO5Z9UHvECMTB+MhRgkOZiUR3sUfzJOEeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYJq78NyVgvhlglKp
        vZ3F2v1T1t8wnWPDcOCrYrGSiOrh/e3lfvXfdmSdZXjy9shOlWTuulumhz83T3jw6ohN4NqA
        9j1fTe8XJEefuaPZdPhI1qIufl7nHImXMvufbD115ZhY+e3I72fK5vY/a7iwb4tcmsfDGwV3
        g26/OXVL4VBz/v10ibL46QtnLxUPc5y5e/KN4+6pE2W22i1V4exom62z943R+5dzmG0mTmiO
        2bTjfynv0QNfFX5P8Pwxi0HUwEwn9uYV+boq/4dpR6TuGL96rlXaMblzAfMVLa2fvDzam7dx
        fy4Sm7xpo+uKM/F359jmLZJ9uPP+5+jjdXNXG7NeXNhw35ODKSpnxkIt9bUOSizFGYmGWsxF
        xYkA7LF5OC0DAAA=
X-CMS-MailID: 20220321114111epcas5p246b51a7d2563e8e455a211a74e50e094
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220320110632epcas5p2d533561db40978dd00b81b391096e3a1
References: <CGME20220320110632epcas5p2d533561db40978dd00b81b391096e3a1@epcas5p2.samsung.com>
        <20220320110616.18355-1-krzk@kernel.org>
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
>From: Krzysztof Kozlowski [mailto:krzk@kernel.org]
>Sent: Sunday, March 20, 2022 4:36 PM
>To: Andy Gross <agross@kernel.org>; Bjorn Andersson
><bjorn.andersson@linaro.org>; Alim Akhtar <alim.akhtar@samsung.com>;
>Avri Altman <avri.altman@wdc.com>; James E.J. Bottomley
><jejb@linux.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>;
>linux-arm-msm@vger.kernel.org; linux-scsi@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzk@kernel.org>; Luca Weiss
><luca.weiss@fairphone.com>
>Subject: [RFT] ufs: qcom: drop custom Android boot parameters
>
>The QCOM UFS driver requires an androidboot.bootdevice command line
>argument matching the UFS device name.  If the name is different, it
refuses
>to probe.  Thise androidboot.bootdevice is provided by stock/vendor (from
an


In case you are resending 
s/thise/this

Rest looks good.

>Android-based device) bootloader.
>
>This does not make sense from Linux point of view.  Driver should be able
to
>boot regardless of bootloader.  Driver should not depend on some Android
>custom environment data.
>
>Cc: Luca Weiss <luca.weiss@fairphone.com>
>Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
>---
>
>Not tested, please kindly provide tests.
>
>See also:
>https://lore.kernel.org/linux-devicetree/f61abc2b-3ce8-7b1f-3d28-
>8a4a03ec58eb@kernel.org/T/#u
>---
> drivers/scsi/ufs/ufs-qcom.c | 15 ---------------
> 1 file changed, 15 deletions(-)
>
>diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index
>0d2e950d0865..586c0e567ff9 100644
>--- a/drivers/scsi/ufs/ufs-qcom.c
>+++ b/drivers/scsi/ufs/ufs-qcom.c
>@@ -957,18 +957,6 @@ static const struct reset_control_ops
>ufs_qcom_reset_ops = {
> 	.deassert = ufs_qcom_reset_deassert,
> };
>
>-#define	ANDROID_BOOT_DEV_MAX	30
>-static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
>-
>-#ifndef MODULE
>-static int __init get_android_boot_dev(char *str) -{
>-	strlcpy(android_boot_dev, str, ANDROID_BOOT_DEV_MAX);
>-	return 1;
>-}
>-__setup("androidboot.bootdevice=", get_android_boot_dev); -#endif
>-
> /**
>  * ufs_qcom_init - bind phy with controller
>  * @hba: host controller instance
>@@ -988,9 +976,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
> 	struct resource *res;
> 	struct ufs_clk_info *clki;
>
>-	if (strlen(android_boot_dev) && strcmp(android_boot_dev,
>dev_name(dev)))
>-		return -ENODEV;
>-
> 	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
> 	if (!host) {
> 		err = -ENOMEM;
>--
>2.32.0


