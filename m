Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A4D5092FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382947AbiDTWlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382899AbiDTWlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:41:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B8042EE0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:38:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KMaRMD014729;
        Wed, 20 Apr 2022 22:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Fjtd50hbyElPrCVlmLMp+5qxBBYw+mzUQL957qPyfFM=;
 b=V0VhrCtB9K5rlu2B8i6pR1s/FL6618ZIYHn5JYOeOcbDUjM9QYe4X2X31nd67Tu4XP/r
 oESz6bZ4YE4zm+yEIsa9iDOxlukBZBpWrfJGxMlseK7/Rde6F8NHeVQEoXJipo50wbAu
 I7FfbF9t6ehO5jFWBVGNq569XBC19sOd9a3LYJqA89OSEE2kuM8vDPM/whyKtDp4AyN9
 hgwTzu4cHq+kYrfLTwyEXYBg2lLqV4PJUVvMYjDRa2QXpGhmHB4+00JCuUgqIZi3uKcQ
 Elgokp3Y57JQbGlAJzm9ucQelrFs3oSeRhHQMYE01YkfXrNOE53ZR9Zvhg8bielWO6nP Dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffndtjh2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KMQuqM035884;
        Wed, 20 Apr 2022 22:38:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm88dqrw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I51sKDn8mkQne3Iwetsa+PKf+I9Mrj4vihLdi2P7NgQqdST7GjMSJx8YbTKm97Iao0UafMetZplyg4gBMdr7tM+OI/VBdRda03QpYe21RozazI5aUPwmIHSkFaIUblEyBYwS+KZm1wvwxOabZAcIMR8OMkMysmHGV4n0gBypcRv9x+TSl1YU7abFKoh8mqrzUV3GFg9nG87v3hJMfeUEY6LBKbjtOypmmJxXfd4/Ax21rnCyTg32lXadZjKaSSqLqNNsjpPXqVSU4dpOkV29qQHjrZgJ48Al3oGPToV/srxfN8LS6GAHmjnjEj2Z1DeSpfa92ADMnmbhp3bqYQk6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fjtd50hbyElPrCVlmLMp+5qxBBYw+mzUQL957qPyfFM=;
 b=MdwC1kJ8H5hycKL7/q9ILvHb66hZau6hmn1MQkmvTxFptx82jIQRmZm6Ed3TsMmq489keSHxpFXTqAnG6UbKE7dJaI3wonw27YTQb25rFNlXh73nYn4y1gtXul9g6LsBDU9NPOSul2iTTF+lUOiv7T06qGVSIt8le5v8JQ6KX+FChjxRX4bLAMGaesfX1tvDdV/JFAo5hqJJihAYSQkm3Btoo4Snqpxs7rTQ/hz9rqcaDIaEgoLnDlaYCyhjLb+1A94+ygJWegkQnqq7hF+PLPXPQA5oJxoehZBPQOACw0Xe4elIJSf1GJnJiW8wj2q4ycky6tR1qGdBAdeQ4o4PPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fjtd50hbyElPrCVlmLMp+5qxBBYw+mzUQL957qPyfFM=;
 b=i3nsQPKoAqiQQYQeYWQcbhYTvgmex8I+EkrFGSOhgU7HkCzWTn2wGXVnDXG6VjCxS6xipK+NCO8rSX22HTjiRVT7bQKaDJ5HnflylyWt18VNS1mULANc2OzCpthF7a0sFEs4AeAmLXYijn69VosVpXeTZ/hcDqMEY3lJ85ciO18=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4550.namprd10.prod.outlook.com (2603:10b6:510:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 22:38:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 22:38:19 +0000
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
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH v2 6/6] hugetlb: Check for pmd unshare and fault/lookup races
Date:   Wed, 20 Apr 2022 15:37:53 -0700
Message-Id: <20220420223753.386645-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420223753.386645-1-mike.kravetz@oracle.com>
References: <20220420223753.386645-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb557698-c1f0-4290-17fb-08da231e77d3
X-MS-TrafficTypeDiagnostic: PH0PR10MB4550:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4550B9C5CBCD63C4BE3B0687E2F59@PH0PR10MB4550.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PutE92cbaTnRNABJXXLQpOg0QaLCI2qjSgoMdJMLShY9dve0Dp5RA7kJpygZzYhSuz/tZPPQDbPgOKa+2pKoRrd/ufdUe0MvNlGQeRAtvCdO9CgayNiOt0vDU9Yl7Z4t5z+yWpWgR4EcESkx9fGxD9kZhOnxIPi77dIt9eLCEleTr23S79t2YBQ68fgPBHW2ti1QNB6wJtzOoROy6+IU1vfumd/nuKT3KqZvK0wRHEkyJy98RmzZGfH4LOSZIaGo1cvP4aSD60kwOoNTUkvzE35SYEZr4KwDq6M2+Qv13X4j/Pr6y0cuQk7SJPv2s7TLDNzDXFIMZG0rPwqdOfZU/ri3W+72EjR2yUL2EcBklm5vI0HPy9d/v0xKfDcEddxEsFyvtKOtc3kGYhRGbfD35TXm0s81GjSmsX/8u3pqKw6zEnmNzdcwiF8faRNNFEBuA64sn2OEtiEo7JJS53ZpyBv5nA7pKI3CTf2bqlrTTVJka+S1yIZ8SwE8hcwfDKZt4Qz7RscOzeAPKrk1+b9nvtY/8iawVY4Rp4QqahfdWYF9ZSloYAb8DPMY+HPmShpGHFcg0pyz8v37mPoiSJxPvlPv2kHQ7HLIzm6T8vFSOnO31TLiK0D+SABnf/dzXHi2kw7ZHhwh/wfFpCs6LiKV7G+HxgqMxLi8KFKe20zVhh4kkocD3rO6y0eUcIUtZdMChM4nHvbjDNoMojZLJKAN4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38350700002)(38100700002)(508600001)(8936002)(54906003)(86362001)(316002)(186003)(52116002)(66556008)(36756003)(83380400001)(44832011)(26005)(66946007)(2906002)(6506007)(6512007)(107886003)(4326008)(1076003)(5660300002)(2616005)(6666004)(66476007)(7416002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6L78Ue2IAog36YEqx0c1rxk4M1FZzuBWCtBS2cNaWDEoZ8F0KSBAnd4Jr2Dz?=
 =?us-ascii?Q?l6ilzs0ZxMrFdRXE39NPusc0opPY07ijC6A8pBpsllJM6CdM2du8RUbkUZgu?=
 =?us-ascii?Q?AN9/ZuBdqP6rjMAA2F4J+8/QStiUVNRZK87H/lWcwdDh5EAVJrZYzdpwtOS2?=
 =?us-ascii?Q?lN+51FSjQjwi1GyN5YbuE8eLlTp2GtshQSq6LdgA8hcuu50xWkkcQroVnAc2?=
 =?us-ascii?Q?Rw6PpUwayE/Jq1QI2KigujIV+OCuNbDEkhxeNSv4d/ecEAT8CCjEs7n3C7kG?=
 =?us-ascii?Q?VQEk7WCTgq1LeI86R0yW7jPUq7MKP44X7auOPePayjOfH3EwxE0Pu3X4f6ET?=
 =?us-ascii?Q?1s7frH51wNPBcM0ItFJaLKGBNGt+1CAMtmztcOLJbTvfTEJxDdBDWQQ7JzXl?=
 =?us-ascii?Q?ZvpijZ/c1y/BZ4AcYSpVc9Zvx4AUJGSibWLQCW/MHIsi8coi5g5D90XE1b/U?=
 =?us-ascii?Q?M/a92denikxLANXFSysDfanC+pbSwBY9uCun9fw/qWpsPeQ+zAFTJv512BoT?=
 =?us-ascii?Q?s8Lsb+ykam57Ut/Od3yiKcPCIQ+r9k9Rrudh/FJ5AevDH1NYAS5jQEgs0FHx?=
 =?us-ascii?Q?eawQA3Jme72cSX1k7SBRuMykdU/om03xkL/mdZx92GJ+YF2sz7h0fqqejbX/?=
 =?us-ascii?Q?ShbGEPEdkfqnydOo5UzLykkrKh5jPc5Vlc3td7jZGBo1lLM9hu7vmT5TNMr+?=
 =?us-ascii?Q?dNoSKqIqB21RsPM2LGe4Dbefne0jfGWFQCR4IqOfBrinCso6jBqGHGIiGnd2?=
 =?us-ascii?Q?RkVEJyLlFf5edxiIzAaWweLfYa6nj9ixrALR/TOGen7yCnTKhhRccVo6vpWa?=
 =?us-ascii?Q?siqRTqJD8Az0vgbVuD/vz+17J1EZu1HfIT0YkeBmlCyFwPsYm555EVPP4UXb?=
 =?us-ascii?Q?HSNCYnMUfG0kVYTE0Lvupt4hA0Nc4kZrKrech3wgMTm/8cNHAj+TuxQuZxLY?=
 =?us-ascii?Q?vV5wcnLgyd2ObJQ4AvCYOtRtGx1T3WWVTJbcZFFTGPNlIGHNQFjHkJNT176i?=
 =?us-ascii?Q?baNnIli7iMpBLVAdvsu9CWHwXRLOECn8xB5vCWsPjUeaIk+zA6mjeI/vjIOy?=
 =?us-ascii?Q?GKt2fQ4+CwuPJojspYujufVHuXtA1LDWzEAsn2QLALj53r+fK/jaG8ZDPgUS?=
 =?us-ascii?Q?C6CJORuyrx89ZUVgJpMunwG27Mc+bIq7iGGR3DxEe2RfrSePbQKKUiAoIXWp?=
 =?us-ascii?Q?O2MRfBxzL2xmaNo4YnBVZToCqV2LbDSdv0aKLzzlnLHdhJpssLv0ujHCC5UU?=
 =?us-ascii?Q?qjWgZauZDF2GpTCSYfqgo6TTW0tC2auQaHs+A3heQysfb0GRtlmoy1PHmlK0?=
 =?us-ascii?Q?oV/v1rGszFWgtdL0nsBJdQ74JuMbJVmEE9gz+8fQokiRWawNnnZYhDeOIPbn?=
 =?us-ascii?Q?JcKXQxtUr1Rh/6jlslh3NuxEANSLIQxPZKempASGO6Gt3gA5sLWhw2iy63hX?=
 =?us-ascii?Q?mybnjZsrztlihF87DC8OGpWAMko1Kmd0ci20az5Cw2h8fGxoP8EHcn+80YaA?=
 =?us-ascii?Q?A/JfFBk9jouKTtOHUxl+3OH/tr0j6bfReNJwuDI/LZfHqDJCFiLuaUIjlvxK?=
 =?us-ascii?Q?fDeGX7j19IHP0NAN02czVuOWMPXodGkwExo0cMg4NbL4/n4w4/euv08AiZ8Q?=
 =?us-ascii?Q?SJLGL6k3A1BzHRRMy1h7rh22Eb3qn1/n6WOl4Pp1mTyHLbRqRUgKpOGBuY2f?=
 =?us-ascii?Q?IxfMmWNWpt8qPuNY7iOdZpfH5MIx5TziqElyMSag+kLvMRVSlDkUR++sNXC/?=
 =?us-ascii?Q?G+dQ0S8i5hmH1W/MycmigsWIF8Oah8c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb557698-c1f0-4290-17fb-08da231e77d3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 22:38:19.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k12veRuQYD9eTaal0OylxzBgK7ZcE5M2kPPWW68k8XCb5LCfHRpdiAp17SwJz9i8Z194imoF9P6GLRwFYh6SBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_06:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200130
X-Proofpoint-ORIG-GUID: FnSZ2ufbAxcFIJmcwGAMgOq6h0WDMfSP
X-Proofpoint-GUID: FnSZ2ufbAxcFIJmcwGAMgOq6h0WDMfSP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a pmd is 'unshared' it effectivelly deletes part of a processes
page tables.  The routine huge_pmd_unshare must be called with
i_mmap_rwsem held in write mode and the page table locked.  However,
consider a page fault happening within that same process.  We could
have the following race:

Faulting thread                                 Unsharing thread
...                                                  ...
ptep = huge_pte_offset()
      or
ptep = huge_pte_alloc()
...
                                                i_mmap_unlock_write
                                                lock_page table
ptep invalid   <------------------------        huge_pmd_unshare
Could be in a previously                        unlock_page_table
sharing process or worse
...
ptl = huge_pte_lock(ptep)
get/update pte
set_pte_at(pte, ptep)

If the above race happens, we can update the pte of another process.

Catch this situation by doing another huge_pte_offset/page table
walk after obtaining the page table lock and compare pointers.  If
the pointers are different, then we know a race happened and we can
bail and cleanup.

In fault code, make sure to check for this race AFTER checking for
faults beyond i_size so page cache can be cleaned up properly.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c1352ab7f941..804a8d0a2cb8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4735,6 +4735,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *src_vma)
 {
 	pte_t *src_pte, *dst_pte, entry, dst_entry;
+	pte_t *src_pte2;
 	struct page *ptepage;
 	unsigned long addr;
 	bool cow = is_cow_mapping(src_vma->vm_flags);
@@ -4783,7 +4784,15 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		entry = huge_ptep_get(src_pte);
 		dst_entry = huge_ptep_get(dst_pte);
 again:
-		if (huge_pte_none(entry) || !huge_pte_none(dst_entry)) {
+
+		src_pte2 = huge_pte_offset(src, addr, sz);
+		if (unlikely(src_pte2 != src_pte)) {
+			/*
+			 * Another thread could have unshared src_pte.
+			 * Just skip.
+			 */
+			;
+		} else if (huge_pte_none(entry) || !huge_pte_none(dst_entry)) {
 			/*
 			 * Skip if src entry none.  Also, skip in the
 			 * unlikely case dst entry !none as this implies
@@ -5462,6 +5471,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	bool new_page, new_pagecache_page = false;
 	bool beyond_i_size = false;
 	bool reserve_alloc = false;
+	pte_t *ptep2;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -5510,8 +5520,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * sure there really is no pte entry.
 			 */
 			ptl = huge_pte_lock(h, vma, ptep);
+			/* ptep2 checks for racing unshare page tables */
+			ptep2 = huge_pte_offset(mm, haddr, huge_page_size(h));
 			ret = 0;
-			if (huge_pte_none(huge_ptep_get(ptep)))
+			if (ptep2 == ptep && huge_pte_none(huge_ptep_get(ptep)))
 				ret = vmf_error(PTR_ERR(page));
 			spin_unlock(ptl);
 			goto out;
@@ -5584,6 +5596,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		goto backout;
 	}
 
+	/* Check for racing unshare page tables */
+	ptep2 = huge_pte_offset(mm, haddr, huge_page_size(h));
+	if (ptep2 != ptep)
+		goto backout;
+
 	ret = 0;
 	/* If pte changed from under us, retry */
 	if (!pte_same(huge_ptep_get(ptep), old_pte))
@@ -5677,7 +5694,7 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags)
 {
-	pte_t *ptep, entry;
+	pte_t *ptep, *ptep2, entry;
 	spinlock_t *ptl;
 	vm_fault_t ret;
 	u32 hash;
@@ -5759,8 +5776,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptl = huge_pte_lock(h, vma, ptep);
 
-	/* Check for a racing update before calling hugetlb_wp() */
-	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
+	/* Check for a racing update or unshare before calling hugetlb_wp() */
+	ptep2 = huge_pte_offset(mm, haddr, huge_page_size(h));
+	if (unlikely(ptep2 != ptep || !pte_same(entry, huge_ptep_get(ptep))))
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
@@ -5861,6 +5879,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	struct page *page;
 	int writable;
 	bool page_in_pagecache = false;
+	pte_t *ptep2;
 
 	if (is_continue) {
 		ret = -EFAULT;
@@ -5976,6 +5995,11 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_unlock;
 	}
 
+	/* Check for racing unshare page tables */
+	ptep2 = huge_pte_offset(dst_mm, dst_addr, huge_page_size(h));
+	if (unlikely(ptep2 != dst_pte))
+		goto out_release_unlock;
+
 	ret = -EEXIST;
 	/*
 	 * We allow to overwrite a pte marker: consider when both MISSING|WP
-- 
2.35.1

