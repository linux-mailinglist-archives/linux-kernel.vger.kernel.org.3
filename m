Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C78157904E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbiGSB77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGSB75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:59:57 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741FD3AB13;
        Mon, 18 Jul 2022 18:59:56 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ILhqxe029327;
        Mon, 18 Jul 2022 18:27:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=4ZVLdzbMUcrfP/EafEBZxfI6im0iYb4s/IkAcW58Hf0=;
 b=G5/9NSoIUat986llcO7MIdTlzWze+GoJ9zsIJoRwQiw1gzLpQPB+fCEQ22W9k0eJ0gxo
 bzO2wzjZRP2wNsDxSQ7ACgYEFr2Mv8c9f4QFUVLcipiTDmIFPxS3bWs7elLXaVS7PKP5
 g8ug9tpaWwAxrfy3TInI2yKfYbf3/bS5hag6kZDESf0cQnfWQkuAbYKw8LUNKSQxmdfV
 qigPF1kBwZcl8NQQDxXBhHCvoNO/dl60+rmWrjCDAdxd91FKzJYwGlQx/w1VBKMo0uF5
 arBhdZtKjOhdaPKpdrNMJbmimv5gT3QT2Nfx1Rw6M4IRAu9T/8ep7EgkVUIELxrdNeDr Eg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hc6dec5hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:27:08 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7C2FE4008A;
        Tue, 19 Jul 2022 01:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194027; bh=ZMdZU1K7CwtMhxl8DY31/uSscHDaBNyOTjP59A3yGu8=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=XU8K0SkWLf3qabPFpb3MSvKQsrRtSZq3BfDn65KdjRq3M3mlHl8N9Gn2pLD8kFCq5
         EklTcOidJQ2eChLO5qqAW/SN/iNH3SscF4RavWWCN3wFiF6A6VQU8GL9gZrqPhYw1T
         7bHVjukFPi5d8xRFOy4YKiFvjXPZ+CeATyhhs/u1G5m5ExQmRapYpjrs/nZjZQ5uyI
         JBB++faMlxUeDGfBVB9ZSzkzFUDYcmIoWCG9E13oNbhJq8X2NlFLiH8GGcnbp9CA3V
         ngdJjn14jBJAdWbn3xLO9d7kuH0ogSafOua3vjz4xjmMCdqoAFxPz4NfXoc6K8a1IR
         +Qe1UWblapmdg==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 5B683A0096;
        Tue, 19 Jul 2022 01:27:06 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:27:06 -0700
Date:   Mon, 18 Jul 2022 18:27:06 -0700
Message-Id: <38fd7899b6861846f1bb614d026ef009a2546df9.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 10/25] usb: gadget: f_tcm: Return ATA cmd direction
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-ORIG-GUID: Cb88W5sHxH7AaOEb2Do6iSiscB9Uc9yf
X-Proofpoint-GUID: Cb88W5sHxH7AaOEb2Do6iSiscB9Uc9yf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=623 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0
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

Check ATA Pass-Through for direction.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/f_tcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 91d853682468..6fea80afe2d7 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -898,6 +898,8 @@ static int get_cmd_dir(const unsigned char *cdb)
 	case READ_TOC:
 	case READ_FORMAT_CAPACITIES:
 	case REQUEST_SENSE:
+	case ATA_12:
+	case ATA_16:
 		ret = DMA_FROM_DEVICE;
 		break;
 
-- 
2.28.0

