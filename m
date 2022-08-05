Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8EF58B2B0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 01:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbiHEXIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 19:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbiHEXIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 19:08:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EDF18366
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 16:08:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275MSlda018541;
        Fri, 5 Aug 2022 23:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=uLUrSuS2douUAqlMe86idx8hRf1Gb94xTu04V6VeISQ=;
 b=KFAZQQVsHTZa/MdZYjFN0AeNToR9t/XBvJ+ectTvBOhBLCmKpsTzU4zWyV6N2Ekkkl77
 OwFgr8nFKDoKg6P7piq8cm+bw2A/gLa6YUCPcfylfVxRVEVEPQJr+gmkbeU11/44vJF6
 px40e1t7WFh6FBS+cDClviIY0HvkbOlTF4hoSRTAHPWW3mt9XGfNtp4QywDGgnQg0PIH
 t6if7ReJeMgynPTiqNjF0uk+eECZ5dwVgSfTaIJIXFOsJT6ZkTfhw9xOn0fM/rAlTb78
 eq3DohflYTt/39NwwIVDyz4GHQQ7yD+K+xSuyvlDzILrN1OOGnSFIYuJW5WV/616rrvA rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvha0kgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 23:08:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 275M2QG9002962;
        Fri, 5 Aug 2022 23:08:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu35v5au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 23:08:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrxUIOQ+dhHZdOAjB/luD8pqAKnfA9/aSDm0eRhRbEovMKTtLBdpZXMsmygJAxZyC6EPYcma0CNDfqXXGCZ2Elr4K8kcFAkvUzic6vQFMNC31+EXZxgwaDdaofqe937EkCoByC0Bpf3XElkCTf0OfRtNdnhojA9UKWAzTmeQXWA07TzbY54jFo8XGlheo8MAWtRzLgsw1avhXkWAbN686eFtWl2zOaU+FTkYxFr3rzWlRUDG731FquX1vluuNZdIu/RqbUP0dfuSWN3fZBfkZ52/mOc5do5eKjy6PZTfdDAdowq5vAC77B0++aYOQNsweGnEs15BmZjBHNdtn8di9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLUrSuS2douUAqlMe86idx8hRf1Gb94xTu04V6VeISQ=;
 b=LKvvII1mdlSKINsu3TvaKdKye0Nh3KFLWayP+0+xOWwxE25L7ZlPH7BD7bwTncOQQs2VA8Nwt4bzI0+LaSAVx1jpxEeIIMy4Z4DnhdD4QXrDfUwbElYWvrUfwg8D6gZ3o9kbLKqxS889Eg861pOE/LHc9a2CcN8ETK0CxxaJSY8FlygkRVeJusqpxQu4pELK3bpdAy+UB2Om+1uCqTrGQ9N8Nl71z38UsOAq5PSIFVs9E0w9WnftvIhaMBjlr//MEknnUx+3p+iOz14mLN6D6xxqDiylKHPDfsUIGwG9Gst9oGgQZ44SR1aYgN4xA7Ke59n1Dzi56nh13MwS5YWLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLUrSuS2douUAqlMe86idx8hRf1Gb94xTu04V6VeISQ=;
 b=vZjyktbSCZFjXlb6jqm1/2ECO4WCKGfGo26K64h7ddFQ3ClJabWT0QZwmY13aCZDaM0WpMU7mXWzXAs1i6aWNPlcxayWYe+WfXA1YqWVveFyJAZKCr0nee8LsJO/46o8a2hlUaj7YqJZtg5sFJ7mXWXl9XwtMikEH7DFrHnLdrM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB3853.namprd10.prod.outlook.com (2603:10b6:208:180::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 23:08:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 23:08:11 +0000
Date:   Fri, 5 Aug 2022 16:08:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 2/2] mm/hugetlb: support write-faults in shared
 mappings
Message-ID: <Yu2i2K421LgaMyxp@monkey>
References: <20220805110329.80540-1-david@redhat.com>
 <20220805110329.80540-3-david@redhat.com>
 <Yu1dkZeBwv0SUQMq@xz-m1.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu1dkZeBwv0SUQMq@xz-m1.local>
X-ClientProxiedBy: MW4PR04CA0284.namprd04.prod.outlook.com
 (2603:10b6:303:89::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d4c3e45-01b6-4ddf-e4b3-08da77375dda
X-MS-TrafficTypeDiagnostic: MN2PR10MB3853:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcNZ90V0mxfjAVUPk0DwbFArzxOxjfMTpEO/VqUL2WEw2IP03XUiNtZB4PWB+vVu0+ADyfrCaAg2qv+XOVbJrjKirMPxKC6KYB/2bJtOeD56DXiemcMKa4lv1AGFbWBTufvhl3nreIeD0eqx4cPCuHZTUo8QAuDGD968+bC2I8Fk1DAwMJrksG2MXHLdRtUkx1ARu9X2By8WpFP4Qfyv3j0FeAhcdTqmYN+u09jvp/tMGX4O7rX5XKNUQTnOEDl6G5Z98iZXGheAD9xqTaqXbn9YCRZfYss0oOzjUtReYOJBjmW0ia/jLGfVyhmDj3KKqL2YN4UatqKzGPX19kKint7BUYuAppdeZ3zk2p28fOuwVUdxUgfSqmWmqD9HIXvdwWT9cUHfV91lbBs7JmIksMZJm77iVzRXiX0TUoU7pB1STK2Dq+cv9+DvuXVUUochW2c7r5wQd1FLUPhjZbemQLjH8JltVnckcnRdzKxRKhFbBTZV/XF3oN5w8U03QUr4lQ4PRRutFi8VqpaLC4HEauXNxdmAM9AobUkm7TCbxzaCEbev5qCApthGhc4/Jon2I5YMdSILkV9AObu2deSE1OfVhd9KcB6nxgxxQTfqRXtQOWpGEBkS3+KGHJbtGaO6lAenUWN+ol3du9FBGBUPkjA+1HuosIhuwsrhk/73pm0sDKRllC3ufLpWthdOvCz6jWx7uYpk8FteIFcRvKKhnrV5C/5HKt3IFvxDm/1J2owyAsL711bh+oNGS8PYXWE9I6ekR19thXAwqu6Vgh1NMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(396003)(39860400002)(376002)(346002)(66476007)(44832011)(66946007)(8936002)(66556008)(4326008)(8676002)(86362001)(5660300002)(54906003)(316002)(6916009)(33716001)(2906002)(966005)(6486002)(478600001)(41300700001)(186003)(38100700002)(6506007)(53546011)(6512007)(6666004)(9686003)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KT5Cc7Iz8cFhRRJliewNYnqeI/cCpzPyoDUsfQ1/J6z7JbOyssJ6OgT5pI9T?=
 =?us-ascii?Q?JyS1ueFRZPu0ygTJn7YKi4Mo2Yy2PU64wzkCF397bJgV2UAcsJkW5MV8Fu7U?=
 =?us-ascii?Q?SrCbb2BWmwrY9Bmkap7kYnRtdk8LEogwLHwwu4J8+9MxNeasCDb7iPandSPz?=
 =?us-ascii?Q?0Alpj8YsmogREHEf/FlA8/+Kyj7Fi3xRxC1u/vxoHISNKdIs7UCi9C/5ZbIl?=
 =?us-ascii?Q?txEGC/Uk7sBMzPUgwzbxaAXTlY/GMiq1g5TV/wDw6mqcxOpyV3DqdR3XOyJM?=
 =?us-ascii?Q?ZRil7BOxYIxO7juOFBmWuDwTMHE7HYs/5xIsQ0c4wgviZm5sPfbzkbDPgiQ8?=
 =?us-ascii?Q?3Yow4eSzXV/dW9r/VpE8150m8LkupKb8Y/dhPeQ/SUgKxDDXJ3JmqhwByM/q?=
 =?us-ascii?Q?MSgBC1XR+IMHLD+08ePOtevLYHRTRLVEeV+guftnAPcMFTWNcK4TR3tGOqCb?=
 =?us-ascii?Q?H8M+xh5m3Pd7XywNuH4CeHbehvhjOQiwTX5dnxPvTHo4IOZTPi4PqmIH4jeC?=
 =?us-ascii?Q?8Ncn9Y17f/D5dQ5HbLMd6iTuFUco+k1A09Rok5176OAQK44P82g1mPpKtG7W?=
 =?us-ascii?Q?0CgH/MRM3uqsDm67ysqfYlvK2CyARObo5ybPV7cd4MnnLkMjRXOj+rEMdQMf?=
 =?us-ascii?Q?0kjAqeQzkmOXKWWvkIAw6wCRbq0zy+/n/SW0ypFaTCMfy5/btlxrdDppvrnh?=
 =?us-ascii?Q?ij/3ClrZ4TP0c0ztKH/lOer85Q+OvwiDAXS1MHY7coP294A8l+WQ57Xr+XRT?=
 =?us-ascii?Q?So2cVngvpmD9epnhRlLkrXoRNa/uGq2Vn0oEn3JuEu8bjjGalJiitCGCNrDp?=
 =?us-ascii?Q?YLdL6yCAyJqyuKTXs3SBEC2ulhR7ZRaEofTlvX85pDyEI/5ZGS6VskX5fn2j?=
 =?us-ascii?Q?ALc6zsvi0ix7v2SDOJUn+Gsa84Nw0kTYLbiirBKstIT7aflDpjd+MNF6JB9z?=
 =?us-ascii?Q?UTlNHcBYlK4DQ3FNj0hWoKzKKgnzDaOwscHZbkNl+S5jPavI7pFuCBq6cxbF?=
 =?us-ascii?Q?wVYIeuHXyVZ+PQIwFj7NUB1eVzxMskeN1Hmu2cW5aq+kb3sumO2earS8jdkq?=
 =?us-ascii?Q?2LInP/MkmaOyVf2E+/a4Epvxc1C+dV1ySojjby+gR0g3RSYs+qfCv4lwRW+v?=
 =?us-ascii?Q?B/XmHXRa8Cm4+cmAD6wTSg58bs/Qpr/v4DV8laYaenCvHy3wKdBsMkhh6OJV?=
 =?us-ascii?Q?60a6X0IxMSYYw7sQHwn8wrkM2tNHR4OrKVT7EbOwI9nO5u2RG1hH8EKq2GIY?=
 =?us-ascii?Q?nwHW2aI1x8q+E2DG11VHBWxo8eyZQK7psvQkzdxrI1SDQLaOJZ/5Epw5YdhF?=
 =?us-ascii?Q?zvbf7YsjIYsalZRropPBrxeodVrOXfbIfXyYtO02z9GBOQvhEDDXYuB+7ACD?=
 =?us-ascii?Q?Atb0kyDE19Aq4iXORz9HZ8OtXzSUQM5TfnTtKmE6xKspKu2D8DhxYc2akN+a?=
 =?us-ascii?Q?ReP5K8kPAQWpdWRyIiqvyY2yKpRkkFPdqz7QUZKMhkxTlgDA3BsjtyeXe5Fd?=
 =?us-ascii?Q?WjfABPdwyiPGqZWD9Ci9WNaDncIOxwFQ2h6+5JdllBThNivyPCPSr69BKJ8y?=
 =?us-ascii?Q?UY1m3HqZF7GmhAQK1ZzLTYJH84Lhq1fscmVNZCUdmSUlPjVDZk/OHilhrUoC?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4c3e45-01b6-4ddf-e4b3-08da77375dda
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 23:08:10.8973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKGR6+P5HtHxrFbEXnWubUq9/PIw2HdanfHpD/VcqDNXB4GtKRY7Zd8MG2jB/mVszdZ1iMmu/pcwjr9v4ElVug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_12,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=773 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208050102
X-Proofpoint-ORIG-GUID: 18N0_SUpXdj0rVc6fZI44F-jTZX9QiaR
X-Proofpoint-GUID: 18N0_SUpXdj0rVc6fZI44F-jTZX9QiaR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/22 14:12, Peter Xu wrote:
> On Fri, Aug 05, 2022 at 01:03:29PM +0200, David Hildenbrand wrote:
> > Let's add a safety net if we ever get (again) a write-fault on a R/O-mapped
> > page in a shared mapping, in which case we simply have to map the
> > page writable.
> > 

> > +		if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
> > +			return VM_FAULT_SIGSEGV;
> 
> I had a feeling that you just want to double check we have write
> permission, but IIUC this should be checked far earlier or we'll have
> problem.

Back when I was exploring hugetlb softdirty support, this patch handled
this condition by not calling into hugetlb_wp (was hugetlb_cow).

https://lore.kernel.org/linux-mm/20210211000322.159437-3-mike.kravetz@oracle.com/

Here is a quickly updated version that was only tested with David's program.
-- 
Mike Kravetz

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a23f1cffaf49..86d38d41fddf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5758,9 +5758,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * spinlock. For private mappings, we also lookup the pagecache
 	 * page now as it is used to determine if a reservation has been
 	 * consumed.
+	 * Only private/non-shared mappings are sent to hugetlb_wp.
 	 */
 	if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
-	    !huge_pte_write(entry)) {
+	    !huge_pte_write(entry) && !(vma->vm_flags & VM_MAYSHARE)) {
 		if (vma_needs_reservation(h, vma, haddr) < 0) {
 			ret = VM_FAULT_OOM;
 			goto out_mutex;
@@ -5768,8 +5769,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		if (!(vma->vm_flags & VM_MAYSHARE))
-			pagecache_page = hugetlbfs_pagecache_page(h,
+		pagecache_page = hugetlbfs_pagecache_page(h,
 								vma, haddr);
 	}
 
@@ -5815,9 +5815,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(entry)) {
-			ret = hugetlb_wp(mm, vma, address, ptep, flags,
+			if (!(vma->vm_flags & VM_MAYSHARE)) {
+				ret = hugetlb_wp(mm, vma, address, ptep, flags,
 					 pagecache_page, ptl);
-			goto out_put_page;
+				goto out_put_page;
+			}
+
+			entry = huge_pte_mkwrite(entry);
+			entry = huge_pte_mkdirty(entry);
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
 			entry = huge_pte_mkdirty(entry);
 		}
