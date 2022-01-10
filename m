Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65333489C10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiAJPU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:20:57 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:41492 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiAJPUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:20:51 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220110152044epoutp01c408492f897509c7107fe80b48befc7a~I8ehakBC72246622466epoutp01C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:20:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220110152044epoutp01c408492f897509c7107fe80b48befc7a~I8ehakBC72246622466epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1641828044;
        bh=mGlk3CcpzKWLyp/Sx47mNP5Avv9tNVz1HyxD/SjlSCM=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=C/fHUOn78Yh/+ifNBh9JvRkEwC5JZ5ywJAJEOvNqeMVvt/fTM+8XVodJmYx4Y8Wy3
         Cgq1anb6iCWurJdHjHulhvEDu94x8dX+lOTXgDrTTPuR7gGwmXbvOdhGN63HbC93HJ
         VVPOEa6/W0guZvEFcPEsXo40SJMNO2/2q2vgmkx4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220110152043epcas5p42ccf288f19d3e12354369329568e0805~I8egPyTQL0050800508epcas5p4f;
        Mon, 10 Jan 2022 15:20:43 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JXcw62wwsz4x9Pr; Mon, 10 Jan
        2022 15:20:38 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.2A.05590.7CE4CD16; Tue, 11 Jan 2022 00:20:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220110152037epcas5p24eb2dcb0d733fb76c76cd6ecaa7e73f3~I8ebUyFcr1817918179epcas5p2s;
        Mon, 10 Jan 2022 15:20:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220110152037epsmtrp1eca31f44c512989876517ef188782cfc~I8ebbA2nh3028530285epsmtrp1O;
        Mon, 10 Jan 2022 15:20:37 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-f3-61dc4ec70ba4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.FA.08738.6CE4CD16; Tue, 11 Jan 2022 00:20:38 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220110152036epsmtip196319c76337d7760193cdc907bdd0245~I8eZ28jKo3096130961epsmtip12;
        Mon, 10 Jan 2022 15:20:36 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'SEO HOYOUNG'" <hy50.seo@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <avri.altman@wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <asutoshd@codeaurora.org>, <cang@codeaurora.org>,
        <bvanassche@acm.org>
In-Reply-To: <20220106213924.186263-1-hy50.seo@samsung.com>
Subject: RE: [PATCH v2] scsi: ufs: modify Tactive time setting conditions
Date:   Mon, 10 Jan 2022 20:50:35 +0530
Message-ID: <024a01d80635$9f4f5740$ddee05c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF2Kk2TqRw63Mnhf/Wn1AdBL3QQDAKhhYJerQsKGHA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmlu5xvzuJBjMfsVnsbTvBbvHy51U2
        i4MPO1kspn34yWzxaf0yVovVix+wWCy6sY3J4vKuOWwW3dd3sFksP/6PyYHL4/IVb4/Lfb1M
        HhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfRfqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7
        ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hGJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+
        cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2RtfljywFu3gqni7WbGC8xNXFyMkh
        IWAicfbOGZYuRi4OIYHdjBJr3r2Ecj4xSvycfY4dwvnMKHHt4TpGmJY1G/5CJXYxSsxbOIsR
        wnnJKPHj2Qc2kCo2AV2JHYvbwGwRgelMEsuOg9mcAtYSnfeWgNnCAp4S948fAJvKIqAq0bul
        E8jm4OAVsJS4PV8DJMwrIChxcuYTFhCbWUBeYvvbOcwQRyhI/Hy6jBVivJXEg/61bBA14hIv
        jx4BO05CYAeHxOmrnSwQDS4S6279h2oWlnh1fAs7hC0l8bK/jR1kr4RAtkTPLmOIcI3E0nnH
        oFrtJQ5cmcMCUsIsoCmxfpc+xCo+id7fT5ggOnklOtqEIKpVJZrfXYXqlJaY2N3NCmF7SEyZ
        s5sVElJ9wMB9up5lAqPCLCRfzkLy5Swk38xC2LyAkWUVo2RqQXFuemqxaYFxXmo5PLqT83M3
        MYITsJb3DsZHDz7oHWJk4mA8xCjBwawkwrv3wq1EId6UxMqq1KL8+KLSnNTiQ4ymwJCfyCwl
        mpwPzAF5JfGGJpYGJmZmZiaWxmaGSuK8p9I3JAoJpCeWpGanphakFsH0MXFwSjUwuer1ZpXM
        twrdq19Xf2B5TPiqM2+W6vIla80QWNEnf3bvi5dfmDKtazMcr1m92bJwKsd7UfmZOydtntJo
        /L3upJJyF2+ewnG9EwVf7l9c7nfwjKDzltk3b+mJZ18yCD7xRaf36Jdl8snXNnuJz1vIInrr
        VfAqg8VvYu4cDum8rP6jvvTwnj3LOF9aHlrRettOfFfzDY2yjKWyrpOrj8yxCP68WUjisBT3
        9AcyL15nrZl9RL7fZR9HmcXJtdmVG/sWs8zeX8/+tPmcZuWPKGbJy6+faDmwtN1/omvqGx79
        av7DJbNVfXx9H+netHjdc/gllwuTu8/7xX13vWfIRXNfVsncfUmuSLiH8+3NZRwztJVYijMS
        DbWYi4oTAdFu2qJJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnO4xvzuJBquOK1nsbTvBbvHy51U2
        i4MPO1kspn34yWzxaf0yVovVix+wWCy6sY3J4vKuOWwW3dd3sFksP/6PyYHL4/IVb4/Lfb1M
        HhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfRfqCbKYAjissmJTUnsyy1SN8ugSuj6/JHloJd
        PBVPF2s2MF7i6mLk5JAQMJFYs+EvexcjF4eQwA5Gid07rrJDJKQlrm+cAGULS6z89xyq6Dmj
        RM/WU4wgCTYBXYkdi9vYQBIiAouZJKa9/MEMUdXDKPHk7x82kCpOAWuJzntLwGxhAU+J+8cP
        gHWzCKhK9G7pBLI5OHgFLCVuz9cACfMKCEqcnPmEBcRmFtCW6H3Yyghhy0tsfzuHGeIiBYmf
        T5exgtgiAlYSD/rXskHUiEu8PHqEfQKj0Cwko2YhGTULyahZSFoWMLKsYpRMLSjOTc8tNiww
        ykst1ytOzC0uzUvXS87P3cQIjjgtrR2Me1Z90DvEyMTBeIhRgoNZSYR374VbiUK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwJbU+7N9vsOLLffdNu17k
        lqeyHpuVyXznrvux96pn9OPaDq//86dknfjh5r2N7x46aF99Lxq3viTbjeVAfMpPzQLG9Gfl
        E2bKtV4RzfA6/3vzzWwO/cePYvRmGxZsvlt7h2NOgJy/9GtBdUVhByPWC5HinDz2ZbkzuBau
        LZ7Re6tn1b8F+650Mq5d8+UjpwSjhJKAhO0T7++z7+rvOav4mqd2q8bTtGeiopnuRi+eMs09
        /Op/2+HKTZN1Xx947qx+7Rzz5etXJtjaMPlcU56XYm7X7ikq5vjtiMkvjrVr9u6J023KsO4W
        Ni3+ML/w6dEHkRkHs2stTnhpfIiZdzCoY77zPK6vB5na826cXLRZUImlOCPRUIu5qDgRABSw
        rSInAwAA
X-CMS-MailID: 20220110152037epcas5p24eb2dcb0d733fb76c76cd6ecaa7e73f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220107095451epcas2p2d06b23e50cbd46e910532e2d9078c912
References: <CGME20220107095451epcas2p2d06b23e50cbd46e910532e2d9078c912@epcas2p2.samsung.com>
        <20220106213924.186263-1-hy50.seo@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Seo Hoyoung,

>-----Original Message-----
>From: SEO HOYOUNG [mailto:hy50.seo@samsung.com]
>Sent: Friday, January 7, 2022 3:09 AM
>To: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
>alim.akhtar@samsung.com; avri.altman@wdc.com; jejb@linux.ibm.com;
>martin.petersen@oracle.com; beanhuo@micron.com;
>asutoshd@codeaurora.org; cang@codeaurora.org; bvanassche@acm.org
>Cc: SEO HOYOUNG <hy50.seo@samsung.com>
>Subject: [PATCH v2] scsi: ufs: modify Tactive time setting conditions
>
>The Tactive time determine the waiting time before burst at hibern8 exit and
>is determined by H/W at linkup state However, in the case of samsung
>devices, guided host's Tactive time
>+100us for stability.
>If the HCI's Tactive time is equal or greater than the device,
>+100us should be set.
>
>Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
>---
Thanks!
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> drivers/scsi/ufs/ufshcd.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
>1049e41abd5b..460d2b440d2e 100644
>--- a/drivers/scsi/ufs/ufshcd.c
>+++ b/drivers/scsi/ufs/ufshcd.c
>@@ -7815,7 +7815,7 @@ static int
>ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
> 	peer_pa_tactivate_us = peer_pa_tactivate *
> 			     gran_to_us_table[peer_granularity - 1];
>
>-	if (pa_tactivate_us > peer_pa_tactivate_us) {
>+	if (pa_tactivate_us >= peer_pa_tactivate_us) {
> 		u32 new_peer_pa_tactivate;
>
> 		new_peer_pa_tactivate = pa_tactivate_us /
>--
>2.26.0


