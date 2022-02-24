Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0927C4C2FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiBXPfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbiBXPfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:35:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EA41C60F0;
        Thu, 24 Feb 2022 07:35:04 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OFF6Xu017214;
        Thu, 24 Feb 2022 15:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=RJpb8ihEyDFjR4Ch0tdM9KeE3pbxKuOWANmT8T6aFW4=;
 b=e0f56xWycHRQVvgAS/QSvx17un9slwJRqOskIVavCzOwKWGHoWPFZK7d41duZlNGVfcA
 89Ncg0tSg55ug7Ge4fSzy4K9pRPkRVNaQT+yV9pNt33SeZ3GviHIZOaxYjbMpEWKjwTA
 FjPRgjzuWVLRMwxLW/lAQ3+JdXsjQNZoJSU+bqyrqqONNLsT5qbLV014LJPu+8k7nTq5
 nR4sIe/N2IWT3CmFUQn4ZCL/ZXUdLiaQAWhYVkTHyF0vnsF280WgxIVjRQLoYiOie2Km
 fPsvRXAhqmHv1j50a5XhIW/ApNkxGTPcfChnZZ39H5Syd95wM71R07HOz0nHVwGPZWaP qw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edtyjf8tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 15:34:54 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21OFCVUP011979;
        Thu, 24 Feb 2022 15:34:53 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma05wdc.us.ibm.com with ESMTP id 3edr92sfw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 15:34:53 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21OFYq0k25887194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:34:52 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 576D5124052;
        Thu, 24 Feb 2022 15:34:52 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7216124054;
        Thu, 24 Feb 2022 15:34:50 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.20.50])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 24 Feb 2022 15:34:50 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        johan@kernel.org, Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH] USB: serial: pl2303: Add IBM device IDs
Date:   Thu, 24 Feb 2022 09:34:44 -0600
Message-Id: <20220224153444.10893-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oVAgC1v5B63svGMp4CKmZlCibv3ksmZK
X-Proofpoint-GUID: oVAgC1v5B63svGMp4CKmZlCibv3ksmZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-24_03,2022-02-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1011 phishscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202240092
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

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
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

