Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91C050A8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391830AbiDUTXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387874AbiDUTWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:22:39 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F624B41D;
        Thu, 21 Apr 2022 12:19:49 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23LIWFsP016452;
        Thu, 21 Apr 2022 19:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=dZWiEVD/xZ1urA5n2y9hX5aRJN3VFiV7YiaKIlXZI9o=;
 b=FAURZotp4fSHTDgZa6wTEfplw3s0UwLjSanj1X5qBowVpXRR2bn3OJFNSc50mlH79Fdf
 krFFQYJKBKh1ec2kgzWnkEbJynbr6k6Rft9/SSi1mJLWjCfyrhHIDqYBDp+sad7kAghT
 hRJM79H5s1Xf0vIYGbrUD4nDGsB0Srbj4qBmqbpuUnXfv8fVrs4aU2QTXPQXhWHP0HhT
 rMSGFUsV9IE+0REhsTjOTRGanbFR0/9Ia1qiuJqHgNwrCVu6ArMXvGzIaORaFjrWcfDa
 FLh3pah8QqxjnksSTvgLuD0mjMgSjEsTF0Cs8Pvt1sCweNARTQhQhcVQ+Q3HPCw/LY4s jA== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fk9h1j4e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 19:19:41 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 8664566;
        Thu, 21 Apr 2022 19:19:40 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 34D3C48;
        Thu, 21 Apr 2022 19:19:40 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/11] dt-bindings: usb: generic-ehci:  Add HPE GXP ehci binding
Date:   Thu, 21 Apr 2022 14:21:29 -0500
Message-Id: <20220421192132.109954-9-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421192132.109954-1-nick.hawkins@hpe.com>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: hHUBP9NRYJbUp-cp8REO9QeIpZl6aBeh
X-Proofpoint-GUID: hHUBP9NRYJbUp-cp8REO9QeIpZl6aBeh
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_04,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=714
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210102
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add hpe,gxp-ehci to the generic-ehci list. This is to
enable the device tree.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v5:
* Fixed previous change log
* Fixed typo with echi -> ehci
v4:
* Based on previous feedback the hpe,gxp-ehci has been
  added to the list of devices
v3:
* No change
v2:
* No change
---
 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 8913497624de..0b4524b6409e 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -55,6 +55,7 @@ properties:
               - brcm,bcm7420-ehci
               - brcm,bcm7425-ehci
               - brcm,bcm7435-ehci
+              - hpe,gxp-ehci
               - ibm,476gtr-ehci
               - nxp,lpc1850-ehci
               - qca,ar7100-ehci
-- 
2.17.1

