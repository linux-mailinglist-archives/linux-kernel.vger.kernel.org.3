Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9DD5790A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiGSCMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiGSCMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:12:42 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796BD3C8D9;
        Mon, 18 Jul 2022 19:12:41 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IMIaOD011734;
        Mon, 18 Jul 2022 18:28:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=kwMOGmIIfzbY7VpWpTbmlhazk7iSokgmI1XZfcrQx8Y=;
 b=q7ePfUsZBGWTsxGqJ2HFZ60FbK+CzJEjf1g4F5P6u2dgJzfzlGCs/Crs7FWtpkvemMy4
 C23khzlxDTAhAq/jKHpx+5C6sF2t5IoING3dG/6c8APMqVv2gYxLmflEe6zE5mHjC7xI
 5qi2KVM3yB3gNYpb+6cdj5O2yEpVmMLRHSg6UO/Ezv1gEhi/YAZ9qWS0LBBW05o5262m
 MwlJs7S8zh5NHG1WRwzcs7XwJ4ERzSxB2acsn/O0hua3BKw5mO5qTRTzVWSDbvPYnFe9
 /Si22hMlYFhpbA5jY2stMYcyBEzAhEr4Q+i0C0YHAW6yTOKSpiCsIKHjx1UEHSW2S+8T qw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvk5whqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:28:05 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3A50C4008A;
        Tue, 19 Jul 2022 01:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194085; bh=ZqUV820F7j/nDTM7lrEmn3rGOhNylVJHOQIpC6HclvU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=InLE3jiupEu8CPftk9AXUU+aDxb2onINhk4xqWPwwNArVHfD9Am4eS9vjkkixt1K4
         RBp1p/j7GDehL4C+ddWC13GxyA3A5xQNAhq5fN03EdDozzl/18aJ50/SuqPnaXoYTY
         XtbrZI4oOPVcyiFGzxitKuA0pl+KrLLQXbuWBXLqUrz2u093YvrAJiFO2yYQ28eTK3
         3RMSHDEPkWOPC4k/txuFYvXss5jXB8SBG3Hp9fJDqFchuUCYRr75Tk695nNNhETAa1
         1vVSpCqTOswfExcZ/7AbT4KqaUsdyR9kzmf7jcoGq4AFr4Z4MtDeWGUJxLdAXNl5h8
         awt2ocJp8um2A==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 12DA6A0096;
        Tue, 19 Jul 2022 01:28:04 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:28:04 -0700
Date:   Mon, 18 Jul 2022 18:28:04 -0700
Message-Id: <b0cc1bbc9a8325600419e7057e61e492db677041.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 19/25] usb: gadget: f_tcm: Decrement command ref count on cleanup
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Proofpoint-GUID: R4CY43pP7J6M-Dp9w_mYnvKsjEVWg-lC
X-Proofpoint-ORIG-GUID: R4CY43pP7J6M-Dp9w_mYnvKsjEVWg-lC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=858 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
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

We submitted the command with TARGET_SCF_ACK_KREF, which requires
acknowledgment of command completion. If the command fails, make sure to
decrement the ref count.

Fixes: cff834c16d23 ("usb-gadget/tcm: Convert to TARGET_SCF_ACK_KREF I/O krefs")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - New patch

 drivers/usb/gadget/function/f_tcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index a8a730e5126d..6cf95c9723a3 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -955,6 +955,7 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
 	return;
 
 cleanup:
+	target_put_sess_cmd(se_cmd);
 	transport_generic_free_cmd(&cmd->se_cmd, 0);
 }
 
-- 
2.28.0

