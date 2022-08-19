Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F149959A621
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350731AbiHSTLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349892AbiHSTL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:11:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FCB10B511
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:11:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JInrLL006441;
        Fri, 19 Aug 2022 19:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=YBiKuuKKVjRgzu+hmNOTwshyEAmgaXyYrZpQelZU8MM=;
 b=dYniviOqUCdz4FxL7FI1/f1RgYS7huDt40xPOXDK9ZSZjrGBsEqhGMkNZNjjSu+CD5Rh
 1Tue+k/JIX9TZUxSwgyBZBAcnkX4QRKdpaRxzmAArfmxupxfutTiMWDOwmmqdRNha74P
 1thoY2l1N2gyHM5jMjvTd6VVxxGUCd4kzzfzy3+o3wMA6YJSe+Xo3fwJF/zPm0S46iBs
 TALo8Ec7aWkyXXH/ruoBNNXVUiUQckP5WzaCHLoBgRMZEL2FGBLTAmXfNoTrazeNxsmz
 4V1n4EoaX+/M8Lr1nu5E1bYUdTMv2Q1sE3/Nk3I2JANk2xRTIg0nzaG3GCtXqaiHzkWM ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2g4xr1a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 19:11:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27JGN6V3007894;
        Fri, 19 Aug 2022 19:11:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2dbswsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 19:11:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRIJuU06bt3fzK4cq2BAgCYxQPNGWqUxbNNKthkOGvEVswY7D4Eaejq8DLTPNE8cFvGQNXqDvVQ/pZiMlkQVDcbRvSB+dsxp4V+gc7sCn9IYJlxSoQEV77xiV/3tCQkVEgeighB2Wtg4frReaDH8b7djCif/TctLlO3Ptff0laN4r3wUGTRXjwYbNO8iWfT6JFe5cJt60is9dsz9u81XVgQs94iFxxzLPK4f8Sv09joTN0egh5D7OLefqoyYTwFunG7fNcX2DymlOgYCfcTQN9L6Oa50pkD7NpzsigVl8wlPkNttHYJoLR21PmBJk9LttQr1iQ/83DE3iPvsOvLVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBiKuuKKVjRgzu+hmNOTwshyEAmgaXyYrZpQelZU8MM=;
 b=AoLSX70SLAjoRzidVyQ+xOLj4mjK69q9Q9P8O2os+jPXxFn2YCJs8Y/EyclTxDVT0cVSSS7a3+bXaVzwCuncqJ9VBhPGRmsg2D6eI2wuhyIhNl4aWcMyfti3kLlOqP3/kLULN+TqPwvdNbkrpegvEC8oHjhku+KDS7N+mZl7HzGY69s7gjxL1Bw8KaYX5gEd0lqxV77fxpE8K1NrSWS1IqOrXspnw+LoQKlSGIGAmo1LLTCArPr0X7mun/bIG1qOmotVL4a1c7Xu15tDCjnetp/9IIXVvKtle28pJtpv1ah/Gs+2H3rrQWAT1WiGFKIlDxLUJkFMJXeAWM3Ej7wAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBiKuuKKVjRgzu+hmNOTwshyEAmgaXyYrZpQelZU8MM=;
 b=LTnTmQWgMEHUV7eUEAmziV4zrMpQ8kcxFadlCbu1wPu2M1kfPipjaM0QpAbMR9ogTza3S8fhX2h0WUipwjxkLq1SmkBevcq+MddfT/Pqk8143BRksAMu1ubABAFlRkDvUsfAMaj1DPUD39t9iRn2FH7MYq66IlkfmZhSS/rxsuA=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by BN6PR1001MB2274.namprd10.prod.outlook.com (2603:10b6:405:31::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Fri, 19 Aug
 2022 19:11:16 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec%6]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 19:11:16 +0000
Date:   Fri, 19 Aug 2022 12:11:12 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] mm/hugetlb: various bugs with avoid_reserve case in
 alloc_huge_page()
Message-ID: <Yv/gUCt+ayp/KSoO@monkey>
References: <d449c6d1-314f-5b90-6d68-3773e2722d7f@huawei.com>
 <Yv7AlZyNaAgpB4Qg@monkey>
 <5b1b60d6-e699-2330-0b6f-14c8dd5d78d4@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b1b60d6-e699-2330-0b6f-14c8dd5d78d4@huawei.com>
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a257b3dc-910c-492b-8864-08da821696e0
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2274:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oc1LVcR9b88t9ZjNN1LX/K0kDTFs1G63VmV+RyHkMYSKqjxhE5+Ihwfu/VNKb/kQRRaw8+px7frw56Lr8lyW7NfxQOiORNwai75p1/QNJVByLHl/NvGf0cUhxK5g300EHLSUn3Ri4Z6DrVBi+1JWYfr9MKTEfxZkK5cjS2HjHOKiiqhu3z87m+Bff80qr6c2t8UYWD+2VjEo+7zvQf4SxVNYvWA9DdYOm+htR/uiDeqZGT5syQ6R4K4d7nvT8iCzfJbnaaLzzHoCCXfs1F9r+UN1n0Ft08W2TWv43zaz47Tt5RHq93U5sFyAZZJnE6+8iDAG/ntrxEkitYkkRmHprGxQSmaZbZZtgPYyBGxQJN37COnE5d4yBMm4Ma9R8yZYFRZTOfnH8l77F79gZP0tOOUoGuIwILWiaZCa6gD8Iw6GFBRrkvUXf7/+K+jCt3k9+NjxnAVkKwvtG/5DcdbjtU9LFQgSvQ3tA4FFZt7Kql7kggfbjwUpuyhlbhfRwKfdhZR/PXDZ8aoIJhck6zYLn568zrP8GzIGbKFuwUxZ+s9TkcumIiP8lFgDO0N1C4PUnkqEZPfjvncDecOhBbJT8cpAVdEqxApY+lRI/tlifTebQaHD0E/FM5Cx4G3rqg7gpqA7Gk6cVUo3j921r8u6UPzu4xKdH8dFWBJWhrz9xEOK998LmyNdhuPCNKwQq9mW2ZCF2rCNKENtvv6YwAvMSvf2dKA4PzveNjGvX232iLOmCo8uFA5hB3wazbuLRhkQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(376002)(366004)(396003)(39860400002)(186003)(83380400001)(5660300002)(44832011)(8936002)(4326008)(6666004)(8676002)(66946007)(33716001)(53546011)(38100700002)(6486002)(6506007)(6512007)(9686003)(6916009)(316002)(26005)(54906003)(41300700001)(86362001)(66556008)(478600001)(2906002)(66476007)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0TEk//BMUde5zq1beB3GM+2x9jIAkfBBLKx0tlmdijLq5H0reh440wGMi9v?=
 =?us-ascii?Q?GCJT6aXpiutD9afDECv1jGKlq5+N04dRFyZjRRAoZjIOz3g7qbnmZRoYi2qE?=
 =?us-ascii?Q?lMTIitMzTo9w8SfbIkW4eb/IEX4oK8wt3mIYf0yBvdQcIkOYPE6CKv22CNLf?=
 =?us-ascii?Q?TJLqvN404WgAT2JuigVSRuIhn/DQZuE0lKVYfNp9DlvshZXptEfovApGOC1e?=
 =?us-ascii?Q?4/JouP/HtYgfNg0XP+z5ovGg+cM9BTgBSuC7gX29msjajAsDCQdPSZuT42fO?=
 =?us-ascii?Q?qan7keOtZKMG4SwWp31nNemiwnVtGrjNnQTheRatedKgZHGwcGfy7hzkQnYN?=
 =?us-ascii?Q?xv3URGILbHKK44oHiv8EX/7c3O9hoou7k7VstrYVbZZQiG3bVNz3SOCVcL8y?=
 =?us-ascii?Q?eQmaG5MY0hz1UxzfT34lKTPLJ9AAwERu8DXJfm45xH2eEFxp90bDj7KkNlLG?=
 =?us-ascii?Q?BbuRNSmjJ08tJ1DmmH2TbMV/fgU0lWyqshZ+2xO0GEm8BBDsw80Nw2ERxtn8?=
 =?us-ascii?Q?dnzhgdKQ3kThIxjT0ZSHeseQXW32CZC9m5b+UUft3GrsnoZDPSxhh75kXCoJ?=
 =?us-ascii?Q?j15wS7jARSj1ZTjpSwgazfWjER5EpwwbbDZKvMn9+3mpavOQy1OllZixOfRF?=
 =?us-ascii?Q?A7ajPZ/ZCZvii2hpnSECInniqH08LEzAqBvB/xn6HAWSsLghOVP0agS10M0A?=
 =?us-ascii?Q?Qa/IXKLLI2sQ3FD2VxJRkZtmBRag5jIV72e+gGOeqJGPu6oidfv83w/gcVzm?=
 =?us-ascii?Q?luFOcGyU+hGfQ1G1uPAvmzP2uxIso/gatg5M2/WJMTDpXKECc8yDjiPjq5KY?=
 =?us-ascii?Q?RsIduMVT6VNPzUkrc7JKx3IicvI3Af9my3UH7bfWdBs8cnBBsXfgkNmPGAJO?=
 =?us-ascii?Q?KyVwCCee5jxRQiBRKFsWJBmL5nwqPt+NtrBlfruDkOq6SeTrjJR1PEh5F4Qt?=
 =?us-ascii?Q?ZUR1wk/3mf60jZvjANi/jDV/hjn3iW5nOWJT9Rs1P46c45E+7iKGKqXFOnKo?=
 =?us-ascii?Q?GdD0VjYEl6DQwNPuYWFpezYUmvBlymp1s8F4m6mRvdO0S3yltar2TMRSHokf?=
 =?us-ascii?Q?KwrEeO6PPCeURM66pjwz6YGjTB8qy6eJj3+JPn6h/sD1hLSuntBLC/TfPbEJ?=
 =?us-ascii?Q?AXBsIGTKxd/V3BXuNHaxlyxn0LmekaPNa0AcYQzO0LKAz0E2z1SMGjxdVdyF?=
 =?us-ascii?Q?g1o4sBlz03mT5oU+ifzmtwE4MZ/3xiHwKt5B6Y+5frUY0ufo8e4dVJqPfDJj?=
 =?us-ascii?Q?TbSt9cjhUPCvdin2oykt7hYe5IlRkuB9zYbOVqOBcIKMd11BqnTj/pHEqTbS?=
 =?us-ascii?Q?iSndCjPqLOGiynBqKs6ExDR7ANi/TwVFc+I6cx2JQYr39d0wb4iRXRwbL8Aq?=
 =?us-ascii?Q?0p3FQxJKAGJYl0KFtzcZScLpgohfU9ubB0s4HKKGlZRsA6Kr7p7j6M9+T1Hi?=
 =?us-ascii?Q?WyvdzssW1kcrVra8j/oQbHinVq17XBqxlJeAKujvrouqJyRqX7un2ASUDt88?=
 =?us-ascii?Q?vIzJ+lvQqiuvLpqHS8ONqYSC01yw0G6qZfoyhnu+rA6DMdNtyl2j5KV+29Jm?=
 =?us-ascii?Q?KkfQXqVSBOgM4gPZC5mnyV3isRjvyc0PcaJBsE5WU6jqtYFf3H3BuFGa+E9R?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a257b3dc-910c-492b-8864-08da821696e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 19:11:16.2284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MBk/b3cx7ZBF0WJbpxUJ2PvNrjPnkx6iv0Syv27ckT8p8BQber1FLv0DtyDzqeWGkz47lo1EcPxGDIMKmyI5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190072
X-Proofpoint-ORIG-GUID: 1iAmj-FG0QEzNLbcHFQPEEG1u3z6WbJ3
X-Proofpoint-GUID: 1iAmj-FG0QEzNLbcHFQPEEG1u3z6WbJ3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/19/22 15:20, Miaohe Lin wrote:
> On 2022/8/19 6:43, Mike Kravetz wrote:
> > On 08/17/22 16:31, Miaohe Lin wrote:
> >> Hi all:
> >>     When I investigate the mm/hugetlb.c code again, I found there are a few possible issues
> >> with avoid_reserve case. (It's really hard to follow the relevant code for me.) Please take
> >> a look at the below analysis:
> > 
> > Thank you for taking a close look at this code!
> > 
> > I agree that the code is hard to follow.  I have spent many hours/days/weeks
> > chasing down the cause of incorrect reservation counts.  I imagine there could
> > be more issues, especially when you add the uncommon avoid_reserve and
> > MAP_NORESERVE processing.
> 
> Many thanks for your time and reply, Mike!

Well, hugetlb reservations interrupted my sleep again :)  See below.

> > 
> >> 1.avoid_reserve issue with h->resv_huge_pages in alloc_huge_page.
> > 
> > Did you actually see this issue, or is it just based on code inspection?
> 
> No, it's based on code inspection. ;)
> 
> > I tried to recreate, but could not.  When looking closer, this may not
> > even be possible.
> > 
> >>     Assume:
> >> 	h->free_huge_pages 60
> >> 	h->resv_huge_pages 30
> >> 	spool->rsv_hpages  30
> > 
> > OK.
> > 
> >>
> >>     When avoid_reserve is true, after alloc_huge_page(), we will have:
> > 
> > Take a close look at the calling paths for alloc_huge_page when avoid_reserve
> > is true.  There are only two such call paths.
> > 1) copy_hugetlb_page_range - We allocate pages in the 'early COW' processing.
> >    In such cases, the pages are private and not associated with a file, or
> >    filesystem or subpool (spool).  Therefore, there should be no spool
> >    modifications.
> 
> Agree.
> 
> > 2) hugetlb_wp (formerly called hugetlb_cow) - Again, we are allocating a
> >    private page and should not be modifying spool.
> 
> Agree.
> 
> > 
> > If the above is correct, then we will not modify spool->rsv_hpages which
> > leads to the inconsistent results.
> 
> I missed to verify whether spool will be modified in avoid_reserve case. Sorry about that.
> 

That is how it SHOULD work.  However, there is a problem with a MAP_PRIVATE
mapping of a hugetlb file.  In this case, subpool_vma will return the
subpool associated with the file, and we will end up with a leaked reservation
as in your example.  I have verified with test code.

The first thought I had is that something like the following should be added.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 474bfbe9929e..5aa19574e890 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -254,7 +258,9 @@ static inline struct hugepage_subpool *subpool_inode(struct inode *inode)
 
 static inline struct hugepage_subpool *subpool_vma(struct vm_area_struct *vma)
 {
-	return subpool_inode(file_inode(vma->vm_file));
+	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
+		return subpool_inode(file_inode(vma->vm_file));
+	return NULL;		/* no subpool for private mappings */
 }
 
 /* Helper that removes a struct file_region from the resv_map cache and returns


That certainly addresses the MAP_PRIVATE mapping of a hugetlb file issue.
I will collect up patches for issues we discover and submit together.

> > It is confusing that MAP_NORESERVE does not imply avoid_reserve will be
> > passed to alloc_huge_page.
> 
> It's introduced to guarantee that COW faults for a process that called mmap(MAP_PRIVATE) will succeed via commit
> 04f2cbe35699 ("hugetlb: guarantee that COW faults for a process that called mmap(MAP_PRIVATE) on hugetlbfs will succeed").
> It seems it has nothing to do with MAP_NORESERVE.
> 
> > 
> >> 	spool->rsv_hpages  29 /* hugepage_subpool_get_pages decreases it. */
> >> 	h->free_huge_pages 59
> >> 	h->resv_huge_pages 30 /* rsv_hpages is used, but *h->resv_huge_pages is not modified accordingly*. */
> >>
> >>     If the hugetlb page is freed later, we will have:
> >> 	spool->rsv_hpages  30 /* hugepage_subpool_put_pages increases it. */
> >> 	h->free_huge_pages 60
> >> 	h->resv_huge_pages 31 /* *increased wrongly* due to hugepage_subpool_put_pages(spool, 1) == 0. */
> >> 			   ^^
> >>
> > 
> > I'll take a closer look at 2 and 3 when we determine if 1 is a possible
> > issue or not.
> 
> I want to propose removing the avoid_reserve code. When called from above case 1) or 2), vma_needs_reservation()
> will always return 1 as there's no reservation for it. Also hugepage_subpool_get_pages() will always return 1 as
> it's not associated with a spool. So when avoid_reserve == true, map_chg and gbl_chg must be 1 and vma_has_reserves()
> will always return "false". As a result, passing in avoid_reserve == true will do nothing in fact. So it can be simply
> removed. Or am I miss something again?

I will take a closer look.  But, at a high level if avoid_reserve == true and
all pages are reserved we must fail the allocation or attempt dynamic
allocation if overcommit is allowed.  So, it seems we at least need the
flag to make this decision.
-- 
Mike Kravetz

> 
> If avoid_reserve code can be removed, below issue 2 and 3 won't be possible as they rely on avoid_reserve doing its work.
> 
> Thanks!
> Miaohe Lin
