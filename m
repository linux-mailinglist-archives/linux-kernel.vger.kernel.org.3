Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8847757908C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiGSCHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbiGSCH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:07:26 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA52E3CBF1;
        Mon, 18 Jul 2022 19:07:21 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IM6Jb6020769;
        Mon, 18 Jul 2022 19:07:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=jfyPUay4vdlY2wbJjo0EIhVwHezxBiYRmPBUyNCQMIs=;
 b=eXS/TW8GnLLbEUPRg+W+gcvR4NTjzxx1CtQC918RjG/Y2HwiIWAu24x5R6fdDYy7mX+y
 AoJkb4gW2xIg+vfSqB2J25so/0o1tcQUz+fKRfAJvFVnqEKOO0Yz30wVqt+4kYXKqQDj
 da/AsaUG0ULuukmS0h6Bw2Dc024Sg2SRH745yUo1NM4pz5Wbd2vng5A4XU8K4ZNsEFnr
 zsgqjO/DTlBYZ8f+ZaQN3H+QseAJPv+iDeeXRG3JQ3suRbWT83A4z+7X9zndhSTWyVlh
 J2gAZROT9etAJI30xCC3DOmuUMIl9GWz7VOhPLJFXcagZXnVG5nFwHUNCbGTXqJv1nHl 7A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3hc6c349ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 19:07:15 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 465EBC0649;
        Tue, 19 Jul 2022 02:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658196434; bh=wiOq5LEF/yNaIM4h+LuNwuRf93wV7htfSQbdTsNLLyg=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Z1XaYkBFs3g/FYEzwsUTxUCCmXMNxhOCSmP1H56tt3uOqcW/n95EEAomVOOJ2wNAu
         eO6qS+t4i4T/oXMY0rUN0i41zyYGuESzXW32n+BaVxzxwx4QXH5QfttADo0v6cgOGJ
         y7DdIrKlm8sr7G97NQ3VpxSVNj92QLXaFsRmKO8WXU9aFUAJ7S4LbWi26ly0KuhfdK
         Cf9aqlwvWOpedu/EaVle2hz30oJ3EDn0+Z0Z92nkIUvKB8un4Gq+bM6IhkL6KWi3WT
         BbVKYlgXYMjVO5x4roxdA1ubLut114q/HbDioUuwox31DhFymSUO92uW/QMl2UmlE/
         NmY/aAkNR0ftw==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 99686A0096;
        Tue, 19 Jul 2022 02:07:12 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 19:07:12 -0700
Date:   Mon, 18 Jul 2022 19:07:12 -0700
Message-Id: <dcd65bce0999bdbe12adda3f2664212c6e9143b9.1658195608.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658195608.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658195608.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 3/4] target: Properly set Sense Data Length of CHECK CONDITION
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Youn <John.Youn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org
X-Proofpoint-ORIG-GUID: DPVXNtbCoUv-U4kfT-KLS-yaWAx3-mPS
X-Proofpoint-GUID: DPVXNtbCoUv-U4kfT-KLS-yaWAx3-mPS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=854 phishscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CHECK CONDITION returns sense data, and sense data is minimum 8 bytes
long plus additional sense data length in the data buffer. Don't just
set the allocated buffer length to the cmd->scsi_sense_length and check
the sense data for that.

See SPC4-r37 section 4.5.2.1.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - Make sure it doesn't overflow and properly pass TRANSPORT_SENSE_BUFFER to
   scsi_set_sense_information()

 drivers/target/target_core_transport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 8c386142ef90..db53b326048d 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3459,12 +3459,19 @@ static void translate_sense_reason(struct se_cmd *cmd, sense_reason_t reason)
 
 	cmd->se_cmd_flags |= SCF_EMULATED_TASK_SENSE;
 	cmd->scsi_status = SAM_STAT_CHECK_CONDITION;
-	cmd->scsi_sense_length  = TRANSPORT_SENSE_BUFFER;
+
 	scsi_build_sense_buffer(desc_format, buffer, key, asc, ascq);
 	if (sd->add_sense_info)
 		WARN_ON_ONCE(scsi_set_sense_information(buffer,
-							cmd->scsi_sense_length,
+							TRANSPORT_SENSE_BUFFER,
 							cmd->sense_info) < 0);
+	/*
+	 * CHECK CONDITION returns sense data, and sense data is minimum 8
+	 * bytes long plus additional Sense Data Length.
+	 * See SPC4-r37 section 4.5.2.1.
+	 */
+	cmd->scsi_sense_length = min_t(u16, buffer[7] + 8,
+				       TRANSPORT_SENSE_BUFFER);
 }
 
 int
-- 
2.28.0

