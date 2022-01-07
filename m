Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CF8487399
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344580AbiAGHeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:34:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15480 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344335AbiAGHeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:34:18 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2074TjNe009310;
        Fri, 7 Jan 2022 07:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ixNehyV1xi796jC16lvBxB1modGp2NWPsfIxVXTSOf8=;
 b=f2I2uaN/rEAMUyNlUthP+H8Ge/nFlyyyD0v31B3mxBSTe9dVtH+V9YEKiOT1upkaS3wr
 xHfuWUI2W3rG800aTAGfhMMX+6xgeWJ8y0kmmRxrPU7UkoLoRhb9yW1N+v54u2OtgkeW
 OS8SvXyIVpwbJRMOVcKFYVz80Y7o5+whe66baUQW+ZgUEg1XCouAxXycFpxZx42dF4HP
 /YV8+ym2L3oDPnWgAJd/+tsqWeTqRUzL1TZqpZl54TUw2ZrfjFJhhQsXZfAvRyKpXN0z
 tfBQbmIZPS6WlOyqDBmlSmcSHoDVGNW2jF98lbCbZI5Pg6m6r3rQwH1Eez8eTn7dXMrA oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4vh986w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 07:33:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2077VOhi142279;
        Fri, 7 Jan 2022 07:33:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by userp3020.oracle.com with ESMTP id 3de4vn887c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 07:33:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyRBUFKstrfMKqE3O3h3teT7e+PgY1QALmxtsCzAF6E6uHAlImvMUGUjGNwc5GM8W0xe47MDAufOItlUYzK618K4bmooUkpw8lE5LosdOt1nYfXkZ7WkrqUzXVx1fQ4mDhgc3C2b0eNUgeESuC9PsUeVLARwEFURCwAoixZXt0UlZvDZX5WS47ctH5KEHNZAfonYaOeFWXhYERZbziJUAcl1AY3zn/c42YoId6YeVI3oE7fi9L+430w5uGei7cKiQb6V4inm2ZysgWTG53PKGISczbTEcX2Ch475ha3cfpuku3KjTGJm3CrNMIFcvwQdIawF/5HPv0sRwzzUqFciHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixNehyV1xi796jC16lvBxB1modGp2NWPsfIxVXTSOf8=;
 b=jQdBP5IjdsgaDbMcsXmx2xta863PYgJ66j136kWAwDMroXyFgc1ARbnQIhfI4YvenPIoQhQ5Dp9Lz3aFhOLnVKiq5q6rdxFo+qEkwcY6cNEbk1a5x0Tvv5F4c65ufdPkga9vRcuBxkgLy68p8L3++vjSv+vAHcn08n9l4yFjLKZD2dNAe9AmWlSn+jGmzHwiu5KYxdxTwGA7hvheK7lFAJaAyeCIWIgzQu5BzocoLfhb6FLHFluN3xKorppaZEcnjcd/flCmb6reuAEvXP3SJysFRsCpuQouqXya45CZtVLMmpbfyIzSo5/z3os3zrpzY4Z1sF2VuIZQ+0coAqIz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixNehyV1xi796jC16lvBxB1modGp2NWPsfIxVXTSOf8=;
 b=U2+uG0GImtIQntUn+eOjf+j4Hp9Ua6qZvKuDl9izzs2h13Fnd3VGlxIbjoqWB7udR34OJLIepSXR/n32T2+g3fgP6MdA1LGoXWNvryFC1rJeRQv3VP/6/3xe6G1/ul4gXzSaQjHO8jyrDeZyzVGYM9c9mGDJAu2w0lJNy5l2UfU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5752.namprd10.prod.outlook.com
 (2603:10b6:303:18d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 07:33:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 07:33:51 +0000
Date:   Fri, 7 Jan 2022 10:33:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] rtc: gamecube: Fix an IS_ERR() vs NULL check
Message-ID: <20220107073340.GF22086@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0065.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 250f2331-080d-40bc-41b9-08d9d1b00cc7
X-MS-TrafficTypeDiagnostic: MW4PR10MB5752:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5752021F436B25B64FA4FF5D8E4D9@MW4PR10MB5752.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xu/AMQBqpPte57Vv7P1dQHePa/T084Ms/0o1ugP5PKmGrPl2Vu331AZz+F4XMoc9iVJmuLQQZRW8uPMvgWE8d/omnOQBuw6f/YGCzBrGu9mE2XAGqnH16HBl9YV2A3/ikOpIegWGCN5VUIkaRjTy/13XPrfjqfq5Xh8hJY9uCWWXYN0WqeA7y1B0N4xx3Cwx6Q80O3Dq6e+SRokqrSGtyMEzeQL7oLiEaAcwKwytA12G0qIn8Qy9daCdwpeIZnmjRtFK8+vHcp02X9iwGl7Y75siUdlEMnOOt5pbWcjwiSe6sEzshzmLR50tz6o9R1kZ6cIfnkNNJ+yecb4JIAAmT96YB4BGCINrfLED3FkSuQmSSpWi63jyvtfd0yquczGI+HP0UMLQ5dL74U/5+cPhOxwVqBZxlj/JO7rYNrkpRJEwE76hkifiKwbPlTxdmOyYR3F+KcQFbUfZIYNTjbXz6Lo1i0jdpYEsGHwAtH5XBg37M2SFIe3Xi3rSpF87vkAwMHu/f9sxLdrYnbB3aKxZhz8KJnh1TDH/RSOHTgLpi2AKZ3Z06VlxileVGv1AA22P2NNh+RQ8bJkNq/EmW/IvIsPZ4yijMLDNu4hw0oj6UQUazIdvnwvwAxlmkBaNA+AIE+4MqlfOfK1EJDPXAHdPrkYyp1VgPU0m23DftirhU4q5BZxCN5cY3BWjKue2yWSZrtYEUzFNM4e46pXBzLHRsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66946007)(6486002)(8936002)(6666004)(2906002)(186003)(4326008)(33716001)(1076003)(5660300002)(33656002)(44832011)(9686003)(6512007)(316002)(52116002)(508600001)(110136005)(83380400001)(38100700002)(38350700002)(66556008)(6506007)(86362001)(66476007)(54906003)(26005)(4744005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ygxPAWM2cEWl9yrEMKB2I7zPQgBk8eAaMnra/9Bklg5finB3nZwEKElVRQUC?=
 =?us-ascii?Q?YvUu2XkSa0elgp1CZ96YbIS/xtn3nNAvarEDZXpndK6h7eIbPa9/B6a9VU9i?=
 =?us-ascii?Q?Haqj4RRlB6Ag2G0VeR265xMWzRk0Otxx7SM5DWxUBsf1XNobCi+SxjauPeXe?=
 =?us-ascii?Q?ontuFfU93ZU/wEIyL54yYjctIYGIVZHEp3KAdoG/fJlxfZQUN95JMlxpGJ2y?=
 =?us-ascii?Q?86onG4uoxKs9QClF6LozgDouh4TtJ+AriMfc9X+RB+2o95KEx2vW6X7NODwS?=
 =?us-ascii?Q?YhVZoSxHqs9SUilitBHdrK6HCNu/QMtxpuGKp9EkB4kaAc6RjAZNDJBYdJvI?=
 =?us-ascii?Q?0tRDyiQ6UJtnTWKbsNJjNA0gIswiQ6vUXicXvLfxo8JYmpfrQvDeVlvPpSHI?=
 =?us-ascii?Q?U/S5qVjEiIvnN8GPYJyMuiO8AqAPXvdKF+tZu0YCVAhNGCD2YEdjGkk3CMRb?=
 =?us-ascii?Q?C1Q8tuA3SFx3LC+30qkjOxSnRuG06uqH5Dv13vIJzyOzpVMdh3A6XoZVZGev?=
 =?us-ascii?Q?jRN/lbKKcAYza8rHVT/7C7ohJ0If1AGz1LQ53BNfthR9/dt76+hKosoj3nEK?=
 =?us-ascii?Q?KBsUEicLU8Fj4Zv29Ax0aIhBnEn1XoLGe3eKS/Q7lXcGve01mWn7jJ1BUT9R?=
 =?us-ascii?Q?dEi6cHyt9exyd7vTRT2bER8YjmwSJ+03BM28U7k0ZVnNmsGrHcgDMasPbmG1?=
 =?us-ascii?Q?bqXhtis7l5vMXR113fE1adKZd8z17Duzm4M1LMNr3TGg9PS2HgiZp4kSmnVb?=
 =?us-ascii?Q?gYIV/hZu+PrPoP4W1qFzw0pLVUPoCM34Zmx/GC32KddKIoH86EV2UleDwkCf?=
 =?us-ascii?Q?12u+m4U+On6bkTCjJqB1/Om26NHZYDaU7MFkJ53BZUsrb9iUqxPSe9WdAdlR?=
 =?us-ascii?Q?m/8dlcc7KIe55j2+PwsMezudivAV32oNctRSd34iqT49Yokn4CxEA73Kzk7S?=
 =?us-ascii?Q?VyBOEJjhgJRREtIzwFUSbOy9gJX77XbL1IXPPsBhkVmh2c3I9RlKiG3Af0Sj?=
 =?us-ascii?Q?vUgAQhfyAGWmsOiWMuZIlLqhS2m5FLC9Tx4M9J+UP6D5aMUH5+CQNyN1kYrv?=
 =?us-ascii?Q?PklZSlI7vzuE8I8XB1LhjY2YORH1q1zVowpxzi5qR39UH9Koh1idGwRl4eRs?=
 =?us-ascii?Q?cOVTamFNvPHtnlA4PMVbujFZC6j/SKb5xNzW5CxM4fTCOuzPr+/Qaatt57is?=
 =?us-ascii?Q?+gtdPk3x7UzHDafZz0E6NzeaB1vuKQSvNBq6RUEKsLg2ssSNARMACpd1DT6s?=
 =?us-ascii?Q?10W23NicOVQTx/sKltxHSlHWZs2qE/RFa0lLxdGHou2n3yJXMzj9VihqvPuT?=
 =?us-ascii?Q?cr2MVJgV3T368HDK9ffegImV23bB8tRNFmfx9b9Zq7Y52M7pPW8ffUFEwfP2?=
 =?us-ascii?Q?FYa5Bvmw+QBum08p9mr5TO4KgntZ34pS8blYvZC0OqDEkwaGurHPJz9s3Fqf?=
 =?us-ascii?Q?Rt2LWOkHn9Cj8bILyLMzgZ5EKGfNcueqRrZwYl1PtWFu/8lk/G2oNdPEzgvl?=
 =?us-ascii?Q?i2nrokJ+pW1Adod5LF36C3K+/rtVzP1fbBIaXin+SP12KAU0hHEHKpTV/lw5?=
 =?us-ascii?Q?SxX18lECEbebISZU6ltcuOMRyFKRrkTTl+mtE14fYTlWzB6HPlG79qp+EUfU?=
 =?us-ascii?Q?h9v2nkbFgBFKoUBg5o7NVM2vJ1m5br96S8PKfTu7BpLNksuD49RdI9O9coNm?=
 =?us-ascii?Q?xOReVUJFpSgyrZoRNoSE4fiPqw4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250f2331-080d-40bc-41b9-08d9d1b00cc7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 07:33:50.9407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: as/vvqtnoPyPeKtHgqKBPyY5VEAmB9DT0qmdDCZS8RfABXfEm1SIVpvwDdhdv+yAMMJzM1PE07xFEhuveRsei2i6glzuCMGR60VZoF+gwFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5752
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070053
X-Proofpoint-ORIG-GUID: MTTifFrnJf1oi4tStdUD2tdF0iK9rel5
X-Proofpoint-GUID: MTTifFrnJf1oi4tStdUD2tdF0iK9rel5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_kzalloc() function returns NULL on error, it doesn't return
error pointers.

Fixes: 86559400b3ef ("rtc: gamecube: Add a RTC driver for the GameCube, Wii and Wii U")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/rtc/rtc-gamecube.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index 98128746171e..f717b36f4738 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -319,8 +319,8 @@ static int gamecube_rtc_probe(struct platform_device *pdev)
 	int ret;
 
 	d = devm_kzalloc(dev, sizeof(struct priv), GFP_KERNEL);
-	if (IS_ERR(d))
-		return PTR_ERR(d);
+	if (!d)
+		return -ENOMEM;
 
 	d->iob = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(d->iob))
-- 
2.20.1

