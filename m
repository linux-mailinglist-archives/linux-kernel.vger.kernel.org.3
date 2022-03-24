Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436694E6DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbiCYFif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243776AbiCYFiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:38:12 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5D1C55B0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:36:24 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220325053620epoutp041226c3a0ffc310cacb10dd72d0c45af5~fiPZZ5ga22694026940epoutp04N
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:36:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220325053620epoutp041226c3a0ffc310cacb10dd72d0c45af5~fiPZZ5ga22694026940epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648186580;
        bh=j86NhfyZGha+ZaYqUAO9Gq8O6Uiv9YJI8CD01My/dgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIUgoXyeISYddQGwAyM8si1dX5+f8aGYrrFANaSCU5Pi4wAooBMvKJOcgdrWLdbZk
         q/1MtlukNbqZqqTDLFXk+LTWzGEc5ya5uYqWbCTmWrmNjJhdLfZjyRNNrPsPUgRtkM
         kCekdXg39thNDQxd+w+xM+IzQ8YLrR4u41QPXC8k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220325053619epcas2p396e719e6bd90aeb455f50da3109e02f8~fiPYjOGKz2426124261epcas2p3X;
        Fri, 25 Mar 2022 05:36:19 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KPrRj6lwzz4x9QX; Fri, 25 Mar
        2022 05:36:17 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.97.25540.FC45D326; Fri, 25 Mar 2022 14:36:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220325053615epcas2p25b140872340b4711d4fef4c5a4cb45f4~fiPUnUeFb0320803208epcas2p2S;
        Fri, 25 Mar 2022 05:36:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220325053615epsmtrp217bc8ac652a7e1b0e4928c9416c61407~fiPUmamsy2929029290epsmtrp2Z;
        Fri, 25 Mar 2022 05:36:15 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-5d-623d54cf7292
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.F8.03370.FC45D326; Fri, 25 Mar 2022 14:36:15 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [12.36.155.109]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220325053614epsmtip21bda836a5f42cc8becf61a0f3cbed5f8~fiPUaS7Ie2101121011epsmtip2N;
        Fri, 25 Mar 2022 05:36:14 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, cang@codeaurora.org, bvanassche@acm.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v1] scsi: ufs: unipro: add to define HS-Gear5 mode
Date:   Fri, 25 Mar 2022 02:21:13 +0900
Message-Id: <20220324172113.192370-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <sc.suh@samsung.com;>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmhe75ENskgy33dSwezNvGZrG37QS7
        xcufV9ksDj7sZLH4uvQZq8W0Dz+ZLT6tX8ZqsXrxAxaLRTe2MVnc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mB1+PyFW+Py329TB4TFh1g9Pi+voPN4+PTWywefVtWMXp83iTn0X6gmymAIyrbJiM1
        MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoZCWFssScUqBQ
        QGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsahpZNZ
        C3azVjQuUWhg3MHSxcjJISFgIvHr0Vogm4tDSGAHo8Th3Z1sEM4nRonTc9sZIZzPjBK33vxn
        g2npe7gHKrGLUaJzwXV2COcHo0RLyz+wwWwCGhJrjh1iAkmICKxgkujZ9IkJJMEsoCbx+e4y
        sCJhASeJxzfaWUFsFgFViY7/DYwgNq+AlcTpiUuhLpSXWNTwG6yXU0BJ4v2pt8wQNYISJ2c+
        YYGYKS/RvHU2M8gyCYGlHBKvW+4yQTS7SHz+vgnKFpZ4dXwLO4QtJfH53V6of4olfrxZzQTR
        3MAosbT9GDNEwlhi1jNQCHAAbdCUWL9LH8SUEFCWOHILai+fRMfhv+wQYV6JjjYhiEYliTNz
        b0OFJSQOzs6BCHtIbL3zixUkLCRQKrH5edUERoVZSH6ZheSXWQhbFzAyr2IUSy0ozk1PLTYq
        MIbHb3J+7iZGcALWct/BOOPtB71DjEwcjIcYJTiYlUR471+2ThLiTUmsrEotyo8vKs1JLT7E
        aAoM6YnMUqLJ+cAckFcSb2hiaWBiZmZobmRqYK4kzuuVsiFRSCA9sSQ1OzW1ILUIpo+Jg1Oq
        gWnVVtkG6c/3VRcyzbxsa670JqbzZ/6T5avyS3l+TPqvtnfj1czDTk+Dy/QlMraL7e7oSbju
        4/Ljv13oyvisgj+yd/yeKb6QOrR/0v7w9bO0TvGc+ZW7Y/WUkBnOQRd8qrk9Mrj/+E2eFZXU
        dbG5uzThzSHrlk8fU/7U6FXVbHBpFwyav1Iiuftg8SrLBfdP5UVcUyovyws58s/6DauMy9wd
        ybUBDFn/3Lf7LhVNm3l5Ous/t7s7RbVWzUjnvVclc1902+rl02ML+ZgYOtOaToqE9L7W9OG6
        Z2Fask5v2+H21otMam/W5avFmFt++O+QvUbwmFumzrRnW+4tvPv4nY2G61eBQFYp9XrVl7Nn
        ayqxFGckGmoxFxUnAgAHsPCuSQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvO75ENskg6efWSwezNvGZrG37QS7
        xcufV9ksDj7sZLH4uvQZq8W0Dz+ZLT6tX8ZqsXrxAxaLRTe2MVnc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mB1+PyFW+Py329TB4TFh1g9Pi+voPN4+PTWywefVtWMXp83iTn0X6gmymAI4rLJiU1
        J7MstUjfLoEr49DSyawFu1krGpcoNDDuYOli5OSQEDCR6Hu4hxHEFhLYwSjR9q4cIi4h8X9x
        ExOELSxxv+UIaxcjF1DNN0aJhV8/sIEk2AQ0JNYcO8QEkhAR2MYkcffDSbAEs4CaxOe7y8A2
        CAs4STy+0c4KYrMIqEp0/G8A28YrYCVxeuJSqCvkJRY1/AbbximgJPH+1FtmiIsUJb6tXccE
        US8ocXLmExaI+fISzVtnM09gFJiFJDULSWoBI9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS9
        5PzcTYzgaNHS2sG4Z9UHvUOMTByMhxglOJiVRHjvX7ZOEuJNSaysSi3Kjy8qzUktPsQozcGi
        JM57oetkvJBAemJJanZqakFqEUyWiYNTqoGJzUyPgb/WS5d9ibfdnt7Ve9JrOxufZ8fWefC/
        ai1/8ubrt8yHTx3+KCkYcGXp9d3+5MSWI6gWNn0zx8pjJ4LE/q6MdT8x/Zbd1qd77ott9fri
        aC9cKX5+a83Jk8EcwhN+eClaOtzYeDpt0Y96gQwRXVPBdMnWB+1LzgXOCPix8+MmbdfaBCGh
        zzsCbfxES+bfqcvs2pTv6OuzwNE18LRt5fKfGyTL3wZu+f7K4PDJ2I3q5x5e1ffSl05eXn3s
        cabaqs85a3M2Gd6dvJ5LoizYv8UwKeymvdkZJl5Dp7hX//Muv+w/2cV9oOZP/qoZrq8d3guu
        sGZ5yxsYe6xu850Hrxddfeqy3HBjnazTwtNKLMUZiYZazEXFiQCIbrVKBQMAAA==
X-CMS-MailID: 20220325053615epcas2p25b140872340b4711d4fef4c5a4cb45f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220325053615epcas2p25b140872340b4711d4fef4c5a4cb45f4
References: <sc.suh@samsung.com;>
        <CGME20220325053615epcas2p25b140872340b4711d4fef4c5a4cb45f4@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS devices support HS-Gear5 mode with UFS4.0 spec.
However there is no definition of HS-Gear5.
So added it in unipro header

Change-Id: Id5475005000fe66b432ab76fa3364a8c12296f7c
Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/scsi/ufs/unipro.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/unipro.h b/drivers/scsi/ufs/unipro.h
index 8e9e486a4f7b..0d2131e1f027 100644
--- a/drivers/scsi/ufs/unipro.h
+++ b/drivers/scsi/ufs/unipro.h
@@ -231,6 +231,7 @@ enum ufs_hs_gear_tag {
 	UFS_HS_G2,		/* HS Gear 2 */
 	UFS_HS_G3,		/* HS Gear 3 */
 	UFS_HS_G4,		/* HS Gear 4 */
+	UFS_HS_G5,		/* HS Gear 5 */
 };
 
 enum ufs_unipro_ver {
-- 
2.26.0

