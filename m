Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AFE504EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbiDRKTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiDRKTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:19:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F5618E14
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:16:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23I7stqY024789;
        Mon, 18 Apr 2022 10:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2021-07-09;
 bh=TZuOvmsMQY5WZJLQYHUv/2oG4fAeAys7iIM5pVmIl2g=;
 b=zLinTAbEP8vLJkCNj1fAFio/j0372cj0SPyeqlEAXJsc++Nv6sJEhYTSNY0UsFjNhIWW
 lzGK++uinMawUdw6orlt3JHcycBEs6qa4PZL2yStRhbbwGCyh5bJjEic18k0HxMm6xzt
 jOKP/3/awU7h159NuHrXn/qcgBCEveBvruILc+HMLpbzbUHzekRklpi8AhzOC+Vgsu3w
 EF+HDrEOwjWPYdSEL1fstmUPq38sRrOqzND/DrY8gdhQyjYrAJfjKicKGdOMeafmuD//
 PELEHAi9xXGBQq5B0v+47sNJG/3th0UftEl+7LpmUFReKo7tYH+SyTQeAxNzEd9uR3ES ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffnp9awh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Apr 2022 10:16:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23IAGUlQ024495;
        Mon, 18 Apr 2022 10:16:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm874m4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Apr 2022 10:16:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnKERApMQQzyiui+7jZsQlYRYfq0R4Hs27rOEpj4xHB02Jv7pKCNx+xmSwe1ni8ljq21SIP3NPXTXCqXj5+CY9Rv6Y1iYga/kQ1RgTwLahCteRUUrJExeBomcA6uiCBt4tuEfkDVaPL+m1GUZl1K+aYVe6QP+/L6zJFKuPvVMle4+yCHlzBnLsEKuF+G+9SoOqDGI6TghYsofX2CKZ7enyApcT/VvkYgqQyD/T27IFXep536iuh3n4hWwWOXC3P8LnqNvLDusMNr4QzUIvZ6+cmPq4ZYAgrtWeZu1o0g8qmlvksVhI7c6kLQqvqyf66R2+ODj3v3KxyueDPz3BIgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZuOvmsMQY5WZJLQYHUv/2oG4fAeAys7iIM5pVmIl2g=;
 b=SXoCVPA3KWwE/jJxHjUslknoI7Wy/9O0RhsypfQHOe9UIPu+pTwfgk8kS+tcwFVRKMYoLR+R/H2QI/wUaDydZip4u2GyTXMBXLXmng2JKhNCnpCXG9osJ5KAyZYMtjtajKqQVdIOv63zPvv428U4N9mPQxu3E5SA5lhL+rSEwPWKDaKfZOTUXnXesev0lzVCNu/LCQpSgQHmQ1x/YVQH3sFquRlrHugQblk0axjdgEfgdlFDkOFzwPwCU2XG6InOn/wri7fYJcMXcPz2LsCuMwlvLvS25vjJW3fsSnh6IbjO2TpcuADqMCGumUWUfeJw3oYf2cCs9ssWUeLOYAR2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZuOvmsMQY5WZJLQYHUv/2oG4fAeAys7iIM5pVmIl2g=;
 b=xY7YwrARQoPTGjfmrh7n531GEJRKibjUuW8FqkyFRN/qYomWFEFAAw1CRFoBk1SVFOjBYjKoLuJLPjG+7oUI5ZV3cTPnL614uy81ND0IfqBeCrRXJCgc0etb7vs8vkDeUuucmKuJnVmnrur4VcboHYygxfskcaRIIv6rf1PxCww=
Received: from SA2PR10MB4587.namprd10.prod.outlook.com (2603:10b6:806:114::12)
 by BN8PR10MB3668.namprd10.prod.outlook.com (2603:10b6:408:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 10:16:36 +0000
Received: from SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::9874:fcc8:51fa:8fb5]) by SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::9874:fcc8:51fa:8fb5%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 10:16:36 +0000
References: <20220418090135.GA23098@xsang-OptiPlex-9020>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Subject: Re: [xfs]  530d96220d: xfstests.xfs.533.fail
In-reply-to: <20220418090135.GA23098@xsang-OptiPlex-9020>
Message-ID: <87o80ypugz.fsf@debian-BULLSEYE-live-builder-AMD64>
Date:   Mon, 18 Apr 2022 15:46:28 +0530
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To SA2PR10MB4587.namprd10.prod.outlook.com
 (2603:10b6:806:114::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a21f5fa6-eb7b-47bd-5044-08da212484d1
X-MS-TrafficTypeDiagnostic: BN8PR10MB3668:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB366855F2C3F6E154DEC09F29F6F39@BN8PR10MB3668.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWojNxZbNQA53bkqG3UGv+1+qnnK6WCXcDA6brg6D1z9JkFvpTu1T3GJu1N+zysI9Gzl5H5AdZeH1SUv3iCQvEFtEsdpw1WQkwgn5vmuT3vk5SCgEguQPsoh4Lv3Y2TMhaU/HnwoeRazvO2hMd5SJhvNlM9fnStIqa9C2MixpHpgekB50TJMEpz07K6g8gV0z52s3efMAEy8FaTNigkTeLb4w3nDLn6yxTLhYyqWIJUk/TV6SBCdmhKbKhex1qOP1JP+miXRae7eEXwchkVyn1TcVFYauX0r3tdluRTnu37p2Plu1lguAELlwAr7y6teXJRQBoGiK7pb0vXQ32Y4UuPUplPXJSXnsYhUbaWXd8MCg+D8nWqcv9PkpUZ7HccPQ/N4VXW4W0xYCOPdT6YhGkLUfknF5lzfH/rdIRhxnlUqzcwZXqR9tzTlGcgXUq30ZpH1ktVTVSIoBmDcf0IDqQHEfOI3vRksFwTJzOgsmB6j+x2bXK/19ZcdyCRUed8E4a4NHQxgwJu2jIapkqOxNokOt+8k3Td5uxlq4M0fETGWlEDevaPB7B/EFCgqmVNVVxrhSUMvI4TfLz8moqk0GHb700GXa0k05v0dKpUfTKXlpJ1dMIJGBn/MtixyGozwCogxO6H+5lbwx7Wxkw/rONllBd0/lMge+yhFekie0DgbiXWg43L3LTLxo1mmLegYfju1dMsvO7GI3R0+/1H0qQHO4qjmymv+Wkf50WlEiy4rj2fXNF5jW8Klk2eM/K8GUDsvDx+CgX4GmBqoRBwwbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4587.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(86362001)(6486002)(966005)(38100700002)(5660300002)(186003)(26005)(83380400001)(66556008)(66476007)(66946007)(8676002)(4326008)(52116002)(38350700002)(8936002)(508600001)(6916009)(54906003)(33716001)(316002)(53546011)(6506007)(2906002)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y2l0BCJs1xi9oDaTYfYGJQvojjOOJtT007dtkZC7Y3OZj3ofECubwxUGSlNv?=
 =?us-ascii?Q?X01LJZyotQff7wtR6pUY2Yvw4MxHLws7BsiejAbUt6BpQeFsU2J6eaYd3a64?=
 =?us-ascii?Q?vcqh0EWPwjEqAuG59tqIoZJATTN45aFB0wULRqOWUVFaF7aHl6uSGkKs4pQT?=
 =?us-ascii?Q?H6b1nNAkR7VV2YQ0zOtr5bESMBdZSz1gfFeFn8qVYECozeFqeDezHMWIxF/I?=
 =?us-ascii?Q?bUvEj1xafXMt7qC6pbeTyW1QgrkgW4QXOLdFM6jZ+IsDs8LRzKkGiUfkWoaF?=
 =?us-ascii?Q?bqUl4II5emRztATM7M1bTCrFL0GuK68ezgg+ipxOzS5UkvnQ32PyxjkGcmvn?=
 =?us-ascii?Q?EhP5V6GYXox6Z8m9LWsC4vs04+XQgMNKo88chcB5bvV/aem2gRHefNF4LOFY?=
 =?us-ascii?Q?+NbZRL62PZyXtlmTPbwfArxFlH+UO7fUVz/hJy5bqU943yVQCm6hXA20qPNa?=
 =?us-ascii?Q?ZMVPbeP++b2pjoO6yUU8OMdDdo5P0oKc6HZrF6sZVPpWDm+6krhxWMoRqiNz?=
 =?us-ascii?Q?VOlvaKuLlJkhJpKHxTkIVU/Iu4oBPgvkPDfC24ywA0k74iiB9erkJRKq4Ep+?=
 =?us-ascii?Q?T74maXBkiQLAQw8vAoiqsOvj6wTN+RwRzEKyJGnTMLgPWBh0u+4694mZDQ8q?=
 =?us-ascii?Q?YaQzXtY1yA7mYNmHabJJNcIGuy4mb9fVAkxShhYtmg0n17fgf943QLtKrDHx?=
 =?us-ascii?Q?bLUbPrMmWIJXwTCwBYMdrJSRp7Gj9o+VhFZ8ywLpWGdWJGOOBPjzVddd8f0b?=
 =?us-ascii?Q?mW84dlB8GhjOfxwpryn4U+nT922THFf8OnxTrVxnCcX9RDSsv9V0Rs1Yuson?=
 =?us-ascii?Q?af7FQjDsG/H4HDxLHqW/BzaqB5yNZX+MLgUSYqapluICeZlyWms6Jovk07Lm?=
 =?us-ascii?Q?R3GkXumZJM+OwIc5oaHQO6lilaTsoSCCAcOQSM6zTS0FhC/NvEecZ6mnHGFA?=
 =?us-ascii?Q?oHAynTyQbUszTG8JW8ApHq2hbOILQnaeTXHSrS4uFYYjxmM8RS/OYEotutst?=
 =?us-ascii?Q?sT3Y+9fvr6hIAy7NGPyKEy1pTwX9hNAoyagRcNBYKGojHjxXV1wgERnlNqT1?=
 =?us-ascii?Q?R3x+PM+QFzYaooEkpPv049xsmiyZIteu2RBlt+hnQkHtx70cRlLkwrvyNkMK?=
 =?us-ascii?Q?kxyZEwAEyT4+tCt4tEJ8+zWNYPqJMrh9yGX53dkyIMSJ5t9j3p/p/pMxZzF8?=
 =?us-ascii?Q?9tSxlKClQTitzg0K5O59PZ1sOor7DmV7/LUE95+r7zQy4SC05JuB1V0gwolr?=
 =?us-ascii?Q?/CKXvQWwQ44yWwDXU0TI5LCMu9H5q+2GqYKmEPUVU+B9Z4riqqStdvl/kUl6?=
 =?us-ascii?Q?ZP2Vr/DnldpJh/J01gpN4Ek4Q81ov6kEaMzJSP1WgTvw+n7hF0Qy9QwWUY6s?=
 =?us-ascii?Q?upvhrTnbkDviWZYXyfaF8Z5CmnxziJes3ZGe6pNBzEy/2NZ/6nV9xSzlP3DD?=
 =?us-ascii?Q?Vhi8ukqnkw95jsVTnyNz6/RJhnTmhiPDTyWCkjSheFI6a7LoCalNqHNH781Z?=
 =?us-ascii?Q?e/7NusqUOLS6T4+mjxA5l0TYBidoz4ihrpG8bTv3XN3Rd477VWz0Pv/2R6kU?=
 =?us-ascii?Q?3RqGGEpfMI9WILELAqzkI75S1xbZFHcXWD4ljrcpx0f7Z3TXgMf5BKYJB/nq?=
 =?us-ascii?Q?cT/NgD/VV4IXfUhKRqFs4GPdg1RmtknGfZk5pedo2xYaP6WcT19tubkgoZ4Z?=
 =?us-ascii?Q?UAdn0LzAWqwxp6iy5ohIdafL/E/zWxffzkeLbbMtS004Sh4Yoc7MN3dWZHg3?=
 =?us-ascii?Q?/AVoSvdb2UsxRIY8Ee6mRYvEM6E5n1c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21f5fa6-eb7b-47bd-5044-08da212484d1
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4587.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 10:16:36.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZCPrAEmfLWHVu3/FeZCJ0umOxZRrM+V6LP9OPYngjZsXgGGiRTRV2XW7aPAB7gV5cR3NvAOU+JXFYNdafxX+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3668
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-18_01:2022-04-15,2022-04-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204180063
X-Proofpoint-ORIG-GUID: 0y5Hg2ENuweIlcrrG_hc4PW5l-F7ZPUG
X-Proofpoint-GUID: 0y5Hg2ENuweIlcrrG_hc4PW5l-F7ZPUG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Apr 2022 at 14:31, kernel test robot wrote:
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: 530d96220d0d99cff9b5a3583210df2b5b5f6408 ("xfs: Directory's data fork extent counter can never overflow")
> url: https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220409-214913/Chandan-Babu-R/xfs-Extend-per-inode-extent-counters/20220406-174647
>
> in testcase: xfstests
> version: xfstests-x86_64-46e1b83-1_20220414
> with following parameters:
>
> 	disk: 4HDD
> 	fs: xfs
> 	test: xfs-group-53
> 	ucode: 0x21
>
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
>
> on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
> 2022-04-15 11:30:13 export TEST_DIR=/fs/sda1
> 2022-04-15 11:30:13 export TEST_DEV=/dev/sda1
> 2022-04-15 11:30:13 export FSTYP=xfs
> 2022-04-15 11:30:13 export SCRATCH_MNT=/fs/scratch
> 2022-04-15 11:30:13 mkdir /fs/scratch -p
> 2022-04-15 11:30:13 export SCRATCH_DEV=/dev/sda4
> 2022-04-15 11:30:13 export SCRATCH_LOGDEV=/dev/sda2
> 2022-04-15 11:30:13 export SCRATCH_XFS_LIST_METADATA_FIELDS=u3.sfdir3.hdr.parent.i4
> 2022-04-15 11:30:13 export SCRATCH_XFS_LIST_FUZZ_VERBS=random
> 2022-04-15 11:30:13 sed "s:^:xfs/:" //lkp/benchmarks/xfstests/tests/xfs-group-53
> 2022-04-15 11:30:13 ./check xfs/531 xfs/532 xfs/533 xfs/534 xfs/538 xfs/539
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 lkp-ivb-d05 5.17.0-rc6-00044-g530d96220d0d #1 SMP Fri Apr 15 17:47:01 CST 2022
> MKFS_OPTIONS  -- -f /dev/sda4
> MOUNT_OPTIONS -- /dev/sda4 /fs/scratch
>
> xfs/531	 4s
> xfs/532	 28s
> xfs/533	[failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/533.out.bad)
>     --- tests/xfs/533.out	2022-04-14 12:51:49.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//xfs/533.out.bad	2022-04-15 11:31:08.365436563 +0000
>     @@ -6,12 +6,4 @@
>      Inject bmap_alloc_minlen_extent error tag
>      * Create directory entries
>      Verify directory's extent count
>     -* Rename: Populate destination directory
>     -Populate $dstdir by moving new directory entries
>     -Verify $dstdir's extent count
>     -* Create multiple hard links to a single file
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/533.out /lkp/benchmarks/xfstests/results//xfs/533.out.bad'  to see the entire diff)

The "Large extent counter" patchset removes code which checked for directory
extent count overflow since an operation on a directory can never cause its
extent count to overflow. However, the following check is added to
xfs_dinode_verify() to check for ondisk corruption when reading an inode from
disk,

        if (S_ISDIR(mode) && nextents > mp->m_dir_geo->max_extents)
                return __this_address;

I have written a patch to remove xfs/533 from fstests. I will post it soon.

-- 
chandan
