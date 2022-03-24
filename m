Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CBD4E5F17
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347313AbiCXHJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbiCXHJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:09:38 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B197167FC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:08:06 -0700 (PDT)
Received: from epcas3p1.samsung.com (unknown [182.195.41.19])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220324070804epoutp04d9bff6c1707b9e5b7207ffe39cfa659d~fP2NKuMRN0876608766epoutp04w
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:08:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220324070804epoutp04d9bff6c1707b9e5b7207ffe39cfa659d~fP2NKuMRN0876608766epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648105684;
        bh=ffNIsUV0dGzaaQ3R/vm5F/lFr5vlgbrv3cLPh72mp0M=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=PhPMcQoYm/J1/tENWR2tnP6STywWdlSknKCRHh3YP7FlsGLAAMLF+btb+4pdbsfta
         3F/HLQxg1QFy4S6XXc2aEdfM62M9oeU3+EuyRQAsfsFmCGRrHXhmqT03V6oPQATvo3
         9lZZUeYpHbPyPs5LqQXq3a2gyDRBueBH9CBhC5sA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas3p4.samsung.com (KnoxPortal) with ESMTP id
        20220324070803epcas3p4a9b366231c0c91cffac1cc571a4f917b~fP2Mqlbk21705917059epcas3p4-;
        Thu, 24 Mar 2022 07:08:03 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp3.localdomain
        (Postfix) with ESMTP id 4KPGX35N54z4x9QT; Thu, 24 Mar 2022 07:08:03 +0000
        (GMT)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: core: Remove unused field in struct ufs_hba
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Keoseong Park <keosung.park@samsung.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <413601558.101648105683746.JavaMail.epsvc@epcpadp4>
Date:   Thu, 24 Mar 2022 16:01:46 +0900
X-CMS-MailID: 20220324070146epcms2p577d43ce3e7cbd36aa964f3842e49b2ba
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220324070146epcms2p577d43ce3e7cbd36aa964f3842e49b2ba
References: <CGME20220324070146epcms2p577d43ce3e7cbd36aa964f3842e49b2ba@epcms2p5>
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

Remove unused field "rpm_lvl_attr" and "spm_lvl_attr" in struct ufs_hba.
Commit cbb6813ee771 ("scsi: ufs: sysfs: attribute group for existing
sysfs entries.") removed all code using that field.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/scsi/ufs/ufshcd.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 88c20f3608c2..94f545be183a 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -820,8 +820,6 @@ struct ufs_hba {
 	enum ufs_pm_level rpm_lvl;
 	/* Desired UFS power management level during system PM */
 	enum ufs_pm_level spm_lvl;
-	struct device_attribute rpm_lvl_attr;
-	struct device_attribute spm_lvl_attr;
 	int pm_op_in_progress;
 
 	/* Auto-Hibernate Idle Timer register value */
-- 
2.17.1

