Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ADF543EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiFHVoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiFHVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:44:08 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-oln040092066082.outbound.protection.outlook.com [40.92.66.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20259AEE08;
        Wed,  8 Jun 2022 14:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaGrXhXHUbLIHRKGMhvkvvo/VH4vumXzWCsQ6NFuG/bVnRT5xiOTTSJNkHisMPMlFUEoBR5jxAGxl7AeURvmvr56dozV4hDMOaf0o5L5WOzKPyN0DzCrh4mOKdF95o16femXZyJyyKxmsNZ3KH46GZwngHRcFQqqcAzX+sDVzmxGqAPYBCPKBoCotOiQFwZXyftazpXMfCmknJZWLs9buiHfRHWLWkMHVA4dJkrfloXJKHXMSL7s1Oc3Hf1v+M7m3rEEyCyLrgIriXEtMY1PQqdvW8E4hrahcL2hxZZ5CURtgoGZRENxjECu/OUjhynWOLNRWwMoJUOXIh7YWxDtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTU/PVysgftUff6kJGFGskS973apk9pJMP/n8+RnYCA=;
 b=MXZVwcH9K3L7U7k5BXtIo9NZZFCt7ozEK33mGH0C/CrduIxa3QZ2e2bnMcrX9Fr+R5gxWLnwhnTImSg9cipH/9TDK1yfZ93kB244RsD1kRrwhv1aOjOhY/OjEgUvher+qx8e3BgY3IhKKGcD6nOW6yuvJ78Fe9fBLl3V7Bk4ftDNIarWL6XAawiafAAEufq8cK/17XKg2J+1d/c8PelSGtJoQiZyxwuBfV/KA7l5x00wb9TzS6ERn5/tIAaTMqfBhaZBskPDlKxLrKcskAHQqScDYvKgxR6cCD7ZIISN1s1VAtJkdHYhxQunbQMdRFD3Z2hI7KR5/XjEG2d7zC9GCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTU/PVysgftUff6kJGFGskS973apk9pJMP/n8+RnYCA=;
 b=hAh9+d0VMaDvBZq+VcC2k1XULm42zypfxrxdBZbo4g5Z3Rny0O38mYbbBL0QZfBaLYRC6UYE9C22mtwpzzKL+366efDRteSYY32r4sE2ZcvwG6g+T7HOBlKdK0LFQrIlMNTi4/0eHch6Vs1J8Iraja8QCSlb41nRM0Q3DHQMEbe4a00tgBXNvlhXWV+UqXmVZ4yCN5HnnL1SksopAAf48HhCv6Bpsz/ywk+PiJaHxerRgVykoxHr1UnqyeI5bPdol4o1AzxbtWeZLUHsePJjimyfGi5PCe6+B4nwelsubxET97jA+dbc7qSPhtes59S8GW38iA88mXBw6pdAf1U5nQ==
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:c2::10)
 by AS8P189MB1542.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:395::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 8 Jun
 2022 21:44:05 +0000
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d]) by PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d%5]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 21:44:05 +0000
From:   Saud Farooqui <farooqui_saud@hotmail.com>
To:     clabbe.montjoie@gmail.com, davem@davemloft.net, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        p.zabel@pengutronix.de, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Saud Farooqui <farooqui_saud@hotmail.com>
Subject: [PATCH] crypto: sun8i-ss - Return appropriate error code
Date:   Thu,  9 Jun 2022 02:43:46 +0500
Message-ID: <PA4P189MB14215851AD16923CD7FED8988BA49@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [wu83tF/DiTuFzQEpevIOGdveInCte9dU]
X-ClientProxiedBy: DX1P273CA0019.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:20::6) To PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:c2::10)
X-Microsoft-Original-Message-ID: <20220608214346.1153223-1-farooqui_saud@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ec0fe74-24e4-47cc-e0e4-08da49980243
X-MS-Exchange-SLBlob-MailProps: CaK+F7me6Cn4w7g/Qnpre93SAPxeuyVxvedXIHMaoNFcTLOAYuJQ4B/Qpe/nBwfGQnP7ZuU41OFKMqYcy8/5LC/eR9frZdj2iWOrhLw+mgoz4jjrTKP2LyOGVC2tSCTAHblKLdnZtDdg/JUjdgXkwVv4ekFrpz6hoXoJ7VurSfnKgXugoez/fqVOWye+pHtWZznYlA0K2gGO0dvaBZfWaw2Ryvw4B79rvPum+NiHGDEoXncH4ZJfbnbsM2KghRO9JP/aCPjbqZJCvHzYnjPwjeDJ0F5jj1eZ5hiP77Rh9kfO1JSwZ10ZGanFf26ERrM3Lih3EXtiMvX6gjBX4VT5mQtNkt4Yj9X2RdBUAxK76bLwiWrx73dK3tAFZlyaCs8vUxKc5FpIJIyB6eHorcgr4yQ+UhasTWkUPWnpqJ8LtsK+vZqu0d6XlWkb/39GshljVBlr6TLDhWfsZ13lC/n3a9x9WUgUSBXLxkkgnL5OgzPAKM99Tfsn+QWZHNrIRLK7s02x7a/XOv1PUhoSebGSaRmPeCOwnudI/mPef8Jia339Qm9r9GMF0/F7Fsj3PqSi4s8Ig4TJvcHBdgz4Qg6uZK8Q2TuYCM2JiK7EI+xJhe9gxNpYW8RvsPKSQo2VLRuy9jK0LuxOaNs1xRUy/Ry9Hb8/OZYnje94exw1S6e8un5nUrxkjF6qufMb7qQsqVxAEmVXURuJm2pTKTnHchwguPtUGlif9CKlpT92xFQTESguIvlcqpMsVw==
X-MS-TrafficTypeDiagnostic: AS8P189MB1542:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTNE53e4hggx6Zqmdhn9wVdOH1oAglSVk/Piw/MyR+LtOBgXfN0+u9QfKGiMDP7NEVM17Kirudt8JKsbZoRzSjlDi+NSIT/Ctfnan0EMezd+GXJ+v1/470Ge2OHZHNhC8t5bBUQ04JS1IRFrHOCUj6kB4Y13uUWUzgzSj2f6cx6hv+I7B1iXMPqONEGiqnM69QkOSmc906+KtqSgbHyXjW+lib5S9VuQdee3+yLP1IwAts6tih2X7EmA0vQi/JjG+Jaa0pFBRgzr3rkWxWcaiXjwI5AL/bGLs+7vboaB8rI3BDVM7FlJxZaD5fQ5m0S6ZVKgZRpBRk48DDnJWoomxN890SBOLN6Wf6OK7dzJqGcvKxqUq+ykMVDEb1TlU2ICSTUsQrD27cTJG4ppYDJ6838CxAyzergUeRaGpIYNqIyMFvcSueEd3M4v+2E/85L3L0hf/cZkHVL9t3t2BXAndj+hE1yGckwiPYqwyZmmX1GaiU9gkJMn37j8JKYPJQtyQY+oYRIrBS3tqEFDIXfYNv926ROc1mzKrbx8OjkevjX7o2M5KjTn+5UoQ7fH73gfgpDNMkg+A2zs1pbEaNIHZg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GiyjnVPEpcWzUx5ZWFz+KMWU3BSq/mobgrHZsPCiHRCyBJ4lfYaNqQ1VG6Q?=
 =?us-ascii?Q?IhrUTUerOMTNap97RN9OdBI0j6GaGF6rlZSEEeDPacKy0BiCxQrejpFvoYAJ?=
 =?us-ascii?Q?/zUEq+CWndYBlOBKxVAPrgdIeZgu5qig/Yev2k8Fr1wRcdYYyPbejVws2BV7?=
 =?us-ascii?Q?UFc8NqHVJ7Fsxd+hDMwGDfHz01IeilCsirdJH4sNFhdd0KKGaA9lwbovtULV?=
 =?us-ascii?Q?B77U0YOADf+8bFiKxyhnFqfGnI3xQ22vEWuB7DEp/f9uv9NxOSHXDjD33LLw?=
 =?us-ascii?Q?Wfk2oLIof6fc2xuI2VwKJmPxWrVzsQ4FS6r3KQSLjRzImVQ3Ky3mTg+OxEEW?=
 =?us-ascii?Q?a6/SPHghGSIynuvgxFBCRiNfLdTXDw9lOPyLCHzqZ0SWp9eJgRuyQ6P7QBoJ?=
 =?us-ascii?Q?gaCldwwUE+xbjwwxOvIoMXrf26rQnNS1pYfyXPTIiymyD9iUcGSrjksrL9v7?=
 =?us-ascii?Q?KioM4gbChN0A0565rRpJPKvMu95Qn3EOl8hlLtkNSUJCGLU4xNVkE8tf6C+R?=
 =?us-ascii?Q?HSW4sKVTi1bGmREzKCAowHR5JWuxYxgIbjgcElzDFUCHLIMMQMTPnt4mGLSV?=
 =?us-ascii?Q?TItBwcqXsJrehx64nLJ+atRMjq++nlfF0ccGRPYXpzQtUkbxY3atY/m3/6ow?=
 =?us-ascii?Q?XyaS9Xgo+YJfDeDeG35TP4w5w7fcUoMXn3X1BZNzV4U3IMfbfZiYumGrlcyy?=
 =?us-ascii?Q?KgsJcXQYW1yznYGfcBiGSxxNEKPnCoINwr7kJnVSMbnnsF46cFyXjUgmt0oP?=
 =?us-ascii?Q?TmbQF6cO78cC1MS/thFhVFulLOr6JkanXol2CARa0Zep0HGlq+i5x8kwIqdo?=
 =?us-ascii?Q?3MgpW5//NjQ4dc8zy2uy0Zzd/yUyMu9dF7Wj05xwI4zSP2rRt6Pb7RRiOYhU?=
 =?us-ascii?Q?XxceQMAgmHM6mGJJakaaVp0EdT1Rsyj5lokl9DopEIvw+8vFl+F09uJWORKm?=
 =?us-ascii?Q?elt0a22PgVMGunHT541jchDcnOpBK4ePFyf6F6pL1RJgfgPyyonJ7zJrlP8O?=
 =?us-ascii?Q?16GWWjA30HA0/8ovG01baBtQm+11AeuqBwVnbb/fNVWYBy5cFm4uyXUVfVwF?=
 =?us-ascii?Q?wCwQI5BQnpz6vpDb2nnhnaIGtdZI+qzTUd3eUlHRg2keg8avzZExUXCIXWol?=
 =?us-ascii?Q?Nzxym0YGm5TypuQijujwrYYbLuSD1UEaNlUqABWlbd6XksuNmrejhIZ2s8CI?=
 =?us-ascii?Q?CwfnLtpGw7nULhtnGJdqPp40mNAQcZ/0DzoC8w+n5RznG4R6NZX/rO53ppiB?=
 =?us-ascii?Q?ZwgciSTpUGBHD5GYxMcRB12hhi7S/eheQReyFDkrMsyT7AYpe5ecjv5W4O02?=
 =?us-ascii?Q?lNqz1PwPnQVdT8aawc4eFpZUs3ovQikTKWhL5si7j2t37cIg3u29SuN+29bD?=
 =?us-ascii?Q?aSLOwG1CrilV1FTmBntZgkFSsOVqGcYyVgE4tKuql8pKZQbolI1p/2+brotg?=
 =?us-ascii?Q?oM4JcayAXqM=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec0fe74-24e4-47cc-e0e4-08da49980243
X-MS-Exchange-CrossTenant-AuthSource: PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 21:44:05.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1542
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return error in case memory could not be allocated for sun8i_ss_flow
internal params

Signed-off-by: Saud Farooqui <farooqui_saud@hotmail.com>
---
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c    | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 98593a0cff69..448819550b59 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -528,25 +528,33 @@ static int allocate_flows(struct sun8i_ss_dev *ss)
 
 		ss->flows[i].biv = devm_kmalloc(ss->dev, AES_BLOCK_SIZE,
 						GFP_KERNEL | GFP_DMA);
-		if (!ss->flows[i].biv)
+		if (!ss->flows[i].biv) {
+			err = -ENOMEM;
 			goto error_engine;
+		}
 
 		for (j = 0; j < MAX_SG; j++) {
 			ss->flows[i].iv[j] = devm_kmalloc(ss->dev, AES_BLOCK_SIZE,
 							  GFP_KERNEL | GFP_DMA);
-			if (!ss->flows[i].iv[j])
+			if (!ss->flows[i].iv[j]) {
+				err = -ENOMEM;
 				goto error_engine;
+			}
 		}
 
 		/* the padding could be up to two block. */
 		ss->flows[i].pad = devm_kmalloc(ss->dev, MAX_PAD_SIZE,
 						GFP_KERNEL | GFP_DMA);
-		if (!ss->flows[i].pad)
+		if (!ss->flows[i].pad) {
+			err = -ENOMEM;
 			goto error_engine;
+		}
 		ss->flows[i].result = devm_kmalloc(ss->dev, SHA256_DIGEST_SIZE,
 						   GFP_KERNEL | GFP_DMA);
-		if (!ss->flows[i].result)
+		if (!ss->flows[i].result) {
+			err = -ENOMEM;
 			goto error_engine;
+		}
 
 		ss->flows[i].engine = crypto_engine_alloc_init(ss->dev, true);
 		if (!ss->flows[i].engine) {
-- 
2.25.1

