Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3215790B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiGSCQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiGSCQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:16:25 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D4C22BFA;
        Mon, 18 Jul 2022 19:16:24 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26INpod5011657;
        Mon, 18 Jul 2022 18:28:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=onOJh2hcdIl+q/Y9f/POAVrOhKBEi/urtBPAsHEj5Z4=;
 b=a9ms9QOWQssmrIQCIgWV3evwBH200OPMURyEmnPCQ+tpbwcyPUxhYbRqpsQAchc4l0jl
 G/89gCvWJZNFHp/CMH4qQnOvpgO4Xhd5clYupOy6TS6ztGV8I3de70zCTpwOvnX0sltw
 jFibBsGEvIRb/c4qdn//QORpGuWl+jsZNnQKRwq1SX7S2zW/0tmEKDeJk6mYSdu94MwA
 Jvga1FN4xnapUYXMjD7yoT42wfg3IK1IzxStmUiXWWB5WHrgMKF3/4ysyQsQyjpp7Z+H
 VOYuTmvD8AY7KNgyoqxf9C2d/onvkkRAB2652etIIVrxYwAt5tcVRdviTVGa7WoHkdyi xA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvk5whr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:28:18 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8AAADC0649;
        Tue, 19 Jul 2022 01:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194097; bh=4MEfvkp8Bb/ru/wAgS6sQwD0ijPTHIo4v+U4hbSm5ko=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=but6wzf8WcRKU9isqjBG6xHxDTS8vZ4P3Fna6BHvzVHHZz2OfKznzRpz6IU1uYPB2
         qqIyLUanRU1tmVwbMhFFbssI5gkEDt39WPqL181eotYL+ZYi/uUBfVmCB7zh5VSCIx
         0zTYfQiU6NhJLtBXIpXyN4RWufdTstLKoVyk4nCei0CHnDztFc9gu2IoP13Xrx008m
         A1sHo60rUYVkTC+A6sN3LolR9Ui/tBoJFs2grp9zy1hOWggPZ7oteF4Y2BzVtjusby
         m6ciE+xK5pKx9C97fC4xlRRUBwnfspUTgLShKgAHpW3bf4kw/h6iO5wxbNnvHf8o/J
         iLKwCEFuWPMQw==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 5173DA0096;
        Tue, 19 Jul 2022 01:28:16 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:28:16 -0700
Date:   Mon, 18 Jul 2022 18:28:16 -0700
Message-Id: <3fbae6ecb8e9f31807635152a377b076e86fb12e.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 21/25] usb: gadget: f_tcm: Get stream by tag
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-GUID: ZYL-LpT_TcOrJqtcR4_I4NedvyT0rqxs
X-Proofpoint-ORIG-GUID: ZYL-LpT_TcOrJqtcR4_I4NedvyT0rqxs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=991 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
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

In preparation for TASK MANAGEMENT handling of overlapped command,
implement uasp_get_stream_by_tag() to find the active stream/command
based on a given tag.

For simplicity, we use mod operation to quickly find an in-progress
matching command tag to check for overlapped command. The assumption is
that the UASP class driver will limit to using tag id from 1 to
USBG_NUM_CMDS. This is based on observation from the Windows and Linux
UASP storage class driver behavior. If an unusual UASP class driver uses
a tag greater than USBG_NUM_CMDS, then this method may no longer work
due to possible stream id collision. In that case, we need to use a
proper algorithm to fetch the stream (or simply walk through all active
streams to check for overlap).

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - Splitted from TASK MANAGEMENT change

 drivers/usb/gadget/function/f_tcm.c | 30 ++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 084143213176..a10e74290664 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -506,6 +506,22 @@ static void uasp_cleanup_old_alt(struct f_uas *fu)
 	uasp_free_cmdreq(fu);
 }
 
+static struct uas_stream *uasp_get_stream_by_tag(struct f_uas *fu, u16 tag)
+{
+	/*
+	 * For simplicity, we use mod operation to quickly find an in-progress
+	 * matching command tag to check for overlapped command. The assumption
+	 * is that the UASP class driver will limit to using tag id from 1 to
+	 * USBG_NUM_CMDS. This is based on observation from the Windows and
+	 * Linux UASP storage class driver behavior. If an unusual UASP class
+	 * driver uses a tag greater than USBG_NUM_CMDS, then this method may no
+	 * longer work due to possible stream id collision. In that case, we
+	 * need to use a proper algorithm to fetch the stream (or simply walk
+	 * through all active streams to check for overlap).
+	 */
+	return &fu->stream[tag % USBG_NUM_CMDS];
+}
+
 static void uasp_status_data_cmpl(struct usb_ep *ep, struct usb_request *req);
 
 static int uasp_prepare_r_request(struct usbg_cmd *cmd)
@@ -513,7 +529,7 @@ static int uasp_prepare_r_request(struct usbg_cmd *cmd)
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 	struct f_uas *fu = cmd->fu;
 	struct usb_gadget *gadget = fuas_to_gadget(fu);
-	struct uas_stream *stream = cmd->stream;
+	struct uas_stream *stream = uasp_get_stream_by_tag(fu, cmd->tag);
 
 	if (!gadget->sg_supported) {
 		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_ATOMIC);
@@ -546,7 +562,7 @@ static void uasp_prepare_status(struct usbg_cmd *cmd)
 {
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 	struct sense_iu *iu = &cmd->sense_iu;
-	struct uas_stream *stream = cmd->stream;
+	struct uas_stream *stream = uasp_get_stream_by_tag(cmd->fu, cmd->tag);
 
 	cmd->state = UASP_QUEUE_COMMAND;
 	iu->iu_id = IU_ID_STATUS;
@@ -568,8 +584,8 @@ static void uasp_prepare_status(struct usbg_cmd *cmd)
 static void uasp_status_data_cmpl(struct usb_ep *ep, struct usb_request *req)
 {
 	struct usbg_cmd *cmd = req->context;
-	struct uas_stream *stream = cmd->stream;
 	struct f_uas *fu = cmd->fu;
+	struct uas_stream *stream = uasp_get_stream_by_tag(fu, cmd->tag);
 	int ret;
 
 	if (req->status == -ESHUTDOWN)
@@ -620,7 +636,7 @@ static void uasp_status_data_cmpl(struct usb_ep *ep, struct usb_request *req)
 static int uasp_send_status_response(struct usbg_cmd *cmd)
 {
 	struct f_uas *fu = cmd->fu;
-	struct uas_stream *stream = cmd->stream;
+	struct uas_stream *stream = uasp_get_stream_by_tag(fu, cmd->tag);
 	struct sense_iu *iu = &cmd->sense_iu;
 
 	iu->tag = cpu_to_be16(cmd->tag);
@@ -632,7 +648,7 @@ static int uasp_send_status_response(struct usbg_cmd *cmd)
 static int uasp_send_read_response(struct usbg_cmd *cmd)
 {
 	struct f_uas *fu = cmd->fu;
-	struct uas_stream *stream = cmd->stream;
+	struct uas_stream *stream = uasp_get_stream_by_tag(fu, cmd->tag);
 	struct sense_iu *iu = &cmd->sense_iu;
 	int ret;
 
@@ -675,7 +691,7 @@ static int uasp_send_read_response(struct usbg_cmd *cmd)
 static int uasp_send_write_request(struct usbg_cmd *cmd)
 {
 	struct f_uas *fu = cmd->fu;
-	struct uas_stream *stream = cmd->stream;
+	struct uas_stream *stream = uasp_get_stream_by_tag(fu, cmd->tag);
 	struct sense_iu *iu = &cmd->sense_iu;
 	int ret;
 
@@ -1285,7 +1301,7 @@ static void usbg_aborted_task(struct se_cmd *se_cmd)
 {
 	struct usbg_cmd *cmd = container_of(se_cmd, struct usbg_cmd, se_cmd);
 	struct f_uas *fu = cmd->fu;
-	struct uas_stream *stream = cmd->stream;
+	struct uas_stream *stream = uasp_get_stream_by_tag(fu, cmd->tag);
 	int ret = 0;
 
 	if (stream->req_out->status == -EINPROGRESS)
-- 
2.28.0

