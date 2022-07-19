Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17465790DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbiGSC23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiGSC21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:28:27 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AAC3AE74;
        Mon, 18 Jul 2022 19:28:26 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26INawLW011668;
        Mon, 18 Jul 2022 18:28:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=BygQ6+1FH3jCaSFf7qCsSOuQqp/3Wicq5Kz0DudzHSc=;
 b=hAcFbV/GEOeIJWAEXS/eq3UEIy0g4XQhVLx5uVy8abeLgRiultUw48DqDnJPTnZny8Uq
 whSTR5CsllCojd1UP52Z0zDaavvSnPbm61/fBgjIwpCOwNjkO40oDpRqzMDTjyw9Ja1b
 hdf0hTIa7k67GQJFCr7fCR69lvC+C1ymernhu+Wwzzt2i8RUJRFno9/bfL54fQNdQj9C
 DgYARq0v6rZFTFjGj//PC6lHrX38greNm7fovIOQvRvTs8nnjSUZgD2OUCrHwYT9K3Xi
 maXhH+W58jM8+xasoWOZTVesATjeDQdS4ZU/USL5uxPTSopkokAOCLQzmCa6Ukv2Dl4u Ww== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvk5whqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:28:11 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5602440097;
        Tue, 19 Jul 2022 01:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194091; bh=Hu9EZfKQjGaOvgd4CEzDGOBcW56c1F3mlREuvVB3bmg=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=mY3hbt8OThXNhwN/J3LIgKLeNB99vTGyFAQvCR1ZcykQ7C16/GUcHfw54dknU96IT
         jRjsW2fwWGazUg7tT6NwX32t6/oX7JX+HSfvbBloCys6L6OGHzSRRbBx4cL3PZvo28
         J4tQr5Js7Aawl9Oe2fkb79RCqNpLB87RITRGXMWK8HudOw43zWNiTr513ki+o7KwbN
         3WOLfCtod2Lk3RhwmQBchNgfu0AHW8hYz/Coj8xr+45oLZXC3bY6V21k31mrm0L5Ws
         oTdZp6/zj45YE1eIywq/Mp0U8bGnBnwnh6XUK55i/NiWbIg+8kzFrLEIwXBh7o5Nmz
         a1R9QqLQkMeEw==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 34EEBA0096;
        Tue, 19 Jul 2022 01:28:10 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:28:10 -0700
Date:   Mon, 18 Jul 2022 18:28:10 -0700
Message-Id: <a4f8072a44e01c0a512fad001f458471548313a1.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 20/25] usb: gadget: f_tcm: Save CPU ID per command
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-GUID: 9HEe-fpxbqdu5ye2vAoO0qlYKYC5UgS0
X-Proofpoint-ORIG-GUID: 9HEe-fpxbqdu5ye2vAoO0qlYKYC5UgS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=672 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally we don't care about the CPU id, but if we ever use
TARGET_SCF_USE_CPUID, then we need to save the cpuid.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/f_tcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 6cf95c9723a3..084143213176 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1069,6 +1069,7 @@ static struct usbg_cmd *usbg_get_cmd(struct f_uas *fu,
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->se_cmd.map_tag = tag;
 	cmd->se_cmd.map_cpu = cpu;
+	cmd->se_cmd.cpuid = cpu;
 	cmd->se_cmd.tag = cmd->tag = scsi_tag;
 	cmd->fu = fu;
 
-- 
2.28.0

