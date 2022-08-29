Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7FF5A568B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiH2VyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiH2VyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:54:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9396AA024F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:54:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TLkw3c026837;
        Mon, 29 Aug 2022 21:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ZAOIu+HQaGBNFVtVzlXTTu8DixlmpnvDH+t1Tx33Gj0=;
 b=PsTncjpIJBvQ53bvXQ8vyb0stuWq/0PhnJi1l3DOOTLJNLD7ev5UywAJYiRBzC4kqI/q
 LTsndAtMzLiK7O9aX7WLaG3DnZQInuPYEMHWjktyYnvcdhD5KZbL5GLhL71kGniXwsLW
 T9QnwclBtDb2PKER697x3Q5FOMMmP4WwtPmlOXsuHyvJ5ENph8rkm95XUyi7zThq8t9/
 KsfVtoV5aX1X6dfy6dHZuk4yjyHaqdYPvCdWfG4m/JirC49SYx2aRao+2uDYiRhsgPMi
 3/KzqZ9m/DnEWnuid5mGQJa7Bni4+c58oJ04SNRHDDPvu0w7kzl/GFkQZptFXvP+lVMX xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0mqpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 21:53:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TIquFi002854;
        Mon, 29 Aug 2022 21:53:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q3at86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 21:53:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIdCRd6r4GOhXO7tmlxZplrET+4oyJ20IcR21+w2fUOEIyieOwJJocLLk0B8w4buizx6/4l/6ihAOx66nqX4eojNSqKUuO8qEr30NmAYx+O+Y6B5ySo+BnU4++t0PSe6GnoWviWCMTUv56qqgH9Wdw26Kyrit1ObPg6fiQZTXoJpGzMsvg8arAR0ah9KUtlNI95QerwpAaL1aaLksB3S8k5GliflO+uYTg9Om2Zq78WSLWRviaWClIBktj7VcSnvUq09kn83MpMVWze8AJkVeW9xTCD54yh1xtBibmEspjhWYoajq3H/LG/TkgPt1Mq20HcoKzqrhjUTMKRO6LJb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAOIu+HQaGBNFVtVzlXTTu8DixlmpnvDH+t1Tx33Gj0=;
 b=PSJqCbHyOJpKC6oPvY4tVf8cXYfLMG/pqT5hV9qI8+4Fc2NxELqFP6jH6gqblUobqBuRGVYReW3/MEMeVgz2tRUrX67K/eszlpfq3QcPfHde8RBQjsrhthVe65vRF3pSRdd6DRQS6drfhuMUQGnqJqXmJIQ8o6ifeT4TjKGeRfk/brIJctyYcdP58+b9IsBClZ+9uuW19VflT9nUxh8jazIgRSa1TjfvV2oZgyViAzKfNpIjJo+hMoBOq/pSNviQG6Mvf9MHB8oSVjB2ttiIGYv6CPVuqmp2rH52CRuE29vV3+1jYk07jQboTccoD8hkb/hoqWZsQLl82Z0mEuydwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAOIu+HQaGBNFVtVzlXTTu8DixlmpnvDH+t1Tx33Gj0=;
 b=BFgzDTfEM7rtM0DAVVSiFxtlfI+HdpQApWj7G6VRe6kUlAvpxBJllmkRlfaqMz4qNAzs9/1dRkA68V+bV+TRQpIHz7VS4lmWTfPhI5zb/gbm8/3s58n7DtFIK8UK5FInJMQfZz+rE+PhHu20/O6lxnGlqScuis0svwQNGfHyvYA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB4171.namprd10.prod.outlook.com (2603:10b6:5:21f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 21:53:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%5]) with mapi id 15.20.5566.015; Mon, 29 Aug 2022
 21:53:51 +0000
Date:   Mon, 29 Aug 2022 14:53:48 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] hugetlb: handle truncate racing with page faults
Message-ID: <Yw01bD00XO+QQbFL@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-5-mike.kravetz@oracle.com>
 <b26db6af-ffde-788d-2148-2e0992f96229@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26db6af-ffde-788d-2148-2e0992f96229@huawei.com>
X-ClientProxiedBy: MW4PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:303:dc::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd3ee6f3-283a-4a25-2b86-08da8a08f588
X-MS-TrafficTypeDiagnostic: DM6PR10MB4171:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgvOKuRyz74YbXagdx44RRJK2lj5vOVM0KELse9doBdcGGj8qbceF4FHH8zvt75Vgb5uJjplxUYAOS2zodLBK90Ctb6x7JIUgPJ6pSI2zesC9E1eqqd3VrT3GxvGhQ7mehJ2Uf8QL1NvkmJG2NlLAQVUMw7/q9NCZJ/bIYH6CuJIO0joLV8AN53XtK8AeLMA3rR9iBtYVm7dAQn63OJjUdjm2ktWwfZR/bkY05NzlN0E9APwCKfNpjTRY6ce5/0N/5o4PnAs+s1r0wz6RjxnW5wloPoIlhbYYRk7Tn07VcFHY7HLvYaBlvWvJk29QcTHo7u/5Xhqr8ywfIPemOxfvlPGJ8GupjEwlccQjLcz8kHTJKBY+HN4f7F9ziAqNZmz7XIvaToUVfggrlp+9gV+eX+Iit2OtJRMD2sRlMWDY36jcaR9IxYhwFC2s07vHzcZZbHN89Iy0JSOBCGfXDjAQQ+Jbw3wCRj2qw15NpviuuF+haasaDAJbAW1GxC6Dy3MEB4gjpjXhZEKCOE5uMjQm9ibfXj3RORqL7gsFvDJt42pbFMyYXy3C3K5F0LJrL/n+gY6CVXGCHr3LA8YF+seYKVU9Q8TBy//OpsC5uWLZ5OkasNGhHVzgr+PuyweSAcllr1x8ir8jVG/mz5F4Z2ZKm0UFaDtELp3I80hbQcyKnjNqUITKWs2CCzpXY+Y929uWJonfa6pWru1MAHyiJ2d+SYoci84kIQyYdZKekAQd/vHVa9Gqxnei0/xjfFrfZgsyobh43J+uPClCyCU2codU63LTcnnmK3nzd2HWYch/Hj4dT+6MnCb3Ct9IXg91EEt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(136003)(346002)(376002)(39860400002)(366004)(316002)(6916009)(54906003)(478600001)(6486002)(33716001)(66946007)(66556008)(38100700002)(66476007)(4326008)(8676002)(41300700001)(8936002)(7416002)(5660300002)(9686003)(44832011)(26005)(6666004)(53546011)(83380400001)(2906002)(6506007)(186003)(86362001)(6512007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Web57CLl1GR36W97md3QHHVOZAn7G1v1WrX947yiAUkfOGBH0uuh1Sm0H9OH?=
 =?us-ascii?Q?JLrdCjkqLBy/p7M559BY2knWE2rEBpY61kOMNyNib+ET8TBif0hjAMG4rtta?=
 =?us-ascii?Q?vI4/Aq1wiNzxBfZWlTaiaERO4tmKhUR1CQjRXVBul4AZM3ZwPZ9ghI+vYzSW?=
 =?us-ascii?Q?VvJ8BSEANh6P7VUTmhwcnLhGZG+uNu9I79SQeVuTBIERwxh08M1Ds9r6/xog?=
 =?us-ascii?Q?F0zxRlpFlC1QPqnt0xxyFKWXZFosXjFI1wngqtJUFQStqBgjfhwI0Gs7CNJj?=
 =?us-ascii?Q?UtTMoodWbTt+JA84mePwllhfJuAt4PCIk+YmzwwiWvgUKqVRvDSTjJUgrod5?=
 =?us-ascii?Q?hiXwwc7eHR1RYtKOZ86q6sc6CqBbOuqjnWyyQkH8RB2sZIy1qeoGwHRqmYf9?=
 =?us-ascii?Q?OIrna6U++kaxc7+YFCpUVY4/weBvssXXDZ16UYQ5WUctHoyhYYg57MsZu3fg?=
 =?us-ascii?Q?XZzccfhf9WPWdCkY1whXccy82ei7dEM1k+j59YHzlSiHmtzGssjY59/CJ4D9?=
 =?us-ascii?Q?WqTUweLv2VrMslW++9MJh4nEoGLB/WMYLbm8QKSG3z/6Og5JbtJmek68FxlK?=
 =?us-ascii?Q?oVO2Hdy7WBmcLRweUtzvxGYu2jYXwrctf1ROisFlB34A5rt6TMfIJKw9Qi6W?=
 =?us-ascii?Q?wl7QAmx+KLeA91TchTZD7/NzBas1UgqqrGyQZq9E7gw7ZZWDL3bI0p3wxI0J?=
 =?us-ascii?Q?LKZuoGnWbCjj+Csk/RHAlTFF/OtAixhboPvd2bzrzwiqKtDlGR2gPOotk8zC?=
 =?us-ascii?Q?cJFGn4ZmxfHYz3cipoQDqaD+CtOLVAgtkw2xTgmitKMtWifh+V2pvoDETQnp?=
 =?us-ascii?Q?lfffmggKV9R2JYyhZFxwUfCuQb9yq4SHNRae9gINq7/FbHAY3M6J/lGR+F6+?=
 =?us-ascii?Q?jsy+UQo1eMS/8BpTnpAlT07V1R5g7r2w9Q/g0hNGUwHQWwVePV4NBOYlGGW/?=
 =?us-ascii?Q?egrOLawlTI8c3pANKKS3mt6xriLwre8n2koTelLnFid0JeqGAj+1fd9SgFCd?=
 =?us-ascii?Q?A7N0WaGLE+P54aGgusnn1R0EbEoCgaJ2MoK0Gw6PC4axLKdQGHfPx8vSg0od?=
 =?us-ascii?Q?qmCWGunk7keRUZ+JdJnywch7soMJDmbtU99nl6KUkFgT1v53bKwzErYSzDl5?=
 =?us-ascii?Q?VsJTUhsJS5ABwa/CJf2+Fa2B1ZupqwkfGHJStQYfnYWV+Yck2J63T4yMEzhX?=
 =?us-ascii?Q?8+Dt7CSuC2DIxfl+BlhU3lXweKp/6CQElMAzzaI9WaLHePM+VmmaxFhqphzr?=
 =?us-ascii?Q?O51ZNGrjKz6iETJteWOxXsKXeIazZ9FVwTWVxi4FcwTfqFgGVrPQakagFHts?=
 =?us-ascii?Q?jJ7hZR+Ep83jdBkQTHgiTbWxrLAx5nHuC8PX8ro9wbjXTlo07oss3lpJJq+d?=
 =?us-ascii?Q?fo2No6mWrb2HxFXtTtivvl8eJserEkHGKD5trq6eBbOeeGjfwTdoN3WmzmR+?=
 =?us-ascii?Q?k6Oy5GiNnWGJvg1bXg1uzhoKWX5XwROCi+mtrSGMhTc80NETdv6ELN4VoEC0?=
 =?us-ascii?Q?3gwn0RaO3+q3ZYEF1LVc+yftGIZ5sHnMxZ8LuIk2izZN9NCdTL0djakA/i6H?=
 =?us-ascii?Q?gJ4SrROAVO0AkxZJoUonZuOmQ9N6tk/T9pLR2mW0w2ARWhLJZrV0TanX9eaI?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3ee6f3-283a-4a25-2b86-08da8a08f588
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:53:51.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLNOQgdguZL6lsyUhEwIWdi4NrfhffkDXBS0ihnMBjwmxJ8fFKEDN7i67II1He8JoiOe/PAA3ouWjpO6Pl/kTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290097
X-Proofpoint-GUID: 8iy3vQC6JqPiBU6dBNgAa71K_5LTTlYP
X-Proofpoint-ORIG-GUID: 8iy3vQC6JqPiBU6dBNgAa71K_5LTTlYP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/22 16:02, Miaohe Lin wrote:
> On 2022/8/25 1:57, Mike Kravetz wrote:
> > When page fault code needs to allocate and instantiate a new hugetlb
> > page (huegtlb_no_page), it checks early to determine if the fault is
> > beyond i_size.  When discovered early, it is easy to abort the fault and
> > return an error.  However, it becomes much more difficult to handle when
> > discovered later after allocating the page and consuming reservations
> > and adding to the page cache.  Backing out changes in such instances
> > becomes difficult and error prone.
> > 
> > Instead of trying to catch and backout all such races, use the hugetlb
> > fault mutex to handle truncate racing with page faults.  The most
> > significant change is modification of the routine remove_inode_hugepages
> > such that it will take the fault mutex for EVERY index in the truncated
> > range (or hole in the case of hole punch).  Since remove_inode_hugepages
> > is called in the truncate path after updating i_size, we can experience
> > races as follows.
> > - truncate code updates i_size and takes fault mutex before a racing
> >   fault.  After fault code takes mutex, it will notice fault beyond
> >   i_size and abort early.
> > - fault code obtains mutex, and truncate updates i_size after early
> >   checks in fault code.  fault code will add page beyond i_size.
> >   When truncate code takes mutex for page/index, it will remove the
> >   page.
> > - truncate updates i_size, but fault code obtains mutex first.  If
> >   fault code sees updated i_size it will abort early.  If fault code
> >   does not see updated i_size, it will add page beyond i_size and
> >   truncate code will remove page when it obtains fault mutex.
> > 
> > Note, for performance reasons remove_inode_hugepages will still use
> > filemap_get_folios for bulk folio lookups.  For indicies not returned in
> > the bulk lookup, it will need to lookup individual folios to check for
> > races with page fault.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  fs/hugetlbfs/inode.c | 184 +++++++++++++++++++++++++++++++------------
> >  mm/hugetlb.c         |  41 +++++-----
> >  2 files changed, 152 insertions(+), 73 deletions(-)
> > 
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index d98c6edbd1a4..e83fd31671b3 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -411,6 +411,95 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
> >  	}
> >  }
> >  
> > +/*
> > + * Called with hugetlb fault mutex held.
> > + * Returns true if page was actually removed, false otherwise.
> > + */
> > +static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
> > +					struct address_space *mapping,
> > +					struct folio *folio, pgoff_t index,
> > +					bool truncate_op)
> > +{
> > +	bool ret = false;
> > +
> > +	/*
> > +	 * If folio is mapped, it was faulted in after being
> > +	 * unmapped in caller.  Unmap (again) while holding
> > +	 * the fault mutex.  The mutex will prevent faults
> > +	 * until we finish removing the folio.
> > +	 */
> > +	if (unlikely(folio_mapped(folio))) {
> > +		i_mmap_lock_write(mapping);
> > +		hugetlb_vmdelete_list(&mapping->i_mmap,
> > +					index * pages_per_huge_page(h),
> > +					(index + 1) * pages_per_huge_page(h),
> > +					ZAP_FLAG_DROP_MARKER);
> > +		i_mmap_unlock_write(mapping);
> > +	}
> > +
> > +	folio_lock(folio);
> > +	/*
> > +	 * After locking page, make sure mapping is the same.
> > +	 * We could have raced with page fault populate and
> > +	 * backout code.
> > +	 */
> > +	if (folio_mapping(folio) == mapping) {
> 
> Could you explain this more? IIUC, page fault won't remove the hugetlb page from page
> cache anymore. So this check is unneeded? Or we should always check this in case future
> code changing?
> 

You are correct, with the updated code we should never hit this condition.
The faulting code will not remove pages from the page cache.
It can be removed.

> > +		/*
> > +		 * We must remove the folio from page cache before removing
> > +		 * the region/ reserve map (hugetlb_unreserve_pages).  In
> > +		 * rare out of memory conditions, removal of the region/reserve
> > +		 * map could fail.  Correspondingly, the subpool and global
> > +		 * reserve usage count can need to be adjusted.
> > +		 */
> > +		VM_BUG_ON(HPageRestoreReserve(&folio->page));
> > +		hugetlb_delete_from_page_cache(&folio->page);
> > +		ret = true;
> > +		if (!truncate_op) {
> > +			if (unlikely(hugetlb_unreserve_pages(inode, index,
> > +								index + 1, 1)))
> > +				hugetlb_fix_reserve_counts(inode);
> > +		}
> > +	}
> > +
> > +	folio_unlock(folio);
> > +	return ret;
> > +}
> 
> <snip>
> > @@ -5584,9 +5585,13 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >  		clear_huge_page(page, address, pages_per_huge_page(h));
> >  		__SetPageUptodate(page);
> >  		new_page = true;
> > +		if (HPageRestoreReserve(page))
> > +			reserve_alloc = true;
> >  
> >  		if (vma->vm_flags & VM_MAYSHARE) {
> > -			int err = hugetlb_add_to_page_cache(page, mapping, idx);
> > +			int err;
> > +
> > +			err = hugetlb_add_to_page_cache(page, mapping, idx);
> >  			if (err) {
> >  				restore_reserve_on_error(h, vma, haddr, page);
> >  				put_page(page);
> > @@ -5642,10 +5647,6 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >  	}
> >  
> >  	ptl = huge_pte_lock(h, mm, ptep);
> > -	size = i_size_read(mapping->host) >> huge_page_shift(h);
> > -	if (idx >= size)
> > -		goto backout;
> > -
> >  	ret = 0;
> >  	/* If pte changed from under us, retry */
> >  	if (!pte_same(huge_ptep_get(ptep), old_pte))
> > @@ -5689,10 +5690,18 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >  backout:
> >  	spin_unlock(ptl);
> >  backout_unlocked:
> > -	unlock_page(page);
> > -	/* restore reserve for newly allocated pages not in page cache */
> > -	if (new_page && !new_pagecache_page)
> > +	if (new_page && !new_pagecache_page) {
> > +		/*
> > +		 * If reserve was consumed, make sure flag is set so that it
> > +		 * will be restored in free_huge_page().
> > +		 */
> > +		if (reserve_alloc)
> > +			SetHPageRestoreReserve(page);
> 
> If code reaches here, it should be a newly allocated page and it's not added to the hugetlb page cache.
> Note that failing to add the page to hugetlb page cache should have returned already. So the page must be
> anon? If so, HPageRestoreReserve isn't cleared yet as it's cleared right before set_huge_pte. Thus above
> check can be removed?

You are correct again.  The above check can be removed.

Thanks!

I will remove them in a v2 series.
-- 
Mike Kravetz

> 
> Anyway, the patch looks good to me.
> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thanks,
> Miaohe Lin
> 
