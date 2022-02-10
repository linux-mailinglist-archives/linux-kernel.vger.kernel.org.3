Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9116C4B1523
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245654AbiBJSUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:20:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244485AbiBJSUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:20:39 -0500
X-Greylist: delayed 1314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 10:20:39 PST
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E09B1167;
        Thu, 10 Feb 2022 10:20:39 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21AHrBa6019217;
        Thu, 10 Feb 2022 17:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=LoMzU4Gj/192aRDbVYQFs/9H8PFlmG143Za29tBADlg=;
 b=jNaDcxZOwlGWZkM+DCZffxiWvR3tYcowG8JSmU7b8BLTny+oIja7rRDKAvLLQ8ANoQ1C
 +hOrKsO8wn3G3ox6HxGjIDz3zfa8pHP8iDzihnSbnHL1Aqu1Q6dLtPGK671WCQkon5cI
 +Or9tUzQxJu4NjrHN9s3ZP3EfnGmktqnf1UF56Xk/KWXwSIi6me+MHx+1So658YZI5BS
 7NDm5dMigHyWKHS54BHpfteW8PTHE2GDAqikrAmgHKFLPxxpZ2ZZdsv54ZQ0HWwkiqUs
 ffSKaT9FEgUlz2uwNo0EQW864w0AkXRwBskAQjSZ8CIep3OzngOfyOKg8B4RBuwWmdz0 9Q== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3e57g8g2e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 17:58:22 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 0A8FDAA;
        Thu, 10 Feb 2022 17:58:21 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v1]dt-bindings: vendor-prefixes: add HPE Prefix
Date:   Thu, 10 Feb 2022 11:59:11 -0600
Message-Id: <20220210175912.102159-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <nick.hawkins@hpe.com>
References: <nick.hawkins@hpe.com>
X-Proofpoint-GUID: giCr7cMEyk5ZeNR3YkkroGgXo6bzw8vH
X-Proofpoint-ORIG-GUID: giCr7cMEyk5ZeNR3YkkroGgXo6bzw8vH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_08,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 mlxscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxlogscore=942 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100094
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Description: This patch adds the Hewlett Packard Enterprise prefix
that will be used for upcoming support in the HPE BMC GXP.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 294093d45a23..e8b0ec874aed 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -515,6 +515,8 @@ patternProperties:
     description: Jiangsu HopeRun Software Co., Ltd.
   "^hp,.*":
     description: Hewlett Packard
+  "^hpe,.*":
+    description: Hewlett Packard Enterprise
   "^hsg,.*":
     description: HannStar Display Co.
   "^holtek,.*":
-- 
2.17.1

