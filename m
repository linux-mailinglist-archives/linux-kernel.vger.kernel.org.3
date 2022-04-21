Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293AE50A8F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391851AbiDUTXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388672AbiDUTWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:22:40 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EC94C7B8;
        Thu, 21 Apr 2022 12:19:49 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23LJ2AM1013645;
        Thu, 21 Apr 2022 19:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=1PKj35N4lHm6I1ROK+WgNFFp0NpMhtthZ77PmVVHB5U=;
 b=o8Edh9P3seJlD/KDg4eSVeocqgM5ZkMCvVAf9CNuNx0JfK0m/Fu98ofZGPI6crX85hY0
 Zcu+aXRKz284nJw77FR5w2wfyUTMa9NKiufUH7XsbRNpu22zl249eOtHoX1SRL7tOJlz
 rIAz0nSc3qCPaxEiH16s/szvBC5JOpw/ChLjUbZYepsjw+aeYKOa+jBNBmwHKoRqF9Km
 PWRw7R949QVFm6lRvApzKO/BydsCC6maGIBySH80dk2vaUt9C8EJMpF4XJQN/3o2uEKN
 G5mXTD3i4AC7S4PGxBAI3y40PAsXFjDPYO8jAmfp4cYy9M0pisU82akUmtQDOtYXIxWO +g== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fk9fkt6bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 19:19:41 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 133A87D;
        Thu, 21 Apr 2022 19:19:41 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id B71CA4A;
        Thu, 21 Apr 2022 19:19:40 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/11] dt-bindings: usb: generic-ohci:  Add HPE GXP ohci binding
Date:   Thu, 21 Apr 2022 14:21:30 -0500
Message-Id: <20220421192132.109954-10-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421192132.109954-1-nick.hawkins@hpe.com>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: xSNWY5rx8EqiMY0gItCSWkSlCKj4QVH0
X-Proofpoint-ORIG-GUID: xSNWY5rx8EqiMY0gItCSWkSlCKj4QVH0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_04,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=756 impostorscore=0 phishscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204210102
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add hpe,gxp-ohci to the generic-ohci list. This is to
enable the device tree support.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v5:
* Fixed version log
* Fixed typo ochi -> ohci
v4:
* Based on previous feedback the hpe,gxp-ohci is added
  to the list
v3:
* No change
v2:
* No change
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

