Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A8F579076
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiGSCG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiGSCGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:06:54 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A5D3C8D9;
        Mon, 18 Jul 2022 19:06:53 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ILooam020734;
        Mon, 18 Jul 2022 18:26:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=5JtutWQ3TvVbO9MexC8Mla+M0EsNrFxPIoJRfZIzkIA=;
 b=GmUGd/WqaXGlCOJjolQhAzofyZnqQ80rWXby0hsxHFm173MuxVMqJnz/yfVbFdQScbSl
 oXI5zDUf2wMJgkoKdCa2M7tPH/VXQ6AngDnWRypUBgcge4lbsEDBlXwy71QaEdigQDOt
 epnI5ngN+U+7BeOFcTUOEVpMNtgbD7P62/hbxk2/Ce6p4A2by/9bB7z5ETRJAM03hB3D
 iZ7vrmO64DrxKRo72wYkeJw9g3CM687PTu041HB9NfFKNYz7QWJyI7Asnwgxw8ss8Ew8
 D14+7ynAFh+j9oOmTnZ2ct9nrdJxRhD3xPaxmyjTmMEqx1kLgRRd0SoqNUR8T0HmCPsh Fw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3hc6c344we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:26:31 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B6AD6C0649;
        Tue, 19 Jul 2022 01:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658193990; bh=g644d0gYPJVQYiL4nKwFKzkvaaT1M/KFt0n+kHVCwEs=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=RN6mUNigP63geO2l9KAsaLAAjMKuBsniGJqWPw5bvISJ8s6k8AcaNEhHfShS9Hj1e
         TCFdnaaIQ8+pCxF7tZjegAh/eobt3QyoZcD1gshwsTr9e6Yri15wwGSOCdqd8HbonT
         zR8PM14hY7dIl8+W9z8Kp/CSozRvXRZg7Krb6/6vaalyA/gD5999mFQXUeUFEfDCL6
         EVXWhRXvlmI/Wkc84JmsDRLhRQN2L75cy1a65N5FZmWnZyI6O7o9ieCX8ytz+GdM/s
         6hvkI8pd908R/5BOhC9O6CQn5SPbmZCu+AfASYktBWeZ+SzOLED/FK9+yxjk4ntnkb
         hgogrf5etZj7g==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 7B898A0096;
        Tue, 19 Jul 2022 01:26:29 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:26:29 -0700
Date:   Mon, 18 Jul 2022 18:26:29 -0700
Message-Id: <93ccca7015e6b10e904c26fd2653c6026b606644.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 04/25] usb: gadget: f_tcm: Increase bMaxBurst
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-ORIG-GUID: iOya1dphKypYK6_ArQddTz3Ae_OWd1NU
X-Proofpoint-GUID: iOya1dphKypYK6_ArQddTz3Ae_OWd1NU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=756 phishscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the default bMaxBurst is 0. Set default bMaxBurst to 15 (i.e.
16 bursts) to Data IN and OUT endpoints to improve performance. It
should be fine for a controller that supports less than 16 bursts. It
should be able to negotiate properly with the host at packet level for
the end of burst.

If the controller can't handle a burst of 16, and high performance isn't
important, the user can use BOT protocol from mass_storage gadget driver
instead.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/f_tcm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 8e17ac831be0..270ec631481d 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1774,7 +1774,7 @@ static struct usb_endpoint_descriptor uasp_ss_bi_desc = {
 static struct usb_ss_ep_comp_descriptor uasp_bi_ep_comp_desc = {
 	.bLength =		sizeof(uasp_bi_ep_comp_desc),
 	.bDescriptorType =	USB_DT_SS_ENDPOINT_COMP,
-	.bMaxBurst =		0,
+	.bMaxBurst =		15,
 	.bmAttributes =		UASP_SS_EP_COMP_LOG_STREAMS,
 	.wBytesPerInterval =	0,
 };
@@ -1782,7 +1782,7 @@ static struct usb_ss_ep_comp_descriptor uasp_bi_ep_comp_desc = {
 static struct usb_ss_ep_comp_descriptor bot_bi_ep_comp_desc = {
 	.bLength =		sizeof(bot_bi_ep_comp_desc),
 	.bDescriptorType =	USB_DT_SS_ENDPOINT_COMP,
-	.bMaxBurst =		0,
+	.bMaxBurst =		15,
 };
 
 static struct usb_endpoint_descriptor uasp_bo_desc = {
@@ -1817,12 +1817,14 @@ static struct usb_endpoint_descriptor uasp_ss_bo_desc = {
 static struct usb_ss_ep_comp_descriptor uasp_bo_ep_comp_desc = {
 	.bLength =		sizeof(uasp_bo_ep_comp_desc),
 	.bDescriptorType =	USB_DT_SS_ENDPOINT_COMP,
+	.bMaxBurst =		15,
 	.bmAttributes =		UASP_SS_EP_COMP_LOG_STREAMS,
 };
 
 static struct usb_ss_ep_comp_descriptor bot_bo_ep_comp_desc = {
 	.bLength =		sizeof(bot_bo_ep_comp_desc),
 	.bDescriptorType =	USB_DT_SS_ENDPOINT_COMP,
+	.bMaxBurst =		15,
 };
 
 static struct usb_endpoint_descriptor uasp_status_desc = {
-- 
2.28.0

