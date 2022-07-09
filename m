Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113DD56C89A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiGIKEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGIKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:04:22 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4024AD4F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 03:04:20 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220709100416epoutp03ef3c99b6cfdf27ac81e58789ddbad6a0~AIRmawqZj1085610856epoutp03S
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 10:04:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220709100416epoutp03ef3c99b6cfdf27ac81e58789ddbad6a0~AIRmawqZj1085610856epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657361056;
        bh=RttijG+tvSRcaHpVpM0QwAL3QWBIlj9F8NQg2N/lu6A=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Iv8T6R0ORqYgtBf3ujqPy9Z4bD2FXtYUF2JMBlCH5falkrpEQDLDEo4g0cemEyugQ
         vyUwU1MMGHDVPZB/rwAvvBR4EfBzGb7IkMejzF2j8V+GM0Vnhqg9QeYta3x0JqZK1f
         rLiEDbOSW3vPg2Co/9/qWiVmwggj3Rr9/i0LLgo8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220709100415epcas5p4fdc4218b5f7f5f6a484a7c98940cd2b1~AIRlRNDVp2598925989epcas5p4N;
        Sat,  9 Jul 2022 10:04:15 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Lg5Mx37Hhz4x9Pv; Sat,  9 Jul
        2022 10:04:13 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.F4.09662.D9259C26; Sat,  9 Jul 2022 19:04:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220709100412epcas5p2ec6d9cdac81a2f38ca862165648e4194~AIRisRcFz2047520475epcas5p2Q;
        Sat,  9 Jul 2022 10:04:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220709100412epsmtrp11fcfc2151d709c837b3c58450a2044b8~AIRirdE0l2673226732epsmtrp1B;
        Sat,  9 Jul 2022 10:04:12 +0000 (GMT)
X-AuditID: b6c32a49-86fff700000025be-13-62c9529d53c8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.47.08905.C9259C26; Sat,  9 Jul 2022 19:04:12 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220709100411epsmtip298216536c03d20cbd24268e41a08442c~AIRhPp7tn0358503585epsmtip2k;
        Sat,  9 Jul 2022 10:04:11 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Avri Altman'" <avri.altman@wdc.com>,
        "'Bart Van Assche'" <bvanassche@acm.org>,
        "'James E.J. Bottomley'" <jejb@linux.ibm.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>
Cc:     "'Bean Huo'" <beanhuo@micron.com>,
        "'Adrian Hunter'" <adrian.hunter@intel.com>,
        "'Yue Hu'" <huyue2@yulong.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20220709000027.3929970-1-bjorn.andersson@linaro.org>
Subject: RE: [PATCH] scsi: ufs: ufshcd: Drop loglevel of WriteBoost message
Date:   Sat, 9 Jul 2022 15:34:09 +0530
Message-ID: <000001d8937b$3d39faa0$b7adefe0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQImLzBMENaA2Jj71t4ZY6FxYLPYzAJCrgA7rMiCdUA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwbZRz2vbseVybb8aG8dtnszo8EMrp20HplIMvc2CkmI+qyBBPLFS6U
        0C97RSbOBIOUjSKDZGMblqAlA0WQiFjJChl0w9qgYqAIk+HGVqZdAsK2sJDKsOWG8t/zvO/z
        /J7f7/0g0Lh+XEIUG62cxcjqKTwac11JSkppfsOnlXtCsbQv0InTwZUJnB6aPYXRI5cXMLpx
        cQWl+z+dQWnnlAuhxy85cNo+2YfT7d5HyP5oZtyfw7T2BxHm+m/9OFPvHATMw+6TOLM09zvG
        3O/ZyVQP2hHmu85WNFecV5Kh49hCziLljAWmwmJjUSaV86bmFY1SJVekKNT0S5TUyBq4TOrg
        67kp2cX6cKOU9D1WXxpeymV5ntrzcobFVGrlpDoTb82kOHOh3pxmlvGsgS81FsmMnDVdIZfv
        VYaF+SW6uuq7qDn05PFZ+220AlRuqQFiApJpcGDEHlUDook40g1gRaAeEcg9ANfOXwcCWQbQ
        +4Ub37AElj5+rBoAcKbPLxJIEED/6r2oiAonU2Bfqw2PbCSQfwN4u3FoPQUlewG86BpbryUm
        D8D+gAuJ4HgyB/406sIiGCOfhw1ff4VGcAyphmtznYiAY6HvQmBdg5LPwu/nHajQkxSuzLWJ
        IjiBTIfd7R6RoEmEweGr68GQ9BOww30uTIgwOQinA/sEbzy86+2NErAEBk/bHksY6PxHIizr
        4Hx7NxBwFhz0O7CIBCWTYPelPULSVvhJKIAIzhh40hYnqF+AlQsTmIC3wwa7XbRRvO7RB/Vg
        V9OmsZo2jdW0qf2m/7M+A1gHeIYz84YijleaFUau7L/7LjAZesD6M05+tQ/M3FyUeQBCAA+A
        BEolxGie82rjYgrZ98s5i0ljKdVzvAcow2fdgEqeKjCF/4HRqlGkqeVpKpUqTZ2qUlCJMa9N
        9GjjyCLWypVwnJmzbPgQQiypQJCBxqOB9Csjh8fLlIfcY160auLEi08f2X3tmOGbnWZDtKxj
        6xP25S8DHvP03tPXsrcZmAMzTVNjN6/e/6O14lR58VmJlBzu6PqRbHv7cJd7tXbcX523u5Lb
        bnL+YPTEn8mDyNplqnl/fpRm6PhU6p1a3+yH9knnUkB9rAVjiW8f7CO28CFHbPehmUTKtBj7
        gO8raz4r21GO4P6QMts5GS/peljnuDGam2cbPpKv+fMt/Rmdx2GHJ+aTb53P+mW6VR2y+Y5+
        3nNxW0ntO+cyen9N+uvnd5ez1hbujK1ql/HgR15sCCo7UtSjVeIWm9u+o+1W1Y3UGtGituVC
        /vwuP4XxOlaRjFp49l+gTFSRTwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvO6coJNJBm/vqlicfLKGzeLlz6ts
        FgcfdrJYnN7/jsVi2oefzBZ7Zt9ltlh0YxuTxeVdc9gsuq/vYLNYfvwfkwOXx+Ur3h6L97xk
        8rhzbQ+bx4RFBxg9vq/vYPP4+PQWi8fnTXIe7Qe6mTy2rlnMHMAZxWWTkpqTWZZapG+XwJXR
        1/6KueA3T8XD7sfMDYzN3F2MnBwSAiYSTz62MHUxcnEICexmlFgwdTorREJa4vrGCewQtrDE
        yn/P2SGKnjNKnHtwFSzBJqArsWNxGxtIQkTgI6PEtuMrGUEcZoEdjBL/3txkhWiZzChxaOFX
        sLmcAk4Se55sYwKxhQW8Jc6c38YCYrMIqEhMXLeaGcTmFbCU+P90DROELShxcuYToBoOoKl6
        Em0bGUHCzALyEtvfzmGGOE9B4ufTZWDjRQSsJNYvP8QKUSMu8fLoEfYJjMKzkEyahTBpFpJJ
        s5B0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERyVWpo7GLev+qB3iJGJg/EQ
        owQHs5IIb7zy8SQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4
        OKUamI6veCD5/fK7suTbri8vuRbvM3W9xpe697D675mdfs4GN/bpa4YtyvkakLv30dXrL/g2
        TN4870HcT5bCvzmtUVNy+dOeL/y5ePnpTY7mQuuDNovnr5978L5Y/t+l99fIPOYQnWfI2VOp
        +fwz45rDX2513p0lcJGfI4Dz2APt9vVPEkXibjWn3N29PP3SU7um35MCp+bMsd382mHFxW9b
        ll1qzPF690NsyyTr7ErDJxxbF+hNf/rK9lrJer7pByLXzGjc8YDNzcB1ls3zM7UlDw1i2HmP
        OfWmqxclXrwmuUjK5kB9WFvUIZ6lpdvOzmj7UN6qveuahO6nnuX9O26q9an6/yu98P/MQc6b
        T6wm7LOIVGIpzkg01GIuKk4EAB61T4E5AwAA
X-CMS-MailID: 20220709100412epcas5p2ec6d9cdac81a2f38ca862165648e4194
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220708235759epcas5p3705680d639a85558bdbc26d827deb563
References: <CGME20220708235759epcas5p3705680d639a85558bdbc26d827deb563@epcas5p3.samsung.com>
        <20220709000027.3929970-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Bjorn Andersson [mailto:bjorn.andersson@linaro.org]
>Sent: Saturday, July 9, 2022 5:30 AM
>To: Alim Akhtar <alim.akhtar@samsung.com>; Avri Altman
><avri.altman@wdc.com>; Bart Van Assche <bvanassche@acm.org>; James
>E.J. Bottomley <jejb@linux.ibm.com>; Martin K. Petersen
><martin.petersen@oracle.com>
>Cc: Bean Huo <beanhuo@micron.com>; Adrian Hunter
><adrian.hunter@intel.com>; Yue Hu <huyue2@yulong.com>; linux-
>scsi@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [PATCH] scsi: ufs: ufshcd: Drop loglevel of WriteBoost message
>
>Commit '3b5f3c0d0548 ("scsi: ufs: core: Tidy up WB configuration code")'
>changed the log level of the write boost enable/disable notification from
>debug to info, this results in a lot of noise in the kernel log during
normal
>operation.
>
>Drop it back to debug level to avoid this.
>
>Fixes: 3b5f3c0d0548 ("scsi: ufs: core: Tidy up WB configuration code")
>Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> drivers/ufs/core/ufshcd.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
>22042ee3af14..be65d5bf123e 100644
>--- a/drivers/ufs/core/ufshcd.c
>+++ b/drivers/ufs/core/ufshcd.c
>@@ -5747,7 +5747,7 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool
>enable)
> 	}
>
> 	hba->dev_info.wb_enabled = enable;
>-	dev_info(hba->dev, "%s Write Booster %s\n",
>+	dev_dbg(hba->dev, "%s Write Booster %s\n",
> 			__func__, enable ? "enabled" : "disabled");
>
> 	return ret;
>--
>2.35.1


