Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C26557906F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbiGSCGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbiGSCGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:06:00 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F6F63CA;
        Mon, 18 Jul 2022 19:05:58 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ILfl1i029330;
        Mon, 18 Jul 2022 18:26:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=yAZZWy276p5sPzjI5n0T4dZwrfUn0k9KxJke9IIfpLc=;
 b=dDzOOfQTLoPATVIcpdwXN3/dCaAxZT8F9MPHHeZD8T6/hH01YVz5QZ5U9BgfR5RFIWEM
 v8AcpReDNRoXGONXS/MnZcYVRYxc/FDQv/6Eumi0Rz/7XrRZ6+nStzMHWda5hY5sUoih
 IA7cjKtwzrWnykR3lZ2dSsiNcKMDJAlWNEuJut+lsBx38VX8SIWuiTdjMA9LwuEzmRGs
 Xht/7x2rkYWJaD9ohKqmNHwl7brBoSwlSKPKb5/qdZ/N1Y6H5htpBI+bDIZq7hMXewZX
 yPIJEacYCGDhg7xKuF8JVxonrIyB6/jpGlUCouPwvpq6H1ZZdwW7//ll18V5jQo6aESr Ag== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hc6dec5dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:26:12 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E8CD7C0649;
        Tue, 19 Jul 2022 01:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658193971; bh=DLunloD49fKZwbypsH/3t3UFeb+X8d/VWtL3un/nSYg=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=DcFYJbpmwGV6SyerL6pw+LlE/I+yPcjULjArP/feALOe7ZiqaCnK4xfOusa64YW4W
         DSAap0+rrgRw8LTFq33hm2yIxrbU0N4u5D9LkbTTCGGDG8/tza+6fq4hYjZHjWAJf+
         brq/3U+Lo+XAk2bteYSexHCP6Y2hI2omLKS19NTSIahdouWNKpwFFc7rMKEf0VItXX
         gAD+4hq7peC8F7aduFCWw9gfBXcV1Vv73tPDXHA1EsebyKwn54kAG6pMp9RLOMgIW2
         T+8EppgfHAUzO49HuQNWG5oLkCZVAf05EMqYZ9kKAnypJIDIPvAWAVXKhjTinA2JJE
         xrTK7PDIXoUmQ==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id AE426A0068;
        Tue, 19 Jul 2022 01:26:10 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:26:10 -0700
Date:   Mon, 18 Jul 2022 18:26:10 -0700
Message-Id: <1dbdd36fdcc823dc0a7185cc120073cbdc299c77.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 01/25] target: Add overlapped response to tmrsp_table
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org
X-Proofpoint-ORIG-GUID: amv1Yam69oRupuv322c88zNYZPULSD3k
X-Proofpoint-GUID: amv1Yam69oRupuv322c88zNYZPULSD3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TMR_OVERLAPPED_TAG_ATTEMPTED response to tmrsp_table.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 include/target/target_core_base.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index c2b36f7d917d..8e3da143a1ce 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -223,6 +223,7 @@ enum tcm_tmrsp_table {
 	TMR_LUN_DOES_NOT_EXIST		= 3,
 	TMR_TASK_MGMT_FUNCTION_NOT_SUPPORTED	= 4,
 	TMR_FUNCTION_REJECTED		= 5,
+	TMR_OVERLAPPED_TAG_ATTEMPTED	= 6,
 };
 
 /*
-- 
2.28.0

