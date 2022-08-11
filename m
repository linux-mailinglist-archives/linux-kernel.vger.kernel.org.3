Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B7A58FB06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiHKK7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:59:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC999353F;
        Thu, 11 Aug 2022 03:59:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B94Z5E021902;
        Thu, 11 Aug 2022 10:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=VWRVGU/G0qQeM11mwceC3JtYQYn7ZB+jO/Ytf/55ttQ=;
 b=J6hK+UWXQZlGzdECyxXnvTEtR41CMZ5z6SxCS9ur4/LAij5qfKUdJG7Nqp2OblbKyTpn
 ekM0vhPk248eb7lIDzj8KyA2d86iRA+csE7RjUMCVEROtAD1pK6CxjOO8qjSGsDAAlrH
 ZAjPCLxJ8cmbKLbgpw7ijbbCodz43hLy8/7rja8orFuKfmtT3ZGduf1/gt8xeuQ4jXug
 wy6vUnpsX9PXWi3SCWdUG62E7RAlE8B97Eohc+bF9Huuv5NYD4ggflDs9cCE5cKW9mnt
 QJiGtcKg5kLaHFKZ+PGWkPCd0mTfsYXK1Ey8AIo6FrlyagwoKD+jQxl8wm0hfUO2OheU Qw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqbmgma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 10:53:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27B950NO035254;
        Thu, 11 Aug 2022 10:53:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqk0w1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 10:53:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X70geARK9gzVqa4xEBfALY3ASU6f3CfhG8GnlWLKSehEFo4dB6X0nMOjfK0g1v8geKnPqpmkYSaeQdnPbKZhk9A0Qo+YMXeoL8pmSEPTQ1/HTE82a6S481kABn43sknl/egNHOCOlAH49lc7AWvceHtsTIDeGv7uu2leaHbCy5TWtEs1Zg9IVSnMC6LmKx2NLoBPo7VTIa3PX5iHEZl8e/fHaUpe+7dYy1kc7sbTl7GEOUCkjEKRvt1B8d/9jasoX+3dd4FInp4Um9JhHizcc0tdAr4l8jLaFuJdoL2o2QoLWJLF+J3f1VqSS7pz0+Q2auMZNv0wLT/qtF8EaufHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWRVGU/G0qQeM11mwceC3JtYQYn7ZB+jO/Ytf/55ttQ=;
 b=M7s4V85rBDQRGlqbfbkAKZO8IT/ph36QSPShc4NipzjFWAK+2jOZniHMrBel936RkU4lWmPp+eKfZegIuxP3lHycHa6Z8FrGbH+Y3IPLeqMeAqMiqXILw/GEIOiBL9dPQLX9qNSpD4yfuMLZysl6OIpfcIhIk4C6I/yaoOvi5r4NZ9BVjmSUZTcg67d192MigrdxvRo04Ra0w4mkhPmtBsyKBVbiqsgjlVcWGv5xqEc6hCGo9G0f+ae2KMomAqIKtp4eTvvUzbKsuluJCbFzB0IC83I+4uuxvv4JKc7og3/T+XfCcmXDBRzq79AeF8MiyXtivnrkRuxNY6sazXez9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWRVGU/G0qQeM11mwceC3JtYQYn7ZB+jO/Ytf/55ttQ=;
 b=aeJPWRylYOWR2w2QGM5lVsS0O6TFGDMTYMB5DVgDlq1iSXboR/JsUIlwcQO0yP8eZPAid9qlhbCFg69h5sowAF7XQC/eiVVSEFXjPQ8OPgID/iFhy2IOMFTECxTNSU6KbdrehpZtvna17OqmF3aS0ub735m+3em5qTOXh7q6PTM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1708.namprd10.prod.outlook.com
 (2603:10b6:4:e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 11 Aug
 2022 10:53:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.024; Thu, 11 Aug 2022
 10:53:17 +0000
Date:   Thu, 11 Aug 2022 13:53:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee@kernel.org>, Martin Kaiser <martin@kaiser.cx>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mfd: fsl-imx25: fix check for platform_get_irq() errors
Message-ID: <YvTfkbVQWYKMKS/t@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec08b1ab-1c02-4b0a-2785-08da7b87b246
X-MS-TrafficTypeDiagnostic: DM5PR10MB1708:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uphVC5OwjOYZ4PQz57w0bjx9HrVSRp91e0iqqV0DxwF09K9jofcR9hLmaEnUGYd1nhjUykyKx6H2jhTTpkwUTZSKFhvJT+37Ryal6WsoKX5cqgURLok/wz7SPmyUJzTD93SuD4L4dTF+DVH3Xbm8xSlxkxnw2cgOdfnW9PBRTtE291hHRQ1FRK/bn06LRbxBEXw2kyktlxddPpk4XHTuAtzmqVfGiZT+6RAxkTQrZzqXst6KuGnHsUcJdPzeGs3+VzM/1566nJePRppFSf/Up6S5Fs00KRmEbPptgm+6y7NmWqpOwkCYa8mmVRg5aCJ17I/rT6w1BTTW7ei810TjA64ihLhOe8QDwerrQjJy6sBslG+hcnplzZufdAtpVM/ttVnDRxHhwqDj5bwl5Bh3K9IbGpEI8LOx1Rycremtzp5JfbLn+hss6UCbuAyFsyUGYQr8reApeLMQzGHDa6hQO9ttgN673TAheT+LeeJIseSWfUyzvnGvdxdwMsE5qKHUzxpp3zt6+An92r2YP3wu/pjhT1OsRKBDgUZRH9tjmwLnaRdf0l/gWR8BmTBzeTEdTpue+tSHRy5heDEk3ragaPggIZsf2Bz7CSRfhu+ZJo7RfganPdqTOzY6iVDWKXhQvDkaCWRoPN6R8AbMXJAS+r6A+zZNNls1VmxnmX5GLsucykBOxbczkIqhnUbSfF8UP3GLCLtiK7uTerJvNZ5SbwHRqgv8Oh5L3BRNjlURGTLMyIn7mmY/rP+V5LJi3oK22lTCocNb8xvKMaWCJwI9snOpMEv4GcoWmb27QzfmyeSp+w0rV/zLItRYLmUkdZBD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(366004)(376002)(39860400002)(136003)(44832011)(8936002)(9686003)(52116002)(5660300002)(7416002)(186003)(38350700002)(33716001)(38100700002)(2906002)(6666004)(6506007)(6512007)(26005)(86362001)(110136005)(6486002)(4326008)(54906003)(316002)(83380400001)(66556008)(66946007)(66476007)(478600001)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IpztbTLYi83NIc+J9+jooQXRbRuFZ3JUsacXfW9lYwet3A/eCdAbm5vVtiYc?=
 =?us-ascii?Q?HHkpVOCdCdpscK1o/Z3zXiKVjTTMwOra+1//Sd3+RU3WYg0Fw4Zm6hn/HCHu?=
 =?us-ascii?Q?ajIgjAIpbjlHl05+KoX5XMS1XcL487ALqRkBqjliNK6737prZGM37stjcxLS?=
 =?us-ascii?Q?SiwL47k6Pt2wy/7EpghbmXeilIeKptVy9fvKBqZo8b0YSitX5nY7Z3GI3mkn?=
 =?us-ascii?Q?aAxQaTaPs6Es1ugGob1X98A5X93BLjUG0UxOu+V7h1obHsEnVWBWVZyD3Zqt?=
 =?us-ascii?Q?D+lI0Bugcbfs+Gmc2MSsp55UPNZIc4xNGoTtTBKyynBYRZUdhDIA4UbniYWn?=
 =?us-ascii?Q?AE6cub3tQQNe74LbYlcgGs4+RjIj/l00LhYGl+a4A7pA6tUjnIBosHRUSjpz?=
 =?us-ascii?Q?zlpp3VPAhB6jl3EXd4oQQrJoBdUYh+c29mFBiG7JaSuH0ZSp3/rHnfgM1Csj?=
 =?us-ascii?Q?cFW2k9ysQDJ7aeUm3EJz408BimC4wLreNfE/cHQ6eCICJYwWeTbxlRLlpM4J?=
 =?us-ascii?Q?TloGkvR+9Ldu1ULkXsZSKE7bVl9wsF7k375dIOm3O/WzpfbalN8YnYoLpNe5?=
 =?us-ascii?Q?GB4U82Dqlr7R7tIRBaLfNYv1mhb2IYYG2vmSy2rPEmVNeHitXDsi8VtZJh1i?=
 =?us-ascii?Q?Eqzjh5fqj10uo7S/lwpJzpYPxxSOy3DXzfQoOMpfhGOIMnkFCkQApVSO81vS?=
 =?us-ascii?Q?YudoCqPeC6/SmeEG+4Ze4I3IaudQwTZvS8F04IrbaHLKkKIBIWCxIK5DNcL3?=
 =?us-ascii?Q?sBdBxi1NQmNR/+lUEIqP783nosDrNs4YakvxkV7lLvAjG9lE+YgdoPKf3UMD?=
 =?us-ascii?Q?FL58Qs4GlosqlDLnBNcS3wxTdUOkAgCsZeTuHBytjZTnUae45kvxJIYt2B2g?=
 =?us-ascii?Q?kHjtDk5fjI1kapulW5cFYvx8kc3m39TD7zrFKVaHhmOUF84rjyk3uCAFRkUP?=
 =?us-ascii?Q?INyQ7wWVlKe7ZPv3bj+riZd08JrqTWOiouDa4CuDA4F24fMj1qREr0MAt7xP?=
 =?us-ascii?Q?g9MlEHoc+hLR2ZR40mHiSG3IzZX4WcuHHgQV0YPebrCyKvuI1yu49/U5TS9W?=
 =?us-ascii?Q?MtNRdoNVEa8yeoKOv8jkGeQvZqlew+racqMlPMiog0maAuJHfJO2TzRMjo8b?=
 =?us-ascii?Q?2ulQ096s9V58myUbETkNW8+H/1wVI5Ht5fnlI6cwaGcHa5Dv8w+SsYKI7U95?=
 =?us-ascii?Q?OwUDT3f6mOZ6F28QqvD4RhEO/gjFUGpsOjERXTxs3XdWH7sc2xQZmkioe32R?=
 =?us-ascii?Q?ISCqS9F6pXdRG//5SWu31GJPDtDN/u9BdNFC2CdDpjnkN3NbB7Q1xTrfpSy8?=
 =?us-ascii?Q?z8AXgb9Q+jCcE2FDkb+QVyLaL5s5ckO1a/+fAXjioSva5pmtCcqQus0y0FHX?=
 =?us-ascii?Q?S9zlGxfcOQE9m3gfV7XLW4knMI8TZNtlIojM3blSCI5ypCtTQzzsZIgJiCBn?=
 =?us-ascii?Q?0jd2tAJ0N7w611+OLQr1wFxjcQAbwTQvOHEbUY1NL7gm1mL8qctYyuGcQHlF?=
 =?us-ascii?Q?J0NEg9qpnXAGyz3av9Qsyo3XtQDv2rJDoz8RDflfA6YI0tHubDqMs0tgsJBb?=
 =?us-ascii?Q?xO7crZJHi0LJeu39rTFTorDG22pUXPYEnWwkRWZbjE1aJG9MpC128xH3ooww?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GaLkfBDCwIh5NiGtaWUZh1xap7necawOJa91XofHSqFcV/G95OQRPae7c+MF?=
 =?us-ascii?Q?U/BiJFvqBpHQI5ypmdzuTIb8S1ZMyjvS3PbScN3hA/ewiRUEY/XfNK/yjt0f?=
 =?us-ascii?Q?9fl3zQ/DAY4ZReAGaR0b5Kw30X+2OFS0grdnC6opd9C+SLGVXPZV49bhnLm2?=
 =?us-ascii?Q?ffOYvl8O+kDbYI2+NTq/E/mrf6LBYnQ7rWl2+Z7+owpIwhrfuBP70GgsnYTn?=
 =?us-ascii?Q?RCYksyMuBeFFLdSoLZm9kY19Uu82iJ9TInFMnDeNALfLeSrOKyY9Zhr6ISAJ?=
 =?us-ascii?Q?mD7Uk/nTYPEZosfQr6lQmgNGLRzqOV2Q0sjzIBkVbsdDbPmcEf/d4YUE/E0/?=
 =?us-ascii?Q?Y4Bnfbk1JSXiTtnnuTnCGinSBWyS6DFPh8RsxDlTSJsyp7uGCMFg72cwcIpV?=
 =?us-ascii?Q?DpGLiFX01pvxBrc2sRlx3PDtr8bPHhI0P8W7cndYPwHq/kBWjtX7wUEaEbVb?=
 =?us-ascii?Q?TJrwWqVKC9ESElMDQqqS89Z6sqrNzITe6KU1U86DE7Q6AFrAO2u+9Y6bBgOB?=
 =?us-ascii?Q?WLCDxGMwgxCaZo8CyCuIL5cfT1kTo2Z3VmQ9/FyogTb1EVawKGLY+E0BIGgd?=
 =?us-ascii?Q?T8JVYC45nJI0qgrEGCZ4MN7uyX63BhJzG3mGkiyt7XpUBJh66a+DaeYgoHAv?=
 =?us-ascii?Q?mlg6tDRBAOGNRBjI93PCrpkHU0zsvgmg1Sw/Fs3eJxyFC009+x000kqQfV20?=
 =?us-ascii?Q?UqLDVqI1iZF6VW1RXn4FQz19QPAYh8JQS8agvRYHl4CEev0ZoqgrkCyopXAE?=
 =?us-ascii?Q?xDqDlJpOh+UAsfdYSKxJwsCmV3fNNgXxtrk1oRc9FthWArpGLI79AnUPcY5f?=
 =?us-ascii?Q?JMzkH877nEbJm1He+kKvsPqxKTns46x5bHZNJLZTPmGTkIHWKI7swtrlbgGs?=
 =?us-ascii?Q?rXf+7iRupgbfofnU952ZtF53U2v50beFdF6yuFk46kto3QV0m9TtqJFQfihl?=
 =?us-ascii?Q?A6DTWuMrEGLsN0VQzZeIrL/78A/6InFhR6UiG7mcf4nONmvbfDIwJKXSDGLS?=
 =?us-ascii?Q?wqdsRAeO72SkO7UTrlr9PoHvW/unhdNv96Xp1v1pdPdg47XuRoulHbyCEZGQ?=
 =?us-ascii?Q?bs73gY6amLQxrVbqrrBnC7og0+p+1n6siRerB6XHLrGVZnaO1gOx0Vf09wtm?=
 =?us-ascii?Q?C3OABOuHRtEocMOz2T4Er6qEgSw5SHC6zn35tOybSJWrWE88klcv7ppKj95v?=
 =?us-ascii?Q?a5K1PZ1GcyMvFbHFTOYXFvAMclC0SH92VdEJajayLK42b3VZ0PrPd1k3jmM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec08b1ab-1c02-4b0a-2785-08da7b87b246
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 10:53:17.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGSE02cV1SUSZq5AC5Ziz2rTLK4HgH4eShbvTWqZxdNY/YTTRwp0oj8e3IzrSuhzNVw5Fj2e1+u+fmuOahsnEXsT1VpovDoJAEZGlPZ7cZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208110031
X-Proofpoint-GUID: bo8Y_IGJGd27hc56k6lmzIoVnRBl2iYi
X-Proofpoint-ORIG-GUID: bo8Y_IGJGd27hc56k6lmzIoVnRBl2iYi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mx25_tsadc_remove() function assumes all non-zero returns are success
but the platform_get_irq() function returns negative on error and
positive non-zero values on success.  It never returns zero, but if it
did then treat that as a success.

Fixes: 18f773937968 ("mfd: fsl-imx25: Clean up irq settings during removal")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mfd/fsl-imx25-tsadc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
index 37e5e02a1d05..dfc6da9b4aec 100644
--- a/drivers/mfd/fsl-imx25-tsadc.c
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -69,7 +69,7 @@ static int mx25_tsadc_setup_irq(struct platform_device *pdev,
 	int irq;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
+	if (irq < 0)
 		return irq;
 
 	tsadc->domain = irq_domain_add_simple(np, 2, 0, &mx25_tsadc_domain_ops,
@@ -179,7 +179,7 @@ static int mx25_tsadc_remove(struct platform_device *pdev)
 	struct mx25_tsadc *tsadc = platform_get_drvdata(pdev);
 	int irq = platform_get_irq(pdev, 0);
 
-	if (irq) {
+	if (irq >= 0) {
 		irq_set_chained_handler_and_data(irq, NULL, NULL);
 		irq_domain_remove(tsadc->domain);
 	}
-- 
2.35.1

