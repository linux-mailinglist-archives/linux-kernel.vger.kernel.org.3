Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048185AF346
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiIFSGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIFSGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:06:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9117F09B;
        Tue,  6 Sep 2022 11:06:13 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Hs3Eb030609;
        Tue, 6 Sep 2022 18:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=dLBsl4U3gkjdRtm+MVoOVFCqbCEFo17WMDC+P7hRR0U=;
 b=OWkPu0lYb+cP1BY0PKpsnhAS63VgOG5K+b+HFj3l3XZzWEvzM+NfLU0+DNtdkogoFZ2f
 0Kb8FrxK2i1CTnJAYeAtAVGTkdZYolJrpJe6JuyNY6QDie74s2DHkAszsz6DBX/tQJcc
 Qbic80XZ6UtB0zxFBpd6prTuVnB91tjnSxJr+uuMLFnZBwML2M5wRHA2orsnFMnhaLXJ
 20Qnpgv9147Cj7QkwRNMY4BPNba5L4ZqRRpTEcdoUjj3vIvPjSDhR527zeHJS2QBCNZB
 oS4Iup2gNcupTMxLG0VUKOxE9mgme64xPQ1NNU9YmE5Zwie4+0PWzsHpOtGUGm5+X6VR Bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbc6k97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 18:05:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Gi7jD023652;
        Tue, 6 Sep 2022 18:05:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9g8nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 18:05:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgkMLYvJDfRhmPaN6382jufkoq8pNLoSCB99kOUGg9uiTIzjQchAU89ANZ2tQu6e6lAPHF2Ukjf3PQbwLxChirInLHDX06cZ7+0rH5JeGesGzMwsomzAZd6PkIDEhs8jT5Zf9acx8gp84OUeOjSGxe8cJOZk2J8nV0rxbTVuju0toIxHzwAtMhv0yZTgqSP1sANpLEH5ljIXhTNHU+UCIoLFZw7GnXlIC0/HKlBT157qKZOvOI4+VQdRsCiIx3Dtn9ynu7DlYkEey6SGsOy68ZwjEp8xKOtx7DBoS2P9UmAJEqbfGlL/RYhysPyOQqRge7Plho6cpo8enEPIt6D25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLBsl4U3gkjdRtm+MVoOVFCqbCEFo17WMDC+P7hRR0U=;
 b=X2xJG8hfuEpu0nBTrOnIAm07q6hHNhdR9uGeXQATv1k+RymSlggiULyA2pGnaJo1wcxAzcunG4dNDt/kw3dWJYDf9uWM3GbbrqYjwtWgunmS02AFeAy1ebmYb0I+usL3X6XPKy0J853/31ylkv0zVjjx7O2QFpMpRXowdlhVlla82HG2YWL241VK5KFE7zXZ7CI5fOVK2dOdslBHxT54z4m9Cj6UAn8Ml7Q3CLPJS+R3iDIioj2Ja+3X3nf6i4i9qgPbQZDVLiiJWUGbyzkORHVrjFHbWqSmwcS7bMB/JAps3uGOaO0t346+Cey5bm2Xa0ZjU0umrToJRp1Q+mQOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLBsl4U3gkjdRtm+MVoOVFCqbCEFo17WMDC+P7hRR0U=;
 b=MEAnjRs8VPi14QmE3c6kox0hiQWUyeQ6j/oni0g9Lsv+xZR/kTrt6HGVKfP5yQrKIMykVCLy5RXH0Np00DC4l8RajP6ab3ARd5owybixPPOyeMas9Sgul4BiwHd/7FuHDHxZM+02HOn5dw7IU++7xBwnR1rSt3IQSXpUVfAW8ZU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB6380.namprd10.prod.outlook.com (2603:10b6:510:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 18:05:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 18:05:37 +0000
Date:   Tue, 6 Sep 2022 11:05:33 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
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
        linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 4/8] hugetlb: handle truncate racing with page faults
Message-ID: <YxeL7ZMoyNmPAvY0@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-5-mike.kravetz@oracle.com>
 <yt9dr10ok3lm.fsf@linux.ibm.com>
 <Yxd5z0c8NlKVlVqk@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxd5z0c8NlKVlVqk@monkey>
X-ClientProxiedBy: MW2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:907:1::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5839f58-8758-4e81-ab13-08da903266dd
X-MS-TrafficTypeDiagnostic: PH7PR10MB6380:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTLfPRtLP8g9k/zln5HfcU/g2QwtiSWhvV/hY2TKCeu2Dris8rISuzDetC/dwxAMwWv2cw63fM8uXeLv3Wiwj6uPiUMOQPHgbCbwL2+j7+iXt6QxufC/blRC/7axKTTMgy7NfCZTmmvOeWKx43enlyicnuw5h7bSOmAWQywE+SXJ1S2SElM4Lb83Y7fUPkLRcEFmzWupD7r02ir8+c3gZKCf078s7XgESagq4rpSbc33oZPPFLnftZr8V35GyhQUyN0sY3k+n1B7ywiQUlEtw+ftskIubOPZF5RHPG8HQ9Qc0iVJO2CfTufUEWcmAMXgyESgpvFS5F70VNa6jBzn1Q7Tiy2PwEHxKtYyeq7D5oI91lz3TMUTgNYC2UAGcfhdZpIF0p30iaeFQc7S7OADXCwVrc4fhFWUb+0ZOMuEhKsbnh4dyMZZl1YJ+SyV0wKGYfk+bu69nu0Uc9XEjtrw6Bp5ay6aW6zhB92yXxjl8G9zwbDETfStIocWLwDwv+56MaWSXxPvmPozemb41fs3MKYZXf0n1DXxAIjDCFU+i6k4HSEGtp70DL/3E1n5E9LhGTARaXtqF4LfludT/IuTBKaDGk+OPL/ngeUM6es0PuqrsYLAH0FQ3VKHU0C3hnxLRGKRI6Q2hLT6zMOGA/7hYKCnrgDy2VP0I1F4X9e/Fim3CCO7ZIayiG2jtSq1fd/7m6/6FwMQg7I3I5ot+3V+yvtrtljf1JxOsEX7rliW1Co=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(366004)(136003)(39860400002)(346002)(8676002)(66556008)(4326008)(6486002)(66946007)(54906003)(966005)(2906002)(316002)(66476007)(44832011)(33716001)(7416002)(8936002)(5660300002)(6916009)(38100700002)(86362001)(26005)(6506007)(41300700001)(6512007)(6666004)(186003)(9686003)(53546011)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9an3yeJMMu/2JVVV3zru7w9SOkU9aVtF2wXVGxeoxqOxdLe5yYCP+ydwks/F?=
 =?us-ascii?Q?S/UxCv40iqkcj+9PHbLMcO/rFiWu+Z4NwBxkO1/mQ/pvNvCX7FYWgP+yGkc5?=
 =?us-ascii?Q?qQDsuWTcVzmbNAngcIXIW0NE62uGaDZ1Ys+C0M/LZ0Aoe2skMxRoe/xMD9oI?=
 =?us-ascii?Q?0cdrutnM27gt5YyGscsoHC1xX6Xy8hHfoJUP6Pamy3abtYbOJvW1ciWvgEOa?=
 =?us-ascii?Q?ri0hcqBQwLJ1MyXNj6wSYHKBuQGKgbtK3+Z4eu6gH1tPW2q9N4hBDIeE0ceD?=
 =?us-ascii?Q?dHI8gw3kqQ5Im3XzpAuAL/GhdktPQ4TS3YkE1mILD1yujZQDyu1gaGhxNWpQ?=
 =?us-ascii?Q?gkPoXI8cCcES5PhbsNRaUvE1AZczsmwTamehxzZd+CFoUYbw1zsOnHEhb5fn?=
 =?us-ascii?Q?tb3y6hQTqOkW9GLpvOpvHdsOzIxFJmg0pA9JXbrv1E5dE0mXa6XnEOeK3LW/?=
 =?us-ascii?Q?fy4RcRsOyEuoO5OaonB3+QBntAgQ1/zh+3NrRiqJSzCfj5w6xPMkorYZQh6+?=
 =?us-ascii?Q?2UL7eYj71uTv+OtNShSADvHm/H6c8FrU86h3S3tyqu2slR7wEZRLfFPXKlTj?=
 =?us-ascii?Q?gThcY9huXGFPGE2yT2CfC1rEgp8fgeu+a3hL3Q7bsi6USsKNsdStJdaZfup9?=
 =?us-ascii?Q?2/SUqhIkhzT7Xen6QfAqGQfQQqBoLlVDHm0xALL/6mrjDXggjuk1Ar9x4q8S?=
 =?us-ascii?Q?2Rro/oxjd4CEe8x2KeaEzxmao9kdBIjnvdRhl+yetK8dEFnLsHL7vdOtNIzY?=
 =?us-ascii?Q?rqibXdYopEn/Oxyr9vTtaaQXyvY0BPKSfjPAJNlZ97NCh7UAQraKg7HYKUod?=
 =?us-ascii?Q?Dgjmgf1FxkyIcw+9oNhKOZUb/kujIoz7Dv2EGbKxCK93w98uS/DboIYM6jC+?=
 =?us-ascii?Q?Y+GeD//kGcGeo0LWTvTWvEKwmiAPSLAwC+gVAK1v0JyM/iIOCuRVrJZTVe9R?=
 =?us-ascii?Q?TiAbBFsPQxPuj8B1JCvudTriwGwLqDYC66f57lsH8EA6Lx3DxP5pY3Xaqx1F?=
 =?us-ascii?Q?PkwiZ8SoDz7e46bfhUIQ2ROtCLZ5W9uqGpRUu6mV6dC4UysGh1pNZsgWer+O?=
 =?us-ascii?Q?UaTJdlT29clwvlfFjnF+2hLu2Q0vogq3cBKpoc6JRvCPkFe+RJwpytess/ua?=
 =?us-ascii?Q?1O/DArAQ5sDClQiyUlrUzDOtZPv0ybj4M5txhEDS4d3T3QaxCXz6dylW3VvC?=
 =?us-ascii?Q?+KhNm8O3MvB43UfRuUX9YYwHMGjZPFRIk0clkSB2yOKSXhuXzbIY5syydHUf?=
 =?us-ascii?Q?8lV04RnLV7dnAggVPsFV/7GMrL692nC6EVgSsfeZ4PlnfSn1El3X5MM4gkuI?=
 =?us-ascii?Q?kfuGEg+D/j1Ny4lxquBTAVxB756glWMKJAHh50tRIYXONgCkHaNDPbcLS8iY?=
 =?us-ascii?Q?ZbLQTGlpwa6t3Gioxepe5PxWB8isL+vUTChCXCVntFBDp/QUC4YmYQ2bC3Vg?=
 =?us-ascii?Q?Mz6GKhvb3ZoA5hRUfP2BCe2kqxehPAGaSF7E27MBmtNh5BR+vYhHdewmaVvN?=
 =?us-ascii?Q?sdFS+gfTYi1LP8Mj8w77/5ZL9ois3hN1G3qoRBAPEE92BQ8tsKeOZtivycuW?=
 =?us-ascii?Q?daE/rC9neSgWm3bDOaBLEjcc/H9Tir04R5qet4sfDhYB9b5YYZQQogKbcJSu?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5839f58-8758-4e81-ab13-08da903266dd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 18:05:37.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUpHjxkVgEDlt5OKt1mvYhAfGVFpWPcf3X5ymVU3edTZk0fYP9muN0vWebbR84DNn9JPz/ndeMwbh58juplaPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060084
X-Proofpoint-ORIG-GUID: Llh-RemODnjGRUTwO4JZeKTNL_hWFLWW
X-Proofpoint-GUID: Llh-RemODnjGRUTwO4JZeKTNL_hWFLWW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/22 09:48, Mike Kravetz wrote:
> On 09/06/22 15:57, Sven Schnelle wrote:
> > Hi Mike,
> > 
> > Mike Kravetz <mike.kravetz@oracle.com> writes:
> > 
> > > When page fault code needs to allocate and instantiate a new hugetlb
> > > page (huegtlb_no_page), it checks early to determine if the fault is
> > > beyond i_size.  When discovered early, it is easy to abort the fault and
> > > return an error.  However, it becomes much more difficult to handle when
> > > discovered later after allocating the page and consuming reservations
> > > and adding to the page cache.  Backing out changes in such instances
> > > becomes difficult and error prone.
> > >
> > > Instead of trying to catch and backout all such races, use the hugetlb
> > > fault mutex to handle truncate racing with page faults.  The most
> > > significant change is modification of the routine remove_inode_hugepages
> > > such that it will take the fault mutex for EVERY index in the truncated
> > > range (or hole in the case of hole punch).  Since remove_inode_hugepages
> > > is called in the truncate path after updating i_size, we can experience
> > > races as follows.
> > > - truncate code updates i_size and takes fault mutex before a racing
> > >   fault.  After fault code takes mutex, it will notice fault beyond
> > >   i_size and abort early.
> > > - fault code obtains mutex, and truncate updates i_size after early
> > >   checks in fault code.  fault code will add page beyond i_size.
> > >   When truncate code takes mutex for page/index, it will remove the
> > >   page.
> > > - truncate updates i_size, but fault code obtains mutex first.  If
> > >   fault code sees updated i_size it will abort early.  If fault code
> > >   does not see updated i_size, it will add page beyond i_size and
> > >   truncate code will remove page when it obtains fault mutex.
> > >
> > > Note, for performance reasons remove_inode_hugepages will still use
> > > filemap_get_folios for bulk folio lookups.  For indicies not returned in
> > > the bulk lookup, it will need to lookup individual folios to check for
> > > races with page fault.
> > >
> > > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > ---
> > >  fs/hugetlbfs/inode.c | 184 +++++++++++++++++++++++++++++++------------
> > >  mm/hugetlb.c         |  41 +++++-----
> > >  2 files changed, 152 insertions(+), 73 deletions(-)
> > 
> > With linux next starting from next-20220831 i see hangs with this
> > patch applied while running the glibc test suite. The patch doesn't
> > revert cleanly on top, so i checked out one commit before that one and
> > with that revision everything works.
> > 
> > It looks like the malloc test suite in glibc triggers this. I cannot
> > identify a single test causing it, but instead the combination of
> > multiple tests. Running the test suite on a single CPU works. Given the
> > subject of the patch that's likely not a surprise.
> > 
> > This is on s390, and the warning i get from RCU is:
> > 
> > [ 1951.906997] rcu: INFO: rcu_sched self-detected stall on CPU
> > [ 1951.907009] rcu:     60-....: (6000 ticks this GP) idle=968c/1/0x4000000000000000 softirq=43971/43972 fqs=2765
> > [ 1951.907018]  (t=6000 jiffies g=116125 q=1008072 ncpus=64)
> > [ 1951.907024] CPU: 60 PID: 1236661 Comm: ld64.so.1 Not tainted 6.0.0-rc3-next-20220901 #340
> > [ 1951.907027] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> > [ 1951.907029] Krnl PSW : 0704e00180000000 00000000003d9042 (hugetlb_fault_mutex_hash+0x2a/0xd8)
> > [ 1951.907044]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> > [ 1951.907095] Call Trace:
> > [ 1951.907098]  [<00000000003d9042>] hugetlb_fault_mutex_hash+0x2a/0xd8
> > [ 1951.907101] ([<00000000005845a6>] fault_lock_inode_indicies+0x8e/0x128)
> > [ 1951.907107]  [<0000000000584876>] remove_inode_hugepages+0x236/0x280
> > [ 1951.907109]  [<0000000000584a7c>] hugetlbfs_evict_inode+0x3c/0x60
> > [ 1951.907111]  [<000000000044fe96>] evict+0xe6/0x1c0
> > [ 1951.907116]  [<000000000044a608>] __dentry_kill+0x108/0x1e0
> > [ 1951.907119]  [<000000000044ac64>] dentry_kill+0x6c/0x290
> > [ 1951.907121]  [<000000000044afec>] dput+0x164/0x1c0
> > [ 1951.907123]  [<000000000042a4d6>] __fput+0xee/0x290
> > [ 1951.907127]  [<00000000001794a8>] task_work_run+0x88/0xe0
> > [ 1951.907133]  [<00000000001f77a0>] exit_to_user_mode_prepare+0x1a0/0x1a8
> > [ 1951.907137]  [<0000000000d0e42e>] __do_syscall+0x11e/0x200
> > [ 1951.907142]  [<0000000000d1d392>] system_call+0x82/0xb0
> > [ 1951.907145] Last Breaking-Event-Address:
> > [ 1951.907146]  [<0000038001d839c0>] 0x38001d839c0
> > 
> > One of the hanging test cases is usually malloc/tst-malloc-too-large-malloc-hugetlb2.
> > 
> > Any thoughts?
> 
> Thanks for the report, I will take a look.
> 
> My first thought is that this fix may not be applied,
> https://lore.kernel.org/linux-mm/Ywepr7C2X20ZvLdn@monkey/
> However, I see that that is in next-20220831.
> 
> Hopefully, this will recreate on x86.

One additional thought ...

With this patch, we will take the hugetlb fault mutex for EVERY index in the
range being truncated or hole punched.  In the case of a very large file, that
is no different than code today where we take the mutex when removing pages
from the file.  What is different is taking the mutex for indices that are
part of holes in the file.  Consider a very large file with only one page at
the very large offset.  We would then take the mutex for each index in that
very large hole.  Depending on the size of the hole, this could appear as a
hang.

For the above locking scheme to work, we need to take the mutex for indices
in holes in case there would happen to be a racing page fault.  However, there
are only a limited number of fault mutexes (it is a table).  So, we only really
need to take at a maximum num_fault_mutexes mutexes.  We could keep track of
these with a bitmap.

I am not sure this is the issue you are seeing, but a test named
tst-malloc-too-large-malloc-hugetlb2 may be doing this.

In any case, I think this issue needs to be addressed before this series can
move forward.
-- 
Mike Kravetz
