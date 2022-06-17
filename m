Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D554EEF3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379600AbiFQBqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378914AbiFQBqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:46:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4201D337;
        Thu, 16 Jun 2022 18:46:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25H0M5Ro032718;
        Fri, 17 Jun 2022 01:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=KnjdxRnD3KSNz4VWUJGhLyl3yHatIubBcByjdVr0d2c=;
 b=YBfRsks6HIwsQWbjJPCQgO0AZt8PSnIc9t96U+RSYN2QFEs29Li+pY+FOXuF2RU1qsw4
 VQwdKB1pAsRe46dGLV0W1+xDyVuAJS9iKC4Cm7LE5IM3PRGUvT3vn7/D4ZuVx3DZFBok
 2N0Ux1jKkfqTWx3PZ59MnbSOPBjT7k8bg3tRppvNnefYMIF2fjb4lmQoPFtN5PfqOdhh
 RIhFsxeQo/5rrVSZVb6rYyvZdOy5UO+xsQrbSHldJLCROvwnUW1QMxGN6Ml/vRgv4Z7s
 Ma2UvxxK5OkF2YLz6GVfWkHA6luJyoUdpfDmdpUDVk0BSf1QnzaUXlJ9YcsxzMjdkcG+ Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2vtxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 01:46:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25H1UHuI020948;
        Fri, 17 Jun 2022 01:46:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq31d18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 01:46:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbUEaZ3CaVf52YJDdhSpXVPnvpXgA/QZFMdtr+hUUm7Rux4TNQ9uK3GMtCzQBTQnwfcHqOC/FHEVmY3OyDR46ugFBntcQ1xzCYeWK1pnCkZA668f0wr8+K4TzLDGsW43mi9HN0qhVpedhMxlC1LFxV6WnwWC5CB61WpGJGTcmCZ/Ne5XLi+Ru9HKKqojGh+gwhsCQ3vRh5o+iwpU7fmDn5XBt06FiKYtGQr+tCoGT8EPTNqPa+Q8LI4vwAghNqflcwKAAUSYjnJTLMVegY6TCVxLXI0zxi5nNPjFAaqdTOdXcBlyMwmgSY07rmqN3TXEP9455pxEVSRYwkL3atIvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnjdxRnD3KSNz4VWUJGhLyl3yHatIubBcByjdVr0d2c=;
 b=FibnDUHe4NofZs26cFxJKng4Cj2AZ5OZ7QSDOmftvqltAwKFxie+wyG7hHSpDP1y61b+C9SGbEHjcP7ehdTk++QkaUxAQ2lKmQToWk3Vs5JOTIxMRGRjAh7dZpVAkkbRS9QpoAoBpnsJKN4Qjv5//ulHIddwJhHWjoyr5lryd41B4rLb2qccGOyxnYCF2j2sSdOcpa0zSjnUdqAEnmxs+aCuLKVjYKs/EVo8dUdosWkV+WXMNsUbiomSKIvOLjPuhGuTOGXSmjC9aAqFIM9eAwFK9GjLVIj/sL9fsj9uSR/N6t0ic9fNP13acK1+9oFWCzTDR3WFdQwjZdbommr1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnjdxRnD3KSNz4VWUJGhLyl3yHatIubBcByjdVr0d2c=;
 b=d0waNAmQBv5a8ccszyvnNITNRR6F/ozw/TO8jjoCEgZuUmN++FUg5FR1qS64k/1E9pe3SrG0kjSa0EezjxH60pRrMSwDWy1v1du6DHqPhxNBeiJT3Yzg/vSwLPXmLprp4t1GB+fe2b0ZRGxpK3GXB3x79eB7ls/rsQCLvpjThcg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN4PR10MB5621.namprd10.prod.outlook.com (2603:10b6:806:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 17 Jun
 2022 01:46:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5353.015; Fri, 17 Jun 2022
 01:46:00 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>,
        <damien.lemoal@opensource.wdc.com>, <Ajish.Koshy@microchip.com>
Subject: Re: [PATCH 0/4] pm8001 driver improvements
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edzooyep.fsf@ca-mkp.ca.oracle.com>
References: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
Date:   Thu, 16 Jun 2022 21:45:58 -0400
In-Reply-To: <1654879602-33497-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Sat, 11 Jun 2022 00:46:38 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:32b::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cab0594b-d88b-494e-4e2d-08da50032152
X-MS-TrafficTypeDiagnostic: SN4PR10MB5621:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB562136A7760049B77780BF008EAF9@SN4PR10MB5621.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: edgQlxuyjrB3S4NnnjFYESY3B4ZAAyOaxallqZLUoQGjK5+4X9pPXQ4051I/womFY1Z4rsJccqYSyOz0fu/gzA3fjGIgW2Dhqj9lra/pe855xCtjaMEgGs7m3GPLrf3YCc6LYaVOT/qVz+d9EzbDLW8fo6BDfQ0ixJEoG4uQtAOd0Ao5zoS3UNGUjYFUCycDUohGlEacYoK7T+VTcVKrNTBYKE5kXPgrRshhIqWq+gvfaZuV0QMNjf6oGaH66RaegDGreLM27lx3PThQQ8sAmrhDugjDVJ9opLPBqQ1JOzOoDc91THzt6+ZBBjv9+4bU/ZGhFwDSVe8av/Gxalwp0TDs/gdXGlCoMUXuOvcfdEfvc40GkkLvlPqW2VPgIbxoPxXwLxdTNeP1iYGZKfqHaOvrHhNAdR917a+kcgICcr3WSQQZ3jZCbPsfTeKbsEbSofAHlHRuVtPCbw1iHIqnoXTuhgk7vtjRkD8doQojwBdLPJZfK1+5Mg/+YMSerLepzS/9r9NqfuXEwcZX8eK7t3rtTsy3iiGzznR7lGQsSmqwA/9Ufh4TcCy76WbDasz8NYXhIuGwy1eTdHyrBebZLWu8gAAj7qe6O9UPWCMDckRWw6mMW4ZTOVGls+jQaX5eLpGSaBqhmm+a3vO14cOJeMaMrFtU6zqwP384SpozggxsFSgR5fHVyR+x/dLawDUW0hKaNIQ0dcqjZ7Bh9V7FNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66556008)(6916009)(2906002)(508600001)(36916002)(4744005)(6512007)(38100700002)(5660300002)(26005)(66946007)(8936002)(52116002)(38350700002)(6486002)(66476007)(6506007)(4326008)(316002)(54906003)(8676002)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zsDv/0U5zWbNXQZnoKArE1y7SholQiffZN2NqVMayVtiETHTHt1Wf2bMC9ZA?=
 =?us-ascii?Q?zEa0Ew3DeRLNqwc2eCrauPHhP7YzNV72seAWNv8eTbKMXFubh5rYOtXTVz4q?=
 =?us-ascii?Q?O5d72x18uOjqEtbokKmwm0fXLK1yjgI/2IL9uTXY9vd/KQRYrjtDi0dUdMI5?=
 =?us-ascii?Q?cyBnRo3OwPKB/TEi/VfpVUUsWOYGqOMzoQ5/1P+e2bw6wPCw+P6gU8OjX3Mt?=
 =?us-ascii?Q?t/OKJChrBcVSRNFW9HzE2zHBDC/DY4L9+3P2JT2v7C85THaGhjHEJVAegqk+?=
 =?us-ascii?Q?hyIS6K4iixqKzJcjy6Kj5L7wLHlAaWrySnXS7UHSn8jm5fWJ+mowCI5L/dBK?=
 =?us-ascii?Q?1eIYxruj+2ra+XraDcgPNj5Xnyil6pFmyBWkZH/o19BrG7cMFIDXDBW9tqxA?=
 =?us-ascii?Q?WH7uOjF+eXJR1WUIPBsk8cGdh9F9m0r/vW06/EEUrjjVs/IYx/gnnWth/nSo?=
 =?us-ascii?Q?qMVN4w7NBEzJacZUX1ntFRNUJDWtjspTVQLlvZl525IfSYfEkV+mmTSomRG1?=
 =?us-ascii?Q?d0kB/KdFODpXYcvHnFWbxr55d7K+wr0Pmq3ZuXbR3qAK4S7oBuzQsJsHNJMy?=
 =?us-ascii?Q?4V9KR1ykUGsf7Z9TdBFzJXc4tam3iu0Eo4Xlgc23op90SuLnCxr1CeIQFnoG?=
 =?us-ascii?Q?PiYEG6Di6napUm9YugT7EjkFP6DLDea0DQNCpNNU6bxlGqkbqCzYRvYNC+T3?=
 =?us-ascii?Q?CX35H8qICdJ+ZeZrTSc2597JDsj5Jvzz85NnA/MHA9ThfKjz1nlq1ZMO60LS?=
 =?us-ascii?Q?2+ieeYo5GKqYCAk2iGq89jf/8HtuVTL6VYoj/pdRP8j3qdkAyNGjQyItht5W?=
 =?us-ascii?Q?NPDd0eLPKE3QXtZzL4w4FsLyF2xI3KJVPoUV0aU9VRWsD1aNVaZ2h1X/EQbV?=
 =?us-ascii?Q?kk2yvmg8/0G4JMtNCJ8LjC6TxsQPlZ/dI0D7IjrU+hTPwb+4kGwvWEOhP3+7?=
 =?us-ascii?Q?69aZ9bj9EoAnNKdmbvnmnuHEnnsGCWZpiOa5X/mRuWYdOYeJxDvfXBSvXwYS?=
 =?us-ascii?Q?iEer2BFmiBL+nqpE+RN77ohIVKO5ZOGKy2cSIjVeZZo1erXlOysgT6XJS7ic?=
 =?us-ascii?Q?36yXb0y1cev1PI5lAK4gEVUebevCZWkxLocYvRe1KCiBKCGNiWF94mIIIGE+?=
 =?us-ascii?Q?i09kB3MDJ9FSWMiCJaAYq9Tk1rrGnsfV4ADqo4OZqKTUylmKxGLwj3cDf8gS?=
 =?us-ascii?Q?Xyy7tcDsYm6x9aYk+ulvW/6EJbBfUTPKvy5KiuNMoFXYwX+DI1bfbS/4uukF?=
 =?us-ascii?Q?HPdCOwr8f0gmDKTVaUI21EJdmuvwJnSQM1w2Og1OZnhedy6YUSa03FPFuuor?=
 =?us-ascii?Q?YLqlPDZYQak8ab3it69Qb6ckkbuWq0QrZd4h/6Eti4px6rKhVUvNCg1n5/7S?=
 =?us-ascii?Q?GGrY5QVHmDcFj8bu++1YHv4naTpZqv7xya/yjZcJPHi84eBqEhX9251ruAAe?=
 =?us-ascii?Q?rajawGBX9LvT7lDi6kjSTaw7UphDstLek1W/zmsvQ9ZB+PhCSVFGM7o6s6AG?=
 =?us-ascii?Q?TNqJJh4aqL20YRhZaOnNRYRImMd092/I4zr8BlrkB6kNoga0Q1xgzcvJ++eF?=
 =?us-ascii?Q?MlyZficQj8pe5Bn5yuJdOUMuSb8Ss/JPYIyY/T01e4ENF8PRybAUncmwRfwM?=
 =?us-ascii?Q?Paydf/OU2c9+P8ThjT3VA86QlqmSlkyHU6YAmkxmQI9Z5s+KcXiiQD5r5pYT?=
 =?us-ascii?Q?Ccg7XVKebmzkUYzKl1a3uRBi5hBIqVXmZCmpvXJr9SSbTlgJzAg8nFawfqR2?=
 =?us-ascii?Q?qmwnObNiklbOMnLHWqDkzw2wxo0pbGg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab0594b-d88b-494e-4e2d-08da50032152
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 01:46:00.3168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nG1h/PrjoGDinzMVAalMN/iytpEGLUd+ialr/JxE2AcHdtLF+fekEh+Vampryvad/tIa2yxaW6hOaK20psA2yxfePYsQwlfXFP7EwjtF3S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5621
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_18:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=626
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206170005
X-Proofpoint-GUID: KEiEpYhHJXFvtm6jaSi0W9yXL-q4lzC2
X-Proofpoint-ORIG-GUID: KEiEpYhHJXFvtm6jaSi0W9yXL-q4lzC2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This small series includes the following:
> - Rework how some shost values are set
> - Fix a longstanding bug that the driver attempts to use tags before they
>   are configured
> - Stop using {set, clear}_bit()
> - Expose HW queues

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
