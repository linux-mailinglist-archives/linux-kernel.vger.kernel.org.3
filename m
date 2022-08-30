Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD39E5A6C59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiH3Sjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiH3Sjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:39:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC507170E;
        Tue, 30 Aug 2022 11:39:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UHtNWX032440;
        Tue, 30 Aug 2022 18:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=+2ySLpVcqfOfJlK5zYsjMuy7coXZXBEJUE4DHgt73Hw=;
 b=pyTX+/b0ECy6C6qz+jxl765440u8KSNNc2mpogA6XcyWr/6jYpJwqDyAqZgzKsUnjHyn
 qDHpCSCFPYsgTeMxMOz6OdkKb7XZamHzftn0/Z1Ri/3cSjNwF8X8xBhfY3rKMwTcw4CM
 jeLw3vV+rShAHQRzTuIiDmr6DBbTGDUhQoJOZmH3TJe/zq/ObqQC2WQY7wR/YeywnC9n
 52e/ZAq4k6EUcXOzZSUO9NuTpKrGcpHgg+M4sisAkq1RwXPAyuO7ANMMIP6FRm51mG6/
 fX18txPWGPkHMkPFBd3yw9QPLgqznDd8cSH0oo+OSf0vua87TLaj9YAgSxEpbmczmTBu Lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a2278c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 18:39:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UIXVvr013087;
        Tue, 30 Aug 2022 18:39:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q49e4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 18:39:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5lJay9qoVo/A3NmZazAyrrUU5ef16SLTI+zlOLlFGUdTSQzBN/BLcuHB2oE0oROmZJVC3GnN8LmX2KVuNV8H4lAMWjZq07oVL8ZnbTaMXuRwypay0gjKROpGiCb4x1rqyC5lYIj8WrUmb0MNTrk90e/+k5BY2btP75Rg2ZHEq7V5HCrQg3rh7Aw5E+WHBNQ5CxolaPXNxu9yh1HNYgkfUvYImETcdxe31yTfKAeL8MWo4UyTgd1r8YPEFUkidtA6i0Kp6Oj41dad345bXvrrR9XCcJly+JluREl59/arQEtetQ5FctafknsaDz2hThrm2wSXGOACoIqTdN8zzUPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2ySLpVcqfOfJlK5zYsjMuy7coXZXBEJUE4DHgt73Hw=;
 b=by9gEcPa68oW0BuF2WZJUZQJdrPGMycR4lxmERbp5tJBDyRC6YiXfTVvlkIHc5SElpPZC2o9JI9kMIPyzH8JVIbBxsbEy+EKaujBEsN7sehFnbjifwWEJTWrcH3HhGOquolMzI0402AEK3C0IQG3mchb6xPTYOX3FY5N6uAbChT7RilLSJ/pcXwzgdPb6dKC0zep9abhm5CY8RrqNnUc2OzNpjEdAgWLC0+FPNo5aS0iMd1eZrhxisOYjZElaUi1F1C4ZQQrjaoAsNtzdxuW7933kI7n7TcI+1QYJJcPgDQZS+jmYBD9fbjS86EsPS/OFr22Gb1fqOf3pmc0WyUPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2ySLpVcqfOfJlK5zYsjMuy7coXZXBEJUE4DHgt73Hw=;
 b=mL6BcGcbjH0+lAsE1PysNu+4MZH4QJHXoU/VW9MyTs6n+I6B52fkaY3q40QOVcaagJgAutyEm+nYNX2W81dN9sKirgtc3LIeRpCF5Igr7c861FIO7ks03XH3cxOLwc4mrozPNviTJHV5NSonia8CNxvXdyenWWc6eXmcS3qqYa4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5140.namprd10.prod.outlook.com (2603:10b6:208:320::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 18:39:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 18:39:12 +0000
Date:   Tue, 30 Aug 2022 11:39:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        inuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
Message-ID: <Yw5ZTEqxZCAgEbK9@monkey>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
 <57c8f032-e48a-bacb-7922-3e2cc10dc0d2@linux.alibaba.com>
 <Yw4+YvdS9kJUnx1s@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw4+YvdS9kJUnx1s@monkey>
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d2b195f-00c9-4595-2f99-08da8ab6ee67
X-MS-TrafficTypeDiagnostic: BLAPR10MB5140:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqKexwR1c7/POgy+NTZKL+ONeTVNwS9UzMlrjGX/hV6FLesGuJ2EpZ4xqJ8d/FVjrcLY2vgdmoQD9msy4sBLzPlhjpbuP/LHJBa6jidZYOL+1r+64asLGHbmmXqpI8QTs0hcn4WwlOiJEPGit8G2qSNhJeNorD262TlWjgCil3f2RHmlcfrrWT7RuIQ0sgfvWnB1czZ0IVjTqolqGV4vjj+T4d6eLvAalf50VG+gyofl7bV/mOYgma0sd1Vup9SDxJITpr/jlwKMnaON19esfqq4rCYsomhUjDDhoy8u+qSvClneHv31uhXrEBoQDcyOrvTTCm62fP5cQW2fvjvxPjsXzKCc+KGafT7lXpNkO/GiA88w+AdVLvdg0BOlxqslrn31Of3ihGpfrgGuLInyuHPhiFnkG5eBG6Zxxd4X3gzA90x+jtG90U9Hse+zTLCtTTLJ/7T+Zq8tYWLrMUl2vhEGUBEPiUbsruAtnu9zx09DKMhi0mbm69Y/6p4Y5GuAybWh8pq89L/yfn0z8ndvqBd2bUW/kybS4uIjre6KomHPAYHt2/svGwls4cf39XTXXXFxSPN/sLYLa6bEsnI1Fwv3SxINJOxKw0T0UlnHq8q/iE5GOs4RKqI7L8artLMeW0zASAQJHxm0BZsKn+gOvJ96hwVPGvJuwIq5NQ7P5MlNRoFA0J9P7TMJHbtCUQbjL5APUsKbsQP/BJGhUAV/Zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(66946007)(66556008)(66476007)(316002)(6916009)(6486002)(478600001)(54906003)(33716001)(5660300002)(44832011)(8676002)(4326008)(8936002)(7416002)(2906002)(38100700002)(86362001)(186003)(9686003)(6512007)(6506007)(6666004)(26005)(53546011)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UbQAYJyZQVsT9KR9VvYIfScSVwqWRnLeJPy1ZUBj4m5n9zEGQ3VL7e1055WL?=
 =?us-ascii?Q?RM427DHHp9kDIP4utp3q3E/nqDUy9ugnmTA6PnSm9KXHNsJjSByguE8bZm7j?=
 =?us-ascii?Q?YYcQWjfBH6zRAa7Ee/LKWqNIzcu2J1s/beOP/B/OYkFkRIP7Odna9sTybQAq?=
 =?us-ascii?Q?JHmLLA68crBNTX6AOqPiHKB0LPd4xKYlB5ko5yyeXt6rXn7E1MSu5fQNGt/m?=
 =?us-ascii?Q?ThiPH5Q+s3MV10sXfqWjtE+zZIKbh7pp4qKNkwF2Ej6tE7yDE4sBz7uixLX3?=
 =?us-ascii?Q?7a6F8jxZUrnTQJkGzN8x0hqLRkBbd3+RL4TlyXUkWNV7uoX5fshXUTEUoF32?=
 =?us-ascii?Q?MrSOetABkyci6mvHXCcpSpmpP578lVBBrS/Oq0/I/CcdNUJv4Nuk27QiBHuA?=
 =?us-ascii?Q?Y3UQSldbXmkbUaiMJiZjpKBG014FVjkAHw+lwbePa1WKjKoKppDNA2sPWZyO?=
 =?us-ascii?Q?/konBgrDkXOvbHW3g0HWp1xYbf9YoJpkPtwSOHxRcaapsk7hePvYG3asJ9ho?=
 =?us-ascii?Q?fsp41WbqiBnI8MhQt8v0YvVtpO2+gqZ/hu72vZZ0MzFVvN60vwHnxIQBHSty?=
 =?us-ascii?Q?lS2CSwdisnLbh/8uxJKY7phs9MJ6GD64oeVXj4sXzbJEpkp+Ajja5el2lk92?=
 =?us-ascii?Q?1LVCf9Ax3XXUY+paXB5oAihJhZO0cYYZKmNcjV8vAUBmj266vv3K9Fe7i6Fz?=
 =?us-ascii?Q?CI9eJO6KF2Y8iGGJnibuT5w/Qje0ERL7HDH6QG4+hysyfqu6BA6IDXQfFSCL?=
 =?us-ascii?Q?VJIu+vk8iTFqpZ4UaIOcP/g62nO98JIvQpOK7D5bKX2NC3kx822nhK0Xi3R8?=
 =?us-ascii?Q?lU4a5GQXIWqgu3bqBQUczmmRKJz3Cy8tuw7jJG6VjfywpF3QgxmXKfqbMGcf?=
 =?us-ascii?Q?G+/UKMU0vUgqLjJGzK3BHCaw1s4daRj6EOwBAnUTSY4HAiyavlVUDA1yK4vY?=
 =?us-ascii?Q?DFsnEK/DIYW6racEr/hZ/rQQCPVu1SlhCmi4H3jCwg9j6YRdqCH9UspLJL3C?=
 =?us-ascii?Q?1MC6B5yPICNirIVFQAcufhQZTtvQV9CA3bxSFSBE5aVjmnkAjMjHtVJEmhMO?=
 =?us-ascii?Q?TP86fXd4mMGvBkT4J+xlb+m4S00xwtxqwsGxkYLBq8dxTAxN4Lwe34pAWEzE?=
 =?us-ascii?Q?uaIa3s++LsN7Qj9SOS9W+YD5x83iiFsA0quzq3iom9FVy0mMTkrxakeoagaY?=
 =?us-ascii?Q?QgfBMrvezAwAqzuHO1tIonBnZZOHjU28IMVyJah68QpWyssh3+RBiHt515F3?=
 =?us-ascii?Q?15q68esUM/RsWG3oqTvHVKH2nWCd6U0Xps120XXOq3lBcQhjZdPOHmsd8ZSA?=
 =?us-ascii?Q?XE7/JRs/DtE/4kXeg6vFVfqIcRsaVk82cdqVeOJhq+DrYnZx9BrOTiVZkli9?=
 =?us-ascii?Q?UqvjfUmhTYa/6VvhZuJ9nD4u5Vr2+2FycQzksvcdVkri4sJT8lOHFAuydnlP?=
 =?us-ascii?Q?fD82Ervx6FZf7sVVp/aRulN5U8K/ugabUPcK1oc7eBjWIy32kL4A4qqPMUYl?=
 =?us-ascii?Q?1uQonq/j4zA6eJnerxnPf9Ce7X3hWy2TJOAHEPGb5F07A4IsSn2qvRqhv1Q1?=
 =?us-ascii?Q?nFP7prP7gAhMpBxi7QlYYsnKlNQvEFxaayrzeVOEpG8g2+goYErIHYxRVwTn?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2b195f-00c9-4595-2f99-08da8ab6ee67
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:39:11.9778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIb38Xt4vHG0Cnd5jX03EhyVZ1pWgvOzY+NWBnsC7bhf4+ZoVkXaBzTyXTdBbIRdLnH062RBhmm8Ox4Hxgxf3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300084
X-Proofpoint-GUID: VgzsLiOo9WM7mGpheHN0gzg-jpuOSJXv
X-Proofpoint-ORIG-GUID: VgzsLiOo9WM7mGpheHN0gzg-jpuOSJXv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/22 09:44, Mike Kravetz wrote:
> On 08/30/22 09:06, Baolin Wang wrote:
> > Hi Mike,
> > 
> > On 8/30/2022 7:40 AM, Mike Kravetz wrote:
> > > During discussions of this series [1], it was suggested that hugetlb
> > > handling code in follow_page_mask could be simplified.  At the beginning
> > > of follow_page_mask, there currently is a call to follow_huge_addr which
> > > 'may' handle hugetlb pages.  ia64 is the only architecture which provides
> > > a follow_huge_addr routine that does not return error.  Instead, at each
> > > level of the page table a check is made for a hugetlb entry.  If a hugetlb
> > > entry is found, a call to a routine associated with that entry is made.
> > > 
> > > Currently, there are two checks for hugetlb entries at each page table
> > > level.  The first check is of the form:
> > > 	if (p?d_huge())
> > > 		page = follow_huge_p?d();
> > > the second check is of the form:
> > > 	if (is_hugepd())
> > > 		page = follow_huge_pd().
> > > 
> > > We can replace these checks, as well as the special handling routines
> > > such as follow_huge_p?d() and follow_huge_pd() with a single routine to
> > > handle hugetlb vmas.
> > > 
> > > A new routine hugetlb_follow_page_mask is called for hugetlb vmas at the
> > > beginning of follow_page_mask.  hugetlb_follow_page_mask will use the
> > > existing routine huge_pte_offset to walk page tables looking for hugetlb
> > > entries.  huge_pte_offset can be overwritten by architectures, and already
> > > handles special cases such as hugepd entries.
> > 
> > Could you also mention that this patch will fix the lock issue for
> > CONT-PTE/PMD hugetlb by changing to use huge_pte_lock()? which will help
> > people to understand the issue.
> 
> Will update message in v2.  Thanks for taking a look!
> 

One additional thought, we 'may' need a separate patch to fix the locking
issues that can be easily backported.  Not sure this 'simplification' is
a good backport candidate.
-- 
Mike Kravetz
