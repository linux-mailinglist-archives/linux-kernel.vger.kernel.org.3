Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B48508B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379903AbiDTPDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379902AbiDTPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:02:46 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63606C4B;
        Wed, 20 Apr 2022 07:59:59 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KDgEQu006225;
        Wed, 20 Apr 2022 14:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=LZJcMsYo4F/gBcJ4+93JsjuqQM6hCYdR4j0EeQhvsOQ=;
 b=PpsX+O9gyZdzgViYqbz0RHsr2HzUiACeUTHbJLSQB3UppzsT8h6rl1+OUpptz/O8ltby
 s7dHlCQPCURfl8YmfK73dG71ePVcoiidFGWk5kqMioe8SkMt8o/keEUh0HASopI3RMAr
 oJtd6LTxl0KEcLuqf1TVjtEvCcFFtuKUWm+FiMDzsfpYzPYN1iQ4izF3ID8XsgagDwE/
 ynJUuPn50JVdMPqtRxpnFuim12RYDkls6Bz3bXV5KzykdOFrBDp39RjJQwMfmqC7iSRa
 Htp1QD4ZoPdqSA/0+J+Cw2vLlq2V8AlNORxm1RV4GZqSO3Zu0OfeAneMKiIfOn1KloAq Lw== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fjbhjd7fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:59:54 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 794C783;
        Wed, 20 Apr 2022 14:59:54 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 2286D3B;
        Wed, 20 Apr 2022 14:59:54 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick@hpe.com, joel@jms.id.au, arnd@arndb.de
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/11] dt-bindings: usb: generic-echi:  Add HPE GXP echi binding
Date:   Wed, 20 Apr 2022 10:01:52 -0500
Message-Id: <20220420150156.47405-8-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420150156.47405-1-nick.hawkins@hpe.com>
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: d0LZOQRd8apgynPSt2Qkqhd_327_3t8A
X-Proofpoint-ORIG-GUID: d0LZOQRd8apgynPSt2Qkqhd_327_3t8A
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=561
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add hpe,gxp-echi to the generic-echi list. This is to
enable the device tree.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v1:
*Based on previous feedback the hpe,gxp-echi has been
added to the list of devices
---
 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 8913497624de..2d52f53ae805 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -55,6 +55,7 @@ properties:
               - brcm,bcm7420-ehci
               - brcm,bcm7425-ehci
               - brcm,bcm7435-ehci
+              - hpe,gxp-echi
               - ibm,476gtr-ehci
               - nxp,lpc1850-ehci
               - qca,ar7100-ehci
-- 
2.17.1

