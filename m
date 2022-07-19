Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4F3579045
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiGSB6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiGSB6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:58:47 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5AF39B9A;
        Mon, 18 Jul 2022 18:58:46 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26INawLR011668;
        Mon, 18 Jul 2022 18:27:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=p86ySwkfPEOGRNYiCayfsxV8vR/Zt884NmPL1N4e22Y=;
 b=E/csdIsFpHyYTCx1TdtNWGkYcZucfl8sFJnHZSkTs2EN6tcpJfP9EVOkT8CTI3I4MNEE
 VOb0atHgJPhW/ew8IY9hRlrf0aciM2tNtGtK4RVm1a/TCcWCutZTN8E+AW29QJJZh1+P
 qiwxReUGzBL9nqJ+dFYkX0xEFkBEJzbH6Lh5Hy0Ja951EfvucC1+MlaKg8EU9p8uTJMO
 N1jS54R57CpjY6GIFMfouJ8m34lcKPgkkfnQqlHobhD8s0n8kd3JKFi0JYik8tYRIS2A
 eg+2ffpXt5Rbs6sfXGbhQK4FYvoIJdiotinKWGORqbC53R8FyxcS7EfbP4nj/KfZrqVD Gg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvk5whpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:27:47 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ECA03C0649;
        Tue, 19 Jul 2022 01:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194067; bh=2HvC2YXu4BJ+vnsXvfnddzVm8KC6PIuyWJsyVPWUmj4=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Byoi86g/AVX8l4cZhT40x6S/eX6MgNJf7C9JaEN+ENoKi9bfO85x/clPIFsxtG20s
         deU3P4ntTZMT22sxMmJJttzhvviMXj8OiXDDxPIUPLm6eGSlz44+F/Ukv0c/wzY3JF
         E7LaNgLSsayNrn93/btI7VFnrpCEhc0EUrlq8uCAjtaus1DlMaChD6LcAq/8z3ijGq
         A9yyfMkFvXvTJ8j20r9HoCD6xTWuv3JxxUnUQ5TsApNy4QjsLPeyPdiJT6qvKbdUbP
         KXZF9NUiKA9Pq4h0Zib7SBriGUpGYX9DLXXaBwbEtA+lCmcKXc5T+bCaLeUgh0DfRJ
         FAfX7KgiDTgKA==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id B1EC7A0069;
        Tue, 19 Jul 2022 01:27:45 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:27:45 -0700
Date:   Mon, 18 Jul 2022 18:27:45 -0700
Message-Id: <dd9069e0527f2da04b6567fd17b19545646f4348.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 16/25] usb: gadget: f_tcm: Update state on data write
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-GUID: UvshAVfQl2i9V9HfpsIGAKefCxSGQ2-W
X-Proofpoint-ORIG-GUID: UvshAVfQl2i9V9HfpsIGAKefCxSGQ2-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=936 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
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

When preparing request for data write state, the next state is
UASP_SEND_STATUS. When data write completes, the next state is
UASP_QUEUE_COMMAND. Without this change, the command will transition to
the wrong state.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - Move a related change from TASK MANAGEMENT updating cmd state to
   UASP_QUEUE_COMMAND to here.

 drivers/usb/gadget/function/f_tcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 1e7d29f8aecb..d7318c84af98 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -934,6 +934,8 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
 	struct usbg_cmd *cmd = req->context;
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 
+	cmd->state = UASP_QUEUE_COMMAND;
+
 	if (req->status < 0) {
 		pr_err("%s() state %d transfer failed\n", __func__, cmd->state);
 		goto cleanup;
@@ -976,6 +978,8 @@ static int usbg_prepare_w_request(struct usbg_cmd *cmd, struct usb_request *req)
 	req->complete = usbg_data_write_cmpl;
 	req->length = se_cmd->data_length;
 	req->context = cmd;
+
+	cmd->state = UASP_SEND_STATUS;
 	return 0;
 }
 
-- 
2.28.0

