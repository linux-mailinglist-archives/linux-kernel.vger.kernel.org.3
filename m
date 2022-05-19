Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B27952D578
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbiESOCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239568AbiESOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:00:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6BBEBE99;
        Thu, 19 May 2022 06:58:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JCxse3009233;
        Thu, 19 May 2022 13:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=mHJVks2aDHtTVPtCYBYdmaTTnDLv4bOQ1erlGX2CEhU=;
 b=dqcr9P88FY+w3pqHL7ZkXLUNNJP9t2iRLYpBGqBMeGZwkyMHryhTc0MYdS71r4C/xhFQ
 IUt+ndPpwWPsu+WqdN0eGDBjuOwH/iCFMkcNPC/y0zpooBe0JYX+cy15y3v3NpxWMb73
 wUc8qc67QcZnGf+e/DLa7oGPdqQX2NoIqA7NeYLgN7vYs1Z6iFW/DFIu/MMpEe8axIG8
 QxiVZyfAHvEuB4XEWYZnD7GaQrUnWi0/Bm25BpX1hcC5XDUlWFrf4bm9KNLxG+DY5pVb
 17cQWQdV0hXvhQIVbcVDYpAv0GkAeUpsii+G27HSf0qkpkiqaJAzpWwlweCh1OHpLZDo oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310vay3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 13:58:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JDu3KD014682;
        Thu, 19 May 2022 13:58:34 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22vauuvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 13:58:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFXFrESiSLAD4zp+SPeNqfqAfVGg2w1W/GcmfLvVa6e/4870X1ez/ZzfKnDg+kSOdCrveOyoeJMGI9EiXYzmNtGhal31swrPUT3AcO6z+Yy8yYeRM9TGq4sBxStEUdTPyY+otSMDR9XHkfCWKV2SKCtqdVR2aFl/fQKGp/VnfpcAqK81NFwqUyl3TTdv5Ixd+Qmw1KcLVPlYuzYWhH7EDbFtm/ZZl0z0YcKaF2FTiaMmuAyltNQw1qIFryzNgYmQEln+QezXP/zyoW3073Hhb4UIXxMqmzYmXvRs6uA2fV1CWdVY2ZIMU/6bfb/FVcFjK0sIAaepzyfoc7DPlHYPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHJVks2aDHtTVPtCYBYdmaTTnDLv4bOQ1erlGX2CEhU=;
 b=JG9/fbRklIMOFlM0LXt4tlFl3/rMR+lUkNezUuLb1eGUB3Mn2OnCFzQDKNj21fEizG4bPGV8XvLGyBVTPti+jTi4/RJ9wbQJ4GuNDf5/t9kwDUZH1auon45StOzDhepp0R5PmkKaw6yp40RCYDw2zCXFRkdGRMa8f3O/+/apEMtjf1yU3g7eyF8NgcRPjDw3YRLl2mmepuWRacimm46UeaOUOPhK8vl/SgwFKpJYVVPWwzIFibD+jFnl+nm2P5HwRFu+Ww6kL0fVjQCAzog3En8ZzE6PHcmVOP4RSZL65WiW1u6yycAiuVWyYBHs9Ksp2yOfwU+6VONBmXqcEP7iPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHJVks2aDHtTVPtCYBYdmaTTnDLv4bOQ1erlGX2CEhU=;
 b=DZFx3UXO/mmv0xKolIbCFOvNj0rHFSjIv9LxAguhR4sUxUGP362/j1fWvz9i2Bp4/NWqQlUZ09DPxfdEw+uypzOlcysnvQ4NdDFZjD4n/TEXzk/C7HGyx4iK+O/GvY/I0I5/H4Rv/vU3pG7vToKjlL92QIkP1/XrhLfJ/IJa3fE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB3023.namprd10.prod.outlook.com
 (2603:10b6:805:d2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 13:58:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 13:58:33 +0000
Date:   Thu, 19 May 2022 16:58:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] clocksource/drivers/timer-ti-dm: Remove unnecessary NULL
 check
Message-ID: <YoZM65RFDQAfqV6J@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0177.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0b66f3f-5ba8-40c8-0ad5-08da399fa937
X-MS-TrafficTypeDiagnostic: SN6PR10MB3023:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3023B0605111A94DE7B560AF8ED09@SN6PR10MB3023.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0J9JaaUg0NRYz0kPh/V2BkvfYUHV36XLW7IDUHcHO6QEN0G5BpTQB4EW/E48tzE0+9yXMCtSjOjukuONtpCINL0oaMIlj4t2R8DB9X3bXboECfSRG6fXXCp9HMJzRRQ/deVAEbWvVACvEni/ULNJan4BP9Jx3rC3MR4XBYVx42uRuyi3We4jqFWS8EmD5Fuyrau6nNHfSP2keOiCOxuhhyaj6wgv1ZfoeCimn1N5AQYtwD2psad0N2SCnSTuN1LRwfGy3eiaAwOQUxrXz72eEqGr2Jlsew2pJLv+rUUY/QOvfSx2BgWUG12cB1e0YJXgm38XEO2lft38za2/Ssu6lOS+UokXwPvswKGM1GS8MgWd/8lLwEf9BzC29GRSzSgb++OZGXUf+A3CtMPJFZxh+FCcUVNGV3Z8GwLgdaYf80c9sDLkEjVZ+Yrue4sT1GXQ+weFkH3id2yaooCMylv8L6eSq1ZD4CL4uTmx88lxfCSjUyfJkI0Txj4Mki8Pz3MhZU5BmTSCtHHyTWyRo2rnbfNXzEoXG4MAfm240UY28yv9EBYNyRCv5h3MaE+SLohLoON41TAheyOyyI4geDopJBFnR0PrVKXqr6KEXdSl0sY0tPCYiUzJVvtSDPd9bm/doAOaCBlk6CoGoWkeB66fY/67/G0mkJdGUp4FT9q4HGTLVYsHxPpiU6KmRLahQ2uki88GvPb8DQ+svh1uJKepxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(4326008)(6916009)(6486002)(66476007)(8676002)(66946007)(5660300002)(316002)(66556008)(83380400001)(44832011)(4744005)(508600001)(8936002)(33716001)(186003)(26005)(2906002)(52116002)(38100700002)(6506007)(9686003)(38350700002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ENem73i6DfXx0Tp+XMaa/7rYUeT3TLoKnPzhs5VrPF1z65w1bGrBUJOPalk?=
 =?us-ascii?Q?fgeNH0WD3sQcibgpSKkaHBj3Avn6rx1QtESqxcwyr71QjH4mSV9IloRvwOwt?=
 =?us-ascii?Q?usHVJeaS/lWuuomy3fg55LjYxkFn8fGI/1c9SIXxkRyH0gLyi8YSVOFJ+dD3?=
 =?us-ascii?Q?Zh6amfhuYD9x79sAuv4EqRckOF4yPUeOTfbadtSEYWQVzllmsHbJmyqEVkE5?=
 =?us-ascii?Q?c/f5fu4aopLHhsCa3NJ7mrdUXTPsMC/2aZY+VKYJpf8FLmv1jAZkVkoOl91D?=
 =?us-ascii?Q?16vq6Xs5qpwd8s7Su9sbI80dQPhQ1NkfhYRQvmNujXd1oI+D/0kl3/HktFXW?=
 =?us-ascii?Q?5eqGq7hMPCEXslAJ+4VAQBn6GWwa78wDlqXFofIZRE8qxxjMIQt91WNBs4ir?=
 =?us-ascii?Q?k5x9VKj92gbvkNPP57y+/RM5eacKutcYESmDGTEPsxMtaOTIOcoPRNPIceb8?=
 =?us-ascii?Q?LpNljaErU1Dk6ngUTfwmjJHzcAkhkwmcD5QkrGsBnBC3oTzEK38KyfEtMPFy?=
 =?us-ascii?Q?W64hHtdE55uOQmREOkaWahd9oqPmwPB6Vd7wuPjIehAUJN6XOj8+pFAS/e9v?=
 =?us-ascii?Q?OpOfKF7PY37SJuSvNGZ0rRdeOGxIp3UKXN/+5XSpDdIhjRcsJ2fVVgyTwvAg?=
 =?us-ascii?Q?kE1AQsBuITfYjadOJ97rJu/CqFMPFNr9/PV9ZBMEH+Wleo0logji0DMkdgFg?=
 =?us-ascii?Q?tOGD6kJ6O+D7jHX0ygGF5+vLEUJcZ8AuKK1McPqSNCXykmls2fGiNhY7Zcjv?=
 =?us-ascii?Q?0SHV78lsXJqGS3vVg6eUPPNRcyYL1dlwijkehRmME1gPfC7QQN+RLX+A+U46?=
 =?us-ascii?Q?0uymdZBRR0TsCpmfwor2/NMkIYmQ6X/E7PFIq+PTRZBuQf6lKmI1JY+88j59?=
 =?us-ascii?Q?g84QpZbRl5lUOB0DcaI+RlMXUKgQleSEyfKi7pf4ETTVidEhp6FCbvUKHoMF?=
 =?us-ascii?Q?CvrpubzueoaS0HDNQRbHeEJg+6tVbQGs2uWMI5thZwca7NA1rD+f76SHkHo5?=
 =?us-ascii?Q?uRfRhc1f3dCmxBrxEmAQkYR2gaSfk/97V/h7ZB0mLngK8sQlWwydoB5oehXK?=
 =?us-ascii?Q?xKvY4kErL7bXnzO7F62jTqL1ds8QnTcSJoX+/MZ4eZQdcwAjuSlLnqXIR994?=
 =?us-ascii?Q?i9yCi1dsHyRzv7kmHyAxBjb841M5YOFqTFQfGMMA5ppxM2ok9r7TQDD+A/+y?=
 =?us-ascii?Q?J/J+dXvc99MJElYLdltouGSDxpJEx/f1l+r2px0rewybBLVHoP0eS+bddjP4?=
 =?us-ascii?Q?eap/NjsBuhmtpi7DitqVVMZZPYaeV/qoqHjYWHDMxZ9ZGcVobABABGnYSA9b?=
 =?us-ascii?Q?kN2rgkbqv9ylqXICci1PETrw7buUM/fdrZnAFlfXZkfuhVLnS2r1H4aE3iiG?=
 =?us-ascii?Q?PBcOEGYMu1oTd5BfGddiMoAItkNqG2GLSa7JkoHPtNtmDGUXZWk3Hm19nSNq?=
 =?us-ascii?Q?oKkjHhwfmHjd10owGAB3Vvoioiy9EwPVNHVRcCJW3U765VrSfWoKWJ1qPpB0?=
 =?us-ascii?Q?+vnrjxKR7u5rePul8SihEex+RZ2Fg2vwr4vkwEPqpDPwFPF4c7HxOFLvtlRb?=
 =?us-ascii?Q?x2oMcZAtxVlPJg1JkdXJMTa40hRef62EUVINPOW9ta1Nr/bxv0ThYen8qfJF?=
 =?us-ascii?Q?yf6Wu56PS4Cp+PGz24224nWS7az6I2AdMYEqFnQNTOGjITNXRpY7feM/SrjP?=
 =?us-ascii?Q?k2EdU4yZPVm0bBIo9Tex6tRa92jBY5OmEA6yaK7AhrW603v2tvMpVcvlCZ8O?=
 =?us-ascii?Q?oUqPrtGSlpM1PDNW6111Dk0+2FVfbLs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b66f3f-5ba8-40c8-0ad5-08da399fa937
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 13:58:32.9136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wAuaE0LBL+0GO+blGUsMP+LHUq9oATrFcyS2A7Iz0v+Wc9Vp752BEtpTotnboFFl6dICoIvBvb5Vhp9xBnDu+yJtokvua30ilDcBnUU+Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3023
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_04:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190081
X-Proofpoint-ORIG-GUID: mneGGs2vYqbaIRXFys1VklhQ9GbxKCRq
X-Proofpoint-GUID: mneGGs2vYqbaIRXFys1VklhQ9GbxKCRq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "pdata" pointer cannot be NULL because it's checked at the start of
the function.  Delete the check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/clocksource/timer-ti-dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index f51d24301ff1..469f7c91564b 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -943,8 +943,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		cpu_pm_register_notifier(&timer->nb);
 	}
 
-	if (pdata)
-		timer->errata = pdata->timer_errata;
+	timer->errata = pdata->timer_errata;
 
 	timer->pdev = pdev;
 
-- 
2.35.1

