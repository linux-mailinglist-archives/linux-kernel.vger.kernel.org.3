Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C8A55789D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiFWLV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiFWLVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:21:54 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20092.outbound.protection.outlook.com [40.107.2.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127424BB8B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2DOojRRu7o35OmOa7dhQtFD2wK9DXNTy+RDSJs3iF4hNcv4HVlXzYPQdNivaijg/IGeio42zms+aKFl1cD0XOQMpsSawUuDisI3b3lZINLLb7L9LxTF6jtfekKFl+vntTG/wtHYfH7WBpJF9EYRqT1vFfNY7Ef9V9AuwAumDMSBS1psaXOlsA7wtzKCLs759TWfVsd+cpJClcVOQTI+AfgbTMhSZcHwIKtehW8gQv3lwa2EXHOs3g8aE0rMDZKt90spEIr97lA3zpAkVVWjvB9FOam5TnzeOxm3at4aI3hWmvKaKF7LNQmtZvarmIWbKR29ixQLwT84Z4NxJrr7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXSWc3WK1yiprzgmOnt9rJzT+d9FynhFwW4w2QGPrcM=;
 b=gyyLGlRbXJuqMl2J1E6pSXnM/mM0oJvGBuxGYX4ArI5sXx9mMt6+nNLaKfIMbESLntJN3kWJVJyuf7P5S5a7KYiLzmUZFoG24L+vOx390j3aP6muIDVpW3glcWKSdSTIMq4ueJQjmmqB5wePnB3Ml8ltqH42vNa5jplvc8maLjBoBOg8pWvjFDDgyv9iosKSXa2HNXB6WhRYd1AR+pFIRWPjPXAQR3a23zuZpGjj8tee+kfA940lJO0deELWMY97BQOuUtRF0FajICVte4AI+lBmmt5S6FvNdO9F2A/knK7t/bVSO/4yzHOsQi6PAjEK2Fg+ZPTkeeq5AptbLEH88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXSWc3WK1yiprzgmOnt9rJzT+d9FynhFwW4w2QGPrcM=;
 b=ic0VcFwNY3fJGMF8UanSyCLAtfv6bbIwBXm1LfoGBh+iXM9EqRkdSQ38GiVySz0TW+pNwGgApLC8OBdW8F4uIuEDpmc2qh9nVA4tEQJ9z2FBDA0vqKZlPPUbMhSaDUMHm9hlfMRTCUnYlhFyg7BqXvo4H3rnoluOt+nQM62X/t0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB9PR02MB6858.eurprd02.prod.outlook.com (2603:10a6:10:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Thu, 23 Jun
 2022 11:21:49 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::11f2:df70:b231:2b45]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::11f2:df70:b231:2b45%4]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 11:21:49 +0000
Message-ID: <ab1ad93b-4d39-8863-9704-da779fc4c426@axentia.se>
Date:   Thu, 23 Jun 2022 13:21:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Auchter <michael.auchter@ni.com>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH] extcon: usbc-tusb320: make sure the state is initialized on
 probe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0177.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::32) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 791862bf-2fa1-4993-949f-08da550a90f9
X-MS-TrafficTypeDiagnostic: DB9PR02MB6858:EE_
X-Microsoft-Antispam-PRVS: <DB9PR02MB68580FFFAA2A10E13A5A835BBCB59@DB9PR02MB6858.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jX/VETC6WPJ4PSt01U8OKJgBUIGU1zqloTJXEGP93hT9DyrXRGonBxHuvVBATboj1DsSUBFOzrSgGeHGN3d3cR0R9SEtLlyGX63HZfxVYSwUR4SKMsTstoK9rnoQl+IUMm47XqmGUZW5pvCdZuMZTql+sGnBEH992RmnIi/BhwSEioaKLoSnreDBaNZ4giRr//FQwJrmQI2JnF6+sOEBFO4ACrZdIfdjmfTO/7GDBjEh21KTr8sGumgj88CRhInoRm0Yenc5gS4u8bzWYJK3COLa0mTjxUfixuW3Nf2sG/s5oCTnJFQaDk11PFKuiWUXrZAPAlAOCvHOFRRC3V/atI71TIwmwAJYc8biRkNLXw2hEEFZ/TAbDlJie6DWhWUV3gmHN2sAQfIcFKlsb9LQ+KA8wTlWbabaQzfj72NXJeKPTqjvL5KUY4UAZQojLIAl2dZukHa12nCfJGBkL1749Wv6QsWHSXdClN3h50Y2VUYgRGRCWjpiQGvgH2Kq6uhYCCQCp9Y/Khs09fSQbTvE9s2OJJAi0EP/UwOJJ6naDN4mMgreVQ6gZlR5uS3MmMfh7geakM6SxuVw9Rtdw1UsgU7VaFAWfgNE3KxzU2H+J04/bWQJ5E6Ai7X7ahKtc/IJ6oEZ1LOD32rNK0ro66GSAr+AOIfMlJJK9p+IAeseTop3bHXmJWD02i9XS7YW+09PKqtH7QIwqFsG3IZ/GCGGs9dLLOeEYYZWLCYGaCHADNq31q+ll483Cu+AogR8jHDmK8MBlT90QW9C3K/OB1eA7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39840400004)(136003)(376002)(396003)(66946007)(38100700002)(31696002)(66476007)(5660300002)(8676002)(6506007)(66556008)(26005)(6512007)(4326008)(86362001)(478600001)(6486002)(8936002)(186003)(41300700001)(2906002)(36756003)(2616005)(31686004)(83380400001)(316002)(6916009)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZCsxQ1B4bVNjcDFRUVB4RVVnbG1pKy90U0xxaTZMR25nNDN0WGFscGwwcEth?=
 =?utf-8?B?Z0VUT0VyMnJPMmVGRHR5UXJDM2YwS2E4OVlOZk10S2d1M3ZGTGczTEZTNGh2?=
 =?utf-8?B?cGJrcUw5NWVCTFM2bm1TcXZhYXhCQVcxOW12Y3pBVm1haHlMNHZSS01yaUxk?=
 =?utf-8?B?MWtQdEc3NGMvK1VwdlVaZWJ4NDF1NnZBZ3BnczJVRERXM1U5dEZ4K1MrZGFV?=
 =?utf-8?B?ZERRaG5pUGMwanZLN1NsYXJBMmpCVU03ZEdJRXB1bTBLZ0RsdVhxY2dTdDhi?=
 =?utf-8?B?L1ZCcnJMZmlxbUZqUjFlcHVIUXZrNmcrdUdrSW96TXdpbUJhTkIwY0ZEbzBS?=
 =?utf-8?B?RlM4cGhaNXk4OEtqOFM0NXJFZi9Pbk8xZ09oZE5qY012U0s2N1FGeE1ubkw4?=
 =?utf-8?B?ZXVTWlBIZEMzWUpHcENJWGpYMG83alZSR0JZUHprcjI1TU8zdGx4U0c1amZn?=
 =?utf-8?B?NUIrb3VKcERwaHBWckZQenM4dVlDQnN0YUxkVCtSTmU3aEphN0lYQXQzVGs3?=
 =?utf-8?B?dmNBTlhJVXFkRHltNHRIa1c0RktVQXpSa2lEM0Q3YWl3dmttNTBySk1vUmV0?=
 =?utf-8?B?Qjc3NW1aMk5DV2Y4czZPTDB5UHB2My9Qd3hZQU1ZMDlCb3V5TDRKdUhkdkRZ?=
 =?utf-8?B?bDdFM1JPWm9iVVZJVFFzZEVFR0pjVm9CaGZFaDJmbWtEUmF2OVJ2clFmR1Zt?=
 =?utf-8?B?bHFzUFNrOENJNUNWdTJKTXovTzRvRWJiUEF5RlhMbmo5b2tEeDY4L3dxa0tq?=
 =?utf-8?B?bGdPZkIrbFNqczZxemd2VWNUU0NJNHRPOEJUNm4wSmpMLy9yVjY3R0RuN0Yw?=
 =?utf-8?B?TTNhYUZiekZPMklsUVBFZGIvM2g1SmRYQXVZWDFkdFRiV1NTa2hGS3RBWFZW?=
 =?utf-8?B?Qi9RTDE2dFJKV3NxSXhqUXMyL1NmSnk5anFuZXE2dlc0ai8xZEg1NVZuUjVX?=
 =?utf-8?B?YjVKbEszMDRLTlpBdG5CdmtkcHIwbzRDS1M0UVNkbHVQdVpobi9SUFBKTGpI?=
 =?utf-8?B?TVdLcDZ0TVE5bnRtVzI2cUwwRjBodWV6TmN2dHJvdHhkdXJMdGpnamxZclZp?=
 =?utf-8?B?WXk5TzNMMU5mNUtaNEdxd2JvOENnaG51Y084Rm93VEF3MGhMVWtYcUNCK2Vv?=
 =?utf-8?B?U0xsdEx6VkYxMFFJNmJhTzROd1VrV2ZvQnZDM1psWWhiK1pZRTNzb01jdDFM?=
 =?utf-8?B?TmloY0JXMDhaMEIxZ1QrbWNVZWVpSHBRMXVZc3lpUzFnM1doZDNBVUEzQUJr?=
 =?utf-8?B?NGlhalVvSVQ2NmNwTklnSk15bFk5NmxQZWlaUHB6UlU2c1FiNkZoblZJdG1K?=
 =?utf-8?B?U3AyRC92VzBCNS9jR01PUWlGL2k5ZEVMZmlxcVhyanNVQ2hUa0VCY01WSnlB?=
 =?utf-8?B?M0lBU1FBYTd1emM0ZGY0NGJyRXIxNmdkRVFlZk5udUFlZ2ZwM0VzQ2hvdlBJ?=
 =?utf-8?B?QTgreDhsTUgzU3NYTWZGT0o2cTVScC91TklsL3RnNFV6Zms4R05mVzhVM1dm?=
 =?utf-8?B?enkycnh0SWNhNU5ZZFdUMXJ3UXBud21TY05sZ2hycUJjRThTYk1WTnFIN2pK?=
 =?utf-8?B?dHVWOTJaYnZNYi9Ddm9ZR3AxK1RIYTlWRThPazNkZjBVeXFNODNwQTVUS3h2?=
 =?utf-8?B?RktCVHhwZkxUTFBYRFhUZmszVnBXdFl0ZVMzckRIaFlsLzZIT2dxUGI1QVFu?=
 =?utf-8?B?OEJFVGNsRmdXZ0dpVTR0UkQxV2ZNRWsybkpQRDc1Tk00eTY4ZS9WRVhvUlJ1?=
 =?utf-8?B?T1NpMS9laCtpYmJMRXZuRTl4MVJwbUxKOGZQWk9pSXc2UnpNSnNVaGdZTGFK?=
 =?utf-8?B?UlV1SXArcWl4b3BUZzdHUWljd0JCYjdDaXU4TzB1QnV6NmlrSjFVMzNna0lC?=
 =?utf-8?B?ZmNOMkhUcy9Vc3hNNWhETTVyVXRLRDRSdmh6S2Y5YWlTcXB0STVuN2lqaURK?=
 =?utf-8?B?bjdYbTV2K3FPUjBhOXFkS082bTVNdzNRNGtyaHc3OTVyZVExYUUyYWNHTy9H?=
 =?utf-8?B?RmlaQkZja21HSGdCWmVtT2xKaytOY2RvTis5cERTKytYTFBzTFp3ZWFudUsz?=
 =?utf-8?B?OFIyNlVxUGs1bnJ0bHVZZWhMeG1NWDB1TTF4Q3dYcktNZXcwRWt3TlNPenNC?=
 =?utf-8?Q?tw8wV2FhREW4lm4wFumKnrgdX?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 791862bf-2fa1-4993-949f-08da550a90f9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 11:21:49.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04U2ksKRBVjVd+NhkpNA+bP2iE14k/03W7458l4LmIE/sKwfQAmWWjW/ya4kg0gP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the port is connected at boot, there is not necessarily
an interrupt flagged in the interrupt status register, causing
the IRQ handler to bail out early without reading the state when
it is invoked directly from probe.

Add a flag that overrides the interrupt status register and reads
the state regardless during probe.

Fixes: 06bc4ca115cd ("extcon: Add driver for TI TUSB320")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/extcon/extcon-usbc-tusb320.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index 6ba3d89b106d..bd3645ae0d52 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -55,6 +55,7 @@ struct tusb320_priv {
 	struct extcon_dev *edev;
 	struct tusb320_ops *ops;
 	enum tusb320_attached_state state;
+	bool initialized;
 };
 
 static const char * const tusb_attached_states[] = {
@@ -195,7 +196,7 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
+	if (priv->initialized && !(reg & TUSB320_REG9_INTERRUPT_STATUS))
 		return IRQ_NONE;
 
 	state = (reg >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
@@ -297,6 +298,8 @@ static int tusb320_extcon_probe(struct i2c_client *client,
 		 */
 		tusb320_irq_handler(client->irq, priv);
 
+	priv->initialized = true;
+
 	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
 					tusb320_irq_handler,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-- 
2.20.1

