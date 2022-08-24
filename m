Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F0E5A00E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbiHXR6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240070AbiHXR6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:58:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9184DB02
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:58:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHkceP007210;
        Wed, 24 Aug 2022 17:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=ebOe1ckKldwqcRiwhNBXvszAyeF7qEwCokrWjV0M84U=;
 b=lODKbhBDWz2jjSLfCB84Rda4AM/+KAe2fpGZ4AkI0uAa2iBvVm1x48PVPqZytF3XXPkQ
 2sY8H7mxClTMH+A1A1vFpNk/nc8fkXzZ0R5QT1B5rSQ9sBUZ5JdV18ISnMXAHM5ocmhQ
 1bPZJzSYhqoaBFsPYTPLI4gXAHmaBnfo5++KkEZYrzAR+2Su2pPW5jFH6yopv58UCZOX
 fr5H6QLVtc/o592N0yxamI9lBDHvhXCUqHcrHNJaMkRvI5DJ3j9Ux0Y8O9uBuaRZR5no
 2XeXDc/DTiDINW8w1iek7Kn8XtZchMdsdIB5h9Prcl+Lyz1ybk3cC6jmTY/XZTQmumPD WA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55nyapg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27OH6Es6011170;
        Wed, 24 Aug 2022 17:58:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6kuj35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vz63rZL6XDX2+c890sntsele6M+4aYtalwpnzgxoJBnj942vaAZucSqDd+aqk7RHx2qGA0WTas9djYVb75vGc61K5jGQ617hkQlwXPLls2+yXzPuiSEhvBx1cyh7kSN6qUYmlkKQqFOIRUMh7xJlubeCJStpYNAl4SwVP6q9Din37oUV6yHr2gh/v6oa1iVsGuqSo0ZrIjxuzVPB18nk6n2QZcuOLkUBvgS6Dwe6qMc4wKiDGwn5hBJPwCyQ4jb2tO7Is+TLo9x2lXHTNTFFn2C3nFUuHX87sEipLojl8fjX+kiccKNwjxIxayeguFSWpKx9bIWuy85H4JSHXJRPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebOe1ckKldwqcRiwhNBXvszAyeF7qEwCokrWjV0M84U=;
 b=LtTWprV4GELecErc8fwwLSKJRS8veXrSVPnikmCs5NuxmXP20v1El4JkXyjmB7W3tIVYPVFI2ZQYQdH8Ly2q+FkHHfl6MGKvPwNY29UNFwwpfOF8mNt5z+oUYnL0awjNjKUlI4XBFy896k3iWL2kAcWg41x97lAPbEjzEl7cNRZgOv9CDDozIkaPc6PVVgyhqYUqyxekaMHTxBIEaiKH6TA9vRzDw2wJShCRiDZ9N9MoGYcmQHnuZNzloUrP1U+loa84nebMqI7UqXuhUvbliyk0k4OiNVj6/+YBvKD6nxsMViotd4CNo5X/GvboeOoq91c5Uv1qg971Rt5XYj84Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebOe1ckKldwqcRiwhNBXvszAyeF7qEwCokrWjV0M84U=;
 b=V2wjywoFjxAxvYxf5v44ddmSUkAWbpt4u16EO+FGchoCKAXSCNpiMaU0t7x5v1diqvldJ10ho8SIpbpcCKc5O7W2ZZK9RwFs8iOwTOrhdU5GA7+1Y5WRtWxgEEDhcK8b9BooeGWVMdO2pbT5Mgm6zR+pAuAgOsyFi7QqcQBRm0Y=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH0PR10MB4520.namprd10.prod.outlook.com (2603:10b6:510:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 17:58:04 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec%6]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 17:58:04 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
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
Subject: [PATCH 0/8] hugetlb: Use new vma mutex for huge pmd sharing synchronization
Date:   Wed, 24 Aug 2022 10:57:49 -0700
Message-Id: <20220824175757.20590-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0379.namprd04.prod.outlook.com
 (2603:10b6:303:81::24) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51c6b848-2f28-4dfd-e9a4-08da85fa3137
X-MS-TrafficTypeDiagnostic: PH0PR10MB4520:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vH3yWtaHnxTOFwAdYlFteyqZUP2ZtrB+YQ+xh853ixqvKJir8ZTXBX6K0JRRqjPWyZNQDEbJPvMJzy7TeBSDprSwJVlJ2dIyRtr/iP14gPwv2Nj4/BFzeq8RRbL+BEekFo/GJy0FUCf3zVyWOm10VXmYP6DY4ZrSxM26XwvSPRLXOVau06M/G7TBhG159AITZ4Orhk45otWFpJHY3izfq6OkP1o2L/Mw65EC3BAImGPDTi2HSpnCanPtqVkZT447EagmNZeTnT8EVAE9YY7HHCpmGKG5oUzbvR7oqe1RrvpXdUo0DvWz31mamNZ6c/wwwOwCzy/hNaqpRwo5B5uDyvbplB2SXOUmk0jNG9x7TYC9QAInlRUFbSdaBqhDfi4HDQe0CgCjuJTMhYkTHnhkcR4vEnbUb72jDRAOjLILOvOnWloMTbXt6zLGADRmeoaf+c/xmNKZxUPyGlzah6Ra8n42N7N1SOphsTI/tDaTu0qZejVer7SIuGmBxQkpWI6PflkZKfbMbtpP2HuDliHn172dPlNRfxF91Iruq9aKF5xY3OwrxPbAS/veFIR73dLd0Pm481vU5YU9TK69Sbvb0DWftOK5ubuM3ucbtsyd61dFVX6/V70s7MOpA2OHcLVvrEny7SDolGH29bImEG3Lt/xhBS2YzpbvI7nlwFOabQXf4jWsGIX2jNrjWWQPRIILL7kRrS6N7q6tzZAGW3hUfxBm9wVVqR5WiQfejfo8QzDxGmPsTQkqePBDGb5uKWOGldjkqjTXwByh/rg/u/oBuaRw/NupCMqTRKGPcWfRtnrbWSOlEQDSAw2dCsQ36/Ni
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(376002)(346002)(366004)(7416002)(1076003)(6512007)(6666004)(8936002)(26005)(186003)(107886003)(2616005)(6506007)(44832011)(86362001)(36756003)(41300700001)(316002)(5660300002)(54906003)(478600001)(66556008)(8676002)(966005)(4326008)(6486002)(83380400001)(38100700002)(66946007)(2906002)(66476007)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I5AbqZuGRXkbl2/6GI20ZvR8wOIQmPxu1vyjNxgzvHpZYsFxLiC1FEImkynv?=
 =?us-ascii?Q?FGxIID69a45ke7AI0qCj2yprTLZo+6J0vG1OlUJdXPdUSerCp1OUJSPeiNkP?=
 =?us-ascii?Q?yax3VUm2zKG1kcXpp262Xf0u9vTNIH/v48UzHZt5tvkv2HBs+78PtrR8Z456?=
 =?us-ascii?Q?AOEocdS3AXSDwhaxEs3Qcel3E7gplgAZz0T7Qh3WTrfssMh0f5tHN7Q6y+Gj?=
 =?us-ascii?Q?J1BlauE6bm874WIiglXw5kIcALGLhFe25JfBEn4GIYpWlr3MshpoV49uE1wh?=
 =?us-ascii?Q?ea5qSFRAowqQkpyi1arkom0slF6sAYd+SpwbzhBbu7eBk6qS7UyCcAqmguo3?=
 =?us-ascii?Q?kvT8bb/i5M3219yGpTaqgBMklG1Wdt+9tLwifPKpnH+G28TJu5OJ5o+Boxou?=
 =?us-ascii?Q?f25qzzS4tJMzoz145ySsXZHIp0+2upNQLYvgDSdrW70uW50oBPWHKc3r95HG?=
 =?us-ascii?Q?1wfpjsP3auWc+AbAXY2HLjENH09JNI9nVuNzZ5OHmy93CULyazJcjvud9XGX?=
 =?us-ascii?Q?OapFdtEOo0Utl4wB1P/VwCbzcLLIw6i6sN303qGGxppRC7Qqi6dQdweEEU1L?=
 =?us-ascii?Q?eYyJK8WcxNhk7Eo7MN5MOJxZCs+wRnOQn/XDaX5y2uA/ICVq0uGHTVcDf80w?=
 =?us-ascii?Q?5G/sdNuKsqop5xmvjEhhxJTRL1tYMZNplfuEqK1C+8lfqeEalH3wr/6hnbDu?=
 =?us-ascii?Q?vB/R7Be50Uzpnxc9m8vjs4RZWoFDfwOqglRGCy0p07JnOrY01w0eXeP0xfcD?=
 =?us-ascii?Q?1QtPrXGZ+xhzLGBzcR1nSxLWfsJuh7aaBxDtboFSWC6DI39wn7cWiPaJwlLj?=
 =?us-ascii?Q?m3gtt8JLLhhujpn3kB1LYqBSa9IlPqVEh+BMzxlxmBzFnF85SHTEPswDTJWk?=
 =?us-ascii?Q?JExPtBa0aHNyn1tKuyQO/PstilVneAT0VeZypnCk5H91jj5sV+kOmQwBA4r8?=
 =?us-ascii?Q?yxVNaU1akO3WSzmYbOgPjJ3AbxZsm+3XOyihwPPaFeos3QXrxotZ7ljIhiAz?=
 =?us-ascii?Q?XZoPnmOF4qvZv8OTMoJ71G7PZruq4RiLSvQrfwUik8yB9cM4NrJkOCrpxfNn?=
 =?us-ascii?Q?Np6QPLVbv3E7C/hOzaYe7jlQV3goNkCkKvvDSmpsyOwOTq0JRCAQjriL6UXl?=
 =?us-ascii?Q?UbWjtsWvNtz92T6j0jsYNd6znYuImkI4PnnVIq/7JviY0Sm2LPCKER4C0xr+?=
 =?us-ascii?Q?DaIInBXsw9TrS2jJoDgLVZITftHBAxgQ2h+wR83cf0mFyso6Jitvo8JNwozd?=
 =?us-ascii?Q?nfMf6hzkytRvtZPax5YhaZLZoroOT89nUq9LcbOV9qhDIre1wJdYBBpYwI+X?=
 =?us-ascii?Q?LsnMLN5FEExy+MJKu+2Gbcd3QsA4DlBTRZ6w6YmzyHXXvbQw+wc4wW3hM/c4?=
 =?us-ascii?Q?55mlR92VwHBLEkFe3+LEET91bRkTJqNaUjy1ZinVs2kMcrPVy3zo/tk8dxgg?=
 =?us-ascii?Q?+f1OQl63GlwyIuBfdvqW48cOOVzyH7yet+erW8+FgMjXAniSDYYAyW3fRM/Y?=
 =?us-ascii?Q?qaJuwpJekQMlH3UFmoHijlnRLQRNODVsN/fWj5KKOCahzxs2ynGgFqjg0yey?=
 =?us-ascii?Q?Gsnzt7l0CICrRsktEYKHL+1rm2cApZPplSVirZKXpYQ7O61IQCy9OSjKmHcX?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c6b848-2f28-4dfd-e9a4-08da85fa3137
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 17:58:04.6349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hf4VS1eWrmH++rE2Izp8Vc8b4cUVu6wr9lfmbJYN8+suf1A3zDi2OdwTTmdRkqp91g1WDVW05GhTGHVHByzhEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240066
X-Proofpoint-ORIG-GUID: ZeTCyPz7ar9OIGux8F0tGftyMOFvk0aA
X-Proofpoint-GUID: ZeTCyPz7ar9OIGux8F0tGftyMOFvk0aA
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb fault scalability regressions have recently been reported [1].
This is not the first such report, as regressions were also noted when
commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization") was added [2] in v5.7.  At that time, a proposal to
address the regression was suggested [3] but went nowhere.

The regression and benefit of this patch series is not evident when
using the vm_scalability benchmark reported in [2] on a recent kernel.
Results from running,
"./usemem -n 48 --prealloc --prefault -O -U 3448054972"

			48 sample Avg
next-20220822		next-20220822			next-20220822
unmodified	revert i_mmap_sema locking	vma sema locking, this series
-----------------------------------------------------------------------------
494229 KB/s		495375 KB/s			495573 KB/s

The recent regression report [1] notes page fault and fork latency of
shared hugetlb mappings.  To measure this, I created two simple programs:
1) map a shared hugetlb area, write fault all pages, unmap area
   Do this in a continuous loop to measure faults per second
2) map a shared hugetlb area, write fault a few pages, fork and exit
   Do this in a continuous loop to measure forks per second
These programs were run on a 48 CPU VM with 320GB memory.  The shared
mapping size was 250GB.  For comparison, a single instance of the program
was run.  Then, multiple instances were run in parallel to introduce
lock contention.  Changing the locking scheme results in a significant
performance benefit.

test		instances	unmodified	revert		vma
--------------------------------------------------------------------------
faults per sec	1		397068		403411		394935
faults per sec  24		 68322		 83023		 82436
forks per sec   1		  2717		  2862		  2816
forks per sec   24		   404		   465		   499
Combined faults 24		  1528		 69090		 59544
Combined forks  24		   337		    66		   140

Combined test is when running both faulting program and forking program
simultaneously.

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
using the hugetlb fault mutexes for more coordination between the fault
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

RFC -> v1
- Addressed many issues pointed out by Miaohe Lin.  Thank you!  Most
  significant was not attempting to backout pages in fault code due to
  races with truncation (patch 4).
- Rebased and retested on next-20220822

Mike Kravetz (8):
  hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race
  hugetlbfs: revert use i_mmap_rwsem for more pmd sharing
    synchronization
  hugetlb: rename remove_huge_page to hugetlb_delete_from_page_cache
  hugetlb: handle truncate racing with page faults
  hugetlb: rename vma_shareable() and refactor code
  hugetlb: add vma based lock for pmd sharing
  hugetlb: create hugetlb_unmap_file_folio to unmap single file folio
  hugetlb: use new vma_lock for pmd sharing synchronization

 fs/hugetlbfs/inode.c    | 364 ++++++++++++++++++++++++++++++----------
 include/linux/hugetlb.h |  38 ++++-
 kernel/fork.c           |   6 +-
 mm/hugetlb.c            | 354 ++++++++++++++++++++++++++++----------
 mm/memory.c             |   2 +
 mm/rmap.c               | 114 ++++++++-----
 mm/userfaultfd.c        |  14 +-
 7 files changed, 653 insertions(+), 239 deletions(-)


base-commit: cc2986f4dc67df7e6209e0cd74145fffbd30d693
-- 
2.37.1

