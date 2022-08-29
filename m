Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3091D5A575B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiH2XBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiH2XBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:01:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A28C72ECA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:01:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMDv6B006909;
        Mon, 29 Aug 2022 23:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=VGmmPwWPu5W99D4ogg7Tpo9BbWI+rzPi+9Yb/8AA3Rg=;
 b=nyQ+e20mP9BvKtiYS/I0riVCQjaprXlf+Nd1nDlRDfO/wSXrspbJcIIa4P2MoL7imiOJ
 xappeJKG1Ky+MFAVaxAVxk0woOeT/m+aaZGLM8Y3CGeVguDIc2tSYYUNqsDUukJhG6Ws
 O1NNSQTt/dmmUkJTPxdZV+ttgn2C+FwQ9UXN8pdRBPSYvrrMudbul05IU0Qmt28L3pBn
 1OuGoozfbdgCWCJtGSKa56ZhfvoaddW8Qdb40V+VU6xIbjHEocScnm/2HpHEHldScLKg
 m1xQHeRQyj2P2vbMuzZvaTRzLjs9gvrSmE1sy2lgnb9vUuDivAj0+DNHPEcae6YrYfq5 BQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0mtwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:00:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TKDP0a017923;
        Mon, 29 Aug 2022 23:00:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q3b6ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:00:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaEeGH67emPXy7v9oLYmwEaHCKrNorhx/GRgH3NRR0obvNDpcyYv2CNk3mtCyLKocTFfedFgr2bBTJ1cfyNzKvZ5E22w1hC/k8Ct4MKSfd9dQB3dwZnYbmS6ea48rsqBWQNdZ0AnOqUj/VL+73AK8SDSauyOzzvKCIaUH/8tYRid1BIQkyHsACpzcV/1eLGGUTj4j3zpPN99/uS3NF8KeEVQfiDLRyRZIyGGE6LWycA7Sw4kSzeUJA0C7k1ZG71fUw4nFMYQvmUl33hH5pbZTlROz6bU4YCbTGwzNb13g1pcVmujqHD1yGetYv5el3pyB4QswLVW1ZxYLIGk3FO1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGmmPwWPu5W99D4ogg7Tpo9BbWI+rzPi+9Yb/8AA3Rg=;
 b=QGoTs168IHhp+4I9H+pgSvETTwua2Uzu1LCczjXBo2IwNqAA1DZthcn72KJEcr37VeLmSnzVCZCPQornG7ebR2tMRXELPr8MS7UZR/kvhrS0G0tS6YXZiVlc1sTAVeI9V3faCGMt8dwBIF4lCvz2ExXTWy1eKddXgj10F94LUIjgUb+RTUtOhMG5o/KUbBHNm0NCC0BPwCnfHp5CbS6CR83oM4qPePGiHlLTvMlZe4xkdWKHg2o2J1OdsAX0aWcPu8/KIWyQkw+AxqkN3+TYZpGKsw+t42FYKLfDGDyAcNp3sDZXDnqEyGsWpyeyd+lZUslWyA7C1iIaMBtEC+hEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGmmPwWPu5W99D4ogg7Tpo9BbWI+rzPi+9Yb/8AA3Rg=;
 b=w7XlrigbEdTXTv/JpOB7RH/rrbhDQ6YB/U4rWidM8ti761QeOOb1uGClhrwUysW6+lHnvTwScg/cOSfLJBuzxnhyV3pDOsHgNSU9xfxWYkkIi/FHPiEbuDGV72R7gw45Tm0IWE20r9IlCItVfeiJKWRW0CxJX4ppEgQLSXTi5xc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BYAPR10MB3736.namprd10.prod.outlook.com (2603:10b6:a03:121::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 23:00:46 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 23:00:45 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 1/7] mm/hugetlb: add folio support to hugetlb specific flag macros
Date:   Mon, 29 Aug 2022 16:00:08 -0700
Message-Id: <20220829230014.384722-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9ac35cd-5a58-4471-519d-08da8a124e82
X-MS-TrafficTypeDiagnostic: BYAPR10MB3736:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1ZXIvX90774wuf19hHC/MU0PfJtgH1Wjrwfue2WWW3ju4FfASX3OPlzg7XYkuKIM2Yf3eXIULOeZUHQDbOWYqGDvRItBA7J2h9gZPlINgiwdwVGNpsOmwE2qUIf3BhuskaercM8bObCjHjsJviS8JIqaUuHAbqQUPNck7ahgInmdldzJxJbikhntyEXVNEHuDyWNT4UNFn79SdOiSWPYVI5RfvHWOfEfjQJ+DnjUCLgIDwa6o0g6IAXX53Zl9cmgK/fcUU+1qxDkL8gWC/n8UtPSPg8Buw11yyJ5RVSXrre5a4VmHBC7Tm2pheycrFGKvi0l4nT2dGhz0M3+iOLqNMuHS5OdOnJMtnTlw62Hx7SCGjefEItlF5CD3NJ7aQ0r34WmumYklCrJxavYE8sa+dEOHCiESQktswGjA5OngJzbqJhiPXjpfM57iqFQi9n9BJ3eYnboM+yK5x8ZGjLdYN2SHuxvryrUQP+R/hH32dfWQK6JzxD7WfoPUfxIE94aTuJw9BMD/WmQ3pBnvw3xJbMDucrUZTPSeGgRyQpmtQ+Mh9inQWK5ZEaAgZuAcxxCCcRBcl5hXHLE2DbILMrVyl3gxs4KfeiRGNp8im7oBBAV7RRzVFKccQpo4wgPrGXrKsz+sXR9lFicUV9b7cUxfRsVyij1DcEQ7BDLAGcSZyBOsHAWd+cMBBmHwa41XLUZV2tUiONTg7ndU1x/CxmpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(376002)(39860400002)(83380400001)(5660300002)(86362001)(1076003)(2616005)(186003)(38100700002)(44832011)(36756003)(7416002)(66946007)(4326008)(8676002)(66556008)(66476007)(2906002)(6486002)(41300700001)(107886003)(8936002)(478600001)(6512007)(6666004)(6506007)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ng5PG/0eBEoX+qWxWOQQoRuZYy5nuUtoya2+cZUGUeBrQnJcq3HyWjhBFJh4?=
 =?us-ascii?Q?Ka8Umksg8PcJfzf/A+/qhclmfUJbFlgKIriL8yLLMvN0mTYzZrA8MEYMxpby?=
 =?us-ascii?Q?l8Q2uXvXo7sNwhiRPEX+mKFfjWsf2NXdcjKQY9V8gGM4ztndzutpnUkVfIcC?=
 =?us-ascii?Q?8StNyZS3ICDQM7elMThQ7b6ne8Qrwk6xsAUk7JO+8Z7PBOlVcHPcjc2eM1cn?=
 =?us-ascii?Q?YWsN0zw7vYd+Dde4kTVHyRps2jY1WfILaIgS6M9rEkzyihusxlQav4CmpZsP?=
 =?us-ascii?Q?RskDfWTANYcQBn116T1zE4Shv/FfOGw4YyIc+pEjJiqxEIZXfAM/yABKjjhb?=
 =?us-ascii?Q?byGPIvka2stL4ZuHRA0JkOMYKiMHWWWKHK7l4CbnQjwbsI5NxrGuqkJKe/Io?=
 =?us-ascii?Q?81xq9+CpV9FBMyuNrwyOjhsqJHAnU9hnWeXkqkL9hU5XaSSl3HIgoecs8iB8?=
 =?us-ascii?Q?X9qBsK30l1B4Y5hYg2rpsy0rfxo9rOE1djKF3bWk0GXcncNaH0zpdhUilf6e?=
 =?us-ascii?Q?IlHe4jaowPLObD73uYepHLeZ3o/I8AYn2YGZJVwuNnqNnfA2C+nvjdA+PX+D?=
 =?us-ascii?Q?FxxZJrtFJ22H+0+jJUY8GRpa5kppMUlRpV7mie6bWJ0KzUfavUgUwF4zHbvm?=
 =?us-ascii?Q?H6YlXqsyv+Z1C3YK2V6nS3CE/YomDkZ4G99hUnwTdf0M5srVjTXv5n1lqwTV?=
 =?us-ascii?Q?7UkZGOd53ahL3cKWcQKKbju/K54I8D1F5C3oYqqSnW0PD9Qt9NAofQI5M+Jb?=
 =?us-ascii?Q?J8kQxqy3XK2GYvs/GNr8F61k1si4EPgHGHrD7RXE/RFqPkbBgNWiPBK9jVcm?=
 =?us-ascii?Q?CRS1ZCr8TQkkpnhQRS0ZB3mq4U2H9xpKo/RCplVlBank9A0Axl+BpDyI/RvU?=
 =?us-ascii?Q?PAzxq4moXbZMhtGieLvD2fNXllR8qMX403SLKIUjldyojrC9Uxr6dADAM3ao?=
 =?us-ascii?Q?g09SGA1esepX5Z6GmeB9JJW7Ks967iZFKAZ3JwPiRVH0Yb9YdePuaw8XSJKA?=
 =?us-ascii?Q?cwY1CyRJlhAdV0pUw+BjvNeVw+0KnHsvq5gFGGc4BuSFoGBJFxHv8nmb7P1g?=
 =?us-ascii?Q?utPvW3u5Uvj61KJvzxxMOoTfFdiq/HE/YQQkdoXuSUI3nL1WcdNJymqU/29r?=
 =?us-ascii?Q?WvU6adPOB6eW5tTjOrUUFtBfJnfXKGUBZ2qp7tQMR0wG48ZCcr5kCw9sdVZK?=
 =?us-ascii?Q?RqXnOrcr5pWtnHCaqEENSL2eTfD/yceHXzK5qq05VAv46SFDxDqJcPszyPej?=
 =?us-ascii?Q?J/lDLkEpZ9t5Y7P5Ikw7YyxlhAhGG+101/PS9U1f8cfl5PmjpCAi1L+7IaUb?=
 =?us-ascii?Q?0EN9SycnMv9Q4JFvWFaxmIdfcf9Na0HGn/BN2EWG9dH+uSyHgZOzw4ODw0qG?=
 =?us-ascii?Q?cDAhrsTQn0WA6xZ7oWesdMk4jZyzMG/1+3bNH9qlYI5gYwsWnt+Uy2Bto2ak?=
 =?us-ascii?Q?FsZ6lojJiriwwqcToXI1RKygMw+wQ96m5e6/fAqZI62M4owk3cYhldlf3BdC?=
 =?us-ascii?Q?nDfYSLMXHAuZErZuKll6o4wXLHAvSeLxyvnIg9GJapuY//wnAAo4qYndoVeX?=
 =?us-ascii?Q?euKTVnB//Z4k4HfCJJcLswQCiksMfaWhHigAaO2or66rUCr9bwV8oEzUQx5M?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ac35cd-5a58-4471-519d-08da8a124e82
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 23:00:45.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0ZTBlZySwDHvN7Wl1SvoEarxoNhUKYAy9RLUM5LbIJN1fRJK26/j7yksE5T6SqXUkYlg+OIHv9BXjRM+DrOIk8qEbeQBtmWEy0OdrJWvD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290101
X-Proofpoint-GUID: 9gqh0rYGH67EB0Ca4tu61KsGaoxylPBU
X-Proofpoint-ORIG-GUID: 9gqh0rYGH67EB0Ca4tu61KsGaoxylPBU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows the macros which test, set, and clear hugetlb specific page
flags to take a hugetlb folio as an input. The marcros are generated as
folio_{test, set, clear}_hugetlb_{restore_reserve, migratable,
temporary, freed, vmemmap_optimized, raw_hwp_unreliable}.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index acace1a25226..ac4e98edd5b0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -583,26 +583,47 @@ enum hugetlb_page_flags {
  */
 #ifdef CONFIG_HUGETLB_PAGE
 #define TESTHPAGEFLAG(uname, flname)				\
+static __always_inline								\
+int folio_test_hugetlb_##flname(struct folio *folio)		\
+	{	void **private = &folio->private;		\
+		return test_bit(HPG_##flname, (void *)((unsigned long)private));	\
+	}	\
 static inline int HPage##uname(struct page *page)		\
 	{ return test_bit(HPG_##flname, &(page->private)); }
 
 #define SETHPAGEFLAG(uname, flname)				\
+static __always_inline							\
+void folio_set_hugetlb_##flname(struct folio *folio)		\
+	{	void **private = &folio->private;		\
+		set_bit(HPG_##flname, (void *)((unsigned long)private));		\
+	}	\
 static inline void SetHPage##uname(struct page *page)		\
 	{ set_bit(HPG_##flname, &(page->private)); }
 
 #define CLEARHPAGEFLAG(uname, flname)				\
+static __always_inline								\
+void folio_clear_hugetlb_##flname(struct folio *folio)		\
+	{	void **private = &folio->private;		\
+		clear_bit(HPG_##flname, (void *)((unsigned long)private));		\
+	}	\
 static inline void ClearHPage##uname(struct page *page)		\
 	{ clear_bit(HPG_##flname, &(page->private)); }
 #else
 #define TESTHPAGEFLAG(uname, flname)				\
+static inline int folio_test_hugetlb_##flname(struct folio *folio)		\
+	{ return 0; }										\
 static inline int HPage##uname(struct page *page)		\
 	{ return 0; }
 
 #define SETHPAGEFLAG(uname, flname)				\
+static inline void folio_set_hugetlb_##flname(struct folio *folio)		\
+	{ }		                                                \
 static inline void SetHPage##uname(struct page *page)		\
 	{ }
 
 #define CLEARHPAGEFLAG(uname, flname)				\
+static inline void folio_clear_hugetlb_##flname(struct folio *folio)	\
+	{ }		                                                \
 static inline void ClearHPage##uname(struct page *page)		\
 	{ }
 #endif
-- 
2.31.1

