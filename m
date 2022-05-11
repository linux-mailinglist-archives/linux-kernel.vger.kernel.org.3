Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AFA5240A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349098AbiEKXQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348520AbiEKXQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:16:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA7919292;
        Wed, 11 May 2022 16:16:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BJUnBq003190;
        Wed, 11 May 2022 23:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=61DLs2XvmUY6Q3wJu3+7uk9UaD5fBMbCn1/FU7tWjwo=;
 b=Xilkk90cPC+Qb42oOHtVKQKOVl2Zo8oBEqIpv5AlH2Xs//PTufXIRJ8pUbKHjrBr7ruD
 rj9RtZIyU8SSkGC+btabz1MplaM3dowpGh98YSkeLz2V3zmHYym1ZwwcgBJXZ9iSraFS
 RjEHJ+7VvujZD0u7XKH/+X9LF1xvG67LwqIeMy8Rue8kMTXDEtPnM1X++jbkxCpKng6I
 e5Mf1cn1/j+S7/ThxcEzPIH5rG1tl1eLRtk8ZMzxrN65p6YhiC877oQjle6i+kaJ1OXr
 gB5X9QOx254Sw/AaH78uho1Ork860iR0z8cOJEvQIMZ5EmpgFUNKbZ1azscg2GmCGRDG 9w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04j5y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 23:16:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BNATf1001451;
        Wed, 11 May 2022 23:16:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf74mbbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 23:15:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvI0gjNKGkwW7pqnTfX/uXC2KdKOLG77WVKPLD+SyBssDd0TbVDEXzuxm+FZBLR5RFj5E9wm4zmK/e8VjiAqC2c/9JUiqbhT6xly1OxSnfbbiVDdSF4VZdmuEzS2gy3pcpwS1fmUJLQbDV4DzwKez0qkMHwkMN1MdToTuyyCKjeGIY0XMz7VriD95IayGU5N75Y5KWzIUScNEjGsDjjhJfZ6YcWW+2U5P9ao9uhSky+jDRCYq5+f+HjioRLjZwYCTE29q3EmneqAiqRZHIU1FWHKvsWUBihqJSb7zCjHtAh7RjzHlaewi7G/xkFfG+VQvBPwG4mU5rcdt2wt/raqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61DLs2XvmUY6Q3wJu3+7uk9UaD5fBMbCn1/FU7tWjwo=;
 b=Ui7cHjSDyjWHD40lWU47uWhZuIsCbiF0DFDCpVALi/gNgNpqbtftK8w4CPLw9z1ffnfmb7J/8Hze1QuWoy1zmqB0cqoxffq1PdX9O93hr1fODHEY8k1gDnauzs7iDL12MMOQKuzUZspfVaKREgdfOP2Sj8eyIcPV73paqijEOqaKsJgoX6jKhVWgrGXDREUUSSKPNAge1fIOTb7oJ/niOwCBhrCly+66kMz0tEL2EWTnPc5PMiQMe//6lXcs/v6isa+wialPGEIyDAaX9c7gFz29uwdxIydYa/YPpQTC6eC0V8kG5lxzAsQyzDpp5ShlcYeFOtXlPcFsVzIT6fC/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61DLs2XvmUY6Q3wJu3+7uk9UaD5fBMbCn1/FU7tWjwo=;
 b=H48aSCjeKlxZ558FfN25vSiDAmbYVoargR7wQ0kBvejxnnnO+MO8iOCCJwpVnYegh5BuyFGXSRTnQ4qw7S5eQUbmyLT7TuXWZ8jwxSs2+CRqv3wGLrQFR96vaziIE5JwEfx1iXuLezzAcae7ECjdW9TMsahKipBcilX71PV3dGQ=
Received: from MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19)
 by PH0PR10MB4758.namprd10.prod.outlook.com (2603:10b6:510:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 23:15:58 +0000
Received: from MN2PR10MB4173.namprd10.prod.outlook.com
 ([fe80::c05:4338:8a25:946c]) by MN2PR10MB4173.namprd10.prod.outlook.com
 ([fe80::c05:4338:8a25:946c%8]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 23:15:58 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        keyrings@vger.kernel.org
Subject: Re: [PATCH] assoc_array: Fix BUG_ON during garbage collect
In-Reply-To: <20220511225517.407935-1-stephen.s.brennan@oracle.com>
References: <20220511225517.407935-1-stephen.s.brennan@oracle.com>
Date:   Wed, 11 May 2022 16:15:55 -0700
Message-ID: <87ilqby82c.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To MN2PR10MB4173.namprd10.prod.outlook.com
 (2603:10b6:208:1d1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7befe571-862b-45b8-3e31-08da33a434af
X-MS-TrafficTypeDiagnostic: PH0PR10MB4758:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB47583FB46E78E9D81D3BEE63DBC89@PH0PR10MB4758.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBELANnhIGYGY67ayGGcsq79fFxqHtGtcJk8K7B1UZ514YFJ0ffSBiQ3pIqy5FVpR3tU6n54U02c0XbNpMX+Qivo8akaPEeVWUqrWMIAhiL+rs30Nq3A9jaDExI3U7hIvTGZ2O3r6kyPjvWqntBISv5q3Bzm7SLPwK16y23CVk82mWhZRj3dqnBRyBvNQ/GiSZu7+CqWBkAnyCX+RURb06hvKFFMc+TLoGporhrGIl2AmZxMFjsh8dMjbYdP50Bq1k2hcdb3wOooHKcsQumxjWtIyMYbGEzdnjKLH5Y0ZHaRx+Y+yGVI1ka6WcKBnIbqToT4+pPjOaY7qaMijON9T0GE0HaKU+xuYKth/ESYBnAlIVeQrX4fw05Ap0mYWcwGBX1uee4SQGvMZ0sQ9bWQTMnblzRZmSk+lOib1itxuukig5sotld99/QKoFKI9cA1zU5dqdLy4Ugdt7asdB1eZp0/UWhJMMiTtLS1CeyaS5+y8nO9p7Iz2yyHrE+yyRen9KB188+YJihPOAgccd6ZxsT2cQ6Pcsvb+aun4Aq+CrStpYDPZNOxle2LvenGVaUCEtol5vS65PiHyHZoUCXEk5veKMq7uk9bKlY7kM+xiirkNKuq8Sk9uZqDXSBTXH2h/SG0w9NXNJZqrPwQ3J5H1nqQek5ALqUvfjzblegrrPraVnoOvtMV/3q2rhnBP54ZMmcBxHrZ2t8PncDg/nmwYc0MXfqlefLOJYI0VFYrxKTdstG//7qV782DRCrX7+PBhTClKUV2DCBvt3NCizvHT6o7eyTH5KbnYJrr/ciEc08=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4173.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(52116002)(6506007)(86362001)(6486002)(6512007)(66556008)(26005)(6666004)(5660300002)(66476007)(186003)(966005)(83380400001)(8936002)(38350700002)(38100700002)(8676002)(4326008)(2906002)(54906003)(6916009)(508600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z44fmWzITdY4ceMKUwUqbWB1IibtqWa3aH8y12ola3Atz4+ijBwyZuM2ZzuN?=
 =?us-ascii?Q?Vhoeyvo2j0FVZ4H41sYK6+BbL5KGi6MCurUWWlImxd/e91D8T8j5gaFZ2Xn+?=
 =?us-ascii?Q?tuIUsZ4nyijB4jWy9OOdVBRK1oNlAI8rQ0RZXp+9SScd0TSfi5likOCDPEIY?=
 =?us-ascii?Q?q0onmU7O8/Y8mqno6vJTsuhuFPRHk4/nbsV9m2BYoMf4eMU/T+d0Wr0VtE/f?=
 =?us-ascii?Q?qd4SpIrauA+Y/7v/G2pdFdpzTwLdIt8d5hFvO34WWmhL9PDLZ+I3BnrzUiOO?=
 =?us-ascii?Q?xGiLw5PUkjSk9hSPx9mJiRgF8GSPuGNO+Qlt559RRTKVvkIJpO0QD0uJJdUl?=
 =?us-ascii?Q?n7tbc+93LBc6Na/3aB6X0jr7kypbL+n6i3y4Ytu1T1J28PN2dnJPW5LcUkAQ?=
 =?us-ascii?Q?kJC665VPkpEkkenNgsRCbc0Lgta0o/Q4TLgJQQakxPW66qWpNvvQDBJKbVLu?=
 =?us-ascii?Q?MGEKvBgQ0pFBZq6NPLPDuOQaW9tbHpPHZqunWBuz8AKkgdWXjwjyV21YEGtz?=
 =?us-ascii?Q?jwjvIH2X5FQrXhwSnatEf+pBYxVEFmfTwTfEZtCmt6jHSSJRI2otnODypPcP?=
 =?us-ascii?Q?9j6INst0M1oOanYm8YFVv7Mj5ZYjp7thartLXYJ7q/0HrACdsf0fOCTV7O9w?=
 =?us-ascii?Q?c9NiPeA316lsu2xg1dYy7YpId554Vn/c3vhvwjdoLa/FRYrtrBQDX3s18r9T?=
 =?us-ascii?Q?5YfMTnQ2i4QMcI7eur5eEtdpSs3dw6pq80ESa2nCUhJFp4hoeRyUHo+Pbazt?=
 =?us-ascii?Q?M/GVUd0yMxWOA3h839qatLzw5rWpVHO7yPHFq8rC2n2n7lc5YzNGGQhUU2/O?=
 =?us-ascii?Q?GK8YAl9+qFfRYj1r8qyrpqL6S5YoH/5g3TJoE0s8nCaiYtxhs7FfH+85iGM2?=
 =?us-ascii?Q?MJqp6TLb8oDqODc6wGRHnv2fvJNPxep+Uq5Y1m5x/0TErxmj+cy3lmLZQgJA?=
 =?us-ascii?Q?oTaCpebVLbXLrDPG9qvsnxdPkhXytw8uBR1DwANZjiCOQAEjFiZ4m+0qMkPT?=
 =?us-ascii?Q?37TfgrvIKW4j5mWC6Dpggx1Z94cuV/LD2m581GYLn+8rz2G9FXBf8UmvHCvx?=
 =?us-ascii?Q?VDfWu6DJG8B2nKvdd2REPoeiN989JjevqpW8aVjcntTWHWESuZA9YY28RAWG?=
 =?us-ascii?Q?22d170hdbJ+Ib22cTj1btboXlqdu2j4DquO0iftag8OYxuC9iVdd10esCh+G?=
 =?us-ascii?Q?TRoQBo8FIAHns/35U5nA+YkX3qJn3N+3AsC7zFCiM9AqfNSXpX05eHFEFFfc?=
 =?us-ascii?Q?AVM9wIqR44ylRS6kuiyMUYwhBgOjKYEWmsNbHOK1cRGHw5rrLxhX0p2lBFwk?=
 =?us-ascii?Q?JrRhM+1RYwxIi//3qZWbua1soenR3ZAoKRZtRXV0gGFY8AfWLUSUwT4JI2Va?=
 =?us-ascii?Q?/Pzv0NBBcDRk/EryUw3aRHn1suoVMM+ZoAf6fQfy0cMGmGgRvVH9cSkBudZN?=
 =?us-ascii?Q?2g4Y8y3J8wO4j+lkbI+gmcva+6S0mBItVMykW1Atbbe4ZBSk7bDWj4gKs50R?=
 =?us-ascii?Q?S5dW1xkzWgli1j2o3D+2y0H1wF6tTdLiFNc0fCpeAD9Dk1t2MgvgI2wdl85I?=
 =?us-ascii?Q?pgxAXujN+RaXZdp4upwjdgK4gsr0LXQ82apzy//vt/DEPztAMtmIsGIUAcOJ?=
 =?us-ascii?Q?mvlamL7rh36WtMsRgQNQaKmxJT1OhpKFwyudXpoS3oK/Ki1PaU/kbAswI54a?=
 =?us-ascii?Q?aj+2h5d70qM5DWTd3HM5stOLQxi1MHWxHZdwk5gvMrv81idiFEkSga16rCVU?=
 =?us-ascii?Q?sQ8oFxVnO0dQdKlOgl7eY8K+s9Q3bkw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7befe571-862b-45b8-3e31-08da33a434af
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4173.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 23:15:58.0086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0ycg/f69urmnP5axlztwdEqQdpmc5YetweHqxB82FLmL636yCFy7cyWDzJDwaRJcUV0u/tSkR+z5EGchPiMJnqQFEyErLS9xBgnt/jcqFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4758
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110104
X-Proofpoint-GUID: peFkbSoy9A5GiIXyX_M2iTcjhI6EWX-I
X-Proofpoint-ORIG-GUID: peFkbSoy9A5GiIXyX_M2iTcjhI6EWX-I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> A rare BUG_ON triggered in assoc_array_gc:
>
>     [3430308.818153] kernel BUG at lib/assoc_array.c:1609!
>
> Which corresponded to the statement currently at line 1593 upstream:
>
>     BUG_ON(assoc_array_ptr_is_meta(p));
>
> Using the data from the core dump, I was able to generate a userspace
> reproducer[1] and determine the cause of the bug.
>
> [1]: https://github.com/brenns10/kernel_stuff/tree/master/assoc_array_gc
>
> After running the iterator on the entire branch, an internal tree node
> looked like the following:
>
>     NODE (nr_leaves_on_branch: 3)
>       SLOT [0] NODE (2 leaves)
>       SLOT [1] NODE (1 leaf)
>       SLOT [2..f] NODE (empty)
>
> In the userspace reproducer, the pr_devel output when compressing this
> node was:
>
>     -- compress node 0x5607cc089380 --
>     free=0, leaves=0
>     [0] retain node 2/1 [nx 0]
>     [1] fold node 1/1 [nx 0]
>     [2] fold node 0/1 [nx 2]
>     [3] fold node 0/2 [nx 2]
>     [4] fold node 0/3 [nx 2]
>     [5] fold node 0/4 [nx 2]
>     [6] fold node 0/5 [nx 2]
>     [7] fold node 0/6 [nx 2]
>     [8] fold node 0/7 [nx 2]
>     [9] fold node 0/8 [nx 2]
>     [10] fold node 0/9 [nx 2]
>     [11] fold node 0/10 [nx 2]
>     [12] fold node 0/11 [nx 2]
>     [13] fold node 0/12 [nx 2]
>     [14] fold node 0/13 [nx 2]
>     [15] fold node 0/14 [nx 2]
>     after: 3
>
> At slot 0, an internal node with 2 leaves could not be folded into the
> node, because there was only one available slot (slot 0). Thus, the
> internal node was retained. At slot 1, the node had one leaf, and was
> able to be folded in successfully. The remaining nodes had no leaves,
> and so were removed. By the end of the compression stage, there were 14
> free slots, and only 3 leaf nodes. The tree was ascended and then its
> parent node was compressed. When this node was seen, it could not be
> folded, due to the internal node it contained.
>
> The invariant for compression in this function is: whenever
> nr_leaves_on_branch < ASSOC_ARRAY_FAN_OUT, the node should contain all
> leaf nodes. The compression step currently cannot guarantee this, given
> the corner case shown above.
>
> To fix this issue, retry compression whenever we have retained a node,
> and yet nr_leaves_on_branch < ASSOC_ARRAY_FAN_OUT. This second
> compression will then allow the node in slot 1 to be folded in,
> satisfying the invariant. Below is the output of the reproducer once the
> fix is applied:
>
>     -- compress node 0x560e9c562380 --
>     free=0, leaves=0
>     [0] retain node 2/1 [nx 0]
>     [1] fold node 1/1 [nx 0]
>     [2] fold node 0/1 [nx 2]
>     [3] fold node 0/2 [nx 2]
>     [4] fold node 0/3 [nx 2]
>     [5] fold node 0/4 [nx 2]
>     [6] fold node 0/5 [nx 2]
>     [7] fold node 0/6 [nx 2]
>     [8] fold node 0/7 [nx 2]
>     [9] fold node 0/8 [nx 2]
>     [10] fold node 0/9 [nx 2]
>     [11] fold node 0/10 [nx 2]
>     [12] fold node 0/11 [nx 2]
>     [13] fold node 0/12 [nx 2]
>     [14] fold node 0/13 [nx 2]
>     [15] fold node 0/14 [nx 2]
>     internal nodes remain despite enough space, retrying
>     -- compress node 0x560e9c562380 --
>     free=14, leaves=1
>     [0] fold node 2/15 [nx 0]
>     after: 3
>
> Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>
> Hi Andrew,
>
> As far as I can tell, lib/assoc_array.c has no maintainer, so I'm
> sending this bugfix to you. Hopefully David can take a look at this and
> verify sure it's all sane. I tested it on my userspace reproducer, and
> also by booting it and exercising the keyring_gc functions a bit.

Actually, by my searching, lib/assoc_array.c is only used by the
KEYS/KEYRINGS subsystem, which is co-maintained by David, who also wrote
the array. Maybe this file ought to be added to that subsystem in
MAINTAINERS?

Adding keyrings@vger.kernel.org to this thread.

Stephen

>
> Thanks,
> Stephen
>
>  lib/assoc_array.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/lib/assoc_array.c b/lib/assoc_array.c
> index 079c72e26493..7ed20233a770 100644
> --- a/lib/assoc_array.c
> +++ b/lib/assoc_array.c
> @@ -1462,6 +1462,7 @@ int assoc_array_gc(struct assoc_array *array,
>  	struct assoc_array_ptr *new_root, *new_parent, **new_ptr_pp;
>  	unsigned long nr_leaves_on_tree;
>  	int keylen, slot, nr_free, next_slot, i;
> +	bool retained;
>  
>  	pr_devel("-->%s()\n", __func__);
>  
> @@ -1536,6 +1537,7 @@ int assoc_array_gc(struct assoc_array *array,
>  		goto descend;
>  	}
>  
> +retry_compress:
>  	pr_devel("-- compress node %p --\n", new_n);
>  
>  	/* Count up the number of empty slots in this node and work out the
> @@ -1554,6 +1556,7 @@ int assoc_array_gc(struct assoc_array *array,
>  
>  	/* See what we can fold in */
>  	next_slot = 0;
> +	retained = 0;
>  	for (slot = 0; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
>  		struct assoc_array_shortcut *s;
>  		struct assoc_array_node *child;
> @@ -1602,9 +1605,14 @@ int assoc_array_gc(struct assoc_array *array,
>  			pr_devel("[%d] retain node %lu/%d [nx %d]\n",
>  				 slot, child->nr_leaves_on_branch, nr_free + 1,
>  				 next_slot);
> +			retained = true;
>  		}
>  	}
>  
> +	if (retained && new_n->nr_leaves_on_branch < ASSOC_ARRAY_FAN_OUT) {
> +		pr_devel("internal nodes remain despite neough space, retrying\n");
> +		goto retry_compress;
> +	}
>  	pr_devel("after: %lu\n", new_n->nr_leaves_on_branch);
>  
>  	nr_leaves_on_tree = new_n->nr_leaves_on_branch;
> -- 
> 2.30.2
