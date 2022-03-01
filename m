Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467E54C9879
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 23:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbiCAWpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 17:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiCAWpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 17:45:40 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB047804D;
        Tue,  1 Mar 2022 14:44:58 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221LcOgN005050;
        Tue, 1 Mar 2022 22:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ykvyyLl7q6ghJb9019sxdtjUtMUQwiVAHjJjIiX4Ags=;
 b=Gal5gJe9fq4uQoYJ7Rmezl/Re69zOHkSyBxGjb/BG87AY540K7vDIXihyuVTY8NGvOZA
 kP11WyBunqq89cWTBlvjZM9CrSjWBn26GR6i76vnidV/08DO4UwUSLJx5zgWKLeOaTzE
 1+XEhfvNeT50oXeVhrRyfgCNREdj2VY23q1Nj84pVCELpR+r6/kK8byScSNX5c++ud7C
 X74vILqTYXHA7Y4cuF90W39IqtCgVfvef47q0ewFS/yPWeeVgJCEoisXWmWdgkeHYRj9
 o258SsBy0wr+/uQv3fJ4hohl6o6SZGNMirozHopF+Zp65pQO7V2TsD3YyKA05alAmG8K Bw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehu7tsb28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 22:44:54 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 221McckK016596;
        Tue, 1 Mar 2022 22:44:53 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3efbuafsn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 22:44:53 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 221MiqeQ48496908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 22:44:52 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC9322805C;
        Tue,  1 Mar 2022 22:44:52 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0709728059;
        Tue,  1 Mar 2022 22:44:52 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.40.70])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Mar 2022 22:44:51 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, johan@kernel.org,
        gregkh@linuxfoundation.org, Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2] USB: serial: pl2303: Add IBM device IDs
Date:   Tue,  1 Mar 2022 16:44:46 -0600
Message-Id: <20220301224446.21236-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bZay3zXL_pWT7UbdJeSBIfP4rGxVXCJ9
X-Proofpoint-GUID: bZay3zXL_pWT7UbdJeSBIfP4rGxVXCJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBM manufactures a PL2303 device for UPS communications. Add the vendor
and product IDs so that the PL2303 driver binds to the device.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Fix commit message Signed-off-by ordering.

 drivers/usb/serial/pl2303.c | 1 +
 drivers/usb/serial/pl2303.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index a70fd86f735c..e2ef761ed39c 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -116,6 +116,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(ADLINK_VENDOR_ID, ADLINK_ND6530GC_PRODUCT_ID) },
 	{ USB_DEVICE(SMART_VENDOR_ID, SMART_PRODUCT_ID) },
 	{ USB_DEVICE(AT_VENDOR_ID, AT_VTKIT3_PRODUCT_ID) },
+	{ USB_DEVICE(IBM_VENDOR_ID, IBM_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 6097ee8fccb2..c5406452b774 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -35,6 +35,9 @@
 #define ATEN_PRODUCT_UC232B	0x2022
 #define ATEN_PRODUCT_ID2	0x2118
 
+#define IBM_VENDOR_ID		0x04b3
+#define IBM_PRODUCT_ID		0x4016
+
 #define IODATA_VENDOR_ID	0x04bb
 #define IODATA_PRODUCT_ID	0x0a03
 #define IODATA_PRODUCT_ID_RSAQ5	0x0a0e
-- 
2.27.0

