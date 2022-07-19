Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CAC5790A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbiGSCMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiGSCMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:12:33 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704BB3CBF1;
        Mon, 18 Jul 2022 19:12:32 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IMtTBx002288;
        Mon, 18 Jul 2022 18:28:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=COQI1joPVzY6z+LSK+qBe+EhRAlVvI0mDGN7HZSpcO4=;
 b=GrxUNfNUIGNPcGcb1TsR2lJeud8fJGMoe5h/Go6nTVq2U5EC0jh3dRLMfhh9YE20+4RM
 XaXR+x532l1QgWEVeDtmKPfTFuPBpjY4/YmQ7xT3O7tA0+k7o/h29n1st3mn1W+oSBBW
 teGMxMza/TKRmXPP1YUKVxxZZ5qWep/GHsYYS4GwXMxSA70YV6DY9UuuDA594XxNUy+1
 y8ivxwWwa6+3/6zE337g1dutM20I75snDjIkVEnc4ESbZWK1sT3yxnYBXOnaP4axqd8Z
 UqXO3DYqfwms+J6YMAXpBrQBoDYlpD3GjlEvBgTqiiT1sLYIGBXc+J2qaHd6TjdgyMg0 4A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvbmwhve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:28:24 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AB42D4008A;
        Tue, 19 Jul 2022 01:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194103; bh=cKiEzj0MB8Y/2NbCc7NTZJ2ZmmooMzpVd2l2YHy7B+o=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=eNZLR6jLLgI8LDnCzLNYrp6u/LG4OoKRHirjl1M/enYZE9npDSHl8kcvEc+PQwWyi
         ZmMKfQp2AM0uJZlnnl/A/G9R5RYDGCres/DCZtrQsKYz9R82KxM3Jc/aMv2Y0prTVQ
         cRuDk+uysMPyl0lCJBpvNJzNhrWfc0jOn/yA37lrrhWRj2p6VqDVQ2VU5q4SWxOuug
         kKfk775h9hAbC/n+dTVZms/hYwPC+fJh6vimLEWfzbBobBQWOpj4orzPOVzkNLlIXr
         pxRQtyeJcvqDjhUA/xStkDqNiu+y4e6O4iaKDsfeGgimaNbeSVu0KCgYMtjsJQADS4
         aBISDLtUQPC9w==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 6D43FA006D;
        Tue, 19 Jul 2022 01:28:22 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:28:22 -0700
Date:   Mon, 18 Jul 2022 18:28:22 -0700
Message-Id: <ec84af52016cffce8aaea98ae0922075c3c11558.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 22/25] usb: gadget: f_tcm: Send sense on cancelled transfer
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-GUID: tilO8DR2S2fTvM2aQtZFhkd7bH4g4fy4
X-Proofpoint-ORIG-GUID: tilO8DR2S2fTvM2aQtZFhkd7bH4g4fy4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=613 phishscore=0 lowpriorityscore=0 adultscore=0
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

If the transfer is cancelled due to a disconnect or driver tear down
(error code -ESHUTDOWN), then just free the command. However, if it got
cancelled due to other reasons, then send a sense CHECK CONDITION status
with TCM_CHECK_CONDITION_ABORT_CMD status to host notifying the delivery
failure. Note that this is separate from TASK MANAGEMENT function abort
task command, which will require a separate response IU.

See UAS-r04 section 8.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - New patch

 drivers/usb/gadget/function/f_tcm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index a10e74290664..116be1c47ac9 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -949,11 +949,16 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
 {
 	struct usbg_cmd *cmd = req->context;
 	struct se_cmd *se_cmd = &cmd->se_cmd;
+	struct uas_stream *stream = uasp_get_stream_by_tag(cmd->fu, cmd->tag);
 
 	cmd->state = UASP_QUEUE_COMMAND;
 
-	if (req->status == -ESHUTDOWN)
-		goto cleanup;
+	if (req->status == -ESHUTDOWN) {
+		stream->cmd = NULL;
+		target_put_sess_cmd(se_cmd);
+		transport_generic_free_cmd(&cmd->se_cmd, 0);
+		return;
+	}
 
 	if (req->status) {
 		pr_err("%s() state %d transfer failed\n", __func__, cmd->state);
@@ -972,7 +977,8 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
 
 cleanup:
 	target_put_sess_cmd(se_cmd);
-	transport_generic_free_cmd(&cmd->se_cmd, 0);
+	transport_send_check_condition_and_sense(se_cmd,
+			TCM_CHECK_CONDITION_ABORT_CMD, 0);
 }
 
 static int usbg_prepare_w_request(struct usbg_cmd *cmd, struct usb_request *req)
-- 
2.28.0

