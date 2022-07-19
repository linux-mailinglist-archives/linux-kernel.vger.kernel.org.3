Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911C757908E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiGSCHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbiGSCH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:07:29 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384DF3DF18;
        Mon, 18 Jul 2022 19:07:26 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J1JOY9002282;
        Mon, 18 Jul 2022 19:07:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=SO+Ozr9/sPtknW4Dm2IkfjhqY8KkDi0uGbNsxMi0Luw=;
 b=DHfN+lJthYr91oMkuIQEI99WM+x8Kjt9GNqpYmE1Z/X5nEcBmgVC6ex4Ecpga7/Ilzvf
 aqCbKO9S8UDQZCCwQq8iQnqDvllKoGocuSpkJyqqAc2J7njw9Wgkd0S2HJnuzPnXFYR9
 oEPQzJnaRhGhSWCWX3Fj1CgQIBRujKu2vBPLwtIRl27sf/8AXkXX1Tw/ZJ1K5kyx9xxY
 OM6CMcPOlolUNZnWFrZvoAgiI3by3ssQ4s8qlFVmiSR5TqfPLY0XyVqPDIbtVful+BRj
 2D/N6FoaY2TFEQeu4oKRxbGC3VQtuNi/fxdhHm+0ANUaKzicMUKvLLE8ir4OosEVQf1n Rw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvbmwp4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 19:07:20 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 432F34008A;
        Tue, 19 Jul 2022 02:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658196440; bh=12PH3KrZuQ0fN8QB633gu08Ms0Ej1Uos3YJGTPWL0BI=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=fPToFenfChGBl6tQA33x51J0+UMO+wVl8tr0rRWXYkHVKzEKVxsp15fLC5g6QHL4u
         9KPOfQqJQIGbohI7HfXEaV3zvvjK+zMEKSsBlTBOf+DkY0jy0ffS552DNo5aiWx10j
         dEjH9CoMvBsITw5NpdCZcy2Amcz6l/LzxE0I51Ql870SmT+p0E5YgK83SMzeYLvcpz
         /CqzRByaB25zvMxhcCxDBi7tVrbGXDdfdPS7xTuuoGuw0qcjp6YD6f2Yx9kVsrmua7
         8SKMjdTMZ2ztLBuovoDgAXTUIw3bYsloE992We3Nayq1hwduFeyStfUOoXcZG8Ju6A
         RK+29TWqRbQEQ==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 23754A0062;
        Tue, 19 Jul 2022 02:07:19 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 19:07:19 -0700
Date:   Mon, 18 Jul 2022 19:07:19 -0700
Message-Id: <71ea0c365383e038b7eb6a638faf45a7345fcb33.1658195984.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658195984.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658195984.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 4/4] target: Properly set Sense data length when copy sense
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Youn <John.Youn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org
X-Proofpoint-GUID: 82IDjKJFH3kYKSM0h1cE1uCoz1GHQyAA
X-Proofpoint-ORIG-GUID: 82IDjKJFH3kYKSM0h1cE1uCoz1GHQyAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The transport_get_sense_buffer() sets sense data length to be the
allocated sense buffer length TRANSPORT_SENSE_BUFFER. However, the sense
data length is depending on the sense data description. Check the sense
data for cmd->scsi_sense_length.

See SPC4-R37 section 4.5.2.1.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - Only memcpy sense data length rather than the entire TRANSPORT_SENSE_BUFFER.

 drivers/target/target_core_transport.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index db53b326048d..95b7788e7cbc 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -771,8 +771,6 @@ static unsigned char *transport_get_sense_buffer(struct se_cmd *cmd)
 	if (cmd->se_cmd_flags & SCF_SENT_CHECK_CONDITION)
 		return NULL;
 
-	cmd->scsi_sense_length = TRANSPORT_SENSE_BUFFER;
-
 	pr_debug("HBA_[%u]_PLUG[%s]: Requesting sense for SAM STATUS: 0x%02x\n",
 		dev->se_hba->hba_id, dev->transport->name, cmd->scsi_status);
 	return cmd->sense_buffer;
@@ -791,6 +789,11 @@ void transport_copy_sense_to_cmd(struct se_cmd *cmd, unsigned char *sense)
 	}
 
 	cmd->se_cmd_flags |= SCF_TRANSPORT_TASK_SENSE;
+
+	/* Sense data length = min sense data + additional sense data length */
+	cmd->scsi_sense_length = min_t(u16, cmd_sense_buf[7] + 8,
+				       TRANSPORT_SENSE_BUFFER);
+
 	memcpy(cmd_sense_buf, sense, cmd->scsi_sense_length);
 	spin_unlock_irqrestore(&cmd->t_state_lock, flags);
 }
-- 
2.28.0

