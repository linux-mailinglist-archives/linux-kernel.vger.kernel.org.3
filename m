Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D0E508B71
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379929AbiDTPDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379906AbiDTPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:02:47 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26A2B87A;
        Wed, 20 Apr 2022 08:00:00 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KEO4eN006612;
        Wed, 20 Apr 2022 14:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=PvZ1pQrQRJdHDkPHYmzY66oiRGACkdtxDpwSSivdkBY=;
 b=nbzlcAOasUtD3TC77dVDCRd+OBLxxeNQsGZ2JGM8uwx7D6CTTcllGapGM+DkTKJoGWzq
 lSgekrOwVtuqxeHjvLaKCy6VQLfUhbc4SNy4Vu5sTDPVsJcNSgaKaAd9pVOLgT+y9TgT
 zGNgloSTM/CRSG3jWj0XX52UQJClfc8zqIK6zrQxlPItLj+9X4jcY7O6ZqnQLnX5kX+7
 ZEs4nVIefKqVScqlXtieGOW8twyOieB4s0W95fgb/GE15dnBjVD/9F9NfuaPcnC/YJik
 3nM4XW8Ig2fA0i9Zn2ewN5hiQUpnCYv+oWtsHbj68X0ikejSyQ8rAfl1SUgM8SpHcTXr Mw== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fjkw88bfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:59:55 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 167C191;
        Wed, 20 Apr 2022 14:59:55 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id A7EA537;
        Wed, 20 Apr 2022 14:59:54 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick@hpe.com, joel@jms.id.au, arnd@arndb.de
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/11] dt-bindings: usb: generic-ochi:  Add HPE GXP ochi binding
Date:   Wed, 20 Apr 2022 10:01:53 -0500
Message-Id: <20220420150156.47405-9-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420150156.47405-1-nick.hawkins@hpe.com>
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: 6RkSogFcGp9eRWvN1NTo1ZbFTutXqXQS
X-Proofpoint-GUID: 6RkSogFcGp9eRWvN1NTo1ZbFTutXqXQS
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=562 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200089
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add hpe,gxp-ochi to the generic-ochi list. This is to
enable the device tree support.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v1:
*Based on previous feedback the hpe,gxp-ochi is added
to the list
---
 Documentation/devicetree/bindings/usb/generic-ohci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index acbf94fa5f74..e2ac84665316 100644
--- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
@@ -42,6 +42,7 @@ properties:
               - brcm,bcm7420-ohci
               - brcm,bcm7425-ohci
               - brcm,bcm7435-ohci
+              - hpe,gxp-ohci
               - ibm,476gtr-ohci
               - ingenic,jz4740-ohci
               - snps,hsdk-v1.0-ohci
-- 
2.17.1

