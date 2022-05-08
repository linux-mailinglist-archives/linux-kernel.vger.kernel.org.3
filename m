Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689A551EF73
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241547AbiEHTJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377113AbiEHSio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:38:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCAABCBF
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:34:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2489Tw3p027467;
        Sun, 8 May 2022 18:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=EjgH3CEKlVELRDCi6HcYrUZ3aKJK6dc9OpDBam1FyYk=;
 b=0pgvb5b0GmO+7mWj/HipS3RG0bPdlLovtlr3jk8WaJXsdg27PmNhpW82bm/yjkwzqKPG
 /axpsNoiMR5swZ8d3Kn4XQBMpjJLpzqQ6Fb5UVzspYV7BLm9lIZzDSwtSddPfhRp/7hA
 o6vHBtezNKy6lPvmKqFbWJ5Inl7s78/yzC16Zt1ey/lL7HGzWF+01qsBiKxrc5MP/UGd
 Voi6e9rjV9X0d+nrT+zrZfY6IdsbJAckMBLJCPP0Abk/lwEQ4YZPiA91UaLqkk26ozXn
 iCilEq/torUhsPK1Je7rJEIFSWKReXIEElTJPsAEW2j0cFU3o/YC09jQc0w8h9N+n/Qf xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj29vst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 248IU6gm005205;
        Sun, 8 May 2022 18:34:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf70vjjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFRpvBjTqdfFjNaopBLQil/HVQJyGzvXePbhCv4ovgQoJV19GhBSljGpt0PqTZRH6BxLljirbL1drfa0QfnvzHbT1QauFd28DLqnqXJDzzlHYzjAJPA2Z79NqTX+TiYTc/Jlq6aJIGXNA1YrS2FPQiodvcb+2C4fzK64sSD+D+7PuVcwxqumnIo5VRM4/ZNvZLSWQJJtg7YmdqkCSKfpOiQoKF5vhNzbCYrKWI0YA5T+nbolHOGMhQnyg2DTPfAy4X0dXlwV77+2QKMF0wCEv8uW2jQbRVstPjaCNDO8xugnSGqd3loQiQq8kHqrJHmWKEdVowOacMixo53MFTM2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjgH3CEKlVELRDCi6HcYrUZ3aKJK6dc9OpDBam1FyYk=;
 b=ZyuID/t+mVDX58qXAZYqXcXS/TDbsFrYhgwKvZ5zQ+21BjmQkt/SnsPtkPOBW3xuwhvg5UgyEjxaWF7wMwqWWizjcMACF5VJHGGyNUuyTJBAnhQWgKPWOmaQfux4Y8JwxZDCUc9451MPk9fmtxVU1l6L5/A3biA+C9VrQtVENByFA4s93p/BFToqKjWMGYMMzcNA6kwpoXd8VPsvunLOMSs+3hMF1/3qdTaBmViGMepQXvng90EknA3didbENMVDcGHZ4qUUEvpdmPGwzt7KB3nLzrMKlcvKvUQsI5TTo6pSg6zoJKaLn5ws2wENf+DJCcQuOPb5Yq/6vGuwJWENTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjgH3CEKlVELRDCi6HcYrUZ3aKJK6dc9OpDBam1FyYk=;
 b=js1QF0FZdW1Tw/3xUNxvp+PREbaDz+V7/J8dn7OnOnKWJSTXzXejhmJBzoZ2GQVcaQoXmpEx4NNL288rZmVP5TN7IXdB7OwVMD0D1ZIni+xfdyIXExtbc0lq7+h5QDWaNIFjrV46pYNB/vt8YAvgcFSD+wsd7XqMEEUNBX3zH7Q=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1485.namprd10.prod.outlook.com (2603:10b6:300:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sun, 8 May
 2022 18:34:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%9]) with mapi id 15.20.5227.023; Sun, 8 May 2022
 18:34:30 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH v3 0/8] hugetlb: Change huge pmd sharing synchronization again
Date:   Sun,  8 May 2022 11:34:12 -0700
Message-Id: <20220508183420.18488-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac1073f-70f7-472f-af86-08da312163ce
X-MS-TrafficTypeDiagnostic: MWHPR10MB1485:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB14851BA74E89DC8C5A303E2EE2C79@MWHPR10MB1485.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mI0npTlqNQh1EcZAEu3ui/sPGlx3Mx8ncf65SMIHP44GUtAeyaTHNhnNAHCPN4d8vPCQjLw09nQvHiO9kisUFIo1RiuW7kjr9UaiVZ4zsOCe0+yg8UwC2demo21eGUSDrr1/zhmhFojrMDPa+kIV4m/6jzLqNNtb5vrATGRtv9ll9qirb+RmrVRNoqHA/2VcmKXM7LnSi3mb5nn0/TGWJoQSF9liwgXiPL+atfsgegdRrEOJh2xqjyNG7rIKUARhR+ZURkEVOQA6Vh74uEPuQhrqe6j1fTAxG3+4EwQRixDKRYt4F+61B1kEYxV0iRJDy+C8dBo71jrAD2qOsVmwNPJpwG83v1CxmlGs1BP4sQoNtIoI0qtd7ftDxmDYVVvr2JCmF64f2rnqmWCbOrGgALy83Dh14TspQJ7jEIK40PORVg2EKpJAmgJTCXELsUotY4Ai9zFI7bFumoEfx3Vp0U974+Qahyc7B6RaPXw+SJmEnpEItZHKMw+AVwr1n5rgmotfhflsRMiUVAghBFP2RxP5uKWxLKh05qVSKQOq7ba6Vsy9gbC00JeYMi8/m9NjAq560YTwufkTuC2F4Lu3N+rNesVxd/pdTKar+pqPKnoei2eKg1aWc4m27dONrLT+C0v1CQ0i9rSseFLbe6sxkTy4t29l+qYmcD7+LqjXGBfctLFYlJtwTl3arsj9/pm8TLBV/hBP8OG8zO26Ronu2YDkS+eDwucC6rDJHQ8W1s2LJGtawYZWef9SMjdeh1meYdhsKVPaCcoP5J7wB21rcIrbWH4fnieu3q5bUrb/ckXJX+ZlKxlK+3f13sSqs3WKOPk7BX5grBCCfNyy78DEWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(2616005)(86362001)(5660300002)(4326008)(6506007)(7416002)(52116002)(6666004)(6512007)(26005)(8676002)(8936002)(36756003)(107886003)(186003)(2906002)(44832011)(83380400001)(1076003)(508600001)(6486002)(966005)(316002)(38350700002)(54906003)(38100700002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UU/2x8dmw6fPRw2DzofYllLZoFzTYhioe1W6o+MayeRQ48Qr1v0n3MOxsm/X?=
 =?us-ascii?Q?3aLKSv232NBZ/4O7seaKnnJoCiPYQaKOcJxySh+D8qUVp+7pidWDzNtxHPmX?=
 =?us-ascii?Q?/z5fhbe/u3+aM24SC5NCUvxZ95nbLbBYMNdqxLdRt4NfgqBnCsBgqLJQqi7t?=
 =?us-ascii?Q?ojuMTD9p2zG/rlPvioDcfMwUr8/fXjtXbRp1MFEBqkQbT8QgEbLwNIAl8ork?=
 =?us-ascii?Q?i3FQEVdFMw05L9u84r7ezsJUeiAK0aVs5arbYK2wwZeGjLsVUmtFhXBq7hKT?=
 =?us-ascii?Q?ldvcyU8dI7gLtGCE5WVC9PWjUFJ649ksa9bo8rE679M/PBGGtWtzPI/u551m?=
 =?us-ascii?Q?xrRXc4bx4GrH/dzPGF0NxF+4j3AioVyUbl7Gf7ZV48wTWrlpOFi6KQr1PJne?=
 =?us-ascii?Q?Cd6kHPjvGl/9x9FEf8fSGTp6mp1e7GrjKnNjbDct0bVHWZyn9u8LDKHAIdVl?=
 =?us-ascii?Q?ilikD/v+AGiQRf4CHg7DtW5N7V5kcwfm7xubP3Wz5PTZoxzQsPAZ58jJyL5I?=
 =?us-ascii?Q?q/yTyezYF0/3SvRXzUTYy8/1T4L67SNo+zCl7jFYM05/8DYxCY+EWQG9Gwo+?=
 =?us-ascii?Q?LxuPrc+BfrmyJe43F1mSxXKYJMI4FiziewhLqYBYhq4YtHjP1xhijUmUsXeQ?=
 =?us-ascii?Q?i1uG0CwzULoyGKcpmACQeQdg3rJrvdGDQ12/AFndzzzOVhmlqnOA5OtY3BG6?=
 =?us-ascii?Q?3fthcKET0s4iHt/rM73eFhqF2wvZqPDt4kzW2eRgKL1bRAQjExCA6tx6uKlq?=
 =?us-ascii?Q?tG84HbTkyzPkCVzw6Up6N7G0Viff0es7Z6czYZmkAAxVkqOn7sT2pwsK7E0z?=
 =?us-ascii?Q?3yz3ujZJMkSqpjCDJ/3lBf/Ty5IzA5UHgJlNh5nYYXq2jvyRekZmsWobnA5P?=
 =?us-ascii?Q?tDve2x2z8f7hOeyBfz7rqD18i5IAl3Lmy2LoVuzVLe3q4v7a4j5JQK2PzoX1?=
 =?us-ascii?Q?ienssa+PZtk/vNLsGKSBxUpHEso/zGY418209a4BRwZ6UDcvop7WceHGGU8N?=
 =?us-ascii?Q?uNatONezp4sUqaHuvmNEhFJJjQsFdF6HnnD9AGwoHa2pTR+EDxV+CygI6Z6P?=
 =?us-ascii?Q?uoBy8jJAikLe/yHxZCadO00gqexOmqJRPlozBVx5fvhNeOpsdbmyLEjz8j2k?=
 =?us-ascii?Q?E0XhFGmr91md9jIFeBePqaN3oOUE/V7vTfZkk8oNj8t9qbSQiEnFG/QxwsT2?=
 =?us-ascii?Q?Mxc5U68gMjws2FRx1SFL8IafDtfK4cDN0lSCmIKwcSS5fLNs63sq33fWFmRq?=
 =?us-ascii?Q?r7d0VWlMx3v4S9nPFHaLGSyHaXyzLwKIJgdBWsug+i7GTUv6lIstUucMWAzR?=
 =?us-ascii?Q?lRMkFyAJNlPp6S6L6ydg2U9c7pe1hFUwAICbdZJ3sChoe8L10ZYL0ufsk18G?=
 =?us-ascii?Q?ry+8LyQtzh7lzrcQUscuoc+RRmICIM15ZS+Ncuirnjt3Z1m/F/fhl9pM//KV?=
 =?us-ascii?Q?gLz62D/kyHkRP/lvmsFMjNQsLF62QfTTgCUgW7eMBwpXnTS+6yuUhcJhjNoD?=
 =?us-ascii?Q?UB+voosAe7LQYGD7P9cKDM05ZiOOebbin80K8Dyz7xbfFnML9DQbbf5TMgbM?=
 =?us-ascii?Q?a/UTu1G6U1OKwL99fKGZMj2jKidJpDOI6I6lHVqKYgCcw8IHeQbKb5GxsvDO?=
 =?us-ascii?Q?kTS3gUh8QA45F/9ZPM9Ge3FOeGqORaugKiSvbAXztPWU/nywvmSTy3ry1e32?=
 =?us-ascii?Q?Nz+SIY+ra225sImvCtg6HnQmZ5qpjoNlC9WZqr+bNXf0mPuh16Cv0XNMee4U?=
 =?us-ascii?Q?y0Yw6SrzEWIpvlOEyXyxvTJHbQdQdv4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac1073f-70f7-472f-af86-08da312163ce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 18:34:30.7017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXu1uaZjUuJ5xDnNAWRYJGit+oBaShZgnbu/RcmSQSXNjM5viJNxfsqrNxpYTagppwF+rHC42DkRiqEdrkbujw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-08_07:2022-05-05,2022-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205080121
X-Proofpoint-ORIG-GUID: YPeZncT-t1ZpfJIYHMRxP-HGKu0DrV6X
X-Proofpoint-GUID: YPeZncT-t1ZpfJIYHMRxP-HGKu0DrV6X
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am sending this as a RFC again in the hope of getting some agreement
on the way to move forward.  This series uses a new hugetlb specific
per-vma rw semaphore to synchronize pmd sharing.  Code is based on
linux-next next-20220506.

hugetlb fault scalability regressions have recently been reported [1].
This is not the first such report, as regressions were also noted when
commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization") was added [2] in v5.7.  At that time, a proposal to
address the regression was suggested [3] but went nowhere.

To illustrate the regression, I created a simple program that does the
following in an infinite loop:
- mmap a 250GB hugetlb file (size insures pmd sharing)
- fault in all pages
- unmap the hugetlb file

The hugetlb fault code was then instrumented to collect number of times
the mutex was locked and wait time.  Samples are from 10 second
intervals on a 48 CPU VM with 320GB memory.  48 instances of the
map/fault/unmap program are running.

next-20220506
-------------
Wait_debug: intvl faults sec  1183577
            intvl num faults  11835773
10 sec      intvl num waits   28129
intvl       intvl wait time   233225 msecs

2 hour      max_flt_wait_time 2,010,000 usecs
run         avg faults sec    1,161,818

next-20220506 + this series
---------------------------
Wait_debug: intvl faults sec  1409520
            intvl num faults  14095201
10 sec      intvl num waits   14078
intvl       intvl wait time   18144 msecs

2 hour      max flt wait time 115,000 usecs
run         avg faults sec    1,476,668

Patches 1 and 2 of this series revert c0d0381ade79 and 87bf91d39bb5 which
depends on c0d0381ade79.  Acquisition of i_mmap_rwsem is still required in
the fault path to establish pmd sharing, so this is moved back to
huge_pmd_share.  With c0d0381ade79 reverted, this race is exposed:

Faulting thread                                 Unsharing thread
...                                                  ...
ptep = huge_pte_offset()
      or
ptep = huge_pte_alloc()
...
                                                i_mmap_lock_write
                                                lock page table
ptep invalid   <------------------------        huge_pmd_unshare()
Could be in a previously                        unlock_page_table
sharing process or worse                        i_mmap_unlock_write
...
ptl = huge_pte_lock(ptep)
get/update pte
set_pte_at(pte, ptep)

Reverting 87bf91d39bb5 exposes races in page fault/file truncation.
Patches 3 and 4 of this series address those races.  This requires
using the hugetlb fault muteses for more coordination between the fault
code and file page removal.

Patches 5 - 7 add infrastructure for a new vma based rw semaphore that
will be used for pmd sharing synchronization.  The idea is that this
semaphore will be held in read mode for the duration of fault processing,
and held in write mode for unmap operations which may call huge_pmd_unshare.
Acquiring i_mmap_rwsem is also still required to synchronize huge pmd
sharing.  However it is only required in the fault path when setting up
sharing, and will be acquired in huge_pmd_share().

Patch 8 makes use of this new vma lock.  Unfortunately, the fault code
and truncate/hole punch code would naturally take locks in the opposite
order which could lead to deadlock.  Since the performance of page faults
is more important, the truncation/hole punch code is modified to back
out and take locks in the correct order if necessary.

[1] https://lore.kernel.org/linux-mm/43faf292-245b-5db5-cce9-369d8fb6bd21@infradead.org/
[2] https://lore.kernel.org/lkml/20200622005551.GK5535@shao2-debian/
[3] https://lore.kernel.org/linux-mm/20200706202615.32111-1-mike.kravetz@oracle.com/

Mike Kravetz (8):
  hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race
  hugetlbfs: revert use i_mmap_rwsem for more pmd sharing
    synchronization
  hugetlbfs: move routine remove_huge_page to hugetlb.c
  hugetlbfs: catch and handle truncate racing with page faults
  hugetlb: rename vma_shareable() and refactor code
  hugetlb: add vma based lock for pmd sharing synchronization
  hugetlb: create hugetlb_unmap_file_page to unmap single file page
  hugetlb: use new vma_lock for pmd sharing synchronization

 fs/hugetlbfs/inode.c    | 297 +++++++++++++++++++++++++++-----------
 include/linux/hugetlb.h |  37 ++++-
 kernel/fork.c           |   6 +-
 mm/hugetlb.c            | 310 ++++++++++++++++++++++++++++++----------
 mm/memory.c             |   2 +
 mm/rmap.c               |  38 ++++-
 mm/userfaultfd.c        |  14 +-
 7 files changed, 525 insertions(+), 179 deletions(-)

-- 
2.35.3

