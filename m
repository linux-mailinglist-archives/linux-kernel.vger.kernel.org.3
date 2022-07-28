Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05CB58453C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiG1RsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiG1RsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:48:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE77913D1B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:47:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SGxHWP028345;
        Thu, 28 Jul 2022 17:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=GJUgaY5/n0nMuB9nWNKD8NIjyDdehosu3qIsLjcDmM8=;
 b=meaMqCkvIiQ8iR/hUDIogY7Aykawcm0JfPz2pk4i0jKuEZW6+rANG3l8naKMPoGfNMA3
 y9uiR+GWhf4deA9E60lARr9OUqiK+9PWPSrCnS2dvGT4xh6/OVZ0nFTbBRBoS4p20cQW
 TuHD+klm6nt7vW1mmUAaAV7JXiojHZ/x5ER9QdY0hKo59uj8R8Dpoh3U7P0SGqA1R2m9
 pqd4KbgXWnnKY97XOrbC4yfM7WKhYoAC9DYTjq3+mT75UcwmV3Bv4XhismSFgCU+nsWp
 3e5skx6RyNVKpOkgSh1W22Q1qqAHCUJ4iH7eZNUtpehkEnsFmbrY1zkMUuVRgP99L3QI 1Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940vy9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 17:47:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SHAM2d029845;
        Thu, 28 Jul 2022 17:47:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hkt7c4ftd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 17:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh3sS3tDZks9XktR+xDEHFlt8PqJRDHsteJHOzAg5HN1RIgehQRpgevzTxMf8e/pNNAra3ETFPF+0RWjdCpmW44XkL8bormjsFUBHbjBoosNLjosRuolBZA5kFH9r71V4mkZchjps0OLIRzg+L0yK1r2LDsA2qsLoVx7DtV7g5mwZATCu3ydJlhcEQWxstFv129ARj7hLGWvDAu11VqtswS8rWPLrhPLeiC4/Y1nm/IjBKvwWiPABOamGzmlcC5swGIqaW24RP4KRcwojPeCBQKb4cYGOuzcICrOs6tlnv0N7LIQ3oP8I6Y0qc2ahLO65YnDzkYRYcux0OOg/OXmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJUgaY5/n0nMuB9nWNKD8NIjyDdehosu3qIsLjcDmM8=;
 b=c92ZC+6ymwxfKcZ5eP/8PU6g3PcYIHxjx7RyIkgM/X528VSRUZ+ZahZ9ip0AlQDfLVVJb/2YsL7QxIP4RwnlAPFloSPLjg4847XbdridRVq5XGHI0vpVB4eTCAhCwhK8W/M2ar5Uw2cMrIdI3CiLDvoIMN68ZEm2uNxE9q7kHbWk82Hb9ZcQ3Tb4SnCDs/pnSSS2gmc8+6cch8vAEIvMA5+qTzZF4WTHAB9+KhmWXWjlLqMLxxO9mUeuqcF80Wh23N0Jg7z0kpGaQfaLmnzmHQwuBdtdUYdEwB+ZW4NjUQHzz16q1CU03h31JBzHMRbQE1t6rVx3Qvks3duWQY4mgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJUgaY5/n0nMuB9nWNKD8NIjyDdehosu3qIsLjcDmM8=;
 b=i88xql10Z8UtYSWj1KS4vRhekW+cHY30nVRA5VupvQZpbMiP6CodGjjkKl+QNa+2SvbgkPnclEFTvljc83052Aoie6qCXUNXbzrJm5ZnFhoUBu179ieMBpWq/mQjYnW7yLN9ChHmtQR5CBPWtmO2V/Du0n7jZ07ypOcrxe2MmIk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5369.namprd10.prod.outlook.com (2603:10b6:610:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 17:47:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 17:47:25 +0000
Date:   Thu, 28 Jul 2022 10:47:21 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v4 8/8] hugetlb: use new vma_lock for pmd sharing
 synchronization
Message-ID: <YuLLqbq1aOwFPsdi@monkey>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
 <20220706202347.95150-9-mike.kravetz@oracle.com>
 <ddab06a9-ab81-5ebd-9273-c50744f6da60@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddab06a9-ab81-5ebd-9273-c50744f6da60@huawei.com>
X-ClientProxiedBy: MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d3b4f2c-68f2-4511-102b-08da70c13b26
X-MS-TrafficTypeDiagnostic: CH0PR10MB5369:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kApEcO463Hbm61z8B0KDvCQ1geX+xgdzfLd/LNK41Akar7Oyt3GHWJO2HrtN1RY7lCs2tzby7vLX/VQ8CToCuok6OuC8LqZK5WGszoPiC93nBApkRsKKaVg4C2arrsAZhJit86RAvpXlBWPQjokDmYS8XPfi0C3etcV5cXfz8M56eYIL+EnMdLXs8pM4epbVzFHg+U5dcZVRSTtsrv6Hjwm7MKmoQUe7Z8UGQe9hrepAID1xhO9q3rfXsDxQX5AOxBgTbydbaixXE55W60j7cXZpz9urVWNJvPoETmCz35hHaNr8ql9rtUQkPE1DydvXu0/+3QYNmkd+8htwHd2YBp418717kxkBaWLSDuxVv4/J4grdqjOEN5RU39VnMKJicgO/6PnxU6U+xHxJ1ui5VqB+Ow5Xi0d4yvkVu5wzQe1HDQfUG4tMytAGyVQmW1kwlDNRLeZ7jnhmz6F8dGBSQdhPjc7CdRm2rctVSkNLyfPWldp7FqxZDNFOY+M+AZD3WEsqxDkQARGq81owPrCGmNZigEAJqrnbLHJub13i6qheejavEfPkQr96B4ZJmj4x3P+uyUCt7Zu7fX08YBeJ81Xn1FNPn/Bnq/hCK2iWoLTMss16Qr5QKSypzueUhll/Gs+jeaXftUDIjZIi7+Dbs7IkNIl+xQzbDQrGhWC5VN9oFom958au8vPy9gLa0OBeJuZFu/IxJVaprvIB5/FISNaapP8e8RRsd/+Jqtn97A08Il4IQCFROYYew7a1F6ZZWPWX2/q2be7V2DHk/bqdWBijhHasEfrUI44gqIIIAy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(376002)(346002)(396003)(41300700001)(53546011)(38100700002)(66946007)(6512007)(26005)(2906002)(54906003)(66476007)(83380400001)(8676002)(33716001)(66556008)(86362001)(9686003)(4326008)(6916009)(186003)(478600001)(30864003)(8936002)(6486002)(6666004)(44832011)(7416002)(316002)(6506007)(5660300002)(87944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K8gOzuYGlDHjd1xub5CRqMl2gKHMkSX0YZPXQutSUEkzhOz4wjWTzuzifPH1?=
 =?us-ascii?Q?lrno17WdwySVABu+2aFD5j/q5CrgbLz5DA+bsiGNWulX4m7Wo/32oe1HRMFY?=
 =?us-ascii?Q?F6RU38RwvTN7mQlEKDtzrkDmUDHSsyfnbLnDnoiRIAf8cdhSeXBX5T+08g5G?=
 =?us-ascii?Q?9zg5WcwhbtgRFcIP69jRvbkro3j8boxDvus1C5G/TK5xBFWMcCBaouwK7St7?=
 =?us-ascii?Q?GItSYLDHm85ofp6LQUKaChvqKIaEP8HuKuUCQEHcgQDnG9EcwbH9LpwShgiM?=
 =?us-ascii?Q?Fd3zQwnb8o34H3NeZfrg8iOWeX1MmJ7CR5u8qvU5vPGZi5hY7xgSyglCU+bM?=
 =?us-ascii?Q?ppKm4ismtkbEtAfJZUNT1iXTg8baUGkbZTgmAzxXXc7HYKWwQXprInJL5l5V?=
 =?us-ascii?Q?E/UUtEgCrWx8wkph2+xBDCJnDJ4mWIQC0Yc5HBn+WfLvQ6uoBHZkG+T9vHnL?=
 =?us-ascii?Q?jtkc3npejLcQ5q59C+B/elXLGd/XcAlIoYkSagl9F+ImuUK0u+O0a+alvUjp?=
 =?us-ascii?Q?XoFtA6wJFKmf58/HJRhfMPDlC4tRZH77VmIA2m72CjA+Mfcnm0KIWWK3Z+06?=
 =?us-ascii?Q?tcAo1PJ9ShEucHG1+3dsaAZDBgpXCxzEZzhRpimy1ME61rkouqHKB/Cv+LRE?=
 =?us-ascii?Q?YUi45nRxwlVSWMRHsogTSqHsLQgjqubhqrbBP10mAAD+83X5fLFe1fgMDYi7?=
 =?us-ascii?Q?Yh9l726GoyJ6I6bzMve9iDotVnSUdJmxH6xQATUogke9ZNRoDr8K1Po+D7cN?=
 =?us-ascii?Q?BXB1SJLY/Ne1H5dM4BW4/vatP0qDJKMcGndSlliEztCCHgTr45WoHtneSbRa?=
 =?us-ascii?Q?h0T3iowRfttcHus28vxmdQfzivTWN0oUJSrByVyFLsynjLOtNaOX1bD1GCo2?=
 =?us-ascii?Q?Q6tpk/bk8hgrH/cUjoYEqdngvyNulS+z7/RMGUe6iEuvs34AqrBwWxz+v3Le?=
 =?us-ascii?Q?i5BBiE3PE1ZV6oqWvXKJhZXM6Bv6pq2r7Yi6XbgUf6XQIG9uXKs/SiyRPbGf?=
 =?us-ascii?Q?Kvfl7FQSkQLDZrQuENLLZWGZjCOzsxse0cTQCXaGeYQTq5ozD7iV8qminTGt?=
 =?us-ascii?Q?pEglziJsKvFbhzHHZ2xgVTDLRVwlM1WMJA3e/6/5QW0mp6z4fl2dsxIl6FzS?=
 =?us-ascii?Q?1wKCcoXkXMgWStluJhrrWZ5ApBeeLLwfIWIIUQmiRWzHgnGpPko6OVsJd4Te?=
 =?us-ascii?Q?8tVD2XD4fNurMhlGQ1KVpZpFFkUgfB47EV2vOzgp7PKyfsu7fAbuZ3RPps08?=
 =?us-ascii?Q?9a46rnCSSTBQSbelhISfveidFjpDhdCHDuyXjrmwZ/egSR4dVFoBvYkKmZ53?=
 =?us-ascii?Q?Ln/du2Eh4fqzgk67q8m1eKQJ0N/qE9RIYGxtZMR8fovjQhixVX1vStuJODWK?=
 =?us-ascii?Q?CrRejDnsOAfxjF7BZ5ndAHFLu9obwJVgrlel0MZbIw9ruZ/Y9p4Bnp9rY/k8?=
 =?us-ascii?Q?ux2cEOGChQeAdfPnb5RY8cQ09kSBXtnETLSgePar/jjs60FCDYUMzXh/aPto?=
 =?us-ascii?Q?Obhmfp8gMutGrfiuJG2ecV5PpOgiyAzLSSkGJzrrt9UMZ2Zh/h8AV1pqbA0K?=
 =?us-ascii?Q?7jfzzVwTDUq84XadKrJ0Ec5KamBR0Y+68fDyytdfuxgeEOx5FHFI4zPlG5ps?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3b4f2c-68f2-4511-102b-08da70c13b26
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 17:47:25.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1P3DdZI0hSzTDY9S2CN0m1pqNToRleF8UOw5zlziBCpSAlaxjGVe8WHkHwR7yK+avurvUUo+ZOQ3JpGCBYNew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280082
X-Proofpoint-GUID: HtB8_jdcY4-xSBrp9oIVlgijqoKbPub1
X-Proofpoint-ORIG-GUID: HtB8_jdcY4-xSBrp9oIVlgijqoKbPub1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28/22 14:51, Miaohe Lin wrote:
> On 2022/7/7 4:23, Mike Kravetz wrote:
> > The new hugetlb vma lock (rw semaphore) is used to address this race:
> > 
> > Faulting thread                                 Unsharing thread
> > ...                                                  ...
> > ptep = huge_pte_offset()
> >       or
> > ptep = huge_pte_alloc()
> > ...
> >                                                 i_mmap_lock_write
> >                                                 lock page table
> > ptep invalid   <------------------------        huge_pmd_unshare()
> > Could be in a previously                        unlock_page_table
> > sharing process or worse                        i_mmap_unlock_write
> > ...
> 
> Duplicated commit log here
> 

Oops, will delete.

> >                                                 i_mmap_lock_write
> >                                                 lock page table
> > ptep invalid   <------------------------        huge_pmd_unshare()
> > Could be in a previously                        unlock_page_table
> > sharing process or worse                        i_mmap_unlock_write
> > ...
> 
> vs here?
> 
> > ptl = huge_pte_lock(ptep)
> > get/update pte
> > set_pte_at(pte, ptep)
> > 
> > The vma_lock is used as follows:
> > - During fault processing. the lock is acquired in read mode before
> >   doing a page table lock and allocation (huge_pte_alloc).  The lock is
> >   held until code is finished with the page table entry (ptep).
> > - The lock must be held in write mode whenever huge_pmd_unshare is
> >   called.
> > 
> > Lock ordering issues come into play when unmapping a page from all
> > vmas mapping the page.  The i_mmap_rwsem must be held to search for the
> > vmas, and the vma lock must be held before calling unmap which will
> > call huge_pmd_unshare.  This is done today in:
> > - try_to_migrate_one and try_to_unmap_ for page migration and memory
> >   error handling.  In these routines we 'try' to obtain the vma lock and
> >   fail to unmap if unsuccessful.  Calling routines already deal with the
> >   failure of unmapping.
> > - hugetlb_vmdelete_list for truncation and hole punch.  This routine
> >   also tries to acquire the vma lock.  If it fails, it skips the
> >   unmapping.  However, we can not have file truncation or hole punch
> >   fail because of contention.  After hugetlb_vmdelete_list, truncation
> >   and hole punch call remove_inode_hugepages.  remove_inode_hugepages
> >   check for mapped pages and call hugetlb_unmap_file_page to unmap them.
> >   hugetlb_unmap_file_page is designed to drop locks and reacquire in the
> >   correct order to guarantee unmap success.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  fs/hugetlbfs/inode.c | 45 ++++++++++++++++++++
> >  mm/hugetlb.c         | 76 ++++++++++++++++++++++++++++++----
> >  mm/memory.c          |  2 +
> >  mm/rmap.c            | 99 ++++++++++++++++++++++++++++----------------
> >  mm/userfaultfd.c     |  9 +++-
> >  5 files changed, 186 insertions(+), 45 deletions(-)
> > 
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index 0eac0ea2a245..be0a5073766f 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -459,6 +459,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >  					struct folio *folio, pgoff_t index)
> >  {
> >  	struct rb_root_cached *root = &mapping->i_mmap;
> > +	unsigned long skipped_vm_start;
> > +	struct mm_struct *skipped_mm;
> >  	struct page *page = &folio->page;
> >  	struct vm_area_struct *vma;
> >  	unsigned long v_start;
> > @@ -469,6 +471,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >  	end = ((index + 1) * pages_per_huge_page(h));
> >  
> >  	i_mmap_lock_write(mapping);
> > +retry:
> > +	skipped_mm = NULL;
> >  
> >  	vma_interval_tree_foreach(vma, root, start, end - 1) {
> >  		v_start = vma_offset_start(vma, start);
> > @@ -477,11 +481,48 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >  		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
> >  			continue;
> >  
> > +		if (!hugetlb_vma_trylock_write(vma)) {
> > +			/*
> > +			 * If we can not get vma lock, we need to drop
> > +			 * immap_sema and take locks in order.
> > +			 */
> > +			skipped_vm_start = vma->vm_start;
> > +			skipped_mm = vma->vm_mm;
> > +			/* grab mm-struct as we will be dropping i_mmap_sema */
> > +			mmgrab(skipped_mm);
> > +			break;
> > +		}
> > +
> >  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> >  				NULL, ZAP_FLAG_DROP_MARKER);
> > +		hugetlb_vma_unlock_write(vma);
> >  	}
> >  
> >  	i_mmap_unlock_write(mapping);
> > +
> > +	if (skipped_mm) {
> > +		mmap_read_lock(skipped_mm);
> > +		mmdrop(skipped_mm);
> 
> Do we need to check &mm->mm_users == 0 here in case the address_space of corresponding process
> has exited? In this case, mmdrop will drop the last reference and free the skipped_mm. So we will
> use skipped_mm below after it's freed?
> 

Good point!
I think we need to wait to drop since we want to hold the read lock.
Will update.

> > +		vma = find_vma(skipped_mm, skipped_vm_start);
> > +		if (!vma || vma->vm_file->f_mapping != mapping ||
> 
> If skipped_vm_start is unmapped and remapped as a anon vma before we taking the mmap_read_lock,
> vma->vm_file will be NULL?
> 

IIUC, vma->vm_file will always be set even for an anon vma.  The fault
code depends on this.  See beginning of hugetlb_fault() where we
unconditionally do:

mapping = vma->vm_file->f_mapping;

> > +					vma->vm_start != skipped_vm_start ||
> > +					!is_vm_hugetlb_page(vma)) {
> > +			mmap_read_unlock(skipped_mm);
> > +			goto retry;
> > +		}
> > +
> > +		hugetlb_vma_lock_write(vma);
> > +		i_mmap_lock_write(mapping);
> > +		mmap_read_unlock(skipped_mm);
> > +
> > +		v_start = vma_offset_start(vma, start);
> > +		v_end = vma_offset_end(vma, end);
> > +		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> > +				NULL, ZAP_FLAG_DROP_MARKER);
> > +		hugetlb_vma_unlock_write(vma);
> > +
> > +		goto retry;
> > +	}
> >  }
> >  
> >  static void
> > @@ -499,11 +540,15 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
> >  		unsigned long v_start;
> >  		unsigned long v_end;
> >  
> > +		if (!hugetlb_vma_trylock_write(vma))
> > +			continue;
> > +
> >  		v_start = vma_offset_start(vma, start);
> >  		v_end = vma_offset_end(vma, end);
> >  
> >  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> >  				     NULL, zap_flags);
> > +		hugetlb_vma_unlock_write(vma);
> >  	}
> >  }
> >  
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 2eca89bb08ab..8369db31df13 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4848,6 +4848,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >  		mmu_notifier_invalidate_range_start(&range);
> >  		mmap_assert_write_locked(src);
> >  		raw_write_seqcount_begin(&src->write_protect_seq);
> > +	} else {
> > +		/*
> > +		 * For shared mappings the vma lock must be held before
> > +		 * calling huge_pte_offset in the src vma. Otherwise, the
> > +		 * returned ptep could go away if part of a shared pmd and
> > +		 * another thread calls huge_pmd_unshare.
> > +		 */
> > +		hugetlb_vma_lock_read(src_vma);
> >  	}
> >  
> >  	last_addr_mask = hugetlb_mask_last_page(h);
> > @@ -4999,6 +5007,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >  	if (cow) {
> >  		raw_write_seqcount_end(&src->write_protect_seq);
> >  		mmu_notifier_invalidate_range_end(&range);
> > +	} else {
> > +		hugetlb_vma_unlock_read(src_vma);
> >  	}
> >  
> >  	return ret;
> > @@ -5057,6 +5067,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
> >  	mmu_notifier_invalidate_range_start(&range);
> >  	last_addr_mask = hugetlb_mask_last_page(h);
> >  	/* Prevent race with file truncation */
> > +	hugetlb_vma_lock_write(vma);
> >  	i_mmap_lock_write(mapping);
> >  	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
> >  		src_pte = huge_pte_offset(mm, old_addr, sz);
> > @@ -5088,6 +5099,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
> >  		flush_tlb_range(vma, old_end - len, old_end);
> >  	mmu_notifier_invalidate_range_end(&range);
> >  	i_mmap_unlock_write(mapping);
> > +	hugetlb_vma_unlock_write(vma);
> >  
> >  	return len + old_addr - old_end;
> >  }
> > @@ -5392,9 +5404,30 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
> >  		 * may get SIGKILLed if it later faults.
> >  		 */
> >  		if (outside_reserve) {
> > +			struct address_space *mapping = vma->vm_file->f_mapping;
> > +			pgoff_t idx;
> > +			u32 hash;
> > +
> >  			put_page(old_page);
> >  			BUG_ON(huge_pte_none(pte));
> > +			/*
> > +			 * Drop hugetlb_fault_mutex and vma_lock before
> > +			 * unmapping.  unmapping needs to hold vma_lock
> > +			 * in write mode.  Dropping vma_lock in read mode
> > +			 * here is OK as COW mappings do not interact with
> > +			 * PMD sharing.
> > +			 *
> > +			 * Reacquire both after unmap operation.
> > +			 */
> > +			idx = vma_hugecache_offset(h, vma, haddr);
> > +			hash = hugetlb_fault_mutex_hash(mapping, idx);
> > +			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +			hugetlb_vma_unlock_read(vma);
> > +
> >  			unmap_ref_private(mm, vma, old_page, haddr);
> > +
> > +			hugetlb_vma_lock_read(vma);
> > +			mutex_lock(&hugetlb_fault_mutex_table[hash]);
> 
> We should respect the below lock order here?
> 
> hugetlb_fault_mutex
>  * hugetlbfs PageHuge() take locks in this order:
>  *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
>      ^^^^
>  *     vma_lock (hugetlb specific lock for pmd_sharing)
>        ^^^^
>  *       mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
>  *         page->flags PG_locked (lock_page)
> 

Yes, taking in the wrong order here is a mistake.  Will fix.
Thanks!

> >  			spin_lock(ptl);
> >  			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
> >  			if (likely(ptep &&
> > @@ -5563,14 +5596,16 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
> >  	};
> >  
> >  	/*
> > -	 * hugetlb_fault_mutex and i_mmap_rwsem must be
> > +	 * vma_lock and hugetlb_fault_mutex must be
> >  	 * dropped before handling userfault.  Reacquire
> >  	 * after handling fault to make calling code simpler.
> >  	 */
> > +	hugetlb_vma_unlock_read(vma);
> >  	hash = hugetlb_fault_mutex_hash(mapping, idx);
> >  	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> >  	ret = handle_userfault(&vmf, reason);
> >  	mutex_lock(&hugetlb_fault_mutex_table[hash]);
> > +	hugetlb_vma_lock_read(vma);
> >  
> >  	return ret;
> >  }
> > @@ -5821,6 +5856,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >  
> >  	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
> >  	if (ptep) {
> > +		/*
> > +		 * Since we hold no locks, ptep could be stale.  That is
> > +		 * OK as we are only making decisions based on content and
> > +		 * not actually modifying content here.
> > +		 */
> >  		entry = huge_ptep_get(ptep);
> >  		if (unlikely(is_hugetlb_entry_migration(entry))) {
> >  			migration_entry_wait_huge(vma, ptep);
> > @@ -5828,23 +5868,35 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >  		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
> >  			return VM_FAULT_HWPOISON_LARGE |
> >  				VM_FAULT_SET_HINDEX(hstate_index(h));
> > -	} else {
> > -		ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
> > -		if (!ptep)
> > -			return VM_FAULT_OOM;
> >  	}
> >  
> > -	mapping = vma->vm_file->f_mapping;
> > -	idx = vma_hugecache_offset(h, vma, haddr);
> > -
> >  	/*
> >  	 * Serialize hugepage allocation and instantiation, so that we don't
> >  	 * get spurious allocation failures if two CPUs race to instantiate
> >  	 * the same page in the page cache.
> >  	 */
> > +	mapping = vma->vm_file->f_mapping;
> > +	idx = vma_hugecache_offset(h, vma, haddr);
> >  	hash = hugetlb_fault_mutex_hash(mapping, idx);
> >  	mutex_lock(&hugetlb_fault_mutex_table[hash]);
> >  
> > +	/*
> > +	 * Acquire vma lock before calling huge_pte_alloc and hold
> > +	 * until finished with ptep.  This prevents huge_pmd_unshare from
> > +	 * being called elsewhere and making the ptep no longer valid.
> > +	 *
> > +	 * ptep could have already be assigned via huge_pte_offset.  That
> > +	 * is OK, as huge_pte_alloc will return the same value unless
> > +	 * something has changed.
> > +	 */
> > +	hugetlb_vma_lock_read(vma);
> > +	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
> > +	if (!ptep) {
> > +		hugetlb_vma_unlock_read(vma);
> > +		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +		return VM_FAULT_OOM;
> > +	}
> > +
> >  	entry = huge_ptep_get(ptep);
> >  	/* PTE markers should be handled the same way as none pte */
> >  	if (huge_pte_none_mostly(entry)) {
> > @@ -5908,6 +5960,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >  			unlock_page(pagecache_page);
> >  			put_page(pagecache_page);
> >  		}
> > +		hugetlb_vma_unlock_read(vma);
> >  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> >  		return handle_userfault(&vmf, VM_UFFD_WP);
> >  	}
> > @@ -5951,6 +6004,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >  		put_page(pagecache_page);
> >  	}
> >  out_mutex:
> > +	hugetlb_vma_unlock_read(vma);
> >  	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> >  	/*
> >  	 * Generally it's safe to hold refcount during waiting page lock. But
> > @@ -6413,8 +6467,9 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
> >  	flush_cache_range(vma, range.start, range.end);
> >  
> >  	mmu_notifier_invalidate_range_start(&range);
> > -	last_addr_mask = hugetlb_mask_last_page(h);
> > +	hugetlb_vma_lock_write(vma);
> >  	i_mmap_lock_write(vma->vm_file->f_mapping);
> > +	last_addr_mask = hugetlb_mask_last_page(h);
> >  	for (; address < end; address += psize) {
> >  		spinlock_t *ptl;
> >  		ptep = huge_pte_offset(mm, address, psize);
> > @@ -6513,6 +6568,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
> >  	 * See Documentation/mm/mmu_notifier.rst
> >  	 */
> >  	i_mmap_unlock_write(vma->vm_file->f_mapping);
> > +	hugetlb_vma_assert_locked(vma);
> 
> s/hugetlb_vma_assert_locked/hugetlb_vma_unlock_write/ ?
> 

Thanks!
Not sure how my testing did not have issues with that mistake.  Will fix.

> >  	mmu_notifier_invalidate_range_end(&range);
> >  
> >  	return pages << h->order;
> > @@ -6890,6 +6946,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> >  	pud_t *pud = pud_offset(p4d, addr);
> >  
> >  	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
> > +	hugetlb_vma_assert_locked(vma);
> >  	BUG_ON(page_count(virt_to_page(ptep)) == 0);
> >  	if (page_count(virt_to_page(ptep)) == 1)
> >  		return 0;
> > @@ -7271,6 +7328,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
> >  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
> >  				start, end);
> >  	mmu_notifier_invalidate_range_start(&range);
> > +	hugetlb_vma_lock_write(vma);
> 
> hugetlb_vma_unlock_write is missed in hugetlb_unshare_all_pmds?
> 

Thanks again!

> >  	i_mmap_lock_write(vma->vm_file->f_mapping);
> >  	for (address = start; address < end; address += PUD_SIZE) {
> >  		ptep = huge_pte_offset(mm, address, sz);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 8917bea2f0bc..3131766f9c7d 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1693,10 +1693,12 @@ static void unmap_single_vma(struct mmu_gather *tlb,
> >  			if (vma->vm_file) {
> >  				zap_flags_t zap_flags = details ?
> >  				    details->zap_flags : 0;
> > +				hugetlb_vma_lock_write(vma);
> >  				i_mmap_lock_write(vma->vm_file->f_mapping);
> >  				__unmap_hugepage_range_final(tlb, vma, start, end,
> >  							     NULL, zap_flags);
> >  				i_mmap_unlock_write(vma->vm_file->f_mapping);
> > +				hugetlb_vma_unlock_write(vma);
> >  			}
> >  		} else
> >  			unmap_page_range(tlb, vma, start, end, details);
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 64076c2a49c1..e1c19d86cea6 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1557,24 +1557,38 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
> >  			 * To call huge_pmd_unshare, i_mmap_rwsem must be
> >  			 * held in write mode.  Caller needs to explicitly
> >  			 * do this outside rmap routines.
> > +			 *
> > +			 * We also must hold hugetlb vma_lock in write mode.
> > +			 * Lock order dictates acquiring vma_lock BEFORE
> > +			 * i_mmap_rwsem.  We can only try lock here and fail
> > +			 * if unsuccessful.
> >  			 */
> > -			VM_BUG_ON(!anon && !(flags & TTU_RMAP_LOCKED));
> > -			if (!anon && huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
> > -				flush_tlb_range(vma, range.start, range.end);
> > -				mmu_notifier_invalidate_range(mm, range.start,
> > -							      range.end);
> > -
> > -				/*
> > -				 * The ref count of the PMD page was dropped
> > -				 * which is part of the way map counting
> > -				 * is done for shared PMDs.  Return 'true'
> > -				 * here.  When there is no other sharing,
> > -				 * huge_pmd_unshare returns false and we will
> > -				 * unmap the actual page and drop map count
> > -				 * to zero.
> > -				 */
> > -				page_vma_mapped_walk_done(&pvmw);
> > -				break;
> > +			if (!anon) {
> > +				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> > +				if (!hugetlb_vma_trylock_write(vma)) {
> > +					page_vma_mapped_walk_done(&pvmw);
> > +					ret = false;
> 
> We should break here?

Yes, at least I did not make the same mistake in try_to_migrate_one() :)

Thank you very much for looking that these proposed changes!
-- 
Mike Kravetz
