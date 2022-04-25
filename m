Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8070150D823
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbiDYEMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbiDYELV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:11:21 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0521018E09
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 21:08:04 -0700 (PDT)
Received: from epcas3p3.samsung.com (unknown [182.195.41.21])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220425040802epoutp04efa6495cc299c63a432105febf21996d~pCCJ872We0051000510epoutp04g
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:08:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220425040802epoutp04efa6495cc299c63a432105febf21996d~pCCJ872We0051000510epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650859682;
        bh=QRctrX1LwDMho3rISDlMf38L36bD3iV1OASpJeXgj0s=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=OHgp/vD49yE4ISPCMp77gQrKAGMa9X6lCQyVI0rKCYcdcbih+O4kkACKGLRX9qXZT
         2U2PZmrpgIeqbdUBZYGBrx00BHl7MaRfWCj+3XIK2FUohmGOEd0VT6k2+9GbPrm+ef
         P3kpbWMxwgg2DdDqf96iW5IhpmZm8pUhEC983fDk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas3p1.samsung.com (KnoxPortal) with ESMTP id
        20220425040801epcas3p1c2fc1a3525c985394bc805f006600aae~pCCJRVYlD1934719347epcas3p1d;
        Mon, 25 Apr 2022 04:08:01 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp2.localdomain
        (Postfix) with ESMTP id 4Kms1Y6BXRz4x9QB; Mon, 25 Apr 2022 04:08:01 +0000
        (GMT)
Mime-Version: 1.0
Subject: RE: [PATCH v3 4/6] scsi: ufshpb: Change sysfs node hpb_stats/rb_*
 prefix to start with rcmd_*
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     Bean Huo <huobean@gmail.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        cpgsproxy3 <cpgsproxy3@samsung.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220424220713.1253049-5-huobean@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1891546521.01650859681867.JavaMail.epsvc@epcpadp4>
Date:   Mon, 25 Apr 2022 12:43:53 +0900
X-CMS-MailID: 20220425034353epcms2p351319a732aa3dca5c3c7b81e8d1c1749
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220424220757epcas2p37d7fcf3c58b1c29291f6e6765e6690ed
References: <20220424220713.1253049-5-huobean@gmail.com>
        <20220424220713.1253049-1-huobean@gmail.com>
        <CGME20220424220757epcas2p37d7fcf3c58b1c29291f6e6765e6690ed@epcms2p3>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Bean Huo <beanhuo@micron.com>
> 
>According to the documentation of the sysfs nodes rb_noti_cnt, rb_active_cnt
>and rb_inactive_cnt, they are all related to HPB recommendation in UPIU response
>packet. I don't know what 'rb' refers to, I think 'rcmd'
>(recommendation) should be the correct abbreviation.
> 
>Change the sysfs documentation about these sysfs nodes to highlight what they mean
>under different HPB control modes.
I think it's better than what I suggested.

> 
>Signed-off-by: Bean Huo <beanhuo@micron.com>
>---
> Documentation/ABI/testing/sysfs-driver-ufs | 18 +++++++++-------
> drivers/scsi/ufs/ufshpb.c                  | 24 +++++++++++-----------
> drivers/scsi/ufs/ufshpb.h                  |  6 +++---
> 3 files changed, 26 insertions(+), 22 deletions(-)
> 
>diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
>index a44ef8bfbadf..6b248abb1bd7 100644
>--- a/Documentation/ABI/testing/sysfs-driver-ufs
>+++ b/Documentation/ABI/testing/sysfs-driver-ufs
>@@ -1518,7 +1518,7 @@ Description:        This entry shows the number of reads that cannot be changed to
> 
>                 The file is read only.
> 
>-What:                /sys/class/scsi_device/*/device/hpb_stats/rb_noti_cnt
>+What:                /sys/class/scsi_device/*/device/hpb_stats/rcmd_noti_cnt
> Date:                June 2021
> Contact:        Daejun Park <daejun7.park@samsung.com>
> Description:        This entry shows the number of response UPIUs that has
>@@ -1526,19 +1526,23 @@ Description:        This entry shows the number of response UPIUs that has
> 
>                 The file is read only.
> 
>-What:                /sys/class/scsi_device/*/device/hpb_stats/rb_active_cnt
>+What:                /sys/class/scsi_device/*/device/hpb_stats/rcmd_active_cnt
> Date:                June 2021
> Contact:        Daejun Park <daejun7.park@samsung.com>
>-Description:        This entry shows the number of active sub-regions recommended by
>-                response UPIUs.
>+Description:        For the HPB device control mode, this entry shows the number of
>+        active sub-regions recommended by response UPIUs. For the HPB host control
>+        mode, this entry shows the number of active sub-regions recommended by the
>+        HPB host control mode heuristic algorithm.
Please check indentation.

> 
>                 The file is read only.
> 
>-What:                /sys/class/scsi_device/*/device/hpb_stats/rb_inactive_cnt
>+What:                /sys/class/scsi_device/*/device/hpb_stats/rcmd_inactive_cnt
> Date:                June 2021
> Contact:        Daejun Park <daejun7.park@samsung.com>
>-Description:        This entry shows the number of inactive regions recommended by
>-                response UPIUs.
>+Description:        For the HPB device control mode, this entry shows the number of
>+        inactive regions recommended by response UPIUs. For the HPB host control
>+        mode, this entry shows the number of inactive regions recommended by the
>+        HPB host control mode heuristic algorithm.
Please check indentation.

> 
>                 The file is read only.
> 
>diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
>index f1f30d4c3d65..e7f311bb4401 100644
>--- a/drivers/scsi/ufs/ufshpb.c
>+++ b/drivers/scsi/ufs/ufshpb.c
>@@ -563,7 +563,7 @@ static void ufshpb_update_active_info(struct ufshpb_lu *hpb, int rgn_idx,
>         if (list_empty(&srgn->list_act_srgn))
>                 list_add_tail(&srgn->list_act_srgn, &hpb->lh_act_srgn);
> 
>-        hpb->stats.rb_active_cnt++;
>+        hpb->stats.rcmd_active_cnt++;
> }
> 
> static void ufshpb_update_inactive_info(struct ufshpb_lu *hpb, int rgn_idx)
>@@ -580,7 +580,7 @@ static void ufshpb_update_inactive_info(struct ufshpb_lu *hpb, int rgn_idx)
>         if (list_empty(&rgn->list_inact_rgn))
>                 list_add_tail(&rgn->list_inact_rgn, &hpb->lh_inact_rgn);
> 
>-        hpb->stats.rb_inactive_cnt++;
>+        hpb->stats.rcmd_inactive_cnt++;
> }
> 
> static void ufshpb_activate_subregion(struct ufshpb_lu *hpb,
>@@ -1321,7 +1321,7 @@ void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
>         if (!ufshpb_is_hpb_rsp_valid(hba, lrbp, rsp_field))
>                 return;
> 
>-        hpb->stats.rb_noti_cnt++;
>+        hpb->stats.rcmd_noti_cnt++;
> 
>         switch (rsp_field->hpb_op) {
>         case HPB_RSP_REQ_REGION_UPDATE:
>@@ -1724,18 +1724,18 @@ static DEVICE_ATTR_RO(__name)
> 
> ufshpb_sysfs_attr_show_func(hit_cnt);
> ufshpb_sysfs_attr_show_func(miss_cnt);
>-ufshpb_sysfs_attr_show_func(rb_noti_cnt);
>-ufshpb_sysfs_attr_show_func(rb_active_cnt);
>-ufshpb_sysfs_attr_show_func(rb_inactive_cnt);
>+ufshpb_sysfs_attr_show_func(rcmd_noti_cnt);
>+ufshpb_sysfs_attr_show_func(rcmd_active_cnt);
>+ufshpb_sysfs_attr_show_func(rcmd_inactive_cnt);
> ufshpb_sysfs_attr_show_func(map_req_cnt);
> ufshpb_sysfs_attr_show_func(umap_req_cnt);
> 
> static struct attribute *hpb_dev_stat_attrs[] = {
>         &dev_attr_hit_cnt.attr,
>         &dev_attr_miss_cnt.attr,
>-        &dev_attr_rb_noti_cnt.attr,
>-        &dev_attr_rb_active_cnt.attr,
>-        &dev_attr_rb_inactive_cnt.attr,
>+        &dev_attr_rcmd_noti_cnt.attr,
>+        &dev_attr_rcmd_active_cnt.attr,
>+        &dev_attr_rcmd_inactive_cnt.attr,
>         &dev_attr_map_req_cnt.attr,
>         &dev_attr_umap_req_cnt.attr,
>         NULL,
>@@ -2098,9 +2098,9 @@ static void ufshpb_stat_init(struct ufshpb_lu *hpb)
> {
>         hpb->stats.hit_cnt = 0;
>         hpb->stats.miss_cnt = 0;
>-        hpb->stats.rb_noti_cnt = 0;
>-        hpb->stats.rb_active_cnt = 0;
>-        hpb->stats.rb_inactive_cnt = 0;
>+        hpb->stats.rcmd_noti_cnt = 0;
>+        hpb->stats.rcmd_active_cnt = 0;
>+        hpb->stats.rcmd_inactive_cnt = 0;
>         hpb->https://protect2.fireeye.com/v1/url?k=9b807207-fa0b6728-9b81f948-74fe485cbfe7-c8e650b167f03dee&q=1&e=ec9d9a5f-605d-45e5-b145-e3a4c9a96f3e&u=http%3A%2F%2Fstats.map%2F_req_cnt = 0;
It's not related to the patch, but the code seems to be wrong.

>         hpb->stats.umap_req_cnt = 0;
> }
>diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
>index b83b9ec9044a..0d6e6004d783 100644
>--- a/drivers/scsi/ufs/ufshpb.h
>+++ b/drivers/scsi/ufs/ufshpb.h
>@@ -211,9 +211,9 @@ struct ufshpb_params {
> struct ufshpb_stats {
>         u64 hit_cnt;
>         u64 miss_cnt;
>-        u64 rb_noti_cnt;
>-        u64 rb_active_cnt;
>-        u64 rb_inactive_cnt;
>+        u64 rcmd_noti_cnt;
>+        u64 rcmd_active_cnt;
>+        u64 rcmd_inactive_cnt;
>         u64 map_req_cnt;
>         u64 pre_req_cnt;
>         u64 umap_req_cnt;
>-- 
>2.34.1
> 
> 
Apart from the indentation, the patch looks good to me, so once
you've fixed them, feel free to add my:

Reviewed-by: Keoseong Park <keosung.park@samsung.com>

Best Regards,
Keoseong Park
