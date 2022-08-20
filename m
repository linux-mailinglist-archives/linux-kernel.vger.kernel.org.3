Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD359AFAA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiHTSmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiHTSmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:16 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90F944578;
        Sat, 20 Aug 2022 11:42:15 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KADEXC015177;
        Sat, 20 Aug 2022 18:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=UFnRtn20x7ErgVNXioH4ORQ70zAQRwvmB5XogSG+iog=;
 b=ooWJQPNxCu2Qr2T8muXoOXzYLynhqKithtVUn3udz3HThIfhchjEHzO6EOSIZI1MiOLx
 d3IPSq1sHFGfdlUbsMhewtBUbhx6gn5aQZaw4e5HPLlxfjHd4F1llJKOqhHQiCEylRmP
 qUI1s+e2YMoFqN/oHI41ZsqIdE9lijPHblTCQKgPYbTpN03cmRXMMUCGNBrui0ExX2Ir
 dnEr+ojNYHEK4kq+B4vZJ8n8/y4YqpKE7qUrKbBcpTrOPx35XmNav/S0F24bKwCK+jMj
 PcdgfbbRcLfkt4rMIbhTd5NAlpq5wdRI6rIydb0eoVsuQro3MlpYqZmMQf2o5J6nu5Xz dg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wnjj41d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:12 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 1279BD2E7;
        Sat, 20 Aug 2022 18:42:11 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id A23268058E9;
        Sat, 20 Aug 2022 18:42:10 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 06/17] crypto: Kconfig - remove AES_ARM64 ref by SA2UL
Date:   Sat, 20 Aug 2022 13:41:40 -0500
Message-Id: <20220820184151.1149247-7-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tNwCB3JFtaODzaSVlOpDWWorFQpwNYPQ
X-Proofpoint-GUID: tNwCB3JFtaODzaSVlOpDWWorFQpwNYPQ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=935 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208200079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
@@ -804,7 +804,6 @@ config CRYPTO_DEV_SA2UL
 	depends on ARCH_K3 || COMPILE_TEST
 	select ARM64_CRYPTO
 	select CRYPTO_AES
-	select CRYPTO_AES_ARM64
 	select CRYPTO_ALGAPI
 	select CRYPTO_AUTHENC
 	select CRYPTO_SHA1
-- 
2.37.1

