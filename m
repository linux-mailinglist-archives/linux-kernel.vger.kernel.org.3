Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D255790CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbiGSCYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGSCYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:24:49 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E92033E20;
        Mon, 18 Jul 2022 19:24:48 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ILoCF6020763;
        Mon, 18 Jul 2022 18:26:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=wJLBErIwYYuh2hawl3dyRP19SnzNtsp24HjH65Z2HG8=;
 b=LB2kEkZHqHjFisGsOAhyhkG7edkLWVm7ix45nNw9O4uvf/rC3opylgYYrUKFPOaUYplo
 Tno/cB1M2QiyG2Kn7Wh3a5R71ZqZ5Gd82MbUDskvCzE3Hp9YpmjqVwXEokDRXfYXK8+W
 DVol6NhLEgL3Gh3HV1VLhDqBPeiH7tjVIYU9FxxCK3I0A1+4xXfzPSgyjDl3HcaZw4qI
 gK2q6krcI3UFoMF9bwOJGxjE25TD2zXiiGPJkEzzIR/jLiYl7x2Emxu32QaguKoRfJ4J
 43HJe1UySYbZU1g0ztUIoL4uffplEcQIaWKVnzaPx5U2QVeAFJWFimNZDkRvrvF5mJGj oQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3hc6c344w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:26:25 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9A9E0C0649;
        Tue, 19 Jul 2022 01:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658193984; bh=rV2b9OgEtHbGnZVIuN0NlxP74jauj/eZVINv1IvF/24=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=JPoEEy39bnGv532h6w1knmPNe3NfcPQacVvtQ6xwCHfWV6KBpm+X6Hc7nQPPnE1PR
         7bU1egqy2utfc8wa8YwWe4FyL11S4efF1sYsT6lSz+qdKLvqelLhKbehlBtdFvZmio
         ESuQQqJtyhB5RGKw6UkYORbX60BgBZnW+1JYFVRkMgbQDOG7kPUIRJCwL2nFjvnCb/
         UJcGtK+MYmVQ9qxvEsSRl63x+DrxSXxwJlnhpOZj3iBz3lOwbau6sw0LoRnkhGWQjU
         AbOuPbKZvNyI09Dv91BG91sBS03wrG9P4BUTqR0RvFamVFGrUTXuncSkkb6m/GKfxL
         QvZZsI2tjBRPg==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id EC046A0068;
        Tue, 19 Jul 2022 01:26:22 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:26:22 -0700
Date:   Mon, 18 Jul 2022 18:26:22 -0700
Message-Id: <79dbca4db65f676df37462b7a008198c81a3297e.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 03/25] usb: gadget: f_tcm: Increase stream count
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-ORIG-GUID: _6NFdC33YKtdkKoJ-b64cooS6uPQgnTM
X-Proofpoint-GUID: _6NFdC33YKtdkKoJ-b64cooS6uPQgnTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=723 phishscore=0
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

Some old builds of Microsoft Windows 10 UASP class driver reject USAP
device with stream count of 2^4. To keep compatibility with both Linux
and Windows, let's increase the stream count to 2^5. Also, internal
tests show that stream count of 2^5 increases performance slightly.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/tcm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/tcm.h b/drivers/usb/gadget/function/tcm.h
index 3cd565794ad7..6cb05dcd19ff 100644
--- a/drivers/usb/gadget/function/tcm.h
+++ b/drivers/usb/gadget/function/tcm.h
@@ -13,7 +13,7 @@
 #define USBG_NAMELEN 32
 
 #define fuas_to_gadget(f)	(f->function.config->cdev->gadget)
-#define UASP_SS_EP_COMP_LOG_STREAMS 4
+#define UASP_SS_EP_COMP_LOG_STREAMS 5
 #define UASP_SS_EP_COMP_NUM_STREAMS (1 << UASP_SS_EP_COMP_LOG_STREAMS)
 
 enum {
-- 
2.28.0

