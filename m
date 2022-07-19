Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFDE579060
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbiGSCCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiGSCCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:02:03 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10FF3B95F;
        Mon, 18 Jul 2022 19:02:02 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26INZLPO002294;
        Mon, 18 Jul 2022 18:26:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=HaG0eGEEJvR0yBp0RO+qatOJAoNJtow+GPziYoQUtGw=;
 b=fbWjcppz4iPuT7JGLFyg/1jj9s94YSqiivYv1Y9LoAuI4a94zeXAXbYhpj1JRoutmRij
 FMOSeMUNMEJsEd5ath565ZPxQWQ7WSMyXUe9EFcC3TeClb7B7Nic2dJq9MB+yX5InrjV
 DQuP+7my4hmfJxmKIhN29k2/HygyzXT3cl8A2SgaLDwQ5S1Hdyu+NQBpt5QZMf9mF4in
 va23lhlgE8h/FFu6u5cnIEH5PFBrfdy9DUuQZj9qgmclSKS1i+Olk2SCt/EH5+3M9vni
 cyGKI4oya2rxjGlN++VxgOBmfOTnGrGpAqzFYSE4lywQJlfvXDbGKBm3PPDH86XNaHn+ 7w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvbmwhna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:26:19 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 55A054008A;
        Tue, 19 Jul 2022 01:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658193978; bh=89Zu00Axch/Lemrn6fD8kbfnRTfQLFsKhC9ceaKXyYE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=I7x8kuV7vaXnugM32sr3x0HnqJwDHG3a4T75S4WpvtIMW1o6SQsEwlgdwh0sFEE6s
         mZeRAyCRd4cdHrFvp+x55DSEYspZ8D/lj/I8WRlyzxY4oOpEp4iFo0JjVNsHUSHQ82
         4ou+ZOvq56yjpzZ6giVDogYnT9atp477JASsGhKNTDwwJHbEu3WqVdvP/rOz12VlwU
         tIh/1tviJSh1n80Q+BmUYVNkVFNIqRfh0dHc0VCrh6r4Gw1w4XDVNTbPOUhIeAwweF
         Gyyy8M0BfOHcgdeU10oCKGYnJH2CCvqiHpAzO353Wmb3dcS9M2WJpirWkL5K3+/46N
         wri7FXqYnR+JA==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id C972BA0096;
        Tue, 19 Jul 2022 01:26:16 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:26:16 -0700
Date:   Mon, 18 Jul 2022 18:26:16 -0700
Message-Id: <27f3e2ced002bd9b738f4245f7e9b674b3bb3436.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 02/25] target: Add common TMR enum
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Youn <John.Youn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org
X-Proofpoint-GUID: aVrnOJ595mQX0UtRmL_dPolrnck9jPBo
X-Proofpoint-ORIG-GUID: aVrnOJ595mQX0UtRmL_dPolrnck9jPBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following common TMR enum:
* TMR_I_T_NEXUS_RESET
* TMR_QUERY_TASK
* TMR_QUERY_TASK_SET
* TMR_QUERY_ASYNC_EVENT

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - Changed enum numbering to continue from 8, 9, 10, ...

 drivers/target/target_core_transport.c | 10 ++++++++++
 include/target/target_core_base.h      |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 7838dc20f713..92cb4a4a9ab9 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3094,6 +3094,10 @@ static const char *target_tmf_name(enum tcm_tmreq_table tmf)
 	case TMR_TARGET_WARM_RESET:	return "TARGET_WARM_RESET";
 	case TMR_TARGET_COLD_RESET:	return "TARGET_COLD_RESET";
 	case TMR_LUN_RESET_PRO:		return "LUN_RESET_PRO";
+	case TMR_I_T_NEXUS_RESET:	return "I_T_NEXUS_RESET";
+	case TMR_QUERY_TASK:		return "QUERY_TASK";
+	case TMR_QUERY_TASK_SET:	return "QUERY_TASK_SET";
+	case TMR_QUERY_ASYNC_EVENT:	return "QUERY_ASYNC_EVENT";
 	case TMR_UNKNOWN:		break;
 	}
 	return "(?)";
@@ -3542,6 +3546,12 @@ static void target_tmr_work(struct work_struct *work)
 	case TMR_TARGET_COLD_RESET:
 		tmr->response = TMR_FUNCTION_REJECTED;
 		break;
+	case TMR_I_T_NEXUS_RESET:
+	case TMR_QUERY_TASK:
+	case TMR_QUERY_TASK_SET:
+	case TMR_QUERY_ASYNC_EVENT:
+		tmr->response = TMR_FUNCTION_REJECTED;
+		break;
 	default:
 		pr_err("Unknown TMR function: 0x%02x.\n",
 				tmr->function);
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 8e3da143a1ce..b3e3125fac97 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -211,6 +211,10 @@ enum tcm_tmreq_table {
 	TMR_LUN_RESET		= 5,
 	TMR_TARGET_WARM_RESET	= 6,
 	TMR_TARGET_COLD_RESET	= 7,
+	TMR_I_T_NEXUS_RESET	= 8,
+	TMR_QUERY_TASK		= 9,
+	TMR_QUERY_TASK_SET	= 10,
+	TMR_QUERY_ASYNC_EVENT	= 11,
 	TMR_LUN_RESET_PRO	= 0x80,
 	TMR_UNKNOWN		= 0xff,
 };
-- 
2.28.0

