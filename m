Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3A151EF85
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbiEHTIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377183AbiEHSit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:38:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43664BCBF
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:34:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248DQPYm022886;
        Sun, 8 May 2022 18:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=4YBF5bEV27uLVVg3IHgJ9vdtJtpItGzHfd+0HtQaBYY=;
 b=h1jcY1iw2/EQbfWYWKZs57ZKiH6Y2Kt2Z6MvsZ6d0VoMjxqmKMAtcXIUJ1Fj/V0xb3lH
 a96pjar+ALWNjgRGcN/Xa10ITnbFJJR/OmhyrFAs04d+3GryAz65ElpE0yXqEZSV9Uk7
 vfCExGOk5bkim16rbzwFwYzq5u0vVG4dj1B0gsGia5nDL/lKiP7dw0zn6Gqj+W5E/TPt
 IYDHH0ye4ArA8SgNtkDlE/BeLV8Fm9KTWPhWcJMQGJNG731SeagE3kn5/bD2MRbtfJMR
 DrePS6x1NwlCzbbm1MLj01gJq2GKvFx+01LU3vFB8YOwsthTwtvu70/A8ymWbEEmUTpK 4w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhat9qru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 248IVFir025089;
        Sun, 8 May 2022 18:34:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf708b51-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOJYvEOl0dCt74ejm6rFsHwYk0kIsme3pduWDHQWiCk7dF36E+k10YVGF4Qej5SkLfDFKwfcjlW94D01c/U2q/KiUOcy8vFF2jmd/RPFHuwzrabdoxgzD7eLjVCYrCeKVDn/Y9fNVghVCnoNs4sWE4ouvzy8YkzoUSLHoGamG+z2tdAXp5yuWG0dMn+CB/tXLpgTurCRF404a7mNhpBYfS29M2yXnVYbUop4vnL2B/8OdDZwruWfYP6p9/RtxS9VY2D1lyqd5zcx6vz+J9wchECrbY6SmoXzd/68hwJKxYUBUg2wKCWTrGUrCJ1hSxSOexxJjjb1g6Wn0sJgpbFHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YBF5bEV27uLVVg3IHgJ9vdtJtpItGzHfd+0HtQaBYY=;
 b=MH7Yi+J85NFw8au4LfxoWa68wXnU5SqhYMzeyykuM1vKgMRl43ioClLr2i7sKs+gOq9TvGkDgzGZhYfeMr2XJScDPMOwcGcvJJeBwmeTSF+pFtUypI15fX+nr50+8FUMXKt6/XXBvIzke5KR0U29IwqshN4CigkTsHFQOkcMK/699cScEw/VhQAdgG1cf5uLw+gEvZc9Vn1YTVULNlS65K5zEi9R78k1J56RvjJeLs70bZoPFY0izEAaa39Ee0+fckfxUEoFJNnr0sD5AQR/tlW853wcrzLCIdFIWBkhZ8IFB+R8bebhg44kKQjxJsQOlaMtlYly07Hw8H3qHgmhMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YBF5bEV27uLVVg3IHgJ9vdtJtpItGzHfd+0HtQaBYY=;
 b=UP1cY+jBgH7ZBm6t/P4i/R7yjgvid1w1AMUJHJNFH+YdVAvBnTQ9g02r3T+FZxBSYWPUEo+H7G8TdMVXlImEW9pOxh2dtSh6woK/e+mRChohjNDbQ7DpX9UGO8BGHq4jIfTxFSXmsIA424cfbuGhhyp76qhKSub8yldTpnMc9uo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1485.namprd10.prod.outlook.com (2603:10b6:300:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sun, 8 May
 2022 18:34:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%9]) with mapi id 15.20.5227.023; Sun, 8 May 2022
 18:34:40 +0000
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
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH v3 5/8] hugetlb: rename vma_shareable() and refactor code
Date:   Sun,  8 May 2022 11:34:17 -0700
Message-Id: <20220508183420.18488-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220508183420.18488-1-mike.kravetz@oracle.com>
References: <20220508183420.18488-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f4da40f-e8cf-494a-2686-08da31216979
X-MS-TrafficTypeDiagnostic: MWHPR10MB1485:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB14850B3401DEF34EDE88464DE2C79@MWHPR10MB1485.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RM6nzZbZ00uL9z2wpxHIGhGJksrr9cLlrj3QXRQcg3UmjUedQptxX66SSnT3vW3oEa1fDpq09i0A7FoedUyGGW63x9DaPNUSDmQdqOlnB5Fu0O0UFvg7rfy5oBzZ7/uWLAEkATu7nau8R31toWPOYtexzeA+WoYsFuVlaEOUPm0s7mY0K0mGejw1VypW4lDK4CY5DnB2H0eC68JmrDIDOwhJeULrEVQg3ksD8g1lqsACpFr77KW5/IxccQckWFsv7vH+1sH7b8VCC2wj2fHsQpMGLNY30/nM7jvw9RoJN/ArrC/OtP/16iqSrFM/PRaHlIXrdFouRojORRX42x1bHbfLR/SaSSCJ7vaiYehKgAF5YqzfBteyWAneqrG4Os+0ebAQAkRjjOPlGXCM8WRDsAQNgEPqeteEW9q8aDrnmBUKsoscAaIN9NJzYSs45nIAxRULS3wvoUdAgIquajSl2f/O+vfbWDjWjeSU1R64L+uZ0p19/bYz/zbKHLOAhWXMS2lZTVD4qCQmw4AGxr1gg7bo9K+0R2j6bv9zNI0CYBjH4p20lI5whEPnjsLp+hX2OijOrdmQg3dohS3EyJw5vF6NLQNBetvSBDfGX0FsnHivJFljY1kY6YSFwyXDEicB+65IJ2BFdAurGjTD20pkgQMxidfQ2T8yE2WyiKgxm0575/sblzH+itrNEXm9h6wmIjlHBqUgz/GTmZLkwVZ6fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(2616005)(86362001)(5660300002)(4326008)(6506007)(7416002)(52116002)(6666004)(6512007)(26005)(8676002)(8936002)(36756003)(107886003)(186003)(2906002)(44832011)(83380400001)(1076003)(508600001)(6486002)(316002)(38350700002)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wHxEbN93sO/8WJkCKcE9vBVm0qdHuIv31bpx1RoKiEo9hZeIbRucUB4mAy6y?=
 =?us-ascii?Q?KAhCfCvtWJXfRMMCobQaFO+VrAo0MNcTJRpSnJzTD8KGeoYr6cVLy5t6lmIO?=
 =?us-ascii?Q?ps3spoEStDkpnzNe7ngvjWlYJwWwEslExV+a25ddEMDhU2EKK/AiGVNx3zjW?=
 =?us-ascii?Q?z15uETaBe9TdtypPQDtqgXBRs7x8JEbfD0qXYxsFgqiDM0RRE0Sm+UiDCVV0?=
 =?us-ascii?Q?ilirFMyGNL7WOA8haPp2OSRL47Ahc8mvxVfWr/WHO46q0jOXszQL3t/QScLz?=
 =?us-ascii?Q?VXnAhUbM+okZI1CXE5XkqorX/1G+tMtwAvdpmT5ZDW0Zzddg22bmKtbcig0q?=
 =?us-ascii?Q?Ie/LsMJSDBI1/65eq+IDxZM/UqKq70vOLAq5tvGbf4TTRy8wGBtbv9B6+/ui?=
 =?us-ascii?Q?+a3Orht98mowjvc7oPieYY/8aKIXdwxSsqpY2UuCmo3BzOeS5dgv5Q3832Or?=
 =?us-ascii?Q?jl16IKPZH1IRN4vlvqJ2dU/T+yQx+2+pnWt3QULtSpiIXZ9bMq8q8Szvp7hs?=
 =?us-ascii?Q?t8E5nXg8WYxC7qi0cGOiMSLrbqpkduxA7rp1bW6+63xnzZOCSRH4FlSzuEXE?=
 =?us-ascii?Q?dP8YOoeD1hYrgaGgD02p8DpfVqUeT9MQqPlT2Ne9wdkDrOstY2AQCCF6Yqvp?=
 =?us-ascii?Q?FIKlpo+WcZFLtqLn+7ziLwHhTVQ3/C7r24liCB3my24OCutQxtTDTAYW4XDd?=
 =?us-ascii?Q?LhklOVbus4rjgr9J/3zn+y5UvnM4TLiWNf6HzoXdjGEa4RVz7uo5zuJ5Wasx?=
 =?us-ascii?Q?dYApgxH7VjcSRjYeBiaXzQWL9LFNwdfceUOb2HhlinjaERxpXV6BVlv+TAI9?=
 =?us-ascii?Q?r9ooorZQQbnRAvAXQJ2RNGT/1mDcEsscpE6JNsRFpPcim7iEI5FWowEDF3bl?=
 =?us-ascii?Q?SjrAYl5+kZEn3WbW9gbaoFDTsXvw5YbkGcq8MTs8rzRQtv4FVa89kryAMdD4?=
 =?us-ascii?Q?/AKMZfFK6z1saMfv92pEE9rZ5/PiyMQ6qF3mnvvMQMqN/xfsHlqqrWGtqrlG?=
 =?us-ascii?Q?IXC/B+aWKt1+WtIMh+LdmGtjtFfmX4IfQ3hueu2eRuEje9tz+cAAgOROV8uE?=
 =?us-ascii?Q?wHtmAcIr0hhC9i4Q+dp4sbt9JwqaSBkMdx57tFVosMKAOZJty8fWGdHsT0nE?=
 =?us-ascii?Q?gQEx4Tt2503YW18SJfTA4lalqQaek26BErhunXgM18iEMn+ina49fdkiyxDW?=
 =?us-ascii?Q?DXIdTMgz+yNqQX2D0OMu5V+TjG53gUxMRHQEjYs1ey4DLx9tyT7GXLYwrQ6J?=
 =?us-ascii?Q?qTLM2RnFrC97qSGIvlJSLsfDFQvFftdgo7lEBN1XmjYXRnaeuRJRWyKVbLsd?=
 =?us-ascii?Q?kyZ2ikvOJVx81I7e5X2xCHkpgB9PEAoAZcz+jQCx5VC4hFdf6stLFr2wn1/U?=
 =?us-ascii?Q?mU2BXJ4OaOdAbTsEZcsDBQTbcws2VX/UHnwdxRWW2f+R3t5J2gWQyVVbtZnd?=
 =?us-ascii?Q?yT6/oU85CGBsBXnRjNX6ylUIgeheDHFN37arlcm7BV0xUECtt1BrcDBQa4VF?=
 =?us-ascii?Q?WBYnPIrItEi3UU7UHR+lXRuWGtzLBgjrWMV0TYl1ny/VCe0VmaYxA97iN0A9?=
 =?us-ascii?Q?SyJmaZNydBKDlPGH1jLoa0rmRLBAuDl+3jZ0avzp7gCgNmZwNL93NArRnxyn?=
 =?us-ascii?Q?btBql57Xxr3swlBz3hap+yPimwMQ9wucxArCfX+6Hl2gd0UJ8ZYql5M+XdtQ?=
 =?us-ascii?Q?afyDheMthQzdxRCAe23Ri+0hm0sIK7D/8qA2ESkPOK1tAL+jyTFY0UWjDjqh?=
 =?us-ascii?Q?rY7czfv3C/Bw20/r93i8tfrS3x9heHA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4da40f-e8cf-494a-2686-08da31216979
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 18:34:40.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRMII58MW09qCrWtFe40bILOCrUSY6XPMt8sGsJtcKBONktjH1VCQw7UwzjlQJ8U9VdbiVxDkg4EInd7aK4iqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-08_07:2022-05-05,2022-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205080121
X-Proofpoint-GUID: uYLTc4jIjG9rp4l5OC25qYmrrVPyMoPt
X-Proofpoint-ORIG-GUID: uYLTc4jIjG9rp4l5OC25qYmrrVPyMoPt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the routine vma_shareable to vma_addr_pmd_shareable as it is
checking a specific address within the vma.  Refactor code to check if
an aligned range is shareable as this will be needed in a subsequent
patch.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 007b39450f71..d278c95e9135 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6600,26 +6600,33 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	return saddr;
 }
 
-static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+static bool __vma_aligned_range_pmd_shareable(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end)
 {
-	unsigned long base = addr & PUD_MASK;
-	unsigned long end = base + PUD_SIZE;
-
 	/*
 	 * check on proper vm_flags and page table alignment
 	 */
-	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
+	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, start, end))
 		return true;
 	return false;
 }
 
+static bool vma_addr_pmd_shareable(struct vm_area_struct *vma,
+						unsigned long addr)
+{
+	unsigned long start = addr & PUD_MASK;
+	unsigned long end = start + PUD_SIZE;
+
+	return __vma_aligned_range_pmd_shareable(vma, start, end);
+}
+
 bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 {
 #ifdef CONFIG_USERFAULTFD
 	if (uffd_disable_huge_pmd_share(vma))
 		return false;
 #endif
-	return vma_shareable(vma, addr);
+	return vma_addr_pmd_shareable(vma, addr);
 }
 
 /*
-- 
2.35.3

