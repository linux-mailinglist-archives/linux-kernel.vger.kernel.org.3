Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6B453F072
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiFFUq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbiFFUqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:46:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFFE111B99
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:40:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256Ivt91017195;
        Mon, 6 Jun 2022 20:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=8gpbcHqofa3ZUH2AYI8aFIUjIzCV/nk6Swr3kdhQFQw=;
 b=gP1S49aqutBnkug2WTKe77ZF+6USRz1EaoVV6SYPDRNYFHwCnyAbbsH7Bv9IgYV4cbya
 Bn1zVDcrxj6SgW1arhVPPKM9mWRyhWOQl2zn1McHdOEijMFa9Dx/3cKU/2vT1clKQ+S9
 C695Idqa7et0mQ7BtHgSbXtBInbjoS7xiMAScs4ElDJgMA0WdeSrDcKhzPVp04b9unKI
 VXM+z4QxleMiqqRD8+1dvSp0lGVWrsIEL82Fa575UMBWpJkEkWAn7vp2GswHuugpTwKQ
 WIlBeioanDyMpKrp3vrTLQ5JpZ+gbcBWHVFKswVJwB4L4XqvGseKNPmzbh4vIVdb4lCy cQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxmtfxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KF8PG001195;
        Mon, 6 Jun 2022 20:38:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu91cqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIa45NaG5SjyzHadejagKSY9jDkv0quHDQSMkKXIdT1PAIB+DnnD+cR1aGVa3xVC8fquq1PjdSnYB/DHQmDFM9ESeUUHAcJQvxSf5kNjMeEioEiwDrpzD3JuKGpu02NNhAM3Ku6f01tBOR/hP7gQbmwIp2qXarrB2ADPxycKtCyN0kqMLWpWr0yUARS0SwdIiNUFRGZfmzf98CvO/5MGIY4Y14ufzwa7KBcDsnwqWcmW61bmsy7D00jRodXgZjRQR234d5Md1yYsFEQbqNnJUOQUEVv/O6wZx9Np/27bSamKeQJ1fBB4ao8Yr92zJ4gBQjm3m9qBwLG6lK96snHQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gpbcHqofa3ZUH2AYI8aFIUjIzCV/nk6Swr3kdhQFQw=;
 b=aN+7BqUBXzVC0/Rvf8A4x9AbXFzTsc4vMUMC8AlAx1mXYYR6p2/knh6mIMnYmFmZ8vYp4yE3WvDY9+lGmg+2/VA0Haf8crOQ4lI6shf3TufveuZ0z4ZCHbTNyrQPl8V/WIyLCh2PsiYcKee3Rgmo8byboy0tKO02+ApKg+YGNr0d7F50pmdchZ3L4WuX2IXhJwKJDl5SYBbGMacsJz08lhpPymTOK1MhqUaJYkDLX7mmeIy9wnvj7cVimvyHroP1kXWNP83n+vr4uZCsV7nLor6hJd4R117RbCSh5VGGIaejj0EI/B6P6ziYoRWdK4dJCl5rQhPWfSro2bpugq8ggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gpbcHqofa3ZUH2AYI8aFIUjIzCV/nk6Swr3kdhQFQw=;
 b=Cfl+OMJVAgMPA88U5YxSf0pNIApj8v59nXdrRh+qA01aYelwfCykCLM5KyfhC60dXJTS454DsTJOvrVuWOWBGfZzdbuSDiBcuFdfK/yjsdvs1BVNLtH8zSlVtWKi5Tepa64vqSE7tBBGAxjpYDALXhrzRZaiSQOSuFoIYwXu2UA=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 SN6PR10MB2734.namprd10.prod.outlook.com (2603:10b6:805:41::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:38:25 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:38:25 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 13/21] clear_page: add generic clear_user_pages_incoherent()
Date:   Mon,  6 Jun 2022 20:37:17 +0000
Message-Id: <20220606203725.1313715-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 428ac945-9487-4c41-ed70-08da47fc8168
X-MS-TrafficTypeDiagnostic: SN6PR10MB2734:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2734AFCF5FD9FDB7860CA045CEA29@SN6PR10MB2734.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSwNndU3lPthop0EGjapoQ9syHlR7WpYqk/Ng0h99k9e8nUH2R5Ed1V+5QZa3WvOsKMABAjp9eYnHxxlhTFXu+oZyxyzMX91GcahrxK4o5qNHfHZl0doGTC4r/PN42MwyGEb9Mu9P8c+KJ4uozYVfMulzZfx1Zp6vNW5dd1Z0R9mFvleVLQ30hLwM8uyfVB9ontkr1lU0oRsSfB2yWD+U9o2Jrx1F2Mc3KBfrtlU6NbVgP0RET8aphsUBmfHnkaO6HzJNk4l/yTkcdtmpxmm2lLpjMqXxHWYFtK5jZ3C57kDaTtHw0VexEK0se6yB6c+dQdRVDqYfXK6jofQjCYwO9EBL0Hfv2zRS5c0jhOBZbjkOHoM6AcBHk9z1gHNMJCH+NsovxoqS1iHvVcWqBZ8ek43ayR3vjbsPuMR8mu6V7qa8zhOEKDnMFNems/hOmDsF5TPuhyrEXN2+bGk/5NsyOgQ7yWZ7ued1yv4M7A40z9bvhhgDjtM4F1jSeVyVIPPythS6hW1HW6sJ2l/mvg4azgKO/98hrW3gigUinb+a0T0R5R9TKAPi5SAsWArHWqnaxlA0si6CvBTPq3GH1g3/TvS1D75KRHI9Pk/zl7DJx/FbTnvKCByk34IWNSXQ4B8jpWAM6KCc3P1FO4w4tt1v2sN6oJklhlJGSVbt0I0LzjIRDVomGRLGqxeQdZ8Q82N/WBxbmQnbufFBojLXbuKm3QJEkp63QTJSPQCqKpXN1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(52116002)(4326008)(2906002)(6506007)(1076003)(8676002)(186003)(508600001)(38100700002)(38350700002)(86362001)(6486002)(2616005)(103116003)(6666004)(66556008)(36756003)(107886003)(7416002)(6512007)(26005)(316002)(5660300002)(66946007)(66476007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6lZzxuLLlOn4YNgtqQrxHoEmuDXAyXAfqX3oMwN989b7dCeE5yli9QJpkLud?=
 =?us-ascii?Q?vXyH20EY4f9Wits7T1brB+R11jL2idPaELfT2XlaJRU1PYlZYZej9Ocok/gY?=
 =?us-ascii?Q?r2ZTt1gBUTtpT67dWVoX5wmZyUBskAsiSeP6haidkKYXE0lCyoV8r4BKAkHk?=
 =?us-ascii?Q?ZvXNJpRafsb2eXtefl2eTTGf1oWHUB3HGVkCA5MJppYB8uLAgmZJjg5Fi1tG?=
 =?us-ascii?Q?DeC+sPzKvsOTBPpQachPlgCuCDHrnm+qLPsXYYTNZ5hSzcUvwafNUq8fr8LX?=
 =?us-ascii?Q?UF+7u4MvHEW90C+0m2NbCODvY098mYWM45sMFc0VA3uRuRvnaIRo9CikWUYI?=
 =?us-ascii?Q?ppOMWXSMXKVyh6Hnx0NLWpzCRfurd0mZUamwdUJKu4614Cj6OAM2hSbtuw2/?=
 =?us-ascii?Q?VWrdfdusP2p5lsiCzaiizCg4HTrkg4SgeBDMg4hQ+61UaZKV4SOV17+Ymdrl?=
 =?us-ascii?Q?jQ/qj4GD0cKZN/MaRS7WVVt16MULbpCIrVQDJZxbe8dQ6Wfk8XSiP8YzgE3m?=
 =?us-ascii?Q?IaIDWXT/HY+ZcBzQr8mJW1qJHP8CNKU/1Cujqvt8e1dBhAAiFGh0gS6pF+T3?=
 =?us-ascii?Q?VOKlnfmczOn98Mec072Sq79QOT44AjOP39vPS0XZgV520PNZCLtn0gPipsXC?=
 =?us-ascii?Q?uyGv+r8nsmJn13kfiP249qPRt8+mZyrp+kWq0aAdNn7t7pqVdBeO7fCRTnC4?=
 =?us-ascii?Q?bCKwNcsFmLEC9W3+gZ0ynX1eFqgE5dtTsTaIctQt1pppHdDS+J+UnDJAdNY8?=
 =?us-ascii?Q?8FGWkWU+0ouO9lKCqFEkHo+0M7OvksOGdynYmB0SFWv7rtOkB2+Uv+p7OBom?=
 =?us-ascii?Q?yEhG0um+pp4TXFhpUDk+w/vvbgniHIfQodg6bGvXapn6qvMdW8pexJAz1Gbn?=
 =?us-ascii?Q?X7WHbY2fzK97y0H3pt04L7rzcXMX7d3Y2LGaDdVrcBl1Uk+zj8CR63B+agY0?=
 =?us-ascii?Q?HXr5ORRXJPAhPyYzHw4s2Ew/1cDI4H5/Eyw+h1RigvDReuqmpgW+RmNECtnF?=
 =?us-ascii?Q?yfhEb5WQs7NVuc8SKIbxPuuMRGW4xGPU+cJi/Oj61+FwEQJJNqUbYnpgJ4qr?=
 =?us-ascii?Q?XXTDrefs++eNO7etBeUr0dRGa/lOYTvaNZ2FbkhrIUg9wuPh9xJxB7o/2+wg?=
 =?us-ascii?Q?rc0kP0DADOAs98EZaKWNfVFGUW1MYXtJUjuymFS7weQXX6eOTGV4bfqLk7i9?=
 =?us-ascii?Q?bnEDRyHGKXydiGYD97zPS4bQpCJ9qwsl/xiHiuwGO/H2uEPIs/8p+ZCBImhK?=
 =?us-ascii?Q?lafap1vMzR+Y1WeGv4C1rpBcU0Jts//ASQpUi9dAN0YurzpwlVVeOftkI/6m?=
 =?us-ascii?Q?nVGYBQnYGrh1NNj/LLMwBBCFsWDKpk88ayk8Y0/QOa9SOpl2gisOF7ZINPIy?=
 =?us-ascii?Q?1wAsDhEiv8wepYIaY8YlwTQTdDaVY8Ec4VCqkapwh364TYt5/jdYSmKMWpyu?=
 =?us-ascii?Q?UrEtJzN9hSy/WasM+tK5rW1MIk3k5z4uRGdsqBWCYNFVmxMT0e3e2JceAjtT?=
 =?us-ascii?Q?r+xW8qqKNI6xed9aj7yTRridTtXlFLJTCdFw1hcUtkTudxzy0YgMLLeVV/Z8?=
 =?us-ascii?Q?s6Nps0JYurfWOEOsnXN2XGYj45Q97/SSeDLguggHxF2yqPD6NAQ/sqHQOw8z?=
 =?us-ascii?Q?CFHqaVKs7qIyFwFWFyMgs9nKb4iHIK1Cf7pQ/j0FspFNelQrIg4ds+9Ad7qU?=
 =?us-ascii?Q?Jj3ZnwZg8GhTTKbzp4l5+YEkggG3TxtftqYBWsAFemkqzXa4Hf56oCRkA76m?=
 =?us-ascii?Q?BxzFPFZ5rddU4vZd0kaA5/NsI1ygsQI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428ac945-9487-4c41-ed70-08da47fc8168
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:38:25.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UfeZi4kKIHq24wYNcDqc+nnP/L9mdcmxBB4Z1YQb/HMSOaiCVhgZoNwdMJQLhA8eV9pnhEmz1qzDQO6ujHBBINlhH5tjA6QSpDcMXJfOh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2734
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-GUID: ddmajI0b9RWhluUJBhCtUE6uJti-FrxO
X-Proofpoint-ORIG-GUID: ddmajI0b9RWhluUJBhCtUE6uJti-FrxO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic primitives for clear_user_pages_incoherent() and
clear_page_make_coherent().

To ensure that callers don't mix accesses to different types
of address_spaces, annotate clear_user_pages_incoherent()
as taking an __incoherent pointer as argument.

Also add clear_user_highpages_incoherent() which either calls
clear_user_pages_incoherent() or falls back to clear_user_highpages()

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Notes:
    clear_user_highpages_incoherent() operates on an __incoherent region
    and expects the caller to call clear_page_make_coherent().
    
    It should, however be taking an __incoherent * as argument -- this it
    does not do because I couldn't see a clean way of doing that with
    highmem. Suggestions?

 include/asm-generic/clear_page.h | 21 +++++++++++++++++++++
 include/linux/highmem.h          | 23 +++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/asm-generic/clear_page.h b/include/asm-generic/clear_page.h
index f827d661519c..0ebff70a60a9 100644
--- a/include/asm-generic/clear_page.h
+++ b/include/asm-generic/clear_page.h
@@ -16,6 +16,9 @@
 #if defined(CONFIG_HIGHMEM) && defined(__HAVE_ARCH_CLEAR_USER_PAGES)
 #error CONFIG_HIGHMEM is incompatible with __HAVE_ARCH_CLEAR_USER_PAGES
 #endif
+#if defined(CONFIG_HIGHMEM) && defined(__HAVE_ARCH_CLEAR_USER_PAGES_INCOHERENT)
+#error CONFIG_HIGHMEM is incompatible with __HAVE_ARCH_CLEAR_USER_PAGES_INCOHERENT
+#endif
 
 #ifndef __HAVE_ARCH_CLEAR_USER_PAGES
 
@@ -41,4 +44,22 @@ static inline void clear_user_pages(void *page, unsigned long vaddr,
 
 #define ARCH_MAX_CLEAR_PAGES	(1 << ARCH_MAX_CLEAR_PAGES_ORDER)
 
+#ifndef __HAVE_ARCH_CLEAR_USER_PAGES_INCOHERENT
+#ifndef __ASSEMBLY__
+/*
+ * Fallback path (via clear_user_pages()) if the architecture does not
+ * support incoherent clearing.
+ */
+static inline void clear_user_pages_incoherent(__incoherent void *page,
+					       unsigned long vaddr,
+					       struct page *pg,
+					       unsigned int npages)
+{
+	clear_user_pages((__force void *)page, vaddr, pg, npages);
+}
+
+static inline void clear_page_make_coherent(void) { }
+#endif /* __ASSEMBLY__ */
+#endif /* __HAVE_ARCH_CLEAR_USER_PAGES_INCOHERENT */
+
 #endif /* __ASM_GENERIC_CLEAR_PAGE_H */
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 08781d7693e7..90179f623c3b 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -231,6 +231,29 @@ static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
 }
 #endif /* __HAVE_ARCH_CLEAR_USER_PAGES */
 
+#ifdef __HAVE_ARCH_CLEAR_USER_PAGES_INCOHERENT
+static inline void clear_user_highpages_incoherent(struct page *page,
+						   unsigned long vaddr,
+						   unsigned int npages)
+{
+	__incoherent void *addr = (__incoherent void *) page_address(page);
+
+	clear_user_pages_incoherent(addr, vaddr, page, npages);
+}
+#else
+static inline void clear_user_highpages_incoherent(struct page *page,
+						   unsigned long vaddr,
+						   unsigned int npages)
+{
+	/*
+	 * We fallback to clear_user_highpages() for the CONFIG_HIGHMEM
+	 * configs.
+	 * For !CONFIG_HIGHMEM, this will get translated to clear_user_pages().
+	 */
+	clear_user_highpages(page, vaddr, npages);
+}
+#endif /* __HAVE_ARCH_CLEAR_USER_PAGES_INCOHERENT */
+
 #ifndef __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE_MOVABLE
 /**
  * alloc_zeroed_user_highpage_movable - Allocate a zeroed HIGHMEM page for a VMA that the caller knows can move
-- 
2.31.1

