Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1025878C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiHBIKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiHBIKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:10:43 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035CDBE2D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:10:42 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220802081040epoutp04dd0d8ed5d67f792eac7d0993947758b8~HeNQyqfRs0560405604epoutp04e
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:10:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220802081040epoutp04dd0d8ed5d67f792eac7d0993947758b8~HeNQyqfRs0560405604epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659427840;
        bh=WfYURiMfxdscvV155kuVfTOog8MwJWRdwgn+ujFV3oI=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=HSO3lBN8Knyuz9LR0pqvUTKnL8zh0PD4KIMeU9ybibMXxrnL5Zpzou03ZxhcLMW2S
         fYYxYcD0NehWCppejmWmg4sQKNyAD0qqo3pCNG42UIPMqe4N3IGbgu10d5lvIvTixI
         HGsCvuEefUfV/ASWt7YXtcNLATFJR5j7GLWMjvZo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220802081039epcas2p1f09accf349a68b375b6248729253e809~HeNQO46uS2809228092epcas2p1F;
        Tue,  2 Aug 2022 08:10:39 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Lxnjq40Xbz4x9Px; Tue,  2 Aug
        2022 08:10:39 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-b2-62e8dbff4c7a
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.E8.09650.FFBD8E26; Tue,  2 Aug 2022 17:10:39 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v6 6/6] scsi: ufs: wb: Move the comment to the right
 position
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220802081039epcms2p68dbe18151e04103d10bf28751f9ace4e@epcms2p6>
Date:   Tue, 02 Aug 2022 17:10:39 +0900
X-CMS-MailID: 20220802081039epcms2p68dbe18151e04103d10bf28751f9ace4e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmhe7/2y+SDFoOy1icfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/JYunWm4wO3B6Xr3h7
        LN7zksljwqIDjB4tJ/ezeHxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAGZVtk5GamJJapJCa
        l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0rJJCWWJOKVAoILG4WEnf
        zqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+PisnlsBTfYKraf
        +MvWwHictYuRk0NCwETi9t5rQDYXh5DADkaJSetmMHYxcnDwCghK/N0hDFIjLOAvseZBGzOI
        LSSgJHFuzSywEmEBA4lbveYgYTYBPYmfS2awgYwREWhjkTjWuZUZYj6vxIz2pywQtrTE9uVb
        GUFsTgE/iYk3PkDVaEj8WNYLZYtK3Fz9lh3Gfn9sPiOELSLReu8sVI2gxIOfu6HikhKHDn1l
        A7lHQiBfYsOBQIhwjcTb5QegSvQlrnVsBDuBV8BX4lXXebDxLAKqErO/PoAa6SLx4ckZNhCb
        WUBeYvvbOcwgI5kFNCXW79KHmK4sceQWC8xTDRt/s6OzmQX4JDoO/4WL75j3hAmiVU1iUZMR
        RFhG4uvh+ewTGJVmIUJ5FpK1sxDWLmBkXsUollpQnJueWmxUYASP2OT83E2M4DSr5baDccrb
        D3qHGJk4GA8xSnAwK4nw3nF5niTEm5JYWZValB9fVJqTWnyI0RTo4YnMUqLJ+cBEn1cSb2hi
        aWBiZmZobmRqYK4kzuuVsiFRSCA9sSQ1OzW1ILUIpo+Jg1Oqgck11GTTPOWG+1MY/7f69G/8
        0FefEsuyiHfltwNbJp1j2rl/5cSY6VHqGqv9/sR6lB4sCPpdlZvgWM8h1b6txqVEbHPSlOyA
        Hfvee8+6et/gyU0+17JZ5UF3vqsfla9caC84cXnmK+3VbqZHH980syn3OsntmyD4n1M5333X
        IfHM+ylif1xOHJ9V+C+kY4uJQrJHtMe1U68mP2mZfDfwqSHD9rz47X3TvfZMfOtrK3F0SmmF
        yKOVFjwJWnMa3rdqts/rPv5zn0czt1g9n/GC1Orewm5ZBxvlgoO/heZ3aq53KpaZYL429wXz
        1dl2QanZ0V+VNv89GMx1KbrgRPbExPJ8FefXHyTWv5xx4L7wDyWW4oxEQy3mouJEAHF7Ysg8
        BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce
References: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
        <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p6>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The location of the comment is wrong. so fix it.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index dcd7f03db2a2..196f964c0877 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1298,9 +1298,10 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 		}
 	}
 
-	/* Enable Write Booster if we have scaled up else disable it */
 	downgrade_write(&hba->clk_scaling_lock);
 	is_writelock = false;
+
+	/* Enable Write Booster if we have scaled up else disable it */
 	ufshcd_wb_toggle(hba, scale_up);
 
 out_unprepare:
-- 
2.25.1
