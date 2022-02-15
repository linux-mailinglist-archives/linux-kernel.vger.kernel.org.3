Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385804B734B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbiBOQWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:22:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbiBOQVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:21:53 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161BE27156
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:21:42 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220215162140epoutp0236da4c135c3370f0c3ad37f8185a1135~UAh-5bviI0932009320epoutp02Y
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:21:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220215162140epoutp0236da4c135c3370f0c3ad37f8185a1135~UAh-5bviI0932009320epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644942100;
        bh=fcvR6uq94cSiqZp9MAZLuz25/68xDCkdfL8moNUqS9Y=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=botiWjIm7CgFIsC2xKcS3vL163u7Bee4nBsPSW+AHAFGYjdLwntHcZBSYL8Y17cft
         uvKHGaoZ+erTBbHeD9Nasx8M3IwFTfE9vnMJydBhsrHK8CnrZ9tjdZFqzzaxIcxeUT
         VHDxpdaa3xwczPK3xkpZCqVPhoC2A4eWiX6iZDis=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220215162138epcas5p1b87c1854cb1e932f6989fcc0959a6004~UAh_sANW82399723997epcas5p1r;
        Tue, 15 Feb 2022 16:21:38 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JymYr0Typz4x9Pp; Tue, 15 Feb
        2022 16:21:36 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.B2.06423.F03DB026; Wed, 16 Feb 2022 01:21:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220215162135epcas5p1a54157dd72d2ae529f336ea86955dfa9~UAh7B8fcQ2537525375epcas5p1d;
        Tue, 15 Feb 2022 16:21:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220215162135epsmtrp277a881b0326f37dcaf1d2b3fb3c5777c~UAh7BFV0a3132731327epsmtrp2T;
        Tue, 15 Feb 2022 16:21:35 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-04-620bd30f3b4d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.2C.29871.E03DB026; Wed, 16 Feb 2022 01:21:34 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220215162133epsmtip14be0eba52da5536d11cd773406f77aef~UAh5dk6WU0868808688epsmtip1P;
        Tue, 15 Feb 2022 16:21:33 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     <keosung.park@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <bvanassche@acm.org>, <beanhuo@micron.com>, <cang@codeaurora.org>,
        <adrian.hunter@intel.com>, <asutoshd@codeaurora.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <1891546521.01644927481711.JavaMail.epsvc@epcpadp4>
Subject: RE: [PATCH] scsi: ufs: Remove wlun_dev_to_hba()
Date:   Tue, 15 Feb 2022 21:51:32 +0530
Message-ID: <057401d82288$19a74980$4cf5dc80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFC7VNpGREACNEdLWuCZe2EwhyDdwKa3nT5rapePlA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmli7/Ze4kgysvLC1OPlnDZrG37QS7
        xcufV9ksDj7sZLGY9uEns8Wn9ctYLRbd2MZkcfzkO0aLy7vmsFl0X9/BZrH8+D8mB26Py1e8
        PS739TJ5LN7zksljwqIDjB7f13eweXx8eovFo2/LKkaPz5vkPNoPdDMFcEZl22SkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAXaukUJaYUwoUCkgsLlbS
        t7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7Ytq+FqaCfu2Lj
        8w7GBsZ3HF2MnBwSAiYSJz6uY+ti5OIQEtjNKLHz0H4o5xOjxIL5H1ghnG+MElvmb2eDaem4
        tY0dIrGXUWL/v9dQzktGiT/zVzOBVLEJ6ErsWNwGNktEYBmTxORNB1hBEpwCDhL7n9xiAbGF
        BSwk3h28ANbAIqAqsWL3fbA4r4ClxMVrNxkhbEGJkzOfgMWZBeQltr+dwwxxhoLEz6fLwGaK
        CFhJzGz+wwRRIy7x8ugRsIskBI5wSLzcPoURosFFYtOzo1C2sMSr41vYIWwpic/v9gJdygFk
        Z0v07DKGCNdILJ13jAXCtpc4cGUOC0gJs4CmxPpd+hCr+CR6fz9hgujklehoE4KoVpVofncV
        qlNaYmJ3NyuE7SHx4NkyZkhYtTNKXDp8gmkCo8IsJF/OQvLlLCTfzELYvICRZRWjZGpBcW56
        arFpgWFeajk8xpPzczcxglOzlucOxrsPPugdYmTiYDzEKMHBrCTCG3eWM0mINyWxsiq1KD++
        qDQntfgQoykw6CcyS4km5wOzQ15JvKGJpYGJmZmZiaWxmaGSOO/p9A2JQgLpiSWp2ampBalF
        MH1MHJxSDUw2021Pbn0iL3Eu4bXao2ln1Exj0g/fV8o5prl6df02pllHs68l/eFfech8Tmqt
        5O8Xv1//mNcl9+/RPtPM/zGmjjc6+I7HbZR+FRYepr16clbdlDsJXSeMXX6YXVBsu1GavW7B
        RNmg0MBrP93FT/EUVj6o/lktbl4cuPDFiSmbOP9cqTpfemXOqi8La8rt9XhW/FmsUL1fcJb9
        pFeNFew/9kg6KR2Kendy9/2yL2vf/ZAt5LzGG7lnSeCPyeX8U01+zH+lZh6+/Wb5oxdfv1mU
        v7U4WHwt7zfHPcH/ViYnbWZbuGWIzy7K4Tru8OycbMqE7HOzfzY3r96r5lgYy2zhkCup9eua
        Sd+OtO7m2OerlFiKMxINtZiLihMBq8SRElYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSnC7fZe4kg/1XzS1OPlnDZrG37QS7
        xcufV9ksDj7sZLGY9uEns8Wn9ctYLRbd2MZkcfzkO0aLy7vmsFl0X9/BZrH8+D8mB26Py1e8
        PS739TJ5LN7zksljwqIDjB7f13eweXx8eovFo2/LKkaPz5vkPNoPdDMFcEZx2aSk5mSWpRbp
        2yVwZWzb18JU0M9dsfF5B2MD4zuOLkZODgkBE4mOW9vYuxi5OIQEdjNKvLjwkhkiIS1xfeME
        dghbWGLlv+dQRc8ZJT4+38UIkmAT0JXYsbiNDSQhIrCFSWL+vvVgCSGBVkaJ592ZIDangIPE
        /ie3WEBsYQELiXcHLzCB2CwCqhIrdt8Hi/MKWEpcvHaTEcIWlDg58wlYnFlAW6L3YSsjhC0v
        sf3tHKjrFCR+Pl3GCmKLCFhJzGz+wwRRIy7x8ugR9gmMQrOQjJqFZNQsJKNmIWlZwMiyilEy
        taA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOA61NHcwbl/1Qe8QIxMH4yFGCQ5mJRHeuLOc
        SUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwZVydFHNG
        i2duK8PtEJ9NZhN+fLCXmsbKFnK5P5gxb5Upl+q2clVngVPVO6ZNFvtoUP9okpv+fNNzz69r
        rGHLF/+QZxzQaLfr4WrtXTX7PeMzJq2aekWq3X12VmjRsktfNk4uYj1Y++3EnBx+mcigJQds
        Pk59vd8u9Mp8k/KtH0MfVhwrTzr19MzSC0n9+TU342L3LPz7lLeuUEtKpDE1ryX4a/UqaRbt
        49yTftzPtlhplsq5MW6maMkapU3H0jtmrZA3vnOq9JBRKOsEHtGpfW9vXviTu2MR86bMyuoz
        VT5rLu4tvhY98+8ON78Dbw2vVjCx+69fyPrC1F//dFXM9AnTZ3VuW5pVsV7NxX5emRJLcUai
        oRZzUXEiAFSPjlkyAwAA
X-CMS-MailID: 20220215162135epcas5p1a54157dd72d2ae529f336ea86955dfa9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220215114002epcms2p1eb4e53507c96e0f24770af16aedcf5c6
References: <CGME20220215114002epcms2p1eb4e53507c96e0f24770af16aedcf5c6@epcms2p1>
        <1891546521.01644927481711.JavaMail.epsvc@epcpadp4>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Keoseong Park [mailto:keosung.park@samsung.com]
>Sent: Tuesday, February 15, 2022 5:10 PM
>To: ALIM AKHTAR <alim.akhtar@samsung.com>; avri.altman@wdc.com;
>jejb@linux.ibm.com; martin.petersen@oracle.com; bvanassche@acm.org;
>beanhuo@micron.com; cang@codeaurora.org; adrian.hunter@intel.com;
>asutoshd@codeaurora.org; linux-scsi@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: [PATCH] scsi: ufs: Remove wlun_dev_to_hba()
>
>Commit edc0596cc04b ("scsi: ufs: core: Stop clearing UNIT ATTENTIONS")
>removed all callers of wlun_dev_to_hba(). Hence also remove the macro
>itself.
>
>Signed-off-by: Keoseong Park <keosung.park@samsung.com>
>---


Thanks!

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> drivers/scsi/ufs/ufshcd.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
>41d85b69fa50..1243d73d669b 100644
>--- a/drivers/scsi/ufs/ufshcd.c
>+++ b/drivers/scsi/ufs/ufshcd.c
>@@ -83,8 +83,6 @@
> /* Polling time to wait for fDeviceInit */  #define
>FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
>
>-#define wlun_dev_to_hba(dv) shost_priv(to_scsi_device(dv)->host)
>-
> #define ufshcd_toggle_vreg(_dev, _vreg, _on)
>	\
> 	({                                                              \
> 		int _ret;                                               \
>--
>2.17.1


