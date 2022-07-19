Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430A857910C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiGSCxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiGSCxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:53:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF33437192;
        Mon, 18 Jul 2022 19:53:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IKcVns023354;
        Tue, 19 Jul 2022 02:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=yQD78+bkBcvAHuUYZY1e0GC5D3A900xJPz0YbGMetwY=;
 b=ISKIc+QOq/F0bUO2jKjZm3WGlGmJojb7l2YJGHUCaCBzi3t4Q/Eg3/WDsRYhO8Bdkx7o
 wKpBSYFiTIWYMM1nhQd5s6DTPmty5Qvy/nyCyzP0x2EHbic+DwRtGlWNktbJd/8bt3+U
 r1VqD5V2Y/CcRz3MBiy0pBtn9nCgIfm+/vMlQGTsGt/ECw7Yed30yoJGf/jBWXFip7aA
 l6lXC8wgF+5576Y3SShv3w/qogcUvblF/4duV5fWTys1QwJ+OLsGtbbmvYGOPAtMTbyw
 BZ1PFwZAgXABzUKuv8DqqVY+eqJjJniVPQL+iVAcQQPpJwWSvOKEphASeS1Ly+4LxalL tw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtcxag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 02:53:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J0XLV1002150;
        Tue, 19 Jul 2022 02:53:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hrg8rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 02:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdMvnL/zhw8C9POaVp2KonA7w9AVUSfPMG4wrcJ6G6sbzj2QYLX3cljukZw+kfGvqdANc14DerKrYN6xSqerMAgYBhoaBS/BWvWextgQRKYugLE4/Nos2PtJnk9MxkLGeNthYhAwhNxg+FepuSPmunhLwiyXDlh+OQuGfAnNsOH9QZXaTDVTwQsiAW5nqDyZWWkR6VVK3GNDfXrHUSyGpFBTB/Di6r+dEW4zf3A/LU9uHYUttu1hpZSp8tDpQYbtFrLV+I5iUxPt+EeHMNWB1/3FuIS7V/PTjB+tCr3mrawS83d8i84Kttwf9tincOWw+p1Uuq55okcy8BddFMncsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQD78+bkBcvAHuUYZY1e0GC5D3A900xJPz0YbGMetwY=;
 b=QNq2b7SXnAAgKEJMvXEVirRz381/PLUZg4joncXg6X8d5sEnoJPqMffg4cPYTzSXMQZjaO9zgshZKfLDl2jrkZCV0tQMuFNYL+j60amopHxzOJuZfmyjecXCFYaawLanzsdAg0tHnDW4gYKIlxydEDTar1iWMdrO3bGHYHPNrm9gxaasXLwK/Mu3Umd9qoE/3LEBNJ7gsbI+xvQj/HJWIUIZXeYO2WhSWJRaWdMH5Slyuty9WnG9yHeCBXB+8xmVw5zx+LfGRy+OxEnEsnja2s07Th3zPx6dCDaDLjphytlRlx8VyvqfCALoQL5tbJF/7e9dBW+yu19J1Hxthz2JZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQD78+bkBcvAHuUYZY1e0GC5D3A900xJPz0YbGMetwY=;
 b=Mkb1/O5R183//w3SlbdACaYh1nqrZMMbp1r6BufKFNecZ1LyabjMLmk5L6a0MwQUQ6uo1C1VzZyg/rFMgzY0cyAx/2RIAPPghjpqZJfef3CxHsfNGE0THZM7bAOixkjKFr/AZmUnf+qiYlm9TzfYzqVfIOaJN6ZaDTECU8lwkiQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB3937.namprd10.prod.outlook.com (2603:10b6:a03:1fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 02:53:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 02:53:13 +0000
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>
Cc:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>
Subject: Re: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size function
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a695q0f9.fsf@ca-mkp.ca.oracle.com>
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
        <BY5PR04MB632776263A4B37AEB7373DE4ED8D9@BY5PR04MB6327.namprd04.prod.outlook.com>
Date:   Mon, 18 Jul 2022 22:53:07 -0400
In-Reply-To: <BY5PR04MB632776263A4B37AEB7373DE4ED8D9@BY5PR04MB6327.namprd04.prod.outlook.com>
        (Arthur Simchaev's message of "Sun, 17 Jul 2022 11:28:07 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::46) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33021d7c-6f6a-497b-03a5-08da6931d237
X-MS-TrafficTypeDiagnostic: BY5PR10MB3937:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQWtDlB6N+msMXk5Kr//7Qj10XN5TnNZag/ffaqUQ7kQfhp2i3v9klLFZFGPBC4pK6tPFggz5N3IA07WyXinVIYw5vTS8jYqZOZ7VhKboMmIccEL+TRJD20vGYzODiKZuRql2CvipACdXV0NvEqxdVhHWjKHzc4ZfwG5j4LUsA+9vB6/9nHNvhTz/77HS87TLGUceC5rZS3TBE/ouY0dbhhMGH80qzlR8mbO0mfA1yXXvmXHdHEDz1jx9CYrHK4IY6pOtiWQL3uLxGchimEdovltRHP4Gd4Z4u41deL5e6j80pkiU2Xd3n1znf7qyi7l5sFV/I9YzzjEocRUf1NVkwPzdoPn+q5xXdpeq6w6LSk7ikp4gM5yCrVBdA2CBSjj6sbwmEKOt16HOGfhM/Nf+ghkwe0cg0DYWenMpy2pjQNz9ntlGAUiJnrGSeyVlLQxbr/eOeIbN1fcQ+PQPXkhPDnncIzxaMxWRFY+P6LzylG4o73j+4TnRZO/Glaxm6Ut5kr05UPJsKzvq+rG0wWlRq/m6t+BsFYq0RLaL0bxUu3QvJwHQeVCszx6f6hm7FrIcJZK4ccIsNS7VeqbdSA0tgdqC5B/z8tJ4wJRmJywr6tMyh0fYp+WKuzXC5YoQVl9UzAURHgN+HbbQDtgDUfnk0OznhJhT+PowXh5QGA2pMYX3CjXeatMCuSf9I4BUkGGnSZ6tNKvjTLvY1vQ/itMaQn8ZYQXSVoPHFvWB6Jqah6gvVMCDDYAVMon/It3+j7VynxiStI9dxPpne4cC/knGaYqlJcLY/WYUAUu8Wl0HAltyOicctZ2REKce8jIoUoK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39860400002)(376002)(346002)(478600001)(6666004)(6486002)(36916002)(41300700001)(186003)(38350700002)(6506007)(52116002)(38100700002)(26005)(6512007)(4326008)(2906002)(4744005)(5660300002)(8936002)(6862004)(316002)(86362001)(66476007)(66556008)(8676002)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mafpK0DKofDha92NJovcjX3yc4CqyqAcKVyziEBUOKBFd4oSTNtsVovXEsmI?=
 =?us-ascii?Q?90OOhV79AsG8+POoSjVTnc/XozLbmmD4NuvGZKUz6cop27bzquFwqPbWiSmp?=
 =?us-ascii?Q?UIBWSkgstAoyvYMediW+ELkfj1ane7yanxgnwAQvddqIpwvawKj7GToLlmZV?=
 =?us-ascii?Q?2nyYb+chRLPVTdPxNecFHxeSRUdEInwQSTwtHqG2+YmIMUzC+amDAQOkKPLV?=
 =?us-ascii?Q?qwTH0gq8ZZ4ChwMx7sAIw9BK+xjXixxY/sfPEKwIV5mdc2hbjSCaEncx1RxA?=
 =?us-ascii?Q?7CjZbbfIbK4sECHywbwSqFw1L9m18K2FgO5ApGJgOXmPzjWeGo6ThbGAHKL9?=
 =?us-ascii?Q?AWRMm37/9UjgXAukGPyqrG0mpylIc/QtRwsXsE8uPsQLn71iq10GCDW5kQBg?=
 =?us-ascii?Q?h1feo8vCNOondR6O42rsi9m8i7AHlcfMq3xU5XybqWevoHZ2ZVAjSo7LnXht?=
 =?us-ascii?Q?eSoCKBHlQnyyo+F1RIxj8KvLO4Ov2M42xl6jDiH6SGY+MYDuvHndYF6e3age?=
 =?us-ascii?Q?W+GPh62eSdCpUBzzFFRRWTTkvt8N7eAelJC5gqFQ5vK7frPSl+GBYn8lRyad?=
 =?us-ascii?Q?XqWYd5/+Mlw8/gyoQ5RVz6KuTPX1+/kbs3VecEO9GKdBNGOvubLnKuuC22Q9?=
 =?us-ascii?Q?/4oQtxNwlAuZkHFYb59cs8kzWqgCJ/SYoIqL8AtVygjRm3Mt8QLI6MeCLpGP?=
 =?us-ascii?Q?g2jPHAJSF3owMQUoFEi/J6lFeOvQ02oUiQWVZyWspMl8f7iWxWuJG+EelsTt?=
 =?us-ascii?Q?4C+EIRxBEIG33bEZwaL3kVHfeffdOX/Xjy15eEoryJR/X2itZ1LQQodhwpMG?=
 =?us-ascii?Q?bX4tlpwqG12ytrB4pbpBKV/gEw7IhI+hM8H3FDH76Xcr287llmXRu5tszgBf?=
 =?us-ascii?Q?S0Z5vy+/UiWJUY840sPoiTed0r8KM1sSia+tJWo97JVGkiPjRzj9ZZHGl9xO?=
 =?us-ascii?Q?kLyyfVL2Pelz6x25dOCEc06FRsMqBrP/qMQw2hEvSc0HTZoAy9U4ticKUzoK?=
 =?us-ascii?Q?JfvcQv4ah39CkOvLyXXKzR4PFGutZ2f5teryKu8Jv+smNZXCyqz0q2MVii2Z?=
 =?us-ascii?Q?DXrPjNIRFUtlbHzVzvjISF1+hhrTsaAGxfq4BaCv+ANhhMxV2Dyx/l5eh9E4?=
 =?us-ascii?Q?sP/JmG05Z70N9cN40OAdvosN9FGRrUwF1kp5cLnbox9m16Umf/BTCg77IeUw?=
 =?us-ascii?Q?4XC2xsQfjDl/UY7RmhMMQfCkD5J3HNeuKyxKcaKupupDX9DRd1Ye3D+GnQOE?=
 =?us-ascii?Q?YNIerZPyKMhZoEyb+dPLXq9/yU4tB3yb4dWGDDZMpBNr2Wuhf6agICHYoCGI?=
 =?us-ascii?Q?LeVlQKvMjpyR2q6H8RX+Licc6c7GTRh3WXgJZRJUrc9UbrN4PhXpugQNeK9E?=
 =?us-ascii?Q?3yXQxZpnmgUTxlMoE4Q3JiwiwC/k5B2LmUC8MKH1/3sB1O1UtOJMJ6jKpx0w?=
 =?us-ascii?Q?dlUCMMpBhU39SAVMSt03QrXqOCgbw1mO/Zl0FWr5hZDl+y9Z8RazjYwpL5Ra?=
 =?us-ascii?Q?BMY/uZmOvEX6V+6ao59WAblbvXx4Pre8epkvR5YzYbq7mLMeMH36cTiEzRGY?=
 =?us-ascii?Q?Fx0ml3EFn5W2Epsynj9aWg7Sf4mkSILLWmJmGSGFc2kLT03nGEtYJHto7+zf?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33021d7c-6f6a-497b-03a5-08da6931d237
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 02:53:12.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hW7kA/L58IcEwvtwVnBdXMvWMucFT6lSNcph8/FsWCOYTwtNFhcct2MZ0JTS6sj4LvrsJDA8MvQAXfflXgi9z3QShTg/037s5ynkKXM9QHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=955 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190009
X-Proofpoint-GUID: gn6Q0Ng8Hl7EQ894XbL0A4MhpNRBKBRF
X-Proofpoint-ORIG-GUID: gn6Q0Ng8Hl7EQ894XbL0A4MhpNRBKBRF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arthur,

> The bsg driver allows user space to send device management commands.
> As such, it is often used by field application engineers to debug
> various problems, and as a test bed for new features as well.

I would like a review from UFS stakeholders.

-- 
Martin K. Petersen	Oracle Linux Engineering
