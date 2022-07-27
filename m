Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0A583350
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbiG0TRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiG0TQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:16:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C3A6B25D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:06:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RIwkjN013082;
        Wed, 27 Jul 2022 19:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=HSWKonv2LWMmpoTKTjpT4r1mWngIMpFdcjhzjZqT4FE=;
 b=fEE4y+LWKWq857bYdrEdQbqVCvJZzcYwAJCZybnAZgpQO6G2KrKqEZGTuyPKlqPLAkIo
 0eC6M+UeYVFgKMXBz3CPRHp+8EgEdSIAIt5QoIfEt13w7mlny0zt78FNbgxRwF5oQV20
 rBcIir1kdgO2t9PZQDn7A5iRuxdbgMJASClJPpB2LXl6Geueo+y3mqkiqih3pMWVd1FD
 YqmbUpDS7C/EhJdjI9yEllAC3NrW7jXabrEY9y7QGky+HNFRD8K+grGwTESpx1LR/zFy
 XC7xFk3pu6RaxngeJid3WfwkpdDUnxEt2LrpYxjLSA++t10y1y4Ds6NMinJ7a36k/TFa BA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940tbe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 19:00:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RI7afR019965;
        Wed, 27 Jul 2022 19:00:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh639pyer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 19:00:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ul2K3ADKtRx/rP9JMmMn7lxkBO5Da+xxD31p8Bz4DDMshlJFU2FInexdWvpIuGsowmdkK7WLxuCtjy52Y/QbDcDIwlYCzmK1tt7Eg5CQm41cZF7IvnIemQ/jA0dnBw+E5jwzFDDo+nCBQqebVXLD0YfUMOeMhR3ZxdHK9Zct5DZIbOBbrjdjsmb9/Okcdo/5tyRHlu55be7g2/QN0bAoKX5BWRA3iCcD0jrxXfN1xrr7ANLX3PmRSLp0zDz+zXnQYBIJNn7P9SgJqMne5A1lq1aNklRfhlJaMUhUGxysKostJUQbDCJpyrnqpoDN1Y0a9PCMu+AeIwa/M2ZgtmbKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSWKonv2LWMmpoTKTjpT4r1mWngIMpFdcjhzjZqT4FE=;
 b=FrJm1bQOo8zBOOwYDOBoQr5kbEeWcOrI+SvxwdFyP8KJXqV1WxFMc+VqPstIs4KEp4869beAS1POq9uTQF7LNale0JxT0D7omcVnncl0Zm8AB6W3aw4Zw0/O5Hr9h+OwWY7NiOEOK2b6Tfir2Afb1mpyB8SvHIHhk//Xy1d9Miw8YN4ujepI13PQNlDKyMnOpwuM8e8g4aSW2mL6iHPiZaOfSXUiRxOMa38mYj6BlEGYvT6TqGPTV/pQgs3Oa72o/fmdDAaxR/A2/aDDKxbpZIPPaQOFdbIZz4BYmg2DEyFECZIKfEF4VQYPGXpFoZL2MZtOyDzwf3DvqiSaxCZSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSWKonv2LWMmpoTKTjpT4r1mWngIMpFdcjhzjZqT4FE=;
 b=v4ZwYWxubOsoNlUoX5O0GiwpKBs0cd+KtGvnhb/wZylAMASUe1m3W9ni5esfKtAWnrw2yAVMSB4TIqXdW3Dv5W2Hl/ENyf9mMhIGhvaZUClxQvO+EhcPrYXnjd92NOku9Lje5gBedji1W0tDS5ja4brbNz+7TU2i7WEax2eVxv4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4493.namprd10.prod.outlook.com (2603:10b6:a03:2dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Wed, 27 Jul
 2022 19:00:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 19:00:34 +0000
Date:   Wed, 27 Jul 2022 12:00:31 -0700
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
Subject: Re: [RFC PATCH v4 4/8] hugetlbfs: catch and handle truncate racing
 with page faults
Message-ID: <YuGLT+RlCynFM9Z4@monkey>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
 <20220706202347.95150-5-mike.kravetz@oracle.com>
 <ee6af38d-f797-a64f-e5c4-78bad3753aca@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee6af38d-f797-a64f-e5c4-78bad3753aca@huawei.com>
X-ClientProxiedBy: MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e481533-fbd1-4415-229f-08da700248e1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4493:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RiSQJO1/aP49peF9jSd5COWcCETRyKU69U9Hv5PnBEHQ4RV9UL2Pcy1CVkaw9mi0G3TD7ml/KflDOMu036fFMlxoS1gxLXTSAKBnJ/C0CP5azHTfqhHgh28JF86TRqdrdbHFZyvCrfpA7zdPgHxfBbN6qwp1LIlmulcTc1qjgllKT39IKHXm0qYTROMYFQNQLpugs+VBRnTp/Qakkpev4k6pQ233/ZEDxMBHwIpRv1FSz3GL6brgWeookGshsWc8xI+6BBb2P2fvY0G6cls8asyWFbD16nKcxnDFF/wyE2Ft4QUTtURc9O6uROB1xr2J9FZIRA6YA9VPqoKpIBpP/qG7iv90tGFdR+W8hO79G3xHuny9MRfjACIpD1fbc4ctUJbUmpKFpe4g/FScZ/7lOTkT+XJTyPeUYxpu3OfdT4f5VAWaa5lw2ULtJDtG81R68DvnqTuCExEIoohXiOfWMfKqn/7+JaV5Jw4WQ2BXLi7xuZvFBXR5zZ9bLa3PCkbGWB184kH9QlpaxFJevJQKyqak0O+RmJFf0n8LcaOIoorMTtT+k9pRDfOULnvEG3hWh4UaGeJ1ZKjbBLoeBcLM72cvGQ3WGZMERIRppsSJB/p/w1KkgMJCMAT3yDMifrULukeRZrEpdqK9BgyIkkFPcK/u/8ht5AqJZJBKy+Xj1BmSmlxFJlwUabNM3KlAXdilkjAPnPLNLlkMKpWhTOz9V8ZRCavj1cJgWnMMNebzzz0fGi5qUbPlYgpw4pwXugCb2Myi+KN3DJtgGDNUJ2lPY5ls2VcSodVzJoZEXQ00QmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(366004)(346002)(136003)(376002)(86362001)(33716001)(6506007)(186003)(6666004)(6512007)(26005)(41300700001)(9686003)(478600001)(316002)(53546011)(6486002)(83380400001)(44832011)(5660300002)(7416002)(66556008)(4326008)(66476007)(8936002)(8676002)(6916009)(54906003)(38100700002)(66946007)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/gFDnS4TY1T8d+chtkYPVw8uzbZkRQuWJ4s9UgRQzFwehrMhe++xTVYPTNIA?=
 =?us-ascii?Q?aRXKNbnUnDTG65feQKBbPcIP8L6LQZOkDuV35pmFaOuE4SV0m6yJheHd0Ro5?=
 =?us-ascii?Q?HuzmWpyCdw2TXj/oQpGMrDNpY1GVzqxeZTVVNaRqM3KfloxnhKvkXjmp0IoX?=
 =?us-ascii?Q?e3QIPKrjmKEfcScQ4fRE7Zo+nrHTwuM5Sc3AOvX+WXYNozQ76FlV+6+BqNHc?=
 =?us-ascii?Q?YkAj+S7Yu8EzRCdEJDpP5NMgAUfXc/R/o9kUeeQdSKBBy7DI+sCDtKzHdBVe?=
 =?us-ascii?Q?UG026ZN53Jks3/9GS15qvek9/RCCyrMYvpSr9JTLNDAZTmN405+2fDKdRRjs?=
 =?us-ascii?Q?dv9R+wv5Hu1inoiT8vfkRGMRPC8ZfwR8O2lWlpGhf3XqBn7zp2KtskLO7WnQ?=
 =?us-ascii?Q?iWMkp9ulUxjkaOgQdcVySVdQxJONSfhiLI2ZX5jfNMFdILSWU5aGCKElmRQg?=
 =?us-ascii?Q?CwRqvyu7E7/lI/6IlOt25T8D1ujtdGUj5qiJJwaf/IWE5ZIro9gzkLTKtom7?=
 =?us-ascii?Q?iVE8fbSL5ffwbPVAvUYz3tiwV2jIVkxeDE0h4CsRf67P2/wgEx/MLnxMOJqD?=
 =?us-ascii?Q?spIgznZzYnYFuQGRyWkGiIRKnm6f5CUebBkopw92XMJOwbby+eobj9DmuRd4?=
 =?us-ascii?Q?JmebzoQYgDoba4d+D/+kLK+OCIU2986k3sH9OH/QUC6KlX414zhVog5xrixR?=
 =?us-ascii?Q?KdKibPllacTiiBbWHjY0e2uFLOR1iismAZst1RA140bhEcf50aYfqiXRua6d?=
 =?us-ascii?Q?RFD5uPsItx+6wO66930793nMMwbbBYMva1UBhE9UTSt7cEIO3sMgnRzFngDI?=
 =?us-ascii?Q?Lb9eIMmCGPRizYNySGJx03BNPIxvNZUGZGGEayjHp0ndXqdwmWSykKKNPrf1?=
 =?us-ascii?Q?0eLArPLK71n7A3QcZaxczHjyEvtvSo+tFeUeoPG9e48CvVCxk1W3fdid+Tr/?=
 =?us-ascii?Q?h7TzSqPtwVbXfCWxuT9fA5+NgenqpyW+UBuDdw5WZaMZU5NiFoY4Cbq9V5Rx?=
 =?us-ascii?Q?NYOBgh7kB0Jlvd2RFYIa0ukQHR5EvifpBb+sZaD3iovE5sqwzuEJ8w/GWZPk?=
 =?us-ascii?Q?N3/crPuhavpN48OtY2cwQtXrTb0QGHkn0qEbcARL1TGZkq+cFG4sNuh8JeFm?=
 =?us-ascii?Q?mgndZsWLTjVX2YHks6woJt9fml+PEM3+S8PiYglnetiTOyWPzma7UCajF1SJ?=
 =?us-ascii?Q?f4Efj+rx548lKkUhl/np2vYZWRNMOvrSHvj+QnPNnopPTcZs1vfOrPJ3Wgfc?=
 =?us-ascii?Q?BEjYXdWjTEKr6VI/fXaASfvQnl3VkjXdkytdpbs0ylKROb2J9uL1xIusi6C4?=
 =?us-ascii?Q?I5n9xfbqoVI6p79lej97PqLsC7A96aof9DIDvruNd76Wj5bwxM59vpYYk50X?=
 =?us-ascii?Q?bhRZUHrQdzEFQYFPTST521TRCGVZk2QucxdkLWFklk+ywUFLxls5wToqWkji?=
 =?us-ascii?Q?1xlY+ilqk0k12g8fm/KwpInqCHDAWe66pa8zmyv/dkcKdOVntHXvEgjpRNeu?=
 =?us-ascii?Q?F1Ag51jVNPVw6ROxb+5dj2uwXqT0Mn/iIvtM5e8fQdds3R5xlB2QjpcmWNYf?=
 =?us-ascii?Q?VYy1QgZsxDwDwNpPsYwSV5pLlavoFbv0RDxiF1iH2wt3mTQh+RSxdbmAs+Z9?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e481533-fbd1-4415-229f-08da700248e1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 19:00:34.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EvuJzqVCPcbsYddgo0LMCjNe5ZLvEXGyPglZPBMuq8YNjUd4jLvXF3ENwIzacvVlTrax99RVooFjMPVGxiEOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270082
X-Proofpoint-GUID: Qlgd1BUG5YEq4NZYuj5BLhpER_QV9ioy
X-Proofpoint-ORIG-GUID: Qlgd1BUG5YEq4NZYuj5BLhpER_QV9ioy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/22 17:20, Miaohe Lin wrote:
> On 2022/7/7 4:23, Mike Kravetz wrote:
> > Most hugetlb fault handling code checks for faults beyond i_size.
> > While there are early checks in the code paths, the most difficult
> > to handle are those discovered after taking the page table lock.
> > At this point, we have possibly allocated a page and consumed
> > associated reservations and possibly added the page to the page cache.
> > 
> > When discovering a fault beyond i_size, be sure to:
> > - Remove the page from page cache, else it will sit there until the
> >   file is removed.
> > - Do not restore any reservation for the page consumed.  Otherwise
> >   there will be an outstanding reservation for an offset beyond the
> >   end of file.
> > 
> > The 'truncation' code in remove_inode_hugepages must deal with fault
> > code potentially removing a page/folio from the cache after the page was
> > returned by filemap_get_folios and before locking the page.  This can be
> > discovered by a change in folio_mapping() after taking folio lock.  In
> > addition, this code must deal with fault code potentially consuming
> > and returning reservations.  To synchronize this, remove_inode_hugepages
> > will now take the fault mutex for ALL indices in the hole or truncated
> > range.  In this way, it KNOWS fault code has finished with the page/index
> > OR fault code will see the updated file size.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> 
> <snip>
> 
> > @@ -5606,8 +5610,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >  
> >  	ptl = huge_pte_lock(h, mm, ptep);
> >  	size = i_size_read(mapping->host) >> huge_page_shift(h);
> > -	if (idx >= size)
> > +	if (idx >= size) {
> > +		beyond_i_size = true;
> 
> Thanks for your patch. There is one question:
> 
> Since races between hugetlb pagefault and truncate is guarded by hugetlb_fault_mutex,
> do we really need to check it again after taking the page table lock?
> 

Well, the fault mutex can only guard a single hugetlb page.  The fault mutex
is actually an array/table of mutexes hashed by mapping address and file index.
So, during truncation we take take the mutex for each page as they are
unmapped and removed.  So, the fault mutex only synchronizes operations
on one specific page.  The idea with this patch is to coordinate the fault
code and truncate code when operating on the same page.

In addition, changing the file size happens early in the truncate process
before taking any locks/mutexes.
-- 
Mike Kravetz
