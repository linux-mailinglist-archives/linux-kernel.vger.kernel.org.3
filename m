Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003885AF840
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiIFXJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIFXJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:09:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F568688C;
        Tue,  6 Sep 2022 16:09:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286LcsjG022167;
        Tue, 6 Sep 2022 23:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=0PUYPH5LWe83H0XMhyzjh13dEqVYNPck6rHaijXQHI0=;
 b=D4k/OZtmETnEkdpSkkt18vr2gYsavjW4M4vlm0j6NLMMl58bIRHAxoyO5OtOQ9VpWs2U
 iZTuqV6h8RDd0NKO8u6wzMbVYMwQSMoklxJvqfIaPGY2aQEEZ/aNzL7vN05jnK6S98B2
 OTu8xm9TeXmjYyRoYVezg/qwsYomlCKqOfp2UtSHNH21gPG4c+SzR9ohOf2mTph+aXfV
 FBWuvxq+bBdM0q/07JOYFuej7R7yMAubLpXLd4vY3bu7nWx1zH8s/Mcx9bVPzNoQWSn3
 eENtOyZmCn3FLyqOH3nUWncDDHOnJzrhl19IOF8QXL9gmv27xICl9q7PVtUrzMI1WSFN bA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2fc27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 23:08:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JjjNr027632;
        Tue, 6 Sep 2022 23:08:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9t566-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 23:08:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JahJ9f4xrUfHLi22NQ3YuA94l0WVEIaL+QBnTvycAkg4/G6+y9I71wtjFiz1iJR/hwPGkdD4D1nK678CybSDHyDk6EPONUKve1tF0cAHDWmy+o2lgHfzgbVPJ2wiwo0mzuDUhZOq+icDQ/qhLEcusFLw7rvjl4W4QfqK8j0d7EUwJSI05koffybHUS2kxndfniuVojnVB1vxNGZEDIMtRd7WEdoE5h3CBSsz5Dyu+6WH9umt5CBbIouKODaf41clZyvY4BR3oM5vHuiA4iJVb/nX9uOqQ03/1MsF1mIfR3QzwPB8eZaxRbNvBc7eq3tkBznkHNSoWLN/KJiBOzgsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PUYPH5LWe83H0XMhyzjh13dEqVYNPck6rHaijXQHI0=;
 b=iX81+9kSte1zwZUkSFyptLuxmtjna8q5wlR1hSWkzb/HpzXK9Z91pNoUJOxD6lSVR24GZjFQJRJ26HH9C4F5Bx4lYVOTpQ15v1/71D4y/gyYo0ar4dmDZFBI8pR13c8ChDt5axIVNRzzatrze4NQxhobQly1u/Q8VJZHyNWqLvdEE5/EGsXZo6ZCHP2ET7zjlBX2yWdzTi0RBRxcKIQwUiP1kGh9/aNv7FkaHmG1JiBTelBX+4O0p4ehBQ2Hq2mdEtHSW4WoBv2/d0VJDEQRb8Ow9hSyq8kf2Icp8JByQZdaZKu0P02W5pOVp06F0IC6nVfY8WvpkdYB+Z0Zgh2CfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PUYPH5LWe83H0XMhyzjh13dEqVYNPck6rHaijXQHI0=;
 b=gaEDbkBJkxFH4awsfeCnl/3rnEo3Tu7dQ9vnYxnPiiRi5XW3bN7DG1FRFt2TDg2xOWllpjg7ZDszvn5TO2vrGEFc87XBetehQbuxh7E961S0zUsnYPpACtBaBvPPq+xdg/VV6q2uAqtPzt8lAez56inS507EznQJM9NUuBqWpyI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB4830.namprd10.prod.outlook.com (2603:10b6:5:3ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 23:08:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 23:08:54 +0000
Date:   Tue, 6 Sep 2022 16:08:51 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
        linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 4/8] hugetlb: handle truncate racing with page faults
Message-ID: <YxfTA53/5pkpC7xZ@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-5-mike.kravetz@oracle.com>
 <yt9dr10ok3lm.fsf@linux.ibm.com>
 <Yxd5z0c8NlKVlVqk@monkey>
 <YxeL7ZMoyNmPAvY0@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxeL7ZMoyNmPAvY0@monkey>
X-ClientProxiedBy: BY5PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4f40acf-668c-4b57-691f-08da905cc4ac
X-MS-TrafficTypeDiagnostic: DS7PR10MB4830:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/yjW6Id5Bgb1geNXahATbyO8IixNed7OUruS/uUiynRUCgLr8pAiGqB5ZNVf2KAfd1J2juOWhJapcpFr+j/jiYhQp01h5ofrCH2Klw65tFq77oSa2vsKmNOYu/YKTCOCG4WspFHbF9L5CX+uIgJE6svioaYNstHSsXrqvRqK/Dp6E7fe8UipoiyNdMjWVg6tb1zklscdYi6SvhKMArEC6mMtr6UKGH2nLje+xWTwk7NH9ITbq1K07SL+vMUJi1noKx4KO8mlfKfQbahw+KZenpbG4Jjh44Nt74JbQe40FUDQGY2HEvmy3NCa3sP6nlreAraXQNzgTij0MhjCQdzcZYrrlQNbmQk7bwQi0wkPnsjPcKRmvzlZ7rkYCdDwwQv60YPk+/v3IEJkggSPR1DsX2XCqApfGli/Z1c2VoYwn/IqD2J8E+22VFxtjf9uJDIfG+iELycL5kmP+EEpGZTAbmVVr7fmZJTWNVHUp69skZ/M3QUlClAMycO2Rqfm01C//eXhsY6tg0CD69oZHxwvtjLENCmcl7CSoCs4h+z6uuD2PY3B7cM34VwCtq4NjbLmHrlzJzPRElHEEle115FJ0jZaD+2438gNYVYrAqpVDyZ4EXYI8WkG4FVi//O/U7Z2xPHKY2Tvof2nn8s1pXzyQUzlgclV6fLIUWU0S78dguT33zJZIs2QFJGDis3/dn/7gfo+NSTEAxcgDOGMm3zrtDUtTppE0p5c8uI0SUbB4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(39860400002)(366004)(136003)(396003)(38100700002)(66556008)(66946007)(33716001)(8676002)(66476007)(4326008)(54906003)(316002)(110136005)(2906002)(5660300002)(44832011)(9686003)(7416002)(8936002)(6512007)(41300700001)(186003)(6666004)(83380400001)(53546011)(6506007)(6486002)(478600001)(26005)(966005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zFr3MRZYj5OqQzsNCU8iVRQeshhSd90Fjf+OPt+KOZ70qI/hMYR18k9rmXbX?=
 =?us-ascii?Q?nECUrwypDfjzUoBlwEKKIsz2IKUyCTYmnuvyXhggTzRv2C1lAyMiyEOicqoS?=
 =?us-ascii?Q?Y5qHAPGQkrI+1Tczmg48jhmNPp4vhXcdvvECnBgC7d6gmlooI/qTEDWmBfTz?=
 =?us-ascii?Q?o7+gD/7SRyZLu0Y2sKd0RHXQ8cN2kWpUoWxVeXnk/wwhwaaDM/H4G03xpss2?=
 =?us-ascii?Q?eo9J6kf4Hzz2hTnGgoLnNZXR2IqRmGsws3H2Cm/onNhAtEKNWMDRtMJLenPZ?=
 =?us-ascii?Q?cY2/IvNcfKWWSNkiLTEHCACqgSbOI9N7NKjGGL70Ae7jJ8tmgsulwAHfZLew?=
 =?us-ascii?Q?Sv0lS2yyq0UvfId+cprw8nitLgGNpNHS7LHcxms0/a2eXek/ZjgTIWsbu6ZW?=
 =?us-ascii?Q?+Qaq5X7K9MPeTv+ODI3W27Xyj40zcqSGlosQx6L1RRcQofAN6hXalMeP8O74?=
 =?us-ascii?Q?Hb2odhs5Z+sjCxnfNqiOyb4BJzLHnH8MJfhMwNSksZtDCM+FDRsTtlByIRw7?=
 =?us-ascii?Q?YaW8zQk7+5EOSx52D54KLUqNPXxNQJKEPCw2EA8C4go6Q1xedtQBjjSbvTgB?=
 =?us-ascii?Q?1cDOh3tbbEaEopERmZxMU1vJ5kaBXBX23ZVQu3qYgxW/YnKyUn80r33NXQu7?=
 =?us-ascii?Q?sxpk2ZVMvjewdBxzLLghrTWyc6+lIKaDT1oAxp+cMZGWajzsqRoBTfupJaba?=
 =?us-ascii?Q?2UZpSaFRk/PVymLMI2hQN84k06ErtyrOBRctKvbbAfZwlsl+hbXwsgsieCNK?=
 =?us-ascii?Q?WCdAnlBOmZV4/vzahyJbEgYnVNLJjGd3R1J2wcdXWLg9dgNfdj2cKpJnqyLV?=
 =?us-ascii?Q?WvT+gipUttoQfvTfyv+i16emVn7A46YXRt8UbX0EWJxlZWQ7cb1Vb6Q4XcWU?=
 =?us-ascii?Q?xlBgS4lSnYU2fv9ZYktQ5dsoeXsVUNxhDQCTO6nPTUueb4BiPBBNG62GAq6n?=
 =?us-ascii?Q?bg0opOfK7nCllT9W11QXKsegp7XzFqMK60mB6lxH1qFURYBJ9wkFdM0LkznP?=
 =?us-ascii?Q?iaKC57l9hUnmaucBDWhA/ZKakiYmPIXrvxdwaOBbgGZBJ2OqfXyCff1FKQpa?=
 =?us-ascii?Q?okNYJ6n6p3tIMP9fgG2IO+MtcDXE/QP6yuiTvGU7d2RxQg/FLvE/DL1hJSNw?=
 =?us-ascii?Q?/33ZQRiRw+UCpnke8P4rLSIhr1uHXA7EH1RUSyoXT/A+zZHt/MxZUFr7Tvr/?=
 =?us-ascii?Q?2jQjYhhxGaNK6WW0XTdzETqoSFGA4cC8WiNnHCx2LygIyUPgO0Ca9aesV2hh?=
 =?us-ascii?Q?GPLJ8MIliuHtJEv2WFDCZKhvLnCsdvIW/tZdFX3jd1H8sz8sIQt/+FTuVXKQ?=
 =?us-ascii?Q?iaPNEPTcl7ILDHiUMdGqnvKxIwXGzjU7yKExsf0to0uWFd5X2F7rHoC6jmN5?=
 =?us-ascii?Q?KSV2w1nHl7qjV8HWQSUja3ytJgLSMK4beLErdbO/gKVviJ2NLhvOGjGcJezE?=
 =?us-ascii?Q?nHWTpg71UpekXZKsQY/64YuFiVYqUZWyarUnH16WGCw0j61gO2k6wUpWsW2h?=
 =?us-ascii?Q?Up22+YVqZOwSEYLGf73w7e54+aFbrf6QFwAqKDhMt9lhWyobp0XmU6o4V9ji?=
 =?us-ascii?Q?aaxU6Y0e0u3x9/FWCpk1TDZuqPWOHueozQJ0dMqW0icrsp05AUIzcPVsVsyM?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f40acf-668c-4b57-691f-08da905cc4ac
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 23:08:54.0822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJNxQbavodeKkPCySN6IO8AIuXuHh2TTF1eSXlATOgkCDoAlb1oPegdogm5LYvNMhVI/eez3pAL4xJ3jscGqDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060108
X-Proofpoint-GUID: tiHgkL8yj3gFCX8j1uNcgRCgusLnhZB4
X-Proofpoint-ORIG-GUID: tiHgkL8yj3gFCX8j1uNcgRCgusLnhZB4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/22 11:05, Mike Kravetz wrote:
> On 09/06/22 09:48, Mike Kravetz wrote:
> > On 09/06/22 15:57, Sven Schnelle wrote:
> > > Hi Mike,
> > > 
> > > Mike Kravetz <mike.kravetz@oracle.com> writes:
> > > 
> > > > When page fault code needs to allocate and instantiate a new hugetlb
> > > > page (huegtlb_no_page), it checks early to determine if the fault is
> > > > beyond i_size.  When discovered early, it is easy to abort the fault and
> > > > return an error.  However, it becomes much more difficult to handle when
> > > > discovered later after allocating the page and consuming reservations
> > > > and adding to the page cache.  Backing out changes in such instances
> > > > becomes difficult and error prone.
> > > >
> > > > Instead of trying to catch and backout all such races, use the hugetlb
> > > > fault mutex to handle truncate racing with page faults.  The most
> > > > significant change is modification of the routine remove_inode_hugepages
> > > > such that it will take the fault mutex for EVERY index in the truncated
> > > > range (or hole in the case of hole punch).  Since remove_inode_hugepages
> > > > is called in the truncate path after updating i_size, we can experience
> > > > races as follows.
> > > > - truncate code updates i_size and takes fault mutex before a racing
> > > >   fault.  After fault code takes mutex, it will notice fault beyond
> > > >   i_size and abort early.
> > > > - fault code obtains mutex, and truncate updates i_size after early
> > > >   checks in fault code.  fault code will add page beyond i_size.
> > > >   When truncate code takes mutex for page/index, it will remove the
> > > >   page.
> > > > - truncate updates i_size, but fault code obtains mutex first.  If
> > > >   fault code sees updated i_size it will abort early.  If fault code
> > > >   does not see updated i_size, it will add page beyond i_size and
> > > >   truncate code will remove page when it obtains fault mutex.
> > > >
> > > > Note, for performance reasons remove_inode_hugepages will still use
> > > > filemap_get_folios for bulk folio lookups.  For indicies not returned in
> > > > the bulk lookup, it will need to lookup individual folios to check for
> > > > races with page fault.
> > > >
> > > > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > > ---
> > > >  fs/hugetlbfs/inode.c | 184 +++++++++++++++++++++++++++++++------------
> > > >  mm/hugetlb.c         |  41 +++++-----
> > > >  2 files changed, 152 insertions(+), 73 deletions(-)
> > > 
> > > With linux next starting from next-20220831 i see hangs with this
> > > patch applied while running the glibc test suite. The patch doesn't
> > > revert cleanly on top, so i checked out one commit before that one and
> > > with that revision everything works.
> > > 
> > > It looks like the malloc test suite in glibc triggers this. I cannot
> > > identify a single test causing it, but instead the combination of
> > > multiple tests. Running the test suite on a single CPU works. Given the
> > > subject of the patch that's likely not a surprise.
> > > 
> > > This is on s390, and the warning i get from RCU is:
> > > 
> > > [ 1951.906997] rcu: INFO: rcu_sched self-detected stall on CPU
> > > [ 1951.907009] rcu:     60-....: (6000 ticks this GP) idle=968c/1/0x4000000000000000 softirq=43971/43972 fqs=2765
> > > [ 1951.907018]  (t=6000 jiffies g=116125 q=1008072 ncpus=64)
> > > [ 1951.907024] CPU: 60 PID: 1236661 Comm: ld64.so.1 Not tainted 6.0.0-rc3-next-20220901 #340
> > > [ 1951.907027] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> > > [ 1951.907029] Krnl PSW : 0704e00180000000 00000000003d9042 (hugetlb_fault_mutex_hash+0x2a/0xd8)
> > > [ 1951.907044]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> > > [ 1951.907095] Call Trace:
> > > [ 1951.907098]  [<00000000003d9042>] hugetlb_fault_mutex_hash+0x2a/0xd8
> > > [ 1951.907101] ([<00000000005845a6>] fault_lock_inode_indicies+0x8e/0x128)
> > > [ 1951.907107]  [<0000000000584876>] remove_inode_hugepages+0x236/0x280
> > > [ 1951.907109]  [<0000000000584a7c>] hugetlbfs_evict_inode+0x3c/0x60
> > > [ 1951.907111]  [<000000000044fe96>] evict+0xe6/0x1c0
> > > [ 1951.907116]  [<000000000044a608>] __dentry_kill+0x108/0x1e0
> > > [ 1951.907119]  [<000000000044ac64>] dentry_kill+0x6c/0x290
> > > [ 1951.907121]  [<000000000044afec>] dput+0x164/0x1c0
> > > [ 1951.907123]  [<000000000042a4d6>] __fput+0xee/0x290
> > > [ 1951.907127]  [<00000000001794a8>] task_work_run+0x88/0xe0
> > > [ 1951.907133]  [<00000000001f77a0>] exit_to_user_mode_prepare+0x1a0/0x1a8
> > > [ 1951.907137]  [<0000000000d0e42e>] __do_syscall+0x11e/0x200
> > > [ 1951.907142]  [<0000000000d1d392>] system_call+0x82/0xb0
> > > [ 1951.907145] Last Breaking-Event-Address:
> > > [ 1951.907146]  [<0000038001d839c0>] 0x38001d839c0
> > > 
> > > One of the hanging test cases is usually malloc/tst-malloc-too-large-malloc-hugetlb2.
> > > 
> > > Any thoughts?
> > 
> > Thanks for the report, I will take a look.
> > 
> > My first thought is that this fix may not be applied,
> > https://lore.kernel.org/linux-mm/Ywepr7C2X20ZvLdn@monkey/
> > However, I see that that is in next-20220831.
> > 
> > Hopefully, this will recreate on x86.
> 
> One additional thought ...
> 
> With this patch, we will take the hugetlb fault mutex for EVERY index in the
> range being truncated or hole punched.  In the case of a very large file, that
> is no different than code today where we take the mutex when removing pages
> from the file.  What is different is taking the mutex for indices that are
> part of holes in the file.  Consider a very large file with only one page at
> the very large offset.  We would then take the mutex for each index in that
> very large hole.  Depending on the size of the hole, this could appear as a
> hang.
> 
> For the above locking scheme to work, we need to take the mutex for indices
> in holes in case there would happen to be a racing page fault.  However, there
> are only a limited number of fault mutexes (it is a table).  So, we only really
> need to take at a maximum num_fault_mutexes mutexes.  We could keep track of
> these with a bitmap.
> 
> I am not sure this is the issue you are seeing, but a test named
> tst-malloc-too-large-malloc-hugetlb2 may be doing this.
> 
> In any case, I think this issue needs to be addressed before this series can
> move forward.

Well, even if we address the issue of taking the same mutex multiple times,
this new synchronization scheme requires a folio lookup for EVERY index in
the truncated or hole punched range.  This can easily 'stall' a CPU if there
is a really big hole in a file.  One can recreate this easily with fallocate
to add a single page to a file at a really big offset, and then remove the file.

I am trying to come up with another algorithm to make this work.

Andrew, I wanted to give you a heads up that this series may need to be
pulled if I can not come up with something quickly.
-- 
Mike Kravetz
