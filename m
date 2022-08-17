Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D4D597A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbiHQXVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242262AbiHQXV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:21:29 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD562A50D8;
        Wed, 17 Aug 2022 16:21:25 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HMqjeF032410;
        Wed, 17 Aug 2022 23:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=SPA9HR1ud0yigF92QgPA3v3i+U9ls34Dlp7ecixtQLQ=;
 b=dPdTG4G+qC6RhoRJ4ny4hRGW/GQcy8hTj2nQFbl+hb3EzaiF7bSZ2Mhb/BjkVWKvSn2m
 NgrClI5ErgFk6linSjAWld1fnrMCtxBRWo57gN7zHkxuvUSCfn6ivmjmhWdFJduklMcH
 u/OJgGQswo8oIZuUbe7jud10zIhl6ohbrzWL1UzT91TaTyXLJYdmVrYX6hybfrgOZnie
 VWjioW66qqJrrULxdxQiTug21gGdVgOeSQHU2dXkX5wOeqA/fe2uhlBFMN/v363DBkdL
 slDl/MUB8PI4q8GZ9t5jah/lnhnTxBJGyKDIsE4v+a93kOa+CKNqaxVE7BsBOeJVTGHj HA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j19gr05um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 23:21:19 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 7C44CD2E2;
        Wed, 17 Aug 2022 23:21:18 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 2B5F3808A31;
        Wed, 17 Aug 2022 23:21:18 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 06/10] crypto: Kconfig - remove AES_ARM64 selection by SA2UL entry
Date:   Wed, 17 Aug 2022 18:20:53 -0500
Message-Id: <20220817232057.73643-7-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817232057.73643-1-elliott@hpe.com>
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: d3V_-3BP5hNUaeeEzOlHtSK1vq04Jzlj
X-Proofpoint-GUID: d3V_-3BP5hNUaeeEzOlHtSK1vq04Jzlj
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_15,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=870 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the CRYPTO_AES_ARM64 selection by the TI security
accelerator driver (SA2UL), which leads to this problem when
running make allmodconfig for arm (32-bit):

WARNING: unmet direct dependencies detected for CRYPTO_AES_ARM64
  Depends on [n]: CRYPTO [=y] && ARM64
  Selected by [m]:
  - CRYPTO_DEV_SA2UL [=m] && CRYPTO [=y] && CRYPTO_HW [=y] && (ARCH_K3
    || COMPILE_TEST [=y])

Fixes: 7694b6ca649fe ("crypto: sa2ul - Add crypto driver")
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 drivers/crypto/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 3e6aa319920b..9728874f66a0 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -804,7 +804,6 @@ menuconfig CRYPTO_HW
 	depends on ARCH_K3 || COMPILE_TEST
 	select ARM64_CRYPTO
 	select CRYPTO_AES
-	select CRYPTO_AES_ARM64
 	select CRYPTO_ALGAPI
 	select CRYPTO_AUTHENC
 	select CRYPTO_SHA1
-- 
2.37.1

